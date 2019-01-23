class StudentSerializerWeb < ActiveModel::Serializer

  attributes :id, :first_name, :s_last_name, :class_name, :why_inactive,
             :school_id, :school_name, :user_id, :grade, :control_group,
             :vol_name, :vol_email, :vol_phone, :vol_ids


end

