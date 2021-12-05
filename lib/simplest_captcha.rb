require "simplest_captcha/version"
require "simplest_captcha/engine"
require "simplest_captcha/captcha_module"
require "simplest_captcha/captcha_helper"

module SimplestCaptcha
  # Your code goes here...
  if defined?(ActiveRecord::Base)
    ActiveSupport.on_load(:action_view) do
      ActionView::Base.send :include, SimplestCaptcha::CaptchaHelper
    end
  end
end
