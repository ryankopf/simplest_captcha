class CreateSimplestCaptchaCaptchas < ActiveRecord::Migration[6.1]
  def change
    create_table :simplest_captcha_captchas do |t|
      t.string :private_key
      t.timestamps
    end
  end
end
