class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :lockable
  devise :omniauthable, omniauth_providers: %i[twitter google_oauth2 facebook]

  validates :email, :last_name, :first_name, presence: true
  validates_uniqueness_of :email, :cellphone, :identity_number, :licence_number, :allow_blank => true, :allow_nil => true
  validates :identity_number, length: {minimun: 13, maximum: 13}
     
  has_many :trips, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :report, dependent: :destroy
  has_many :riders, dependent: :destroy
  
  has_one_attached :profile_image

  enum gender: [
    :not_chosen,
    :male, 
    :female
  ]

  enum role: [
    :rider,
    :driver,
    :admin,
    :super_admin
  ]

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    role.eql?('admin')
  end

  def driver?
    role.eql?('driver')
  end

  def self.to_csv
    attributes = User.column_names

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def self.import file
    CSV.foreach(file.path, headers: true) do |row|
      row = row.to_hash
      row[:tokens] = {}
      user = User.new(row)
      user.skip_confirmation!
      user.save(validate: false)
    end
  end

  protected
  # I disable this method because I don't use the confirmable Devise module
  def confirmation_required?
    true
  end

  def self.from_omniauth(access_token)
    providers = ['twitter', 'facebook']
    data      = access_token.info
    user      = User.where(email: data['email'])&.first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      if providers.include?(access_token.provider)
        first_name = data['name']&.split&.first
        last_name  = data['name']&.split&.last
      else
        first_name = data['first_name']
        last_name = data['last_name']
      end

      user = User.new(email: data['email'],
                         first_name: first_name,
                         last_name: last_name,
                         password: Devise.friendly_token[0, 20],
                         confirmed_at: Time.zone.now
                        )
      if user.save(validate: false)
        user.profile_image.attach(io: open(data['image']), filename: "#{user.first_name}-#{user.id}.png")
      end
    end
    user.confirm
    user
  end
end
