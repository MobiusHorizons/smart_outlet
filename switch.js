client = new Paho.MQTT.Client("test.mosquitto.org", 8080, "clientId");
client.connect({onSuccess:onConnect});
// called when the client connects
function onConnect() {
  // Once a connection has been made, make a subscription and send a message.
  console.log("onConnect");
  client.subscribe("/light-123");
}

// called when a message arrives
function onMessageArrived(message) {
  console.log("onMessageArrived:"+message.payloadString);
  var s = document.getElementById("switch");
  if ( message.payloadString == "on"){
    s.checked = true;
  } else if (message.payloadString =="off"){
    s.checked = false;
  }
}

function toggle(s){
  var value = s.checked;
  message = new Paho.MQTT.Message(value ? "on" :"off");
  message.destinationName = "/light-123
  client.send(message); 
}
