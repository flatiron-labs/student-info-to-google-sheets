class FakeLearn < FakeApi

  get '/api/v1/batches/:batch_id/batch_students' do
    json_response 200, 'batch_students.json'
  end

end
