class Content < ActiveRecord::Base
  Status = {
    private: 0,
    public: 1
  }

  class << self
    def get_content_by_id(id, status: nil, user_id: nil)
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
        content = nil
        if id.present?
          content = get_content_by_id(id)
        else
          content = self.new
          content.created_at = current_timestamp
        end

        content.title = params[:title]
        content.subtitle = params[:subtitle]
        content.body = params[:body]
        content.user_id = params[:user_id]
        content.ip = params[:ip]
        content.status = Status[:private]
        content.updated_at = current_timestamp

        content.save!

        content
      end
    end
  end
end
