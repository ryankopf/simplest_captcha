module CaptchaModule
  attr_accessor :captcha,:captcha_id,:captcha_skip

  def captcha_correct
    return true if self.captcha_skip
    errors.add("captcha","does not match") unless Captcha::validate(self.captcha_id,self.captcha.downcase)
  end

  def captcha_valid
    return true if self.captcha_skip
    errors.add("captcha","does not match the letters pictured.") unless Captcha.valid(self)
  end

  def captcha_valid_for_revisable
    return true if (self.revision_of.present? && self.new_record?)
    return true if self.captcha_skip
    errors.add("captcha","does not exist") if self.captcha.blank?
    errors.add("captcha","does not match") unless Captcha::validate(self.captcha_id,self.captcha.downcase)
  end

end