module Array.Focus where
{-| Focus helpers for Array.

# Accessors
@docs at, updateAt

-}

import Maybe
import Array
import Array (Array)
import Focus (..)

{-| Create a focus on the element of the array at the given index

    Focus.set (at 1) 0 (Array.fromList [1,2,3]) == (Array.fromList [1,0,3])
-}
at : Int -> Focus (Array a) (Maybe a)
at n =
  create
    (Array.get n)
    (\f xs -> case f (Array.get n xs) of
      Nothing -> xs
      Just x  -> Array.set n x xs
    )

{-| Update the element at the given index

  updateAt 1 (\x -> x * x) (Array.fromList [1,2,3]) == (Array.fromList [1,4,3])
-}
updateAt : Int -> (a -> a) -> Array a -> Array a
updateAt n f = update (at n) (Maybe.map f)
