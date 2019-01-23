class Swagger::ReportsController < Swagger::ApidocsController
  swagger_path '/run_report' do
    operation :post do
      key :summary, 'Create report'
      key :description, 'Create report'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Reports']
      security Authorization: []
      parameter do
        key :name,:report_param
        key :in, :body
        key :description, "report parameter json"
        key :required, true
        schema do
          key :'$ref',:report_param
        end
      end
    end
  end

end
