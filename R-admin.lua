local htmlEntities = module("lib/htmlEntities")
local Tools = module("lib/Tools")
local SendWeb = module("Settings")
local player_ad = {}
local admin_ticket_time = 60000 

function SendLogInve(linkwebhook, name, message)
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
    PerformHttpRequest(linkwebhook,function(err, text, headers) end,'POST',json.encode({username = SendWeb.Server.NServer,embeds = connect,avatar_url = SendWeb.Server.PServer}),{ ['Content-Type'] = 'application/json' })
  end
  
local function R_BANOFFLINE(player,choice)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.ban") then
    vRP.prompt(player,"ايدي اللاعب المراد تبنيده","",function(player,id)
      id = parseInt(id)
	  vRP.prompt(player,"السبب","",function(player,reason)
      vRP.setBanned(id,true)
      SendLogInve(SendWeb.Log.BandOffline,
      "BANNED OFFLINE",
      "• | **ID : **" ..player.."\n• | **Band : **"..id.."\n• | **REASON : **"..reason)
      TriggerClientEvent('RAR:Alert', player, {
        sr = "msg",
        type = 'done',
        text = '   تم التبنيد بنجاح  ',
        sec = 2500,
        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
        vol = 0.1
      })
      end)

    end)
  end
end


RegisterServerEvent("RAR:Day")
AddEventHandler("RAR:Day", function()
  local user_id = vRP.getUserId(source)
  for i, v in pairs(SendWeb.MoneyBank) do
    local user_id = vRP.getUserId(source)
    if vRP.hasGroup(user_id,""..i.."") then
      vRP.giveBankMoney(user_id,v[1])
      SendLogInve(SendWeb.Log.PayCheck,
      "• | PAYCHECK PLAYER",
      "• | **ID : **" ..source.."\n• | **JOB : **"..i.."\n• | **MONEY : **$"..v[1])
      TriggerClientEvent("RAR:Notify", source, {type = "alert", text = "تم ايداع راتبك في البنك",
      photo = "https://cdn.discordapp.com/attachments/694414844925051000/778228891420590120/dollar.svg",
       color = "#a2482a",
        colortext = "white"
       }) 
		end
	end
end)

local function R_REVIVEALL(player,choice)
	vRP.request(player,"هل انت متاكد من انعاش جميع الاعبين؟",30,function(player,ok)
    if ok then	
      local users = vRP.getUsers()
      local user_id = vRP.getUserId(source)
          for k,v in pairs(users) do
            local target_source = vRP.getUserSource(k)
            if target_source ~= nil then
              TriggerClientEvent("3BS:PARS", player, {time = 1500, text = ".. جاري الانعاش"})
              SetTimeout(1500,function ()
                SendLogInve(SendWeb.Log.ReviveAll,
                "REVIVE ALL PLAYERS",
                "• | **ID : **" ..user_id)
              vRPclient.varyHealth(target_source, {100})
              end)
            end
          end
        end
  end)
end

local function R_REVIVE(player,choice)
  local user_id = vRP.getUserId(source)
    vRP.prompt(player,"ايدي اللاعب","",function(player,user_player)
      local art = vRP.getUserSource(tonumber(user_player))
      if art ~= nil then
        TriggerClientEvent("3BS:PARS", player, {time = 1000, text = "يرجى الانتظار"})
        SetTimeout(1000,function ()
        SendLogInve(SendWeb.Log.Revive,
        "REVIVE PLAYER",
        "• | **ID : **" ..user_id.."\n• | **REVIVE : **"..user_player)
        vRPclient.varyHealth(art,{100})
        end)
      else
        TriggerClientEvent('RAR:Alert', player, {
          sr = "msg",
          type = 'error',
          text = '   لم يتم العثور على الشخص او غير ميت  ',
          sec = 2500,
          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
          vol = 0.3
        })
      end
    end)
end


local function R_ADDROLES(player,choice)
  local user_id = vRP.getUserId(source)
  vRP.prompt(player,"ايدي اللاعب المراد اعطائة رتبة","",function(player,id)
      id = parseInt(id)
      vRP.prompt(player,"الرتبه؟","",function(player,role)
      if role ~= nil then
      TriggerClientEvent("3BS:PARS", source, {time = 1000, text = "يرجى الانتظار"})
      SetTimeout(1000,function ()
        SendLogInve(SendWeb.Log.AddGroup,
        "ADD GROUPS",
        "• | **ID : **" ..user_id.."\n• | **ADD : **"..role.."\n• | **TO : **"..id)
        vRP.addUserGroup(id,role)
        TriggerClientEvent('RAR:Alert', player, {
          sr = "msg",
          type = 'done',
          text = '   تم اضافة الرتبة بنجاح  ',
          sec = 2500,
          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
          vol = 0.1
        })
      end)
      end   
    end)
  end)
end

local function R_REMOVEROLES(player,choice)
  local user_id = vRP.getUserId(source)
  vRP.prompt(player,"ايدي اللاعب المراد ازالة رتبته","",function(player,id)
      id = parseInt(id)
      if id ~= "" then
      vRP.prompt(player,"الرتبه؟","",function(player,role)
      role = role or ""
      if role ~= nil and role ~= "" then
      TriggerClientEvent("3BS:PARS", player, {time = 1000, text = "يرجى الانتظار"})
      SetTimeout(1000,function ()
        vRP.removeUserGroup(id,role)
        SendLogInve(SendWeb.Log.ReGroup,
        "REMOVE GROUPS",
        "• | **ID : **" ..user_id.."\n• | **RMOVE GROUP : **"..role.."\n• | **FROM : **"..id)
        TriggerClientEvent('RAR:Alert', player, {
          sr = "msg",
          type = 'done',
          text = '   تم ازالة الرتبة بنجاح  ',
          sec = 2500,
          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
          vol = 0.1
        })
      end)
    else
      TriggerClientEvent("3BS:PARS", player, {time = 1000, text = "يرجى الانتظار"})
      SetTimeout(1000,function ()
      TriggerClientEvent('RAR:Alert', player, {
        sr = "msg",
        type = 'error',
        text = '   لم يتم العثور على الرتبة او الشخص نفسه  ',
        sec = 2500,
        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
        vol = 0.3
      })
    end)
      end   
    end)
  end
  end)
end

local function R_KICK(player,choice)
  local user_id = vRP.getUserId(source)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.kick") then
    vRP.prompt(player,"ايدي اللاعب المراد طرده","",function(player,id)
      id = parseInt(id)
      vRP.prompt(player,"السبب؟","",function(player,reason)
        local source = vRP.getUserSource(id)
        if source ~= nil then
          vRP.kick(source,reason)
          SendLogInve(SendWeb.Log.Kick,
          "KICK",
          "• | **ID : **" ..player.."\n• | **KICK : **"..source.."\n• | **REASON : **"..reason)
          TriggerClientEvent('RAR:Alert', user_id, {
            sr = "msg",
            type = 'done',
            text = '   تم طرد اللاعب بنجاح  ',
            sec = 2500,
            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
            vol = 0.1
          })
        end
      end)
    end)
  end
end

local function R_BAN(player,choice)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.ban") then
    vRP.prompt(player,"ايدي اللاعب المراد تبنيده","",function(player,id)
      id = parseInt(id)
      vRP.prompt(player,"Reason: ","",function(player,reason)
        local source = vRP.getUserSource(id)
        if source ~= nil then
          vRP.ban(source,reason)
          SendLogInve(SendWeb.Log.Band,
          "BANNED",
          "• | **ID : **" ..player.."\n• | **KICK : **"..source.."\n• | **REASON : **"..reason)
          TriggerClientEvent('RAR:Alert', player, {
            sr = "msg",
            type = 'done',
            text = '   !! تم تبنيد اللاعب بنجاح  ',
            sec = 2500,
            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
            vol = 0.1
          })
        end
      end)
    end)
  end
end

local function R_UNBAN(player,choice)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.unban") then
    vRP.prompt(player,"ايدي اللاعب المراد فك بانده","",function(player,id)
      id = parseInt(id)
      vRP.setBanned(id,false)
      SendLogInve(SendWeb.Log.UnBan,
      "UN-BANNED",
      "• | **ID : **" ..player.."\n• | **UNBAN : **"..id)
      TriggerClientEvent('RAR:Alert', player, {
        sr = "msg",
        type = 'done',
        text = '   تم ازالة الباند من اللاعب بنجاح  ',
        sec = 2500,
        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
        vol = 0.1
      })
    end)
  end
end



local function R_COORDS(player,choice)
  vRPclient.getPosition(player,{},function(x,y,z)
    TriggerClientEvent('RAR:Alert', player, {
      sr = "msg",
      type = 'info',
      text = '   قم بالنسخ كالاتي بالاسفل  ',
      sec = 3000,
      sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
      vol = 0.1
    }) 
    vRP.prompt(player,"YourCoord",x..","..y..","..z,function(player,choice) end)
  end)
end





local function R_TPTOME(player,choice)
  local user_id = vRP.getUserId(source)
  vRPclient.getPosition(player,{},function(x,y,z)
    vRP.prompt(player,"اللاعب المراد سحبه","",function(player,user_id) 
      local tplayer = vRP.getUserSource(tonumber(user_id))
      if tplayer ~= nil then
        TriggerClientEvent('RAR:Alert', player, {
          sr = "msg",
          type = 'done',
          text = '   تم سحب اللاعب  ',
          sec = 2500,
          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
          vol = 0.1
        })
        ----------------------------------------------------
vRPclient.getPosition(player, {}, function(x,y,z)
  SendLogInve(SendWeb.Log.TpToMe,
  "TP TO ME",
  "• | **ID : **" ..user_id.."\n• | **TP : **"..tplayer.."\n• | **COORDS : **"..x..","..y..","..z.."")
  end)
  ----------------------------------------------------
        TriggerClientEvent('RAR:Alert', tplayer, {
          sr = "msg",
          type = 'info',
          text = '   تم سحبك من قبل مشرف  ',
          sec = 2500,
          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
          vol = 0.1
        })
        vRPclient.teleport(tplayer,{x,y,z})
      end
    end)
  end)
end

local function R_TPTO(player,choice)
  local user_id = vRP.getUserId(source)
  vRP.prompt(player,"ايدي اللاعب المراد الانتقال له","",function(player,user_id) 
    local tplayer = vRP.getUserSource(tonumber(user_id))
    if tplayer ~= nil then
      vRPclient.getPosition(tplayer,{},function(x,y,z)
        vRPclient.teleport(player,{x,y,z})
      end)
      vRPclient.getPosition(tplayer, {}, function(x,y,z)
        SendLogInve(SendWeb.Log.TpTo,
        "TP TO",
        "• | **ID : **" ..user_id.."\n• | **TP : **"..tplayer.."\n• | **COORDS : **"..x..","..y..","..z.."")
        end)
        ----------------------------------------------------
    end
  end)
end

local function R_TPCOORDS(player,choice)
  vRP.prompt(player,"Coords x,y,z:","",function(player,fcoords) 
    local coords = {}
    for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
      table.insert(coords,tonumber(coord))
    end

    local x,y,z = 0,0,0
    if coords[1] ~= nil then x = coords[1] end
    if coords[2] ~= nil then y = coords[2] end
    if coords[3] ~= nil then z = coords[3] end
    TriggerClientEvent('RAR:Alert', player, {
      sr = "msg",
      type = 'info',
      text = '   تم نقلك للأحداثيات التي وضعتها  ',
      sec = 3000,
      sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
      vol = 0.1
    })
    vRPclient.teleport(player,{x,y,z})
  end)
end

local function R_GIVEITEM(player,choice)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.prompt(player,"اسم الغرض","",function(player,idname) 
      idname = idname or ""
      vRP.prompt(player,"العدد؟","",function(player,amount) 
        amount = parseInt(amount)
        vRP.giveInventoryItem(user_id, idname, amount,true)
        SendLogInve(SendWeb.Log.GiveItem,
        "GIVE ITEM ADMIN",
        "• | **ID : **" ..user_id.."\n• | **ITEM : **"..idname.."\n• | **AMOUNT : **"..amount)
        TriggerClientEvent('RAR:Alert', player, {
          sr = "msg",
          type = 'info',
          text = '   تم اخذ الغرض بنجاح  ',
          sec = 3000,
          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
          vol = 0.1
        })
      end)
    end)
  end
end

admins = {}
local player_ad = {}




local function ch_calladmin(player,choice) 
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		vRP.prompt(player,"اكتب مشكلتك قبل طلب ادمن","",
			function(player,desc) 
				if player_ad[player] == nil then
					player_ad[player] = true
				end
				if player_ad[player] == true then
					player_ad[player] = false
					SetTimeout(admin_ticket_time,
						function ()
							player_ad[player] = true
							TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'info',
                text = '   يمكن طلب ادمن الان  ',
                sec = 3000,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                vol = 0.1
              })
						end
					)
					desc = desc or ""
					if desc ~= nil and desc ~= "" then
						local answered = false
						local players = {}
						local users = vRP.getUsers({})
						for k,v in pairs(users) do
							local player = vRP.getUserSource(tonumber(k))
							if vRP.hasPermission(k,"admin.tickets") and player ~= nil then
								table.insert(players,player)
							end
						end
						for k,v in pairs(players) do
							vRP.request(v,"Admin ticket (user_id = "..user_id..") take/TP to ?: "..desc.."", 60, 
								function(v,ok)
									if ok then 
										if admins[v] == nil then
											admins[v] = false
										end
										if admins[v] == false then
                      if not answered then
                        TriggerClientEvent('RAR:Alert', player, {
                          sr = "msg",
                          type = 'error',
                          text = '   تم قبول طلبك من قبل مشرف  ',
                          sec = 2500,
                          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                          vol = 0.3
                        })
												vRPclient.getPosition(player, {}, 
                          function(x,y,z)
                            SendLogInve(SendWeb.Log.Tick,
                            "ADMIN",
                            "• | **ADMIN : **" ..vRP.getUserId(v).."\n• | **CITIZEN : **"..vRP.getUserId(player).."\n• | **Description : **"..desc)		
														vRPclient.teleport(v,{x,y,z})
													end)

												answered = true
												admins[v] = true
												SetTimeout(SendWeb.InfoAdmin.SecAccept,function () admins[v] = false end)
											else
                        TriggerClientEvent('RAR:Alert', v, {
                          sr = "msg",
                          type = 'error',
                          text = '   الطلب مقبول  ',
                          sec = 2500,
                          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                          vol = 0.3
                        })
                      											end
                    else
                      TriggerClientEvent('RAR:Alert', v, {
                        sr = "msg",
                        type = 'error',
                        text = '   ممنوع قبول طلبين بنفس الوقت يرجى الانتظار  ',
                        sec = 2500,
                        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                        vol = 0.3
                      })
										end
									end	
								end
              )
						end
          else
            TriggerClientEvent('RAR:Alert', player, {
              sr = "msg",
              type = 'error',
              text = '   يرجى كتابة المشكلة  ',
              sec = 2500,
              sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
              vol = 0.3
            })
					end
				else
          TriggerClientEvent('RAR:Alert', player, {
            sr = "msg",
            type = 'error',
            text = '   السبام ممنوع يرجى الانتظار دقيقة  ',
            sec = 2500,
            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
            vol = 0.3
          })
        				end
			end
    )
	end
end


------------------------------- ادمن رتب --------------------------------

local function call_admingroups(player,choice) 
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		vRP.prompt(player,"اكتب الرتبة التي تريدها داخل الطلب","",
			function(player,desc) 
				if player_ad[player] == nil then
					player_ad[player] = true
				end
				if player_ad[player] == true then
					player_ad[player] = false
					SetTimeout(admin_ticket_time,
						function ()
							player_ad[player] = true
							TriggerClientEvent('RAR:Alert', player, {
                sr = "msg",
                type = 'info',
                text = '   يمكن طلب ادمن الرتب الان  ',
                sec = 3000,
                sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
                vol = 0.1
              })
						end
					)
					desc = desc or ""
					if desc ~= nil and desc ~= "" then
						local answered = false
						local players = {}
						local users = vRP.getUsers({})
						for k,v in pairs(users) do
							local player = vRP.getUserSource(tonumber(k))
							if vRP.hasPermission(k,"admin.groups") and player ~= nil then
								table.insert(players,player)
							end
						end
						for k,v in pairs(players) do
							vRP.request(v,"Admin Groups (user_id = "..user_id..") take/TP to ?: "..desc.."", 60, 
								function(v,ok)
									if ok then 
										if admins[v] == nil then
											admins[v] = false
										end
										if admins[v] == false then
                      if not answered then
                        TriggerClientEvent('RAR:Alert', player, {
                          sr = "msg",
                          type = 'error',
                          text = '   تم قبول طلبك من قبل ادمن الرتب  ',
                          sec = 2500,
                          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                          vol = 0.3
                        })
												vRPclient.getPosition(player, {}, 
                          function(x,y,z)
                            SendLogInve(SendWeb.Log.Tick,
                            "ADMIN",
                            "• | **ADMIN : **" ..vRP.getUserId(v).."\n• | **CITIZEN : **"..vRP.getUserId(player).."\n• | **Description : **"..desc)		
														vRPclient.teleport(v,{x,y,z})
													end)

												answered = true
												admins[v] = true
												SetTimeout(SendWeb.InfoAdmin.SecAccept,function () admins[v] = false end)
											else
                        TriggerClientEvent('RAR:Alert', v, {
                          sr = "msg",
                          type = 'error',
                          text = '   الطلب مقبول  ',
                          sec = 2500,
                          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                          vol = 0.3
                        })
                      											end
                    else
                      TriggerClientEvent('RAR:Alert', v, {
                        sr = "msg",
                        type = 'error',
                        text = '   ممنوع قبول طلبين بنفس الوقت يرجى الانتظار  ',
                        sec = 2500,
                        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
                        vol = 0.3
                      })
										end
									end	
								end
              )
						end
          else
            TriggerClientEvent('RAR:Alert', player, {
              sr = "msg",
              type = 'error',
              text = '   يرجى كتابة المشكلة  ',
              sec = 2500,
              sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
              vol = 0.3
            })
					end
				else
          TriggerClientEvent('RAR:Alert', player, {
            sr = "msg",
            type = 'error',
            text = '   السبام ممنوع يرجى الانتظار دقيقة  ',
            sec = 2500,
            sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349942098296852/258193__kodack__beep-beep.wav",
            vol = 0.3
          })
        				end
			end
    )
	end
end


local function R_NOCLIP(player, choice)
  vRPclient.toggleNoclip(player, {})
end


RegisterServerEvent("blips:all")
AddEventHandler("blips:all", function(type)
	local user_id = vRP.getUserId(source)
  SendLogInve(SendWeb.Log.ShowBlips,
  type,
  "• | **ID : **" ..user_id)
end)

RegisterServerEvent("Noclip:RAR")
AddEventHandler("Noclip:RAR", function()
  local user_id = vRP.getUserId(source)
  vRPclient.getPosition(source, {}, function(x,y,z)
    SendLogInve(SendWeb.Log.NoClip,
    "NOCLIP ADMIN",
    "• | **ID : **" ..user_id.."\n• | **COORDS : **"..x..","..y..","..z.."")
    end)
end)

local function R_SHOWPLAYERS(player, choice)
  TriggerClientEvent("showBlips", player)
end

local function R_TPTOWEP(player, choice)
  TriggerClientEvent("TpToWaypoint", player)
end

--[[
local function tptowaypoint(source)
  TriggerClientEvent("TpToWaypoint", source)
end

RegisterServerEvent("ippp3112")
AddEventHandler("ippp3112", function()
  tptowaypoint(source)
end)
]]

--RegisterServerEvent("showwater")
--AddEventHandler("showwater", function()
 -- tptowaypoint(source)
--end)

local function FPS(player, choice)
  TriggerClientEvent("compass", player)
end

local function R_CARS(player, choice)
  local user_id = vRP.getUserId(source)
	vRP.prompt(player,"اسم السيارة","",function(player,model)
	  if model ~= nil and model ~= "" then 
      TriggerClientEvent("3BS:PARS", source, {time = 1000, text = ".. جاري التحميل"})
      SetTimeout(1000,function ()
        vRPclient.spawnVehicle(player,{model})
        SendLogInve(SendWeb.Log.Cars,
        "SPOWN CARS",
        "• | **ID : **" ..user_id.."\n• | **NAME CAR : **"..model)
        TriggerClientEvent('RAR:Alert', player, {
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
	end)
end


local function R_REVIVENER(player, choice)
  local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		vRPclient.getNearestPlayers(player,{15},function (nplayer)
			for p,i in pairs(nplayer) do
        vRPclient.varyHealth(p,{100})
      end
      vRPclient.getPosition(player, {}, function(x,y,z)
        SendLogInve(SendWeb.Log.ReviveNp,
        "REVIVE NEARS PLAYERS",
        "• | **ID : **" ..user_id.."\n• | **COORDS : **"..x..","..y..","..z.."")
        end)
      vRPclient.varyHealth(player,{100})
      TriggerClientEvent('RAR:Alert', player, {
        sr = "msg",
        type = 'info',
        text = '   تم انعاش المحيط  ',
        sec = 2500,
        sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349663194513438/320181__dland__hint.wav",
        vol = 0.1
      })
		end)
	end
end


local function LOGO(player, choice)
  TriggerClientEvent("compass", player)
end

local function HUDD(player, choice)
  TriggerClientEvent("hudd", player)
end

local function RADAR(player, choice)
  TriggerClientEvent("radar", player)
end

-------------------------------------------------------------------------------------------
function vRP.openAdminMenu(source)
  vRP.buildMenu("admin", {player = source}, function(menudata)
    menudata.name = "Admin"
    menudata.css = {top="75px",header_color="rgba(0,125,255,0.75)"}
    vRP.openMenu(source,menudata)
  end)
end

vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}

    choices["!-الادارة-!"] = {function(player,choice)
      vRP.buildMenu("admin", {player = player}, function(menu)
        menu.name = "Admin"
        menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
        menu.onclose = function(player) vRP.openMainMenu(player) end 

        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.Praddrole.."") then
          menu["اضافة رتبة"] = {R_ADDROLES}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.Prremrole.."") then
          menu["ازالة رتبة"] = {R_REMOVEROLES}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrKick.."") then
          menu["طرد"] = {R_KICK}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrBan.."") then
          menu["باند"] = {R_BAN}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrUnBan.."") then
          menu["فك باند"] = {R_UNBAN}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrNoClip.."") then
          menu["ّ!.طيران.!"] = {R_NOCLIP}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrNoClip.."") then
          menu["احداثياتك"] = {R_COORDS}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrTpTome.."") then
          menu["سحب لاعب"] = {R_TPTOME}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrTpTo.."") then
          menu["انتقال للاعب"] = {R_TPTO}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrCoord.."") then
          menu["انتقال لاحداثيات"] = {R_TPCOORDS}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrGiveitem.."") then
          menu["اخذ غرض"] = {R_GIVEITEM}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrRevive.."") then
          menu["!.انعاش لاعب.!"] = {R_REVIVE}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrReviveAll.."") then
          menu["!.انعاش الجميع.!"] = {R_REVIVEALL}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrGiveitem.."") then
          menu["اظهار اللاعبين"] = {R_SHOWPLAYERS}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrSpownCars.."") then
          menu["انزال سيارة"] = {R_CARS}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrReviveNer.."") then
          menu["!.انعاش المحيط.!"] = {R_REVIVENER}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrTpToWep.."") then
          menu["!.انتقال لنقطة.!"] = {R_TPTOWEP}
        end
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrBan.."") then
          menu["باند اوفلاين"] = {R_BANOFFLINE}
        end
        if vRP.hasPermission(user_id,"player.calladmin") then
          menu["! طلب ادمن رتب !"] = {call_admingroups}
        end
        if SendWeb.InfoAdmin.calladmins then
        if vRP.hasPermission(user_id,"player.calladmin") then
          menu["! طلب ادمن !"] = {ch_calladmin}
        end
        end
        vRP.openMenu(player,menu)
      end)
    end}

    add(choices)
	end
end)


vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}
    if vRP.hasPermission(user_id,""..SendWeb.InfoPlayer.FPS.."") then
    choices["FPS"] = {function(player,choice)
      vRP.buildMenu("fpss", {player = player}, function(menu)
        menu.name = "FPS"
        menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
        menu.onclose = function(player) vRP.openMainMenu(player) end 
          menu["Hide/Show | Radar"] = {RADAR,"نسبة ارتفاع الفريمات عن ايقافه : %2<br><font color=\"red\">Re-Coder</font> : 3BS#1111"}
          menu["Hide/Show | Hud"] = {HUDD,"نسبة ارتفاع الفريمات عن ايقافه : %4<br><font color=\"red\">Re-Coder</font> : 3BS#1111"}
          menu["Hide/Show | Logo"] = {LOGO,"نسبة ارتفاع الفريمات عن ايقافه : %10<br><font color=\"red\">Re-Coder</font> : 3BS#1111"}
        vRP.openMenu(player,menu)
      end)
    end,"قائمة خاصة بالاشياء الخاصة بالفريمات<br><font color=\"red\">Re-Coder</font> : 3BS#1111"}
  end
    add(choices)
	end
end)


-- admin god mode
-- function task_god()
  -- SetTimeout(10000, task_god)

  -- for k,v in pairs(vRP.getUsersByPermission("admin.god")) do
    -- vRP.setHunger(v, 0)
    -- vRP.setThirst(v, 0)

    -- local player = vRP.getUserSource(v)
    -- if player ~= nil then
      -- vRPclient.setHealth(player, {200})
    -- end
  -- end
-- end

-- task_god()
