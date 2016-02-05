local topic = "";


function message(client, topic, message)
  print(topic .. ": " .. message);
end

function connected(client)
  client:publish(topic, node.chipid() .. " connected");
  client:lwt(topic, node.chipid() .. " disconnected");
  client:subscribe(topic, 0, message);
end

function connect(t, host, port, secure)
  topic = t;
  m = mqtt.Client(node.chipid(), 120);
  m:connect(host, port, secure, connected);
end

