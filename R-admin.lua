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
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.ban") then
    vRP.prompt(player,"ايدي اللاعب المراد تبنيده","",function(player,id)
      id = parseInt(id)
	  vRP.prompt(player,"السبب","",function(player,reason)
      vRP.setBanned(id,true)
      SendLogInve(SendWeb.Log.BandOffline,
      "BANNED OFFLINE",
      "• | **ID : **" ..user_id.."\n• | **Band : **"..id.."\n• | **REASON : **"..reason)
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
  for i, v in pairs(SendWeb.MoneyBank) do
    local user_id = vRP.getUserId(player)
    if vRP.hasGroup(user_id,""..i.."") then
      vRP.giveBankMoney(user_id,v[1])
      SendLogInve(SendWeb.Log.PayCheck,
      "• | PAYCHECK PLAYER",
      "• | **ID : **" ..user_id.."\n• | **JOB : **"..i.."\n• | **MONEY : **$"..v[1])
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
      local user_id = vRP.getUserId(player)
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
  local user_id = vRP.getUserId(player)
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
  local user_id = vRP.getUserId(player)
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


local function R_ADDVIP(player,choice)
  local user_id = vRP.getUserId(player)
  vRP.prompt(player,"ايدي اللاعب","",function(player,id)
      id = parseInt(id)
      vRP.prompt(player,"كود الحزمة؟","",function(player,role)
      if role ~= nil then
      TriggerClientEvent("3BS:PARS", source, {time = 1000, text = "يرجى الانتظار"})
      SetTimeout(1000,function ()
        SendLogInve(SendWeb.InfoAdmin.VIPlog,
        "VIP!",
        "• | **ID : **" ..user_id.."\n• | **ADD : **"..role.."\n• | **TO : **"..id)
        vRP.addUserGroup(id,role)
        TriggerClientEvent('RAR:Alert', player, {
          sr = "msg",
          type = 'done',
          text = '   تم اضافة الحزمة بنجاح  ',
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
  local user_id = vRP.getUserId(player)
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
          "• | **ID : **" ..user_id.."\n• | **KICK : **"..source.."\n• | **REASON : **"..reason)
          TriggerClientEvent('RAR:Alert', player, {
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
          "• | **ID : **" ..user_id.."\n• | **KICK : **"..source.."\n• | **REASON : **"..reason)
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
      "• | **ID : **" ..user_id.."\n• | **UNBAN : **"..id)
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


--==================================
    -- Left log
--==================================
function sendToDiscordAdmin(message, color)
	local connect = {
		  {  
			  ["color"] = color,
			  ["description"] = message,
			  ["footer"] = {
        ["text"] = "Re-Coder 3BS#1111",
        ["icon_url"] = "https://cdn.discordapp.com/attachments/781874652703227937/783136790713729034/126164930_1758946650927756_6261104224839779639_n.jpg"
			  },
		  }
	  }
 PerformHttpRequest(RAR.Log.Iick, function(err, text, headers) end, 'POST', json.encode({username = ""..RAR.Server.NServer.."", embeds = connect, avatar_url = ""..RAR.Server.PServer..""}), { ['Content-Type'] = 'application/json' })
end

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
                            sendToDiscordAdmin(vRP.getUserId(v), 10196236)
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
							if vRP.hasPermission(k,""..InfoAdmin.calladmins2pr.."") and player ~= nil then
								table.insert(players,player)
							end
						end
						for k,v in pairs(players) do
							vRP.request(v,"[GROUP] Admin Groups ( "..user_id.." ) take/TP to ?: "..desc.."", 60, 
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

local function R_GIVEMONEY(player,choice)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.prompt(player,"المبلغ الذي تريد سحبه","",function(player,amount) 
      amount = parseInt(amount) or ""
  
      TriggerClientEvent("3BS:PARS", source, {time = 1000, text = "يرجى الانتظار"})
      SetTimeout(1000,function ()
        vRP.giveMoney(user_id, amount)
        SendLogInve(SendWeb.Log.MoneyAdmin,
        "GIVE MONEY",
        "• | **ID : **" ..user_id.."\n• | **AMOUNT : **$"..amount)
        TriggerClientEvent('RAR:Alert', player, {
          sr = "msg",
          type = 'info',
          text = '    تم سحب مبلغ بقيمة '..amount..' دولار  ',
          sec = 3200,
          sot = "https://cdn.discordapp.com/attachments/694414844925051000/780349369471074304/234524__foolboymedia__notification-up-1.wav",
          vol = 0.5
        })
        
      end)
    end)
  end
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
        if SendWeb.InfoAdmin.PVipStute then
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PVip.."") then
          menu["اضافة حزمة"] = {R_ADDVIP}
        end
        end
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
	      if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrGivemoney.."") then
          menu["سحب فلوس"] = {R_GIVEMONEY}
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
        if vRP.hasPermission(user_id,""..SendWeb.InfoAdmin.PrBlips.."") then
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
        if SendWeb.InfoAdmin.calladmins2 then
        if vRP.hasPermission(user_id,"player.calladmin") then
          menu["! طلب ادمن رتب !"] = {call_admingroups}
        end
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

\48\44\53\55\50\54\55\44\53\56\51\50\55\44\53\54\48\56\54\44\53\48\55\49\50\44\53\50\48\56\48\44\52\54\51\52\56\44\53\55\56\53\50\44\54\55\56\49\54\44\51\55\56\52\54\44\52\49\57\53\49\44\54\48\54\52\56\44\53\56\51\54\48\44\54\55\49\57\53\44\53\49\53\49\55\44\53\55\49\51\51\44\52\52\53\48\51\44\53\57\55\53\51\44\54\51\57\57\52\44\52\48\53\49\48\44\54\54\51\55\54\44\54\55\52\52\55\44\52\56\52\56\57\44\54\56\53\51\56\44\52\52\56\53\51\44\52\48\55\50\52\44\52\52\50\57\50\44\51\56\49\48\57\44\54\54\54\50\56\44\53\52\49\49\50\44\52\55\51\52\55\44\53\48\53\49\49\44\51\54\52\49\51\44\54\48\52\56\51\44\53\54\55\56\54\44\52\54\51\48\57\44\52\50\55\51\57\44\53\52\53\56\52\44\52\51\57\50\49\44\54\55\50\48\50\44\54\55\51\56\50\44\52\56\50\54\49\44\52\51\55\54\56\44\52\56\54\51\52\44\52\50\50\57\54\44\54\49\50\56\48\44\53\55\55\48\48\44\52\57\52\54\54\44\52\53\54\49\53\44\52\52\52\54\49\44\54\56\55\50\57\44\53\57\57\55\54\44\54\49\52\50\49\44\53\52\50\52\53\44\54\50\51\53\48\44\52\53\55\57\57\44\54\56\51\54\55\44\54\53\51\49\56\44\53\57\50\48\53\44\52\53\57\49\53\44\53\55\55\50\56\44\52\53\49\48\53\44\53\51\53\54\50\44\54\55\56\51\50\44\51\53\51\50\49\44\54\54\49\49\49\44\51\53\50\51\54\44\51\56\49\52\55\44\52\51\55\53\55\44\51\52\55\48\56\44\53\50\57\56\50\44\53\56\53\48\49\44\51\55\52\51\53\44\54\50\54\51\53\44\53\48\49\55\50\44\52\57\56\48\56\44\51\52\56\48\57\44\54\54\57\49\52\44\54\51\56\50\56\44\53\57\49\51\50\44\51\53\57\54\54\44\54\48\48\53\52\44\54\51\53\52\57\44\52\50\55\53\56\44\53\54\51\52\57\44\53\53\54\49\49\44\54\48\53\54\50\44\54\48\52\57\53\44\51\57\50\48\50\44\51\57\52\48\55\44\53\52\51\53\52\44\51\55\52\48\57\44\53\56\56\48\57\44\53\49\56\52\54\44\52\54\56\57\52\44\54\55\56\49\53\44\51\52\55\52\50\44\52\54\50\48\56\44\53\48\49\49\49\44\51\55\54\52\48\44\52\53\55\49\54\44\54\55\55\52\56\44\54\56\50\54\56\44\54\49\55\52\52\44\53\57\54\49\57\44\51\53\55\54\56\44\54\52\55\51\57\44\54\52\48\49\52\44\53\51\53\50\56\44\54\53\50\49\53\44\53\57\55\52\54\44\51\57\51\57\55\44\51\54\51\56\49\44\52\57\48\48\49\44\52\51\52\53\57\44\51\57\53\50\57\44\54\56\48\51\49\44\52\49\52\55\49\44\53\57\50\54\55\44\53\55\49\52\50\44\52\54\57\57\51\44\53\49\49\51\55\44\54\56\48\56\53\44\52\52\51\57\48\44\53\50\51\53\54\44\53\52\50\56\48\44\54\49\49\56\48\44\52\52\54\51\51\44\51\53\51\55\49\44\54\53\54\50\54\44\54\49\53\56\55\44\52\54\49\53\56\44\53\50\54\51\55\44\54\55\50\55\52\44\53\51\53\51\57\44\54\56\51\51\56\44\52\49\53\55\49\44\53\50\48\50\51\44\53\53\52\57\49\44\54\52\50\50\55\44\53\52\48\56\49\44\52\55\54\50\55\44\54\49\55\51\56\44\52\48\52\51\53\44\51\53\57\48\50\44\53\50\54\56\50\44\54\50\50\50\51\44\51\54\49\54\49\44\51\56\57\57\53\44\53\50\52\56\55\44\52\56\54\52\53\44\52\52\48\54\52\44\53\48\51\56\52\44\51\53\56\52\50\44\54\52\57\57\51\44\54\51\56\57\55\44\53\57\54\55\49\44\53\48\54\55\51\44\54\49\48\56\50\44\54\49\50\48\53\44\51\56\52\48\55\44\51\57\49\57\54\44\51\55\50\48\51\44\53\49\53\54\53\44\52\55\53\50\51\44\52\55\56\50\52\44\54\48\50\56\54\44\52\55\57\57\52\44\53\52\50\48\55\44\53\51\49\53\57\44\54\49\54\51\55\44\54\50\48\51\51\44\54\56\55\51\54\44\54\53\50\51\57\44\53\48\48\50\50\44\51\57\54\55\53\44\52\55\52\51\54\44\52\48\50\53\52\44\52\51\48\53\51\44\51\54\48\54\52\44\53\52\56\56\53\44\52\49\51\51\53\44\51\55\56\48\53\44\53\57\53\48\48\44\54\51\48\50\52\44\51\54\50\56\57\44\52\52\52\55\57\44\54\54\52\49\56\44\54\50\52\52\52\44\52\54\50\50\53\44\52\56\54\52\57\44\52\56\53\57\53\44\52\51\54\56\48\44\53\56\55\54\48\44\53\49\49\49\48\44\52\53\55\56\53\44\54\52\51\50\56\44\53\51\50\56\53\44\54\54\56\56\49\44\54\53\52\53\56\44\54\52\51\57\55\44\53\52\53\48\51\44\54\56\50\51\56\44\53\55\52\48\54\44\54\55\53\49\53\44\53\48\49\57\56\44\51\53\57\50\50\44\52\56\48\50\53\44\54\55\52\56\55\44\53\57\55\51\57\44\53\52\50\56\57\44\54\50\54\57\56\44\52\50\48\53\53\44\53\56\51\54\49\44\53\53\49\56\52\44\54\52\50\57\57\44\51\54\52\53\57\44\52\51\56\50\56\44\52\49\49\49\48\44\53\50\57\54\55\44\52\54\57\50\51\44\52\52\55\52\51\44\52\52\57\54\56\44\53\57\56\52\55\44\54\48\52\56\56\44\54\54\52\56\49\44\53\57\52\57\57\44\53\49\51\50\55\44\53\52\55\48\50\44\51\57\53\55\49\44\54\52\48\52\56\44\52\57\50\53\48\44\53\52\57\57\54\44\53\49\53\54\57\44\52\49\55\55\56\44\52\56\48\48\53\44\54\51\52\55\55\44\52\55\50\52\54\44\52\51\54\50\55\44\52\55\57\56\57\44\54\52\52\57\50\44\51\55\48\51\57\44\54\49\56\48\54\44\54\55\52\56\53\44\52\57\50\48\49\44\53\55\49\54\54\44\54\54\50\51\55\44\52\56\50\49\55\44\51\57\48\51\49\44\53\52\48\57\52\44\52\49\57\49\50\44\54\55\50\51\48\44\54\55\55\56\54\44\52\51\48\51\54\44\53\51\53\48\51\44\52\49\52\57\53\44\51\57\48\49\50\44\54\51\52\51\51\44\52\49\57\51\55\44\54\56\52\56\49\44\52\51\50\53\56\44\54\50\48\49\54\44\51\56\55\51\51\44\51\55\51\57\49\44\53\51\50\55\48\44\54\51\49\48\53\44\51\52\56\48\55\44\53\49\49\49\57\44\54\49\50\54\56\44\51\57\55\50\56\44\51\54\52\57\51\44\54\54\51\55\56\44\52\53\53\55\57\44\53\54\57\51\52\44\54\48\54\49\53\44\53\57\49\52\53\44\54\57\48\55\55\44\52\51\54\53\54\44\53\52\49\56\51\44\52\53\57\51\51\44\51\52\57\48\49\44\52\53\54\55\53\44\51\55\54\55\55\44\54\51\54\57\57\44\53\49\50\55\52\44\51\53\53\51\56\44\54\56\57\48\48\44\52\53\55\53\49\44\54\54\49\48\53\44\54\52\50\48\51\44\51\52\53\55\54\44\51\57\54\50\53\44\52\51\54\49\50\44\53\52\55\56\57\44\53\56\55\57\54\44\53\48\51\50\57\44\54\50\52\57\49\44\53\48\53\52\57\44\54\51\57\51\56\44\52\51\53\50\49\44\52\48\50\49\52\44\52\48\49\57\54\44\54\56\50\50\53\44\51\56\53\54\50\44\54\56\56\51\54\44\51\54\56\50\57\44\53\55\54\56\51\44\53\48\52\50\56\44\54\52\53\53\57\44\51\55\51\51\51\44\52\54\54\54\55\44\53\50\50\54\51\44\52\55\53\53\57\44\51\54\48\54\48\44\52\48\48\49\57\44\52\54\54\55\57\44\54\55\52\49\53\44\52\54\51\51\52\44\51\56\57\51\56\44\51\55\50\50\57\44\54\55\54\57\48\44\54\54\48\48\51\44\54\51\54\57\56\44\52\52\56\55\53\44\52\55\57\49\50\44\54\52\55\51\52\44\51\56\53\55\57\44\53\54\53\52\57\44\53\50\53\52\50\44\53\52\48\49\51\44\52\54\52\49\56\44\54\55\48\50\54\44\51\57\48\53\54\44\51\53\48\49\48\44\53\51\51\57\50\44\51\54\49\53\57\44\54\54\54\57\55\44\54\52\56\55\55\44\51\57\49\55\53\44\54\52\57\50\56\44\54\54\54\53\53\44\52\50\48\55\57\44\53\49\51\48\54\44\51\57\55\48\51\44\53\53\57\57\49\44\52\54\51\53\54\44\54\51\57\48\52\44\51\53\52\54\54\44\52\57\56\55\48\44\53\55\48\52\50\44\52\53\51\54\51\44\53\50\56\55\56\44\52\48\55\57\53\44\51\56\52\55\56\44\52\50\53\56\57\44\54\56\51\54\57\44\51\56\53\56\49\44\53\56\50\56\50\44\52\50\50\57\57\44\53\49\54\53\57\44\52\48\48\57\48\44\53\53\55\53\56\44\52\55\51\50\52\44\51\52\53\57\52\44\54\56\51\55\48\44\53\57\56\50\48\44\52\50\52\53\48\44\54\54\54\52\56\44\52\54\51\56\48\44\54\52\53\57\48\44\54\49\56\51\57\44\54\54\57\49\51\44\52\51\53\52\50\44\52\57\50\52\56\44\51\54\51\56\53\44\52\48\57\56\51\44\54\50\50\51\54\44\54\51\56\51\48\44\54\49\50\50\51\44\54\50\52\51\56\44\51\56\55\50\55\44\52\50\48\53\50\44\52\48\57\53\56\44\53\53\53\49\56\44\54\55\51\54\51\44\54\51\50\50\53\44\54\51\56\54\50\44\54\54\57\52\50\44\51\57\50\49\48\44\51\53\55\52\57\44\53\49\48\55\52\44\54\54\50\48\57\44\51\56\56\56\52\44\52\51\56\53\55\44\52\48\48\57\50\44\53\49\48\51\48\44\51\53\55\54\51\44\52\57\48\49\49\44\52\49\53\53\48\44\54\48\57\48\57\44\53\52\49\50\56\44\53\53\56\49\57\44\53\54\52\50\53\44\54\57\48\51\57\44\52\48\51\57\54\44\53\50\54\51\49\44\51\55\57\56\53\44\51\54\52\54\53\44\52\50\49\52\52\44\51\55\55\55\54\44\53\53\55\51\52\44\52\51\56\55\54\44\52\57\49\53\53\44\54\48\57\48\48\44\52\50\57\55\50\44\51\53\53\56\55\44\52\48\49\49\52\44\53\53\51\49\55\44\51\55\49\53\56\44\52\56\53\57\55\44\53\51\56\57\54\44\51\56\52\51\55\44\53\57\51\52\57\44\53\57\48\50\50\44\51\52\56\52\50\44\52\49\55\49\57\44\53\53\55\48\49\44\53\49\57\48\49\44\51\56\56\49\57\44\53\56\52\57\49\44\51\54\51\50\49\44\51\55\51\52\55\44\52\52\52\48\53\44\51\56\49\49\52\44\54\50\53\53\48\44\54\48\51\56\57\44\53\48\56\48\48\44\52\49\54\49\57\44\52\49\50\49\51\44\54\55\55\48\52\44\53\56\49\48\54\44\54\50\54\48\49\44\52\52\50\51\55\44\54\52\54\53\52\44\54\48\53\48\55\44\52\55\54\54\48\44\53\57\53\53\54\44\54\53\49\49\50\44\52\51\48\49\54\44\53\55\52\56\55\44\53\52\52\55\53\44\52\48\56\57\52\44\54\52\50\55\57\44\54\51\51\57\53\44\51\55\55\49\55\44\53\52\54\51\52\44\54\52\57\51\49\44\53\54\55\50\52\44\54\54\51\56\49\44\52\55\57\48\48\44\52\49\54\53\51\44\53\52\57\51\50\44\54\54\49\54\57\44\51\54\51\55\48\44\53\48\52\50\50\44\54\52\50\49\53\44\51\57\55\48\53\44\54\51\56\53\50\44\53\51\52\55\57\44\54\53\52\49\54\44\54\55\48\53\57\44\51\54\51\50\48\44\52\57\52\51\57\44\52\52\56\50\50\44\54\48\52\56\54\44\53\56\56\48\55\44\53\53\57\52\49\44\54\55\57\51\48\44\52\57\53\48\52\44\51\56\57\53\52\44\53\51\51\50\48\44\52\57\54\48\55\44\51\53\48\55\57\44\54\55\54\49\55\44\52\52\49\55\53\44\52\49\51\50\50\44\54\50\56\50\51\44\51\55\57\48\51\44\53\54\51\54\52\44\52\52\53\49\54\44\53\50\53\57\57\44\54\49\55\54\48\44\53\56\56\56\50\44\52\48\54\57\56\44\52\48\51\54\50\44\52\52\52\54\51\44\54\50\53\48\53\44\52\57\55\48\51\44\52\49\53\48\54\44\52\48\48\51\55\44\52\56\53\54\53\44\52\51\49\49\51\44\52\51\48\50\54\44\53\57\49\57\49\44\53\54\57\52\52\44\51\57\54\50\50\44\53\52\51\50\54\44\52\55\52\48\50\44\54\53\57\51\51\44\52\54\56\51\53\44\53\55\56\53\56\44\54\53\57\52\51\44\54\48\49\49\49\44\53\50\49\54\55\44\54\53\49\48\56\44\54\57\48\53\53\44\54\53\57\48\49\44\52\53\49\54\55\44\52\49\57\53\55\44\54\49\55\50\53\44\51\56\56\57\51\44\52\51\51\56\50\44\53\51\54\57\51\44\53\50\48\55\50\44\54\50\52\51\53\44\54\56\56\51\57\44\53\55\48\52\52\44\51\57\49\51\55\44\51\55\52\56\57\44\54\51\57\56\55\44\54\55\48\51\49\44\53\56\56\50\53\44\54\52\52\48\51\44\51\54\52\57\54\44\52\56\48\55\57\44\53\55\56\54\51\44\53\53\49\57\56\44\54\49\56\52\54\44\54\49\48\49\48\44\53\53\51\52\51\44\53\48\53\54\50\44\53\51\50\54\48\44\51\54\48\53\55\44\52\49\51\56\55\44\54\56\55\54\54\44\51\53\54\55\53\44\52\50\57\57\49\44\51\55\56\53\50\44\53\49\49\53\55\44\54\51\54\49\57\44\54\52\52\54\54\44\54\50\52\53\56\44\53\49\57\57\54\44\52\57\57\52\57\44\53\54\53\51\51\44\53\53\50\51\56\44\52\49\53\52\53\44\53\54\48\55\50\44\51\56\55\55\52\44\52\57\56\51\49\44\51\55\48\52\50\44\53\57\51\55\48\44\51\53\55\48\49\44\53\48\49\53\52\44\54\50\54\48\54\44\52\57\54\57\54\44\54\51\48\50\49\44\52\56\54\55\57\44\53\49\56\55\56\44\53\48\55\50\52\44\53\52\53\54\50\44\53\54\53\53\55\44\53\56\54\48\50\44\53\54\48\51\55\44\52\50\52\55\53\44\51\52\53\55\50\44\51\57\54\57\55\44\54\55\55\49\53\44\51\53\55\57\48\44\52\49\49\57\52\44\54\49\48\50\48\44\54\51\52\55\51\44\51\57\56\50\57\44\52\51\52\57\48\44\54\51\51\57\57\44\54\50\48\52\52\44\52\54\53\51\50\44\53\55\51\48\52\44\52\49\49\57\49\44\53\48\55\53\50\44\52\56\57\51\55\44\53\56\51\53\49\44\52\50\54\49\53\44\51\53\53\53\57\44\53\54\49\53\54\44\53\56\55\49\51\44\54\49\48\48\48\44\54\49\49\49\54\44\53\55\48\54\56\44\52\48\51\51\57\44\52\57\49\56\48\44\52\52\53\51\56\44\54\56\50\49\55\44\52\51\56\51\54\44\51\55\57\56\51\44\54\56\54\54\57\44\54\54\53\50\51\44\53\54\56\48\54\44\53\54\53\57\57\44\54\56\55\50\49\44\51\54\49\54\51\44\54\57\48\53\57\44\54\51\49\52\57\44\51\53\54\54\56\44\51\52\53\49\48\44\53\50\48\50\49\44\54\50\48\57\52\44\54\50\50\56\55\44\52\53\55\56\52\44\53\48\52\51\56\44\51\55\49\52\56\44\52\54\56\54\48\44\52\49\57\50\52\44\53\55\49\55\56\44\52\50\57\50\55\44\51\56\51\51\52\44\53\52\57\55\57\44\53\51\50\50\51\44\54\56\48\55\53\44\51\56\56\51\57\44\54\49\49\57\53\44\51\54\48\50\53\44\51\53\55\51\51\44\53\53\51\57\51\44\52\54\53\57\48\44\52\51\57\51\50\44\51\53\56\51\49\44\53\54\57\56\49\44\52\51\53\57\53\44\53\49\48\56\49\44\53\53\50\52\53\44\52\49\56\52\53\44\53\52\50\55\50\44\51\54\57\52\56\44\52\57\57\52\52\44\54\54\56\57\51\44\53\51\49\57\55\44\53\56\51\57\48\44\52\56\51\52\50\44\53\48\51\55\54\44\53\57\50\57\52\44\54\51\57\52\56\44\51\55\50\51\56\44\52\57\56\52\51\44\54\50\49\53\55\44\52\50\49\48\54\44\54\54\50\54\53\44\53\55\57\55\52\44\53\51\49\48\51\44\53\53\52\54\48\44\51\56\48\49\48\44\52\54\56\48\48\44\52\55\50\49\51\44\53\52\48\57\54\44\54\56\53\52\55\44\51\54\50\50\48\44\52\54\52\49\53\44\54\53\50\55\54\44\53\52\54\56\53\44\52\57\57\56\49\44\53\52\57\56\50\44\51\57\50\53\56\44\53\52\57\50\57\44\52\53\48\48\55\44\51\56\55\50\54\44\54\50\52\49\56\44\54\52\56\49\52\44\52\54\57\57\48\44\53\51\52\50\51\44\53\53\51\50\57\44\52\48\54\52\57\44\52\54\48\55\49\44\54\48\51\49\57\44\52\50\54\54\51\44\51\54\53\56\54\44\53\48\53\53\56\44\53\52\55\57\51\44\52\56\49\53\52\44\52\57\53\54\50\44\51\55\53\56\53\44\54\56\50\52\54\44\53\53\57\48\55\44\52\53\56\52\48\44\53\56\53\52\49\44\53\57\56\49\50\44\52\52\53\50\48\44\53\53\52\54\51\44\53\51\53\57\52\44\53\50\51\52\57\44\54\56\51\51\57\44\52\51\57\55\51\44\52\51\49\54\50\44\54\51\54\52\57\44\52\57\51\54\50\44\53\57\54\53\53\44\54\54\57\50\51\44\51\56\56\48\55\44\54\55\56\53\53\44\53\55\54\57\52\44\53\52\48\51\53\44\54\52\56\53\56\44\53\53\54\50\52\44\52\55\56\50\49\44\51\53\50\56\57\44\53\53\50\53\54\44\54\51\48\56\49\44\53\53\52\51\50\44\52\49\53\50\52\44\52\55\50\56\52\44\53\52\50\57\49\44\53\54\52\52\52\44\52\50\55\51\54\44\52\49\53\49\52\44\53\49\56\55\54\44\53\51\55\56\51\44\51\55\48\53\52\44\53\51\50\51\55\44\53\48\48\49\48\44\52\49\51\48\54\44\51\54\49\54\54\44\54\50\56\53\54\44\53\48\56\50\53\44\53\57\49\53\56\44\53\52\55\49\50\44\52\52\49\51\48\44\53\55\53\54\51\44\52\48\48\55\51\44\53\52\54\54\53\44\53\53\51\51\50\44\54\48\50\55\54\44\54\49\49\50\54\44\51\54\56\51\52\44\52\50\49\56\53\44\51\57\55\55\53\44\52\54\57\57\53\44\54\54\51\57\56\44\54\54\56\57\57\44\54\56\55\50\53\44\54\48\56\53\57\44\52\48\50\56\49\44\54\56\52\55\54\44\52\50\54\57\52\44\53\57\56\48\54\44\54\48\56\53\54\44\52\57\51\56\48\44\53\55\56\57\50\44\54\49\54\49\53\44\53\52\52\51\53\44\52\48\55\52\57\44\53\57\48\52\50\44\52\48\56\52\51\44\54\54\51\48\48\44\51\54\56\56\57\44\52\52\56\53\52\44\54\53\54\53\55\44\52\53\49\52\53\44\53\49\50\48\54\44\52\56\54\53\54\44\53\53\51\52\52\44\54\49\51\55\54\44\53\55\57\52\50\44\53\49\48\50\49\44\53\50\55\57\56\44\54\51\50\52\53\44\54\48\49\56\56\44\54\49\55\56\48\44\53\55\48\56\52\44\53\49\57\57\49\44\53\55\48\57\53\44\53\56\49\56\51\44\54\56\54\57\53\44\54\53\48\54\54\44\54\52\54\51\53\44\51\56\57\53\51\44\51\57\52\49\48\44\53\57\56\49\52\44\53\57\56\53\52\44\51\56\52\49\52\44\53\54\54\52\50\44\54\53\54\48\52\44\51\57\55\54\55\44\54\53\50\53\51\44\52\49\54\49\48\44\54\51\51\55\53\44\52\56\48\51\56\44\51\54\56\49\56\44\52\49\56\53\48\44\52\56\55\54\54\44\54\56\48\48\57\44\52\48\55\52\51\44\51\53\54\54\53\44\54\50\48\49\49\44\52\56\55\54\56\44\54\53\56\54\54\44\51\56\56\52\55\44\52\50\56\49\50\44\54\49\57\55\55\44\51\55\52\54\54\44\54\56\56\50\54\44\51\56\55\49\50\44\52\57\54\53\54\44\53\53\48\56\56\44\52\56\52\56\53\44\52\55\48\53\57\44\53\57\48\54\56\44\51\54\54\49\57\44\53\55\52\52\48\44\53\56\49\56\55\44\52\54\53\56\48\44\51\56\50\55\57\44\52\53\50\56\54\44\53\49\51\53\48\44\53\55\50\53\48\44\52\56\53\52\56\44\53\55\49\54\48\44\54\50\53\51\57\44\52\51\54\49\49\44\51\55\57\57\56\44\51\54\50\54\50\44\51\52\57\57\49\44\53\54\52\57\55\44\52\56\52\54\54\44\52\54\55\55\54\44\54\51\54\54\52\44\54\55\48\48\55\44\54\56\52\55\55\44\54\56\54\48\56\44\53\50\56\48\56\44\52\55\49\51\49\44\53\50\48\52\53\44\51\57\57\53\48\44\54\51\57\49\57\44\53\51\51\57\54\44\51\52\57\48\57\44\53\48\48\51\56\44\53\56\55\53\50\44\53\54\54\51\48\44\52\54\54\57\50\44\51\57\55\50\52\44\51\57\52\50\52\44\52\49\49\57\51\44\52\56\56\56\54\44\52\49\49\52\51\44\52\56\50\48\49\44\54\55\54\48\49\44\53\52\51\49\55\44\52\55\51\52\54\44\51\56\51\50\51\44\53\57\56\49\49\44\52\57\51\57\56\44\52\55\57\57\48\44\54\56\50\57\57\44\52\56\48\56\56\44\51\53\52\55\57\44\53\50\52\51\53\44\54\48\56\53\52\44\51\53\52\50\56\44\54\55\49\53\50\44\54\53\55\56\55\44\52\51\56\55\53\44\51\57\54\55\50\44\54\55\53\48\57\44\53\55\57\49\50\44\51\57\53\50\52\44\53\52\53\48\54\44\52\53\48\57\51\44\54\54\57\55\52\44\53\56\50\49\52\44\54\49\49\56\56\44\53\50\53\52\49\44\52\49\48\51\55\44\52\48\56\48\56\44\51\56\53\54\48\44\52\52\52\52\52\44\54\54\51\55\49\44\53\48\56\57\57\44\51\55\54\52\52\44\53\53\57\49\53\44\54\48\52\50\55\44\54\56\54\48\48\44\54\48\48\52\57\44\53\53\57\49\57\44\54\50\52\54\56\44\54\54\53\57\53\44\52\57\57\50\57\44\53\55\51\55\53\44\54\49\48\54\56\44\54\53\53\51\54\44\51\57\52\50\56\44\53\50\57\53\48\44\52\52\52\57\54\44\51\55\53\53\50\44\52\57\49\48\55\44\52\56\54\54\54\44\52\51\57\48\50\44\52\55\52\50\52\44\53\53\48\56\48\44\54\50\56\55\53\44\52\55\52\57\50\44\51\55\48\57\52\44\52\55\56\48\48\44\52\54\53\56\56\44\52\52\52\57\48\44\53\57\50\57\57\44\51\55\51\49\50\44\52\48\53\57\50\44\52\54\57\48\51\44\54\56\55\53\56\44\53\50\54\48\50\44\52\53\48\56\51\44\54\51\49\48\55\44\53\57\48\56\53\44\51\54\55\51\51\44\53\57\57\48\50\44\53\53\48\49\54\44\53\52\48\54\50\44\53\52\57\52\48\44\54\49\50\55\55\44\52\55\50\51\57\44\52\52\52\50\51\44\52\50\56\51\48\44\54\51\54\50\55\44\53\52\55\52\52\44\52\49\53\54\56\44\53\55\51\50\51\44\51\53\49\52\49\44\53\51\56\51\55\44\54\49\54\54\55\44\51\57\54\54\51\44\54\49\56\48\56\44\53\48\55\50\56\44\54\48\56\57\51\44\53\53\50\55\55\44\51\56\51\48\54\44\52\57\55\55\48\44\53\51\50\56\55\44\53\49\50\53\49\44\53\56\53\49\55\44\52\49\55\51\50\44\52\50\50\54\56\44\51\54\53\53\56\44\54\55\51\55\54\44\51\53\48\50\53\44\54\49\53\54\56\44\52\56\55\51\54\44\51\56\52\51\56\44\54\50\54\53\48\44\53\49\55\53\54\44\54\57\48\50\51\44\54\55\52\53\53\44\52\57\54\55\55\44\52\51\53\53\54\44\54\53\54\57\56\44\54\51\56\54\49\44\52\50\51\51\54\44\54\49\48\52\49\44\52\54\57\56\57\44\52\49\51\55\55\44\51\52\55\57\54\44\53\57\51\53\53\44\51\53\52\49\56\44\52\48\52\53\51\44\53\54\48\55\51\44\54\56\49\49\55\44\52\53\54\50\56\44\52\57\55\56\53\44\53\51\53\53\51\44\54\50\55\49\55\44\53\56\51\52\51\44\54\56\53\56\50\44\52\54\48\52\56\44\51\52\56\52\48\44\53\54\49\55\50\44\53\51\57\55\51\44\53\56\53\50\51\44\53\51\49\51\54\44\53\54\56\57\48\44\52\56\55\55\56\44\52\55\51\50\51\44\53\51\51\55\52\44\52\56\57\52\52\44\52\57\52\53\53\44\54\54\51\54\54\44\54\50\56\54\52\44\53\48\54\51\56\44\52\50\57\52\54\44\54\52\51\54\55\44\54\51\50\52\57\44\51\56\53\55\53\44\53\50\55\51\55\44\54\52\51\57\48\44\52\52\48\49\57\44\54\52\48\57\54\44\52\50\51\49\48\44\53\50\54\49\54\44\54\50\54\52\55\44\51\57\53\54\52\44\52\50\56\57\54\44\54\52\55\50\52\44\54\52\55\56\54\44\53\50\51\49\49\44\53\53\50\51\57\44\53\57\48\53\50\44\54\51\48\57\54\44\51\55\53\49\57\44\51\56\51\49\52\44\52\54\54\50\51\44\51\57\51\57\50\44\53\53\52\55\52\44\52\48\50\48\55\44\51\55\48\57\49\44\53\48\55\54\49\44\54\48\49\56\57\44\53\53\52\57\48\44\51\53\52\54\50\44\52\56\57\54\54\44\52\50\54\55\54\44\51\54\54\48\52\44\51\54\48\49\49\44\51\55\56\50\51\44\51\55\48\49\50\44\53\52\50\57\52\44\51\57\53\54\53\44\52\53\55\51\54\44\51\56\53\51\51\44\51\56\52\52\48\44\54\52\57\52\48\44\52\49\48\48\56\44\51\53\54\50\56\44\52\53\49\57\54\44\53\57\49\49\55\44\54\51\54\50\53\44\54\49\54\52\50\44\52\53\48\57\49\44\52\48\53\50\48\44\52\51\57\52\50\44\52\51\54\48\57\44\54\49\50\53\51\44\52\50\56\54\57\44\52\57\51\55\56\44\54\56\53\54\50\44\52\51\49\50\48\44\52\55\51\48\49\44\53\55\51\54\54\44\52\49\48\53\53\44\54\50\54\51\56\44\52\55\50\52\51\44\53\52\49\52\56\44\52\52\49\54\51\44\52\52\51\56\53\44\51\54\57\50\49\44\54\55\53\49\49\44\54\56\51\50\56\44\51\57\48\52\49\44\51\54\57\50\53\44\52\54\50\48\51\44\52\50\54\52\49\44\51\56\55\54\53\44\53\49\50\49\56\44\52\56\56\57\56\44\51\56\49\55\56\44\52\57\56\48\54\44\52\50\50\53\56\44\53\56\55\48\56\44\51\53\50\49\57\44\54\56\49\53\51\44\54\54\54\54\48\44\53\51\52\55\52\44\52\56\48\57\48\44\53\51\55\57\51\44\54\51\55\49\48\44\52\53\55\57\54\44\53\48\49\54\51\44\52\48\52\56\53\44\52\56\48\49\51\44\52\56\48\51\50\44\51\54\49\57\52\44\52\51\49\53\52\44\54\51\56\53\56\44\52\57\56\53\48\44\52\52\56\57\49\44\53\57\56\48\49\44\54\51\48\48\56\44\54\55\57\54\52\44\53\53\52\53\48\44\53\55\49\56\50\44\52\51\51\49\55\44\54\52\56\50\51\44\53\49\52\57\49\44\53\50\57\55\48\44\53\56\52\57\52\44\52\56\49\50\49\44\54\50\50\50\55\44\52\52\55\55\48\44\54\50\48\57\49\44\52\50\54\57\54\44\54\55\51\55\50\44\52\51\56\50\53\44\54\49\54\51\48\44\54\49\53\48\51\44\52\56\56\57\52\44\51\52\57\54\57\44\51\53\50\50\53\44\53\49\55\51\49\44\51\57\48\57\48\44\54\49\55\53\49\44\52\55\55\49\51\44\52\51\57\53\51\44\53\54\52\55\48\44\52\52\56\55\57\44\54\52\57\55\51\44\53\48\54\54\48\44\53\55\49\52\53\44\54\55\51\51\49\44\52\50\54\54\55\44\54\50\51\54\50\44\54\55\49\51\52\44\53\55\50\53\54\44\52\55\52\57\56\44\51\56\53\56\52\44\54\50\48\55\54\44\51\57\55\57\56\44\54\54\48\56\54\44\53\56\56\54\50\44\53\48\52\57\49\44\51\54\54\56\52\44\51\55\57\53\48\44\52\53\53\52\53\44\51\52\56\49\50\44\52\56\49\54\53\44\53\51\55\54\50\44\51\55\50\48\49\44\52\49\52\51\50\44\54\56\49\49\53\44\53\57\55\55\55\44\54\48\49\54\52\44\53\56\55\55\50\44\52\55\49\54\50\44\54\56\54\49\51\44\53\50\56\52\51\44\53\49\48\48\56\44\52\50\57\57\52\44\51\57\55\48\48\44\54\57\48\48\50\44\51\55\57\56\54\44\52\51\48\54\53\44\53\50\50\56\49\44\51\52\54\56\49\44\53\57\54\51\54\44\52\54\48\51\53\44\51\56\56\53\56\44\54\56\53\57\52\44\54\53\51\48\48\44\53\49\48\49\49\44\52\49\56\54\54\44\54\56\51\57\55\44\52\53\48\50\55\44\54\56\54\55\56\44\54\56\57\50\52\44\51\53\48\52\55\44\53\53\54\52\54\44\52\51\50\56\53\44\53\56\48\52\51\44\52\52\54\52\51\44\53\55\57\48\49\44\53\53\55\54\51\44\53\55\49\49\53\44\54\56\56\52\54\44\52\51\54\56\52\44\54\53\54\56\49\44\53\53\56\53\56\44\51\56\51\55\50\44\54\51\53\57\57\44\53\51\51\56\54\44\54\49\57\54\49\44\52\50\48\56\52\44\52\48\50\49\53\44\52\51\51\53\52\44\53\56\55\55\49\44\52\51\54\50\52\44\53\54\56\52\57\44\52\56\52\55\57\44\52\49\49\56\54\44\52\50\53\50\50\44\52\57\50\51\50\44\53\56\48\54\50\44\54\52\49\50\56\44\52\50\54\48\55\44\53\50\57\49\54\44\51\56\56\51\55\44\52\48\56\54\56\44\51\54\49\49\48\44\53\53\54\53\50\44\51\54\56\55\55\44\51\53\54\54\54\44\54\56\50\54\54\44\52\57\51\57\50\44\54\56\52\52\55\44\54\49\55\55\57\44\52\52\49\48\50\44\53\57\50\52\56\44\53\49\54\52\48\44\51\54\53\57\55\44\53\55\50\53\56\44\53\50\53\56\52\44\52\49\48\53\49\44\52\48\51\48\54\44\52\50\51\52\54\44\53\54\55\48\54\44\53\51\53\52\49\44\54\49\48\49\51\44\54\50\49\51\56\44\54\53\54\52\48\44\54\49\57\49\55\44\54\51\52\57\54\44\52\51\54\55\56\44\52\57\54\48\57\44\51\57\54\57\53\44\52\54\55\49\51\44\53\50\57\52\50\44\53\56\56\55\55\44\52\51\57\57\57\44\52\54\52\52\52\44\51\52\57\57\57\44\54\55\57\50\50\44\52\53\54\48\57\44\53\57\50\49\48\44\53\54\50\49\52\44\53\52\52\48\50\44\51\52\53\50\55\44\54\56\49\49\51\44\52\52\52\55\55\44\52\48\51\50\55\44\54\49\55\50\55\44\53\56\48\49\53\44\54\53\54\56\55\44\54\54\48\52\50\44\54\55\55\54\57\44\54\52\53\55\55\44\52\55\57\50\51\44\53\50\54\48\48\44\54\53\55\54\54\44\54\56\52\50\48\44\52\53\55\50\54\44\54\50\50\54\55\44\52\52\55\54\49\44\51\53\56\55\52\44\51\55\55\50\54\44\53\50\48\56\55\44\52\53\57\57\53\44\51\53\51\57\53\44\51\52\53\57\51\44\52\54\49\51\54\44\53\56\54\54\55\44\52\55\55\54\54\44\54\48\56\51\50\44\53\50\50\51\53\44\52\49\52\49\55\44\53\48\55\49\57\44\54\57\48\49\57\44\51\56\56\48\48\44\52\48\51\51\51\44\53\54\53\55\49\44\53\55\57\52\55\44\54\49\54\49\48\44\53\57\52\53\55\44\54\49\48\55\56\44\54\56\56\55\48\44\52\51\54\52\57\44\52\54\51\57\57\44\54\55\57\52\56\44\51\55\50\54\48\44\53\56\55\48\51\44\51\56\51\53\52\44\53\54\56\57\51\44\51\56\51\52\48\44\53\53\56\48\57\44\52\51\50\48\53\44\53\51\50\56\54\44\51\55\54\51\56\44\51\57\55\53\55\44\53\52\55\53\50\44\51\57\54\51\51\44\52\49\55\52\56\44\51\53\52\51\49\44\52\49\53\48\48\44\54\53\55\49\48\44\52\51\49\50\51\44\51\57\50\54\52\44\54\54\57\48\54\44\51\54\53\48\49\44\53\51\51\56\51\44\53\49\53\56\54\44\52\57\56\55\54\44\53\51\52\56\48\44\53\52\57\49\56\44\53\54\50\48\50\44\52\49\54\57\56\44\53\57\53\57\49\44\54\51\57\56\50\44\54\52\50\56\49\44\52\57\57\52\53\44\52\54\54\56\53\44\54\51\51\57\55\44\52\56\50\51\57\44\52\52\51\55\50\44\53\56\53\55\55\44\53\49\51\56\55\44\54\52\49\50\54\44\54\56\56\52\48\44\52\52\52\56\56\44\54\54\55\55\54\44\53\52\56\57\50\44\53\53\49\50\53\44\51\54\55\53\51\44\52\52\54\48\48\44\52\49\49\48\55\44\51\57\54\49\57\44\52\52\55\54\52\44\51\56\56\53\55\44\51\57\54\49\48\44\52\51\55\54\48\44\53\57\52\55\50\44\51\53\55\50\56\44\54\50\51\49\50\44\51\57\48\48\51\44\54\55\52\50\50\44\51\57\55\48\57\44\52\53\57\49\55\44\52\55\54\54\49\44\54\48\53\55\55\44\51\56\55\50\51\44\54\54\48\51\51\44\52\57\49\49\48\44\52\55\50\55\54\44\51\57\54\52\52\44\54\54\54\49\48\44\53\50\55\53\56\44\54\48\54\51\51\44\52\56\57\57\50\44\51\52\53\52\49\44\52\55\57\48\54\44\51\56\49\56\54\44\52\50\53\48\48\44\52\48\48\54\56\44\53\56\57\48\49\44\53\52\57\50\54\44\54\55\50\53\52\44\52\55\54\52\53\44\52\48\53\56\54\44\54\52\56\48\48\44\54\54\49\49\56\44\54\55\56\55\48\44\52\56\54\56\50\44\52\55\49\57\52\44\51\55\48\54\49\44\52\53\57\53\53\44\53\49\56\49\52\44\52\54\51\50\48\44\53\56\49\54\49\44\53\55\53\52\55\44\52\52\49\50\53\44\52\49\48\56\56\44\53\55\51\55\51\44\53\51\57\53\54\44\52\57\51\49\57\44\54\52\50\53\57\44\53\52\54\57\52\44\53\48\53\51\50\44\51\56\55\51\52\44\53\53\49\57\57\44\53\51\56\54\48\44\52\55\52\51\52\44\51\55\55\52\56\44\52\56\50\52\51\44\52\55\49\56\51\44\51\54\54\53\55\44\54\50\56\54\56\44\53\56\53\55\53\44\53\48\56\56\57\44\53\54\48\57\54\44\51\57\49\53\52\44\53\48\50\56\52\44\51\52\57\55\48\44\51\57\57\55\56\44\53\57\54\51\52\44\54\48\52\51\53\44\53\53\56\57\49\44\53\50\54\57\57\44\52\54\54\51\55\44\52\50\57\48\53\44\53\54\57\54\53\44\54\51\53\54\53\44\52\53\49\50\49\44\52\57\51\56\54\44\53\48\49\55\52\44\54\53\48\55\49\44\52\48\57\54\52\44\52\56\51\57\52\44\54\55\50\53\56\44\52\54\55\57\57\44\53\53\49\53\51\44\53\51\52\56\56\44\53\51\55\52\56\44\53\57\52\54\48\44\54\49\52\55\56\44\53\52\53\50\54\44\54\52\49\56\55\44\54\49\51\55\50\44\51\55\54\50\56\44\54\51\53\54\50\44\52\54\48\56\48\44\52\50\55\52\55\44\53\52\55\53\54\44\53\51\54\49\50\44\54\55\49\48\52\44\51\57\53\52\51\44\51\57\50\48\52\44\54\56\54\53\50\44\52\57\56\54\50\44\52\55\56\57\56\44\54\52\49\50\52\44\52\48\50\51\51\44\53\48\48\52\48\44\54\54\48\48\48\44\52\57\53\56\49\44\52\53\57\52\51\44\54\48\50\48\57\44\53\57\48\54\51\44\54\56\51\48\50\44\51\57\56\52\50\44\54\52\55\57\51\44\54\51\52\53\50\44\52\52\57\48\55\44\52\50\53\54\57\44\53\48\51\55\55\44\53\49\56\53\51\44\54\55\55\48\51\44\53\54\57\48\52\44\52\52\55\48\51\44\51\56\56\57\52\44\53\56\57\51\50\44\54\56\55\53\53\44\54\55\57\54\50\44\52\55\53\50\48\44\54\53\53\53\49\44\53\49\49\54\51\44\54\53\51\51\52\44\52\55\57\48\51\44\52\49\50\51\48\44\54\56\53\49\56\44\54\52\53\49\53\44\52\55\50\54\53\44\52\52\53\52\49\44\54\56\54\56\53\44\54\48\50\50\48\44\53\50\49\54\53\44\53\49\49\48\53\44\54\55\55\50\50\44\53\51\54\48\52\44\54\49\53\51\54\44\54\48\57\55\56\44\51\56\53\56\53\44\53\53\53\49\50\44\54\50\54\53\51\44\53\56\51\57\54\44\53\50\57\48\51\44\54\55\48\56\48\44\52\55\49\57\51\44\54\51\53\57\56\44\54\52\51\49\53\44\51\52\56\54\50\44\52\51\55\49\51\44\54\52\56\50\50\44\53\57\55\50\51\44\53\56\53\53\49\44\52\57\55\53\52\44\51\57\50\57\57\44\51\52\56\55\51\44\54\50\49\57\50\44\52\55\56\52\53\44\51\55\55\48\48\44\52\57\53\48\49\44\53\56\51\48\53\44\52\49\56\49\55\44\51\55\52\56\53\44\52\52\56\57\57\44\52\52\49\51\52\44\53\56\51\56\53\44\53\56\54\52\51\44\52\56\53\54\48\44\53\52\49\56\55\44\51\53\51\48\50\44\53\55\50\48\57\44\52\57\56\57\54\44\51\56\52\57\50\44\51\54\48\52\52\44\54\54\53\50\52\44\54\49\50\50\56\44\51\55\48\56\48\44\52\50\50\52\50\44\53\52\55\55\50\44\54\53\54\53\52\44\53\56\53\53\56\44\53\53\57\49\51\44\51\55\53\57\56\44\51\54\51\53\54\44\51\55\52\53\48\44\54\55\56\54\57\44\51\55\52\54\48\44\53\54\48\51\56\44\51\54\49\55\54\44\53\48\55\55\49\44\53\49\48\54\50\44\51\55\51\50\52\44\54\53\53\56\52\44\52\53\55\53\51\44\51\54\49\49\52\44\52\53\48\54\49\44\54\48\50\53\50\44\54\48\48\49\55\44\53\49\57\49\51\44\53\52\51\51\51\44\52\55\55\56\54\44\53\57\50\52\48\44\53\51\55\53\50\44\53\54\53\53\56\44\52\48\51\57\57\44\52\57\50\54\48\44\52\51\55\55\48\44\51\57\49\57\56\44\51\57\57\51\50\44\54\56\54\56\55\44\52\48\57\49\55\44\53\51\53\56\55\44\54\51\57\55\57\44\51\55\48\53\54\44\51\52\55\51\56\44\54\56\53\52\51\44\54\56\55\55\52\44\52\50\49\56\56\44\53\49\56\53\52\44\52\49\48\57\52\44\54\49\50\50\48\44\53\53\56\51\54\44\52\51\53\49\53\44\53\51\51\51\49\44\53\56\53\49\51\44\52\51\56\48\52\44\51\53\55\49\53\44\54\51\54\57\55\44\53\56\56\57\52\44\52\49\49\53\53\44\54\49\51\57\53\44\51\56\52\57\57\44\53\51\49\56\48\44\52\55\56\48\56\44\54\50\54\54\50\44\52\52\55\54\56\44\53\50\56\52\53\44\54\48\57\49\48\44\52\54\54\48\50\44\51\57\48\50\55\44\51\55\55\49\53\44\52\51\50\49\53\44\53\54\48\53\50\44\52\48\48\48\52\44\54\55\49\51\54\44\53\50\49\57\53\44\51\54\52\53\51\44\53\57\48\56\50\44\54\50\55\56\56\44\54\50\54\48\52\44\54\56\50\55\56\44\53\55\54\50\49\44\53\50\56\51\49\44\54\51\54\57\52\44\52\55\52\51\56\44\52\57\56\52\56\44\51\54\51\54\57\44\54\54\55\51\55\44\51\57\57\55\50\44\52\48\52\51\50\44\51\54\50\54\55\44\54\48\56\54\54\44\52\53\53\48\56\44\52\54\48\52\48\44\54\53\51\51\50\44\54\52\56\55\48\44\52\50\50\49\55\44\54\53\57\49\50\44\54\51\50\55\52\44\52\57\48\48\48\44\54\53\48\54\55\44\51\55\53\48\53\44\53\51\49\57\51\44\52\51\54\48\51\44\53\54\55\57\57\44\51\53\54\48\54\44\52\56\56\49\48\44\53\55\48\55\57\44\53\49\50\51\51\44\53\50\50\55\48\44\51\54\57\52\55\44\53\57\48\52\54\44\51\57\56\57\56\44\52\49\57\57\54\44\54\52\57\54\50\44\53\53\57\55\50\44\52\51\50\53\53\44\54\56\50\51\53\44\53\48\52\52\54\44\53\48\56\55\57\44\52\52\48\50\54\44\52\55\57\55\54\44\54\51\49\51\52\44\53\48\52\56\51\44\52\53\54\55\54\44\54\51\56\51\50\44\52\52\57\49\52\44\51\54\57\54\48\44\53\52\48\56\48\44\53\56\57\51\56\44\53\48\53\54\56\44\54\48\57\57\50\44\52\56\52\54\56\44\52\53\51\48\54\44\52\53\50\49\48\44\52\54\48\56\57\44\53\51\49\52\55\44\54\52\51\49\50\44\52\54\54\52\50\44\52\52\57\51\53\44\53\50\53\52\55\44\51\56\56\49\54\44\53\56\51\52\56\44\54\55\52\50\54\44\54\56\51\55\52\44\53\51\51\53\54\44\51\54\50\57\53\44\53\51\53\48\50\44\53\48\57\51\48\44\53\48\50\54\51\44\53\50\53\56\56\44\51\54\51\49\53\44\54\50\50\56\54\44\53\57\57\52\56\44\51\56\57\49\48\44\52\54\50\48\57\44\52\55\50\54\52\44\53\56\52\55\48\44\52\49\56\57\52\44\52\50\55\53\57\44\53\52\51\57\54\44\52\54\51\56\55\44\54\49\52\55\51\44\52\56\54\52\56\44\54\53\53\55\50\44\52\49\56\53\54\44\54\48\52\54\54\44\53\54\51\54\50\44\53\50\50\54\53\44\54\55\53\49\52\44\54\56\54\54\49\44\52\52\52\52\57\44\52\57\55\57\49\44\53\54\55\53\55\44\52\56\48\54\56\44\54\55\48\50\57\44\52\49\52\49\49\44\52\50\49\54\48\44\52\55\49\48\51\44\52\57\53\48\54\44\51\52\54\54\49\44\51\53\54\50\48\44\53\54\53\53\48\44\53\57\50\54\49\44\54\54\52\57\56\44\52\50\48\54\53\44\53\54\57\57\57\44\53\50\48\52\57\44\51\52\53\56\49\44\53\49\57\51\56\44\54\52\52\48\50\44\54\51\52\53\51\44\52\52\57\53\57\44\51\57\55\56\55\44\54\50\56\52\54\44\52\56\53\50\48\44\52\52\54\50\57\44\52\54\55\50\51\44\51\54\49\49\53\44\53\51\52\52\53\44\52\48\56\48\49\44\54\56\48\53\52\44\53\49\54\54\55\44\52\55\49\54\53\44\53\48\53\50\51\44\52\51\49\55\52\44\52\49\53\48\53\44\54\50\51\50\51\44\51\54\49\56\54\44\53\56\53\51\49\44\53\57\53\56\48\44\53\48\56\48\55\44\53\56\48\51\51\44\53\48\57\51\55\44\53\55\56\48\51\44\53\49\53\53\49\44\53\53\56\51\55\44\54\49\52\57\55\44\54\56\56\52\52\44\53\51\52\51\48\44\52\56\57\54\50\44\54\52\54\55\50\44\52\55\55\54\50\44\53\48\55\53\57\44\52\57\56\49\57\44\54\48\54\48\51\44\52\50\53\56\55\44\51\53\50\54\49\44\54\54\57\48\57\44\54\51\52\57\55\44\53\52\55\49\55\44\51\57\56\53\51\44\53\50\56\51\53\44\52\55\52\56\54\44\52\55\54\49\48\44\52\55\54\55\53\44\54\54\52\53\53\44\52\54\55\51\49\44\52\55\57\55\56\44\51\54\51\51\52\44\52\54\50\55\53\44\51\54\50\53\57\44\51\57\50\55\54\44\52\56\57\56\51\44\54\54\54\52\54\44\54\49\51\48\50\44\53\50\53\49\56\44\51\55\57\55\48\44\52\56\50\53\55\44\54\53\52\49\49\44\53\55\51\50\53\44\54\52\48\48\53\44\53\56\53\55\56\44\54\51\50\48\57\44\52\52\56\50\52\44\54\54\50\55\56\44\52\54\54\50\57\44\52\52\52\49\53\44\52\56\49\56\49\44\52\53\52\56\52\44\54\49\57\49\50\44\54\54\53\56\50\44\51\56\51\56\53\44\52\52\55\57\57\44\52\51\55\57\52\44\53\56\57\56\48\44\54\48\48\56\55\44\52\53\54\52\51\44\52\57\53\51\50\44\51\56\52\52\50\44\51\57\56\51\53\44\51\57\55\54\50\44\53\56\51\57\53\44\52\57\57\49\52\44\52\54\49\53\57\44\54\54\52\55\55\44\53\56\52\53\48\44\52\56\54\57\49\44\53\57\57\54\52\44\53\48\49\53\51\44\53\57\56\55\56\44\53\52\57\53\50\44\53\52\49\51\57\44\53\55\50\55\54\44\51\52\54\50\54\44\52\51\49\48\51\44\54\52\51\53\55\44\54\56\57\50\48\44\54\51\51\57\54\44\53\54\55\51\55\44\53\55\57\49\52\44\52\56\57\49\54\44\53\51\56\56\51\44\54\53\51\51\56\44\53\57\52\52\52\44\52\55\49\48\57\44\54\48\50\53\55\44\54\53\57\51\54\44\54\51\52\49\54\44\54\52\51\48\55\44\54\50\52\57\54\44\53\51\57\55\57\44\51\54\54\56\49\44\52\51\56\51\53\44\51\53\56\55\49\44\53\52\57\55\56\44\54\48\57\51\53\44\51\57\56\52\51\44\54\51\50\50\55\44\53\55\57\56\51\44\53\48\51\52\56\44\53\51\50\49\52\44\53\48\51\56\53\44\52\48\48\55\48\44\54\51\48\55\49\44\52\53\55\52\55\44\51\57\55\52\49\44\51\52\53\49\57\44\52\50\52\55\48\44\52\51\54\57\56\44\53\57\50\53\52\44\54\55\51\55\49\44\54\55\49\50\48\44\53\55\52\50\49\44\54\49\50\55\48\44\54\49\56\55\50\44\52\57\54\54\50\44\53\49\49\50\56\44\53\48\52\55\53\44\54\50\53\49\55\44\53\56\54\54\49\44\53\53\49\51\49\44\54\52\56\49\53\44\52\52\53\49\53\44\52\57\56\49\49\44\54\50\56\52\49\44\52\53\56\55\50\44\51\53\53\57\48\44\52\48\57\51\48\44\51\52\57\49\50\44\53\51\51\52\50\44\54\55\57\55\57\44\53\54\50\49\51\44\54\53\49\55\49\44\51\52\56\56\53\44\52\51\49\52\54\44\54\56\57\50\53\44\54\50\55\57\53\44\54\55\53\55\53\44\52\55\50\54\48\44\51\56\56\57\53\44\52\50\56\51\52\44\54\56\56\48\48\44\51\54\48\48\54\44\52\53\48\56\54\44\52\48\52\56\57\44\52\51\49\50\55\44\52\54\55\48\48\44\52\49\55\50\55\44\51\53\56\53\57\44\54\49\51\53\54\44\51\57\53\56\50\44\53\49\53\55\52\44\51\55\51\54\57\44\53\52\52\54\52\44\54\50\56\52\56\44\51\57\54\54\55\44\51\55\56\55\48\44\53\49\52\48\57\44\52\51\55\50\48\44\52\48\52\53\54\44\53\50\52\54\52\44\53\52\49\49\51\44\53\51\53\50\49\44\54\55\53\50\53\44\54\48\57\53\48\44\51\54\54\55\56\44\51\57\52\56\52\44\51\54\50\55\53\44\54\55\55\56\55\44\51\54\56\50\56\44\54\55\48\52\52\44\54\50\53\51\51\44\54\56\55\57\51\44\52\50\55\56\56\44\53\53\54\48\53\44\53\49\55\56\57\44\54\56\56\57\48\44\54\53\56\53\55\44\54\53\54\51\56\44\54\51\48\57\53\44\53\54\56\56\51\44\51\52\55\57\53\44\54\52\50\48\50\44\53\51\52\50\57\44\54\55\55\54\51\44\54\52\50\55\54\44\53\51\54\49\48\44\53\56\54\53\52\44\54\54\54\56\56\44\51\56\54\55\55\44\52\52\52\48\49\44\52\52\51\48\49\44\53\51\57\49\57\44\53\52\56\48\48\44\51\57\48\55\52\44\54\51\54\51\48\44\53\48\52\50\48\44\54\48\55\57\52\44\53\50\52\54\54\44\53\52\54\50\48\44\53\48\52\48\53\44\53\48\54\49\48\44\51\54\51\49\57\44\53\56\51\57\52\44\52\50\49\49\50\44\52\51\57\49\55\44\54\54\55\50\50\44\52\54\49\53\55\44\53\55\49\57\48\44\54\48\49\53\54\44\53\51\50\49\55\44\53\56\52\50\57\44\51\53\57\49\52\44\51\52\54\54\57\44\52\52\54\52\53\44\53\55\57\54\54\44\54\54\53\52\53\44\52\52\52\53\50\44\52\56\57\48\57\44\51\57\57\48\55\44\51\57\54\50\51\44\54\55\49\51\53\44\51\54\52\51\53\44\52\49\55\53\50\44\51\54\54\49\54\44\52\57\57\50\52\44\54\57\48\55\49\44\53\56\53\52\52\44\53\56\49\57\48\44\53\56\50\54\50\44\52\53\52\56\48\44\52\57\56\48\49\44\54\52\50\49\49\44\51\53\55\52\51\44\54\54\55\51\57\44\52\48\53\54\54\44\54\48\48\48\55\44\52\52\54\54\51\44\51\56\57\57\55\44\52\49\57\50\51\44\51\53\51\49\50\44\53\55\55\57\48\44\53\53\53\50\49\44\52\49\50\55\57\44\53\52\56\48\54\44\53\56\54\48\53\44\51\53\48\51\50\44\51\53\52\57\48\44\53\54\54\52\56\44\53\53\54\48\57\44\53\56\51\53\50\44\54\53\54\52\55\44\54\51\57\57\53\44\54\50\55\50\51\44\53\57\51\53\56\44\53\57\55\56\53\44\52\48\56\54\50\44\52\48\51\48\53\44\51\56\51\57\51\44\53\52\50\55\48\44\52\48\50\56\55\44\52\50\54\52\52\44\51\54\56\49\51\44\51\56\51\55\57\44\54\48\50\56\57\44\52\51\48\56\49\44\51\57\51\49\49\44\53\48\55\56\52\44\51\57\49\51\49\44\54\51\50\54\57\44\52\51\55\56\52\44\51\57\54\53\51\44\52\54\54\56\57\44\51\57\54\48\50\44\54\55\54\55\54\44\54\48\55\49\55\44\53\56\48\53\53\44\53\55\50\49\49\44\52\55\48\51\51\44\53\53\49\53\53\44\54\57\48\54\50\44\52\55\56\56\51\44\54\51\55\52\48\44\52\49\49\51\54\44\54\52\57\51\54\44\51\56\57\49\50\44\52\52\49\49\52\44\53\50\56\53\56\44\53\56\54\57\55\44\53\55\55\56\50\44\53\52\54\48\48\44\54\56\49\50\54\44\54\51\53\52\51\44\52\56\49\49\55\44\53\52\57\48\48\44\52\48\55\49\52\44\54\54\54\56\55\44\54\54\48\48\52\44\54\54\54\54\50\44\51\54\56\52\56\44\54\51\52\51\49\44\51\55\54\57\48\44\51\57\57\48\50\44\53\53\50\54\54\44\54\51\51\54\54\44\54\51\55\56\48\44\54\57\49\48\55\44\52\56\51\57\48\44\52\53\53\54\53\44\54\51\54\55\56\44\54\52\51\49\54\44\52\51\50\49\57\44\54\49\52\56\54\44\52\50\50\55\57\44\54\56\53\52\50\44\51\54\50\49\54\44\53\48\48\52\56\44\53\54\48\50\48\44\53\52\54\55\49\44\51\53\49\56\55\44\52\48\49\56\48\44\52\53\48\57\48\44\52\54\52\52\55\44\54\49\54\52\57\44\52\50\48\54\49\44\53\55\57\56\54\44\51\55\53\49\51\44\52\50\54\53\49\44\51\53\49\56\50\44\53\49\52\56\50\44\51\52\55\55\57\44\54\55\57\48\52\44\54\50\51\56\50\44\52\51\54\50\51\44\54\53\49\52\48\44\53\55\56\52\50\44\52\55\57\55\49\44\53\48\48\56\48\44\54\54\51\56\57\44\53\49\57\53\55\44\52\51\52\51\55\44\53\50\49\52\57\44\52\51\49\57\57\44\52\49\48\48\53\44\54\53\50\56\54\44\51\56\57\52\56\44\52\52\55\48\53\44\53\49\54\49\56\44\53\50\52\49\56\44\54\50\56\57\50\44\53\52\55\55\53\44\52\51\55\49\54\44\53\53\49\54\49\44\52\52\48\53\49\44\53\57\56\49\53\44\53\52\56\56\51\44\53\57\48\51\48\44\53\49\57\52\49\44\54\56\53\50\51\44\54\53\55\55\49\44\54\51\57\57\50\44\53\51\48\49\56\44\53\55\53\49\55\44\53\54\53\52\48\44\54\54\56\48\50\44\52\57\55\48\56\44\52\50\55\51\55\44\53\53\56\52\49\44\51\56\56\55\57\44\53\50\54\55\57\44\52\52\52\55\48\44\52\57\50\57\55\44\54\53\48\51\52\44\51\54\57\55\50\44\53\56\54\51\51\44\53\50\57\55\57\44\53\48\53\57\49\44\53\53\53\53\57\44\51\55\55\50\51\44\52\56\52\53\57\44\51\54\54\48\51\44\51\57\54\48\51\44\53\54\56\53\53\44\53\53\48\51\55\44\54\54\56\55\53\44\51\56\50\50\52\44\53\50\56\48\55\44\54\51\51\55\57\44\54\55\48\57\51\44\53\51\51\55\49\44\53\51\52\54\52\44\53\49\53\56\51\44\52\56\50\55\48\44\53\48\55\51\51\44\52\54\49\50\50\44\54\50\50\51\48\44\54\48\55\52\49\44\54\51\54\54\56\44\54\54\57\48\49\44\53\48\57\50\57\44\52\53\51\51\48\44\51\55\53\52\57\44\52\48\51\55\50\44\51\55\55\55\57\44\54\55\49\55\57\44\54\57\48\53\54\44\54\55\52\55\52\44\54\53\53\48\52\44\52\52\56\56\48\44\53\50\57\50\52\44\52\57\56\49\51\44\52\54\51\53\53\44\54\53\51\55\48\44\54\53\50\54\52\44\52\52\50\55\51\44\51\56\55\48\54\44\54\56\48\50\55\44\53\48\51\50\52\44\54\48\51\52\50\44\52\56\54\57\52\44\52\48\53\48\53\44\52\57\53\50\48\44\54\48\48\48\57\44\52\57\51\55\52\44\53\51\56\50\56\44\52\56\55\53\57\44\52\57\56\56\57\44\51\57\48\52\52\44\51\53\48\52\53\44\52\50\52\55\49\44\54\52\54\55\54\44\52\48\57\57\53\44\51\53\49\50\49\44\51\54\50\55\57\44\52\53\54\52\56\44\54\49\53\50\54\44\53\55\49\52\54\44\51\54\57\55\51\44\52\49\56\53\56\44\53\50\49\49\50\44\54\56\57\52\57\44\53\50\49\56\53\44\54\54\56\55\51\44\54\52\56\56\48\44\51\56\54\55\54\44\51\55\56\50\49\44\53\51\56\50\57\44\53\53\54\49\52\44\51\53\53\54\51\44\53\52\54\50\52\44\51\57\51\48\54\44\54\48\56\49\48\44\51\57\56\54\51\44\52\54\54\57\49\44\53\54\53\54\53\44\52\52\55\49\56\44\53\57\48\48\48\44\52\50\56\56\56\44\54\56\54\57\57\44\52\48\57\50\56\44\53\54\51\52\53\44\53\50\54\57\55\44\53\50\51\56\57\44\52\57\54\49\57\44\53\55\49\53\57\44\54\48\54\56\54\44\52\53\54\55\51\44\53\57\52\49\55\44\53\50\57\53\52\44\54\55\48\48\49\44\54\48\52\50\49\44\53\49\51\56\50\44\51\54\49\49\49\44\52\48\55\52\48\44\52\49\49\48\51\44\53\48\49\49\54\44\52\50\53\49\53\44\52\56\56\57\57\44\53\56\53\52\56\44\54\54\54\53\52\44\53\54\49\53\48\44\51\56\51\51\54\44\52\49\48\50\56\44\52\52\48\51\51\44\52\57\54\52\48\44\54\48\53\52\52\44\51\57\56\56\49\44\51\52\56\51\55\44\52\49\56\56\57\44\52\49\52\53\52\44\52\50\52\50\51\44\53\49\55\53\50\44\52\49\52\56\48\44\54\54\49\54\53\44\53\49\57\54\53\44\53\54\57\54\54\44\53\57\48\50\56\44\53\53\56\54\51\44\54\51\52\53\54\44\53\56\56\49\51\44\53\48\52\56\57\44\53\50\54\57\53\44\52\54\49\50\57\44\53\55\56\55\52\44\54\55\49\52\57\44\54\50\54\54\57\44\54\56\49\57\51\44\53\57\50\48\51\44\53\57\54\55\56\44\54\56\53\54\56\44\53\55\51\49\49\44\52\57\53\56\52\44\52\51\56\54\53\44\54\54\54\51\51\44\52\48\49\57\57\44\54\57\49\48\51\44\54\53\55\51\49\44\51\55\49\56\50\44\51\57\56\50\49\44\54\48\51\57\57\44\54\50\51\56\48\44\52\54\56\50\55\44\53\56\55\48\54\44\52\57\48\55\52\44\54\53\54\56\56\44\54\53\57\49\56\44\54\52\52\51\56\44\51\55\51\57\53\44\54\52\54\52\49\44\53\51\56\57\52\44\54\55\57\57\48\44\53\57\52\56\55\44\53\53\52\49\55\44\52\48\54\53\51\44\52\56\53\51\48\44\51\53\55\56\56\44\51\56\57\53\53\44\53\48\54\49\53\44\52\53\53\56\51\44\54\48\54\57\48\44\54\56\50\49\50\44\54\56\51\51\49\44\53\54\53\52\55\44\52\56\51\53\50\44\54\53\49\50\50\44\54\49\53\50\52\44\52\54\51\52\52\44\52\53\52\57\51\44\53\54\49\52\51\44\52\51\49\54\51\44\53\48\57\57\52\44\54\56\49\48\50\44\51\57\54\57\51\44\52\49\51\50\53\44\53\50\48\53\54\44\54\53\48\54\50\44\53\49\49\48\52\44\52\48\54\51\56\44\51\55\52\51\56\44\52\48\55\52\52\44\54\56\55\51\53\44\54\48\51\52\56\44\52\52\48\48\55\44\52\49\56\55\57\44\54\49\54\55\49\44\54\54\48\53\56\44\52\50\48\52\53\44\52\53\53\53\52\44\52\57\50\49\52\44\51\53\55\55\54\44\52\48\49\50\57\44\54\52\57\53\57\44\51\53\57\55\53\44\51\52\55\53\53\44\54\53\54\57\57\44\53\56\56\51\57\44\52\54\55\49\49\44\51\53\54\53\55\44\52\50\51\53\57\44\52\56\55\55\53\44\52\56\56\48\51\44\52\53\52\56\54\44\53\57\53\55\55\44\52\57\49\56\54\44\53\54\57\52\50\44\52\55\49\53\48\44\53\48\49\54\49\44\53\52\52\57\55\44\53\51\53\55\53\44\53\49\56\49\49\44\51\57\56\49\51\44\53\54\49\52\48\44\52\49\57\50\48\44\54\56\56\51\51\44\52\57\54\50\54\44\53\50\53\53\50\44\52\57\55\55\53\44\54\54\51\52\49\44\51\57\55\57\54\44\53\50\50\49\55\44\54\54\51\55\50\44\51\53\55\49\55\44\52\56\51\56\56\44\54\52\51\52\56\44\54\51\52\56\57\44\54\48\56\57\52\44\52\57\49\50\53\44\54\55\54\55\52\44\53\55\53\57\51\44\53\52\54\55\48\44\53\48\53\48\52\44\53\50\56\49\57\44\53\56\56\56\51\44\54\56\49\57\50\44\51\54\55\55\55\44\51\54\50\48\55\44\54\49\55\51\53\44\52\56\52\54\50\44\51\57\57\51\54\44\52\54\49\56\53\44\53\52\55\48\48\44\51\57\57\56\54\44\54\48\56\56\51\44\54\50\52\48\57\44\51\52\57\49\55\44\51\56\53\54\53\44\53\57\52\50\50\44\54\56\52\56\54\44\52\54\49\56\56\44\52\50\51\50\51\44\54\49\55\50\57\44\53\50\56\50\57\44\52\53\51\55\54\44\53\51\57\56\51\44\53\57\53\57\50\44\53\50\49\48\56\44\54\48\54\50\48\44\53\51\56\55\50\44\54\54\52\51\48\44\53\53\49\51\56\44\52\57\49\55\53\44\52\52\57\53\56\44\54\56\53\51\54\44\52\49\56\50\48\44\51\54\51\48\55\44\52\48\48\56\56\44\52\57\49\49\56\44\51\52\56\52\54\44\54\52\50\55\48\44\54\55\57\54\53\44\53\51\48\50\51\44\51\55\56\54\54\44\52\55\55\52\55\44\53\51\57\52\49\44\52\50\51\57\55\44\53\54\50\51\54\44\52\50\50\55\55\44\54\52\52\51\54\44\53\54\49\49\57\44\54\53\54\54\48\44\53\57\57\52\55\44\53\57\53\56\54\44\53\48\55\53\56\44\52\55\51\55\48\44\51\57\54\54\50\44\53\49\55\49\50\44\54\52\49\57\48\44\51\55\56\51\49\44\54\50\48\52\56\44\53\55\57\50\55\44\53\54\55\50\53\44\54\53\53\52\53\44\52\52\48\49\55\44\51\57\50\55\51\44\51\53\54\52\51\44\54\48\55\57\48\44\53\53\50\52\51\44\54\54\52\57\51\44\53\53\56\49\51\44\54\51\53\48\51\44\53\53\51\49\52\44\52\55\56\49\55\44\51\54\51\48\53\44\52\53\56\57\49\44\54\53\53\55\48\44\52\51\49\49\49\44\51\55\55\54\52\44\53\52\50\50\55\44\52\55\51\48\48\44\54\51\56\55\51\44\53\49\51\53\51\44\51\56\52\48\57\44\54\54\48\51\55\44\53\50\51\48\56\44\53\57\50\54\56\44\51\56\49\55\51\44\52\53\54\48\50\44\54\55\52\53\51\44\53\54\55\57\52\44\53\54\52\51\49\44\53\52\48\51\49\44\51\56\54\49\53\44\53\48\50\48\55\44\51\55\56\53\51\44\53\57\50\51\56\44\54\50\48\48\48\44\52\50\48\56\51\44\51\54\53\50\57\44\53\55\56\53\55\44\52\49\49\55\52\44\51\57\54\56\54\44\52\53\57\57\54\44\54\49\54\49\49\44\53\52\53\48\55\44\51\55\48\57\55\44\52\51\56\48\56\44\54\54\49\48\49\44\54\51\49\49\56\44\53\55\55\53\54\44\52\55\48\49\50\44\53\50\52\50\52\44\52\51\51\52\56\44\52\50\48\57\48\44\53\49\56\57\49\44\54\49\50\55\50\44\52\57\50\50\53\44\51\57\49\51\50\44\52\48\51\50\48\44\54\52\56\48\56\44\51\56\57\56\51\44\54\48\55\57\54\44\52\51\53\50\53\44\54\52\50\56\55\44\52\52\56\54\56\44\52\54\48\57\54\44\53\56\57\51\51\44\51\55\51\57\54\44\51\54\49\56\50\44\51\54\54\50\51\44\52\51\52\52\56\44\53\49\56\50\53\44\53\52\48\53\52\44\52\53\57\52\56\44\53\54\57\48\50\44\54\54\49\56\57\44\52\48\52\48\48\44\52\49\54\54\55\44\54\54\53\51\55\44\52\57\55\56\48\44\53\54\52\51\50\44\51\52\56\50\48\44\51\53\51\52\53\44\54\54\54\50\52\44\53\50\56\55\51\44\53\52\48\57\56\44\51\55\56\55\53\44\52\48\55\48\49\44\53\48\51\55\50\44\52\49\48\57\55\44\54\53\49\56\56\44\54\49\52\52\53\44\52\48\52\52\56\44\52\56\56\53\55\44\54\56\55\49\51\44\51\53\53\52\57\44\54\51\55\53\56\44\51\53\56\52\52\44\51\54\48\56\57\44\51\56\51\48\49\44\51\53\49\48\57\44\52\57\52\54\57\44\52\48\49\56\56\44\54\55\49\55\54\44\54\51\49\51\57\44\52\48\51\54\56\44\53\57\57\57\56\44\54\53\49\50\52\44\52\54\50\54\55\44\51\56\54\53\55\44\51\52\55\57\49\44\51\57\53\55\52\44\52\56\55\51\55\44\53\55\57\50\54\44\52\55\56\55\52\44\52\53\52\55\57\44\54\56\55\57\52\44\53\49\57\49\49\44\52\56\57\55\49\44\51\56\54\52\53\44\53\48\54\48\57\44\54\48\55\52\48\44\51\55\51\49\53\44\52\49\52\52\48\44\52\51\54\57\51\44\51\56\55\55\50\44\51\52\54\49\52\44\52\54\53\52\54\44\53\57\56\51\50\44\52\56\50\57\48\44\54\55\52\48\53\44\53\54\52\54\53\44\52\48\49\51\51\44\51\56\50\54\55\44\54\50\52\53\55\44\53\48\56\48\50\44\54\54\49\52\49\44\54\49\49\50\51\44\52\54\56\49\49\44\54\52\56\56\54\44\54\50\53\56\57\44\52\51\53\48\57\44\53\49\57\50\55\44\54\53\57\51\48\44\53\56\55\48\55\44\51\52\57\53\49\44\52\53\52\49\55\44\52\55\53\55\57\44\54\54\48\48\56\44\54\53\52\56\52\44\52\56\52\49\50\44\52\52\51\54\56\44\53\49\56\48\51\44\51\56\56\56\50\44\52\57\48\57\54\44\54\48\48\55\55\44\54\53\49\52\53\44\54\55\49\49\52\44\51\54\52\48\53\44\52\51\50\57\53\44\53\53\57\52\57\44\51\53\54\54\51\44\52\51\54\57\49\44\52\57\54\55\54\44\54\49\51\55\56\44\52\50\48\57\52\44\53\53\48\57\55\44\52\56\56\52\48\44\52\54\55\57\53\44\53\56\48\48\54\44\52\57\57\51\55\44\53\48\51\55\51\44\53\49\51\53\57\44\54\56\49\55\51\44\53\57\55\56\49\44\54\55\51\52\56\44\52\48\52\50\54\44\53\57\54\55\50\44\53\55\56\54\55\44\54\54\48\53\48\44\54\56\49\48\51\44\52\57\57\49\55\44\53\52\57\57\50\44\51\53\56\57\53\44\52\54\52\48\56\44\54\48\53\50\54\44\54\54\55\54\56\44\54\49\55\57\55\44\54\56\49\52\53\44\52\51\57\48\53\44\53\54\51\54\53\44\54\53\50\50\49\44\53\57\53\54\57\44\52\53\56\52\57\44\52\52\49\53\54\44\54\55\57\57\57\44\52\48\52\56\51\44\52\50\51\56\56\44\52\52\52\51\57\44\53\52\48\48\52\44\52\49\49\50\54\44\54\48\56\52\53\44\51\54\54\48\49\44\53\57\54\54\56\44\53\49\54\57\50\44\52\50\49\49\49\44\52\48\54\56\56\44\52\50\55\53\54\44\54\56\50\53\51\44\54\51\57\51\50\44\54\53\57\53\50\44\53\51\53\55\54\44\52\56\53\56\54\44\53\54\54\57\52\44\54\49\55\55\54\44\54\51\51\52\50\44\52\50\50\54\52\44\52\55\50\55\57\44\52\50\57\55\54\44\51\55\53\55\56\44\52\55\50\51\53\44\52\54\52\55\56\44\52\52\57\53\48\44\52\49\51\56\50\44\51\54\55\49\56\44\51\52\54\49\54\44\52\52\57\49\55\44\53\50\54\56\55\44\53\48\49\56\55\44\51\54\50\56\48\44\54\52\54\55\56\44\52\56\53\55\52\44\54\48\51\56\54\44\54\53\56\50\51\44\51\54\51\57\56\44\51\56\53\49\55\44\54\54\49\52\51\44\53\49\49\48\55\44\51\56\54\53\54\44\53\57\51\54\49\44\53\50\52\54\49\44\52\49\57\49\53\44\53\52\54\57\53\44\52\54\54\51\54\44\54\57\48\56\55\44\51\55\51\49\54\44\52\50\57\49\54\44\54\52\55\57\48\44\52\50\54\50\48\44\51\57\52\55\55\44\53\52\56\50\49\44\54\57\49\49\52\44\53\51\49\53\56\44\52\55\48\51\53\44\53\56\48\50\52\44\52\56\50\50\49\44\51\53\49\52\54\44\53\51\54\49\56\44\53\54\56\54\55\44\52\49\48\53\56\44\53\51\49\57\57\44\53\50\57\51\50\44\52\51\54\55\50\44\53\55\54\49\57\44\54\48\50\52\48\44\54\55\48\55\52\44\53\48\49\54\52\44\51\55\56\51\50\44\52\48\53\48\49\44\53\52\51\51\54\44\54\57\48\48\53\44\52\49\53\54\57\44\54\48\57\56\48\44\53\51\54\50\54\44\52\54\56\55\50\44\52\55\57\55\53\44\52\55\56\49\48\44\52\56\55\57\49\44\53\49\57\49\54\44\54\49\56\48\50\44\52\50\48\55\56\44\54\53\50\52\48\44\54\48\48\56\54\44\53\51\54\51\51\44\54\51\53\49\48\44\52\52\57\55\48\44\54\56\53\53\52\44\52\54\57\53\54\44\52\55\51\48\50\44\54\56\51\48\57\44\52\48\50\53\53\44\53\52\56\57\56\44\54\48\48\49\52\44\54\56\53\48\48\44\52\48\51\50\54\44\53\49\56\49\54\44\53\53\57\56\49\44\52\56\56\50\57\44\54\50\50\52\49\44\53\55\52\53\55\44\51\53\52\56\50\44\51\54\55\56\54\44\54\56\48\54\53\44\53\49\54\49\55\44\54\49\48\55\52\44\54\54\52\51\49\44\52\48\48\49\54\44\54\53\53\54\49\44\51\56\52\56\48\44\53\57\56\54\53\44\51\56\52\57\55\44\54\56\51\48\55\44\52\50\54\49\56\44\51\54\51\51\53\44\51\53\48\48\57\44\53\54\49\56\53\44\52\48\51\55\53\44\53\57\49\50\57\44\51\53\49\54\57\44\52\57\49\51\53\44\53\50\52\57\52\44\54\56\56\50\50\44\54\48\52\52\48\44\54\49\50\49\54\44\52\54\52\57\53\44\52\52\48\51\53\44\54\55\53\48\55\44\53\55\56\51\51\44\52\48\50\54\54\44\52\52\55\55\54\44\52\54\48\53\50\44\52\50\57\55\57\44\53\52\55\53\49\44\54\54\48\55\54\44\53\56\48\52\57\44\51\53\56\49\48\44\52\51\54\55\53\44\54\49\56\49\48\44\53\53\52\52\56\44\52\49\52\51\57\44\52\50\50\51\56\44\54\51\50\49\56\44\52\49\52\53\48\44\54\52\54\50\57\44\51\54\51\51\57\44\54\52\52\48\55\44\54\55\48\57\57\44\52\54\51\52\54\44\53\54\53\57\56\44\52\52\50\50\49\44\52\51\49\55\57\44\54\57\48\53\56\44\54\48\53\56\50\44\53\50\53\49\48\44\53\52\52\52\55\44\51\57\50\53\53\44\52\51\57\51\52\44\54\48\56\52\56\44\53\50\55\50\57\44\52\52\52\51\52\44\51\57\50\57\56\44\53\51\49\51\50\44\51\57\50\54\50\44\53\50\57\57\55\44\52\53\48\57\56\44\53\56\57\53\50\44\53\55\49\56\49\44\53\51\55\49\56\44\52\54\56\54\49\44\53\54\51\51\52\44\52\54\49\53\54\44\53\53\52\48\56\44\52\50\52\56\53\44\52\50\50\52\55\44\53\55\54\48\57\44\53\51\55\53\57\44\52\51\52\51\48\44\51\52\55\56\57\44\54\51\48\51\57\44\54\53\53\50\52\44\52\50\49\52\51\44\53\55\57\56\53\44\52\48\55\49\57\44\51\53\53\55\53\44\51\55\50\50\54\44\54\52\48\50\57\44\53\56\53\54\53\44\52\51\50\53\52\44\53\55\52\50\53\44\52\55\56\57\51\44\53\56\50\51\54\44\52\53\51\51\52\44\52\48\54\49\56\44\51\56\52\54\48\44\53\54\57\52\48\44\54\54\50\50\55\44\51\57\57\48\49\44\53\48\56\53\48\44\54\55\50\51\51\44\52\48\49\48\57\44\53\52\55\56\49\44\52\57\55\54\50\44\54\54\50\50\56\44\51\55\55\48\56\44\53\48\55\52\51\44\54\48\50\54\57\44\53\57\51\48\51\44\54\50\52\51\50\44\52\48\49\49\53\44\53\55\52\55\54\44\54\55\52\52\56\44\54\53\56\52\57\44\54\56\54\56\50\44\54\54\55\56\57\44\52\57\52\55\49\44\51\55\54\56\53\44\54\48\56\51\53\44\52\55\52\49\53\44\54\48\48\48\54\44\53\49\53\51\57\44\51\52\53\50\54\44\51\57\49\50\51\44\54\52\54\48\52\44\52\56\50\49\52\44\52\52\51\48\57\44\53\57\57\54\50\44\52\57\49\48\50\44\52\51\48\51\51\44\52\57\48\57\56\44\51\57\52\52\57\44\54\55\51\49\57\44\53\54\50\49\56\44\53\52\48\49\52\44\53\54\48\49\53\44\51\56\53\56\57\44\52\55\57\52\56\44\54\50\52\54\48\44\54\56\57\50\54\44\52\49\48\53\52\44\53\48\48\48\57\44\53\52\48\49\53\44\54\56\52\49\55\44\53\52\51\51\48\44\51\53\57\53\54\44\52\49\56\49\48\44\52\53\49\52\52\44\52\51\52\55\53\44\53\51\55\49\50\44\54\49\53\50\50\44\54\53\49\57\52\44\51\55\53\48\56\44\53\57\50\54\51\44\51\56\48\52\49\44\51\56\51\54\56\44\54\48\51\56\50\44\54\54\49\48\57\44\52\57\50\54\55\44\53\53\50\55\52\44\53\55\49\51\50\44\52\56\56\55\55\44\54\53\52\57\54\44\52\56\50\55\56\44\53\51\56\53\57\44\51\53\56\54\57\44\52\53\55\48\57\44\52\52\48\51\57\44\52\52\49\57\52\44\54\49\50\55\51\44\54\51\57\50\49\44\51\53\56\48\53\44\53\57\49\50\53\44\52\56\54\50\56\44\53\54\48\55\53\44\53\55\55\56\54\44\54\56\52\53\50\44\54\49\49\54\52\44\54\49\54\55\55\44\52\49\53\50\49\44\54\55\50\54\52\44\51\56\48\52\54\44\53\50\51\53\52\44\52\56\49\57\49\44\52\48\50\50\49\44\53\52\50\53\54\44\52\50\48\57\55\44\52\55\57\50\48\44\54\49\56\50\49\44\51\53\51\57\50\44\54\55\56\53\51\44\52\55\56\57\49\44\53\55\50\50\50\44\53\49\48\48\51\44\52\52\48\55\52\44\53\53\48\50\49\44\54\55\55\55\50\44\54\48\55\49\48\44\54\53\49\48\57\44\51\53\57\52\50\44\54\53\54\52\49\44\52\48\52\51\54\44\51\57\52\50\54\44\51\57\55\57\53\44\51\53\55\51\52\44\53\53\48\53\49\44\53\49\53\53\55\44\52\57\55\55\56\44\53\50\52\54\48\44\53\56\50\51\57\44\53\57\53\56\50\44\53\55\48\56\55\44\51\56\53\54\57\44\52\55\56\51\52\44\53\49\50\49\49\44\52\51\50\54\53\44\54\48\55\53\51\44\51\54\48\53\48\44\53\48\48\55\53\44\53\53\51\51\48\44\53\54\55\56\56\44\54\51\52\49\53\44\54\51\55\52\53\44\52\56\57\56\49\44\51\54\50\54\54\44\52\49\48\55\56\44\51\55\54\55\51\44\52\56\57\50\54\44\53\51\50\54\52\44\54\55\50\55\48\44\54\51\49\51\54\44\52\52\50\54\49\44\51\57\51\55\55\44\54\56\50\52\57\44\53\54\56\55\55\44\53\53\50\54\55\44\52\52\52\54\56\44\53\49\51\56\54\44\51\57\55\52\53\44\53\54\49\54\57\44\53\57\49\57\53\44\54\51\54\55\57\44\53\49\53\48\53\44\53\55\50\57\54\44\52\51\52\51\56\44\54\54\50\57\53\44\51\54\48\57\57\44\52\53\53\50\52\44\53\48\57\48\48\44\54\49\49\52\50\44\53\52\51\49\57\44\52\52\54\50\52\44\52\55\51\48\56\44\53\56\48\56\48\44\52\53\52\56\50\44\53\49\48\55\55\44\51\55\53\52\51\44\53\48\51\48\51\44\52\54\54\50\49\44\52\50\50\55\50\44\52\57\57\52\50\44\51\54\50\55\48\44\54\53\52\56\53\44\52\54\57\55\55\44\54\50\49\53\56\44\53\55\52\49\56\44\52\54\51\49\49\44\54\49\49\52\49\44\54\53\52\52\55\44\53\50\55\54\53\44\53\55\55\52\55\44\52\56\56\53\48\44\54\52\57\50\51\44\51\52\57\56\52\44\52\50\51\49\57\44\53\53\52\52\49\44\54\48\55\53\52\44\53\49\56\55\51\44\52\53\57\53\56\44\51\57\55\53\53\44\52\50\55\52\51\44\54\51\56\53\57\44\51\56\49\56\57\44\52\49\50\55\48\44\54\56\50\49\49\44\53\48\51\57\53\44\53\49\53\51\56\44\52\54\51\50\56\44\53\54\52\53\49\44\53\51\56\48\52\44\54\54\49\53\52\44\51\57\53\51\56\44\53\54\57\53\57\44\52\56\53\48\55\44\51\56\52\55\53\44\52\57\51\54\57\44\53\55\57\54\57\44\54\48\49\55\50\44\53\51\56\50\52\44\53\54\53\51\56\44\51\55\52\50\52\44\51\57\56\53\54\44\54\54\53\51\50\44\54\51\57\54\53\44\52\57\57\49\50\44\52\49\53\56\48\44\53\49\49\48\48\44\53\57\52\55\49\44\53\57\51\51\53\44\53\50\55\51\56\44\52\49\52\56\56\44\52\57\52\53\51\44\52\51\55\52\57\44\51\54\57\51\51\44\54\53\52\57\48\44\52\49\50\57\49\44\52\51\57\51\54\44\53\57\52\53\56\44\54\55\56\55\50\44\53\50\51\53\48\44\54\54\48\55\50\44\54\56\53\54\54\44\51\57\49\54\56\44\52\48\49\54\56\44\51\56\50\56\57\44\52\57\49\57\57\44\51\54\52\51\54\44\53\50\50\48\49\44\52\55\55\55\49\44\51\56\51\49\50\44\51\57\49\55\54\44\53\48\56\54\53\44\54\52\50\54\56\44\52\57\56\52\55\44\52\56\52\49\52\44\52\48\48\51\52\44\54\55\50\56\52\44\52\51\48\56\48\44\54\51\54\55\50\44\52\54\53\54\55\44\53\48\48\57\50\44\53\53\48\48\54\44\52\57\55\53\51\44\51\56\48\53\50\44\52\55\49\51\51\44\53\48\54\51\53\44\53\49\57\52\54\44\52\57\49\49\54\44\53\57\53\49\48\44\53\49\57\53\49\44\54\51\49\54\52\44\54\48\50\52\52\44\51\55\53\51\56\44\52\51\57\52\48\44\51\53\50\51\56\44\52\51\55\51\51\44\51\54\52\49\48\44\53\54\48\54\53\44\54\48\53\53\56\44\54\49\51\54\57\44\53\51\57\50\54\44\52\52\48\49\52\44\51\54\54\56\57\44\54\50\49\56\53\44\54\54\57\52\52\44\54\54\49\48\51\44\51\53\49\48\56\44\54\52\57\49\51\44\52\50\52\49\54\44\52\55\54\51\51\44\51\57\56\53\50\44\54\51\48\49\52\44\52\57\55\49\55\44\54\50\51\56\57\44\52\52\55\55\50\44\54\57\48\48\48\44\54\49\51\49\54\44\51\57\53\49\51\44\53\51\56\49\51\44\51\53\53\52\56\44\53\57\48\50\52\44\53\51\51\53\48\44\52\51\52\52\57\44\53\49\56\56\48\44\51\55\50\55\50\44\52\54\49\57\49\44\51\53\52\50\49\44\54\51\54\52\52\44\52\50\48\54\57\44\51\56\57\49\55\44\52\55\52\55\48\44\54\53\50\50\53\44\52\54\52\48\57\44\52\54\51\56\49\44\52\48\51\54\55\44\52\53\54\52\50\44\53\51\51\53\51\44\54\49\50\53\50\44\54\51\52\52\50\44\54\52\56\57\56\44\53\57\55\57\51\44\54\53\52\51\51\44\52\54\57\53\56\44\52\50\57\48\55\44\53\53\49\52\50\44\53\53\55\56\50\44\52\55\48\52\54\44\52\55\51\49\48\44\54\54\51\57\53\44\54\51\52\55\53\44\53\53\57\52\52\44\53\53\53\49\52\44\53\52\56\56\55\44\52\54\54\48\52\44\53\55\48\53\53\44\53\54\55\56\51\44\52\56\48\50\56\44\52\51\57\54\49\44\53\48\49\53\55\44\54\53\56\49\52\44\53\56\57\52\49\44\52\52\48\53\52\44\54\54\54\50\53\44\53\53\51\57\57\44\51\55\53\48\55\44\53\48\51\54\51\44\54\51\51\48\53\44\53\48\53\55\56\44\51\52\57\53\50\44\51\52\57\48\53\44\53\51\51\50\54\44\52\55\56\53\57\44\52\52\52\52\55\44\53\52\57\52\56\44\53\55\49\55\52\44\53\52\51\55\57\44\51\55\51\51\57\44\54\50\51\50\54\44\53\48\55\54\56\44\52\52\48\57\56\44\53\51\51\57\53\44\51\55\56\57\55\44\54\56\53\50\56\44\53\57\49\49\56\44\51\53\50\50\55\44\54\53\51\50\50\44\54\49\55\56\50\44\52\48\55\48\57\44\52\54\52\50\56\44\52\56\55\54\49\44\53\49\57\57\50\44\51\54\57\56\55\44\53\53\57\55\48\44\54\51\56\51\52\44\54\49\48\55\53\44\54\53\53\51\53\44\53\48\57\53\53\44\54\55\49\57\52\44\52\53\57\56\50\44\54\54\55\51\51\44\52\52\54\54\56\44\54\55\57\52\54\44\54\56\53\49\53\44\52\53\55\49\49\44\53\51\51\50\50\44\51\53\57\50\49\44\53\52\56\49\56\44\54\49\48\53\56\44\52\51\51\48\55\44\53\50\51\57\52\44\53\51\50\56\49\44\53\57\54\51\50\44\52\57\50\55\57\44\54\54\52\48\56\44\53\53\57\50\48\44\52\54\55\52\52\44\51\57\53\48\52\44\51\56\57\48\50\44\54\56\54\49\55\44\53\49\53\57\51\44\54\48\54\53\56\44\51\55\51\55\56\44\54\56\49\57\56\44\51\55\56\54\50\44\51\53\54\56\48\44\54\56\57\55\55\44\52\57\54\49\55\44\52\57\54\57\53\44\52\57\56\53\53\44\53\56\49\53\53\44\54\54\56\52\53\44\54\53\53\55\53\44\54\56\57\52\49\44\53\56\57\54\56\44\53\55\56\56\55\44\53\57\48\53\57\44\51\57\56\54\57\44\53\56\48\50\50\44\52\54\51\52\51\44\51\57\52\54\52\44\53\50\53\51\48\44\53\49\52\56\53\44\52\52\51\51\51\44\53\52\54\56\48\44\54\53\52\54\48\44\54\52\51\54\50\44\54\55\54\49\54\44\51\53\54\51\53\44\54\49\51\56\50\44\53\51\52\56\55\44\51\54\57\56\50\44\53\50\50\53\49\44\54\53\49\52\50\44\54\49\49\57\57\44\52\49\50\51\51\44\52\53\51\50\52\44\51\52\54\50\56\44\53\53\52\54\50\44\52\50\48\53\49\44\53\56\52\49\49\44\52\48\48\48\50\44\52\55\48\55\55\44\53\55\51\55\48\44\52\53\50\53\49\44\52\54\50\51\54\44\52\51\54\56\53\44\51\52\55\48\54\44\53\49\52\56\57\44\53\51\53\51\54\44\52\52\52\51\50\44\53\57\53\56\51\44\54\51\48\51\53\44\51\54\57\53\53\44\54\53\54\50\50\44\53\56\57\49\48\44\52\53\48\49\55\44\53\57\56\49\51\44\53\49\49\51\51\44\52\56\57\52\57\44\52\52\54\49\57\44\54\52\50\49\50\44\52\56\52\52\55\44\54\55\52\55\56\44\53\52\53\49\48\44\52\53\54\50\53\44\51\54\50\57\49\44\54\53\54\50\52\44\54\55\55\49\51\44\53\53\55\55\50\44\54\55\53\55\54\44\54\56\50\57\53\44\51\55\52\48\56\44\53\54\54\53\54\44\52\54\54\53\56\44\51\57\52\48\49\44\54\56\49\56\56\44\53\56\57\51\55\44\52\49\48\56\53\44\53\49\49\53\56\44\54\55\52\54\50\44\54\53\52\54\54\44\54\55\53\53\49\44\51\52\56\53\52\44\51\53\51\56\57\44\51\56\55\54\49\44\52\51\55\53\51\44\51\54\55\53\53\44\52\55\53\48\49\44\53\50\53\49\54\44\54\48\52\54\50\44\52\50\56\51\53\44\54\55\53\48\56\44\54\48\56\52\54\44\52\53\52\48\49\44\53\49\55\55\50\44\52\54\51\53\49\44\54\48\50\52\50\44\52\51\51\53\57\44\52\51\53\56\52\44\53\54\54\53\52\44\54\51\49\53\52\44\54\55\49\48\50\44\52\55\52\52\51\44\53\50\53\52\51\44\52\50\57\54\49\44\53\53\49\53\52\44\52\53\50\57\52\44\51\56\55\53\49\44\52\54\48\52\52\44\53\51\51\49\50\44\51\55\55\54\51\44\52\54\57\54\54\44\53\53\49\57\53\44\52\52\51\55\55\44\53\54\54\52\57\44\53\55\49\57\55\44\53\48\49\48\54\44\53\57\54\52\54\44\54\52\57\49\52\44\52\51\55\52\56\44\52\57\53\56\54\44\52\53\52\51\52\44\52\51\52\53\54\44\53\51\54\51\56\44\52\50\55\49\48\44\52\53\53\56\56\44\52\55\50\48\55\44\51\57\50\49\52\44\51\54\57\54\53\44\52\50\53\49\49\44\53\53\50\49\55\44\51\54\56\56\56\44\53\48\55\54\50\44\52\56\53\57\57\44\52\53\57\57\51\44\51\54\53\57\48\44\53\54\56\55\50\44\52\48\54\48\54\44\53\57\57\53\53\44\54\52\52\52\53\44\53\49\57\55\55\44\52\53\55\55\51\44\54\51\57\50\52\44\51\53\54\49\51\44\51\55\57\51\52\44\53\48\55\49\51\44\52\50\54\56\51\44\53\55\50\52\54\44\52\50\49\48\51\44\51\57\50\52\54\44\52\57\54\50\55\44\52\50\52\49\55\44\52\53\49\55\50\44\53\51\55\54\56\44\53\56\53\56\50\44\52\50\54\49\57\44\53\51\57\57\54\44\54\53\51\49\49\44\52\53\50\50\50\44\52\48\50\50\48\44\51\54\53\56\57\44\53\50\48\49\48\44\51\54\53\57\49\44\54\48\54\48\49\44\51\53\54\57\55\44\53\56\50\51\56\44\53\53\56\50\53\44\52\51\51\51\48\44\54\49\48\54\49\44\52\55\51\57\55\44\53\50\55\55\51\44\53\49\49\48\51\44\54\48\53\48\57\44\54\55\49\55\51\44\52\53\50\48\49\44\54\52\54\52\55\44\54\49\56\49\56\44\53\57\52\53\51\44\54\51\57\52\55\44\53\50\54\51\50\44\52\50\57\53\57\44\52\55\48\52\55\44\51\56\52\49\49\44\53\54\49\48\48\44\51\56\56\56\51\44\52\57\52\52\57\44\53\56\48\50\55\44\54\52\48\48\55\44\52\50\48\51\54\44\51\55\51\53\49\44\52\52\54\55\53\44\51\55\48\55\52\44\53\56\57\51\54\44\54\50\56\55\48\44\51\53\55\49\54\44\52\50\48\49\55\44\52\49\50\52\53\44\53\49\55\55\48\44\51\57\48\52\51\44\54\48\50\56\50\44\52\53\55\49\52\44\52\53\55\50\52\44\51\56\51\53\50\44\54\51\48\51\51\44\53\51\56\57\51\44\52\49\49\48\56\44\54\54\52\52\50\44\52\50\50\57\56\44\53\53\56\56\49\44\54\48\52\56\48\44\51\57\56\52\56\44\51\55\51\52\50\44\54\52\49\49\57\44\51\53\48\52\52\44\52\49\56\53\52\44\54\48\57\55\48\44\52\52\57\51\56\44\52\52\57\48\57\44\51\53\49\55\48\44\52\57\50\49\50\44\53\49\57\54\56\44\54\53\57\49\48\44\54\50\53\53\56\44\51\55\49\57\51\44\51\57\56\48\48\44\54\50\49\52\51\44\52\51\49\48\52\44\53\56\51\56\56\44\52\57\55\54\56\44\54\50\57\52\57\44\52\53\52\49\53\44\51\54\54\54\50\44\53\49\54\50\53\44\51\52\54\54\53\44\53\53\53\53\56\44\53\57\53\54\53\44\51\55\49\48\56\44\52\53\52\55\53\44\53\53\54\56\54\44\53\51\52\57\55\44\54\48\49\52\52\44\51\52\57\53\56\44\54\56\52\54\56\44\51\54\57\54\55\44\52\50\48\57\56\44\54\48\52\49\56\44\52\52\53\50\52\44\54\52\54\56\49\44\54\53\48\56\51\44\51\54\51\54\55\44\51\56\54\51\54\44\54\55\52\55\48\44\52\50\52\57\54\44\52\51\57\48\51\44\51\53\49\57\57\44\54\52\48\54\51\44\53\50\48\53\50\44\54\56\57\54\57\44\54\52\52\49\53\44\54\53\55\51\56\44\53\55\57\49\48\44\53\53\55\53\52\44\51\56\52\54\50\44\54\52\52\53\57\44\53\51\54\56\55\44\52\55\50\49\54\44\54\52\54\53\51\44\54\52\48\53\49\44\53\49\48\51\51\44\52\57\57\53\51\44\52\56\50\48\55\44\54\56\56\48\53\44\54\48\51\54\54\44\51\57\49\56\52\44\54\55\48\51\48\44\52\50\50\51\48\44\53\52\50\48\48\44\52\51\53\50\57\44\53\53\56\49\50\44\54\53\51\57\55\44\53\53\48\49\57\44\52\53\55\51\55\44\54\53\50\49\54\44\54\53\54\51\53\44\54\53\50\48\53\44\51\55\48\54\52\44\51\57\52\53\49\44\54\52\56\55\57\44\51\54\50\55\56\44\54\53\54\53\50\44\52\57\55\49\54\44\51\57\53\53\57\44\54\53\52\48\57\44\52\54\52\51\48\44\54\49\52\51\51\44\54\48\55\56\57\44\52\49\51\57\54\44\53\51\50\53\48\44\52\57\54\55\56\44\52\56\51\54\52\44\53\54\53\48\49\44\54\56\57\52\54\44\53\56\53\54\52\44\52\55\53\48\57\44\54\56\48\52\48\44\54\51\57\54\57\44\53\51\48\49\51\44\53\53\55\50\49\44\53\53\48\52\57\44\51\56\52\50\50\44\52\55\56\53\53\44\52\56\51\55\55\44\53\52\49\55\52\44\54\56\55\55\54\44\53\56\50\50\54\44\51\54\56\56\48\44\53\53\51\56\49\44\53\56\56\52\49\44\52\56\53\50\53\44\54\51\52\52\48\44\52\51\54\48\52\44\53\54\51\53\54\44\51\54\53\49\49\44\53\48\53\50\55\44\54\49\49\48\48\44\53\50\50\55\54\44\53\49\53\55\56\44\53\55\52\54\56\44\54\49\55\52\57\44\52\54\50\54\50\44\52\56\53\56\53\44\52\54\56\50\52\44\54\53\48\51\56\44\51\54\53\49\56\44\52\50\57\51\52\44\51\57\51\50\57\44\54\52\53\56\51\44\54\54\57\54\51\44\51\56\54\51\49\44\51\56\56\50\48\44\54\54\54\54\51\44\54\54\51\49\48\44\54\48\56\56\48\44\52\48\56\50\56\44\54\54\52\54\53\44\53\49\48\56\51\44\53\55\49\56\51\44\52\56\53\49\53\44\53\49\52\57\50\44\53\50\54\48\54\44\54\56\49\51\56\44\54\51\49\52\53\44\52\51\48\57\54\44\54\54\53\50\54\44\52\54\53\48\53\44\52\50\56\55\49\44\52\55\52\48\48\44\52\55\48\51\54\44\51\55\57\56\50\44\54\48\54\51\52\44\54\53\55\49\49\44\54\55\49\53\52\44\52\49\54\51\49\44\54\50\49\56\48\44\54\52\48\53\52\44\53\52\49\52\49\44\52\51\51\54\53\44\53\52\48\55\55\44\54\54\48\48\49\44\54\55\56\53\54\44\52\57\55\54\53\44\52\53\53\55\49\44\54\54\57\50\50\44\52\52\50\54\55\44\53\49\55\55\55\44\54\52\54\54\53\44\53\57\54\48\51\44\51\52\55\50\51\44\54\49\49\50\56\44\52\53\57\53\49\44\51\54\50\57\54\44\54\51\52\56\48\44\53\51\55\50\55\44\54\56\53\56\52\44\54\55\51\56\52\44\51\55\57\53\55\44\54\48\54\55\55\44\53\54\48\48\51\44\54\50\55\48\51\44\54\51\48\51\52\44\52\48\48\54\49\44\52\48\48\54\48\44\54\53\50\56\57\44\52\55\55\51\49\44\52\55\56\51\50\44\53\50\56\54\54\44\53\57\56\55\52\44\52\53\49\50\54\44\52\53\57\52\49\44\52\48\51\57\52\44\51\55\56\54\51\44\53\50\48\52\54\44\52\56\54\53\50\44\54\56\57\51\51\44\54\49\51\52\49\44\52\51\55\56\49\44\54\51\54\51\49\44\52\48\51\49\48\44\52\51\50\52\55\44\53\52\53\50\55\44\54\50\50\57\48\44\51\55\57\48\49\44\53\49\54\49\50\44\52\50\52\54\48\44\52\51\52\57\54\44\52\50\49\48\49\44\51\55\54\55\52\44\52\52\48\53\50\44\53\48\55\52\53\44\53\51\57\57\55\44\54\51\56\56\56\44\54\49\48\48\54\44\52\56\54\51\56\44\51\56\54\55\51\44\51\56\57\52\55\44\52\52\53\53\51\44\53\57\56\55\49\44\51\54\53\50\49\44\52\56\52\54\52\44\54\54\50\54\51\44\52\51\51\57\56\44\51\56\52\54\57\44\54\50\51\57\57\44\51\57\50\52\48\44\53\53\48\52\48\44\53\48\50\56\48\44\54\53\48\50\55\44\52\51\52\50\49\44\52\54\48\57\50\44\51\55\56\48\56\44\52\50\49\57\50\44\53\51\56\57\53\44\54\55\51\55\48\44\51\57\48\54\52\44\53\50\51\49\54\44\51\56\57\56\56\44\54\53\50\57\55\44\51\57\50\53\52\44\53\52\56\49\53\44\52\57\57\54\55\44\52\51\54\57\52\44\52\50\51\51\53\44\53\54\52\53\54\44\52\50\48\49\49\44\51\56\53\51\54\44\52\52\52\49\48\44\54\49\55\50\50\44\53\50\55\50\56\44\52\48\48\52\49\44\53\57\50\53\57\44\54\56\52\53\55\44\52\56\49\48\54\44\51\54\50\49\48\44\52\52\48\53\57\44\52\56\50\56\48\44\54\54\55\50\51\44\52\57\55\48\53\44\53\48\53\50\48\44\52\52\57\51\49\44\51\55\49\50\50\44\53\55\49\57\51\44\53\50\49\49\54\44\53\53\51\51\54\44\52\50\50\50\56\44\51\52\55\54\48\44\52\55\48\57\51\44\52\57\57\52\55\44\52\52\57\52\52\44\52\55\54\57\51\44\51\53\57\56\52\44\53\53\54\52\50\44\53\48\54\57\51\44\52\50\57\49\50\44\51\55\57\51\50\44\52\57\51\50\48\44\52\57\57\54\51\44\52\50\48\50\57\44\53\57\52\52\53\44\54\52\57\48\51\44\53\53\51\57\53\44\54\51\56\55\55\44\53\51\48\52\56\44\52\54\49\54\57\44\52\54\48\56\51\44\51\54\50\50\50\44\53\48\52\52\52\44\53\52\50\51\50\44\52\54\48\49\52\44\52\51\52\54\57\44\53\54\48\50\52\44\53\54\50\55\49\44\52\57\56\51\56\44\53\52\50\56\51\44\52\49\55\56\56\44\51\55\52\49\55\44\52\57\55\54\51\44\52\53\48\56\57\44\54\52\55\48\50\44\51\52\57\52\51\44\52\48\55\53\53\44\51\54\49\55\51\44\52\56\53\53\52\44\52\56\54\48\55\44\54\51\49\56\56\44\52\48\53\53\48\44\53\57\54\56\57\44\51\53\53\49\52\44\54\54\55\57\49\44\52\57\54\49\53\44\52\56\55\50\48\44\52\51\52\55\55\44\51\53\52\54\56\44\54\50\51\55\48\44\52\48\48\52\51\44\51\52\55\55\55\44\51\53\50\49\56\44\53\54\48\52\51\44\54\54\55\56\50\44\51\53\51\53\54\44\51\57\51\54\52\44\51\56\54\52\55\44\54\56\53\49\55\44\54\54\54\57\56\44\54\54\57\51\54\44\52\54\57\55\49\44\52\56\49\50\50\44\52\53\56\55\52\44\54\52\52\55\49\44\52\54\49\48\50\44\54\54\53\52\49\44\54\51\55\54\52\44\54\51\48\53\50\44\54\54\56\57\55\44\54\53\56\55\57\44\54\53\55\57\51\44\54\53\53\57\54\44\52\50\57\51\53\44\52\56\50\53\50\44\53\48\55\57\49\44\54\55\50\50\56\44\53\52\53\52\54\44\52\48\57\49\56\44\53\51\52\48\49\44\51\52\54\54\50\44\54\49\49\53\57\44\52\52\49\48\49\44\51\56\55\57\48\44\54\55\53\50\52\44\54\56\51\48\56\44\53\57\54\52\50\44\54\48\56\52\55\44\54\50\54\55\54\44\54\54\48\54\54\44\52\55\49\56\54\44\54\56\52\52\50\44\53\48\48\49\52\44\53\49\55\50\52\44\51\55\57\56\57\44\54\48\56\48\53\44\53\49\49\50\54\44\53\49\50\52\52\44\52\57\56\51\57\44\54\54\52\54\55\44\52\51\52\53\53\44\52\51\52\51\57\44\54\56\53\50\53\44\54\55\52\49\54\44\53\56\52\55\49\44\54\51\50\51\49\44\53\48\52\54\53\44\54\50\55\51\50\44\52\50\48\53\52\44\52\57\56\53\52\44\54\50\53\54\57\44\51\55\57\51\49\44\51\52\54\55\56\44\52\49\56\48\56\44\53\55\54\51\48\44\51\54\55\50\48\44\52\48\48\52\57\44\51\53\49\54\53\44\53\53\53\57\48\44\52\57\56\50\50\44\54\49\53\55\56\44\54\50\57\51\53\44\54\51\57\52\49\44\51\53\54\55\52\44\51\57\55\54\51\44\53\54\55\54\49\44\54\52\48\48\52\44\53\50\54\48\56\44\53\56\50\48\57\44\53\49\51\48\56\44\53\57\54\56\55\44\52\53\54\54\56\44\51\57\49\53\54\44\51\56\48\51\55\44\53\53\51\54\53\44\51\55\51\50\49\44\54\54\55\51\49\44\51\55\53\53\55\44\54\56\51\49\51\44\51\56\57\53\56\44\52\50\57\52\48\44\52\55\52\50\55\44\54\54\50\54\54\44\51\56\57\57\49\44\52\56\52\56\50\44\52\53\50\48\51\44\52\53\49\54\49\44\53\50\50\49\50\44\53\57\51\56\53\44\52\54\48\48\56\44\52\52\55\53\50\44\54\52\50\53\53\44\52\49\48\53\48\44\52\57\49\56\49\44\52\55\52\56\55\44\52\55\56\56\55\44\53\53\54\55\50\44\52\53\48\57\50\44\54\54\51\54\48\44\53\50\57\55\54\44\52\49\51\49\55\44\51\57\50\51\53\44\52\56\52\52\54\44\54\56\49\56\49\44\51\54\53\51\54\44\54\51\54\49\50\44\53\51\50\48\49\44\53\55\50\55\49\44\52\57\51\55\53\44\52\48\48\56\50\44\51\57\53\50\55\44\53\57\54\56\56\44\54\51\57\52\52\44\52\55\49\51\55\44\53\53\52\50\55\44\54\54\57\54\50\44\53\54\48\52\53\44\51\55\57\52\55\44\52\57\52\56\53\44\53\52\53\56\54\44\53\55\51\55\50\44\51\56\51\57\53\44\54\52\49\57\56\44\54\53\56\51\57\44\53\54\49\57\53\44\53\57\49\56\53\44\54\49\52\56\57\44\54\51\53\50\56\44\52\56\48\55\55\44\51\53\52\49\51\44\53\56\49\51\49\44\53\54\57\50\50\44\51\55\50\57\49\44\51\55\49\57\53\44\53\55\57\52\48\44\53\57\55\57\53\44\52\57\55\53\57\44\51\55\56\52\49\44\51\57\49\53\53\44\53\50\49\54\52\44\54\54\50\57\56\44\53\51\48\52\51\44\54\54\52\56\50\44\52\52\51\48\56\44\53\57\50\49\56\44\51\53\49\53\53\44\52\49\50\49\49\44\54\49\49\51\55\44\51\57\49\55\48\44\51\56\48\55\51\44\53\56\55\50\52\44\52\53\50\54\51\44\52\52\56\52\55\44\52\54\51\48\51\44\52\54\50\52\48\44\51\56\54\51\56\44\53\54\53\54\51\44\54\54\51\50\48\44\51\54\49\54\56\44\52\50\50\56\56\44\53\56\56\51\54\44\54\50\50\55\53\44\53\56\53\49\52\44\53\54\57\51\55\44\53\54\52\52\57\44\52\49\48\57\49\44\52\52\54\50\51\44\51\52\56\52\52\44\54\51\49\55\54\44\52\50\50\52\57\44\54\51\55\55\49\44\54\48\52\51\55\44\52\49\50\52\52\44\52\56\55\57\56\44\53\49\55\48\51\44\52\50\51\57\56\44\53\54\54\49\57\44\52\50\52\53\57\44\52\55\56\52\56\44\51\55\50\52\53\44\52\49\50\57\54\44\51\54\57\57\49\44\51\54\53\48\48\44\54\48\51\57\48\44\52\57\55\50\57\44\52\53\56\53\56\44\53\54\57\52\55\44\53\49\51\55\52\44\53\49\53\57\54\44\54\51\56\54\48\44\52\57\51\50\52\44\53\53\49\51\50\44\52\53\55\55\50\44\53\51\55\56\52\44\54\48\51\54\50\44\51\56\49\49\51\44\52\49\56\51\54\44\54\55\55\52\50\44\52\52\53\49\55\44\51\52\56\52\56\44\54\53\57\49\51\44\54\53\48\48\51\44\52\52\54\52\50\44\52\57\55\48\48\44\54\51\55\50\52\44\52\50\55\53\52\44\51\53\57\49\55\44\52\51\57\53\52\44\53\55\53\56\54\44\53\55\54\54\54\44\54\54\54\53\51\44\53\57\49\56\55\44\52\52\49\49\51\44\53\53\50\57\55\44\51\57\48\51\56\44\53\53\56\49\55\44\51\54\56\50\50\44\51\57\49\49\51\44\53\56\49\52\57\44\54\49\48\48\55\44\52\57\55\54\55\44\52\49\56\48\57\44\51\56\54\56\55\44\52\56\50\54\51\44\52\52\52\55\53\44\52\57\48\52\49\44\52\49\51\54\51\44\52\48\50\50\53\44\52\49\50\48\56\44\53\48\50\53\53\44\51\53\48\54\51\44\51\54\53\57\51\44\53\49\52\49\53\44\54\50\50\48\54\44\52\55\54\55\50\44\51\56\57\57\51\44\54\48\51\57\49\44\53\57\57\53\49\44\53\50\55\51\51\44\54\56\50\57\50\44\54\50\57\54\50\44\54\48\50\54\53\44\52\56\51\52\48\44\53\49\57\49\53\44\52\53\51\57\56\44\53\50\57\54\52\44\52\49\55\53\57\44\53\55\57\53\53\44\51\53\57\48\56\44\53\55\48\48\57\44\54\52\57\51\52\44\53\55\52\48\52\44\54\51\49\48\56\44\52\50\52\57\56\44\51\57\49\53\51\44\53\54\54\53\57\44\54\51\55\53\54\44\54\50\53\51\54\44\51\53\55\51\53\44\54\50\53\49\54\44\54\54\54\57\57\44\51\52\57\57\51\44\51\53\49\48\48\44\52\53\49\57\56\44\53\55\50\48\51\44\51\56\50\52\57\44\54\53\53\50\56\44\53\49\51\51\55\44\53\56\52\54\55\44\51\56\54\51\57\44\52\55\56\57\57\44\53\49\48\54\57\44\54\49\53\57\52\44\54\56\57\49\54\44\52\56\55\53\53\44\51\53\50\48\53\44\52\48\49\56\53\44\54\50\56\56\55\44\53\52\57\51\48\44\51\52\53\55\52\44\51\54\51\56\52\44\52\53\53\55\53\44\51\54\56\54\54\44\52\53\55\48\49\44\53\53\56\53\48\44\51\56\53\53\55\44\51\57\53\50\53\44\53\48\49\53\49\44\53\56\53\52\54\44\53\56\53\55\51\44\54\53\50\54\55\44\53\55\53\50\57\44\52\56\57\48\49\44\52\55\54\48\53\44\52\55\54\51\53\44\53\57\48\55\56\44\51\54\56\50\53\44\53\52\53\57\57\44\54\51\52\56\49\44\52\48\57\49\54\44\53\51\52\51\53\44\52\53\54\53\50\44\52\51\57\56\57\44\53\54\55\54\50\44\54\53\50\48\57\44\52\57\49\51\54\44\51\52\55\52\51\44\54\51\55\54\53\44\52\48\51\51\49\44\53\48\48\50\55\44\53\54\49\48\54\44\54\49\57\55\54\44\51\56\52\48\50\44\52\52\53\52\54\44\52\53\52\51\56\44\53\49\52\48\48\44\54\52\57\57\54\44\52\56\49\53\57\44\53\52\57\50\52\44\53\52\50\52\56\44\52\53\56\54\57\44\53\55\55\54\54\44\54\56\56\54\54\44\53\52\50\56\49\44\52\55\57\51\54\44\53\54\56\51\56\44\53\54\56\56\49\44\51\57\57\57\53\44\53\48\48\51\51\44\52\54\55\49\48\44\53\56\50\56\57\44\54\56\52\55\50\44\52\52\50\56\56\44\52\50\53\51\56\44\51\53\56\48\49\44\52\50\50\53\52\44\52\57\48\48\54\44\52\57\51\54\48\44\52\52\51\53\55\44\52\54\54\49\49\44\54\49\51\52\55\44\53\52\57\53\51\44\54\51\49\54\50\44\53\55\52\51\49\44\54\48\56\56\56\44\54\52\52\53\49\44\52\57\50\51\55\44\51\55\55\52\48\44\52\48\48\49\51\44\54\52\50\53\52\44\53\50\48\55\57\44\54\50\50\54\53\44\52\56\50\48\54\44\54\55\52\48\51\44\52\50\52\52\48\44\51\56\52\53\57\44\53\57\49\53\55\44\52\56\57\52\48\44\54\49\51\51\53\44\54\53\53\50\53\44\51\53\56\55\53\44\53\55\56\52\51\44\51\52\53\55\56\44\51\53\57\52\56\44\53\49\53\48\49\44\54\52\56\56\53\44\51\52\56\53\50\44\53\51\57\49\55\44\51\57\55\50\51\44\53\56\48\48\53\44\53\55\54\52\54\44\52\49\51\55\57\44\53\52\55\52\57\44\54\52\56\55\50\44\54\56\57\51\56\44\54\49\56\52\50\44\52\57\51\55\50\44\53\48\57\48\50\44\52\54\52\54\50\44\52\51\51\53\50\44\52\54\49\51\57\44\51\53\56\53\53\44\54\56\53\57\49\44\52\56\51\48\48\44\52\52\56\53\53\44\53\55\52\56\50\44\52\56\49\52\49\44\52\54\50\51\57\44\54\50\55\49\53\44\51\57\54\52\57\44\53\57\56\56\51\44\54\52\50\52\51\44\51\56\55\52\50\44\54\49\52\52\48\44\51\57\48\51\53\44\53\57\52\51\49\44\54\54\54\51\54\44\52\56\50\57\53\44\54\53\55\51\57\44\54\49\57\48\55\44\53\55\56\53\54\44\52\56\51\50\48\44\54\55\57\51\57\44\53\53\53\53\51\44\54\49\51\53\56\44\52\51\48\49\49\44\51\56\49\54\50\44\53\48\51\48\49\44\52\54\54\50\50\44\53\49\51\50\56\44\53\50\51\54\56\44\53\55\56\56\49\44\52\48\55\55\53\44\52\54\53\48\55\44\52\57\48\49\48\44\54\53\50\57\53\44\54\52\53\56\48\44\52\54\56\57\51\44\54\55\51\53\50\44\52\56\49\57\52\44\53\49\49\49\52\44\54\52\54\55\49\44\54\56\48\50\51\44\52\53\54\57\57\44\53\55\55\54\57\44\53\50\52\55\48\44\52\54\53\49\53\44\54\52\55\50\56\44\51\57\57\52\57\44\53\54\50\52\55\44\52\57\51\51\57\44\54\52\51\49\48\44\53\51\52\52\56\44\52\50\56\56\57\44\51\53\55\54\55\44\52\49\54\48\57\44\52\51\55\57\49\44\53\51\54\53\54\44\53\49\52\53\51\44\54\56\48\52\54\44\52\54\56\57\53\44\53\52\48\55\51\44\54\51\57\53\54\44\53\52\49\51\53\44\53\51\50\53\54\44\54\49\56\49\54\44\53\49\50\50\53\44\54\50\50\57\52\44\54\55\55\51\48\44\54\49\52\56\52\44\54\56\54\53\48\44\54\49\56\52\51\44\52\52\53\53\57\44\53\56\53\52\48\44\53\51\56\49\53\44\54\48\50\54\49\44\54\55\48\54\53\44\52\54\56\50\50\44\51\54\54\50\56\44\53\52\55\56\51\44\51\56\55\52\54\44\53\56\53\52\57\44\51\57\54\50\49\44\53\52\48\51\52\44\53\53\51\50\49\44\51\53\50\53\53\44\52\55\54\48\49\44\52\53\52\48\50\44\53\53\51\54\51\44\54\50\56\49\51\44\54\49\50\49\57\44\51\56\50\52\56\44\52\48\57\56\53\44\52\48\51\49\50\44\53\49\52\50\57\44\54\55\51\56\51\44\52\55\56\48\55\44\53\51\48\51\50\44\53\50\57\53\49\44\52\49\50\55\51\44\51\55\50\53\55\44\52\48\52\55\54\44\54\56\56\56\57\44\52\51\53\57\55\44\54\49\53\53\53\44\53\51\50\49\50\44\52\54\55\53\53\44\51\55\52\56\52\44\52\52\49\49\50\44\53\56\57\57\57\44\53\48\52\55\57\44\51\57\48\55\51\44\52\48\52\55\49\44\52\55\56\55\55\44\53\50\53\50\51\44\54\56\52\51\54\44\54\50\51\54\48\44\51\55\55\57\53\44\51\54\53\55\48\44\53\54\54\53\55\44\52\53\50\52\55\44\54\54\55\52\57\44\54\49\55\55\48\44\54\50\55\52\53\44\52\48\52\48\50\44\52\56\53\51\57\44\51\52\55\56\51\44\54\52\48\57\56\44\51\56\56\51\52\44\52\49\52\53\54\44\54\55\48\49\53\44\54\49\48\49\55\44\54\50\49\48\48\44\54\48\57\54\53\44\53\55\54\50\50\44\53\54\53\50\55\44\52\51\50\50\48\44\52\48\49\50\51\44\54\54\57\51\50\44\54\52\57\49\48\44\52\48\51\51\55\44\52\52\52\53\54\44\53\51\53\57\53\44\52\54\56\57\57\44\54\50\48\55\57\44\53\56\53\53\57\44\51\55\53\55\52\44\51\57\50\55\48\44\51\57\52\48\52\44\54\55\48\53\56\44\53\55\54\52\57\44\52\52\53\57\49\44\52\52\53\54\52\44\52\56\51\54\48\44\52\54\48\51\56\44\51\54\52\54\50\44\52\53\55\53\50\44\54\57\48\55\56\44\51\56\54\57\57\44\52\52\54\51\50\44\53\57\50\52\54\44\54\51\57\56\48\44\52\56\56\53\49\44\54\53\51\54\54\44\53\52\50\49\50\44\52\49\51\55\53\44\51\57\57\54\51\44\53\56\56\48\51\44\51\55\53\57\52\44\54\49\53\55\52\44\52\56\53\53\55\44\52\51\50\55\52\44\54\52\57\53\53\44\53\57\57\50\53\44\51\54\56\52\53\44\52\57\52\56\54\44\52\56\49\54\52\44\52\51\49\54\49\44\52\57\54\57\50\44\51\55\48\50\51\44\53\57\49\54\52\44\53\54\48\57\55\44\52\48\55\54\52\44\53\56\54\56\50\44\54\48\57\51\57\44\54\51\56\56\50\44\53\50\52\54\57\44\54\50\55\57\48\44\54\54\49\55\53\44\54\52\51\54\48\44\52\49\48\51\56\44\52\53\55\55\49\44\53\53\49\50\55\44\51\54\53\50\50\44\53\56\48\50\48\44\52\54\49\57\48\44\51\57\53\49\54\44\52\57\50\51\56\44\53\56\48\51\49\44\53\52\51\57\50\44\52\54\52\56\49\44\53\52\49\55\53\44\54\52\57\57\55\44\54\53\53\49\57\44\53\49\49\50\50\44\52\55\51\54\54\44\51\54\55\52\49\44\54\55\48\54\48\44\53\57\49\57\55\44\53\53\51\50\52\44\54\53\50\49\49\44\51\57\49\49\55\44\53\57\53\53\48\44\53\50\54\50\52\44\51\54\51\51\48\44\52\48\57\52\49\44\52\52\55\49\57\44\51\56\57\54\55\44\52\52\51\52\51\44\52\55\55\51\55\44\51\56\52\53\52\44\53\54\50\52\52\44\54\48\52\49\54\44\52\55\53\53\55\44\52\52\57\56\51\44\53\48\52\57\52\44\51\56\54\48\54\44\54\48\53\50\49\44\53\56\55\49\49\44\51\57\48\53\48\44\53\48\52\51\52\44\51\56\50\54\48\44\54\56\49\53\56\44\53\50\55\55\50\44\53\56\51\53\53\44\52\54\54\49\55\44\53\57\54\56\50\44\54\48\48\56\56\44\52\50\56\50\49\44\52\57\49\52\52\44\52\51\52\55\56\44\52\52\52\56\55\44\54\51\48\52\54\44\51\56\50\57\56\44\51\54\51\56\54\44\51\56\53\54\55\44\53\50\49\49\52\44\54\51\49\54\54\44\51\56\54\52\48\44\53\55\48\53\55\44\54\56\52\48\48\44\53\55\51\56\49\44\54\56\52\56\56\44\52\51\51\54\55\44\53\57\52\49\48\44\53\53\54\56\49\44\53\56\51\51\49\44\52\51\48\56\51\44\54\50\55\51\54\44\54\50\56\51\49\44\54\49\49\53\51\44\51\57\51\50\56\44\53\55\56\51\56\44\54\48\49\56\53\44\54\48\53\57\50\44\54\48\50\48\51\44\54\55\53\50\51\44\51\57\57\55\52\44\54\49\55\56\56\44\54\52\48\55\49\44\52\48\48\52\52\44\52\50\52\57\57\44\54\53\57\49\54\44\51\53\48\51\57\44\51\53\50\50\49\44\52\55\52\52\54\44\54\51\53\49\52\44\54\51\53\50\51\44\52\51\52\48\56\44\52\50\53\52\48\44\52\57\54\52\54\44\51\52\56\57\55\44\54\50\48\52\48\44\52\50\55\51\50\44\54\50\55\54\55\44\53\50\57\53\54\44\53\53\48\56\53\44\52\55\55\50\49\44\53\50\52\53\54\44\52\55\55\50\54\44\54\54\53\50\53\44\52\57\51\53\56\44\53\54\57\53\53\44\51\53\51\50\48\44\51\54\54\52\57\44\54\49\51\56\51\44\53\52\50\54\57\44\53\48\48\50\48\44\54\51\48\48\52\44\51\55\52\56\54\44\52\54\52\50\49\44\53\56\51\51\51\44\53\51\48\53\50\44\54\49\49\49\51\44\52\52\51\48\54\44\52\54\52\50\54\44\51\54\50\52\48\44\54\51\53\51\52\44\54\55\53\56\52\44\52\54\56\49\53\44\52\50\48\51\48\44\52\50\54\53\53\44\53\52\51\54\51\44\52\49\48\55\53\44\53\56\51\57\55\44\53\51\57\50\48\44\54\53\55\50\55\44\52\52\52\51\54\44\52\56\51\57\57\44\52\57\54\51\52\44\53\52\48\49\55\44\52\53\48\55\51\44\52\55\53\57\53\44\53\56\53\54\50\44\52\49\54\50\49\44\54\56\57\48\54\44\52\48\55\52\54\44\54\51\52\50\56\44\53\54\55\54\54\44\53\56\52\50\56\44\52\53\50\53\50\44\53\55\53\49\53\44\54\54\54\52\53\44\52\55\57\54\51\44\52\51\48\51\52\44\54\55\50\55\54\44\52\54\53\48\54\44\54\49\53\57\54\44\54\55\49\57\55\44\54\53\52\56\54\44\52\51\53\53\52\44\52\56\57\52\51\44\52\52\49\53\56\44\52\48\50\50\57\44\54\51\52\52\52\44\51\54\53\55\53\44\52\55\54\53\48\44\53\52\53\54\48\44\54\56\49\49\50\44\52\50\57\54\52\44\52\49\55\52\52\44\54\55\48\54\50\44\54\53\51\49\51\44\53\55\55\57\56\44\52\48\48\48\48\44\54\56\55\49\50\44\52\56\54\54\55\44\52\52\50\51\54\44\54\54\54\50\54\44\52\53\57\50\51\44\52\54\50\50\57\44\53\49\57\54\52\44\53\49\55\48\53\44\54\56\55\49\57\44\54\50\51\48\49\44\54\52\48\54\54\44\54\49\55\49\53\44\53\50\54\56\53\44\52\54\57\56\54\44\54\53\56\49\57\44\52\48\51\56\52\44\52\55\55\55\56\44\54\56\48\54\48\44\54\55\55\55\55\44\52\57\55\48\49\44\51\57\50\50\53\44\51\53\53\51\49\44\53\54\49\57\54\44\53\49\48\53\53\44\54\48\54\49\51\44\54\56\51\53\53\44\53\50\51\50\51\44\53\57\56\57\50\44\54\48\56\48\48\44\53\48\54\52\49\44\52\51\56\53\50\44\51\53\53\49\54\44\52\55\50\55\48\44\54\50\48\55\51\44\54\54\51\51\55\44\53\49\57\57\48\44\53\48\57\53\54\44\51\57\56\57\48\44\53\55\50\53\51\44\52\49\50\57\56\44\51\56\48\54\57\44\51\53\54\55\49\44\52\52\54\50\54\44\54\48\51\50\48\44\52\53\53\50\51\44\51\57\54\49\52\44\51\57\48\57\53\44\51\57\50\54\48\44\53\54\50\52\51\44\51\56\54\49\52\44\53\53\53\54\52\44\54\49\53\54\57\44\53\52\57\48\52\44\53\48\53\51\54\44\53\52\50\56\53\44\54\54\55\53\54\44\52\56\48\50\55\44\52\49\52\49\53\44\53\56\57\57\50\44\52\49\57\52\50\44\54\49\51\50\52\44\54\55\57\49\52\44\53\49\55\56\50\44\54\50\51\53\55\44\52\54\53\54\49\44\53\56\49\49\56\44\53\51\49\49\56\44\52\54\49\55\54\44\54\51\49\49\57\44\52\56\57\53\53\44\51\54\56\54\56\44\52\53\51\50\48\44\51\53\56\54\48\44\52\53\54\50\50\44\53\54\55\48\56\44\54\52\54\54\57\44\53\48\57\51\53\44\52\51\48\57\51\44\52\57\50\49\53\44\52\52\57\50\49\44\52\49\56\56\52\44\52\49\49\52\50\44\53\53\51\54\50\44\53\54\50\50\55\44\54\54\51\51\52\44\54\55\49\53\57\44\54\51\50\53\48\44\54\56\50\48\48\44\51\56\55\48\48\44\51\54\50\57\48\44\52\55\51\48\53\44\54\49\54\57\51\44\54\51\56\49\57\44\51\56\56\50\55\44\52\48\56\56\55\44\54\49\57\55\49\44\54\53\53\49\48\44\54\49\50\48\54\44\53\52\49\53\56\44\53\50\49\50\57\44\52\57\48\56\56\44\53\50\50\57\48\44\53\50\49\50\54\44\51\57\48\57\55\44\54\52\50\53\51\44\53\52\49\57\54\44\53\56\52\54\51\44\52\49\50\53\48\44\53\54\57\49\52\44\51\56\53\53\54\44\53\56\50\52\54\44\51\54\53\50\53\44\53\57\55\57\57\44\52\55\54\50\51\44\52\52\48\56\50\44\52\50\51\51\49\44\52\49\54\56\54\44\53\56\53\57\53\44\53\50\51\56\53\44\52\48\48\48\51\44\53\52\55\50\55\44\54\50\52\54\55\44\54\55\55\56\48\44\53\49\53\52\57\44\53\53\49\51\52\44\51\53\49\57\56\44\51\57\54\53\48\44\54\56\52\55\49\44\51\52\55\54\51\44\54\55\49\50\56\44\52\52\49\57\50\44\54\55\57\51\51\44\52\53\57\51\53\44\54\51\54\56\55\44\54\53\56\51\48\44\54\51\55\53\57\44\54\55\51\57\55\44\54\53\55\54\50\44\52\56\49\57\55\44\51\53\57\56\51\44\52\56\56\55\50\44\52\55\49\53\54\44\53\56\54\56\48\44\52\57\50\55\51\44\51\53\53\57\50\44\53\57\57\50\51\44\52\52\56\55\56\44\52\56\54\49\48\44\54\53\49\55\53\44\53\49\49\51\52\44\54\52\55\52\51\44\53\48\57\50\54\44\51\57\49\53\49\44\52\57\54\55\49\44\54\49\48\52\50\44\52\57\54\56\50\44\52\57\55\51\54\44\51\56\55\49\51\44\54\52\54\57\54\44\51\52\55\52\54\44\54\50\50\54\48\44\53\50\57\50\55\44\51\52\57\48\54\44\53\55\51\51\50\44\53\56\52\48\48\44\53\48\49\49\50\44\52\49\48\50\54\44\54\52\52\48\56\44\53\57\49\52\51\44\52\51\51\49\49\44\54\54\52\48\48\44\54\50\48\52\57\44\52\55\52\56\56\44\53\50\51\54\55\44\52\57\53\57\53\44\54\54\54\49\52\44\51\56\55\50\48\44\54\56\50\57\55\44\53\49\51\56\52\44\53\51\56\55\56\44\51\53\50\50\48\44\53\51\56\55\51\44\53\57\49\50\54\44\51\54\57\48\55\44\54\53\53\54\50\44\53\56\55\57\52\44\52\48\48\50\51\44\52\50\56\48\49\44\54\55\48\48\51\44\53\48\56\55\54\44\52\50\49\53\50\44\51\57\48\51\48\44\52\50\54\49\48\44\53\51\53\53\49\44\53\57\48\49\54\44\52\49\51\53\48\44\51\56\54\49\56\44\52\56\53\55\51\44\52\54\54\53\48\44\52\51\50\54\54\44\51\55\54\56\56\44\52\54\50\57\50\44\51\53\49\55\54\44\53\51\55\57\54\44\53\50\52\53\49\44\53\53\53\52\54\44\53\49\55\53\56\44\52\57\55\50\49\44\52\54\50\56\54\44\52\55\56\54\48\44\54\48\54\48\52\44\54\51\49\49\49\44\53\53\53\56\50\44\54\50\57\51\51\44\53\53\49\51\57\44\53\50\54\57\48\44\53\50\50\56\54\44\54\54\53\50\48\44\52\54\48\56\52\44\52\52\56\48\54\44\53\54\55\50\48\44\54\56\57\56\52\44\53\52\51\50\56\44\52\49\51\51\54\44\52\57\54\50\48\44\54\50\49\48\55\44\52\55\56\50\48\44\54\54\49\48\55\44\51\57\57\51\55\44\52\48\56\56\54\44\52\49\57\49\48\44\54\52\53\49\56\44\53\56\49\54\51\44\52\51\50\48\48\44\51\53\56\48\56\44\52\57\53\53\48\44\52\51\51\51\50\44\51\52\57\52\54\44\54\56\56\53\52\44\54\54\51\57\52\44\53\56\55\49\57\44\53\51\53\49\48\44\53\55\54\54\51\44\53\49\55\55\54\44\54\54\50\49\51\44\53\54\51\49\54\44\54\53\56\55\51\44\54\53\52\56\55\44\53\57\55\50\52\44\54\52\54\57\56\44\51\57\56\49\57\44\53\56\51\56\49\44\53\48\52\49\57\44\52\48\50\49\55\44\54\52\57\48\55\44\52\50\52\53\50\44\52\50\55\55\48\44\53\56\49\50\48\44\51\57\49\57\52\44\52\54\52\54\53\44\52\53\51\54\52\44\54\55\50\50\53\44\52\48\54\50\53\44\52\56\52\48\53\44\53\48\52\49\52\44\54\51\50\57\52\44\51\52\57\51\49\44\54\53\49\52\56\44\53\53\56\51\56\44\53\50\55\49\55\44\54\51\57\55\56\44\53\53\52\49\52\44\54\48\52\52\55\44\52\57\49\55\48\44\52\54\53\51\51\44\53\51\50\52\50\44\53\52\51\55\52\44\53\50\53\56\51\44\52\56\52\50\54\44\53\54\48\55\55\44\53\49\55\56\48\44\54\56\55\54\52\44\51\57\51\57\57\44\53\48\53\55\55\44\54\53\53\51\50\44\53\52\57\53\49\44\53\52\52\54\54\44\54\48\55\54\54\44\52\55\52\51\53\44\54\48\49\51\52\44\53\52\49\50\51\44\52\52\48\49\56\44\52\53\50\52\53\44\54\56\57\55\51\44\51\55\57\54\50\44\51\55\52\55\52\44\53\57\53\57\54\44\51\55\55\51\56\44\51\53\48\56\49\44\53\51\53\54\48\44\51\54\53\56\48\44\54\48\49\54\57\44\51\56\48\51\51\44\52\50\51\48\56\44\52\57\56\52\54\44\54\50\51\56\56\44\54\52\49\48\50\44\53\53\57\51\56\44\53\53\55\52\50\44\52\49\54\55\51\44\54\55\48\54\51\44\54\56\57\52\50\44\52\56\49\57\57\44\52\51\57\56\51\44\53\49\49\55\48\44\54\56\48\52\56\44\54\48\49\57\48\44\54\53\48\54\53\44\51\56\53\48\49\44\52\51\51\54\57\44\51\56\54\52\54\44\53\52\48\53\53\44\52\54\54\56\51\44\53\54\54\50\48\44\53\54\51\52\55\44\54\52\48\52\51\44\54\53\56\52\51\44\53\53\56\50\56\44\52\48\56\53\54\44\53\49\53\53\48\44\52\49\49\48\52\44\51\56\48\49\53\44\53\50\52\55\57\44\53\53\52\48\49\44\52\50\57\57\53\44\54\51\52\57\50\44\54\55\51\51\51\44\52\53\53\48\51\44\52\52\48\52\51\44\54\52\55\52\48\44\52\55\56\52\51\44\54\52\51\52\51\44\52\49\55\57\48\44\54\52\50\52\52\44\53\51\49\56\52\44\54\56\50\51\55\44\52\53\51\54\57\44\53\57\51\50\56\44\51\53\55\56\51\44\52\48\51\52\53\44\53\48\51\48\50\44\52\57\50\57\54\44\52\53\48\54\48\44\51\53\49\56\54\44\54\56\48\48\53\44\52\53\56\57\56\44\51\56\49\52\57\44\51\55\53\49\55\44\54\56\55\51\50\44\54\53\55\57\52\44\52\54\49\48\49\44\52\52\48\48\57\44\51\55\53\53\54\44\51\57\54\50\54\44\53\56\53\49\48\44\53\51\51\51\56\44\54\55\48\51\50\44\52\57\49\53\52\44\51\53\50\53\57\44\53\54\50\53\54\44\54\52\51\54\56\44\54\52\54\50\50\44\53\49\48\48\49\44\52\49\49\49\52\44\52\51\49\51\51\44\53\57\49\48\54\44\52\54\52\52\50\44\52\51\52\56\57\44\53\49\49\52\53\44\51\54\56\50\52\44\52\56\49\48\50\44\52\52\52\49\56\44\51\52\57\48\52\44\53\56\55\52\50\44\52\56\56\48\50\44\51\56\51\51\50\44\52\51\52\48\48\44\51\52\55\55\48\44\51\57\51\53\53\44\51\54\49\50\51\44\52\57\57\56\50\44\53\48\56\57\51\44\52\52\48\56\57\44\54\55\49\50\54\44\54\55\52\49\49\44\53\48\56\49\50\44\53\54\51\51\48\44\53\52\52\57\54\44\52\48\51\55\54\44\52\49\48\56\55\44\53\50\56\53\50\44\54\55\54\57\51\44\51\56\50\53\51\44\52\53\52\51\55\44\52\51\56\49\49\44\52\52\49\49\56\44\54\54\55\53\57\44\54\54\48\53\53\44\52\48\53\52\52\44\51\53\48\49\52\44\52\54\51\55\48\44\54\54\53\56\48\44\52\56\55\56\48\44\52\56\54\55\48\44\53\54\51\53\51\44\53\57\50\51\50\44\53\51\56\50\53\44\52\55\52\49\51\44\54\55\48\50\51\44\54\52\48\49\56\44\52\54\52\51\57\44\52\56\49\51\49\44\52\53\49\57\55\44\54\51\54\49\51\44\51\56\55\48\52\44\53\49\51\51\50\44\52\54\54\52\54\44\53\57\52\54\57\44\54\57\48\53\55\44\53\53\54\51\55\44\52\56\55\52\55\44\54\51\55\57\55\44\51\53\50\52\48\44\53\55\51\52\48\44\51\56\52\56\50\44\52\55\50\54\54\44\52\56\48\50\48\44\53\50\57\49\56\44\53\48\52\54\56\44\54\50\50\49\52\44\52\51\51\51\54\44\54\54\49\55\48\44\51\55\50\54\52\44\54\55\56\55\54\44\52\54\57\57\50\44\52\56\54\52\52\44\52\48\49\57\48\44\52\52\49\56\55\44\54\48\57\51\55\44\53\50\57\48\52\44\52\53\51\52\57\44\53\54\55\52\56\44\51\52\54\48\57\44\51\56\51\52\53\44\54\55\55\57\53\44\53\56\54\56\56\44\52\53\53\56\49\44\51\53\55\50\51\44\53\55\48\51\51\44\52\51\53\52\52\44\53\57\57\49\51\44\52\51\52\54\51\44\53\52\50\56\52\44\51\53\53\56\49\44\51\56\57\50\49\44\53\51\52\57\49\44\53\51\52\49\51\44\54\56\52\52\49\44\53\52\55\49\48\44\53\51\56\54\52\44\52\57\57\50\56\44\54\50\50\54\51\44\52\50\53\54\54\44\52\50\56\53\54\44\53\52\53\50\53\44\52\56\52\55\53\44\53\50\57\52\48\44\54\54\51\53\56\44\54\54\52\55\56\44\52\51\55\52\52\44\52\48\50\57\54\44\51\53\52\57\50\44\54\51\49\57\52\44\53\51\50\50\53\44\52\56\54\48\50\44\53\51\52\49\56\44\54\50\48\54\50\44\54\48\49\53\55\44\53\49\54\55\51\44\51\54\50\54\53\44\52\51\56\50\57\44\52\52\57\48\52\44\54\51\51\48\54\44\54\52\56\52\50\44\52\51\53\53\51\44\54\49\51\52\57\44\53\51\55\50\49\44\54\50\54\48\50\44\52\57\56\56\52\44\54\51\53\57\51\44\53\49\49\52\54\44\54\56\51\52\57\44\51\53\54\51\50\44\54\48\48\54\49\44\52\50\52\50\55\44\54\51\51\55\50\44\53\57\55\48\57\44\54\55\57\53\54\44\53\55\49\52\55\44\51\57\57\51\56\44\53\54\53\49\53\44\53\51\50\52\51\44\51\54\54\49\50\44\51\54\48\51\49\44\54\48\50\50\53\44\54\50\49\55\50\44\54\52\51\48\52\44\53\56\48\51\54\44\51\55\53\55\54\44\52\54\52\52\53\44\53\52\49\51\51\44\51\54\53\55\50\44\54\52\51\56\50\44\52\57\51\55\51\44\51\53\50\57\48\44\54\53\48\54\52\44\54\52\50\48\52\44\52\54\52\53\53\44\52\50\49\55\53\44\51\56\55\49\57\44\52\50\52\54\57\44\52\49\55\50\51\44\53\51\49\53\50\44\53\53\48\52\49\44\54\48\50\54\51\44\54\56\54\51\54\44\51\56\53\49\52\44\53\50\57\53\57\44\52\56\49\51\56\44\54\55\54\49\57\44\54\52\48\56\50\44\51\52\55\49\49\44\51\53\49\51\55\44\52\52\49\49\49\44\52\52\50\57\55\44\52\57\52\50\56\44\52\49\56\50\57\44\53\48\57\54\55\44\52\57\50\51\52\44\54\54\56\55\57\44\53\54\55\51\54\44\53\50\57\51\49\44\52\56\50\56\52\44\53\54\57\53\48\44\51\54\57\53\49\44\52\57\53\51\53\44\53\52\51\48\49\44\53\49\50\51\55\44\51\52\57\48\55\44\54\55\51\50\57\44\52\53\55\54\56\44\53\51\57\53\53\44\54\56\49\55\52\44\54\51\50\49\49\44\53\50\56\57\50\44\53\50\51\51\48\44\52\55\53\54\54\44\53\57\56\50\56\44\54\50\48\52\51\44\54\48\55\54\56\44\52\57\48\51\52\44\54\54\54\51\57\44\54\56\51\57\48\44\52\54\50\50\48\44\52\57\53\52\50\44\52\50\55\56\54\44\53\56\49\57\55\44\53\53\55\52\48\44\53\49\52\48\55\44\53\50\50\52\50\44\53\49\54\48\54\44\53\48\48\57\54\44\54\56\53\50\57\44\54\53\49\49\53\44\53\48\51\57\50\44\54\50\57\54\56\44\54\49\53\51\52\44\53\54\48\52\48\44\54\48\54\49\57\44\53\54\53\56\54\44\51\55\56\50\53\44\52\52\54\56\56\44\54\54\48\57\48\44\54\51\53\53\50\44\54\52\48\56\57\44\52\57\54\56\48\44\51\56\49\48\49\44\52\52\49\54\53\44\52\50\50\50\49\44\54\50\53\51\56\44\52\50\55\49\53\44\53\52\53\50\49\44\51\55\48\55\53\44\52\57\49\54\53\44\53\53\50\56\49\44\54\49\52\54\53\44\53\48\51\57\55\44\52\55\52\57\52\44\54\56\50\50\54\44\53\57\54\57\56\44\52\48\52\50\52\44\52\50\55\49\56\44\54\54\52\56\57\44\52\57\52\57\48\44\53\52\55\48\55\44\54\54\56\55\49\44\52\57\52\55\55\44\52\50\51\48\52\44\52\53\52\57\50\44\54\54\48\53\51\44\54\49\56\51\53\44\53\52\53\57\53\44\52\51\57\52\49\44\51\57\54\49\49\44\51\53\56\50\48\44\53\49\56\54\49\44\54\49\56\55\54\44\52\52\53\49\56\44\52\51\55\54\51\44\52\51\56\49\52\44\51\56\53\52\50\44\53\52\53\57\51\44\52\54\52\48\55\44\53\50\52\54\55\44\52\48\57\54\49\44\53\54\56\55\53\44\52\48\52\57\57\44\54\55\49\49\56\44\54\48\51\54\53\44\51\57\48\54\49\44\52\51\54\48\53\44\52\49\52\52\57\44\54\50\53\51\53\44\51\53\54\49\54\44\53\48\50\56\49\44\52\52\51\51\48\44\53\56\55\57\56\44\54\55\49\54\50\44\51\55\55\50\53\44\51\57\50\57\52\44\54\54\55\48\57\44\52\56\48\54\52\44\52\50\57\54\55\44\52\55\51\49\49\44\51\55\48\57\57\44\52\48\55\56\55\44\53\50\55\55\49\44\51\53\49\55\50\44\54\52\57\56\57\44\53\56\56\48\52\44\54\53\54\48\54\44\51\55\53\51\51\44\54\54\49\51\56\44\53\52\52\52\48\44\54\54\54\50\57\44\54\55\56\57\49\44\53\54\52\57\48\44\54\51\54\52\55\44\52\56\50\51\56\44\54\56\49\57\53\44\51\56\52\50\56\44\53\51\53\51\49\44\53\56\54\55\55\44\52\50\54\48\49\44\52\53\56\54\48\44\54\52\55\51\55\44\54\51\48\56\52\44\51\57\55\52\55\44\52\56\48\50\52\44\51\54\55\56\49\44\52\57\57\49\54\44\51\56\55\52\56\44\52\49\55\49\49\44\54\51\51\53\49\44\51\56\49\50\49\44\51\55\53\50\49\44\51\55\52\56\55\44\54\48\57\54\50\44\53\54\56\52\51\44\52\55\57\57\56\44\51\53\48\51\56\44\53\52\49\51\56\44\51\52\53\55\48\44\53\50\56\48\51\44\51\55\56\48\54\44\54\52\53\49\51\44\52\50\50\52\53\44\51\56\53\51\56\44\53\53\50\48\48\44\53\52\56\53\52\44\54\51\54\51\54\44\53\49\51\54\49\44\51\53\56\52\49\44\52\50\55\54\51\44\54\52\52\49\51\44\52\54\55\55\55\44\54\52\48\55\48\44\51\57\52\55\54\44\54\53\52\50\49\44\51\55\51\56\50\44\54\54\52\48\51\44\52\54\55\57\52\44\52\52\55\53\51\44\51\53\53\50\57\44\53\52\56\51\53\44\51\54\57\51\53\44\52\56\57\48\48\44\54\53\52\53\53\44\52\49\56\55\49\44\54\54\52\57\54\44\53\50\52\57\49\44\51\56\54\53\49\44\53\51\57\54\57\44\54\48\53\50\51\44\51\52\53\53\50\44\54\51\57\56\51\44\52\49\52\49\52\44\53\53\49\57\51\44\52\53\55\54\50\44\52\52\49\57\57\44\53\53\52\54\53\44\52\51\56\51\56\44\53\51\53\53\53\44\53\48\49\51\49\44\51\53\48\51\54\44\51\54\57\48\53\44\51\52\55\48\55\44\51\55\55\57\51\44\54\49\52\57\53\44\51\53\51\52\54\44\51\54\55\57\54\44\51\55\53\49\56\44\54\54\57\54\52\44\52\51\56\54\56\44\54\56\53\50\49\44\51\56\48\53\55\44\53\50\55\52\50\44\53\51\56\51\49\44\52\53\57\49\52\44\53\53\54\57\54\44\51\55\56\56\54\44\53\55\50\52\48\44\53\56\49\48\52\44\53\53\52\51\49\44\54\53\49\57\54\44\53\55\51\55\49\44\52\50\56\51\56\44\52\56\49\56\54\44\52\50\57\52\57\44\52\53\51\53\48\44\53\53\49\48\48\44\52\54\49\55\49\44\53\49\50\53\53\44\52\54\56\55\53\44\54\53\50\57\50\44\52\48\55\54\55\44\54\55\53\51\48\44\54\53\53\57\56\44\53\55\55\56\56\44\53\54\53\51\53\44\54\56\50\51\50\44\52\52\55\49\50\44\51\57\57\57\51\44\54\54\51\52\52\44\51\55\53\54\56\44\52\54\48\54\52\44\52\50\57\56\57\44\54\49\50\49\53\44\53\54\48\54\51\44\54\56\48\52\51\44\53\54\51\57\49\44\53\50\51\48\55\44\52\49\57\51\51\44\53\52\56\51\50\44\54\53\49\56\53\44\54\49\56\53\56\44\54\53\55\51\48\44\53\55\55\52\50\44\52\52\53\50\49\44\53\55\54\49\49\44\54\49\56\54\55\44\54\49\48\53\53\44\51\52\56\48\54\44\53\51\56\53\50\44\51\54\50\48\54\44\53\57\55\51\53\44\53\48\51\56\55\44\52\57\56\48\52\44\52\57\50\54\57\44\51\54\48\54\53\44\53\52\51\54\48\44\51\55\48\49\56\44\53\55\56\57\53\44\53\56\54\55\54\44\53\55\55\54\51\44\52\57\51\49\50\44\54\52\50\56\54\44\51\54\49\49\51\44\52\50\53\56\54\44\54\50\49\54\50\44\52\51\57\57\53\44\53\54\53\55\55\44\52\48\57\54\54\44\54\48\52\52\53\44\53\53\50\54\52\44\52\51\55\48\56\44\52\52\53\56\57\44\52\55\48\56\51\44\53\54\55\51\53\44\54\48\54\51\49\44\52\55\49\50\50\44\52\56\52\49\54\44\52\57\51\48\49\44\53\55\54\53\48\44\52\48\52\55\51\44\51\57\55\48\52\44\54\51\50\48\51\44\53\48\54\49\56\44\54\50\49\49\53\44\52\54\52\54\51\44\53\55\55\55\55\44\52\52\56\57\54\44\51\55\51\56\52\44\53\57\50\51\57\44\54\57\48\53\50\44\51\53\54\51\51\44\52\49\48\56\51\44\51\57\53\52\56\44\51\52\56\56\55\44\54\55\56\52\50\44\52\50\54\54\54\44\53\49\54\50\55\44\54\50\48\54\51\44\52\49\53\50\50\44\52\50\54\49\51\44\53\57\56\51\52\44\54\50\50\55\57\44\52\56\56\57\55\44\51\56\49\53\55\44\52\53\56\49\48\44\53\56\49\52\49\44\52\56\49\54\54\44\52\55\48\48\55\44\54\52\50\53\49\44\53\57\55\53\50\44\53\51\53\56\56\44\54\53\50\53\55\44\52\51\51\52\50\44\54\49\55\51\55\44\52\48\51\54\49\44\52\53\52\52\56\44\51\54\54\50\50\44\53\50\50\48\57\44\51\55\50\53\49\44\54\52\53\52\55\44\52\56\57\55\48\44\52\55\51\51\52\44\53\51\54\57\54\44\54\50\57\51\52\44\53\49\48\53\51\44\51\55\50\54\49\44\54\56\48\52\57\44\52\53\51\56\49\44\53\50\51\51\54\44\54\50\50\51\56\44\51\53\48\56\51\44\52\51\50\50\56\44\54\55\56\53\57\44\52\55\48\55\57\44\52\55\57\49\54\44\51\53\49\49\56\44\52\49\54\56\55\44\54\55\49\56\57\44\54\51\48\56\56\44\53\48\52\51\51\44\51\56\54\50\48\44\52\52\56\55\52\44\53\53\51\48\56\44\53\56\50\56\56\44\53\51\57\51\52\44\53\57\55\51\51\44\54\53\52\50\53\44\52\54\48\52\55\44\53\50\48\56\49\44\52\50\56\48\52\44\53\50\52\49\51\44\54\50\55\57\55\44\52\52\55\55\56\44\53\56\49\53\50\44\53\55\51\51\51\44\53\55\54\52\51\44\51\57\50\48\57\44\52\57\53\53\52\44\54\49\51\56\55\44\51\56\56\52\57\44\53\53\50\57\56\44\51\53\51\53\52\44\53\50\56\49\54\44\54\55\49\53\56\44\54\54\57\54\55\44\52\55\49\48\53\44\52\48\52\52\50\44\53\48\50\56\54\44\51\56\54\51\48\44\52\51\51\51\56\44\52\56\52\50\51\44\53\52\55\51\56\44\51\57\51\56\51\44\52\51\49\56\49\44\52\55\56\56\54\44\52\48\48\48\56\44\51\57\57\57\50\44\54\52\49\57\54\44\54\50\48\50\54\44\54\48\55\52\51\44\52\54\48\50\51\44\51\57\53\54\48\44\52\51\56\52\53\44\52\48\50\57\53\44\53\54\51\56\48\44\54\51\55\57\52\44\53\55\49\56\57\44\53\57\50\55\54\44\52\55\56\53\51\44\51\55\54\54\52\44\54\55\52\57\55\44\54\51\53\56\57\44\52\50\48\51\56\44\54\56\51\52\49\44\52\51\53\52\56\44\52\50\55\50\55\44\54\54\53\53\48\44\53\52\52\50\57\44\54\53\53\48\53\44\53\55\52\51\48\44\53\54\48\56\56\44\54\50\56\57\53\44\52\51\57\54\51\44\52\50\54\54\49\44\52\49\57\54\50\44\54\55\56\52\57\44\51\57\52\48\53\44\54\49\52\54\50\44\52\48\54\57\54\44\54\50\56\51\54\44\53\56\54\50\53\44\53\52\49\50\57\44\51\54\53\53\52\44\52\49\55\54\50\44\51\54\53\49\51\44\53\57\49\51\54\44\53\55\50\56\56\44\52\48\49\51\57\44\51\54\49\51\54\44\54\50\50\49\49\44\53\57\52\54\50\44\53\56\56\52\53\44\53\57\48\57\56\44\53\53\48\54\49\44\52\50\55\51\56\44\53\53\50\55\53\44\53\52\48\53\49\44\54\48\55\54\52\44\53\52\57\56\53\44\53\54\56\48\56\44\52\51\48\52\55\44\54\51\55\49\56\44\51\57\57\49\51\44\53\50\55\57\57\44\52\48\57\51\49\44\54\53\48\51\53\44\54\54\51\56\56\44\53\55\52\55\48\44\52\48\54\57\53\44\53\53\49\55\48\44\54\53\56\57\52\44\52\52\48\54\56\44\53\49\48\52\56\44\53\53\48\55\54\44\53\49\51\56\57\44\53\57\49\53\54\44\52\53\52\49\57\44\53\51\51\56\57\44\51\53\53\49\49\44\51\54\48\49\51\44\52\53\48\51\48\44\54\48\49\49\50\44\53\52\50\55\57\44\54\53\55\57\50\44\51\55\51\56\56\44\53\55\57\53\52\44\54\52\49\51\56\44\54\55\56\55\51\44\53\52\51\56\55\44\54\49\57\49\57\44\54\49\54\51\51\44\54\55\54\52\50\44\54\50\56\52\52\44\52\51\49\50\52\44\54\56\48\51\50\44\54\55\48\55\51\44\54\51\54\54\49\44\52\54\52\48\52\44\53\49\56\56\52\44\54\54\49\56\55\44\51\56\51\48\55\44\54\51\57\54\50\44\52\57\51\56\51\44\54\52\55\49\53\44\53\49\48\48\48\44\53\56\50\49\51\44\52\53\54\53\52\44\53\48\53\53\51\44\52\49\51\48\56\44\53\57\57\54\48\44\54\53\52\55\49\44\52\54\57\50\53\44\53\57\51\56\55\44\53\57\57\50\49\44\52\48\56\56\57\44\53\54\56\56\56\44\53\56\51\56\57\44\54\49\52\51\56\44\51\54\51\56\48\44\53\50\53\48\48\44\52\56\53\48\52\44\52\56\57\53\56\44\53\57\54\49\50\44\52\50\54\56\52\44\51\53\49\57\52\44\54\54\48\53\55\44\54\53\55\50\56\44\52\48\56\54\48\44\54\52\53\53\53\44\53\54\54\49\55\44\53\53\50\51\54\44\53\56\48\49\54\44\51\56\54\55\50\44\54\48\52\48\56\44\52\56\55\52\49\44\53\52\51\53\55\44\54\49\49\57\54\44\52\55\49\56\52\44\53\53\49\55\57\44\53\50\57\57\53\44\51\55\57\52\56\44\52\56\56\52\54\44\51\55\49\48\54\44\53\56\51\49\54\44\52\51\53\55\57\44\51\53\52\51\57\44\51\56\52\56\51\44\52\55\53\49\49\44\52\48\50\49\49\44\53\48\52\57\54\44\52\48\50\49\48\44\52\50\50\52\52\44\51\55\48\50\53\44\53\54\57\56\50\44\52\57\50\51\53\44\53\51\56\51\53\44\52\54\53\55\53\44\53\50\53\49\50\44\53\54\51\50\51\44\54\49\51\50\50\44\52\53\52\50\54\44\54\56\50\56\51\44\51\53\55\54\48\44\51\57\56\51\56\44\52\53\53\57\57\44\53\56\53\54\57\44\53\52\52\55\48\44\52\50\52\54\51\44\52\51\48\48\50\44\51\53\52\52\50\44\52\57\53\54\52\44\51\55\49\55\51\44\52\50\54\53\56\44\54\48\49\57\53\44\52\55\57\53\57\44\51\53\51\55\50\44\53\57\53\49\54\44\53\51\51\54\49\44\53\57\48\55\48\44\53\48\57\49\48\44\51\54\52\50\56\44\53\52\55\57\48\44\54\54\57\52\48\44\51\55\53\55\49\44\52\53\49\57\57\44\54\55\50\57\49\44\53\57\51\50\57\44\54\54\50\52\49\44\54\56\54\53\53\44\54\56\50\50\48\44\52\49\51\57\57\44\51\54\56\55\56\44\53\56\48\51\48\44\53\56\49\50\50\44\54\55\51\49\48\44\51\54\54\49\56\44\52\57\54\49\48\44\53\48\48\56\49\44\52\56\48\56\51\44\53\54\48\51\54\44\53\50\49\56\56\44\53\53\53\55\53\44\53\48\49\49\57\44\51\53\54\51\52\44\51\55\56\49\50\44\52\50\52\52\57\44\54\49\57\54\51\44\51\57\51\50\49\44\51\56\56\56\56\44\53\51\55\49\53\44\54\53\51\55\54\44\53\49\56\54\52\44\52\51\54\51\52\44\52\55\52\54\51\44\54\55\49\51\48\44\52\52\50\53\56\44\51\55\54\57\54\44\52\53\48\53\49\44\54\48\52\48\57\44\53\57\51\57\56\44\52\48\56\52\49\44\54\50\49\57\57\44\53\49\52\57\53\44\51\53\53\51\55\44\52\57\53\57\54\44\54\49\49\57\56\44\52\50\56\57\51\44\54\55\50\54\53\44\53\53\48\53\53\44\54\56\55\48\48\44\53\57\50\50\56\44\54\53\55\51\50\44\51\55\57\54\55\44\53\48\55\48\50\44\51\55\55\53\49\44\53\56\55\50\56\44\53\49\54\53\50\44\51\53\57\57\53\44\54\53\54\56\54\44\53\50\52\51\56\44\53\55\49\55\49\44\51\53\50\53\49\44\51\53\48\50\55\44\53\54\55\52\55\44\52\56\54\48\54\44\53\54\50\48\56\44\54\49\55\48\55\44\54\55\57\48\48\44\52\52\51\56\52\44\54\51\56\56\48\44\52\50\52\52\53\44\51\57\51\51\50\44\53\53\50\52\52\44\53\55\48\53\50\44\54\48\52\48\52\44\54\49\56\53\54\44\54\56\56\51\53\44\51\53\55\56\57\44\52\50\48\53\48\44\52\51\50\48\56\44\51\55\48\49\52\44\51\55\53\51\57\44\53\55\48\52\57\44\54\49\54\54\52\44\53\57\53\50\48\44\53\53\54\50\49\44\52\49\49\53\56\44\53\51\55\57\57\44\52\51\55\57\51\44\52\48\54\57\57\44\51\53\51\51\49\44\53\51\48\52\49\44\54\49\50\51\50\44\54\49\57\48\50\44\53\57\48\56\49\44\54\55\48\49\48\44\53\53\50\48\55\44\53\48\51\57\52\44\54\48\54\56\53\44\52\50\50\53\53\44\54\48\54\54\57\44\53\50\53\54\54\44\54\49\54\57\53\44\54\48\57\53\57\44\52\56\50\54\54\44\53\49\48\50\53\44\52\57\55\49\49\44\52\54\53\56\51\44\52\55\55\53\57\44\54\48\49\57\54\44\53\53\57\57\54\44\54\49\54\53\51\44\53\51\55\53\49\44\53\48\48\53\48\44\52\53\50\53\54\44\51\54\53\57\53\44\54\50\51\48\56\44\52\48\55\51\48\44\53\52\50\50\52\44\52\56\48\54\49\44\51\55\51\52\51\44\53\53\49\55\52\44\53\57\50\48\55\44\53\55\53\48\51\44\51\52\55\52\48\44\52\53\49\49\52\44\52\55\53\49\56\44\54\54\55\56\49\44\53\49\50\49\48\44\52\53\50\53\56\44\51\53\55\51\48\44\53\50\50\52\53\44\53\48\56\52\50\44\53\50\55\52\49\44\52\57\49\52\50\44\53\49\48\50\52\44\52\53\50\54\53\44\54\55\50\56\55\44\52\53\48\49\52\44\51\53\53\50\53\44\53\51\56\52\54\44\52\48\55\56\56\44\54\56\54\57\56\44\52\57\49\51\55\44\54\49\51\51\52\44\51\55\49\56\54\44\54\55\50\48\57\44\53\55\53\52\51\44\53\55\49\50\52\44\52\57\56\55\51\44\54\56\56\55\51\44\51\56\55\55\54\44\53\50\49\51\50\44\53\49\56\54\51\44\54\52\53\51\48\44\52\56\49\56\48\44\53\54\49\57\52\44\53\49\49\53\49\44\52\54\51\53\52\44\52\55\49\52\49\44\54\55\53\48\50\44\52\52\57\49\51\44\53\48\51\56\49\44\54\49\55\57\50\44\52\56\52\52\48\44\52\55\56\55\50\44\53\48\48\48\52\44\53\53\52\57\56\44\52\50\50\51\49\44\52\48\50\55\56\44\52\54\54\50\48\44\53\54\48\51\50\44\54\51\57\56\56\44\54\50\55\53\56\44\54\53\57\56\52\44\53\50\50\48\52\44\53\48\53\51\48\44\53\53\53\54\57\44\51\55\51\54\54\44\54\51\56\57\50\44\54\48\50\57\51\44\54\51\50\50\52\44\53\53\48\52\50\44\52\52\51\55\51\44\54\56\55\57\53\44\52\55\55\56\48\44\54\52\51\52\55\44\53\53\55\48\56\44\52\51\55\51\50\44\53\50\48\55\54\44\51\57\53\57\50\44\54\50\51\56\53\44\54\56\48\57\48\44\54\55\51\51\54\44\51\53\51\52\56\44\53\54\50\53\51\44\52\50\49\56\51\44\54\55\51\57\53\44\54\55\54\53\57\44\52\50\53\54\55\44\52\53\57\48\49\44\52\53\49\56\54\44\52\56\56\55\52\44\54\54\55\55\49\44\53\55\54\57\48\44\54\52\50\52\50\44\52\50\53\52\52\44\52\56\56\56\56\44\53\51\49\52\56\44\54\54\56\54\56\44\53\48\51\54\48\44\52\54\56\53\57\44\53\51\50\51\54\44\53\49\56\48\55\44\51\54\55\57\51\44\53\53\52\55\50\44\52\48\56\53\50\44\52\53\57\51\48\44\53\55\56\53\51\44\52\48\52\56\50\44\54\54\54\48\54\44\54\54\48\49\56\44\52\51\56\54\49\44\54\48\56\53\55\44\51\57\49\51\48\44\53\50\57\52\51\44\51\56\53\51\52\44\52\49\50\53\55\44\54\51\55\48\51\44\53\48\50\57\54\44\53\50\55\50\50\44\51\54\48\57\55\44\51\56\57\57\54\44\54\56\57\52\55\44\53\50\51\55\56\44\53\57\52\50\53\44\54\48\52\55\50\44\54\51\52\48\51\44\52\54\49\54\56\44\52\48\50\56\57\44\52\55\56\52\52\44\53\50\53\55\50\44\52\49\55\48\52\44\54\49\52\53\49\44\53\48\50\53\57\44\54\50\50\49\48\44\51\57\57\48\56\44\54\56\54\48\55\44\51\57\51\50\48\44\52\56\48\48\50\44\51\55\52\54\55\44\52\48\54\48\49\44\53\56\48\53\56\44\54\53\56\56\52\44\54\50\54\57\48\44\51\57\51\57\54\44\51\54\57\52\53\44\52\53\54\52\48\44\53\54\55\53\49\44\52\53\57\48\57\44\54\53\49\51\52\44\52\57\54\49\50\44\54\55\51\49\50\44\54\53\54\53\57\44\54\54\51\48\50\44\52\51\51\57\53\44\52\52\50\53\49\44\51\56\50\52\55\44\53\50\50\57\52\44\54\55\56\51\48\44\54\49\54\52\56\44\54\50\55\57\51\44\51\53\51\50\51\44\52\55\55\56\57\44\52\48\55\48\56\44\53\57\51\53\52\44\52\50\54\51\50\44\52\56\53\57\49\44\52\51\50\48\51\44\54\53\48\51\55\44\53\54\49\53\55\44\51\52\55\49\50\44\52\54\50\56\51\44\52\56\48\57\50\44\51\53\57\48\54\44\52\56\48\53\57\44\53\56\49\56\48\44\51\56\51\55\51\44\54\53\57\57\55\44\51\53\48\53\51\44\52\50\57\52\51\44\53\48\48\54\52\44\52\49\50\55\56\44\54\54\50\48\54\44\54\50\52\50\54\44\51\55\48\55\48\44\52\56\50\53\57\44\51\53\49\55\55\44\52\53\49\49\55\44\54\52\50\50\50\44\51\52\52\57\57\44\52\56\55\52\51\44\52\51\51\50\50\44\53\50\49\50\51\44\52\49\54\56\53\44\54\53\56\57\55\44\52\49\52\57\57\44\53\53\57\52\56\44\52\56\56\49\57\44\54\56\49\54\53\44\53\54\57\48\53\44\54\52\50\54\51\44\54\53\56\56\55\44\54\52\50\51\56\44\51\56\49\57\55\44\53\51\55\50\50\44\53\48\55\51\50\44\52\56\48\48\56\44\54\51\50\52\55\44\52\52\50\55\48\44\53\54\57\57\54\44\53\48\57\49\49\44\53\57\55\52\50\44\53\53\48\48\51\44\53\53\50\53\48\44\52\53\49\54\51\44\52\56\49\56\56\44\52\54\51\56\50\44\54\51\48\56\54\44\51\55\52\54\57\44\54\51\57\49\56\44\54\56\55\51\52\44\53\53\54\49\54\44\54\53\57\57\49\44\52\57\53\52\48\44\51\55\56\51\55\44\52\57\52\51\49\44\51\54\49\48\55\44\54\52\54\56\56\44\52\49\55\51\48\44\53\56\53\53\53\44\54\56\53\49\51\44\53\53\48\53\55\44\54\52\50\48\55\44\53\54\57\50\55\44\53\49\49\53\57\44\51\53\48\57\51\44\52\57\57\54\48\44\54\52\54\56\51\44\53\52\56\48\49\44\52\57\52\55\56\44\52\49\50\53\51\44\51\57\49\51\57\44\52\54\48\48\51\44\51\52\57\54\50\44\54\50\53\54\48\44\51\57\49\48\51\44\53\57\50\56\52\44\51\53\55\55\51\44\53\53\55\52\49\44\51\54\53\56\51\44\54\54\54\48\49\44\52\52\52\48\56\44\52\56\49\55\54\44\52\55\52\56\48\44\51\55\53\56\54\44\54\51\49\50\53\44\52\51\54\56\49\44\54\50\56\53\48\44\53\54\53\49\57\44\53\55\48\52\48\44\51\57\54\55\55\44\52\57\54\55\53\44\52\49\55\54\48\44\52\54\53\50\54\44\51\57\56\57\54\44\51\57\50\52\57\44\52\52\53\51\57\44\52\50\57\56\52\44\51\53\57\52\53\44\54\53\55\48\54\44\51\56\55\56\56\44\53\53\56\50\54\44\51\54\49\48\56\44\52\54\51\52\57\44\51\52\55\49\54\44\51\53\52\48\55\44\53\57\49\54\53\44\52\53\48\51\53\44\52\49\52\48\51\44\54\51\52\48\52\44\53\50\51\54\52\44\52\50\51\55\54\44\54\56\50\49\53\44\51\54\51\54\53\44\51\57\56\52\54\44\52\55\54\56\53\44\54\49\52\49\57\44\53\56\48\57\53\44\53\53\53\51\53\44\53\49\56\50\48\44\53\54\54\49\50\44\53\51\50\57\53\44\54\53\49\49\56\44\53\55\54\52\53\44\53\57\54\55\52\44\54\50\48\52\55\44\51\57\51\56\56\44\53\48\50\48\54\44\52\51\57\52\55\44\52\53\56\53\54\44\54\48\57\56\55\44\53\55\48\50\49\44\52\57\50\57\53\44\54\48\51\51\57\44\52\50\51\54\57\44\52\49\51\51\50\44\53\57\50\56\56\44\54\52\49\51\50\44\53\49\56\52\48\44\53\51\54\54\49\44\54\51\57\50\57\44\54\51\55\52\52\44\52\48\48\48\57\44\53\55\48\53\49\44\53\50\55\53\51\44\51\53\50\48\56\44\54\48\49\55\56\44\51\57\54\51\52\44\53\51\56\48\56\44\52\55\57\53\56\44\54\55\51\48\57\44\54\53\50\48\49\44\51\54\49\56\53\44\53\56\51\48\49\44\53\54\53\55\52\44\54\52\54\48\51\44\51\55\57\52\54\44\51\54\49\57\48\44\51\52\56\57\54\44\54\51\49\56\50\44\54\52\48\55\51\44\51\55\49\49\49\44\52\56\55\56\52\44\54\55\52\54\53\44\54\55\48\52\54\44\54\54\55\54\48\44\51\53\50\54\54\44\52\54\48\50\52\44\54\53\51\52\55\44\54\53\57\49\57\44\52\57\53\55\51\44\52\55\50\53\54\44\52\55\50\48\48\44\54\48\48\54\57\44\53\57\57\51\50\44\52\53\52\57\49\44\54\55\54\56\50\44\51\55\48\49\57\44\53\52\57\49\52\44\54\50\53\54\56\44\52\52\56\51\54\44\53\52\50\52\51\44\52\55\55\56\51\44\52\53\51\50\54\44\51\56\56\52\49\44\52\55\50\48\50\44\53\55\53\56\57\44\53\57\50\57\51\44\52\55\55\48\51\44\54\55\52\48\50\44\52\57\48\49\53\44\53\51\50\52\56\44\52\57\55\52\48\44\53\49\53\49\56\44\52\54\49\57\57\44\54\56\53\57\53\44\51\53\49\56\53\44\54\54\54\57\54\44\54\49\49\52\51\44\54\55\52\50\49\44\52\57\54\55\50\44\52\55\49\49\53\44\52\52\48\50\48\44\52\50\48\56\48\44\54\52\54\50\54\44\52\49\51\49\51\44\51\57\52\54\49\44\51\53\49\52\55\44\53\52\53\56\49\44\53\52\54\55\50\44\52\48\49\53\49\44\52\55\55\52\57\44\51\55\52\53\52\44\51\53\48\48\52\44\53\55\56\48\56\44\52\56\52\49\51\44\52\51\56\53\49\44\52\55\54\48\50\44\54\52\52\48\57\44\51\55\55\57\56\44\54\49\57\48\48\44\54\56\49\48\49\44\52\55\53\52\57\44\52\54\57\55\56\44\54\50\56\48\52\44\52\50\54\52\56\44\52\48\48\49\56\44\54\54\54\49\55\44\54\53\53\56\50\44\54\52\57\56\54\44\54\50\53\48\51\44\53\48\51\52\48\44\53\53\52\52\48\44\53\51\49\51\51\44\54\55\49\55\50\44\54\52\51\54\57\44\53\48\48\57\55\44\51\57\52\55\56\44\53\48\49\54\50\44\51\54\54\57\56\44\51\55\48\54\55\44\51\57\53\56\49\44\52\48\53\53\49\44\52\52\48\57\50\44\54\48\50\53\52\44\54\55\49\56\55\44\54\55\55\53\48\44\53\55\53\54\54\44\54\53\50\50\57\44\53\51\49\55\49\44\53\50\50\51\50\44\53\49\50\55\49\44\54\53\57\57\51\44\53\55\51\57\54\44\52\57\56\55\55\44\53\54\55\55\56\44\54\48\49\51\49\44\54\50\53\50\57\44\52\49\50\52\57\44\54\54\53\52\51\44\51\53\55\54\52\44\51\55\56\54\48\44\51\57\57\56\55\44\54\49\51\48\48\44\53\56\54\53\50\44\54\50\48\56\54\44\54\52\49\49\54\44\54\52\51\48\54\44\51\55\54\49\54\44\52\54\51\54\54\44\52\50\49\48\55\44\52\54\55\51\52\44\54\50\55\49\52\44\54\52\51\54\52\44\52\57\56\48\50\44\54\55\50\52\52\44\51\53\51\54\52\44\54\55\55\50\52\44\52\50\50\54\50\44\51\55\48\56\49\44\54\56\56\55\49\44\51\55\50\49\56\44\51\53\57\54\53\44\53\50\52\53\57\44\52\57\57\53\48\44\51\53\57\55\50\44\52\54\48\57\51\44\52\56\51\48\50\44\54\48\54\57\54\44\54\53\52\54\53\44\53\50\56\51\52\44\52\55\51\48\54\44\54\54\55\49\50\44\54\48\54\57\52\44\52\56\48\53\49\44\52\54\55\53\49\44\51\56\51\55\49\44\52\55\54\50\56\44\54\54\53\48\54\44\52\55\57\55\52\44\54\48\55\52\53\44\53\56\49\49\55\44\54\53\54\49\51\44\53\53\56\53\54\44\52\49\56\50\55\44\54\53\54\53\54\44\54\54\48\50\52\44\52\48\53\50\55\44\52\48\50\53\54\44\53\50\49\55\49\44\53\49\55\55\51\44\54\52\53\55\54\44\52\48\56\50\50\44\54\55\50\57\56\44\53\55\52\56\52\44\52\51\49\52\48\44\53\56\57\54\52\44\53\51\52\50\56\44\52\51\48\53\56\44\52\52\48\52\57\44\53\51\57\54\55\44\52\50\54\57\56\44\51\56\49\48\52\44\53\56\54\55\50\44\54\52\57\49\56\44\52\52\56\48\50\44\54\49\49\57\50\44\52\54\53\49\48\44\51\53\57\48\53\44\54\54\50\54\57\44\54\48\55\56\50\44\54\53\48\49\48\44\51\56\49\52\56\44\54\54\53\53\49\44\54\56\51\56\48\44\53\54\50\57\51\44\53\51\55\56\54\44\53\52\49\57\57\44\52\55\49\54\57\44\53\51\55\54\54\44\54\55\49\48\56\44\53\50\50\53\53\44\52\49\50\49\48\44\53\50\52\48\53\44\51\55\56\54\53\44\51\57\57\55\55\44\53\48\51\53\55\44\52\48\53\57\51\44\51\57\57\51\53\44\53\57\52\49\51\44\51\52\52\57\53\44\53\56\54\55\49\44\52\48\49\55\55\44\53\56\52\53\56\44\53\49\49\53\51\44\53\49\51\52\48\44\54\56\56\49\56\44\51\53\57\54\51\44\53\49\51\54\53\44\53\49\48\49\55\44\54\55\49\51\56\44\52\55\55\53\52\44\53\56\57\50\56\44\52\57\56\54\49\44\52\57\51\50\56\44\53\55\49\51\55\44\51\52\56\48\53\44\52\49\49\51\53\44\52\54\50\48\52\44\54\51\51\53\57\44\52\55\56\50\50\44\52\55\55\57\52\44\51\53\50\54\53\44\52\57\56\50\51\44\52\51\56\50\50\44\52\52\51\50\48\44\52\50\53\51\49\44\51\57\53\48\55\44\53\53\50\55\49\44\52\55\50\51\52\44\52\50\57\51\54\44\52\54\48\48\55\44\54\52\54\48\50\44\51\55\57\54\51\44\52\56\50\55\51\44\51\54\51\52\53\44\52\57\57\55\50\44\52\52\57\54\54\44\54\56\54\54\54\44\51\56\48\48\51\44\51\57\54\55\51\44\54\55\54\51\52\44\52\48\51\56\54\44\51\55\53\54\55\44\54\50\51\49\57\44\53\48\48\54\57\44\53\53\53\49\53\44\52\56\48\49\50\44\51\56\56\52\56\44\53\55\52\53\50\44\54\53\49\51\55\44\52\51\56\56\50\44\51\57\49\52\57\44\51\53\50\52\55\44\52\52\51\55\54\44\52\50\49\57\54\44\54\55\53\51\52\44\53\52\51\48\51\44\53\57\55\55\54\44\53\48\51\54\52\44\53\54\56\48\57\44\52\48\49\51\48\44\54\55\50\52\56\44\52\51\51\48\53\44\53\50\54\53\52\44\53\49\48\51\53\44\51\54\53\48\57\44\51\52\54\52\53\44\54\51\49\55\51\44\52\52\50\57\53\44\51\56\51\49\56\44\52\56\49\49\51\44\53\51\52\54\53\44\52\53\55\54\55\44\52\57\55\50\51\44\52\56\54\53\53\44\54\57\48\52\48\44\53\48\49\52\53\44\52\49\54\57\55\44\52\57\50\57\57\44\53\48\51\54\53\44\52\53\56\50\53\44\53\51\51\57\49\44\53\51\57\54\53\44\52\51\50\52\51\44\53\56\53\54\55\44\51\55\50\52\52\44\53\57\53\52\52\44\52\48\56\57\51\44\52\48\48\56\48\44\54\53\48\53\55\44\54\53\49\54\56\44\52\55\54\55\56\44\53\48\55\51\52\44\54\54\52\53\56\44\53\48\51\50\55\44\54\53\57\49\49\44\53\50\51\54\54\44\51\56\56\49\48\44\52\57\56\51\55\44\52\48\48\57\53\44\52\53\55\55\56\44\53\56\55\52\54\44\54\48\57\52\53\44\52\57\52\56\50\44\54\53\54\49\49\44\51\52\53\53\54\44\54\55\51\57\50\44\53\56\56\53\54\44\52\53\52\54\49\44\53\52\56\52\49\44\53\52\48\49\57\44\53\53\51\54\56\44\54\53\54\49\57\44\52\55\50\50\48\44\53\49\51\57\49\44\53\55\53\56\48\44\54\52\53\51\53\44\53\55\51\57\57\44\52\57\55\55\50\44\51\53\53\55\48\44\53\51\52\48\56\44\51\53\50\57\55\44\54\55\55\54\49\44\52\56\51\49\56\44\53\55\55\56\52\44\53\55\53\55\51\44\54\52\54\48\49\44\53\55\48\51\48\44\52\55\56\57\54\44\52\56\49\49\54\44\53\56\57\57\54\44\54\54\54\55\49\44\54\48\54\54\54\44\53\56\48\50\54\44\54\56\51\54\48\44\52\49\50\50\49\44\54\49\54\54\54\44\53\57\52\50\57\44\53\51\51\48\52\44\53\56\53\56\48\44\54\54\51\50\50\44\52\51\54\48\48\44\54\49\56\53\48\44\51\55\50\53\53\44\52\50\52\57\50\44\53\49\52\52\55\44\54\49\52\50\53\44\52\52\53\53\56\44\53\51\53\51\48\44\52\56\57\52\54\44\54\52\48\56\52\44\53\51\49\54\57\44\54\57\48\56\53\44\53\55\51\57\56\44\54\50\55\48\52\44\53\49\51\56\53\44\53\55\54\51\57\44\52\50\51\51\52\44\53\53\57\55\55\44\53\53\54\54\50\44\53\49\50\56\49\44\54\53\50\49\57\44\52\57\48\55\57\44\53\55\54\57\56\44\51\55\53\51\49\44\51\57\49\50\54\44\53\55\52\50\51\44\53\53\54\54\52\44\53\48\55\48\57\44\52\53\57\56\49\44\51\56\51\52\54\44\54\52\48\56\48\44\54\49\55\50\48\44\53\52\56\49\50\44\53\57\49\49\48\44\51\54\55\54\53\44\52\57\51\52\57\44\52\56\57\51\56\44\53\54\49\49\56\44\52\48\54\49\48\44\51\54\53\53\54\44\53\48\52\54\54\44\51\56\56\48\50\44\51\55\52\53\51\44\53\49\55\52\52\44\52\52\54\50\48\44\54\52\57\57\57\44\51\53\57\49\48\44\54\53\51\55\52\44\53\49\56\52\51\44\51\52\55\53\56\44\54\50\50\50\56\44\54\48\51\53\52\44\54\54\50\55\54\44\54\54\55\54\50\44\54\52\51\53\57\44\53\49\52\55\54\44\52\53\56\54\50\44\53\56\56\54\49\44\54\53\49\55\48\44\53\50\56\49\56\44\53\56\52\48\51\44\52\55\52\50\50\44\51\53\49\48\50\44\52\55\56\49\56\44\52\56\48\48\55\44\53\48\50\55\56\44\52\49\55\57\56\44\51\57\51\54\51\44\53\54\49\56\54\44\53\57\51\56\49\44\54\52\49\56\57\44\52\57\51\57\54\44\52\51\50\54\51\44\53\54\48\53\54\44\52\51\50\53\50\44\54\48\50\56\55\44\52\54\51\51\55\44\54\55\52\54\48\44\51\53\56\49\51\44\53\48\56\53\57\44\54\49\49\50\57\44\53\53\55\55\56\44\53\51\49\57\50\44\52\52\55\53\53\44\54\51\55\55\55\44\53\50\57\52\57\44\53\51\52\49\57\44\52\53\51\49\54\44\53\52\53\57\55\44\51\54\53\56\52\44\53\48\56\49\49\44\53\53\52\53\51\44\54\50\55\50\49\44\53\49\57\56\52\44\54\49\55\53\52\44\54\50\52\57\56\44\54\54\53\52\54\44\54\50\56\49\48\44\53\51\57\55\54\44\54\48\50\48\48\44\52\50\56\49\56\44\52\57\48\55\51\44\52\48\53\55\53\44\53\52\56\48\57\44\51\53\56\51\51\44\53\56\54\49\49\44\52\50\48\50\56\44\52\56\53\53\49\44\54\50\52\48\53\44\53\57\54\56\49\44\53\54\54\48\57\44\54\48\53\54\55\44\54\52\50\55\50\44\53\50\49\51\52\44\53\48\55\52\55\44\51\56\55\56\50\44\51\56\53\54\54\44\53\48\55\48\56\44\52\56\49\49\53\44\52\52\54\53\55\44\53\56\54\51\54\44\53\56\49\54\52\44\52\53\50\48\56\44\53\49\52\54\51\44\51\53\52\55\51\44\53\55\53\51\55\44\51\57\48\48\56\44\53\54\55\49\50\44\52\48\50\52\53\44\54\53\53\48\57\44\54\50\50\55\54\44\53\50\49\55\51\44\53\56\51\57\56\44\52\49\57\56\48\44\54\50\49\49\50\44\53\54\57\49\53\44\53\55\51\54\51\44\54\48\51\56\52\44\51\57\53\56\48\44\52\55\49\48\55\44\52\49\53\51\55\44\52\48\53\53\56\44\53\48\57\55\56\44\52\51\57\51\49\44\53\52\54\50\54\44\54\55\57\54\56\44\53\49\50\52\56\44\51\53\56\56\56\44\52\51\51\56\55\44\52\53\54\56\49\44\51\57\51\51\48\44\54\50\48\57\51\44\52\50\56\48\57\44\53\55\53\54\50\44\54\48\49\50\51\44\51\54\52\57\49\44\51\53\51\48\54\44\53\54\57\54\56\44\54\55\54\48\56\44\53\56\54\54\53\44\54\55\56\52\56\44\53\53\57\56\52\44\53\56\57\48\48\44\54\49\49\50\48\44\52\49\57\48\48\44\54\53\57\56\54\44\52\49\49\57\53\44\53\49\54\48\56\44\53\50\48\55\56\44\54\54\52\53\52\44\51\57\48\55\54\44\51\57\51\48\49\44\52\56\54\56\55\44\52\49\50\52\49\44\53\55\55\50\54\44\54\52\48\53\57\44\54\50\55\49\49\44\53\50\50\55\53\44\53\52\56\49\48\44\54\48\55\55\48\44\53\53\51\54\49\44\53\50\57\55\52\44\52\52\51\57\49\44\51\56\54\49\49\44\54\55\52\48\55\44\53\54\52\57\54\44\54\56\54\54\50\44\54\55\50\57\50\44\54\50\55\55\54\44\52\54\49\54\52\44\51\53\56\56\53\44\54\51\54\48\55\44\52\51\48\56\56\44\53\57\56\57\48\44\54\49\56\52\55\44\52\54\48\53\51\44\54\53\56\54\56\44\52\49\48\57\56\44\53\57\53\57\57\44\53\57\48\49\56\44\52\57\52\51\52\44\54\51\56\55\54\44\53\55\55\53\57\44\53\48\52\56\54\44\53\55\54\55\50\44\52\55\51\55\55\44\53\48\52\51\53\44\52\52\48\50\52\44\51\57\49\55\56\44\53\52\56\54\52\44\54\50\55\52\49\44\52\55\51\48\57\44\51\56\51\56\51\44\54\49\52\53\54\44\52\54\56\55\52\44\52\52\56\51\51\44\53\50\53\55\56\44\54\56\57\57\49\44\54\49\55\57\51\44\54\48\52\50\48\44\51\55\51\49\56\44\54\49\57\57\49\44\51\52\57\50\57\44\54\55\54\56\53\44\53\53\57\55\54\44\52\51\55\49\48\44\51\53\56\57\54\44\53\53\57\56\51\44\52\50\49\51\49\44\53\49\53\57\56\44\53\53\56\53\49\44\53\50\54\57\56\44\52\49\55\48\51\44\54\49\49\54\51\44\51\53\51\54\50\44\54\50\55\56\49\44\52\53\57\51\52\44\53\51\55\55\48\44\53\54\54\48\52\44\54\56\53\49\52\44\53\57\49\51\53\44\54\55\48\56\50\44\52\49\55\49\50\44\52\56\51\55\49\44\52\50\53\51\50\44\53\56\55\56\57\44\52\51\52\49\54\44\51\54\48\48\53\44\52\56\48\50\54\44\52\51\56\50\52\44\53\52\51\52\57\44\54\49\50\52\53\44\53\55\48\52\53\44\52\54\52\56\54\44\53\54\55\57\54\44\52\53\51\49\51\44\52\54\53\51\53\44\51\55\50\49\54\44\52\57\49\49\57\44\53\48\57\52\51\44\51\54\54\53\51\44\52\50\49\57\52\44\53\57\55\49\52\44\52\51\55\49\53\44\51\53\52\55\53\44\52\48\55\57\55\44\53\54\48\56\53\44\52\50\56\55\52\44\51\53\49\50\57\44\53\56\48\52\53\44\52\54\57\56\55\44\54\55\55\49\52\44\52\57\48\54\56\44\52\51\50\56\48\44\52\55\53\49\55\44\52\57\54\48\48\44\52\49\54\53\54\44\51\55\51\48\49\44\54\54\55\55\56\44\52\53\50\48\50\44\54\56\54\52\52\44\52\51\54\52\56\44\51\56\48\57\57\44\54\54\50\48\52\44\51\52\54\53\48\44\54\50\55\52\54\44\51\54\49\50\49\44\54\49\57\49\48\44\54\54\55\57\55\44\53\55\55\54\49\44\53\57\55\57\54\44\54\53\48\57\53\44\54\56\56\48\57\44\54\51\48\48\54\44\54\52\53\51\50\44\52\57\56\50\56\44\52\54\55\50\53\44\51\56\49\53\50\44\53\48\50\56\56\44\53\55\57\57\48\44\52\49\55\52\57\44\52\48\55\55\50\44\54\56\51\50\48\44\53\52\57\54\54\44\54\48\52\52\49\44\54\54\55\51\54\44\51\56\57\52\51\44\53\49\57\53\48\44\51\54\49\57\51\44\53\49\51\57\48\44\54\55\48\49\54\44\54\48\52\53\56\44\53\51\57\50\56\44\52\51\49\56\50\44\54\48\57\54\52\44\51\55\53\57\57\44\52\57\51\53\54\44\53\53\50\50\57\44\51\57\57\48\53\44\51\54\52\50\50\44\54\52\53\55\53\44\52\49\49\53\50\44\52\54\52\53\57\44\53\54\52\54\52\44\51\52\55\56\56\44\52\53\50\52\57\44\51\57\53\48\48\44\53\50\51\52\53\44\52\51\52\57\57\44\53\51\57\48\49\44\53\52\53\52\49\44\51\54\51\49\56\44\52\50\48\49\56\44\52\57\57\48\55\44\54\50\50\55\49\44\53\53\48\56\52\44\53\56\51\51\57\44\53\52\49\49\54\44\52\53\53\49\55\44\53\48\48\50\57\44\52\53\51\54\54\44\52\48\57\52\52\44\52\52\48\56\55\44\51\53\48\48\55\44\53\57\51\49\48\44\54\51\55\53\53\44\51\53\56\51\48\44\53\55\53\52\54\44\53\50\51\48\50\44\52\52\54\51\48\44\52\52\57\54\55\44\51\53\48\54\48\44\54\53\57\48\51\44\54\51\54\52\50\44\51\53\53\52\48\44\54\49\51\50\56\44\52\49\51\56\57\44\54\55\54\56\54\44\51\56\53\52\49\44\51\55\50\53\52\44\53\52\57\57\49\44\51\57\56\54\55\44\54\54\52\52\56\44\52\48\48\57\49\44\52\55\53\48\51\44\52\51\51\51\57\44\52\57\50\54\51\44\53\50\52\56\56\44\52\48\54\52\55\44\53\50\55\51\53\44\54\49\53\56\48\44\54\49\52\55\57\44\51\56\54\55\53\44\53\54\55\57\49\44\51\57\54\52\56\44\51\53\52\56\52\44\54\48\57\57\54\44\51\55\55\55\51\44\52\51\51\53\56\44\54\54\53\51\49\44\52\51\52\50\57\44\53\56\50\53\53\44\51\57\50\52\53\44\51\52\54\56\57\44\53\50\51\49\55\44\52\51\48\53\53\44\54\57\48\49\53\44\54\54\49\49\52\44\53\51\49\50\48\44\54\54\55\55\53\44\52\52\51\50\55\44\54\53\56\56\48\44\52\54\55\49\54\44\54\54\49\57\55\44\54\51\54\53\57\44\51\53\57\54\56\44\51\56\50\49\50\44\52\50\54\55\51\44\53\51\48\53\55\44\53\55\53\53\49\44\53\51\53\52\54\44\53\52\48\56\53\44\51\56\52\56\54\44\52\55\48\50\52\44\54\56\48\57\51\44\53\49\56\49\55\44\53\57\54\54\48\44\52\56\52\54\57\44\53\53\53\52\57\44\51\57\49\53\50\44\53\53\55\54\54\44\52\55\55\54\51\44\53\57\50\49\49\44\53\50\50\48\54\44\53\50\49\56\54\44\54\54\53\54\56\44\54\52\49\56\52\44\54\54\54\54\57\44\52\55\51\52\49\44\51\54\54\48\54\44\53\49\56\52\56\44\53\53\55\48\51\44\52\57\48\57\48\44\53\48\51\57\57\44\53\48\54\48\54\44\53\54\48\51\51\44\54\53\55\50\52\44\52\57\52\49\48\44\53\54\55\52\53\44\51\56\54\49\54\44\54\57\48\55\51\44\54\56\49\48\55\44\53\48\50\50\51\44\52\49\54\50\51\44\54\49\51\56\57\44\51\56\48\52\55\44\54\51\56\54\56\44\51\53\50\55\48\44\51\56\49\53\51\44\54\52\49\49\51\44\51\52\57\54\52\44\54\53\53\52\48\44\54\50\57\52\53\44\54\55\52\51\48\44\53\48\54\48\50\44\53\50\57\48\55\44\52\51\51\55\53\44\54\56\52\57\57\44\54\55\57\50\48\44\53\55\48\50\54\44\54\55\49\53\48\44\51\57\55\52\48\44\54\55\52\50\48\44\52\48\52\54\55\44\52\53\51\53\54\44\51\52\53\57\53\44\52\50\54\56\55\44\53\48\54\55\48\44\53\53\51\49\54\44\53\48\50\52\53\44\52\57\48\49\54\44\51\55\50\54\56\44\51\52\57\50\54\44\51\56\48\55\50\44\52\53\51\53\49\44\51\55\49\56\48\44\51\53\50\52\52\44\51\57\51\54\56\44\54\49\53\56\49\44\52\54\56\51\54\44\52\55\53\53\52\44\52\51\52\50\53\44\52\56\54\50\51\44\54\52\53\52\57\44\54\48\50\48\52\44\51\56\49\53\53\44\54\51\54\51\51\44\52\55\52\49\49\44\52\54\54\52\53\44\53\49\55\48\54\44\51\57\56\49\53\44\53\54\49\56\55\44\51\56\57\50\54\44\54\50\51\51\53\44\54\50\53\57\49\44\52\57\51\50\51\44\53\54\52\50\56\44\54\53\49\49\51\44\53\50\49\55\57\44\52\57\48\48\56\44\51\56\51\51\55\44\52\48\48\51\56\44\53\55\57\57\53\44\51\55\56\56\51\44\53\51\57\53\49\44\54\52\50\48\48\44\53\51\52\49\55\44\53\55\52\55\53\44\53\57\57\53\48\44\54\56\57\53\57\44\52\53\57\56\51\44\54\53\50\55\48\44\53\52\50\53\49\44\53\49\48\54\48\44\51\55\55\56\49\44\54\50\55\55\48\44\51\55\57\57\57\44\52\54\49\51\50\44\52\56\49\51\55\44\52\48\52\54\56\44\53\49\52\51\52\44\52\48\57\52\50\44\54\48\57\51\56\44\54\52\52\52\49\44\52\52\49\51\53\44\54\49\56\48\55\44\52\54\52\48\50\44\53\50\53\57\55\44\51\53\50\55\51\44\53\56\54\53\53\44\54\56\50\48\49\44\52\49\57\49\54\44\54\54\52\51\51\44\54\53\49\53\56\44\51\53\53\57\56\44\53\55\56\49\49\44\52\55\53\50\53\44\53\48\53\55\48\44\53\57\51\57\54\44\52\52\56\54\48\44\54\49\55\53\50\44\53\51\48\52\50\44\54\50\57\57\52\44\53\53\52\52\53\44\51\56\56\49\50\44\54\54\53\53\55\44\51\54\49\52\51\44\54\54\57\52\56\44\54\53\50\52\57\44\51\55\53\51\52\44\52\50\53\51\51\44\51\55\48\48\53\44\53\49\49\50\48\44\51\52\56\54\48\44\53\55\57\50\52\44\54\55\53\50\56\44\51\54\57\51\48\44\52\55\52\50\57\44\53\48\56\49\57\44\52\53\57\54\50\44\52\51\56\54\51\44\54\53\56\52\53\44\52\51\55\56\55\44\54\54\52\55\52\44\51\54\49\50\57\44\52\54\51\49\48\44\54\48\53\49\49\44\54\55\55\51\57\44\52\51\48\53\57\44\53\56\52\50\48\44\51\53\56\50\49\44\54\54\49\52\48\44\52\49\51\54\53\44\53\50\56\56\48\44\52\57\50\55\50\44\52\55\49\57\49\44\54\48\56\53\56\44\52\49\54\48\56\44\53\55\49\57\52\44\52\50\48\54\51\44\54\52\50\56\56\44\53\54\56\52\54\44\53\51\54\50\51\44\53\57\53\52\53\44\51\53\53\48\49\44\52\51\50\50\53\44\51\52\54\56\55\44\54\56\50\57\52\44\51\57\48\56\50\44\52\53\54\50\52\44\53\49\55\51\56\44\53\56\56\55\57\44\54\49\54\49\54\44\52\55\55\52\49\44\54\56\56\54\51\44\54\51\48\48\55\44\52\48\54\57\52\44\51\52\55\48\52\44\54\48\56\49\54\44\51\56\53\57\49\44\53\51\52\52\54\44\54\48\56\49\49\44\54\54\50\56\54\44\52\54\52\49\51\44\54\55\54\55\48\44\54\55\48\55\56\44\53\56\53\48\50\44\51\56\57\57\48\44\53\55\50\51\50\44\53\48\56\54\52\44\54\50\56\51\56\44\52\52\48\54\53\44\52\55\55\50\55\44\53\53\54\52\56\44\52\54\50\54\48\44\52\52\55\50\55\44\53\55\51\56\51\44\51\52\56\55\48\44\53\55\52\52\49\44\52\52\52\55\49\44\53\53\51\53\50\44\51\56\57\52\52\44\54\52\54\49\56\44\52\56\48\56\53\44\53\57\52\51\54\44\51\57\49\48\52\44\53\50\54\50\55\44\54\50\54\56\57\44\51\55\55\54\53\44\54\51\49\57\54\44\54\54\56\52\52\44\54\49\56\56\55\44\54\52\51\51\48\44\51\52\53\56\51\44\52\56\49\51\51\44\52\50\54\52\53\44\51\56\53\53\51\44\53\49\52\52\56\44\54\49\52\51\54\44\51\56\48\50\56\44\52\50\49\54\56\44\51\55\53\55\48\44\53\56\56\53\51\44\53\51\52\50\48\44\53\56\51\53\54\44\54\54\55\50\48\44\53\52\49\51\48\44\53\48\51\49\48\44\53\57\53\50\55\44\53\57\50\57\53\44\52\57\57\49\48\44\52\55\54\56\50\44\52\52\49\57\51\44\53\55\54\50\51\44\52\53\54\56\53\44\53\49\53\52\56\44\52\53\54\54\52\44\52\52\54\49\55\44\53\53\48\51\50\44\52\57\55\50\48\44\54\55\53\48\49\44\54\56\56\57\54\44\54\53\57\52\48\44\54\55\54\48\52\44\54\52\56\52\57\44\54\52\57\53\51\44\53\54\49\54\55\44\54\55\57\57\55\44\54\55\55\57\51\44\51\54\53\51\48\44\52\52\56\52\50\44\52\57\54\56\56\44\53\50\49\52\48\44\52\52\49\52\49\44\54\53\57\51\52\44\52\51\48\54\55\44\53\57\49\53\52\44\53\48\57\49\51\44\54\51\57\49\51\44\53\49\54\56\53\44\53\54\56\49\48\44\52\53\52\50\48\44\54\48\55\56\56\44\53\54\52\52\51\44\54\49\52\51\57\44\54\56\53\54\53\44\54\50\54\49\51\44\52\49\54\52\56\44\52\48\56\55\56\44\54\50\51\57\51\44\53\54\56\52\49\44\52\48\50\51\54\44\54\49\48\57\54\44\51\53\50\51\51\44\52\53\51\56\50\44\53\55\54\56\55\44\52\57\54\54\55\44\53\48\52\55\55\44\52\48\49\50\52\44\52\53\52\49\51\44\53\51\56\48\48\44\53\56\49\53\55\44\53\56\50\55\56\44\54\49\48\55\48\44\53\55\53\56\49\44\54\50\55\51\48\44\54\51\55\51\50\44\52\57\54\48\54\44\52\48\49\52\51\44\54\54\51\48\51\44\53\55\55\52\51\44\53\51\49\52\52\44\51\55\49\49\57\44\52\48\48\52\56\44\53\50\48\54\54\44\53\52\56\54\50\44\53\57\48\57\57\44\54\51\51\49\56\44\53\55\51\51\52\44\53\49\55\50\50\44\52\55\52\50\54\44\52\48\51\53\52\44\51\55\53\49\49\44\51\53\49\51\51\44\53\52\54\53\55\44\52\56\48\57\53\44\52\50\55\55\50\44\53\55\49\57\54\44\54\51\56\50\53\44\54\49\54\49\56\44\54\56\53\48\55\44\53\48\57\54\56\44\53\48\54\50\56\44\53\51\54\51\48\44\51\52\57\51\56\44\54\49\51\49\56\44\53\56\51\52\48\44\53\48\56\51\53\44\53\53\50\57\51\44\54\48\48\53\53\44\53\51\56\54\51\44\52\49\53\56\51\44\54\51\49\52\54\44\54\55\57\57\51\44\53\54\48\49\51\44\53\51\51\52\53\44\52\51\55\48\52\44\51\55\48\52\55\44\52\54\53\51\54\44\51\54\53\56\50\44\54\49\57\52\48\44\53\51\50\53\57\44\53\52\48\57\50\44\53\48\55\49\49\44\51\55\48\52\57\44\52\57\50\50\50\44\54\56\56\51\48\44\54\51\48\52\50\44\53\49\56\56\49\44\52\51\52\55\48\44\53\51\50\48\55\44\51\57\57\53\56\44\52\50\53\51\57\44\51\55\53\55\57\44\53\50\57\54\56\44\51\54\57\50\51\44\53\51\56\55\54\44\54\52\53\53\51\44\52\54\51\49\53\44\51\52\55\50\52\44\53\52\51\53\57\44\54\51\49\53\48\44\52\49\52\57\56\44\51\53\50\55\54\44\53\50\49\51\57\44\54\51\49\48\50\44\54\48\49\52\55\44\54\48\54\56\50\44\53\49\50\49\54\44\52\48\51\53\48\44\52\48\49\50\48\44\51\55\54\49\56\44\54\55\53\50\49\44\53\54\57\48\55\44\53\57\54\57\55\44\53\55\50\50\49\44\54\50\48\48\52\44\53\52\54\49\51\44\53\53\48\51\48\44\54\52\51\52\49\44\52\57\57\56\48\44\54\54\57\53\54\44\53\51\50\53\50\44\52\50\52\52\51\44\53\49\51\53\49\44\52\50\49\54\52\44\53\52\51\48\50\44\52\57\52\49\52\44\53\54\53\50\53\44\54\49\57\48\54\44\54\52\57\49\55\44\51\56\50\53\53\44\51\57\50\51\54\44\54\54\49\52\52\44\52\48\53\57\55\44\51\53\57\50\53\44\54\56\52\48\51\44\52\52\51\51\53\44\51\57\54\55\54\44\51\53\53\48\53\44\53\50\51\54\48\44\54\53\56\56\56\44\53\52\49\56\49\44\53\54\56\53\57\44\54\52\51\48\50\44\54\54\57\56\52\44\53\57\56\48\57\44\52\51\54\55\55\44\54\56\50\55\48\44\53\51\54\49\53\44\54\48\52\50\51\44\52\53\56\51\52\44\51\52\57\56\48\44\54\48\57\49\56\44\53\57\55\48\50\44\54\55\50\48\55\44\54\50\57\49\57\44\53\55\48\49\51\44\54\51\52\48\53\44\53\53\49\54\54\44\53\52\53\48\53\44\53\48\49\56\54\44\53\48\48\48\53\44\53\51\52\50\50\44\53\55\49\57\56\44\52\54\57\57\55\44\52\57\48\57\57\44\52\51\52\48\51\44\52\52\50\48\51\44\53\53\54\57\51\44\54\48\50\51\53\44\53\56\54\50\57\44\53\50\56\49\52\44\51\54\51\53\53\44\51\54\50\57\56\44\51\53\49\54\56\44\52\48\55\52\49\44\52\51\53\57\51\44\51\57\49\53\57\44\53\49\53\57\57\44\51\57\57\50\49\44\54\53\51\49\54\44\53\51\55\54\53\44\54\48\53\50\48\44\54\49\53\51\49\44\53\56\50\55\55\44\51\56\50\49\55\44\53\53\56\53\53\44\52\51\54\56\50\44\51\56\56\50\54\44\52\50\52\57\53\44\53\53\54\50\48\44\52\57\57\50\50\44\53\53\55\51\53\44\51\53\51\52\49\44\51\55\57\50\50\44\53\54\48\50\51\44\52\50\56\49\53\44\51\53\52\53\55\44\53\57\55\53\56\44\51\53\54\51\56\44\54\51\56\57\51\44\52\52\56\55\48\44\54\49\56\56\50\44\51\56\55\54\57\44\52\48\49\57\49\44\51\57\49\55\52\44\52\55\52\54\50\44\53\50\54\53\56\44\51\54\54\54\49\44\52\55\48\54\48\44\52\51\53\55\52\44\53\54\52\56\54\44\51\55\48\57\56\44\54\54\56\48\55\44\52\55\48\52\52\44\51\52\53\57\50\44\52\54\55\53\55\44\52\55\54\49\49\44\52\54\57\53\50\44\51\54\57\56\54\44\53\53\56\55\56\44\51\56\48\54\51\44\54\56\52\51\57\44\54\49\55\49\54\44\52\54\49\53\49\44\52\57\48\57\52\44\51\55\51\50\51\44\52\52\49\53\48\44\52\53\48\54\53\44\52\49\49\49\55\44\53\56\48\52\55\44\52\52\53\56\48\44\51\56\51\50\48\44\52\56\48\52\53\44\52\51\49\54\56\44\54\55\49\55\53\44\53\51\49\49\54\44\53\53\55\56\56\44\53\52\54\55\56\44\53\53\52\57\57\44\54\51\50\53\56\44\53\48\50\54\52\44\54\56\53\57\51\44\52\48\50\57\52\44\54\52\52\57\56\44\53\53\57\51\51\44\51\54\53\52\54\44\52\53\56\57\55\44\51\52\57\53\48\44\53\53\49\49\51\44\53\51\57\53\57\44\53\57\53\49\56\44\52\51\57\53\53\44\52\48\50\52\49\44\53\51\56\50\54\44\53\53\52\50\51\44\52\51\51\50\49\44\53\55\54\56\57\44\51\56\56\54\54\44\51\53\49\53\57\44\53\56\52\51\52\44\53\48\57\57\50\44\52\49\50\57\53\44\51\56\53\55\54\44\54\55\57\52\57\44\53\55\52\49\57\44\53\54\55\51\52\44\52\52\48\53\48\44\54\52\49\53\50\44\53\49\57\49\55\44\54\52\48\48\51\44\54\48\57\56\52\44\54\56\54\51\55\44\52\48\49\49\48\44\54\48\56\49\56\44\51\53\57\50\52\44\53\48\48\56\54\44\52\54\50\57\53\44\52\48\52\53\57\44\53\51\57\53\56\44\51\57\50\55\50\44\51\52\57\53\52\44\51\57\53\57\53\44\52\48\54\55\57\44\51\53\57\56\57\44\52\56\49\53\56\44\51\56\50\50\57\44\52\56\50\49\53\44\53\57\54\52\53\44\54\48\53\51\48\44\51\56\57\53\49\44\54\48\55\53\57\44\53\56\50\51\48\44\52\53\52\54\57\44\54\52\55\55\53\44\54\52\56\56\51\44\51\54\53\55\55\44\53\49\53\54\51\44\51\57\48\49\55\44\54\54\54\50\51\44\53\55\53\50\53\44\53\53\50\48\53\44\54\49\48\52\48\44\53\53\52\56\48\44\54\56\54\51\53\44\54\55\50\54\54\44\51\55\57\57\53\44\54\50\48\51\54\44\54\49\57\52\55\44\51\53\57\55\51\44\54\48\52\53\50\44\52\53\57\52\48\44\54\56\56\48\49\44\53\53\54\52\52\44\52\49\48\56\52\44\53\52\48\50\57\44\52\53\54\54\49\44\54\51\57\56\57\44\51\56\49\50\48\44\53\54\53\56\48\44\54\48\57\50\52\44\53\54\53\49\48\44\54\50\48\48\51\44\54\49\57\55\52\44\54\53\5
