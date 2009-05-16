module HttpServer
  class ThreadPool
    include HttpServer::ServerMethods

    def initialize(router, num_threads = 20)
      @num_threads = num_threads
      @available = ThreadGroup.new
      @thread_available = ConditionVariable.new
      @thread_mutex = Mutex.new
      @router = router

      num_threads.times do
        @available.add(Thread.new(&thread_block))
      end
    end

    def run_request(socket)
      thread = nil
      while thread.nil?
        @thread_mutex.synchronize do
          thread = get_thread
          @thread_available.wait(@thread_mutex) if thread.nil?
        end
      end
      thread[:socket] = socket
      thread[:router] = @router
      thread.run
    end

    def available_threads
      @available.list.size
    end

    private
    def get_thread
      @available.list.select { |t| t.stop? }.first
    end

    def thread_block
      lambda {
        while true
          if Thread.current[:socket].nil?
            Thread.stop
          end
          
          socket = Thread.current[:socket]
          raw = read_http(socket)
          request = HttpServer::Request.new(raw)
          response = Thread.current[:router].handle_request(request)
          socket.puts(response.raw_http)
          socket.close if socket.respond_to?(:close)
          
          # Reset this to available
          @thread_available.signal
          Thread.stop
        end
      }
    end
  end
end
