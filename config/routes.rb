SimplestCaptcha::Engine.routes.draw do
  get ':id.gif', to: 'captcha#show'
  get ':id.js', to: 'captcha#show'
end
