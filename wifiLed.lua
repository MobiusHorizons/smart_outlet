--dofile("check_for_wifi.lua")
print(wifi.sta.getip())
led1 = 1;
led_state = false;
gpio.mode(led1, gpio.OUTPUT)
srv=net.createServer(net.TCP)

style =file.open("style.css", 'r');
script=file.open("switch.js", 'r');

srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        if(_GET.switch == "on") then
          led_state = true;
        elseif(_GET.switch == "off") then
          led_state = false;
        end

        buf = buf.."<html><head>";
        buf = buf.."<style>" .. style.read() .. "</style>";
        buf = buf.."<script>" .. script.read() .."</script>";
        buf = buf.."</head><body>";
        buf = buf.."<label class=\"button\"> ";
        buf = buf.."<input type=\"checkbox\" "
        if (led_state) then
          buf = buf.."checked ";
        end
        buf = buf.."onclick=\"toggle(this)\" />"
        buf = buf.."<span></span><span></span></label>"
--        buf = buf.."<a href=\"?ON=true\"><button ".. disabled_on ..">ON</button></a>&nbsp;<a href=\"?ON=false\"><button" .. disabled_off .. ">OFF</button></a></p>";
        local _on,_off = "",""
        gpio.write(led1, led_state);
        client:send(buf);
        client:close();
        -- rewind files so we can go again.
        style.seek("set", 0);
        script.seek("set", 0);

        collectgarbage();
    end)
end)

tmr.alarm(6, 10000, 1, function() tmr.wdclr() end)
