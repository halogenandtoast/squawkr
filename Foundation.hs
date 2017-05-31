{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE ViewPatterns      #-}
module Foundation where

import Import.NoFoundation
import Database.Persist.Sql (ConnectionPool, runSqlPool)
import Text.Hamlet          (hamletFile)

mkYesodData "App" $(parseRoutesFile "routes")

type DB = ReaderT SqlBackend (HandlerT App IO)
type Form x = Html -> MForm (HandlerT App IO) (FormResult x, Widget)

data App = App { appConnPool :: ConnectionPool }


instance Yesod App where
  defaultLayout widget = do
    pc <- widgetToPageContent $(widgetFile "default-layout")
    withUrlRenderer $(hamletFile "templates/default-layout-wrapper.hamlet")

instance YesodPersist App where
    type YesodPersistBackend App = SqlBackend
    runDB action = do
        master <- getYesod
        runSqlPool action $ appConnPool master

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage
