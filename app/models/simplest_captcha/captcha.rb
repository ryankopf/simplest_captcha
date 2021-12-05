module SimplestCaptcha
  class Captcha < ApplicationRecord
    #id, private_key=the actual captcha letters

    def self.generate
      @captcha = Captcha.new
      word = newpass(5)
      @captcha.private_key = word
      @captcha.save()
      return @captcha.id
    end

    def self.valid(theobject,theuser=nil)
      theuser = theobject.user if ((theuser.nil?) && (theobject.respond_to?("user")))
      if ((!(theuser.nil?)) && theuser.validated?)
        return true
      end
      captcha = Captcha.find(theobject.captcha_id)
      if theobject.captcha.downcase == captcha.private_key
        captcha.update_column(:private_key,"DELETEMESOON4")
        return true
      else
        return false
      end
    end

    def self.validate(captcha_id,word,theuser=nil)
      if (theuser.present? && theuser.respond_to?(:validated?) && theuser.validated?)
        return true
      end
      captcha = Captcha.find(captcha_id)
      if word.downcase == captcha.private_key
        captcha.update_column(:private_key,"DELETEMESOON4")
        return true
      else
        return false
      end
    end

    def self.check_without_updating(captcha_id,word)
      !Captcha.where(id: captcha_id, private_key: word.downcase).empty?
    end


    def self.newpass( len )
      chars = ("a".."h").to_a
      pass = ""
      1.upto(len) { |i| pass << chars[rand(chars.size-1)] }
      return pass
    end

    def self.spurt(h,w,mark,color="gray",amt=1)
      amt.times do
        mark.pixel_color(h,w,"black")
        5.times do
          mark.pixel_color(h+(rand(10)-5),w+(rand(10)-5),color)
          mark.pixel_color(h+(rand(20)-10),w+(rand(20)-10),"darkgray")
          mark.pixel_color(h+(rand(10)-5),w+(rand(10)-5),"black") if rand(3) == 1
          mark.pixel_color(h+(rand(10)-5),w+(rand(10)-5),"#111111") if rand(5) == 1
        end
      end
      return mark
    end

    def self.draw_a_nice_line(mark)
      x = rand(10)
      y = 10+rand(40)
      xo = 0
      yo = 0
      slope = (4+rand(4))
      slope = 0-slope if y > 30
      (100+rand(40)).times do
        xp = x+xo
        yp = y+yo
        mark.pixel_color(xp+rand(2),yp+rand(1),"black")
        mark.pixel_color(xp+1,yp+1,"black")
        mark.pixel_color(xp+rand(2),yp+rand(5),"black")
        xo+=1
        yo=(xo/slope)
        #x+=xo;y+=yo;
      end
      return mark
    end


    def get_blob()
      require "rmagick"
      word = self.private_key

      images = Array.new
      word.each_char { |c|
        images << Magick::Image.read(File.join(SimplestCaptcha.root,"captcha/#{c}.gif")).first
      }

      mark = Magick::Image.read(File.join(SimplestCaptcha.root,"captcha/blank.gif")).first
      x = -40
      y = 0
      for image in images
        x = x + 40 + (rand(10)-5)
        mark = mark.composite(image, x, (0-(rand(8))), Magick::OverCompositeOp)
      end

      mark = Captcha::draw_a_nice_line(mark)
      mark = Captcha::spurt(rand(190),rand(48),mark,"grey",5)
      mark = Captcha::spurt(rand(190),rand(48),mark,"red")
      mark = Captcha::blur_image(mark)
      mark = Captcha::spurt(rand(190),rand(48),mark,"grey",5)
      mark = Captcha::spurt(rand(190),rand(48),mark,"grey",5)
      mark = Captcha::spurt(rand(190),rand(48),mark) if rand(3) == 1

      return mark.scale(200, 50)
    end

    def self.blur_image(img)
      img = img.emboss(radius=0.0, sigma=1.0) if rand(10) == 0
      img = img.edge(radius=2.0) if rand(20) == 0
      img = img.radial_blur((rand(8)).to_f) if rand(3) == 0
      if rand(7) == 0
        img = img.gaussian_blur(radius=rand(3).to_f, sigma=(rand(3)+1).to_f)
      elsif rand(3) == 0
        img = img.gaussian_blur(radius=rand(2).to_f, sigma=(rand(2)+1).to_f)
      elsif rand(3) == 0
        img = img.oil_paint(radius=0.1)
      elsif rand(3) == 0
        #mark = mark.ordered_dither
        #mark = mark.ordered_dither(threshold_map="#{(rand(3)+2)}x2")
      end
      return img
    end


  end
end