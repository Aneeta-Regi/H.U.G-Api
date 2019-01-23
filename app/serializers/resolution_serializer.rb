class ResolutionSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :comment, :res_date

  def res_date
    res_date = object.created_at
    res_date
  end
end
