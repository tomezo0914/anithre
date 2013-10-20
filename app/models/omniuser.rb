class Omniuser < ActiveRecord::Base
  Provider = {
    twitter: "twitter",
    facebook: "facebook",
  }

  class << self
    def get_twitter_by_uid(uid)
      get_user_by_provider_uid(Provider[:twitter], uid)
    end

    def get_facebook_by_uid(uid)
      get_user_by_provider_uid(Provider[:facebook], uid)
    end

    def get_user_by_provider_uid(provider ,uid)
      self.where("provider = ? AND uid = ?", provider, uid).first
    end

    def create(auth)
      self.transaction do
        current_timestamp = Time.now
        user = self.new
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.created_at = current_timestamp
        user.updated_at = current_timestamp

        case user.provider
        when Provider[:twitter]
          user.name = auth["info"]["nickname"]
        when Provider[:facebook]
          user.name = auth["info"]["name"]
        end

        user.save!
        user
      end
    end
  end
end
