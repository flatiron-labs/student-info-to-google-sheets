require 'sinatra/base'


class FakeApi < Sinatra::Base


  private

  def json_response(status_code, file_name)
    content_type :json
    status status_code
    File.read("spec/fixtures/#{file_name}")
  end

end
