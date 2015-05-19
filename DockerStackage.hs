module Main (main) where

import Control.Monad
import Control.Applicative
import System.Process
import Data.List
import Data.List.Split

type Version = String
type URL = String

versions :: [Version]
versions =
  [ "1.11"
  , "1.12"
  , "1.15"
  , "2.9"
  ]

mkdirp :: FilePath -> IO ()
mkdirp path = callProcess "mkdir" ["-p", path]

curl :: URL -> FilePath -> IO ()
curl url dest = callProcess "curl" ["-s", "-o", dest, url]

sha256 :: FilePath -> IO String
sha256 path = head . words <$> readProcess "shasum" ["-a", "256", path] ""

cabalUrl :: Version -> URL
cabalUrl version = "https://www.stackage.org/snapshot/lts-" ++ version ++ "/cabal.config?global=true"

cabalPath :: Version -> FilePath
cabalPath version = "cabal-configs/" ++ version

dockerfilePath :: Version -> FilePath
dockerfilePath version = version ++ "/Dockerfile"

replace :: Eq a => [a] -> [a] -> [a] -> [a]
replace old new = intercalate new . splitOn old 

createVersion :: String -> String -> IO ()
createVersion template version = do
  mkdirp version
  let url = cabalUrl version
  let path = cabalPath version
  curl url path
  checksum <- sha256 (cabalPath version)
  let dockerfile = replace "{VERSION}" version . replace "{CHECKSUM}" checksum $ template
  writeFile (dockerfilePath version) dockerfile

main :: IO ()
main = do
  template <- readFile "Dockerfile.template"
  forM_ versions (createVersion template)
