function log(){
  console.log(arguments);
}

var client = mqtt.connect("ws://test.mosquitto.org:8080");
client.subscribe("light-123");

client.on("message", function(topic, payload){
  log(topic, payload.toString());
  var s = document.getElementById("switch");
  if (topic === "light-123"){
    if ( payload.toString() == "on"){
      s.checked = true;
      document.title = "on";
    } else if (payload.toString() =="off"){
      s.checked = false;
      document.title = "off"
    }
  }
});

window.toggle = function(s){
  var value = s.checked;
  var status = value ? "on" : "off";
  client.publish("light-123", status, {retain: true});
  document.title = status;
}
