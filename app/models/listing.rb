class Listing < ActiveRecord::Base
  belongs_to :category
  scope :approved, -> {where("approved = ? AND date_approved > ? AND payment = ?",
                       true, 30.days.ago, true)}
  scope :pending, -> {where("approved is null")}
  scope :rejected, -> {where("approved = ?", false)}

  mount_uploader :logo, LogoUploader


  validates :title, presence: true
  validates :description, presence: true
  validates :headquarters, presence: true
  validates :app_instructions, presence: true
  validates :company_name, presence: true
  validates :company_url, presence: true
  validates :company_email, presence: true
  validates :category_id, presence: true

  def self.search(search)
    if search
      find(:all, conditions: 
        ['title LIKE ? OR description LIKE ? OR company_name LIKE ?', 
        "%#{search}%", "%#{search}%", "%#{search}%"] )
    else
      find(:all)
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Listing.exists?(column => self[column])
  end

  def send_payment_prompt
    generate_token(:payment_token)
    save!
    SubmitterMailer.payment_instructions(self).deliver
  end

  
end
