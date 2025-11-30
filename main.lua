local Scripts = {
    ["6035872082"] = {"Rivals", "15617dc4236f8bf6d51dadbbd5bcf6c8", "Key system"},
    ["7219654364"] = {"[DUELS] Murderers VS Sheriffs", "006f0a2825058a63ea26737a3813a4ac", "Key system"},
    ["7326934954"] = {"99 Nights in the Forest", "c11e4962dfb764c574a709ee0dc90435", "Key system"},
    ["4348829796"] = {"Murderers VS Sheriffs DUELS", "98bea62e9b82dd008994f378b139d014", "Key system"},
    ["210851291"] = {"Build A Boat For Treasure", "https://api.junkie-development.de/api/v1/luascripts/public/0b617f68b40fc96c5bfc21832824f80c3a4477919fc8311129efed6f99329509/download", "Keyless"},
    ["8070345443"] = {"Invisible Hide and Seek", "https://api.junkie-development.de/api/v1/luascripts/public/85d34c6e7b3691feed776d071a0ed36c11579ff7795131039d04ba017c703dda/download", "Keyless"},
    ["7823137182"] = {"Hide the body", "https://api.junkie-development.de/api/v1/luascripts/public/93c4f50821e9c8a6c9e09ccde10ef8db5b2ffe58302cc773f9f07edfb54e54c8/download", "Keyless"},
    ["111958650"] = {"Arsenal", "https://api.junkie-development.de/api/v1/luascripts/public/6f6685c814d8af8ad4592c6881f81cf9864db7b9bd4b79e2ab535e2e7a64597a/download", "Keyless"}
}

if game.GameId == 4348829796 then
    if hookfunction and (getcallingscript or (debug and debug.traceback)) then
        local old_wait

        local function isBac()
            if getcallingscript then
                local caller = getcallingscript()
                if caller and caller.Name == "BAC_" then
                    return true
                else
                    if debug.traceback():find("BAC_") then
                        return true
                    end
                end
            elseif debug.traceback():find("BAC_") then
                return true
            end
        end

        old_wait = hookfunction(wait, function(duration)
            if isBac() then
                return old_wait(999999999)
            end
            return old_wait(duration)
        end)

        local old_task_wait
        if task and task.wait then
            old_task_wait = hookfunction(task.wait, function(duration)
                if isBac() then
                    return old_task_wait(999999999)
                end
                return old_task_wait(duration)
            end)
        end

        local old_task_delay
        if task and task.delay then
            old_task_delay = hookfunction(task.delay, function(delayTime, callback)
                if isBac() then
                    return
                end
                return old_task_delay(delayTime, callback)
            end)
        end

        local RunService = game:GetService("RunService")
        local signals = {
            RunService.Heartbeat,
            RunService.Stepped,
            RunService.RenderStepped,
        }

        for _, sig in ipairs(signals) do
            pcall(function()
                if sig and type(sig.Wait) == "function" then
                    local old = hookfunction(sig.Wait, function(self, ...)
                        if isBac() then
                            task.wait(999999999)
                            return
                        end
                        return old(self, ...)
                    end)
                end
            end)
        end

        _G.DisabledAntiCheat = true
    end
end

local WindUI = loadstring(game:HttpGet("https://gist.githubusercontent.com/ekuve/973a997c53c7a73bb549d6afdd1af0cb/raw/5e3851efc951227b09a0b7e4e1f3fdcbaeb6e7aa/Fixed_WindUI.lua"))()

while not game:GetService("Players").LocalPlayer do
    task.wait()
end

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService") 
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local PathfindingService = game:GetService("PathfindingService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera
local WindowClosed = false

local DebrisConnections = {}
local DebrisInstances = {}
local OnCloseFunctions = {}

WindUI:AddTheme({
    Name = "VioletBlue",

    Accent = Color3.fromHex("#6C63FF"), 
    Background = Color3.fromHex("#0D0E1A"), 
    BackgroundTransparency = 0,
    Outline = Color3.fromHex("#8B80F9"), 
    Text = Color3.fromHex("#E0E0FF"), 
    Placeholder = Color3.fromHex("#7070A0"), 
    Button = Color3.fromHex("#3A3A70"), 
    Icon = Color3.fromHex("#9BA5FF"), 
    Hover = Color3.fromHex("#A59EFF"), 
    WindowBackground = Color3.fromHex("#101024"), 
    WindowShadow = Color3.fromHex("#000000"), 

    DialogBackground = Color3.fromHex("#151532"), 
    DialogBackgroundTransparency = 0,
    DialogTitle = Color3.fromHex("#C8C8FF"),
    DialogContent = Color3.fromHex("#B0B0FF"),
    DialogIcon = Color3.fromHex("#A0A8FF"),

    WindowTopbarButtonIcon = Color3.fromHex("#9BA5FF"),
    WindowTopbarTitle = Color3.fromHex("#E0E0FF"),
    WindowTopbarAuthor = Color3.fromHex("#A0A0FF"),
    WindowTopbarIcon = Color3.fromHex("#C5C8FF"),

    TabBackground = Color3.fromHex("#1A1A3A"),
    TabTitle = Color3.fromHex("#E0E0FF"),
    TabIcon = Color3.fromHex("#9BA5FF"),

    ElementBackground = Color3.fromHex("#1E1E40"),
    ElementTitle = Color3.fromHex("#FFFFFF"),
    ElementDesc = Color3.fromHex("#B0B0FF"),
    ElementIcon = Color3.fromHex("#9BA5FF"),

    PopupBackground = Color3.fromHex("#12122A"),
    PopupBackgroundTransparency = 0,
    PopupTitle = Color3.fromHex("#E0E0FF"),
    PopupContent = Color3.fromHex("#B0B0FF"),
    PopupIcon = Color3.fromHex("#A0A8FF"),
})

local Window = WindUI:CreateWindow({
    Title = "Ekuve Hub Loader",
    Icon = "door-open", 
    Author = "by ekuve",
    Folder = "Ekuve hub loader",
    Theme = "VioletBlue",

    ScrollBarEnabled = true,
    HideSearchBar = false,

    Transparent = true,

    User = {
        Enabled = true,
    },
})

Window:EditOpenButton({
    Title = "Ekuve hub loader",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("6C63FF"),
        Color3.fromHex("3AA0FF") 
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:Tag({
    Title = ".gg/ekuve",
    Icon = "geist:logo-discord",
    Color = Color3.fromHex("#7289da"),
    Radius = 10, -- from 0 to 13
})

local Icons = {
    Keyless = "lock-open",
    ["Key system"] = "key-round",
    Paid = "dollar-sign"
}

local Executor = loadstring(game:HttpGet("https://raw.githubusercontent.com/ekuve/ekuvehub/refs/heads/main/key.lua"))()
local function Execute(Data)
    local Url = Data[2]
    local Type = Data[3]

    if Type == "Keyless" then
        loadstring(game:HttpGet(Url))()
    else
        Executor.Execute(Url)
    end
end

local ConfigManager = Window.ConfigManager
local Config = ConfigManager:CreateConfig("EkuveHubLoader")

local function CreateTab(GameId, Data)
    local GameName, ScriptUrl, AccesType = Data[1], Data[2], Data[3]

    local Tab = Window:Tab({
        Title = GameName,
        Icon = Icons[AccesType],
        Locked = false,
    })

    Tab:Button({
        Title = "Execute",
        Callback = function()
            if tostring(game.GameId) == GameId then
                Execute(Data)
            else
                WindUI:Notify({
                    Title = "Script not made for this game",
                    Content = "You are not in the correct game to execute this script.",
                    Icon = "warning"
                })
            end
        end
    })

    local last
    Tab:Toggle({
        Title = "Auto Execute",
        Desc = "Add script to auto exec folder",
        Default = false,
        Flag = "AutoExecute"..GameId,
        Callback = function(Value)
            if Value and last == nil and tostring(game.GameId) == GameId then
                Execute(Data)
            end
            last = Value
        end
    })
    task.delay(0, function()
        last = false
    end)

    return Tab
end

local CurrentGameId = tostring(game.GameId)
if Scripts[CurrentGameId] then
    local Tab = CreateTab(CurrentGameId, Scripts[CurrentGameId])
    Tab:Select()
    Scripts[CurrentGameId] = nil
end

for GameId, Data in pairs(Scripts) do
    CreateTab(GameId, Data)
end

Config:Load()

local Destroyed = false
Window:OnDestroy(function()
    Destroyed = true
end)

while task.wait(0.5) and not Destroyed do
    Config:Save()
end
