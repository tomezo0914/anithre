class Content < ActiveRecord::Base

  has_many :messages, -> { order("updated_at DESC") }

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

    def edit(params, user_id: nil, ip: nil)
      self.transaction do
        id = params[:id].present? ? params[:id].to_i : nil
        current_timestamp = Time.now
        content = nil

        content = get_by_id(id) if id.present?
        if content.blank?
          content = self.new
          content.created_at = current_timestamp
        end

        content.title = params[:title]
        content.subtitle = params[:subtitle]
        content.description = params[:description]
        content.episode = params[:episode]
        content.user_id = user_id
        content.ip = ip
        content.status = Status[:private]
        content.updated_at = current_timestamp

        content.save!

        content
      end
    end
  end
end
