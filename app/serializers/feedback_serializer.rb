class FeedbackSerializer < ActiveModel::Serializer
  has_many :resolutions
  attributes :id, :vol_name, :vol_id, :email, :mood, :comments, :feed_date, :session_id

  def feed_date
    feed_date = object.created_at
    feed_date
  end
end


