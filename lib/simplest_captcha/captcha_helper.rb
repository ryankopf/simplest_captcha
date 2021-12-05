module SimplestCaptcha
  module CaptchaHelper
    def captcha_tag(f)
      stringbuf = "<div class='captcha_tag'>"
      if respond_to?(:user_is_validated?)
        if user_is_validated?
          return stringbuf << "</div>"
        end
      end
      captcha_public = SimplestCaptcha::Captcha::generate
      stringbuf << f.hidden_field(:captcha_id, value: "#{captcha_public}")
      stringbuf << "<div class='cimg'><img src='/captcha/#{captcha_public}.gif' id='captcha_img' class='captcha_img'></div>"
      img = "<img src='https://i.ani.me/0251/9977/ref.png' alt='new image' border='0' class='refresh'>"
      stringbuf << link_to(img.html_safe, "/captcha/#{captcha_public}.js", method: :get, remote: true)
      stringbuf << "<div>"
      stringbuf << f.text_field(:captcha, autocomplete: :off)
      stringbuf << "</div>"
      if (respond_to?(:logged_in?) && respond_to?(:user_is_validated?))
        stringbuf << "<div class='captcha_hint'>"
        if logged_in?
          stringbuf << "Repeat the letters shown or "
          stringbuf << link_to("validate your mobile phone.", "/users/#{current_user.id}", target: "_blank")
        else
          stringbuf << "<a href='/login' target='_blank'>Login and validate your account.</a>"
        end
        stringbuf << "</div>"
      end
      return stringbuf.html_safe
    end
  end
end
