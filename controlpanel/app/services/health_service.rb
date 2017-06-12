class HealthService
    def healthCheck(url="http://localhost:3000/")        
        request_options = {
            :timeout => 5,
            :open_timeout => 5,
            :read_timeout => 10,
        }

        begin
            res = HTTParty.get(url, request_options)
        rescue Timeout::Error,
                Errno::EINVAL,
                Errno::ECONNRESET,
                Errno::ECONNREFUSED,
                EOFError,
                Net::HTTPBadResponse,
                Net::HTTPHeaderSyntaxError,
                Net::ProtocolError => e
                return false
        rescue => e
            return false
        end

        if res.code == 200
            return true
        else
            return false
        end
    end
end
