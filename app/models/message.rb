class Message < ActiveRecord::Base
  Status = {
    private: 0,
    public: 1
  }

  class << self
    def get_by_id(id, status: nil, user_id: nil)
      status = [Status[:private], Status[:public]] if status.blank?

      arel = self.where("id = ?", id)
      arel = arel.where("status IN (?)", status)
      arel = arel.where("user_id = ?", user_id) if user_id.present?
      arel.first
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
        message.user_id = 10
        message.ip = params[:ip]
        message.status = Status[:private]
        message.updated_at = current_timestamp

        message.save!

        message
      end
    end
  end
end
