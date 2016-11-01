module Adapters
  class Learn

    BASE_URL = 'http://www.learn.co/api'

    def fetch_batch_students(batch_id)
      url = "#{BASE_URL}/v1/batches/#{batch_id}/batch_students"
      HTTParty.get(url)
    end

  end
end
