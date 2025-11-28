-- Do not take direct loadingstring from here or script may be updated.

local PlaceId = game.PlaceId

local Scripts = {
  17625359962 = "https://api.junkie-development.de/api/v1/luascripts/public/01b9c60ff53f840fb80c41ac603e78d78db6f812e965677367991d411bb2438a/download",
  135856908115931 = "https://api.junkie-development.de/api/v1/luascripts/public/8b89e68ae4f88d8869c9aee1820ea110fb331f5d1d843c93b8c6dcd38c25097b/download",
  79546208627805 = "https://api.junkie-development.de/api/v1/luascripts/public/840287e5b73e8760b4336d5338ec08ddb37c3c7d92e02535d9ce90a20ab09eaa/download",
  12355337193 = "https://api.junkie-development.de/api/v1/luascripts/public/cc7eecf4c4c192df914af936cbdd7f4ee0828398770a1b29feb8c67ac863393b/download",
  537413528 = "https://api.junkie-development.de/api/v1/luascripts/public/0b617f68b40fc96c5bfc21832824f80c3a4477919fc8311129efed6f99329509/download",
  97479046766439 = "https://api.junkie-development.de/api/v1/luascripts/public/85d34c6e7b3691feed776d071a0ed36c11579ff7795131039d04ba017c703dda/download",
  81239378558719 = "https://api.junkie-development.de/api/v1/luascripts/public/93c4f50821e9c8a6c9e09ccde10ef8db5b2ffe58302cc773f9f07edfb54e54c8/download",
  286090429 = "https://api.junkie-development.de/api/v1/luascripts/public/6f6685c814d8af8ad4592c6881f81cf9864db7b9bd4b79e2ab535e2e7a64597a/download"
}

if Scripts[PlaceId] then
  getgenv().LoadedFromHub = true
  loadstring(game:HttpGet(Scripts[PlaceId]))()
else
  setclipboard("https://discord.gg/ekuve")
  game:GetService("StarterGui"):SetCore("SendNotification", {
  	Title = "Game not supported";
  	Text = "You can add it to suggestion in our discord (copied to clipboard).";
  	Duration = 10;
  })
end
