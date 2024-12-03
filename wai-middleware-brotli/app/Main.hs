{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Concurrent
import Network.HTTP.Types.Status
import Network.Wai
import qualified Network.Wai.Middleware.Brotli as B
import Network.Wai.Handler.Warp
import Network.Wai.Application.Static
import Network.Wai.Middleware.Gzip

main :: IO ()
main = do
  let settings =
        B.defaultSettings
        {B.brotliFilesBehavior = B.BrotliPreCompressed B.BrotliIgnore, B.brotliMinimumSize = 5}
      app = staticApp $ defaultWebAppSettings "."

  runEnv 3000 (gzip def {- TODO replace gzip with zopfli -} $ B.brotli settings {- $ sdch sdchSettings -} $ app)
