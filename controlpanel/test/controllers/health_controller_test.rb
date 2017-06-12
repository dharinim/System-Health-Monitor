require 'test_helper'

class HealthControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

 test "linkerdviz is down" do
    stub_request(:get, "http://localhost:9990/admin/ping").
      to_return(status: 200, body: "", headers: {})

    stub_request(:get, "http://localhost:9991/admin/ping").
      to_return(status: 200, body: "", headers: {})

    stub_request(:get, "http://localhost:9992/metrics").
      to_return(status: 200, body: "", headers: {})

    stub_request(:any, 'http://localhost:3000/').to_timeout

    get '/health', as: :json

    expectedResponse = {
        "linkerdtcp"=>true,
        "namerd"=>true,
        "linkerd"=>true,
        "linkerdviz"=>false
    }

    assert_equal expectedResponse, JSON.parse(response.body)
  end

  test "everything is up and running" do
    stub_request(:get, "http://localhost:9990/admin/ping").
      to_return(status: 200, body: "", headers: {})

    stub_request(:get, "http://localhost:9991/admin/ping").
      to_return(status: 200, body: "", headers: {})

    stub_request(:get, "http://localhost:9992/metrics").
      to_return(status: 200, body: "", headers: {})

    stub_request(:get, "http://localhost:3000/").
      to_return(status: 200, body: "", headers: {})

    get '/health', as: :json

    expectedResponse = {
        "linkerdtcp"=>true,
        "namerd"=>true,
        "linkerd"=>true,
        "linkerdviz"=>true
    }

    assert_equal expectedResponse, JSON.parse(response.body)
  end
end


