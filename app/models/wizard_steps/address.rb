class Offer::Address < Offer
  validates :address_addon, :street, :street_no, :city, :country_code_iso, :presence => true
  validates_numericality_of :zip
  after_initialize initialize_from_user
end
