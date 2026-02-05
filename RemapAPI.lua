local api = {}
function api.convert(from)
    --[[
    this is the main conversion function, this powers the converter.
    ]]
    local line = from
        line = line:gsub("^%s*([%w_%.%[%]]+)%s*%-=%s*(.+)$", "%1 = %1 - %2")
        line = line:gsub("^%s*([%w_%.%[%]]+)%s*%*=%s*(.+)$", "%1 = %1 * %2") -- this converts stuff like -=, += *= to 1 = 1 * 2, whatever
        line = line:gsub("^%s*([%w_%.%[%]]+)%s*%+=%s*(.+)$", "%1 = %1 + %2")
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
        line = line:gsub("task%.wait", "wait")
        line = line:gsub("'UserInputService'", "'Input'")
        line = line:gsub("%W.CFrame = CFrame.lookAt(%W, %W)", "%1:LookAt(%1, %2)")
        line = line:gsub("'TextButton'", "'UIButton'")
        line = line:gsub("'Script'", "'ScriptInstance'")
        line = line:gsub("Humanoid", "--[[Humanoids are not supported in Polytoria.]]")
        line = line:gsub("PathfindingService", "--[[Pathfinding is not supported in Polytoria]]")
        line = line:gsub("MarketplaceService", "--[[Marketplace services are not supported in Polytoria]]")
        line = line:gsub("Color3%.new(%d+,.%d+,.%d+)", "Color.New(%1, %2, %3)")
        line = line:gsub("workspace", "game['Environment']")
        line = line:gsub("game%.Players", "Players")
        line = line:gsub("DataStoreService", "Datastore")
        line = line:gsub("ServerScriptService", "ScriptService")
        line = line:gsub("game%.PlaceId", "game.GameID")
        line = line:gsub("CFrame%.new(%d+,.%d+,.%d+)", "Vector3.New(%1, %2, %3)")
        line = line:gsub("CFrame%.Angles(%d+,.%d+,.%d+)", "Vector3%.Angles(%1, %2, %3)")
        line = line:gsub("%.Rotation .= CFrame%.Angles(%W,.%W,.%W)", ":MoveRotation(Vector3.New(%1, %2, %3))")
    return line
end
return api
