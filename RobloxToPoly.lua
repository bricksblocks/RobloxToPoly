print("Welcome to ROBLOX to Polytoria (v0.0.5).\nThis is a Luau -> Polytoria Lua converter.\nInput file name:")
local filename = io.read("*l")
local file = nil
local res, err = pcall(function()
    print("Opening file...\nType 'START' to start conversion, type 'STOP' to end program.")
    local selection = io.read("*l")
    if selection == "START" then
        print("Starting conversion.")
        local currentline = 0
        local totals = {}
        for line, nm in io.lines(filename) do
            currentline = currentline + 1
            print("Converting line "..currentline)
            line = line:gsub("Instance.new", "Instance.New")
            line = line:gsub("'Script'", "'ScriptInstance'")
            line = line:gsub("Vector3.new", "Vector3.New")
            line = line:gsub("Color3.new(%W,.%W,.%W)", "Color.New(%1, %2, %3)")
            line = line:gsub("Color3", "Color")
            line = line:gsub("workspace", "game['Environment']")
            line = line:gsub("game.PlaceId", "game.GameID")
            line = line:gsub("CFrame\\.new(%W,.%W,.%W)", "Vector3\\.New(%1, %2, %3)")
            line = line:gsub("CFrame\\.Angles(%W,.%W,.%W)", "Vector3\\.Angles(%1, %2, %3)")
            line = line:gsub("\\.%W\\.", "[%1]")
            line = line:gsub("\\.Rotation .= CFrame\\.Angles(%W,.%W,.%W)", ":MoveRotation(Vector3.New(%1, %2, %3))")
            line = line:gsub(":%s*[%w_%.]+", "")
            table.insert(totals, line)
        end
        print("Finished conversion!\nMaking file "..filename.."(robloxToPoly)...")
        local file = io.open(filename:gsub("\\.lua", ' ').."(1).lua", 'a')
        for _, line in ipairs(totals) do
            print("Wrote line...")
            if file then file:write(line.."\n") end
        end
        if file then file:close() end
        print("Finished full conversion!")
    elseif selection == "STOP" then
        os.exit(1)
    end
end)