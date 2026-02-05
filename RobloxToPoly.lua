print("Welcome to RobloxToPoly (v0.0.9).\nThis is a Luau -> Polytoria Lua converter.\nInput file name:")
local filename = io.read("*l")
local file = nil
local conversionapi = require("RemapAPI")
print("Opening file...\nType 'S' to start conversion, or type 'E' to end program.")
local selection = io.read("*l")
if selection == "S" then
    print("Starting conversion.")
    local currentline = 0
    local totals = {}
    for line in io.lines(filename) do
        currentline = currentline + 1
        print("Converting line "..currentline)
        line = conversionapi.convert(line)
        print("Result: "..line)
        table.insert(totals, line)
    end
    print("Finished conversion!\nMaking file "..filename.."(RobloxToPoly)...")
    local file = io.open(filename:gsub("%.lua", ' ').."(RobloxToPoly).lua", 'a')
    for nm, line in ipairs(totals) do
        print("Wrote line "..nm)
        if file then file:write(line.."\n") end
    end
    if file then file:close() end
    print("Finished full conversion!")
elseif selection == "E" then
    os.exit(1)
end
