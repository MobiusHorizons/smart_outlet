-- Checks for Wifi, and otherwise turns on wifi smart mode.
if (got_wifi == nil) then
  got_wifi = function()
    local ip = wifi.sta.getip()
    print("got wifi, ip ", ip)
  end
end

if (wifi.sta.getip() == nil) then
  wifi.setmode(wifi.STATION)
  wifi.startsmart(0, got_wifi)
end
