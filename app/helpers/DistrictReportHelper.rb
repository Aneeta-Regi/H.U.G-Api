module DistrictReportHelper

  def self.district_averages(report)
    # remove the final object in the array its not like the rest
    report.pop

    # second Grade
    # number of second graders
    sec_g_students = []
    trd_g_students = []
    report.each do |r|
      r[:students][0][:second_graders].each do |c|
        sec_g_students << c
      end
      r[:students][1][:third_graders].each do |c|
        trd_g_students << c
      end
    end
    # hug gain
    sec_hug_gain_divider = report.select { |s| s[:second_g_averages][:hug_gain_average] != 0 }
    sec_hug_gain_total = report.sum { |s| s[:second_g_averages][:hug_gain_average] }
    sec_hug_gain_average = sec_hug_gain_divider.size.zero? ? 0 : (sec_hug_gain_total / sec_hug_gain_divider.size).round(2)
    # mid year dra gain

    sec_dra_gain_divider = report.select { |s| s[:second_g_averages][:mid_year_dra_gain_average] != 0 }
    sec_dra_gain_total = report.sum { |s| s[:second_g_averages][:mid_year_dra_gain_average] }
    sec_dra_gain_average = sec_dra_gain_divider.size.zero? ? 0 : (sec_dra_gain_total / sec_dra_gain_divider.size).round(2)

    # end year dra gain
    sec_dra_gain_divider_end = report.select { |s| s[:second_g_averages][:end_year_dra_gain_average] != 0 }
    sec_dra_gain_total_end = report.sum { |s| s[:second_g_averages][:end_year_dra_gain_average] }
    sec_dra_gain_average_end = sec_dra_gain_divider_end.size.zero? ? 0 : (sec_dra_gain_total_end / sec_dra_gain_divider_end.size).round(2)

    # mid year rit gain
    sec_rit_gain_divider = report.select { |s| s[:second_g_averages][:mid_year_rit_gain_average] != 0 }
    sec_rit_gain_total = report.sum { |s| s[:second_g_averages][:mid_year_rit_gain_average] }
    sec_rit_gain_average = sec_rit_gain_divider.size.zero? ? 0 : (sec_rit_gain_total / sec_rit_gain_divider.size).round(2)

    # end year rit gain
    sec_rit_gain_divider_end = report.select { |s| s[:second_g_averages][:end_year_rit_gain_average] != 0 }
    sec_rit_gain_total_end = report.sum { |s| s[:second_g_averages][:end_year_rit_gain_average] }
    sec_rit_gain_average_end = sec_rit_gain_divider_end.size.zero? ? 0 : (sec_rit_gain_total_end / sec_rit_gain_divider_end.size).round(2)

    # mid year rank gain
    sec_rank_gain_divider = report.select { |s| s[:second_g_averages][:mid_year_rank_gain_average] != 0 }
    sec_rank_gain_total = report.sum { |s| s[:second_g_averages][:mid_year_rank_gain_average] }
    sec_rank_gain_average = sec_rank_gain_divider.size.zero? ? 0 : (sec_rank_gain_total / sec_rank_gain_divider.size).round(2)

    # end year rank gain
    sec_rank_gain_divider_end = report.select { |s| s[:second_g_averages][:end_year_rank_gain_average] != 0 }
    sec_rank_gain_total_end = report.sum { |s| s[:second_g_averages][:end_year_rank_gain_average] }
    sec_rank_gain_average_end = sec_rank_gain_divider_end.size.zero? ? 0 : (sec_rank_gain_total_end / sec_rank_gain_divider_end.size).round(2)

    sec_g_scores = { hug_gain: sec_hug_gain_average, mid_year_dra: sec_dra_gain_average,
                     end_year_dra: sec_dra_gain_average_end,
                     mid_year_rit: sec_rit_gain_average,
                     end_year_rit: sec_rit_gain_average_end,
                     mid_year_rank: sec_rank_gain_average,
                     end_year_rank: sec_rank_gain_average_end }

    # third grade
    # hug gain
    trd_hug_gain_divider = report.select { |s| s[:third_g_averages][:hug_gain_average] != 0 }
    trd_hug_gain_total = report.sum { |s| s[:third_g_averages][:hug_gain_average] }
    trd_hug_gain_average = trd_hug_gain_divider.size.zero? ? 0 : (trd_hug_gain_total / trd_hug_gain_divider.size).round(2)

    # mid year dra gain
    trd_dra_gain_divider = report.select { |s| s[:third_g_averages][:mid_year_dra_gain_average] != 0 }
    trd_dra_gain_total = report.sum { |s| s[:third_g_averages][:mid_year_dra_gain_average] }
    trd_dra_gain_average = trd_dra_gain_divider.size.zero? ? 0 : (trd_dra_gain_total / trd_dra_gain_divider.size).round(2)

    # end year dra gain
    trd_dra_gain_divider_end = report.select { |s| s[:third_g_averages][:end_year_dra_gain_average] != 0 }
    trd_dra_gain_total_end = report.sum { |s| s[:third_g_averages][:end_year_dra_gain_average] }
    trd_dra_gain_average_end = trd_dra_gain_divider_end.size.zero? ? 0 : (trd_dra_gain_total_end / trd_dra_gain_divider_end.size).round(2)

    # mid year rit gain
    trd_rit_gain_divider = report.select { |s| s[:third_g_averages][:mid_year_rit_gain_average] != 0 }
    trd_rit_gain_total = report.sum { |s| s[:third_g_averages][:mid_year_rit_gain_average] }
    trd_rit_gain_average = trd_rit_gain_divider.size.zero? ? 0 : (trd_rit_gain_total / trd_rit_gain_divider.size).round(2)

    # end year rit gain
    trd_rit_gain_divider_end = report.select { |s| s[:third_g_averages][:end_year_rit_gain_average] != 0 }
    trd_rit_gain_total_end = report.sum { |s| s[:third_g_averages][:end_year_rit_gain_average] }
    trd_rit_gain_average_end = trd_rit_gain_divider_end.size.zero? ? 0 : (trd_rit_gain_total_end / trd_rit_gain_divider_end.size).round(2)

    # mid year rank gain
    trd_rank_gain_divider = report.select { |s| s[:third_g_averages][:mid_year_rank_gain_average] != 0 }
    trd_rank_gain_total = report.sum { |s| s[:third_g_averages][:mid_year_rank_gain_average] }
    trd_rank_gain_average = trd_rank_gain_divider.size.zero? ? 0 : (trd_rank_gain_total / trd_rank_gain_divider.size).round(2)

    # end year rank gain
    trd_rank_gain_divider_end = report.select { |s| s[:third_g_averages][:end_year_rank_gain_average] != 0 }
    trd_rank_gain_total_end = report.sum { |s| s[:third_g_averages][:end_year_rank_gain_average] }
    trd_rank_gain_average_end = trd_rank_gain_divider_end.size.zero? ? 0 : (trd_rank_gain_total_end / trd_rank_gain_divider_end.size).round(2)

    trd_g_scores = { hug_gain: trd_hug_gain_average, mid_year_dra: trd_dra_gain_average,
                     end_year_dra: trd_dra_gain_average_end,
                     mid_year_rit: trd_rit_gain_average,
                     end_year_rit: trd_rit_gain_average_end,
                     mid_year_rank: trd_rank_gain_average,
                     end_year_rank: trd_rank_gain_average_end }

    # build a hash to return
    district_report = { num_of_schools: report.size, num_sec_graders: sec_g_students.size,
                        num_trd_graders: trd_g_students.size, sec_g_averages: sec_g_scores,
                        trd_g_averages: trd_g_scores }
    district_report
  end


end