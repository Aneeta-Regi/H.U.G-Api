
  module SHelper
    def self.set_scores(record)
      # dra scores
      record.fall_dra.nil? ? fall_dra = 0 : fall_dra = record.fall_dra
      record.winter_dra.nil? ? winter_dra = 0 : winter_dra = record.winter_dra
      if winter_dra.zero?
        mid_year_dra_gain = 0
      else
        record.mid_year_dra_gain.nil? ? mid_year_dra_gain = winter_dra - fall_dra : mid_year_dra_gain = record.mid_year_dra_gain
      end
      record.spring_dra.nil? ? spring_dra = 0 : spring_dra = record.spring_dra
      if spring_dra.zero?
        end_year_dra_gain = 0
      else
        record.end_of_year_dra_gain.nil? ? end_year_dra_gain = spring_dra - fall_dra : end_year_dra_gain = record.end_of_year_dra_gain
      end

      # rit scores
      record.fall_rit.nil? ? fall_rit = 0 : fall_rit = record.fall_rit
      record.winter_rit.nil? ? winter_rit = 0 : winter_rit = record.winter_rit
      if winter_rit.zero?
        mid_year_rit_gain = 0
      else
        record.mid_year_rit_gain.nil? ? mid_year_rit_gain = winter_rit - fall_rit : mid_year_rit_gain = record.mid_year_rit_gain
      end
      record.spring_rit.nil? ? spring_rit = 0 : spring_rit = record.spring_rit
      if spring_rit.zero?
        end_year_rit_gain = 0
      else
        record.end_of_year_rit_gain.nil? ? end_year_rit_gain = spring_rit - fall_rit : end_year_rit_gain = record.end_of_year_rit_gain
      end

      # rank scores
      record.fall_rank.nil? ? fall_rank = 0 : fall_rank = record.fall_rank
      record.winter_rank.nil? ? winter_rank = 0 : winter_rank = record.winter_rank
      if winter_rank.zero?
        mid_year_rank_gain = 0
      else
        record.mid_year_rank_gain.nil? ? mid_year_rank_gain = winter_rank - fall_rank : mid_year_rank_gain = record.mid_year_rank_gain
      end
      record.spring_rank.nil? ? spring_rank = 0 : spring_rank = record.spring_rank
      if spring_rank.zero?
        end_year_rank_gain = 0
      else
        record.end_year_rank_gain.nil? ? end_year_rank_gain = spring_rank - fall_rank : end_year_rank_gain = record.end_year_rank_gain
      end

      # lexile scores
      record.fall_lexile.nil? ? fall_lexile = '' : fall_lexile = record.fall_lexile
      record.winter_lexile.nil? ? winter_lexile = '' : winter_lexile = record.winter_lexile
      record.spring_lexile.nil? ? spring_lexile = '' : spring_lexile = record.spring_lexile

      # build the hash to return
      @student_record = { fall_dra: fall_dra, winter_dra: winter_dra, mid_year_dra_gain: mid_year_dra_gain,
                          spring_dra: spring_dra, end_year_dra_gain: end_year_dra_gain,
                          fall_rit: fall_rit, winter_rit: winter_rit, mid_year_rit_gain: mid_year_rit_gain, spring_rit: spring_rit,
                          end_year_rit_gain: end_year_rit_gain, fall_rank: fall_rank, winter_rank: winter_rank,
                          mid_year_rank_gain: mid_year_rank_gain, spring_rank: spring_rank, end_year_rank_gain: end_year_rank_gain,
                          fall_lexile: fall_lexile, winter_lexile: winter_lexile, spring_lexile: spring_lexile }
    end
    @student_record

    # create a lexile gain calculator here.
end