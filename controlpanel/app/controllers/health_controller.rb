class HealthController < ApplicationController
    include HealthHelper

    def index
       # healthService method is available in helpers/health_helper
        checks = {
            linkerd: "http://localhost:9990/admin/ping",
            namerd: "http://localhost:9991/admin/ping",
            linkerdtcp: "http://localhost:9992/metrics",
            linkerdviz: "http://localhost:3000",
        }

        mutex = Mutex.new        
        healthCheckResult = {}

        threads = []
        for check in checks.keys()
            threads << Thread.new(check) do |check|
                health_check_url = checks[check]
                status = healthService.healthCheck(url=health_check_url)
                mutex.synchronize {
                    healthCheckResult[check] = status    
                    Thread.exit
                }
            end
        end
        
        for thread in threads
            thread.join
        end

        respond_to do |format|
            format.json  { render :json => healthCheckResult }
            format.html  { render :html => "Please curl as json curl -i -H \"accept-encoding: txt/json\" http://localhost:1234/health" }
        end
    end
end
