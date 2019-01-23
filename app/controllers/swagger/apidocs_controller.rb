class Swagger::ApidocsController < Swagger::BaseController
  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'HUG Api docs'
      key :description, 'HUG Swagger api docs'
    end
    security_definition :Authorization, type: :apiKey do
      key :name, :Authorization
      key :in, :header
    end
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end
  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    Swagger::AuthenticationController,
    Swagger::Absence,
    Swagger::AbsencesController,
    Swagger::AppLink,
    Swagger::AppLinksController,
    Swagger::District,
    Swagger::DistrictsController,
    Swagger::DraRecord,
    Swagger::DraRecordsController,
    Swagger::Lesson,
    Swagger::LessonsController,
    Swagger::PasswordsController,
    Swagger::ReportParam,
    Swagger::ReportsController,
    Swagger::TutorReportParam,
    Swagger::TutorReportController,
    Swagger::School,
    Swagger::SchoolsController,
    Swagger::Session,
    Swagger::SessionsController,
    Swagger::Student,
    Swagger::StudentsController,
    Swagger::User,
    Swagger::UsersController,
    self
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
