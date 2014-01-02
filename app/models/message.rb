class Message < ActiveRecord::Base
  Status = {
    private: 0,
    public: 1
  }

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
        message = nil
        if id.present?
          message = get_by_id(id)
        else
          message = self.new
        end

        content = Content.where("id = ?", params[:content_id].to_i).first
        hash_key = "#{params[:ip]}#{Time.now.strftime('%Y%m%d')}#{content.title}#{content.episode}"

        message.content_id = params[:content_id]
        message.body = params[:body]
        message.user_hash = Digest::MD5.new.update(hash_key).to_s
        message.ip_address = params[:ip]
        message.status = Status[:public]

        message.save!

        message.user_name = "anonymoous" if 1 == 1
        message
      end
    end
  end
end
