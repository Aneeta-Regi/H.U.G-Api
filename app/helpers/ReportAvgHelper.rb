
 module ReportAvgHelper

# build an averages hash to pass to the school.
# we need to account for any students who have a zero score and remove them from the average calculations
# by creating an array that excludes any student who has a zero the respective score we can use that size
# of that array as a divider for the average.

   def self.class_averages(student_class)
     # hug first attempt
     hug_one_divider = student_class.select { |s| s[:first_attempt_average] > 0 }
     hug_one_total = hug_one_divider.sum { |s| s[:first_attempt_average] }
     hug_one_divider.size.zero? ? hug_one_average = 0 : hug_one_average = (hug_one_total / hug_one_divider.size).round(2)
     # hug second attempt
     hug_two_divider = student_class.select { |s| s[:second_attempt_average] > 0 }
     hug_two_total = hug_two_divider.sum { |s| s[:second_attempt_average] }
     hug_two_divider.size.zero? ? hug_two_average = 0 : hug_two_average = (hug_two_total / hug_two_divider.size).round(2)
     # hug gain
     hug_gain_divider = student_class.select { |s| s[:hug_gain] > 0 }
     hug_gain_total = hug_gain_divider.sum { |s| s[:hug_gain] }
     hug_gain_divider.size.zero? ? hug_gain_average = 0 : hug_gain_average = (hug_gain_total / hug_gain_divider.size).round(2)
     # fall dra
     fall_dra_divider = student_class.select { |s| s[:fall_dra] > 0 }
     fall_dra_total = fall_dra_divider.sum { |s| s[:fall_dra] }
     fall_dra_divider.size.zero? ? fall_dra_average = 0 : fall_dra_average = (fall_dra_total / fall_dra_divider.size).round(2)
     # winter dra
     winter_dra_divider = student_class.select { |s| s[:winter_dra] > 0 }
     winter_dra_total = winter_dra_divider.sum { |s| s[:winter_dra] }
     winter_dra_divider.size.zero? ? winter_dra_average = 0 : winter_dra_average = (winter_dra_total / winter_dra_divider.size).round(2)
     # mid year dra gain
     # mid_year_divider = student_class.select { |s| s[:mid_year_dra_gain] > 0 }
     # mid_year_total = mid_year_divider.sum { |s| s[:mid_year_dra_gain] }
     # mid_year_divider.size.zero? ? mid_dra_average = 0 : mid_dra_average = (mid_year_total / mid_year_divider.size).round(2)
     mid_dra_average = winter_dra_divider.size.zero? ? 0 : winter_dra_average - fall_dra_average
     # spring dra
     spring_dra_divider = student_class.select { |s| s[:spring_dra] > 0 }
     spring_dra_total = spring_dra_divider.sum { |s| s[:spring_dra] }
     spring_dra_divider.size.zero? ? spring_dra_average = 0 : spring_dra_average = (spring_dra_total / spring_dra_divider.size).round(2)
     # end year dra gain
     # end_year_divider = student_class.select { |s| s[:end_year_dra_gain] > 0 }
     # end_year_total = end_year_divider.sum { |s| s[:end_year_dra_gain] }
     # end_year_divider.size.zero? ? end_dra_average = 0 : end_dra_average = (end_year_total / end_year_divider.size).round(2)
     end_dra_average = spring_dra_divider.size.zero? ? 0 : spring_dra_average - fall_dra_average
     # fall rit
     fall_rit_divider = student_class.select { |s| s[:fall_rit] > 0 }
     fall_rit_total = fall_rit_divider.sum { |s| s[:fall_rit] }
     fall_rit_divider.size.zero? ? fall_rit_average = 0 : fall_rit_average = (fall_rit_total / fall_rit_divider.size).round(2)
     # winter rit
     winter_rit_divider = student_class.select { |s| s[:winter_rit] > 0 }
     winter_rit_total = winter_rit_divider.sum { |s| s[:winter_rit] }
     winter_rit_divider.size.zero? ? winter_rit_average = 0 : winter_rit_average = (winter_rit_total / winter_rit_divider.size).round(2)
     # mid year rit
     # mid_year_rit_divider = student_class.select { |s| s[:mid_year_rit_gain] > 0 }
     # mid_year_rit_total = mid_year_rit_divider.sum { |s| s[:mid_year_rit_gain] }
     # mid_year_rit_divider.size.zero? ? mid_rit_average = 0 : mid_rit_average = (mid_year_rit_total / mid_year_rit_divider.size).round(2)
     mid_rit_average = winter_rit_divider.size.zero? ? 0 : winter_rit_average - fall_rit_average
     # spring rit
     spring_rit_divider = student_class.select { |s| s[:spring_rit] > 0 }
     spring_rit_total = spring_rit_divider.sum { |s| s[:spring_rit] }
     spring_rit_divider.size.zero? ? spring_rit_average = 0 : spring_rit_average = (spring_rit_total / spring_rit_divider.size).round(2)
     # end year rit
     # end_year_rit_divider = student_class.select { |s| s[:end_year_rit_gain] > 0 }
     # end_year_rit_total = end_year_rit_divider.sum { |s| s[:end_year_rit_gain] }
     # end_year_rit_divider.size.zero? ? end_rit_average = 0 : end_rit_average = (end_year_rit_total / end_year_rit_divider.size).round(2)
     end_rit_average = spring_rit_divider.size.zero? ? 0 : spring_rit_average - fall_rit_average
     # fall rank
     fall_rank_divider = student_class.select { |s| s[:fall_rank] > 0 }
     fall_rank_total = fall_rank_divider.sum { |s| s[:fall_rank] }
     fall_rank_divider.size.zero? ? fall_rank_average = 0 : fall_rank_average = (fall_rank_total / fall_rank_divider.size).round(2)
     # winter rank
     winter_rank_divider = student_class.select { |s| s[:winter_rank] > 0 }
     winter_rank_total = winter_rank_divider.sum { |s| s[:winter_rank] }
     winter_rank_divider.size.zero? ? winter_rank_average = 0 : winter_rank_average = (winter_rank_total / winter_rank_divider.size).round(2)
     # mid year rank
     # mid_year_rank_divider = student_class.select { |s| s[:mid_year_rank_gain] > 0 }
     # mid_year_rank_total = mid_year_rank_divider.sum { |s| s[:mid_year_rank_gain] }
     # mid_year_rank_divider.size.zero? ? mid_rank_average = 0 : mid_rank_average = (mid_year_rank_total / mid_year_rank_divider.size).round(2)
     mid_rank_average = winter_rank_divider.size.zero? ? 0 : winter_rank_average - fall_rank_average
     # spring rank
     spring_rank_divider = student_class.select { |s| s[:spring_rank] > 0 }
     spring_rank_total = spring_rank_divider.sum { |s| s[:spring_rank] }
     spring_rank_divider.size.zero? ? spring_rank_average = 0 : spring_rank_average = (spring_rank_total / spring_rank_divider.size).round(2)
     # end year rank
     # end_year_rank_divider = student_class.select { |s| s[:end_year_rank_gain] > 0 }
     # end_year_rank_total = end_year_rank_divider.sum { |s| s[:end_year_rank_gain] }
     # end_year_rank_divider.size.zero? ? end_rank_average = 0 : end_rank_average = (end_year_rank_total / end_year_rank_divider.size).round(2)
     end_rank_average = spring_rank_divider.size.zero? ? 0 : spring_rank_average - fall_rank_average
     # fall Lexile
     # winter lexile
     # spring lexile
     # build hash

     @class_average = { hug_first_attempt_average: hug_one_average, hug_second_attempt_average: hug_two_average,
                        hug_gain_average: hug_gain_average, fall_dra_average: fall_dra_average,
                        winter_dra_average: winter_dra_average, mid_year_dra_gain_average: mid_dra_average,
                        spring_dra_average: spring_dra_average, end_year_dra_gain_average: end_dra_average,
                        fall_rit_average: fall_rit_average, winter_rit_average: winter_rit_average,
                        mid_year_rit_gain_average: mid_rit_average, spring_rit_average: spring_rit_average,
                        end_year_rit_gain_average: end_rit_average, fall_rank_average: fall_rank_average,
                        winter_rank_average: winter_rank_average, mid_year_rank_gain_average: mid_rank_average,
                        spring_rank_average: spring_rank_average, end_year_rank_gain_average: end_rank_average,
                        fall_lexile_average: '60-210', winter_lexile_average: '65-215', spring_lexile_average: '70-220' }
   end

   def self.fifth_averages(student_class)

     # fall dra
     fall_dra_divider = student_class.select { |s| s[:fall_dra] > 0 }
     fall_dra_total = fall_dra_divider.sum { |s| s[:fall_dra] }
     fall_dra_divider.size.zero? ? fall_dra_average = 0 : fall_dra_average = (fall_dra_total / fall_dra_divider.size).round(2)
     # winter dra
     winter_dra_divider = student_class.select { |s| s[:winter_dra] > 0 }
     winter_dra_total = winter_dra_divider.sum { |s| s[:winter_dra] }
     winter_dra_divider.size.zero? ? winter_dra_average = 0 : winter_dra_average = (winter_dra_total / winter_dra_divider.size).round(2)
     # mid year dra gain
     # mid_year_divider = student_class.select { |s| s[:mid_year_dra_gain] > 0 }
     # mid_year_total = mid_year_divider.sum { |s| s[:mid_year_dra_gain] }
     # mid_year_divider.size.zero? ? mid_dra_average = 0 : mid_dra_average = (mid_year_total / mid_year_divider.size).round(2)
     mid_dra_average = winter_dra_divider.size.zero? ? 0 : winter_dra_average - fall_dra_average
     # spring dra
     spring_dra_divider = student_class.select { |s| s[:spring_dra] > 0 }
     spring_dra_total = spring_dra_divider.sum { |s| s[:spring_dra] }
     spring_dra_divider.size.zero? ? spring_dra_average = 0 : spring_dra_average = (spring_dra_total / spring_dra_divider.size).round(2)
     # end year dra gain
     # end_year_divider = student_class.select { |s| s[:end_year_dra_gain] > 0 }
     # end_year_total = end_year_divider.sum { |s| s[:end_year_dra_gain] }
     # end_year_divider.size.zero? ? end_dra_average = 0 : end_dra_average = (end_year_total / end_year_divider.size).round(2)
     end_dra_average = spring_dra_divider.size.zero? ? 0 : spring_dra_average - fall_dra_average
     # fall rit
     fall_rit_divider = student_class.select { |s| s[:fall_rit] > 0 }
     fall_rit_total = fall_rit_divider.sum { |s| s[:fall_rit] }
     fall_rit_divider.size.zero? ? fall_rit_average = 0 : fall_rit_average = (fall_rit_total / fall_rit_divider.size).round(2)
     # winter rit
     winter_rit_divider = student_class.select { |s| s[:winter_rit] > 0 }
     winter_rit_total = winter_rit_divider.sum { |s| s[:winter_rit] }
     winter_rit_divider.size.zero? ? winter_rit_average = 0 : winter_rit_average = (winter_rit_total / winter_rit_divider.size).round(2)
     # mid year rit
     # mid_year_rit_divider = student_class.select { |s| s[:mid_year_rit_gain] > 0 }
     # mid_year_rit_total = mid_year_rit_divider.sum { |s| s[:mid_year_rit_gain] }
     # mid_year_rit_divider.size.zero? ? mid_rit_average = 0 : mid_rit_average = (mid_year_rit_total / mid_year_rit_divider.size).round(2)
     mid_rit_average = winter_rit_divider.size.zero? ? 0 : winter_rit_average - fall_rit_average
     # spring rit
     spring_rit_divider = student_class.select { |s| s[:spring_rit] > 0 }
     spring_rit_total = spring_rit_divider.sum { |s| s[:spring_rit] }
     spring_rit_divider.size.zero? ? spring_rit_average = 0 : spring_rit_average = (spring_rit_total / spring_rit_divider.size).round(2)
     # end year rit
     # end_year_rit_divider = student_class.select { |s| s[:end_year_rit_gain] > 0 }
     # end_year_rit_total = end_year_rit_divider.sum { |s| s[:end_year_rit_gain] }
     # end_year_rit_divider.size.zero? ? end_rit_average = 0 : end_rit_average = (end_year_rit_total / end_year_rit_divider.size).round(2)
     end_rit_average = spring_rit_divider.size.zero? ? 0 : spring_rit_average - fall_rit_average

     # build hash

     @class_average = { hug_first_attempt_average: 0, hug_second_attempt_average: 0,
                        hug_gain_average: 0, fall_dra_average: fall_dra_average,
                        winter_dra_average: winter_dra_average, mid_year_dra_gain_average: mid_dra_average,
                        spring_dra_average: spring_dra_average, end_year_dra_gain_average: end_dra_average,
                        fall_rit_average: fall_rit_average, winter_rit_average: winter_rit_average,
                        mid_year_rit_gain_average: mid_rit_average, spring_rit_average: spring_rit_average,
                        end_year_rit_gain_average: end_rit_average, fall_rank_average: 0,
                        winter_rank_average: 0, mid_year_rank_gain_average: 0,
                        spring_rank_average: 0, end_year_rank_gain_average: 0,
                        fall_lexile_average: '0', winter_lexile_average: '0', spring_lexile_average: '0' }
   end

   @class_average

 end