{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handler.Home where

import Import

data Session = Session { sessionEmail :: Text
                       , sessionPassword :: Text
                       }

data Registration = Registration { registrationEmail :: Text
                                 , registrationPassword :: Text
                                 }

loginForm :: Form Session
loginForm = renderDivs $ Session
  <$> areq emailField "Email" Nothing
  <*> areq passwordField "Password" Nothing

registerForm :: Form Registration
registerForm = renderDivs $ Registration
  <$> areq emailField "Email" Nothing
  <*> areq passwordField "Password" Nothing

getHomeR :: Handler Html
getHomeR = do
  (loginFormWidget, loginEncType) <- generateFormPost loginForm
  (registerFormWidget, registerEncType) <- generateFormPost registerForm
  defaultLayout $ do
    setTitle "Squawkr"
    $(widgetFile "home")
