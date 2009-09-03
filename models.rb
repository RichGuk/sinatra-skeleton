class User
  include DataMapper::Resource

  attr_accessor :password, :password_confirmation

  property :id, Integer, :serial => true
  property :login, String, :nullable => false, :length => 3..40, :unique => true
  property :email, String, :nullable => false, :length => 1..320, :unique => true

  property :crypted_password, String
  property :salt, String

  validates_is_confirmed :password, :if => proc{ |m| m.password_confirm_required? }

  before :save, :encrypt_password

  def encrypt_password
    self.salt ||= Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--")
    unless password.nil? || password.empty?
      self.crypted_password = self.class.encrpyt(self.salt, self.password)
    end
  end

  def self.encrpyt(salt, password)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  def self.authenticate(login, password)
    u = User.first(:login => login)
    return nil unless u
    u.crypted_password == self.encrpyt(u.salt, password) ? u : nil
  end

  def password_confirm_required?
    crypted_password.blank? || !password.blank?
  end
end