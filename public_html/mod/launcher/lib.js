
function show_average_loadtime() {
  document.getElementById('show_load').style.visibility = "visible";
  document.body.style.cursor = 'wait';
  document.getElementById('submit').disabled = "true";

  return true;
}


function mask_unmask(element) {
  element.type = (element.type == 'password') ? 'text' : 'password';
}
