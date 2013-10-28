class Message < ActiveRecord::Base
  Status = {
    private: 0,
    public: 1
  }

  attr_accessor :user_name

  class << self
    def content_timeline(content_id, status: nil, user_id: nil, page: 1, limit: 30)
      status = [Status[:private], Status[:public]] if status.blank?
      arel = self.where("content_id = ?", content_id)
      arel = arel.where("status IN (?)", status)
      arel = arel.where("user_id = ?", user_id) if user_id.present?
      arel.order("updated_at DESC").page(page).per(limit)
    end

    def edit(params)
      self.transaction do
        id = params[:id].present? ? params[:id].to_i : nil
        current_timestamp = Time.now
        message = nil
        if id.present?
          message = get_by_id(id)
        else
          message = self.new
          message.created_at = current_timestamp
        end

        message.content_id = params[:content_id]
        message.body = params[:body]
        #message.user_id = params[:user_id]
        message.user_id = 0
        message.ip = params[:ip]
        message.status = Status[:public]
        message.updated_at = current_timestamp

        message.save!

        message.user_name = "anonymoous" if 1 == 1
        message
      end
    end
  end
end
