class DraRecordSerializer < ActiveModel::Serializer
  attributes :id, :grade, :school_year, :fall_dra, :winter_dra, :mid_year_dra_gain, :spring_dra, :end_of_year_dra_gain,
             :fall_rit, :winter_rit, :mid_year_rit_gain, :spring_rit, :end_of_year_rit_gain,
             :student_id, :fall_lexile, :winter_lexile, :spring_lexile,
             :fall_rank, :winter_rank, :mid_year_rank_gain, :spring_rank, :end_year_rank_gain,
             :fall_lexile_one, :fall_lexile_two, :winter_lexile_one,
             :winter_lexile_two, :spring_lexile_one, :spring_lexile_two
end


