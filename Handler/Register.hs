module Handler.Register where

import Import

getRegisterR :: Handler Html
getRegisterR = defaultLayout $(widgetFile "temp")
