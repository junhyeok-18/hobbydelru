//엔터키
function enterkey(obj) {
    if (window.event.keyCode == 13) {
    	obj();
    }
}

//숫자만 입력
function checkNumber(event) {
  if(event.key >= 0 && event.key <= 9) {
    return true;
  }
  
  return false;
}