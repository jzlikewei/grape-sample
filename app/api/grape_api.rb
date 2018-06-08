module API
  class GrapeApi < Grape::API
    format :json

    desc "ping"
    params do
      requires :test_id, type: String, desc: 'desv', default: 'asdfas', values: ['asdfas']
    end
    get '/ping/:room_id' do
      { dong: Time.now.to_i }
    end

    desc "ping"
    delete '/dong' do
      { ping: Time.now.to_i }
    end
  end
end
