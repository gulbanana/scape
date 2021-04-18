module Input (controlSub) where

import Data.Maybe
import Data.Set
import Miso
import Game

data Control = ControlUp | ControlDown | ControlLeft | ControlRight | ControlPause
  deriving (Eq, Ord)

controlSub :: Sub Action
controlSub = keyboardSub (pickIfOne . mapMaybe controls . toList)

controls :: Int -> Maybe Control
-- arrows
controls 37  = Just ControlLeft
controls 38  = Just ControlUp
controls 39  = Just ControlRight
controls 40  = Just ControlDown
-- wasd
controls 65  = Just ControlLeft
controls 87  = Just ControlUp
controls 68  = Just ControlRight
controls 83  = Just ControlDown
-- numpad
controls 100 = Just ControlLeft
controls 104 = Just ControlUp
controls 102 = Just ControlRight
controls 98  = Just ControlDown
-- 5, space
controls 101 = Just ControlPause
controls 32  = Just ControlPause
controls _  = Nothing 

pickIfOne :: [Control] -> Action
pickIfOne []  = NoOp
pickIfOne [x] = pick x
pickIfOne _   = NoOp

pick :: Control -> Action
pick ControlLeft = MoveDelta (-1) 0
pick ControlUp = MoveDelta 0 (-1)
pick ControlDown = MoveDelta 0 1
pick ControlRight = MoveDelta 1 0
pick ControlPause = Wait
