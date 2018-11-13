print("=> Starting "..node.heap());

wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="Zofian"
station_cfg.pwd="molmolmol"
station_cfg.save=false
wifi.sta.config(station_cfg)

local tmr_connection = tmr.create()
local tmr_task = tmr.create()
tmr_connection:register(1000, tmr.ALARM_AUTO, function (t) 
  ip = wifi.sta.getip()
  if ip then
    print(wifi.sta.getip())
    t:unregister() 
    tmr_task:register(1000, tmr.ALARM_AUTO, function (t) 
      -- print(adc.read(0))
      local addr = 'http://192.168.0.37:3344/messages'
      print(addr)
      http.post(addr, nil,
               '{"adc":"' .. adc.read(0) .. '"}',
               function(code, data)
                 if (code < 0) then
                   print("HTTP request failed")
                 else
                   print(code, data)
                 end
               end)
    end)
    tmr_task:start()
  end
end)
tmr_connection:start()
