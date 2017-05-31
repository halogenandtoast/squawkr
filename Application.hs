{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE ViewPatterns         #-}
{-# LANGUAGE RecordWildCards      #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Application where

import Import
import Database.Persist.Postgresql (createPostgresqlPool)
import Control.Monad.Logger (runStdoutLoggingT)

import Handler.Home
import Handler.Register
import Handler.SignIn

mkYesodDispatch "App" resourcesApp

develMain :: IO ()
develMain = appMain

appMain :: IO ()
appMain = do
  appConnPool <- runStdoutLoggingT $ createPostgresqlPool "host=localhost database=squawkr user=yesod password=yesod port=5432" 5
  warp 3000 App {..}
