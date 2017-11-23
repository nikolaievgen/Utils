"use strict"

var hello = "Hello World";
var elem_internal = document.createElement("p");
elem_internal.innerHTML = hello;

info.appendChild(elem_internal);

var xrh = new XMLHttpRequest();
xrh.open("GET", 'info.txt', true);
xrh.send();
xrh.onreadystatechange = function(){
  if(xrh.readyState != 4) {
    return;
  }

  var elem = document.createElement("p");

  if(xrh.status != 200) {
    elem.innerHTML = "XMLHttpRequest Hello World!";
    document.getElementById("info_status").innerHTML = "Loading Error";
  } else {
    elem.innerHTML = xrh.responseText; 
    document.getElementById("info_status").innerHTML = "Loaded OK";
  }

  document.body.appendChild(elem);
}
document.getElementById("info_status").innerHTML = "Loading";
