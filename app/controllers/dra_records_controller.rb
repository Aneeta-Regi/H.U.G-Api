class DraRecordsController < ApplicationController
  before_action :set_dra_record, only: [:show, :update, :destroy]
  before_action :authenticate_token!

  # GET /dra_records
  def index
    @dra_records = DraRecord.all
    render json: @dra_records
  end

  # GET /dra_records/1
  def show
    render json: @dra_record
  end

  # POST /dra_records
  def create
    @dra_record = DraRecord.new(dra_record_params)
    # look for empties and nulls then set to zero
    @dra_record.check_values
    # set the gains for DRA & RIT
    set_gains
    if @dra_record.save
      render json: @dra_record, status: :created, location: @dra_record
    else
      render json: @dra_record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dra_records/1
  def update
    @dra_record.update(dra_record_params)
    # look for empties and nulls then set to zero
    @dra_record.check_values
    # set the gains for DRA & RIT
    set_gains
    if @dra_record.save
      render json: @dra_record, status: :created, location: @dra_record
    else
      render json: @dra_record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dra_records/1
  def destroy
    @dra_record.destroy
  end

  # import of dra records using Roo gem

  def import_record
    @failed = []
    @success = []
    file = params[:file]
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (3..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    if row['grade'] == '2nd' || row['grade'] == '3rd' || row['grade'] == '5th'
      #do the work
      # adding check for no year
      if row['school year'] == ' '
        @failed << { name: row['name'], message: 'School year is empty.' }
      else
        # split the name into first and last
        first = row['name'].partition(' ').first.strip
        last = row['name'].partition(' ').last.strip
        # find the student
        student = Student.where(first_name: first, s_last_name: last, school_id: params[:school_id])
        # guard against the student not found.
        # set the student row into the the failed hash
        if student.empty?
          @failed << { name: row['name'], message: 'Student not found.' }
        else
          dra_records = DraRecord.where(student_id: student[0].id, school_year: row['school year'])
          @dra_record = dra_records[0]
          # if no record the make a new one
          if dra_records.empty?
            @dra_record = DraRecord.new(student_id: student[0].id,
                                        school_year: row['school year'], grade: row['grade'])
          end
          import_set_values(row)
          @dra_record.check_values
          set_gains
          @dra_record.save
          @success << { name: row['name'] }
        end
      end
    else
      @failed << { name: row['name'], message: 'Grade value is not correct.' }
    end
    end
    @message = { number_successful: @success, failed: @failed }
    render json: @message
  end

  def import_set_values(row)
    row['fall dra'].nil? ? @dra_record.fall_dra : @dra_record.fall_dra = row['fall dra']
    row['winter dra'].nil? ? @dra_record.winter_dra : @dra_record.winter_dra = row['winter dra']
    row['spring dra'].nil? ? @dra_record.spring_dra : @dra_record.spring_dra = row['spring dra']
    row['fall rit'].nil? ? @dra_record.fall_rit : @dra_record.fall_rit = row['fall rit']
    row['winter rit'].nil? ? @dra_record.winter_rit : @dra_record.winter_rit = row['winter rit']
    row['spring rit'].nil? ? @dra_record.spring_rit : @dra_record.spring_rit = row['spring rit']
    row['fall rank'].nil? ? @dra_record.fall_rank : @dra_record.fall_rank = row['fall rank']
    row['winter rank'].nil? ? @dra_record.winter_rank : @dra_record.winter_rank = row['winter rank']
    row['spring rank'].nil? ? @dra_record.spring_rank : @dra_record.spring_rank = row['spring rank']
    row['fall lexile'].nil? ? @dra_record.fall_lexile : @dra_record.fall_lexile = row['fall lexile']
    row['winter lexile'].nil? ? @dra_record.winter_lexile : @dra_record.winter_lexile = row['winter lexile']
    row['spring lexile'].nil? ? @dra_record.spring_lexile : @dra_record.spring_lexile = row['spring lexile']
  end

  # used to set the mid and end year gains on scores by create, update and import methods
  def set_gains
    @dra_record.set_mid_year_dra
    @dra_record.set_end_year_dra
    @dra_record.set_mid_year_rit
    @dra_record.set_end_year_rit
    @dra_record.set_mid_year_rank
    @dra_record.set_end_year_rank
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_dra_record
      @dra_record = DraRecord.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dra_record_params
      params.require(:dra_record).permit(:grade, :school_year, :fall_dra, :winter_dra, :spring_dra, :mid_year_dra_gain, :end_of_year_dra_gain,
                                         :fall_rit, :winter_rit, :mid_year_rit_gain, :spring_rit, :end_of_year_rit_gain,
                                         :fall_lexile, :winter_lexile, :spring_lexile,
                                         :fall_rank, :winter_rank, :mid_year_rank_gain, :spring_rank, :end_year_rank_gain,
                                         :fall_lexile_one, :fall_lexile_two, :winter_lexile_one,
                                         :winter_lexile_two, :spring_lexile_one, :spring_lexile_two,
                                         :student_id, :file, :school_id)
    end
end
