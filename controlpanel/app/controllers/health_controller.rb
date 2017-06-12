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
    
        healthCheckResult = {
          linkerd: true,
          namerd: true,
          linkerdtcp: true,
          linkerdviz: true
        }

        respond_to do |format|
            format.json  { render :json => healthCheckResult }
            format.html  { render :html => "Please curl as json curl -i -H \"accept-encoding: txt/json\" http://localhost:1234/health" }
        end
    end
end
