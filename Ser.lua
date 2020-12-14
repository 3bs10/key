
local Tunnel = module("lib/Tunnel")
local Proxy = module("lib/Proxy")
local SendWeb = module("vrp", "Settings")
DontChange = {}
vRP = Proxy.getInterface("vRP")
RSCclient = Tunnel.getInterface("vrp_names","vrp_names")
vRPclient = Tunnel.getInterface("vRP",GetCurrentResourceName())
vRPbm = {}
BMclient = Tunnel.getInterface(GetCurrentResourceName(),GetCurrentResourceName())
PRICE = 100
playersToCall = {}

--==================================
    -- KEY CANCEL EMOTES
--==================================
RegisterServerEvent('CancelEmotes')
AddEventHandler('CancelEmotes', function()
  vRPclient.stopAnim(source,{false})
end)

--==================================
    -- TAKE HOSTAGE
--==================================
RegisterServerEvent('RAR:sync')
AddEventHandler('RAR:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('RAR:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('RAR:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('RAR:stop')
AddEventHandler('RAR:stop', function(targetSrc)
	TriggerClientEvent('RAR:cl_stop', targetSrc)
end)

--==================================
    -- CARRY
--==================================
RegisterServerEvent('CarryPeople:sync')
AddEventHandler('CarryPeople:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	TriggerClientEvent('CarryPeople:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
	TriggerClientEvent('CarryPeople:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('CarryPeople:stop')
AddEventHandler('CarryPeople:stop', function(targetSrc)
	TriggerClientEvent('CarryPeople:cl_stop', targetSrc)
end)

--==================================
    -- HEAL PLAYER
--==================================
RegisterServerEvent('RAR:checkmoney')
AddEventHandler('RAR:checkmoney', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if(user_id)then
        if vRP.tryPayment({user_id,xRAR.HealRP.Price}) then
          TriggerClientEvent('RAR:Heal', source)
          TriggerClientEvent("RAR:Notify", player, {type = "alert", text = "لقد دفعت "..xRAR.HealRP.Price.." من اجل العلاج",
              photo = "https://image.flaticon.com/icons/svg/190/190411.svg",
               color = "rgba(91, 212, 159, 0.8)",
                colortext = "#fff"
               }) 
        else
          TriggerClientEvent("RAR:Notify", source, {type = "alert", text = "ليس لديك المال المطلوب للعلاج",
              photo = "https://image.flaticon.com/icons/svg/190/190406.svg",
               color = "rgba(179, 34, 27, 0.8)",
                colortext = "white"
               }) 
        end
    end
end)

--==================================
    -- COLOR WP
--==================================
local function wc1(player)
	TriggerClientEvent("setWColor",player,{1})
end
	
local function wc2(player)
	TriggerClientEvent("setWColor",player,{2})
end

local function wc3(player)
	TriggerClientEvent("setWColor",player,{3})
end

local function wc4(player)
	TriggerClientEvent("setWColor",player,{4})
end

local function wc5(player)
	TriggerClientEvent("setWColor",player,{5})
end

local function wc6(player)
	TriggerClientEvent("setWColor",player,{6})
end

local function wc7(player)
	TriggerClientEvent("setWColor",player,{7})
end

local function wc8(player)
	TriggerClientEvent("AddSkin",player)
end

local function wc0(player)
	TriggerClientEvent("setWColor",player,{0})
end


local function wa1(player)
	TriggerClientEvent("AddFlash",player)
end

local function wa2(player)
	TriggerClientEvent("AddSupp",player)
end

local function wa3(player)
	TriggerClientEvent("Addgrip",player)
end

local function wa4(player)
	TriggerClientEvent("AddExtendedClip",player)
end

local function wa5(player)
	TriggerClientEvent("AddScope",player)
end

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if xRAR.ColorWP.Stute then
		if vRP.hasPermission({user_id,""..xRAR.ColorWP.Percolor..""}) then
			choices["الوان الاسلحة"] = {
				function(player,choice)
					vRP.buildMenu({"wcolor", {player = player}, 
						function(menu)
							menu.name = "الوان الاسلحة"
							menu["! RESET"] = {wc0,"اعاده ضبط اللون"}
							menu["Color 1"] = {wc1,"<img src='"..xRAR.ColorWP.picture.Color1.."' /><br/>"}
							menu["Color 2"] = {wc2,"<img src='"..xRAR.ColorWP.picture.Color2.."' /><br/>"}
							menu["Color 3"] = {wc3,"<img src='"..xRAR.ColorWP.picture.Color3.."' /><br/>"}
							menu["Color 4"] = {wc4,"<img src='"..xRAR.ColorWP.picture.Color4.."' /><br/>"}
							menu["Color 5"] = {wc5,"<img src='"..xRAR.ColorWP.picture.Color5.."' /><br/>"}
							menu["Color 6"] = {wc6,"<img src='"..xRAR.ColorWP.picture.Color6.."' /><br/>"}
							menu["Color 7"] = {wc7,"<img src='"..xRAR.ColorWP.picture.Color7.."' /><br/>"}
							menu["سكن سلاح"] = {wc8,"<img src='"..xRAR.ColorWP.picture.Color8.."' /><br/>"}
							vRP.openMenu({player,menu})
						end
					})
				end
			, "لتغيير لون اسلحتك"}
		end

		if vRP.hasPermission({user_id,""..xRAR.ColorWP.Permadd..""}) then
			choices["اضافات الأسلحة"] = {
				function(player,choice)
					vRP.buildMenu({"wadds", {player = player}, 
						function(menu)
							menu.name = "اضافات الأسلحة"
							menu["ضوء"] = {wa1,"<img src='"..xRAR.ColorWP.picturetools.Light.."' /><br/>"}
							menu["كاتم للصوت"] = {wa2,"<img src='"..xRAR.ColorWP.picturetools.Silencer.."' /><br/>"}
							menu["مقبض متطور"] = {wa3,"<img src='"..xRAR.ColorWP.picturetools.Handle.."' /><br/>"}
							menu["مخزن اضافي"] = {wa4,"<img src= '"..xRAR.ColorWP.picturetools.Store.."' /><br/>"}
							menu["منظار / سكوب"] = {wa5,"<img src= '"..xRAR.ColorWP.picturetools.Telescope.."' /><br/>"}
							vRP.openMenu({player,menu})
						end
					})
				end
			, "لاضافات الاسلحة وظهورها بشكل جميل"}
		end
	end
		add(choices)
	end
end})

--==================================
    -- CHECK AUTO MSG
--==================================
RegisterServerEvent('RAR:getPlayerIdentifiers')
AddEventHandler('RAR:getPlayerIdentifiers', function()
    if GetPlayerIdentifiers(source) ~= nil then
        TriggerClientEvent('RAR:setPlayerIdentifiers', source, GetPlayerIdentifiers(source))
    end
end)
--==================================
    -- Mention Descord
--==================================
function GetPlayerDiscordMention(player)
  local dis = "غير مرتبط"
  for i=1,5 do
      local den = GetPlayerIdentifier(player,i)
      if den then
          if string.sub(den,1,7) == "discord" then
              return "<@" .. string.sub(den,9) .. ">"
          end
      end
  end
  return dis
end

--==================================
    -- Joining
--==================================
AddEventHandler('playerConnecting', function()
	local last_login_stamp = os.date("%H:%M:%S | %d/%m/%Y")
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
    sendToDiscord("join", "**Player : **" .. GetPlayerName(source) .. "\n**More info : **Connecting To The Server\n**iP : **" .. GetPlayerEndpoint(source) .. "\n**Time : **" .. last_login_stamp .. "", 41767)
end)

AddEventHandler('playerDropped', function(reason)
	local last_login_stamp = os.date("%H:%M:%S | %d/%m/%Y")
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	sendToDiscord2("Left", "**ID : **" .. user_id .. "\n**Name : **" .. GetPlayerName(source) .. "\n**More info : **Disconnected From The Server\n**Reason : **" .. reason .. "\n**iP : **" .. GetPlayerEndpoint(source) .. "\n**Time : **" .. last_login_stamp .. "", 10682368)
end)

--==================================
    -- Left log
--==================================
function sendToDiscord2(name, message, color)
	local connect = {
		  {  
			  ["color"] = color,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
        ["text"] = "Re-Coder 3BS#1111",
        ["icon_url"] = "https://cdn.discordapp.com/attachments/781874652703227937/783136790713729034/126164930_1758946650927756_6261104224839779639_n.jpg"
			  },
		  }
	  }
 PerformHttpRequest(SendWeb.Log.Join, function(err, text, headers) end, 'POST', json.encode({username = "RAR", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/781874652703227937/787852721855266816/logo_2.png"}), { ['Content-Type'] = 'application/json' })
end

--==================================
    -- Join log
--==================================
function sendToDiscord(name, message, color)
	local connect = {
		  {  
			  ["color"] = color,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
        ["text"] = "Re-Coder 3BS#1111",
        ["icon_url"] = "https://cdn.discordapp.com/attachments/781874652703227937/783136790713729034/126164930_1758946650927756_6261104224839779639_n.jpg"
			  },
		  }
	  }
	PerformHttpRequest(SendWeb.Log.Left, function(err, text, headers) end, 'POST', json.encode({username = "RAR", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/781874652703227937/787852721855266816/logo_2.png"}), { ['Content-Type'] = 'application/json' })
end

--==================================
    -- BlackList Wep
--==================================
AddEventHandler("vRP:playerSpawn",
	function (user_id,player)
		if not vRP.hasPermission({user_id,""..xRAR.AntiCheatwep.PermUserBlackList..""}) then
			TriggerClientEvent("RAR:AntiCheat",player)
		end
	end
)

function SendLogDiscord(message)
	local connect = {
		  {  
			  ["color"] = 1621222,
        ["title"] = "**RAR Blacklist WP**",
			  ["description"] = message,
			  ["footer"] = {
			  ["text"] = "Re-Coder 3BS#1111",
			  ["icon_url"] = "https://cdn.discordapp.com/attachments/781874652703227937/783136790713729034/126164930_1758946650927756_6261104224839779639_n.jpg",
			  },
		  }
	  }
	PerformHttpRequest(xRAR.AntiCheatwep.Sendloganti, function(err, text, headers) end, 'POST', json.encode({username = "RAR", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/781874652703227937/787852721855266816/logo_2.png"}), { ['Content-Type'] = 'application/json' })
  end

function SendToAdminsChat(Msg)
    for i,p in pairs(vRP.getUsersByPermission({""..xRAR.AntiCheatwep.PermSentChat..""})) do
        local admin = vRP.getUserSource({p})
        if admin then
            TriggerClientEvent('chatMessage', admin, "^0[^1RAR^0]", {0,0,0}, Msg)
        end
    end
end

function MentionDiscordAntiCheat(player)
    for i=1,5 do
        local den = GetPlayerIdentifier(player,i)
        if den then
            if string.sub(den,1,7) == "discord" then
               return "<@" .. string.sub(den,9) .. ">"
            end
        end
    end
    return "Not Found"
end

RegisterNetEvent("RAR:SendLog")
AddEventHandler("RAR:SendLog",
	function ()
		local user_id = vRP.getUserId({source})
		if user_id ~= nil then
			local PlayerName = GetPlayerName(source)
			local IP = GetPlayerEndpoint(source)
			local identifiers = ""
			for i,p in pairs(GetPlayerIdentifiers(source)) do
				identifiers = identifiers .. p .. "\n"
			end
			SendToAdminsChat("^1" .. PlayerName .. " ^0( ID: ^1" .. user_id .. " ^0) ^3Weapons BlackList Has Been Deleted.")
			SendLogDiscord("**Name : **" .. PlayerName .. "\n**ID : **" .. user_id .. "\n**IP : **" .. IP .. "\n**Discord : **" .. MentionDiscordAntiCheat(source) .. "\n\n ```lua\n" .. identifiers .. "\n```")
		end
	end
)

--==================================
    -- Fix
--==================================
AddEventHandler('chatMessage', function(source, name, msg)
  if xRAR.Fix.Stute then
	if msg == ""..xRAR.Fix.commaneds.."" then
	  local user_id = vRP.getUserId({source})
	  local player = vRP.getUserSource({user_id})
	  if vRP.hasPermission({user_id,""..xRAR.Fix.Prem..""}) then
		CancelEvent();
    TriggerClientEvent('RAR:fix', source);
    else
      TriggerClientEvent("RAR:Aler",player, "error",
      "فشل",
      "لا يمكنك استعمال هذا الكوماند لانه ليس لديك صلاحية",
      3000)
	  end
  end
end
end)

--==================================
    -- HUD
--==================================
RegisterServerEvent("vRP_HealthUI:getData")
AddEventHandler("vRP_HealthUI:getData", function()
    local user_id = vRP.getUserId({source})
    TriggerClientEvent("vRP_HealthUI:returnBasics", source, vRP.getHunger({user_id}), vRP.getThirst({user_id}))
end)


--==================================
    -- SFTI
--==================================
RegisterServerEvent("lvc_TogDfltSrnMuted_s")
AddEventHandler("lvc_TogDfltSrnMuted_s", function(toggle)
	TriggerClientEvent("lvc_TogDfltSrnMuted_c", -1, source, toggle)
end)

RegisterServerEvent("lvc_SetLxSirenState_s")
AddEventHandler("lvc_SetLxSirenState_s", function(newstate)
	TriggerClientEvent("lvc_SetLxSirenState_c", -1, source, newstate)
end)

RegisterServerEvent("lvc_TogPwrcallState_s")
AddEventHandler("lvc_TogPwrcallState_s", function(toggle)
	TriggerClientEvent("lvc_TogPwrcallState_c", -1, source, toggle)
end)

RegisterServerEvent("lvc_SetAirManuState_s")
AddEventHandler("lvc_SetAirManuState_s", function(newstate)
	TriggerClientEvent("lvc_SetAirManuState_c", -1, source, newstate)
end)

RegisterServerEvent("lvc_TogIndicState_s")
AddEventHandler("lvc_TogIndicState_s", function(newstate)
	TriggerClientEvent("lvc_TogIndicState_c", -1, source, newstate)
end)

--==================================
    -- ROB
--==================================

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('es_bank:toofar')
AddEventHandler('es_bank:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_bank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'النشرة الاخبارية', {255, 0, 0}, "تم الغاء السرقة في : ^2" .. xRAR.Shops[robb].nameofbank)
	end
end)

RegisterServerEvent('es_bank:playerdied')
AddEventHandler('es_bank:playerdied', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_bank:playerdiedlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'النشرة الاخبارية', {255, 0, 0}, "تم الغاء السرقة في : ^2" .. xRAR.Shops[robb].nameofbank)
	end
end)

RegisterServerEvent('es_bank:rob')
AddEventHandler('es_bank:rob', function(robb)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  local cops = vRP.getUsersByPermission({""..xRAR.sPolice..""}) -- برميشن العساكر
  if vRP.hasPermission({user_id,""..xRAR.sPolice..""}) then
    TriggerClientEvent("RAR:Aler",player, "error",
    "ملاحظة",
    "انت عسكري لا يمكنك ذلك",
    5000)
  else
    if #cops >= xRAR.Police then -- السرقة ما رح تتم الا اذا هذا العدد من العساكر موجود
	  if xRAR.Shops[robb] then
		  local bank = xRAR.Shops[robb]
		  if (os.time() - bank.lastrobbed) < 600 and bank.lastrobbed ~= 0 then
			  TriggerClientEvent('chatMessage', player, 'ملاحظة', {255, 0, 0}, "يمكنك نهب هذا المكان بعد مرور ^2" .. (1200 - (os.time() - bank.lastrobbed)) .. "^0 ثانية.")
			  return
		  end
		  TriggerClientEvent('chatMessage', -1, 'النشرة الاخبارية', {255, 0, 0}, "تتم السرقة الان في : ^2" .. bank.nameofbank)
		  TriggerClientEvent('chatMessage', player, 'تعليمات', {255, 0, 0}, "لقد بدأت السرقة في : ^2" .. bank.nameofbank .. "")
		  TriggerClientEvent('chatMessage', player, 'تعليمات', {255, 0, 0}, "بعد ^1 5 دقائق ستحصل عل اموالك , في حال وجود شرطة في المكان اهرب !")
		  TriggerClientEvent('es_bank:currentlyrobbing', player, robb)
		  xRAR.Shops[robb].lastrobbed = os.time()
		  robbers[player] = robb
		  local savedSource = player
		  SetTimeout(300000, function()
			  if(robbers[savedSource])then
				  if(user_id)then
					  vRP.giveInventoryItem({user_id,"dirty_money",bank.reward,true})
					  TriggerClientEvent('chatMessage', -1, 'النشرة الاخبارية', {255, 0, 0}, "نجحت السرقة في: ^2" .. bank.nameofbank .. "^0!")
					  TriggerClientEvent('es_bank:robberycomplete', savedSource, bank.reward)
				  end
			  end
		  end)		
	  end
    else
      TriggerClientEvent("RAR:Aler",player, "error",
      "فشل",
      "ليس هناك عدد كافي من العساكر",
      5000)
    end
	end
end)

--==================================
    -- Ask ID 
--==================================
local function AskID(player)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRPclient.getNearestPlayer(player,{10},
			function (nplayer)
				local nuser_id = vRP.getUserId({nplayer})
				if nuser_id ~= nil then	
					vRP.request({nplayer,"هل تريد اعطاء الهوية؟",60,
						function (v,ok)
							if ok then
								TriggerClientEvent("RAR:Aler",player, "done",
								"هوية المواطن",
								""..vRP.getUserGroupByType({nuser_id,"job"}).." : الوظيفة <br/>"..nuser_id.." : رقم الهوية <br/>"..GetPlayerName(nplayer).." الاسم",
								5000)
							else
								TriggerClientEvent("RAR:Aler",player, "error",
								"رفض الهوية",
								"المواطن قام برفض الهوية",
								5000)
							end
						end
					})
				end
			end
		)
	end
end





local function showMyID(player)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		TriggerClientEvent("RAR:Aler",player, "done",
		"هويتك",
		""..vRP.getUserGroupByType({user_id,"job"}).." : الوظيفة <br/>"..user_id.." : رقم الهوية <br/>"..GetPlayerName(player).." الاسم",
		5000)

	end
end

if xRAR.AllCommaneds.AskId.Stute then
RegisterCommand(""..xRAR.AllCommaneds.AskId.CommandShow.."",function(player, args, rawCommand)
	showMyID(player)
   end)
   RegisterCommand(""..xRAR.AllCommaneds.AskId.CommandAsk.."",function(player, args, rawCommand)
    AskID(player)
     end)
end
--==================================
    -- Keys Hack
--==================================
RegisterServerEvent("RAR:Key")
AddEventHandler("RAR:Key", function(Key)
  local user_id = vRP.getUserId({source})
  DisRSERVER(SendWeb.Log.Keys,
  "Blacklist Keys",
  "• | **ID : **" ..user_id.."\n• | **NAME : **"..GetPlayerName(source).."\n• | **KEY : **``"..Key.."``\n• | **DISCORD : **"..GetPlayerDiscordMention(source).."\n• | **LICENSE : **"..GetPlayerIdentifier(source).."\n• | **IP : **"..GetPlayerEndpoint(source))
end)

--==================================
    -- cPanel Admin
--==================================
function SendMsgAdmin(admin,namelog, color)
  local discord = GetPlayerDiscordMention({source})
  local connect = {
        {
            ["color"] = color,
            ["title"] = namelog,
            fields = {
                {
                    name = "**ايدي الادمن**",
                    value = ""..admin.."",
                    inline = true
                },

            },
            ["footer"] = {
                ["text"] = "Made by 3BS#1111 | Time [ " .. os.date("%x | %X") .. " ]",
                ["icon_url"] = ""
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/785033767928594492/ii8gxOR4HSZGxfGOTbevss5uvyzScPkwnYCwE8Ty0Jek8qTcd9XOsPXxSsW6--qOSf4j", function(err, text, headers) end, 'POST', json.encode({username = "#System", embeds = connect, avatar_url = "https://d.top4top.io/p_1536y4uyq1.png"}), { ['Content-Type'] = 'application/json' })
  end

  local function adminjoin(player,choice)
    local user_id = vRP.getUserId({player})
    local TheSkin = { model = xRAR.cPanel.SetSkin.Skin }
    vRP.request({player,"هل أنت متأكد من تسجيل دخولك؟",20,
    function(player,ok)
        if ok then 
            if vRP.hasGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP1..""}) then
                  vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP1..""})
                  if xRAR.cPanel.HistoryChat then
                  SendMsgAdmin(""..user_id.."","**• ADMIN LOGIN**", 1422343)
                  end
                  if xRAR.cPanel.SetSkin.Stute then
                    vRPclient.setCustomization(player,{TheSkin})
                  end
                  if xRAR.cPanel.HistoryChat then
                  TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^2Admin => "..user_id.." Has Been Join To Administration System")
                  end
                 elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP2..""}) then
                  vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""})
                  if xRAR.cPanel.HistoryChat then
                    SendMsgAdmin(""..user_id.."","**• ADMIN LOGIN**", 1422343)
                    end
                  if xRAR.cPanel.SetSkin.Stute then
                    vRPclient.setCustomization(player,{TheSkin})
                  end
                  if xRAR.cPanel.HistoryChat then
                    TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^2Admin => "..user_id.." Has Been Join To Administration System")
                    end
                elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP3..""}) then
                  vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP3..""})
                  if xRAR.cPanel.HistoryChat then
                    SendMsgAdmin(""..user_id.."","**• ADMIN LOGIN**", 1422343)
                    end
                  if xRAR.cPanel.SetSkin.Stute then
                    vRPclient.setCustomization(player,{TheSkin})
                  end
                  if xRAR.cPanel.HistoryChat then
                    TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^2Admin => "..user_id.." Has Been Join To Administration System")
                    end
                elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP4..""}) then
                  vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP4..""})
                  if xRAR.cPanel.HistoryChat then
                    SendMsgAdmin(""..user_id.."","**• ADMIN LOGIN**", 1422343)
                    end
                  if xRAR.cPanel.SetSkin.Stute then
                    vRPclient.setCustomization(player,{TheSkin})
                  end
                  if xRAR.cPanel.HistoryChat then
                    TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^2Admin => "..user_id.." Has Been Join To Administration System")
                    end
                elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP5..""}) then
                  vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP5..""})
                  if xRAR.cPanel.HistoryChat then
                    SendMsgAdmin(""..user_id.."","**• ADMIN LOGIN**", 1422343)
                    end
                  if xRAR.cPanel.SetSkin.Stute then
                    vRPclient.setCustomization(player,{TheSkin})
                  end
                  if xRAR.cPanel.HistoryChat then
                    TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^2Admin => "..user_id.." Has Been Join To Administration System")
                    end
                elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP6..""}) then
                  vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP6..""})
                  if xRAR.cPanel.HistoryChat then
                    SendMsgAdmin(""..user_id.."","**• ADMIN LOGIN**", 1422343)
                    end
                  if xRAR.cPanel.SetSkin.Stute then
                    vRPclient.setCustomization(player,{TheSkin})
                  end
                  if xRAR.cPanel.HistoryChat then
                    TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^2Admin => "..user_id.." Has Been Join To Administration System")
                    end
                elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP7..""}) then
                  vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP7..""})
                  if xRAR.cPanel.HistoryChat then
                    SendMsgAdmin(""..user_id.."","**• ADMIN LOGIN**", 1422343)
                    end
                  if xRAR.cPanel.SetSkin.Stute then
                    vRPclient.setCustomization(player,{TheSkin})
                  end
                  if xRAR.cPanel.HistoryChat then
                    TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^2Admin => "..user_id.." Has Been Join To Administration System")
                    end
                elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP8..""}) then
                  vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP8..""})
                  if xRAR.cPanel.HistoryChat then
                    SendMsgAdmin(""..user_id.."","**• ADMIN LOGIN**", 1422343)
                    end
                  if xRAR.cPanel.SetSkin.Stute then
                    vRPclient.setCustomization(player,{TheSkin})
                  end
                  if xRAR.cPanel.HistoryChat then
                    TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^2Admin => "..user_id.." Has Been Join To Administration System")
                    end
                elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP9..""}) then
                  vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP9..""})
                  if xRAR.cPanel.HistoryChat then
                    SendMsgAdmin(""..user_id.."","**• ADMIN LOGIN**", 1422343)
                    end
                  if xRAR.cPanel.SetSkin.Stute then
                    vRPclient.setCustomization(player,{TheSkin})
                  end
                  if xRAR.cPanel.HistoryChat then
                    TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^2Admin => "..user_id.." Has Been Join To Administration System")
                    end
                elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP10..""}) then
                  vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP10..""})
                  if xRAR.cPanel.HistoryChat then
                    SendMsgAdmin(""..user_id.."","**• ADMIN LOGIN**", 1422343)
                    end
                  if xRAR.cPanel.SetSkin.Stute then
                    vRPclient.setCustomization(player,{TheSkin})
                  end
                  if xRAR.cPanel.HistoryChat then
                    TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^2Admin => "..user_id.." Has Been Join To Administration System")
                    end
            end
        end
    end})
end

local function adminleft(player,choice)
  local user_id = vRP.getUserId({player})
  vRP.request({player,"هل أنت متأكد من تسجيل خروجك؟",20,
  function(player,ok)
      if ok then 
          if vRP.hasGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP1..""}) then
            vRP.removeUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""})
                vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP1..""})
                if xRAR.cPanel.HistoryDiscord then
                SendMsgAdmin(""..user_id.."","**• ADMIN LEFT**", 14619154)
                end
                if xRAR.cPanel.HistoryChat then
                TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^8Admin => "..user_id.." Has Been Left From Administration System")
                end
               elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""}) then
                vRP.removeUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""})
                vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP2..""})
                if xRAR.cPanel.HistoryDiscord then
                  SendMsgAdmin(""..user_id.."","**• ADMIN LEFT**", 14619154)
                  end
                if xRAR.cPanel.HistoryChat then
                  TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^8Admin => "..user_id.." Has Been Left From Administration System")
                  end
              elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP3..""}) then
                vRP.removeUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""})
                vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP3..""})
                if xRAR.cPanel.HistoryDiscord then
                  SendMsgAdmin(""..user_id.."","**• ADMIN LEFT**", 14619154)
                  end
                if xRAR.cPanel.HistoryChat then
                  TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^8Admin => "..user_id.." Has Been Left From Administration System")
                  end
              elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP4..""}) then
                vRP.removeUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""})
                vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP4..""})
                if xRAR.cPanel.HistoryDiscord then
                  SendMsgAdmin(""..user_id.."","**• ADMIN LEFT**", 14619154)
                  end
                if xRAR.cPanel.HistoryChat then
                  TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^8Admin => "..user_id.." Has Been Left From Administration System")
                  end
              elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP5..""}) then
                vRP.removeUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""})
                vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP5..""})
                SendMsgAdmin(""..user_id.."","**• ADMIN LEFT**", 14619154)
                if xRAR.cPanel.HistoryChat then
                  TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^8Admin => "..user_id.." Has Been Left From Administration System")
                  end
              elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP6..""}) then
                vRP.removeUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""})
                vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP6..""})
                if xRAR.cPanel.HistoryDiscord then
                  SendMsgAdmin(""..user_id.."","**• ADMIN LEFT**", 14619154)
                  end
                if xRAR.cPanel.HistoryChat then
                  TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^8Admin => "..user_id.." Has Been Left From Administration System")
                  end
              elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP7..""}) then
                vRP.removeUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""})
                vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP7..""})
                if xRAR.cPanel.HistoryDiscord then
                  SendMsgAdmin(""..user_id.."","**• ADMIN LEFT**", 14619154)
                  end
                if xRAR.cPanel.HistoryChat then
                  TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^8Admin => "..user_id.." Has Been Left From Administration System")
                  end
              elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP8..""}) then
                vRP.removeUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""})
                vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP8..""})
                if xRAR.cPanel.HistoryDiscord then
                  SendMsgAdmin(""..user_id.."","**• ADMIN LEFT**", 14619154)
                  end
                if xRAR.cPanel.HistoryChat then
                  TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^8Admin => "..user_id.." Has Been Left From Administration System")
                  end
              elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP9..""}) then
                vRP.removeUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""})
                vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP9..""})
                if xRAR.cPanel.HistoryDiscord then
                  SendMsgAdmin(""..user_id.."","**• ADMIN LEFT**", 14619154)
                  end
                if xRAR.cPanel.HistoryChat then
                  TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^8Admin => "..user_id.." Has Been Left From Administration System")
                  end
              elseif vRP.hasGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP10..""}) then
                vRP.removeUserGroup({user_id,""..xRAR.cPanel.GroupBasic.GROUP2..""})
                vRP.addUserGroup({user_id,""..xRAR.cPanel.GroupSpare.GROUP10..""})
                if xRAR.cPanel.HistoryDiscord then
                  SendMsgAdmin(""..user_id.."","**• ADMIN LEFT**", 14619154)
                  end
                if xRAR.cPanel.HistoryChat then
                  TriggerClientEvent('chatMessage', -1, "^7RAR", {0,0,0}, "^8Admin => "..user_id.." Has Been Left From Administration System")
                  end
          end
      end
  end})
end

--==================================
    -- DISCORD CLIENT
--==================================
RegisterServerEvent('vRP:Discord')
AddEventHandler('vRP:Discord', function()
    local user_id = vRP.getUserId({source})
    local faction = vRP.getUserGroupByType({user_id,"job"})
    local name = vRP.getPlayerName({source})
	TriggerClientEvent('vRP:Discord-rich', source, user_id, faction, name)
end)

--==================================
    -- MSG JOIN
--==================================
AddEventHandler('playerConnecting', function()	
  TriggerClientEvent("RAR:Aler",-1, "done",
  "تسجيل دخول",
  "قام بتسجيل دخوله المدينة "..GetPlayerName(source).." المواطن",
  2500)
end)
--==================================
    -- MSG LEFT
--==================================
AddEventHandler('playerDropped', function()
  TriggerClientEvent("RAR:Aler",-1, "error",
  "تسجيل خروج",
  "قام بتسجيل خروجه من المدينة "..GetPlayerName(source).." المواطن",
  2500)
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason)
	if killer == "**Invalid**" then 
		reason = 2
	end
	if reason == 0 then
    TriggerClientEvent("RAR:Aler",-1, "killer",
    "عملية انتحار",
    "قام بالانتحار "..GetPlayerName(source).." المواطن",
    2500)
  elseif reason == 1 then
    --[[
    TriggerClientEvent("RAR:Aler",-1, "killer",
    "!! عمل اجرام",
    " "..killer.." قام بقتل  "..GetPlayerName(source).." المواطن",
    2500)
	else
    TriggerClientEvent("RAR:Aler",-1, "death",
    "تحلل",
    "سيتحلل بعد 5 دقائق "..GetPlayerName(source).." المواطن",
    2500)
    ]]
  else
	end
end)

if xRAR.AllCommaneds.SpownCars.Stute then
RegisterCommand(""..xRAR.AllCommaneds.SpownCars.Command.."",function(source, args, rawCommand)
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrSpownCars..""}) then
    vRP.prompt({user_id,"اسم السيارة","",function(user_id,model)
      if model ~= nil and model ~= "" then 
      TriggerClientEvent("3BS:PARS", source, {time = 1000, text = ".. جاري التحميل"})
      SetTimeout(1000,function ()
        vRPclient.spawnVehicle(source,{model})
        DisRSERVER(SendWeb.Log.Cars,
        "SPOWN CARS",
        "• | **ID : **" ..user_id.."\n• | **NAME CAR : **"..model)
        TriggerClientEvent('RAR:Alert', source, {
          sr = "msg",
          type = 'done',
          text = '   تم بنجاح  ',
          sec = 2500,
          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
          vol = 0.1
        })
      end)
    else
      end
    end})
  else
    TriggerClientEvent("RAR:Aler",source, "error",
    "فشل",
    "لا يمكنك استعمال هذا الكوماند لانه ليس لديك صلاحية",
    3000)
  end
 end)
end
 
function LocationToPlayer(player,choice)
	local user_id = vRP.getUserId({player})
	local money = vRP.getMoney({user_id})
	local toSMS = playersToCall[choice]
	local callingID = vRP.getUserId({toSMS})
	player = player
	toSMS = toSMS
	if money >= PRICE then
		if user_id == callingID then
		else
			if vRP.tryPayment({user_id, PRICE}) then
				vRP.request({toSMS, GetPlayerName(player) .. " موقع", 60, 
					function(v,ok)
						vRPclient.getPosition(player,{},
							function (x,y,z)
								vRPclient.setGPS(toSMS,{x,y})
							end
						)
					end
				})
        TriggerClientEvent('RAR:Alert', player, {
          sr = "msg",
          type = 'error',
          text = '  تم ارسال الموقع بنجاح ',
          sec = 2500,
          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
          vol = 0.3
      })
				vRP.closeMenu({player})
			end
		end
  else
    TriggerClientEvent('RAR:Alert', player, {
      sr = "msg",
      type = 'error',
      text = "ليس لديك نقود لارسال الموقع",
      sec = 2500,
      sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
      vol = 0.2
    })
	end
end

function showPlayers(player,choice)
	users = vRP.getUsers({})
	vRP.buildMenu({"Location", {player = player}, 
		function(menu)
			menu.name = "اللاعبين"
			menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
			menu.onclose = function(player) vRP.closeMenu({player}) end
			myName = tostring(GetPlayerName(player))
			for k, v in pairs(users) do
				playerName = tostring(GetPlayerName(v))
				if(playerName ~= myName)then
					playersToCall[playerName] = v
					menu[playerName] = {LocationToPlayer, "ارسال الموقع"}
				end
			end
			vRP.openMenu({player,menu})
		end
	})
end


function DisRSERVER(linkwebhook, name, message)
	local connect = {
    {  
      ["color"] = SendWeb.Server.ColorLogs,
      ["title"] = "**".. name .."**",
      ["description"] = message,
      ["footer"] = {
        ["text"] = "Re-Coder 3BS#1111",
        ["icon_url"] = "https://cdn.discordapp.com/attachments/781874652703227937/783136790713729034/126164930_1758946650927756_6261104224839779639_n.jpg"
      },
    }
  }
    PerformHttpRequest(linkwebhook,
    function(err, text, headers) end,
    'POST',json.encode({
     username = SendWeb.Server.NServer,
     embeds = connect,
     avatar_url = SendWeb.Server.PServer
    }),
     { ['Content-Type'] = 'application/json' })
  end

--==================================
    -- Admin Messages
--==================================
function sendtoalladmins(player,choice)
    local user_id = vRP.getUserId({player})
    vRP.prompt({player,"الرسالة","",function(player,message)
        if message ~= nil and message ~= "" then
            vRP.request({player,"هل أنت متأكد من ارسال الرسالة لجميع الادمنية؟",60,function(player,ok)
                if ok then

                    local players = {}
                    local users = vRP.getUsers({})
                    for k,v in pairs(users) do
                        local player = vRP.getUserSource({tonumber(k)})
                        if vRP.hasPermission({k,"admin.tickets"}) and player ~= nil then
                            table.insert(players,player)
                        end
                    end
                    for k,v in pairs(players) do
                        TriggerClientEvent('RAR:Alert', v, {
                            sr = "msg",
                            type = 'error',
                            text = message,
                            sec = 10000,
                            sot = "https://cdn.discordapp.com/attachments/658478824375320617/782709237700755496/music_zapsplat_exploring.mp3",
                            vol = 0.2
                          })
                          ----------------------------------------------------
DisRSERVER(SendWeb.Log.SendToAdmin,
  "SEND TO ADMINS",
  "• | **ID : **" ..player.."\n• | **MSG : **"..message)
  ----------------------------------------------------
                    end
                else
                    
                end
            end})
        end
    end})
end

--==================================
    -- Tp All Admins
--==================================
function tpalladmins(player,choice)
    local user_id = vRP.getUserId({player})
    vRP.request({player,"هل انت متأكد من سحب جميع الادمنية؟",60,function(player,ok)
        if ok then
            TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'info',
                text = "تم سحب جميع الاداريين بنجاح",
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                vol = 0.1
              })
                                        ----------------------------------------------------
vRPclient.getPosition(player, {}, function(x,y,z)
DisRSERVER(SendWeb.Log.TpAllAdmins,
"TP ALL ADMINS",
"• | **ID : **" ..player.."\n• | **COORDS : **"..x..","..y..","..z.."")
end)
----------------------------------------------------
            local players = {}
            local users = vRP.getUsers({})
            for k,v in pairs(users) do 
                local player = vRP.getUserSource({tonumber(k)})
                if vRP.hasPermission({k,"admin.tickets"}) and player ~= nil then
                    table.insert(players,player)
                end
            end
            vRPclient.getPosition(player,{},function(x,y,z)
                for k,v in pairs(players) do
                    vRPclient.teleport(v,{x,y,z})
                end
                local coords = x,y,z
            end)
        end
    end})
end
--==================================
    -- Players Message
--==================================
function sendtoallplayers(player,choice)
    local user_id = vRP.getUserId({player})
    vRP.prompt({player,"الرسالة:","",function(player,message)
        if message ~= nil and message ~= "" then
            vRP.request({player,"هل أنت متأكد من ارسال الرسالة لجميع اللاعبين؟",60,function(player,ok)
                if ok then
                    local players = {}
                    local users = vRP.getUsers({})
                    for k,v in pairs(users) do
                        local player = vRP.getUserSource({tonumber(k)})
                        if vRP.hasPermission({k,"player.phone"}) and player ~= nil then
                            table.insert(players,player)
                        end
                    end
                    for k,v in pairs(players) do
                        TriggerClientEvent('RAR:Alert', v, {
                            sr = "msg",
                            type = 'info',
                            text = message,
                            sec = 10000,
                            sot = "https://cdn.discordapp.com/attachments/658478824375320617/782712444442116146/Cinematic_Winter_Logo_Music.wav",
                            vol = 0.2
                          })
DisRSERVER(SendWeb.Log.SendToAll,
"SEND TO ALL",
"• | **ID : **" ..player.."\n• | **MSG : **"..message)
                    end
                else
                    
                end
            end})
        end
    end})
end
--==================================
    -- Check Player Group
--==================================
function checkplayergroups(player,choice)
    local user_id = vRP.getUserId({player})
    vRP.prompt({player,"ايدي اللاعب","",function(player,id)
        id = parseInt(id)
        if not vRP.hasPermission({id,"cantbe.checked"}) then
            local id_source = vRP.getUserSource({id})
            local id_groups = vRP.getUserGroups({id})
            list = ""
            for k,v in pairs(id_groups) do
                list = list.. "" ..k.. "<br>"
            end
            DisRSERVER(SendWeb.Log.CheckGroups,
            "CHECK GROUPS",
            "• | **ID : **" ..player.."\n• | **Check Groups : **"..id.."\n• | **GROUPS PLAYER : **\n```"..list.."```")
            TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'info',
                text = ""..list.."",
                sec = 5000,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                vol = 0.1
              })
        elseif vRP.hasPermission({id,"cantbe.checked"}) then
           -- TriggerClientEvent("3BS:SendMessage",player,{text = "<span style='color:white;text-align: center;font-weight: 900'><h1><img src='"..ph.."' width='70' height='70'><br/><h1>!! خطأ <br/> <h3>لا يمكنك الاستعلام عن رتب اداري</span>",type = "info",timeout = (3000),layout = "centerright",theme = "gta",modal = false, animation = {open = "gta_effects_open",close = "gta_effects_close"}})
        end
    end})
end


--==================================
    -- StopChat
--==================================
disabled = false

function disablechat(player,choice)
    local user_id = vRP.getUserId({player})
    disabled = not disabled
    if disabled then
        vRP.request({player,"هل أنت متأكد من ايقاف الشات؟",60,function(player,ok)
            if ok then
              DisRSERVER(SendWeb.Log.StopChat,
              "STOP CHAT",
              "• | **ID : **" ..player)
                --SendDiscordAll("[AE] STOP CHAT ⚡️","⭐️ | **ID ADMIN : **"..user_id.."\n⭐️ | **NAME ADMIN : **"..GetPlayerName(player).."", 12714239) 
               TriggerClientEvent("RAR:Notify", player, {type = "alert", text = "تم ايقاف الشات مؤقتا",
               photo = "https://cdn.discordapp.com/attachments/694414844925051000/778220218346373140/chat.svg",
                color = "#20b6f6",
                 colortext = "white"
                }) 
            end
        end})
    else
        TriggerClientEvent("RAR:Notify", -1, {type = "alert", text = "تم اعادة تشغيل الشات",
        photo = "https://cdn.discordapp.com/attachments/694414844925051000/778218469245059082/shield_2.svg",
         color = "#00aa63",
          colortext = "white"
         }) 
    end
end
AddEventHandler('chatMessage', function(Source, Name, Msg)
    local pid = vRP.getUserId({Source})
    if Msg then 
        if disabled == true then
            if not vRP.hasPermission({pid,""..SendWeb.InfoAdmin.PrTpToMeAllAdmins..""}) then
                TriggerClientEvent("RAR:Notify", pid, {type = "alert", text = "لا يمكنك الارسال !! الشات متوقف",
   photo = "https://cdn.discordapp.com/attachments/694414844925051000/778233513991340062/megaphone_1.svg",
    color = "#a83d54",
     colortext = "white"
    })
             --   TriggerClientEvent("3BS:SendMessage",Source,{text = "<span style='color:white;text-align: center;font-weight: 900'><h1><img src='"..ph.."' width='70' height='70'><br/><h1>!! الشات</span>",type = "info",timeout = (2000),layout = "centerright",theme = "gta",modal = false, animation = {open = "gta_effects_open",close = "gta_effects_close"}})
              --  TriggerClientEvent("3BS:SendMessage",Source,{text = "<span style='color:white;font-weight: 900';>الشات مغلق لا يمكنك الارسال</span>",type = "error",timeout = (2000),layout = "centerright",theme = "metroui",modal = false, animation = {open = "gta_effects_open_left",close = "gta_effects_close_left"},sounds = {sources = {""..musicmsg..""},volume = volmusic,conditions = {"docVisible"}}})
                CancelEvent()
            elseif vRP.hasPermission({pid,""..SendWeb.InfoAdmin.PrTpToMeAllAdmins..""}) then
                return
            end
        elseif disabled == false then
            return
        end
    end
end)
--==================================
    -- Mute Chat
--==================================
muted = {}
muteminute = {}
function muteplayer(player,choice)
    local user_id = vRP.getUserId({player})
    vRP.prompt({player,"ايدي اللاعب","",function(player,id)
        id = parseInt(id)
        local id_source = vRP.getUserSource({id})
        if id ~= nil then
            if muted[id_source] == nil then
                vRP.prompt({player,"مدة الميوت بالدقايق:","",function(player,mutetime)
                    if mutetime ~= nil and mutetime ~= "" then
                        muteminute[id_source] = mutetime
                        muted[id_source] = true
                        DisRSERVER(SendWeb.Log.PlayerMuteChat,
                        "MUTE CHAT",
                        "• | **ID : **" ..player.."\n• | **MUTE : **"..id.."\n• | **TIME : **"..mutetime)
                        --SendDiscordAll("[AE] MUTE CHAT ⚡️","⭐️ | **ID ADMIN : **"..user_id.."\n⭐️ | **NAME ADMIN : **"..GetPlayerName(player).."\n⭐️ | **MUTE PLAYER : **"..id.."\n⭐️ | **MUTE TIME : **"..mutetime.."", 12714239) 
                        TriggerClientEvent('RAR:Alert', id_source, {
                            sr = "msg",
                            type = 'error',
                            text = '   Admin => '..user_id..' Give u Mute : '..mutetime..' =) GG  ',
                            sec = 5000,
                            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                            vol = 0.3
                          })
                        TriggerClientEvent('chatMessage',-1, "^8[System] : ^7["..user_id.."] "..GetPlayerName(player).." Muted : ["..id.."] "..GetPlayerName(id_source).." For : "..mutetime.."")
                        SetTimeout(mutetime*60000,function()
                            muted[id_source] = nil
                            TriggerClientEvent('RAR:Alert', id_source, {
                                sr = "msg",
                                type = 'done',
                                text = '   تم انتهاء مدة الميوت يرجى الالتزام بالقوانين  ',
                                sec = 5000,
                                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                                vol = 0.1
                              })
                        end)
                    end
                end})
            else
                TriggerClientEvent('RAR:Alert', player, {
                    sr = "msg",
                    type = 'error',
                    text = '   يوجد ميوت على هذا اللاعب بالفعل  ',
                    sec = 5000,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                    vol = 0.3
                  })
            end
        end
    end})
end
--==================================
    -- UnMute
--==================================
function unmuteplayer(player,choice)
    local user_id = vRP.getUserId({player})
    vRP.prompt({player,"ايدي اللاعب","",function(player,id)
        id = parseInt(id)
        local id_source = vRP.getUserSource({id})
        if id ~= nil then
            if muted[id_source] == true then
                muted[id_source] = nil
                TriggerClientEvent('RAR:Alert', player, {
                    sr = "msg",
                    type = 'done',
                    text = '   تم فك الميوت عن اللاعب بنجاح  ',
                    sec = 3000,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                    vol = 0.1
                  })
                  TriggerClientEvent('RAR:Alert', id_source, {
                    sr = "msg",
                    type = 'done',
                    text = '   تم فك الميوت عنك  ',
                    sec = 3000,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                    vol = 0.1
                  })
                  DisRSERVER(SendWeb.Log.PlayerUNMuteChat,
                  "UNMUTE CHAT",
                  "• | **ID : **" ..player.."\n• | **UNMUTE : **"..id)
                TriggerClientEvent('chatMessage',-1, "^8[System]: ^7["..user_id.."]"..GetPlayerName(player).." UnMuted : "..GetPlayerName(id_source).." ["..id.."] ")
            elseif muted[id_source] == nil then
                TriggerClientEvent('RAR:Alert', player, {
                    sr = "msg",
                    type = 'error',
                    text = '   لا يوجد ميوت على هذا اللاعب  ',
                    sec = 2500,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                    vol = 0.3
                  })
            end
        end
    end})
end

AddEventHandler('chatMessage', function(Source, Name, Msg)
    local pid = vRP.getUserId({Source})
    if Msg then 
        if muted[Source] == true then
            TriggerClientEvent("RAR:Notify", pid, {type = "alert", text = "نعتذر : انت ممنوع من الشات",
            photo = "https://cdn.discordapp.com/attachments/694414844925051000/778234431353258015/mute.svg",
             color = "#ff9f00",
              colortext = "white"
             })
            CancelEvent()
        elseif muted[Source] == nil then
            return
        end
    end
end)

--==================================
    -- CLEAR CHAT
--==================================
function clearchat(player)
    local user_id = vRP.getUserId({player})
    TriggerClientEvent("chat:clear",-1)
    DisRSERVER(SendWeb.Log.ClearChatt,
    "CLEAR CHAT",
    "• | **ID : **" ..player)
    TriggerClientEvent("RAR:Notify", -1, {type = "alert", text = "تم مسح الشات العام بالكامل",
    photo = "https://cdn.discordapp.com/attachments/694414844925051000/778221261825376256/megaphone.svg",
     color = "#00263f",
      colortext = "white"
     }) 

end

--==================================
    -- SELF REVIVE
--==================================
local selfrevive = {function (player)
	vRPclient.isInComa(player,{},function (coma)
    if coma then
      
			vRPclient.varyHealth(player,{100})
		else
			TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'error',
                text = '   يالحبيب انت مو ميت  ',
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
              })
		end
	end)
end,"لانعاش نفسك اذا مت"}

--==================================
    -- LOOT
--==================================
local isloot = {}
local choice_loot = {function(player,choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
 			  if isloot[user_id] ~= true then
				isloot[user_id] = true
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = vRP.getUserId({nplayer})
      if nuser_id ~= nil then
        vRPclient.isInComa(nplayer,{}, function(in_coma)
          if in_coma then
			local revive_seq = {
			  {"amb@medic@standing@kneel@enter","enter",1},
			  {"amb@medic@standing@kneel@idle_a","idle_a",1},
			  {"amb@medic@standing@kneel@exit","exit",1}
			}
  			vRPclient.playAnim(player,{false,revive_seq,false}) -- anim
            SetTimeout(15000, function()
              local ndata = vRP.getUserDataTable({nuser_id})
              if ndata ~= nil then
			    if ndata.inventory ~= nil then -- gives inventory items
				  vRP.clearInventory({nuser_id})
                  for k,v in pairs(ndata.inventory) do 
			        vRP.giveInventoryItem({user_id,k,v.amount,true})
	              end
				end
			  end
			  local nmoney = vRP.getMoney({nuser_id})
			  if vRP.tryPayment({nuser_id,nmoney}) then
			    vRP.giveMoney({user_id,nmoney})
			  end
            end)
            vRPclient.stopAnim(player,{false})
            TriggerClientEvent("3BS:PARS", source, {time = 1000, text = ".. أستيلائك"})
            SetTimeout(1000,function ()
            TriggerClientEvent('RAR:Alert', nplayer, {
                sr = "msg",
                type = 'error',
                text = '   لقد تم الاستيلاء على جميع اغراضك  ',
                sec = 5000,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
              })
            end)
            vRPclient.getPosition(player, {}, function(x,y,z)
            DisRSERVER(SendWeb.Log.Loot,
            "PLAYER LOOT",
            "• | **ID : **" ..user_id.."\n• | **LOOT : **"..nuser_id.."\n• | **COORDS : **"..x..","..y..","..z.."")
            end)
    		vRP.giveInventoryItem({user_id,"قلب",1})
				vRP.giveInventoryItem({user_id,"يد",1})
				vRP.giveInventoryItem({user_id,"راس",1})
          else
            TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'error',
                text = '   !! ليس ميت  ',
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
              })
          end
        end)
      else
        TriggerClientEvent('RAR:Alert', player, {
            sr = "msg",
            type = 'error',
            text = '   لا يوجد شخص قريب  ',
            sec = 2500,
            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
            vol = 0.3
          })
      end
    end)
				SetTimeout(60000,function()
					isloot[user_id] = false
				end)
  else
    TriggerClientEvent('RAR:Alert', player, {
        sr = "msg",
        type = 'error',
        text = '   سبام التلويت ممنوع يرجى الانتظار دقيقة  ',
        sec = 3000,
        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
        vol = 0.3
      })
  end
  end
end,"تلويت اقرب شخص ميت"}



--==================================
    -- CHEACK JAIL ADMIN
--==================================
local aUnjailed = {}
function ajail_clock(target_id,timer)
  local target = vRP.getUserSource({tonumber(target_id)})
  local users = vRP.getUsers({})
  local online = false
  for k,v in pairs(users) do
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then
    if timer>0 then
        TriggerClientEvent('RAR:Alert', target, {
            sr = "msg",
            type = 'error',
            text = '   Time Jail : '..timer..'m Enjoy =) ',
            sec = 4000,
            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
            vol = 0.3
      })
      vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(timer)})
	  SetTimeout(60*1000, function()
		for k,v in pairs(aUnjailed) do --
		  if v == tonumber(target_id) then
	        aUnjailed[v] = nil
		    timer = 0
		  end
		end
		vRP.setHunger({tonumber(target_id), 0})
		vRP.setThirst({tonumber(target_id), 0})
	    ajail_clock(tonumber(target_id),timer-1)
	  end) 
    else 
	
	  vRPclient.teleport(target,{SendWeb.CoordsJail.UnJail[1],SendWeb.CoordsJail.UnJail[2],SendWeb.CoordsJail.UnJail[3]}) -- teleport to outside jail
      vRPclient.setHandcuffed(target,{false})
      local uotjail = { model = ""..SendWeb.InfoPlayer.SkinOutJail.."" }
      for i=0,300 do
        uotjail[i] = {0,0}
      end
      vRPclient.setCustomization(target,{uotjail})
      TriggerClientEvent('RAR:Alert', target, {
        sr = "msg",
        type = 'INFO',
        text = '   تم خروجك من السجن بنجاح  ',
        sec = 5000,
        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
        vol = 0.1
      })
	  vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(-1)})
    end
  end
end

--==================================
    -- JAIL ADMIN
--==================================
local R_jailAdmins = {function(player,choice) 
	vRP.prompt({player,"ايدي الشخص","",function(player,target_id) 
		if target_id ~= nil and target_id ~= "" then 
			vRP.prompt({player,"المدة","",function(player,jail_time)
				if jail_time ~= nil and jail_time ~= "" then 
					vRP.prompt({player,"سبب السجن","",function(player,jail_reason)
						if jail_reason ~= nil and jail_reason ~= "" then 
							local target = vRP.getUserSource({tonumber(target_id)})
							if target ~= nil then
								if tonumber(jail_time) > 500 then
									jail_time = 500
								end
								if tonumber(jail_time) < 1 then
									jail_time = 1
								end
								vRPclient.teleport(target,{SendWeb.CoordsJail.JaillAdmin[1],SendWeb.CoordsJail.JaillAdmin[2],SendWeb.CoordsJail.JaillAdmin[3]}) -- teleport to inside jail
								TriggerClientEvent('chatMessage', -1, "[Server]", {0,0,0}, "^7 دقيقة ^8 "..jail_time.."^7 لمدة ^8 "..GetPlayerName(target).."^7 قام بسجن ^8"..GetPlayerName(player).."^7 : المشرف")
                TriggerClientEvent('chatMessage', -1, "[Server]", {0,0,0}, "^8"..jail_reason.."^7 : السبب")
                local idle_copy = { model = ""..SendWeb.InfoPlayer.SkinJail.."" }
                    for i=0,300 do
                      idle_copy[i] = {0,0}
                    end
                    vRPclient.setCustomization(target,{idle_copy})
								ajail_clock(tonumber(target_id),tonumber(jail_time))
                vRPclient.setHandcuffed(target,{true})
                DisRSERVER(SendWeb.Log.JaillAdmin,
                "JAIL ADMIN",
                "• | **ID : **" ..player.."\n• | **JAIL : **"..target_id.."\n• | **TIME : **"..jail_time.."\n• | **REASON : **"..jail_reason.."")
							end
						else
                            TriggerClientEvent('RAR:Alert', player, {
                                sr = "msg",
                                type = 'error',
                                text = '   لا يوجد سبب ',
                                sec = 2500,
                                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                                vol = 0.3
                          })
						end
					end})
                else
                    TriggerClientEvent('RAR:Alert', player, {
                        sr = "msg",
                        type = 'error',
                        text = '   لا يمكن ان يكون وقت السجن فارغ ',
                        sec = 2500,
                        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                        vol = 0.3
                  })
				end
			end})
		else
            TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'error',
                text = '   لا يوجد شخص محدد ',
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
          })
		end
	end})
end,"سجن شخص مخالف للرول بلي عن بعد"}

--==================================
    -- CHEACK ALL JAIL
--==================================
local function update_name(player, user_id, source)
	RSCclient.insertUser(player,{user_id,source,vRP.hasPermission({user_id, "player.group.add"})})
end
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 

  local users = vRP.getUsers({})
	for k,v in pairs(users) do
		update_name(source,k,v)
		update_name(v,user_id,source)
  end
  if first_spawn then
    TriggerClientEvent("ownId:init", source, user_id)
 end
  SetTimeout(5000,function ()
    TriggerClientEvent('compass', source)
    TriggerClientEvent("RAR:Notify", source, {type = "alert", text = "تم اظهار اسم المدينة",
    photo = "https://cdn.discordapp.com/attachments/694414844925051000/778221261825376256/megaphone.svg",
     color = "#00263f",
      colortext = "white"
     }) 
  end)
    SetTimeout(11000,function ()
      TriggerClientEvent('showmapp', source)
      TriggerClientEvent("RAR:Notify", source, {type = "alert", text = "تم تفعيل دليل الدوائر",
      photo = "https://cdn.discordapp.com/attachments/694414844925051000/778221261825376256/megaphone.svg",
       color = "#00263f",
        colortext = "white"
       }) 
    end)
    local target = vRP.getUserSource({user_id})
    SetTimeout(100,function()
      local custom = {}
      vRP.getUData({user_id,"vRP:jail:time",function(value)
        if value ~= nil then
          custom = json.decode(value)
          if custom ~= nil then
            if tonumber(custom) > 0 then
              BMclient.loadFreeze(target,{false,true,true})
              SetTimeout(15000,function()
                BMclient.loadFreeze(target,{false,false,false})
              end)
              vRPclient.setHandcuffed(target,{true})
              vRPclient.teleport(target,{SendWeb.CoordsJail.JailLeft[1],SendWeb.CoordsJail.JailLeft[2],SendWeb.CoordsJail.JailLeft[3]})
              TriggerClientEvent('RAR:Alert', target, {
                sr = "msg",
                type = 'error',
                text = '   تم استرجاعك للسجن لأنهاء حكمك ',
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
          })
              vRP.setHunger({tonumber(user_id),0})
              vRP.setThirst({tonumber(user_id),0})
              ajail_clock(tonumber(user_id),tonumber(custom))
            end
          end
        end
      end})
    end)
  end)

  AddEventHandler("vRP:playerLeave",function(user_id, source)
    local users = vRP.getUsers({})
    for k,v in pairs(users) do
      RSCclient.removeUser(v,{user_id})
    end
  end)
  
--==================================
    -- DRAG
--==================================
  local R_DRAG = {function(player,choice)
    -- get nearest player
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      vRPclient.getNearestPlayer(player,{10},function(nplayer)
        if nplayer ~= nil then
          local nuser_id = vRP.getUserId({nplayer})
          if nuser_id ~= nil then
            vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
              if handcuffed then
                  TriggerClientEvent("dr:drag", nplayer, player)
        else
            TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'error',
                text = '  اللاعب غير مقيد  ',
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
          })
              end
            end)
          else
            TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'error',
                text = '  لايوجد لاعب قريب  ',
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
          })

          end
        else
            TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'error',
                text = '  لايوجد لاعب قريب  ',
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
          })
          end
      end)
    end
  end, "سحب اقرب لاعب مكلبش"}

--==================================
    -- COMMAND DRAG
--==================================
if xRAR.AllCommaneds.Drag.Stute then
  RegisterCommand(""..xRAR.AllCommaneds.Drag.Command.."",function(player, args, rawCommand)
    local user_id = vRP.getUserId({player})
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrSpownCars..""}) then
    if user_id ~= nil then
      vRPclient.getNearestPlayer(player,{10},function(nplayer)
        if nplayer ~= nil then
          local nuser_id = vRP.getUserId({nplayer})
          if nuser_id ~= nil then
            vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
              if handcuffed then
                  TriggerClientEvent("dr:drag", nplayer, player)
        else
            TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'error',
                text = '  اللاعب غير مقيد  ',
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
          })
              end
            end)
          else
            TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'error',
                text = '  لايوجد لاعب قريب  ',
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
          })

          end
        else
            TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'error',
                text = '  لايوجد لاعب قريب  ',
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
          })
          end
      end)
    end
  else
    TriggerClientEvent("RAR:Aler", player, "error",
    "فشل",
    "لا يمكنك استعمال هذا الكوماند لانه ليس لديك صلاحية",
    3000)
  end
  end)
end

--==================================
    -- CHANGE SKIN
--==================================
local R_SKINS = {function(player,choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
        vRP.prompt({player,"ايدي اللاعب:","",function (player , targetid)
          local targetsource = vRP.getUserSource({tonumber(targetid)})
            if targetid ~= nil and targetid ~= "" then 
                vRP.prompt({player,"اسم السكن:","",function(player,Skin)
                    if Skin ~= nil and Skin ~= "" then
                      DisRSERVER(SendWeb.Log.ChangeSkin,
                      "CHANGE SKIN",
                      "• | **ID : **" ..player.."\n• | **CHANGE SKIN : **"..targetid.."\n• | **TO : **"..Skin)
                        TriggerClientEvent('RAR:ChangeSkin', targetsource, Skin)
                    else
                        TriggerClientEvent('RAR:Alert', player, {
                            sr = "msg",
                            type = 'error',
                            text = '  لم يتم التعرف على السكن او غير موجود  ',
                            sec = 2500,
                            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                            vol = 0.3
                      })
                    end 

                end})
            else
                TriggerClientEvent('RAR:Alert', player, {
                    sr = "msg",
                    type = 'error',
                    text = '  يرجى كتابة ايدي الشخص ',
                    sec = 2500,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                    vol = 0.3
              })
            end
        end})
    end
end, "لتغيير سكن شخص عن بعد"}

--==================================
    -- CHANGE SKIN COMMAND
--==================================
if xRAR.AllCommaneds.ChangeSkin.Stute then
RegisterCommand(""..xRAR.AllCommaneds.ChangeSkin.Command.."",function(player, args, rawCommand)
  local user_id = vRP.getUserId({player})
  if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrChangeSkin..""}) then
  if user_id ~= nil then
      vRP.prompt({player,"ايدي اللاعب:","",function (player , targetid)
        local targetsource = vRP.getUserSource({tonumber(targetid)})
          if targetid ~= nil and targetid ~= "" then 
              vRP.prompt({player,"اسم السكن:","",function(player,Skin)
                  if Skin ~= nil and Skin ~= "" then
                    DisRSERVER(SendWeb.Log.ChangeSkin,
                    "CHANGE SKIN",
                    "• | **ID : **" ..player.."\n• | **CHANGE SKIN : **"..targetid.."\n• | **TO : **"..Skin)
                      TriggerClientEvent('RAR:ChangeSkin', targetsource, Skin)
                  else
                      TriggerClientEvent('RAR:Alert', player, {
                          sr = "msg",
                          type = 'error',
                          text = '  لم يتم التعرف على السكن او غير موجود  ',
                          sec = 2500,
                          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                          vol = 0.3
                    })
                  end 

              end})
          else
              TriggerClientEvent('RAR:Alert', player, {
                  sr = "msg",
                  type = 'error',
                  text = '  يرجى كتابة ايدي الشخص ',
                  sec = 2500,
                  sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                  vol = 0.3
            })
          end
      end})
  end
else
  TriggerClientEvent("RAR:Aler", player, "error",
  "فشل",
  "لا يمكنك استعمال هذا الكوماند لانه ليس لديك صلاحية",
  3000)
end
end)
end

--==================================
    -- TERMALI
--==================================
stat = {}
if SendWeb.Src.Termali then
vRP.defInventoryItem({""..SendWeb.InfoPlayer.NameiTemTermali.."", "خوذة حرارية", "خوذة حرارية مصممة للرؤية من هم خلف الجدران", function(args)
    local choices = {}
    choices["لبس الخوذة"] = {function(player,choice,mod)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
        if vRP.tryGetInventoryItem({user_id,""..SendWeb.InfoPlayer.NameiTemTermali.."",1,false}) then -- get item
            if stat[user_id] then
                TriggerClientEvent('RAR:Alert', player, {
                    sr = "msg",
                    type = 'error',
                    text = '  الخوذة قيد الاستعمال ',
                    sec = 2500,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                    vol = 0.3
                })
            else

                TriggerClientEvent("3BS:PARS", player, {time = 1500, text = ".. جاري الاستعمال"})
                SetTimeout(1500,function ()
                    stat[user_id] = true
                    TriggerClientEvent('termali', player, true)
                    vRP.closeMenu({player})
                    TriggerClientEvent('RAR:Alert', player, {
                        sr = "msg",
                        type = 'done',
                        text = '   تم تفعيل وضع المنظور الحراري  ',
                        sec = 3000,
                        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                        vol = 0.1
                      })
                end)
                vRPclient.getPosition(player, {}, function(x,y,z)
                DisRSERVER(SendWeb.Log.Termalii,
                "USE TERMALI",
                "• | **ID : **" ..user_id.."\n• | **COORDS : **"..x..","..y..","..z.."")
                end)
				-- SendDiscord131("اللاعب " .. user_id .. " استخدم الخوذة الحرارية", 13961481)
        Citizen.Wait(SendWeb.InfoPlayer.TimeTermali)
        TriggerClientEvent("3BS:PARS", player, {time = 1500, text = "..جاري الالغاء "})
        SetTimeout(1500,function ()
                TriggerClientEvent('termali', player, false)
                TriggerClientEvent('RAR:Alert', player, {
                    sr = "msg",
                    type = 'error',
                    text = '  تم الغاء المنظور الحراري ',
                    sec = 2500,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                    vol = 0.3
                })
                stat[user_id] = false
            end)
            end
        end
      end
    end}
    return choices
end, 0.01})
end

--==================================
    -- RemoveCar
--==================================
AddEventHandler( 'chatMessage', function( source, n, msg ) 
    if SendWeb.Src.DvCar then 
    for k,v in pairs (SendWeb.RemoveCar) do
    msg = string.lower( msg )
    if ( msg == ""..v.."" ) then 
        CancelEvent() 
        TriggerClientEvent( 'RAR:RemoveCar', source )
    end
  end
end
end)

--==================================
    -- UNJIL
--==================================
local R_unjail = {function(player,choice) 
	vRP.prompt({player,"ايدي اللاعب","",function(player,target_id) 
	  if target_id ~= nil and target_id ~= "" then 
		vRP.getUData({tonumber(target_id),"vRP:jail:time",function(value)
		  if value ~= nil then
		  custom = json.decode(value)
			if custom ~= nil then
			  local user_id = vRP.getUserId({player})
			  if tonumber(custom) > 0 or vRP.hasPermission({user_id,"admin.unjail"}) then
	            local target = vRP.getUserSource({tonumber(target_id)})
				if target ~= nil then
                  unjailed[target] = tonumber(target_id)
                  TriggerClientEvent('RAR:Alert', target, {
                    sr = "msg",
                    type = 'done',
                    text = '   تم الافراج عن سجنك من قبل مشرف  ',
                    sec = 3000,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                    vol = 0.1
                  })
                  TriggerClientEvent('RAR:Alert', player, {
                    sr = "msg",
                    type = 'done',
                    text = '   تم الافراج عنه سيتم استخراجه عن قريب  ',
                    sec = 3000,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                    vol = 0.1
                  })
                  DisRSERVER(SendWeb.Log.UnjailPlayer,
                  "CHANGE SKIN",
                  "• | **ID : **" ..player.."\n• | **UNJIL : **"..target)
				else
                    TriggerClientEvent('RAR:Alert', player, {
                        sr = "msg",
                        type = 'error',
                        text = '  لا يمكنك ترك الوصف فارغ ',
                        sec = 2500,
                        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                        vol = 0.3
                    })
				end
			  else
				TriggerClientEvent('RAR:Alert', player, {
                    sr = "msg",
                    type = 'error',
                    text = '  الشخص غير مسجون ',
                    sec = 2500,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                    vol = 0.3
                })
			  end
			end
		  end
		end})
      else
        TriggerClientEvent('RAR:Alert', player, {
            sr = "msg",
            type = 'error',
            text = '  لا يوجد شخص محدد ',
            sec = 2500,
            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
            vol = 0.3
        })
      end 
	end})
end,"فك سجن اقرب واحد"}

--==================================
    -- UNJIL COMMAND
--==================================
if xRAR.AllCommaneds.UnJail.Stute then
RegisterCommand(""..xRAR.AllCommaneds.UnJail.Command.."",function(player, args, rawCommand)
  local user_id = vRP.getUserId({player})
  if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrUnjil..""}) then
	vRP.prompt({player,"ايدي اللاعب","",function(player,target_id) 
	  if target_id ~= nil and target_id ~= "" then 
		vRP.getUData({tonumber(target_id),"vRP:jail:time",function(value)
		  if value ~= nil then
		  custom = json.decode(value)
			if custom ~= nil then
			  local user_id = vRP.getUserId({player})
			  if tonumber(custom) > 0 or vRP.hasPermission({user_id,"admin.unjail"}) then
	            local target = vRP.getUserSource({tonumber(target_id)})
				if target ~= nil then
                  unjailed[target] = tonumber(target_id)
                  TriggerClientEvent('RAR:Alert', target, {
                    sr = "msg",
                    type = 'done',
                    text = '   تم الافراج عن سجنك من قبل مشرف  ',
                    sec = 3000,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                    vol = 0.1
                  })
                  TriggerClientEvent('RAR:Alert', player, {
                    sr = "msg",
                    type = 'done',
                    text = '   تم الافراج عنه سيتم استخراجه عن قريب  ',
                    sec = 3000,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                    vol = 0.1
                  })
                  DisRSERVER(SendWeb.Log.UnjailPlayer,
                  "CHANGE SKIN",
                  "• | **ID : **" ..player.."\n• | **UNJIL : **"..target)
				else
                    TriggerClientEvent('RAR:Alert', player, {
                        sr = "msg",
                        type = 'error',
                        text = '  لا يمكنك ترك الوصف فارغ ',
                        sec = 2500,
                        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                        vol = 0.3
                    })
				end
			  else
				TriggerClientEvent('RAR:Alert', player, {
                    sr = "msg",
                    type = 'error',
                    text = '  الشخص غير مسجون ',
                    sec = 2500,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                    vol = 0.3
                })
			  end
			end
		  end
		end})
      else
        TriggerClientEvent('RAR:Alert', player, {
            sr = "msg",
            type = 'error',
            text = '  لا يوجد شخص محدد ',
            sec = 2500,
            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
            vol = 0.3
        })
      end 
  end})
else
  TriggerClientEvent("RAR:Aler", player, "error",
  "فشل",
  "لا يمكنك استعمال هذا الكوماند لانه ليس لديك صلاحية",
  3000)
end
end)
end

--==================================
    -- JAIL POLICE
--==================================
local R_JAILPOICE = {function(player,choice) 
    vRPclient.getNearestPlayers(player,{15},function(nplayers) 
      local user_list = ""
      for k,v in pairs(nplayers) do
        user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
      end 
      if user_list ~= "" then
        vRP.prompt({player," الاشخاص القريبين" .. user_list,"",function(player,target_id) 
          if target_id ~= nil and target_id ~= "" then 
            vRP.prompt({player,"المدة","1",function(player,jail_time)
              if jail_time ~= nil and jail_time ~= "" then 
                local target = vRP.getUserSource({tonumber(target_id)})
                if target ~= nil then
                  if tonumber(jail_time) > 60 then
                      jail_time = 60
                  end
                  if tonumber(jail_time) < 1 then
                    jail_time = 1
                  end
              
                  vRPclient.isHandcuffed(target,{}, function(handcuffed)  
                    if handcuffed then 

                      vRPclient.teleport(target,{SendWeb.CoordsJail.Jaill[1],SendWeb.CoordsJail.Jaill[2],SendWeb.CoordsJail.Jaill[3]}) -- teleport to inside jail
                      vRP.setHunger({tonumber(target_id),0})
                      vRP.setThirst({tonumber(target_id),0})
                      jail_clock(tonumber(target_id),tonumber(jail_time))
                      local user_id = vRP.getUserId({player})
                      local idle_copy = { model = ""..SendWeb.InfoPlayer.SkinJail.."" }
                      for i=0,300 do
                        idle_copy[i] = {0,0}
                      end
                      vRPclient.setCustomization(target,{idle_copy})
                      DisRSERVER(SendWeb.Log.Jaill,
                      "JAIL POLICE",
                      "• | **ID : **" ..player.."\n• | **JAIL : **"..target_id.."\n• | **TIME : **"..jail_time.." Month")
                    else
                        TriggerClientEvent('RAR:Alert', player, {
                            sr = "msg",
                            type = 'error',
                            text = '  كلبش الشخص اول شي ',
                            sec = 2500,
                            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                            vol = 0.3
                        })
                    end
                  end)
                else
                    TriggerClientEvent('RAR:Alert', player, {
                        sr = "msg",
                        type = 'error',
                        text = '  لا يوجد شخص محدد ',
                        sec = 2500,
                        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                        vol = 0.3
                    })
                end
              else
                TriggerClientEvent('RAR:Alert', player, {
                    sr = "msg",
                    type = 'error',
                    text = '  اكتب وقت السجن ',
                    sec = 2500,
                    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                    vol = 0.3
                })              end
            end})
          else
            TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'error',
                text = '  لا يوجد شخص محدد ',
                sec = 2500,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                vol = 0.3
            })
                  end 
        end})
      else
        TriggerClientEvent('RAR:Alert', player, {
            sr = "msg",
            type = 'error',
            text = '  لا يوجد شخص قريب ',
            sec = 2500,
            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
            vol = 0.3
        })
      end 
    end)
  end,"سجن اقرب شخص عليك"}

	
  if xRAR.AllCommaneds.ReviveNer.Stute then 
  RegisterCommand(""..xRAR.AllCommaneds.ReviveNer.Command.."",function(player, args, rawCommand)
    local user_id = vRP.getUserId({player})
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrReviveNer..""}) then
    if user_id ~= nil then
      vRPclient.getNearestPlayers(player,{15},function (nplayer)
        for p,i in pairs(nplayer) do
          vRPclient.varyHealth(p,{100})
        end
        vRPclient.varyHealth(player,{100})
          vRPclient.getPosition(player, {}, function(x,y,z)
            DisRSERVER(SendWeb.Log.ReviveNp,
           "REVIVE NEARS PLAYERS",
           "• | **ID : **" ..user_id.."\n• | **COORDS : **"..x..","..y..","..z.."")
           end)
        TriggerClientEvent('RAR:Alert', source, {
          sr = "msg",
          type = 'info',
          text = '   تم انعاش المحيط  ',
          sec = 2500,
          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
          vol = 0.1
        })
      end)
    end
  else
    TriggerClientEvent("RAR:Aler",player, "error",
    "فشل",
    "لا يمكنك استعمال هذا الكوماند لانه ليس لديك صلاحية",
    3000)
  end
  end)
end

  if xRAR.AllCommaneds.JailPolice.Stute then
    RegisterCommand(""..xRAR.AllCommaneds.JailPolice.Command.."",function(player, args, rawCommand)
      local user_id = vRP.getUserId({player})
      if vRP.hasPermission({user_id,""..SendWeb.Prm.PrJail..""}) then
      vRPclient.getNearestPlayers(player,{15},function(nplayers) 
        local user_list = ""
        for k,v in pairs(nplayers) do
          user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
        end 
        if user_list ~= "" then
          vRP.prompt({player," الاشخاص القريبين" .. user_list,"",function(player,target_id) 
            if target_id ~= nil and target_id ~= "" then 
              vRP.prompt({player,"المدة","1",function(player,jail_time)
                if jail_time ~= nil and jail_time ~= "" then 
                  local target = vRP.getUserSource({tonumber(target_id)})
                  if target ~= nil then
                    if tonumber(jail_time) > 60 then
                        jail_time = 60
                    end
                    if tonumber(jail_time) < 1 then
                      jail_time = 1
                    end
                
                    vRPclient.isHandcuffed(target,{}, function(handcuffed)  
                      if handcuffed then 
  
                        vRPclient.teleport(target,{SendWeb.CoordsJail.Jaill[1],SendWeb.CoordsJail.Jaill[2],SendWeb.CoordsJail.Jaill[3]}) -- teleport to inside jail
                        vRP.setHunger({tonumber(target_id),0})
                        vRP.setThirst({tonumber(target_id),0})
                        jail_clock(tonumber(target_id),tonumber(jail_time))
                        local user_id = vRP.getUserId({player})
                        local idle_copy = { model = ""..SendWeb.InfoPlayer.SkinJail.."" }
                        for i=0,300 do
                          idle_copy[i] = {0,0}
                        end
                        vRPclient.setCustomization(target,{idle_copy})
                        DisRSERVER(SendWeb.Log.Jaill,
                        "JAIL POLICE",
                        "• | **ID : **" ..player.."\n• | **JAIL : **"..target_id.."\n• | **TIME : **"..jail_time.." Month")
                      else
                          TriggerClientEvent('RAR:Alert', player, {
                              sr = "msg",
                              type = 'error',
                              text = '  كلبش الشخص اول شي ',
                              sec = 2500,
                              sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                              vol = 0.3
                          })
                      end
                    end)
                  else
                      TriggerClientEvent('RAR:Alert', player, {
                          sr = "msg",
                          type = 'error',
                          text = '  لا يوجد شخص محدد ',
                          sec = 2500,
                          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                          vol = 0.3
                      })
                  end
                else
                  TriggerClientEvent('RAR:Alert', player, {
                      sr = "msg",
                      type = 'error',
                      text = '  اكتب وقت السجن ',
                      sec = 2500,
                      sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                      vol = 0.3
                  })              end
              end})
            else
              TriggerClientEvent('RAR:Alert', player, {
                  sr = "msg",
                  type = 'error',
                  text = '  لا يوجد شخص محدد ',
                  sec = 2500,
                  sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                  vol = 0.3
              })
                    end 
          end})
        else
          TriggerClientEvent('RAR:Alert', player, {
              sr = "msg",
              type = 'error',
              text = '  لا يوجد شخص قريب ',
              sec = 2500,
              sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
              vol = 0.3
          })
        end 
      end)
    else
      TriggerClientEvent("RAR:Aler", player, "error",
      "فشل",
      "لا يمكنك استعمال هذا الكوماند لانه ليس لديك صلاحية",
      3000)
    end
    end)
  end

  local INFOO = {function(player,choice)
    local user_id = vRP.getUserId({player})
    local money = vRP.getMoney({user_id})
    local bakk = vRP.getBankMoney({user_id})
    local job2 = vRP.getUserGroupByType({user_id,"job"})
    local menu = {}
    menu.name = "قاعدة البيانات"
      menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
          menu["معلوماتك"] = {rtttt,"<font color=\"red\">Money Cash : </font> : "..money.."<br><font color=\"red\">Money Bank : </font>"..bakk.."<br><font color=\"red\">Job : </font> : "..vRP.getUserGroupByType({user_id,"job"})..""}
    vRP.openMenu({player, menu})
  end}

--==================================
    -- CHEACK JAIL POLICE
--==================================
local unjailed = {}
function jail_clock(target_id,timer)
  local target = vRP.getUserSource({tonumber(target_id)})
  local users = vRP.getUsers({})
  local online = false
  for k,v in pairs(users) do
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then
    if timer>0 then
        TriggerClientEvent('RAR:Alert', target, {
            sr = "msg",
            type = 'error',
            text = '   Time Jail : '..timer..'m Enjoy =) ',
            sec = 4000,
            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
            vol = 0.3
      })
      vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(timer)})
	  SetTimeout(60*1000, function()
		for k,v in pairs(unjailed) do 
		  if v == tonumber(target_id) then
	        unjailed[v] = nil
		    timer = 0
		  end
		end
		vRP.setHunger({tonumber(target_id), 0})
		vRP.setThirst({tonumber(target_id), 0})
	    jail_clock(tonumber(target_id),timer-1)
	  end) 
    else 
	  BMclient.loadFreeze(target,{false,true,true})
	  SetTimeout(15000,function()
		BMclient.loadFreeze(target,{false,false,false})
    end)
	  vRPclient.teleport(target,{SendWeb.CoordsJail.UnJail[1],SendWeb.CoordsJail.UnJail[2],SendWeb.CoordsJail.UnJail[3]}) 
    vRPclient.setHandcuffed(target,{false})
    local uotjail = { model = ""..SendWeb.InfoPlayer.SkinOutJail.."" }
    for i=0,300 do
      uotjail[i] = {0,0}
    end
    vRPclient.setCustomization(target,{uotjail})
    TriggerClientEvent('RAR:Alert', target, {
        sr = "msg",
        type = 'INFO',
        text = '   تم خروجك من السجن بنجاح  ',
        sec = 5000,
        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
        vol = 0.1
      })
	  vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(-1)})
    end
  end
end

function Jailllll(player,choice)
  TriggerClientEvent('RAR:Alert', player, {
    sr = "msg",
    type = 'error',
    text = "تم ايقاف تفعيل الخيار بسبب المشاكل",
    sec = 7000,
    sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
    vol = 0.3
})
end

--==================================
    -- STORE MONEY
--==================================
local choice_store_money = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local amount = vRP.getMoney({user_id})
    if vRP.tryPayment({user_id, amount}) then 
      vRP.giveInventoryItem({user_id, "money", amount, true})
      DisRSERVER(SendWeb.Log.moneyStore,
      "STORE MONEY",
      "• | **ID : **" ..user_id.."\n• | **STORE MONEY  : **"..amount)
    end
  end
end,"خزن فلوسك في الحقيبة."}

--==================================
    -- ARMOR
--==================================
vRP.defInventoryItem({"body_armor","درع","للحصول على قوة مضاعفة",
function(args)
  local choices = {}

  choices["استخدام"] = {function(player,choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      if vRP.tryGetInventoryItem({user_id, "body_armor", 1, true}) then
        BMclient.setArmour(player,{100,true})
        DisRSERVER(SendWeb.Log.UseArrmor,
        "ARMOR",
        "• | **ID : **" ..user_id.."\n• | **USE ARMOR**")
        vRP.closeMenu({player})
      end
    end
  end}

  return choices
end,
0.50})

if xRAR.AllCommaneds.Armor.Stute then 
  RegisterCommand(""..xRAR.AllCommaneds.Armor.Command.."",function(player, args, rawCommand)
    local user_id = vRP.getUserId({player})
    if vRP.hasPermission({user_id,""..xRAR.AllCommaneds.Armor.Perm..""}) then
        BMclient.setArmour(player,{100,true})
        DisRSERVER(SendWeb.Log.UseArrmor,
        "ARMOR",
        "• | **ID : **" ..user_id.."\n• | **USE ARMOR**")
    end
  end)
end

local ch_handcuff = {function(player,choice)
  local user_id = vRP.getUserId({player})
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.toggleHandcuff(nplayer,{})
      TriggerClientEvent('RAR:Alert', player, {
        sr = "msg",
        type = 'error',
        text = '  تم تقييد الشخص  ',
        sec = 2500,
        sot = "https://cdn.discordapp.com/attachments/781064308107771924/783170025136717854/handcuff.wav",
        vol = 0.3
      })
      TriggerClientEvent('RAR:Alert', nplayer, {
        sr = "msg",
        type = 'error',
        text = '  تم تقييدك  ',
        sec = 2500,
        sot = "https://cdn.discordapp.com/attachments/781064308107771924/783170025136717854/handcuff.wav",
        vol = 0.3
      })
    DisRSERVER(SendWeb.Log.Cuff,
    "POLICE CUFF",
    "• | **ID : **" ..user_id.."\n• | **CUFF : **"..nplayer)
      vRP.closeMenu({nplayer})
    else
      TriggerClientEvent('RAR:Alert', player, {
        sr = "msg",
        type = 'error',
        text = '   لا يوجد لاعب قريب  ',
        sec = 2500,
        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
        vol = 0.3
      })
    end
  end)
end,"تقييد اقرب شخص لك"}

function vRPbm.getArmour()
  return GetPedArmour(GetPlayerPed(-1))
end

--==================================
    -- Menu
--==================================

local adminmanagementmenu = {function(player,choice)
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = "قاعدة البيانات"
    menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}

    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrSendAlertToAdmins..""}) then
        if SendWeb.Src.SendMsgAdmin then
        menu["ارسال رسالة لجميع الادارة"] = {sendtoalladmins,"رسالة لجميع الادمنية لتنبيه"}
        end
    end
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrClearChat..""}) then
        if SendWeb.Src.ClearlChat then
        menu["!-مسح الشات-!"] = {clearchat,"مسح الشات من الكل"}
        end
    end
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrSendAlertToAll..""}) then
        if SendWeb.Src.SendMsgAll then
        menu["ارسال رسالة لجميع اللاعبين"] = {sendtoallplayers,"تنويه او رسالة لجميع المواطنين"}
        end
    end
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrStopChat..""}) then
        if SendWeb.Src.cPanelChat then
        menu["ايقاف / تشغيل الشات"] = {disablechat,"ايقاف الشات على الجميع فقط الادارة العليا يمديها تكتب ويمديك تشغله"}
        end
    end
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrGiveUnMuteChat..""}) then
        if SendWeb.Src.MuteChat then
        menu["! فك ميوت شات !"] = {unmuteplayer,"حذف ميوت لشخص بالشات العام"}
        end
    end 
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrGiveMuteChat..""}) then
        if SendWeb.Src.MuteChat then
        menu["! اعطاء ميوت شات !"] = {muteplayer,"اعطاء ميوت لشخص بالشات العام"}
        end
    end
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrCheckGroups..""}) then
        if SendWeb.Src.CheakRole then
        menu["تحقق من الرتب"] = {checkplayergroups,"اضافة او ازالة رتب عامة للادارة العليا"}
        end
    end
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrJailOffline..""}) then
        if SendWeb.Src.JailOffline then
        menu["سجن اوفلاين"] = {Jailllll,"سجن اوفلاين"}
        end
    end
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrTpToMeAllAdmins..""}) then
        if SendWeb.Src.TpToMeAllAdmins then
        menu["سحب جميع الادمنية"] = {tpalladmins}
        end
    end

	vRP.openMenu({player, menu})
end}



vRP.registerMenuBuilder({"main", function(add, data)
    local user_id = vRP.getUserId({data.player})
    if user_id ~= nil then
      local choices = {}
      if vRP.hasPermission({user_id,"player.loot"}) then
        choices["تلويت"] = choice_loot 
      end
      choices["YourInfo"] = INFOO 
      if vRP.hasPermission({user_id,"emergency.revive"}) then
      choices["معالجة ذاتية"] = selfrevive
      end
      if vRP.hasPermission({user_id,"player.loot"}) then
        choices["تخزين الاموال"] = choice_store_money 
      end
      if vRP.hasPermission({user_id,"emergency.revive"}) then
        choices["معالجة ذاتية"] = selfrevive
      end

      choices["طلب الهوية"] = {AskID,"لطلب الهويه من المواطن"}
      choices["عرض هويتي الوطنية"] = {showMyID,"لعرض الهوية الخاصة بك"}

      choices["ارسال الموقع"] = {showPlayers,"لارسال الموقع للاعبين"}
--
      if(vRP.hasPermission({user_id, "123"}))then
        choices["تعقب شخص"] = {function(player,choice)
          users = vRP.getUsers({})
          vRP.buildMenu({"Find", {player = player}, function(menu)
            menu.name = "تعقب"
            menu.css={top="75px",header_color="rgba(235,0,0,0.75)"}
            menu.onclose = function(player) vRP.openMainMenu({player}) end	
            if(playersTracking[user_id] == nil)then
              myName = tostring(GetPlayerName(player))
              for k,v in pairs(users) do
                playerName = tostring(GetPlayerName(v))
                playersToFind[playerName] = tonumber(k)
                menu[playerName] = {findThePlayer, "تعقب هذا الشخص"}
              end
            else
              menu["!ايقاف التعقب!"] = {cancelTracking, "الغاء تعقب الشخص الحالي"}
            end
            vRP.openMenu({player, menu})
          end})
        end, "لتعقب شخص ما على الخريطة"}
      end
--
      add(choices)
  
  
    end
  end})


  vRP.registerMenuBuilder({"police", function(add, data)
    local user_id = vRP.getUserId({data.player})
    if user_id ~= nil then
      local choices = {}
      if vRP.hasPermission({user_id,""..SendWeb.Prm.PrJail..""}) then
        choices["سجن"] = R_JAILPOICE 
      end
      if vRP.hasPermission({user_id,"police.drag"}) then
        choices["سحب"] = R_DRAG 
      end
      if vRP.hasPermission({user_id,"police.easy_cuff"}) then
        choices["تقييد / فك تقييد"] = ch_handcuff 
      end
      if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrJailAdmin..""}) then
        if SendWeb.Src.JailAdmin then
        choices["سجن عن بعد"] = R_jailAdmins 
        end
      end
      add(choices)
    end
  end})



vRP.registerMenuBuilder({"admin", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrChangeSkin..""}) then
        if SendWeb.Src.ChangeSkin then
        choices["تغيير سكن شخص"] = R_SKINS 
        end
    end
    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrJailAdmin..""}) then
        if SendWeb.Src.JailAdmin then
        choices["سجن عن بعد"] = R_jailAdmins 
        end
    end

    if xRAR.cPanel.Stute then
    if vRP.hasPermission({user_id,""..xRAR.cPanel.PrLogin..""}) then
      choices["! تسجيل دخول !"] = {adminjoin,"تتم استرجاع صلاحياتك من تسجيل الدخول"}
    end
    if vRP.hasPermission({user_id,""..xRAR.cPanel.PrLeft..""}) then
      choices["! تسجيل خروج !"] = {adminleft,"ستزال الصلاحيات عند تسجيل خروجك"}
    end
    end

    if vRP.hasPermission({user_id,""..SendWeb.InfoAdmin.PrUnjil..""}) then
        choices["فك سجن"] = R_unjail 
    end
    if vRP.hasPermission({user_id,"admin.tickets"}) then
      choices["!-قوائم حساسة-!"] = adminmanagementmenu
    end

    add(choices)


  end
end})

