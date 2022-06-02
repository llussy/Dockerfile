function getip( )                                                                                                                                                                                                                                                               
local myIP = ngx.req.get_headers()["x_forwarded_for"]                                                                                                                                                                                                                           
if myIP == nil then                                                                                                                                                                                                                                                             
   local myIP = ngx.var.binary_remote_addr                                                                                                                                                                                                                                            
end                                                                                                                                                                                                                                                                             
if myIP ~= nil and string.len(myIP) >15  then                                                                                                                                                                                                                                   
   local pos  = string.find(myIP, ",", 1)                                                                                                                                                                                                                                       
   local myIP = string.sub(myIP,1,pos-1)                                                                                                                                                                                                                                              
end                                                                                                                                                                                                                                                                             
   return myIP                                                                                                                                                                                                                                                                  
end
--正常逻辑通过,通过X-FOR-IP过滤IP,访问次数60秒内 > 30次 = 429（60s CD）
--访问次数60秒内 > 99次 = 429（120s CD）
local ip = getip()
local limit = ngx.shared.limit_req
local req,_=limit:get(ip)
 if req then
   if req == "deny" then
     ngx.exit(429)
   elseif req > 99 then
     limit:set(ip,"deny",120)
     ngx.exit(429)
   elseif req > 30 then
     limit:incr(ip,1)
     ngx.exit(429)
   else
     limit:incr(ip,1)
   end
 else
   limit:set(ip,1,60)
end