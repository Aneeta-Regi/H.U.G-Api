class StudentSerializerReport < ActiveModel::Serializer


  attributes :id, :name, :grade, :second_grade, :third_grade, :fifth_grade, :acumen


  def name
    name = object.first_name + ' ' + object.s_last_name
    name
  end

  def second_grade
    r = DraRecord.where(student_id: object[:id], grade: '2nd')
    if r.empty?
      second_grade = {}
    else
      # set mid year scores
      mid_y_dra =  r[0].winter_dra.nil? || r[0].winter_dra.zero? ? 0 : (r[0].winter_dra - r[0].fall_dra).round(2)
      mid_y_rit =  r[0].winter_rit.nil? || r[0].winter_rit.zero? ? 0 : (r[0].winter_rit - r[0].fall_rit).round(2)
      mid_y_rank = r[0].winter_rank.nil? || r[0].winter_rank.zero? ? 0 : (r[0].winter_rank - r[0].fall_rank).round(2)

      # set end year scores
      end_y_dra = r[0].spring_dra.nil?  || r[0].spring_dra.zero? ? 0 : (r[0].spring_dra - r[0].fall_dra).round(2)
      end_y_rit =  r[0].spring_rit.nil? || r[0].spring_rit.zero? ? 0 : (r[0].spring_rit - r[0].fall_rit).round(2)
      end_y_rank = r[0].spring_rank.nil? || r[0].spring_rank.zero? ? 0 : (r[0].spring_rank - r[0].fall_rank).round(2)

      second_grade = { school_year: r[0].school_year,
                       dra: { fall: r[0].fall_dra, winter: r[0].winter_dra, spring: r[0].spring_dra,
                              mid_year_gain: mid_y_dra,
                              end_year_gain: end_y_dra },
                       rit: { fall: r[0].fall_rit, winter: r[0].winter_rit, spring: r[0].spring_rit,
                              mid_year_gain: mid_y_rit ,
                              end_year_gain: end_y_rit },
                       rank: { fall: r[0].fall_rank, winter: r[0].winter_rank, spring: r[0].spring_rank,
                               mid_year_gain: mid_y_rank,
                               end_year_gain: end_y_rank },
                       lexile: { fall_one: r[0].fall_lexile_one, fall_two: r[0].fall_lexile_two,
                                 winter_one: r[0].winter_lexile_one, winter_two: r[0].winter_lexile_two,
                                 spring_one: r[0].spring_lexile_one, spring_two: r[0].spring_lexile_two } }
    end
    second_grade
  end

  def third_grade
    r = DraRecord.where(student_id: object[:id], grade: '3rd')
    if r.empty?
      third_grade = {}
    else

      # set mid year scores
      mid_y_dra =  r[0].winter_dra.nil? || r[0].winter_dra.zero? ? 0 : (r[0].winter_dra - r[0].fall_dra).round(2)
      mid_y_rit =  r[0].winter_rit.nil? || r[0].winter_rit.zero? ? 0 : (r[0].winter_rit - r[0].fall_rit).round(2)
      mid_y_rank = r[0].winter_rank.nil? || r[0].winter_rank.zero? ? 0 : (r[0].winter_rank - r[0].fall_rank).round(2)

      # set end year scores
      end_y_dra = r[0].spring_dra.nil?  || r[0].spring_dra.zero? ? 0 : (r[0].spring_dra - r[0].fall_dra).round(2)
      end_y_rit =  r[0].spring_rit.nil? || r[0].spring_rit.zero? ? 0 : (r[0].spring_rit - r[0].fall_rit).round(2)
      end_y_rank = r[0].spring_rank.nil? || r[0].spring_rank.zero? ? 0 : (r[0].spring_rank - r[0].fall_rank).round(2)

      third_grade = { school_year: r[0].school_year,
                      dra: { fall: r[0].fall_dra, winter: r[0].winter_dra, spring: r[0].spring_dra,
                             mid_year_gain: mid_y_dra,
                             end_year_gain: end_y_dra },
                      rit: { fall: r[0].fall_rit, winter: r[0].winter_rit, spring: r[0].spring_rit,
                             mid_year_gain: mid_y_rit ,
                             end_year_gain: end_y_rit },
                      rank: { fall: r[0].fall_rank, winter: r[0].winter_rank, spring: r[0].spring_rank,
                              mid_year_gain: mid_y_rank,
                              end_year_gain: end_y_rank },
                      lexile: { fall_one: r[0].fall_lexile_one, fall_two: r[0].fall_lexile_two,
                                winter_one: r[0].winter_lexile_one, winter_two: r[0].winter_lexile_two,
                                spring_one: r[0].spring_lexile_one, spring_two: r[0].spring_lexile_two } }
    end
    third_grade
  end

  def fifth_grade
    r = DraRecord.where(student_id: object[:id], grade: '5th')
    if r.empty?
      fifth_grade = {}
    else

      # set mid year scores
      mid_y_dra =  r[0].winter_dra.nil? || r[0].winter_dra.zero? ? 0 : (r[0].winter_dra - r[0].fall_dra).round(2)
      mid_y_rit =  r[0].winter_rit.nil? || r[0].winter_rit.zero? ? 0 : (r[0].winter_rit - r[0].fall_rit).round(2)
      mid_y_rank = r[0].winter_rank.nil? || r[0].winter_rank.zero? ? 0 : (r[0].winter_rank - r[0].fall_rank).round(2)

      # set end year scores
      end_y_dra = r[0].spring_dra.nil?  || r[0].spring_dra.zero? ? 0 : (r[0].spring_dra - r[0].fall_dra).round(2)
      end_y_rit =  r[0].spring_rit.nil? || r[0].spring_rit.zero? ? 0 : (r[0].spring_rit - r[0].fall_rit).round(2)
      end_y_rank = r[0].spring_rank.nil? || r[0].spring_rank.zero? ? 0 : (r[0].spring_rank - r[0].fall_rank).round(2)

      fifth_grade = { school_year: r[0].school_year,
                      dra: { fall: r[0].fall_dra, winter: r[0].winter_dra, spring: r[0].spring_dra,
                             mid_year_gain: mid_y_dra,
                             end_year_gain: end_y_dra },
                      rit: { fall: r[0].fall_rit, winter: r[0].winter_rit, spring: r[0].spring_rit,
                             mid_year_gain: mid_y_rit ,
                             end_year_gain: end_y_rit },
                      rank: { fall: r[0].fall_rank, winter: r[0].winter_rank, spring: r[0].spring_rank,
                              mid_year_gain: mid_y_rank,
                              end_year_gain: end_y_rank },
                      lexile: { fall_one: r[0].fall_lexile_one, fall_two: r[0].fall_lexile_two,
                                winter_one: r[0].winter_lexile_one, winter_two: r[0].winter_lexile_two,
                                spring_one: r[0].spring_lexile_one, spring_two: r[0].spring_lexile_two } }
    end
    fifth_grade
  end

  def acumen
    averages = object.average
    if averages.nil?
      acumen = { average_first_attempt: 0, average_second_attempt: 0 }
    else
      acumen = { average_first_attempt: (100 - averages.acumen_one).round(1), average_second_attempt: (100 - averages.acumen_two).round(1) }
    end
    acumen
  end

end
