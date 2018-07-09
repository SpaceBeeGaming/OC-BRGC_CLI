local term = require("term")
local shell = require("shell")

local headerText = "BRGC CLI v1.0"

function menu()
  local input
  term.clear()

  print("------------------")
  print(headerText)
  print("------------------")

  term.setCursor(1, 7)
  print("Possible commands:")
  print("- calibrate -- (Re)calibrate a reactor")
  print("- steamtarget")
  print("- service -- Enable/Disable Services")
  print("- config")
  print("- list -- List available components")
  print("- discover -- Rescan the system for new components.")
  print("- exit")

  term.setCursor(1, 4)
  term.write(">: ")
  input = term.read({ hint = { "calibrate", "steamtarget", "service", "config", "list", "discover", "exit" } })
  input = input:sub(1, -2)

  if (input == "calibrate") then calibrate()
  elseif (input == "steamtarget") then steamtarget()
  elseif (input == "service") then service_main()
  elseif (input == "config") then print("Not implemented") --TODO: Implement
  elseif (input == "list") then list()
  elseif (input == "discover") then discover()
  elseif (input == "exit") then
    term.clear()
    os.exit()
  else
    print("Invalid command!")
    os.sleep(1)
    menu()
  end
end

function calibrate()
  local input
  term.clear()

  print("------------------")
  print(headerText)
  print("------------------")

  term.setCursor(1, 7)
  shell.execute("brgcctrl list reactors")
  print()
  print("Calibrate a given reactor.")
  print("To calibrate a reactor enter the")
  print("first 3 digits of the address.")
  print("To exit calibration utility enter 'back'")

  term.setCursor(1, 4)
  term.write("> calibrate/: ")
  input = term.read({ hint = { "back" } })
  input = input:sub(1, -2)

  if (input == "back") then
    menu()
  elseif (input == "") then
    print("No argument given!")
    os.sleep(1)
    calibrate()
  else
    print("Executing...")
    shell.execute("brgcctrl calibrate " .. input)
    os.sleep(1)
    calibrate()
  end
end

function steamtarget()
  local input
  term.clear()

  print("------------------")
  print(headerText)
  print("------------------")

  term.setCursor(1, 7)
  shell.execute("brgcctrl steamtarget get")
  print()
  print("Change the target for steam production")
  print("Possible commands:")
  print("- change")
  print("- back")

  term.setCursor(1, 4)
  term.write("> steamtarget/: ")
  input = term.read({ hint = { "change", "back" } })
  input = input:sub(1, -2)

  if (input == "back") then
    menu()
  elseif (input == "change") then
    local input
    term.write("New value: ")
    input = term.read()
    input = input:sub(1, -2)
    print("Executing...")
    shell.execute("brgcctrl steamtarget set " .. input)
    os.sleep(1)
    steamtarget()
  else
    print("Invalid argument!")
    os.sleep(1)
    steamtarget()
  end
end


--Service
function service_main()
  local input
  term.clear()

  print("------------------")
  print(headerText)
  print("------------------")

  term.setCursor(1, 7)
  print("Change the state of services.")
  print("Possible commands:")
  print("- reactor")
  print("- turbine")
  print("- grid")
  print("- all")
  print("- back")

  term.setCursor(1, 4)
  term.write("> service/: ")
  input = term.read({ hint = { "reactor", "turbine", "grid", "all", "back" } })
  input = input:sub(1, -2)

  if (input == "back") then menu()
  elseif (input == "reactor") then service_reactor()
  elseif (input == "turbine") then service_turbine()
  elseif (input == "grid") then service_grid()
  elseif (input == "all") then service_all()
  else
    print("Invalid argument!")
    os.sleep(1)
    service_main()
  end
end

function service_reactor()
  local input
  term.clear()

  print("------------------")
  print(headerText)
  print("------------------")

  term.setCursor(1, 7)
  shell.execute("brgcctrl service reactor status")
  print("Possible commands:")
  print("- stop")
  print("- runOnce")
  print("- shutdown")
  print("- restart")
  print("- start")
  print("- back")

  term.setCursor(1, 4)
  term.write("> service/reactor/: ")
  input = term.read({ hint = { "stop", "runOnce", "shutdown", "restart", "start", "back" } })
  input = input:sub(1, -2)

  if (input == "back") then
    service_main()
  elseif (input == "stop") then shell.execute("brgcctrl service reactor stop")
  elseif (input == "runOnce") then shell.execute("brgcctrl service reactor runOnce")
  elseif (input == "shutdown") then shell.execute("brgcctrl service reactor shutdown")
  elseif (input == "restart") then shell.execute("brgcctrl service reactor restart")
  elseif (input == "start") then shell.execute("brgcctrl service reactor start")
  else
    print("Invalid argument!")
    os.sleep(1)
    service_reactor()
  end
  os.sleep(1)
  service_reactor()
end

function service_turbine()
  local input
  term.clear()

  print("------------------")
  print(headerText)
  print("------------------")

  term.setCursor(1, 7)
  shell.execute("brgcctrl service turbine status")
  print("Possible commands:")
  print("- stop")
  print("- runOnce")
  print("- shutdown")
  print("- restart")
  print("- start")
  print("- back")

  term.setCursor(1, 4)
  term.write("> service/turbine/ : ")
  input = term.read({ hint = { "stop", "runOnce", "shutdown", "restart", "start", "back" } })
  input = input:sub(1, -2)

  if (input == "back") then service_main()
  elseif (input == "stop") then shell.execute("brgcctrl service turbine stop")
  elseif (input == "runOnce") then shell.execute("brgcctrl service turbine runOnce")
  elseif (input == "shutdown") then shell.execute("brgcctrl service turbine shutdown")
  elseif (input == "restart") then shell.execute("brgcctrl service turbine restart")
  elseif (input == "start") then shell.execute("brgcctrl service turbine start")
  else
    print("Invalid argument!")
    os.sleep(1)
    service_turbine()
  end
end

function service_grid()
  local input
  term.clear()

  print("------------------")
  print(headerText)
  print("------------------")

  term.setCursor(1, 7)
  shell.execute("brgcctrl service grid status")
  print("Possible commands:")
  print("- stop")
  print("- runOnce")
  print("- restart")
  print("- start")
  print("- back")

  term.setCursor(1, 4)
  term.write("> service/grid/ : ")
  input = term.read({ hint = { "stop", "runOnce", "restart", "start", "back" } })
  input = input:sub(1, -2)

  if (input == "back") then service_main()
  elseif (input == "stop") then shell.execute("brgcctrl service grid stop")
  elseif (input == "runOnce") then shell.execute("brgcctrl service grid runOnce")
  elseif (input == "restart") then shell.execute("brgcctrl service grid restart")
  elseif (input == "start") then shell.execute("brgcctrl service grid start")
  else
    print("Invalid argument!")
    os.sleep(1)
    service_grid()
  end
end

function service_all()
  local input
  term.clear()

  print("------------------")
  print(headerText)
  print("------------------")

  term.setCursor(1, 7)
  print("Possible commands:")
  print("- stop")
  print("- shutdown")
  print("- restart")
  print("- start")
  print("- back")

  term.setCursor(1, 4)
  term.write("> service/all/ : ")
  input = term.read({ hint = { "stop", "shutdown", "restart", "start", "back" } })
  input = input:sub(1, -2)

  if (input == "back") then service_main()
  elseif (input == "stop") then shell.execute("brgcctrl service all stop")
  elseif (input == "shutdown") then shell.execute("brgcctrl service all shutdown")
  elseif (input == "restart") then shell.execute("brgcctrl service all restart")
  elseif (input == "start") then shell.execute("brgcctrl service all start")
  else
    print("Invalid argument!")
    os.sleep(1)
    service_all()
  end
end

function list()
  local input
  term.clear()

  print("------------------")
  print(headerText)
  print("------------------")

  term.setCursor(1, 7)
  shell.execute("brgcctrl list")
  print()
  print("Possible commands:")
  print("- back")

  term.setCursor(1, 4)
  term.write("> list/ : ")
  input = term.read({ hint = { "back" } })
  input = input:sub(1, -2)
  if (input == "back") then
    menu()
  else
    print("Invalid argument!")
    os.sleep(1)
    list()
  end
end

function discover()
  print("Executing...")
  shell.execute("brgcctrl discover")
  os.sleep(1)
  menu()
end

menu()