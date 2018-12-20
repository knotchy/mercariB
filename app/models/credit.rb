class Credit < ApplicationRecord
  belongs_to :user

  validates :expiration_month, :expiration_year, :security_code, presence: true
  validates :card_number, presence: true, uniqueness: true

  def card_img
    card_numbers = card_number.split("")
    first_number = card_numbers[0].to_i
    digit  = card_numbers.length
    if digit == 14
      card_img = "dinersclub"
    elsif digit == 15
      card_img = "american_express"
    else digit == 16
      case first_number
      when 3
        card_img = "jcb"
      when 4
        card_img = "visa"
      when 5
        card_img = "master-card"
      end
    end
    return card_img
  end

  def low_four_digits
    regexp = /\d(?=(\d){4})/
    self.card_number = card_number.gsub(regexp, '*')
    return card_number
  end

  def month_number
    month = "0" + expiration_month.to_s
    return month
  end
end