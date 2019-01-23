class DraRecord < ApplicationRecord
  belongs_to :student

  def check_values
    # check the dra scores
    self.fall_dra = 0 if fall_dra.nil?
    self.winter_dra = 0 if winter_dra.nil?
    self.spring_dra = 0 if spring_dra.nil?
    # check the rit scores
    self.fall_rit = 0 if fall_rit.nil?
    self.winter_rit = 0 if winter_rit.nil?
    self.spring_rit = 0 if spring_rit.nil?
    # check the rank scores
    self.fall_rank = 0 if fall_rank.nil?
    self.winter_rank = 0 if winter_rank.nil?
    self.spring_rank = 0 if spring_rank.nil?
    # check lexile scores
    self.fall_lexile = '' if fall_lexile.nil?
    self.winter_lexile = '' if winter_lexile.nil?
    self.spring_lexile = '' if spring_lexile.nil?
  end

  # dra scores
  def set_mid_year_dra
    if fall_dra > 0 && winter_dra > 0
      self.mid_year_dra_gain = self.winter_dra - self.fall_dra
    else
      self.mid_year_dra_gain = 0
    end
  end

  def set_end_year_dra
    if self.fall_dra > 0 && self.spring_dra > 0
      self.end_of_year_dra_gain = self.spring_dra - self.fall_dra
    else
      self.end_of_year_dra_gain = 0
    end
  end

    # rit socres
  def set_mid_year_rit
    if self.fall_rit > 0 && self.winter_rit > 0
      self.mid_year_rit_gain = self.winter_rit - self.fall_rit
    else
      self.mid_year_rit_gain = 0
    end
  end

  def set_end_year_rit
    if self.fall_rit > 0 && self.spring_rit > 0
      self.end_of_year_rit_gain = self.spring_rit - self.fall_rit
    else
      self.end_of_year_rit_gain = 0
    end
  end

  # Rank scores
  def set_end_year_rank
    if self.fall_rank > 0 && self.spring_rank > 0
      self.end_year_rank_gain = self.spring_rank - self.fall_rank
    else
      self.end_year_rank_gain = 0
    end
  end

  def set_mid_year_rank
    if self.fall_rank > 0 && self.winter_rank > 0
      self.mid_year_rank_gain = self.winter_rank - self.fall_rank
    else
      self.mid_year_rank_gain = 0
    end
  end

end
