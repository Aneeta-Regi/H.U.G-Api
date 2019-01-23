class EventSerializer < ActiveModel::Serializer
  attributes :id, :event_name, :start_date, :url, :image, :school_id, :school_name, :description, :address, :city, :state, :zip, :label, :end_date
end
