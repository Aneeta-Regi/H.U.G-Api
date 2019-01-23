require 'SHelper'
require 'ReportAvgHelper'
class ReportsController < ApplicationController
  include SHelper
  include ReportAvgHelper
  # before_action :authenticate_token!
  # before_action :check_permission
  # on hold for now.

  def temp_report
    params[:school_year] = '2018/2019'
    params[:school_id] = [7, 8, 9, 27, 30, 31]
    params[:download] = false
    gen_report
  end

  def district_report
    @district = District.find(params[:district_id])
    array = []
    if @district.schools.empty?
      message = { message: 'There are no schools for this district in our system.' }
      render json: message, status: :unprocessable_entity
    else
      @district.schools.each do |s|
        array << s.id
      end
      params[:school_id] = array
      @dis_report = true
      gen_report
    end
  end

  def gen_report
    # build a report object that we can pass to the report view for rendering.
    @report = []
    # generate an array of students based off of the array school ids.
    # find all the schools
    @schools = School.where(id: params[:school_id])
    # for each school create a group of students
    @schools.each do |school|
      @student_group = []
      # get every student that ever went to that school
      @students = Student.where(school_id: school.id)
      p @students
      # start sorting them by the grade year and narrow them down to only the required year for the report
      @second_grade = @students.select { |s| s.second_grade_year == params[:school_year] && s.control_group == false }
      @second_grade_control = @students.select { |s| s.second_grade_year == params[:school_year] && s.control_group == true }
      @third_grade = @students.select { |s| s.third_grade_year == params[:school_year] && s.control_group == false }
      @third_grade_control = @students.select { |s| s.third_grade_year == params[:school_year] && s.control_group == true }
      p "number of third graders is:"
      p @third_grade.size
      # fifth graders go here.
      @fifth_grade = @students.select { |s| s.fifth_grade_year == params[:school_year] && s.control_group == false }
      @fifth_grade_control = @students.select { |s| s.fifth_grade_year == params[:school_year] && s.control_group == true }
      # loop through the grades and find the dra records and then build the object
      # ********************************************************
      # second graders go here
      second_graders = []
      @second_grade.each do |student|
        # go get the averages
        set_acumen(student)
        # get the scores record
        dra_record = DraRecord.where(student_id: student.id, grade: '2nd')
        # unless the dra record is nil send the record off to the helper to set all the scores and return an object
        dra_record[0].nil? ? zero_out_scores : @student_record = SHelper.set_scores(dra_record[0])
        # there will be no last year gains for second graders but we need to leave a place holder.
        @last_year_dra_gains = ''
        # build the hash
        second_graders << hash_builder(student)
      end
      @student_group << { second_graders: second_graders }
      # send second graders off to the class averages
      second_g_averages = ReportAvgHelper.class_averages(second_graders)
      # ********************************************************
      # second grade control group averages
      if @second_grade_control.empty?
        # then skip this shit and set the control averages to an empty object
        second_g_control_averages = {}
      else
        # do some stuff
        second_g_control = []
        @second_grade_control.each do |student|
          # go get the averages
          set_acumen(student)

          # get the scores record
          dra_record = DraRecord.where(student_id: student.id, grade: '2nd')

          # unless the dra record is nil send the record off to the helper to set all the scores and return an object
          dra_record[0].nil? ? zero_out_scores : @student_record = SHelper.set_scores(dra_record[0])

          # there will be no last year gains for second graders but we need to leave a place holder.
          @last_year_dra_gains = ''
          # build the hash
          second_g_control << hash_builder(student)
        end
        # send second grade control group
        second_g_control_averages = ReportAvgHelper.class_averages(second_g_control)
      end
      # ********************************************************
      # third graders go here
      third_graders = []
      @third_grade.each do |student|
        set_acumen(student)

        dra_record = DraRecord.where(student_id: student.id, grade: '3rd')

        # unless the dra record is nil send the record off to the helper to set all the scores and return an object
        dra_record[0].nil? ? zero_out_scores : @student_record = SHelper.set_scores(dra_record[0])

        @last_year_dra_gains = set_last_year_dra_gains(student)
        third_graders << hash_builder(student)
      end
      @student_group << { third_graders: third_graders }
      # send third graders off to the class averages
      third_g_averages =  ReportAvgHelper.class_averages(third_graders)
      # ********************************************************
      # third grade control group averages
      if @third_grade_control.empty?
        # then skip this shit and set the control averages to an empty object
        third_g_control_averages = {}
      else
        # do some stuff
        third_g_control = []
        @third_grade_control.each do |student|
          # go get the averages
          set_acumen(student)

          # get the scores record
          dra_record = DraRecord.where(student_id: student.id, grade: '3rd')

          # unless the dra record is nil send the record off to the helper to set all the scores and return an object
          dra_record[0].nil? ? zero_out_scores : @student_record = SHelper.set_scores(dra_record[0])
          # there will be no last year gains for control students but we need to leave a place holder.
          @last_year_dra_gains = ''
          # build the hash
          third_g_control << hash_builder(student)
        end
        # send second grade control group
        third_g_control_averages = ReportAvgHelper.class_averages(third_g_control)
      end
      # ********************************************************
      # fifth graders go here
      fifth_graders = []
      @fifth_grade.each do |student|
        set_acumen(student)

        dra_record = DraRecord.where(student_id: student.id, grade: '5th')

        # unless the dra record is nil send the record off to the helper to set all the scores and return an object
        dra_record[0].nil? ? zero_out_scores : @student_record = SHelper.set_scores(dra_record[0])

        @last_year_dra_gains = set_third_year_dra_gains(student)
        fifth_graders << hash_builder(student)
      end
      @student_group << { fifth_graders: fifth_graders }
      # send third graders off to the class averages
      fifth_g_averages =  ReportAvgHelper.fifth_averages(fifth_graders)
      # ********************************************************
      # fifth grade control group averages
      if @fifth_grade_control.empty?
        # then skip this shit and set the control averages to an empty object
        fifth_g_control_averages = {}
      else
        # do some stuff
        fifth_g_control = []
        @fifth_grade_control.each do |student|
          # go get the averages
          set_acumen(student)

          # get the scores record
          dra_record = DraRecord.where(student_id: student.id, grade: '5th')

          # unless the dra record is nil send the record off to the helper to set all the scores and return an object
          dra_record[0].nil? ? zero_out_scores : @student_record = SHelper.set_scores(dra_record[0])
          # there will be no last year gains for control students but we need to leave a place holder.
          @last_year_dra_gains = ''
          # build the hash
          fifth_g_control << hash_builder(student)
        end
        # send second grade control group
        fifth_g_control_averages = ReportAvgHelper.fifth_averages(fifth_g_control)
      end
      # ********************************************************
      # put the info into the report object for delivery.
      @report << { school_name: school.school_name, district: school.school_district,
                   state: school.school_state, second_g_averages: second_g_averages,
                   second_g_control_averages: second_g_control_averages,
                   third_g_averages: third_g_averages,
                   third_g_control_averages: third_g_control_averages,
                   fifth_g_averages: fifth_g_averages, fifth_g_control_averages: fifth_g_control_averages,
                   students: @student_group }
    end

    # Add on a report detail object at the end to pass along info not contained in a school.
    @report << { created_by: 'Alex Hughes', report_date: params[:school_year],
                 number_of_schools: params[:school_id].size.to_s, district: @schools[0].school_district }
    # we will use a boolean param to determine if we are rendering to the web or an excel download.
    #
    if params[:download]
      day = DateTime.now.to_date
      filename = 'Master_Report_of_' + day.to_s
      render xlsx: @report, template: 'reports/gen_report.xlsx.axlsx', filename: filename
    elsif @dis_report
      @district_report = DistrictReportHelper.district_averages(@report)
      render json: @district_report
    else
      render json: @report
    end
  end

  # lets build the student hash
  def hash_builder(student)
    student_hash = { id: student.id, name: student.first_name + ' ' + student.s_last_name,
                     other_interventions: student.num_other_programs,
                     tutor: student.vol_name, first_attempt_average: @acumen_one,
                     second_attempt_average: @acumen_two,
                     hug_gain: (@acumen_two - @acumen_one).round(2),
                     last_year_dra_gains: @last_year_dra_gains,
                     fall_dra: @student_record[:fall_dra], winter_dra: @student_record[:winter_dra],
                     mid_year_dra_gain: @student_record[:mid_year_dra_gain],
                     spring_dra: @student_record[:spring_dra], end_year_dra_gain: @student_record[:end_year_dra_gain],
                     fall_rit: @student_record[:fall_rit], winter_rit: @student_record[:winter_rit],
                     mid_year_rit_gain: @student_record[:mid_year_rit_gain],
                     spring_rit: @student_record[:spring_rit], end_year_rit_gain: @student_record[:end_year_rit_gain],
                     fall_rank: @student_record[:fall_rank], winter_rank: @student_record[:winter_rank],
                     mid_year_rank_gain: @student_record[:mid_year_rank_gain],
                     spring_rank: @student_record[:spring_rank], end_year_rank_gain: @student_record[:end_year_rank_gain],
                     fall_lexile: @student_record[:fall_lexile], winter_lexile: @student_record[:winter_lexile],
                     spring_lexile: @student_record[:spring_lexile] }
    student_hash
  end

  # calculate the acumen in a percentage or 0 if record nil.
  def set_acumen(student)
    student.average.nil? ? @acumen_one = 0 : @acumen_one = (100 - student.average.acumen_one).round(2)
    student.average.nil? ? @acumen_two = 0 : @acumen_two = (100 - student.average.acumen_two).round(2)
  end


  # if there is no dra record for this student we need to zero the scores and keep going.
  def zero_out_scores
    @student_record = { fall_dra: 0, winter_dra: 0, mid_year_dra_gain: 0,
                        spring_dra: 0, end_year_dra_gain: 0, fall_rit: 0,
                        winter_rit: 0, mid_year_rit_gain: 0, spring_rit: 0,
                        end_year_rit_gain: 0, fall_rank: 0, winter_rank: 0,
                        mid_year_rank_gain: 0, spring_rank: 0, end_year_rank_gain: 0,
                        fall_lexile: '', winter_lexile: '', spring_lexile: '' }
  end

  def set_last_year_dra_gains(student)
    dra_record_second = DraRecord.where(student_id: student.id, grade: '2nd')
    unless dra_record_second[0].nil?
      if dra_record_second[0].fall_dra.nil? || dra_record_second[0].winter_dra.nil?
        sem_improvement_second = 0
      else
        sem_improvement_second = dra_record_second[0].winter_dra - dra_record_second[0].fall_dra
      end
      if dra_record_second[0].fall_dra.nil? || dra_record_second[0].spring_dra.nil?
        end_improvement_second = 0
      else
        end_improvement_second = dra_record_second[0].spring_dra - dra_record_second[0].fall_dra
      end
    end
    dra_record_second[0].nil? ? last_years_dra_gains = '' : last_years_dra_gains = 'Mid ' + sem_improvement_second.to_s + ' / ' + 'End ' + end_improvement_second.to_s
    last_years_dra_gains
  end

  def set_third_year_dra_gains(student)
    dra_record_second = DraRecord.where(student_id: student.id, grade: '3nd')
    unless dra_record_second[0].nil?
      if dra_record_second[0].fall_dra.nil? || dra_record_second[0].winter_dra.nil?
        sem_improvement_second = 0
      else
        sem_improvement_second = dra_record_second[0].winter_dra - dra_record_second[0].fall_dra
      end
      if dra_record_second[0].fall_dra.nil? || dra_record_second[0].spring_dra.nil?
        end_improvement_second = 0
      else
        end_improvement_second = dra_record_second[0].spring_dra - dra_record_second[0].fall_dra
      end
    end
    dra_record_second[0].nil? ? last_years_dra_gains = '' : last_years_dra_gains = 'Mid ' + sem_improvement_second.to_s + ' / ' + 'End ' + end_improvement_second.to_s
    last_years_dra_gains
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:school_year, :download, :district_id, :school_id => [])
  end
end
