if game.placeId ~= 0 then
    local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()
    local win = DiscordLib:Window("Templae: jett main#2944")

    --Services
    local UIS = game:GetService('UserInputService')
    local tpService = game:GetService("TeleportService")
    local Http = game:GetService("HttpService")
    local players = game:GetService("Players")
    local workspace = game:GetService("Workspace")
    local runService = game:GetService("RunService")
    local lightingService = game:GetService("Lighting")

    --Variables
    local player = players.LocalPlayer
    local mouse = player:GetMouse()
    local placeId= game.PlaceId
    local char = player.Character
    local Api = "https://games.roblox.com/v1/games/"
    local humRootPart = char.HumanoidRootPart

    --Functions
    local function sendNotification(title,text,icon,dur)
        game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Icon = icon,
        Dur = dur})   
    end

     --UNI
     local Universal = win:Server("Universal", "")
     --Universal Channel
     local uni = Universal:Channel("Usefull")
         --FPS Cap
         local fpsSlider = uni:Slider("Custom FPS", 1, 1000, 240, function(fps)
            setfpscap(fps)
         end)
         uni:Seperator()
         
         --Small Server Finder
         uni:Button("Smallest Server Join", function()
             sendNotification(" Locating all servers!","Please wait...",'','3')
             local servers = Api..placeId.."/servers/Public?sortOrder=Asc&limit=100"
             function ListServers(cursor)
             local Raw = game:HttpGet(servers .. ((cursor and "&cursor="..cursor) or ""))
             return Http:JSONDecode(Raw)
             end
 
             local Server, Next; repeat
             local Servers = ListServers(Next)
             Server = Servers.data[1]
             Next = Servers.nextPageCursor
             until Server
             sendNotification("Found Smallest Server!","Teleporting please wait...",'','3')
             task.wait(2)
 
             tpService:TeleportToPlaceInstance(placeId,Server.id,game.Players.LocalPlayer)
         end)
         uni:Seperator()
         
         --ANTI-AFK Script
         uni:Button("Anti-AFK", function()
            sendNotification("AFK Disabled","You will not be kicked after 20 min!","",3)
             for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
                 v:Disable()
             end
         end)
         uni:Seperator()
         
         --Rejoin Script
         uni:Button("Rejoin", function()
             sendNotification("Rejoining","Please wait...",'','7')
             task.wait(2)
             tpService:Teleport(placeId, player)
         end)
         uni:Seperator()
         
         --Enable Shift Lock
         uni:Button("Enable Shift Lock", "Exactly what the title says", function()
             sendNotification(" Sucess!","Shift Lock enabled.",'',3)
             player.DevEnableMouseLock = true
         end)
         uni:Seperator()

         -- Full Bright
         getgenv().fbToggled = false
         uni:Toggle("Full Bright",false, function(state)
            if state then
                sendNotification("Full Bight ON","Never be afraid again!",icon,2)
            else
                sendNotification("Full Bight OFF","Watch the dark!",icon,2)
            end
            getgenv().fbToggled = state
         end)
         lightingService.LightingChanged:Connect(function()
             if getgenv().fbToggled then
                 lightingService.Ambient = Color3.new(1, 1, 1)
                 lightingService.ColorShift_Bottom = Color3.new(1, 1, 1)
                 lightingService.ColorShift_Top = Color3.new(1, 1, 1)
             end
         end)

    local uni = Universal:Channel("Useless")
        --Copy PlaceId
        uni:Button("Copy PlaceId", function()
            sendNotification(" Sucess!","GameID copied to clipboard.",'','3')
            setclipboard(tostring(placeId))
        end)
        uni:Seperator()
        
        --Kick
        uni:Button("Kick ME", function()
            sendNotification("Kicking...","Please wait...",'','1')
            task.wait(0.5)
            player:Kick("Kicked!")
        end)
 end
