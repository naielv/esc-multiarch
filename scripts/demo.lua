
set("foo","bar")

foo = get("foo")

log(foo)

log("CFG "..config("foo"))
log("CFG "..config("fuz"))

onEvent("*","test",function(msg)
  log("Received "..msg.name)

  sendCommand(self(),"hello","world")
end)

onCommand("*","hello",function(msg)
  log("Hello "..msg.payload.."!")
end)

i=0
tick(2,function()
  log("Sending hello "..i.."!")
  i = i +1
  sendEvent("test","hello")
  return i <= 5
end)

