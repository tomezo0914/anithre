class Content < ActiveRecord::Base

  has_many :messages, -> { order("updated_at DESC") }

  Status = {
    private: 0,
    public: 1
  }

  class << self
    def recently(limit: 10)
      status = [Status[:private], Status[:public]]
      self.where("status IN (?)", status).order("updated_at DESC").limit(limit)
    end

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
          content.status = Status[:private]
        end

        Rails.logger.debug "--------------"
        Rails.logger.debug params.inspect
        Rails.logger.debug "--------------"

        content.title = params[:title]
        content.subtitle = params[:subtitle]
        content.description = params[:description]
        content.episode = params[:episode]
        content.status = params[:publish].blank? ? Status[:private] : params[:publish]
        content.user_id = user_id
        content.ip_address = ip

        content.save!

        content
      end
    end

    def publish(params, user_id: nil)
      self.transaction do
        current_timestamp = Time.now
        content = get_by_id(params[:id].to_i, user_id: user_id)
        content.status = Status[:publish]
        content.updated_at = current_timestamp
        content.save!

        content
      end
    end
  end
end
