module Handler.SignIn where

import Import

getSignInR :: Handler Html
getSignInR = defaultLayout $(widgetFile "temp")
