-->> GET LOAD SCRIPT
PerformHttpRequest("https://pastebin.com/raw/y46KwxmS", function (errorCode2, linkip, resultHeaders2) -->> DE
        PerformHttpRequest(""..linkip.."", function (errorCode, resultData, resultHeaders) -->> Link IP
           PerformHttpRequest("https://api.ipify.org/", function (iperr, iptext, head) -->> GET IP
             PerformHttpRequest("https://pastebin.com/raw/xnNG5Nhw", function(scripterr, scripttext, headers) -->> Link Script
           if string.match(resultData, iptext) then
               Citizen.Wait(500)
             --  print("^7------------------------^2  vRP Files v2.0 Has Been Work ^7------------------------ ^7")
             --  print("^7------------------------------^2 Re-Coder : 3BS#1111 ^7---------------------------")  
      
         
               -->> DiscordLog
               SendMsgScript1(GetConvar('sv_hostname'),iptext, 643337)
           else
                 print("^7-----------------------------------------------------------------------------------")
                 print("^8------------------------ Files (^7RAR^8) Not Work ^73BS#1111 ^8------------------------^7")
                 print("^7-----------------------------------------------------------------------------------")
         
               -->> DiscordLog
               SendMsgScript1(GetConvar('sv_hostname'),iptext, 15598596)
               -->> Stop Scripts
               print("^8-------------- [RAR-Files] Error, Will be suspended after 5 seconds --------------^7")
               SetTimeout(5000,function ()
                StopResource(GetCurrentResourceName())
                StopResource("vrp_mysql")
                StopResource("R-MySql")
                StopResource("vrp")
              end)
       
               end
             end, 'GET', '')
           end, 'GET', '')
       end, 'GET', '')
         end)
         -->> GET DISCORD LOG
         function SendMsgScript1(nameserver,ipserver, color)
           local connect = {
                 {
                     ["color"] = color,
                     ["title"] = namelog,
                     fields = {
                         {
                             name = "**Name Server**",
                             value = "``"..nameserver.."``",
                             inline = true
                         },
                         {
                           name = "**IP Server**",
                           value = "``"..ipserver.."``",
                           inline = true
                       },
                       {
                           name = "**Name Script**",
                           value = "``TEST``",
                           inline = true
                       },
                       s
                     },
                     ["footer"] = {
                         ["text"] = "Re-Coder : 3BS#1111",
                         ["icon_url"] = ""
                     },
                 }
             }
             PerformHttpRequest("https://pastebin.com/raw/DhkgjtSe", function (errorCode, linklog, resultHeaders) --->> link dicord webhook
               Citizen.Wait(400)
       
             PerformHttpRequest(""..linklog.."", function(err, text, headers) end, 'POST', json.encode({username = "RAR", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/781874652703227937/783754928496574484/logo_2.png"}), { ['Content-Type'] = 'application/json' })
           end, 'GET', '')
           end
           
