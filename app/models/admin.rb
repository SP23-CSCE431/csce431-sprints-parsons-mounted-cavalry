class Admin < ApplicationRecord
    devise :omniauthable, omniauth_providers: [:google_oauth2]

    # asks for gmail or tamu email
    def self.from_google(email:, full_name:, uid:, avatar_url:)
        return unless /@tamu.edu\z/.match?(email)

        create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
    end
end
