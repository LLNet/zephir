-- Copyright (c) 2013-2019 Zephir Team
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

import qualified Turtle
import Prelude hiding (FilePath)
import Filesystem.Path.CurrentOS as Path

import qualified Data.Aeson as JSON
import Data.Aeson ((.=), (.:))

import Options.Applicative
import Control.Monad
import Data.Traversable
import Data.Maybe
import Data.List

import qualified Data.Text as T
import qualified Data.Text.Encoding as T.Encoding
import qualified Data.ByteString.Lazy as B

import qualified System.Console.ANSI as ANSI

zpProgDesc :: String
zpProgDesc = "Zephir program description"

zpProgHeader :: String
zpProgHeader = "Zephir program header"

showHelpOnErrorExecParser :: ParserInfo a -> IO a
showHelpOnErrorExecParser = customExecParser (prefs showHelpOnError)

data Command = CommandTest deriving (Show)

main :: IO ()
main = do
    command <- showHelpOnErrorExecParser (info (helper <*> parseCommand)
        (fullDesc  <>
        progDesc zpProgDesc <>
        header zpProgHeader))
    run command

parseTestCommand :: Parser Command
parseTestCommand = pure CommandTest

parseCommand :: Parser Command
parseCommand = subparser $
    command "test"
        (info (helper <*> parseTestCommand)
        (fullDesc <> progDesc "some test command"))

runTest :: IO ()
runTest = putStrLn "Zephir"

run :: Command -> IO ()
run command =
    case command of
        CommandTest -> runTest
