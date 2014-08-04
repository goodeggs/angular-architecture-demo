require './index'

before fibrous ->
  databases.sync.connect()
  databases.sync.reset()
