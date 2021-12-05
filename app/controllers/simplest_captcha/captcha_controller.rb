require_dependency "simplest_captcha/application_controller"

module SimplestCaptcha
  class CaptchaController < ApplicationController
    def show
      @captcha = Captcha.find(params[:id])
      respond_to do |format|
        format.gif do
          mark = @captcha.get_blob
          mark = mark.scale(120, 30) if params[:sm] == "y"
          render content_type:  'image/gif', plain: mark.to_blob
        end
        format.js do
          word = Captcha::newpass(5)
          @captcha.private_key = word
          @captcha.save()
          render
        end
      end
    end
  end
end