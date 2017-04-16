module API
  class GrapeApi < Grape::API
    format :json
    get "/ping" do
      {dong: Time.now.to_i}
    end
    delete "/dong" do
      {ping:Time.now.to_i}  
    end
  end
end
