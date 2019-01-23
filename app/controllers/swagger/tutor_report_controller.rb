class Swagger::TutorReportController < Swagger::ApidocsController
  swagger_path '/tutor_report/{school_id}' do
    parameter do
      key :name, :school_id
      key :in, :path
      key :description, 'HUG system ID of the school to run a tutor report on. When requesting a report on all schools use 0.'
      key :required, true
    end
    operation :get do
      key :summary, 'Tutor Report'
      key :description, 'Generates a report on all tutors at the requested school id. The response will include active and inactive tutors.'
      key :produces, ['application/json']
      key :tags,['Tutor Report']
      security Authorization: []
    end
  end
end