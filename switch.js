function toggle(s){
  var value = s.checked;
  window.location = "/?switch=" + (value ? "on" : "off");
}
