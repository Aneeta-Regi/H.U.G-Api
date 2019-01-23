class Swagger::FeedbacksController < Swagger::BaseController
  swagger_path '/feedbacks' do
    operation :post do
      key :summary, 'Create feedback'
      key :description, 'The volunteer name and id are set in the backend at creation'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Feedbacks']
      security Authorization: []
      parameter do
        key :name, :feedback
        key :in, :body
        key :description, "Feedback json"
        key :required, true
        schema do
          key :'$ref',:feedback
        end
      end
    end
    operation :get do
      key :summary, 'List all Feedbacks'
      key :description, 'List all Feedbacks'
      key :produces, ['application/json']
      key :tags,['Feedbacks']
      security Authorization: []
    end
  end

  swagger_path '/feedbacks/{id}' do
    parameter do
      key :name, :id
      key :in, :path
      key :description, "Feedback id"
      key :required, true
    end
    operation :get do
      key :summary, 'Show Feedback'
      key :description, 'Show Feedback'
      key :produces, ['application/json']
      key :tags,['Feedbacks']
      security Authorization: []
    end
    operation :put do
      key :summary, 'Update Feedback'
      key :description, 'Update Feedback'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Feedbacks']
      parameter do
        key :name, :feedback
        key :in, :body
        key :description, "AppLink json"
        key :required, true
        schema do
          key :'$ref',:feedback
        end
      end
    end
    operation :delete do
      key :summary, 'delete Feedback'
      key :description, 'delete Feedback'
      key :produces, ['application/json']
      key :tags,['Feedbacks']
      security Authorization: []
    end
  end

end
