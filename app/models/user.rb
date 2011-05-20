class User < ActiveRecord::Base
    
    serialize :birthdate, Hash
    attr_accessor :password
    attr_accessible :first_name,:last_name, :email, :password, :password_confirmation, :birthdate
    attr_readonly :gender

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :first_name, :presence => true,
                      :length => { :maximum => 32}, :format => {:with => /\A[^;]+\z/}
    validates :last_name, :presence => true,
                      :length => { :maximum => 32}, :format => {:with => /\A[^;]+\z/}
    validates :email, :presence => true,
                      :format => { :with => email_regex },
                      :uniqueness => { :case_sensitive => false}
    validates :password, :presence =>true, :confirmation => true, :length => {:within => 6..40}

    before_save :encrypt_password

    def has_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
     end

     def self.authenticate(email,submitted_password)
       user = find_by_email(email)
       return nil if user.nil?
       return user if user.has_password?(submitted_password)
     end
    def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
   end

    private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
    def age
      age = Date.today.year - read_attribute(:birthdate).year
      if Date.today.month < read_attribute(:birthdate).month || 
      (Date.today.month == read_attribute(:birthdate).month && read_attribute(:birthdate).day >= Date.today.day)
        age = age - 1
      end
      return age
    end

  end
  
  
