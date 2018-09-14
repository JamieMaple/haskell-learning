import System.Directory
import Control.Monad
import Control.Monad.State
import Control.Monad.Trans
import Control.Monad.Reader

test :: IO [FilePath]
test = do
    contents <- liftIO . listDirectory $ ".."
    rest <- forM contents $ (\name -> return name)
    return rest

data Test = AppConfig { 
    cfgMaxDepth :: Int
} deriving Show

-- state
addItem :: a -> State [a] ()
addItem val = state (\s -> ((), val:s))

removeItem :: State [a] a
removeItem = state (\(x:xs) -> (x, xs))

-- reader
readerTest :: Reader String String
--readerTest = ask >>= (\x -> reader (++"!!"))
readerTest = reader (++"!!")

tom :: Reader String String
tom = do
    env <- ask
    return (env ++ "This is Tom.")

jerry :: Reader String String
jerry = do
    env <- ask
    return (env ++ "This is Jerry.")

tomAndJerry :: Reader String String
tomAndJerry = do
    t <- tom
    j <- jerry
    return (t ++ "\n" ++ j)

runJerryRun :: String
runJerryRun = (runReader tomAndJerry) "Who is this?"


testIO :: String -> IO [FilePath]
testIO path = do
    sub <- liftIO . listDirectory $ path
    return sub


