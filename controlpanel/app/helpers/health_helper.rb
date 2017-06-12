module HealthHelper
    @@hs = HealthService.new()

    def healthService
        return @@hs
    end
end
