SimplestCaptcha::Engine.routes.draw do
  get ':id.gif', to: 'captcha#show'
end
