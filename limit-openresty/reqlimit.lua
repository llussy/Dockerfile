local limit_req = require "resty.limit.req"
local rate = 3   --指标每秒3次/s
local burst = 10  --漏桶容量10个
local error_status = 429   --触发异常状态码
local nodelay = false     --漏桶延迟漏记是否触发
--截取x_forwarded_for 首IP作为IP指标
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
--漏桶算法(rate+burst)=超过及429
local lim, err = limit_req.new("limit_req_store", rate, burst)
if not lim then
    ngx.log(ngx.ERR, "No Lua-module limit req: ", err)
    ngx.exit(error_status)                                    
end
local key = getip()
local delay, err = lim:incoming(key, true)
if not delay and err == "rejected" then
    ngx.exit(error_status)
end
if delay > 0 then
    if nodelay then
        -- 突发情况处理逻辑
    else
        ngx.sleep(delay)
    end
end