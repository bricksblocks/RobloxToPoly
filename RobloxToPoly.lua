print("Terminal Random ID: "..math.random(1,10000).."\nWelcome to ROBLOX to Polytoria (v0.0.8).\nThis is a Luau -> Polytoria Lua converter.\nInput file name:")
local filename = io.read("*l")
local file = nil
local res, err = pcall(function()
    print("Opening file...\nType 'S' to start conversion, or type 'E' to end program.")
    local selection = io.read("*l")
    if selection == "S" then
        print("Starting conversion.")
        local currentline = 0
        local totals = {}
        for line, nm in io.lines(filename) do
            currentline = currentline + 1
            print("Converting line "..currentline)
            line = line:gsub("Instance%.new", "Instance.New")
            line = line:gsub("Vector3%.new", "Vector3.New")
            line = line:gsub("'Script'", "'ScriptInstance'")
            line = line:gsub("'ScreenGui'", "'GUI'")
            line = line:gsub("'Frame'", "'UIView'")
            line = line:gsub("'ImageLabel'", "'UIImage'")
            line = line:gsub("HttpService", "Http")
            line = line:gsub("ImageId", "ImageID")
            line = line:gsub("CastShadow", "CastShadows")
            line = line:gsub("RunService%.RenderStepped", "game.Rendered")
            line = line:gsub("'RemoteEvent'", "'Event'")
            line = line:gsub("'UserInputService'", "'Input'")
            line = line:gsub("%W.CFrame = CFrame.lookAt(%W, %W)", "%1:LookAt(%1, %2)")
            line = line:gsub("'TextButton'", "'UIButton'")
            line = line:gsub("'Script'", "'ScriptInstance'")
            line = line:gsub("Color3%.new(%d+,.%d+,.%d+)", "Color.New(%1, %2, %3)")
            line = line:gsub("workspace", "game['Environment']")
            line = line:gsub("game%.Players", "Players")
            line = line:gsub("DataStoreService", "Datastore")
            line = line:gsub("ServerScriptService", "ScriptService")
            line = line:gsub("game%.PlaceId", "game.GameID")
            line = line:gsub("CFrame%.new(%d+,.%d+,.%d+)", "Vector3%.New(%1, %2, %3)")
            line = line:gsub("CFrame%.Angles(%d+,.%d+,.%d+)", "Vector3%.Angles(%1, %2, %3)")
            line = line:gsub("%.Rotation .= CFrame%.Angles(%W,.%W,.%W)", ":MoveRotation(Vector3.New(%1, %2, %3))")
            print("Result: "..line)
            table.insert(totals, line)
        end
        print("Finished conversion!\nMaking file "..filename.."(robloxToPoly)...")
        local file = io.open(filename:gsub("%.lua", ' ').."(robloxToPoly).lua", 'a')
        for _, line in ipairs(totals) do
            print("Wrote line...")
            if file then file:write(line.."\n") end
        end
        if file then file:close() end
        print("Finished full conversion!")
    elseif selection == "E" then
        os.exit(1)
    end
end)
