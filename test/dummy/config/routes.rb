Rails.application.routes.draw do
  mount SimplestCaptcha::Engine => "/simplest_captcha"
end
