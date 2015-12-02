import Control.Monad
import System.IO
import System.Process

main :: IO ()
main = forM_ [0..1000] $ \ix -> do
  putStrLn ("Iteration #" ++ show ix)
  let p = (proc "uuid-v4-collision-repro-exe" [])
          { std_out = CreatePipe }
  (_, Just h1, _, ph1) <- createProcess p
  (_, Just h2, _, ph2) <- createProcess p
  waitForProcess ph1
  waitForProcess ph2
  out1 <- hGetContents h1
  out2 <- hGetContents h2
  if out1 == out2
    then do
        putStr out1
        putStr out2
        error "UUID collision!"
    else return ()
