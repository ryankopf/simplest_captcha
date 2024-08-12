module SimplestCaptcha
  module CaptchaHelper
    def captcha_tag(f, options = {})
      # Set initial variables based on options
      show_hint = !options[:dont_show_hint]
      show_login = !options[:dont_show_login]
      user_validation_is_available = respond_to?(:user_is_validated?)

      # Initialize the string buffer
      stringbuf = "<div class='captcha_tag'>"

      # Check if the user is validated and return early if true
      if user_validation_is_available && user_is_validated?
        stringbuf << "</div>"
        return stringbuf.html_safe
      end

      # Generate captcha and build the captcha HTML
      captcha_public = SimplestCaptcha::Captcha.generate
      stringbuf << f.hidden_field(:captcha_id, value: "#{captcha_public}")
      stringbuf << "<div class='cimg'><img src='/captcha/#{captcha_public}.gif' id='captcha_img' class='captcha_img'>"
      img = "<img src='https://i.ani.me/0251/9977/ref.png' alt='new image' border='0' class='refresh'>"
      stringbuf << link_to(img.html_safe, "/captcha/#{captcha_public}.js", method: :get, remote: true)
      stringbuf << "</div><div>"
      stringbuf << f.text_field(:captcha, autocomplete: :off)
      stringbuf << "</div>"

      # Optionally show the captcha hint based on conditions
      if show_hint && respond_to?(:logged_in?) && user_validation_is_available
        stringbuf << "<div class='captcha_hint'>"
        if logged_in? && show_login
          stringbuf << "Repeat the letters shown or "
          stringbuf << link_to("validate your mobile phone.", "/users/#{current_user.id}", target: "_blank")
        elsif !logged_in? && show_login
          stringbuf << "<a href='/login' target='_blank'>Login and validate your account.</a>"
        end
        stringbuf << "</div>"
      end

      # Close the main captcha_tag div
      stringbuf << "</div>"
      return stringbuf.html_safe
    end
  end
end
