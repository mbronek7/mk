print("=> Starting "..node.heap());
wifi.setmode(wifi.STATION)
wifi.sta.config("Zofian","molmolmol")
tmr.alarm(0, 1000, tmr.ALARM_AUTO, function() 
    ip = wifi.sta.getip()
    if ip then
        print(wifi.sta.getip())
        tmr.unregister(0) 

        tmr.alarm(1, 5000, tmr.ALARM_AUTO, function()
            http.post('http://httpbin.org/post',
                'Content-Type: application/json\r\n',
                '{"hello":"world"}',
                function(code, data)
                    if (code < 0) then
                        print("HTTP request failed")
                    else
                        print(code, data)
                    end
                    print(node.heap())
                end
            )
        end)
    else
        print("=> Connecting..." .. node.heap())
    end
end)
