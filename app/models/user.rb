class User < ActiveRecord::Base
    has_and_belongs_to_many :genres
    has_and_belongs_to_many :instruments
    has_and_belongs_to_many :interests
    has_and_belongs_to_many :activities

    # validates_confirmation_of :password

    has_secure_password

    validates :password, length: { minimum: 8 }, allow_nil: true
    validates_format_of :email_address, :with => /@/

    LEVEL_ANCHORS = ['Beginner', 'Novice', 'Fair', 'Good', 'Excellent']
    AFFILIATIONS = ['AFFIL 1', 'AFFIL 2', 'AFFIL 3']


    def password_valid?(password)
        salted_password = password + self.salt.to_s
        digest = Digest::SHA1.hexdigest(salted_password)
        return digest == self.password_digest
    end

    def password
        @password
    end

    def password=(password)
        @password = password
        rng = Random.new
        self.salt = rng.rand().to_s
        self.password_digest = Digest::SHA1.hexdigest(password + self.salt)
    end

    def password_confirmation
        @password_confirmation
    end

    def password_confirmation=(password_confirmation)
        @password_confirmation = password_confirmation
    end
end
