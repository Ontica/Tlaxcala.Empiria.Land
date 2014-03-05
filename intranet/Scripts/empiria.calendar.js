var oCurrentCalendarDataSource = null;    

function on_calendar_date_selected(value) {
  if (oCurrentCalendarDataSource != null) {
    oCurrentCalendarDataSource.value = value;
    document.all.ifraCalendar.style.visibility = "hidden";
  }
  oCurrentCalendarDataSource = null;
}

function on_calendar_lost_focus() {
  if (document.activeElement != document.all.ifraCalendar) {
    document.all.ifraCalendar.style.visibility = "hidden";  
  }
}

function on_calendar_resize(x, y) {        
  document.all.ifraCalendar.width = x;
  document.all.ifraCalendar.height = y;        
}

function hideCalendar() {
//  var oCalendar = document.all.ifraCalendar;
//  
//	if (oCalendar.style.visibility == "visible") {
//    //oCalendar.style.visibility = "hidden";   
//  }
  
  if (document.activeElement != document.all.ifraCalendar) {
    getElement("ifraCalendar").style.visibility = "hidden";  
  } 
}

function showCalendar(oDataSource, oImageSource) {
  if (oDataSource.disabled) {
    alert("Este control está deshabilitado.")
    return;
  }
  var oCalendar = document.all.ifraCalendar;
  x = event.clientX;
  y = event.clientY;

  var parentX = oCalendar.contentWindow.parent.document.body.clientWidth;
  var parentY = oCalendar.contentWindow.parent.document.body.clientHeight;

  var calendarWidth = oCalendar.contentWindow.document.body.clientWidth;
  var calendarHeight = oCalendar.contentWindow.document.body.clientHeight;
  
  if ((x + calendarWidth) >= parentX) {
    x = x - calendarWidth;
    y = y + oImageSource.height + 1;    
    if (x < 0) {
      x = 0;
    }
  }
  if ((y + calendarHeight) >= parentY) {
    x = x - calendarWidth;    
    y = y - calendarHeight - 1;
 
    if (y < 0) {
      y = 0;
    }
  }
  oCurrentCalendarDataSource = oDataSource;        
	if (oCalendar.style.visibility == "visible") {
    oCalendar.style.visibility = "hidden";
	} else {
    oCalendar.contentWindow.moveTo(x, y);
    if (cal_isDate(oDataSource)) {
      oCalendar.contentWindow.execScript("setDate('" + oDataSource.value + "')");
    } else {
      oCalendar.contentWindow.execScript("setDate('')");
    }
    oCalendar.style.zIndex = 999;
    oCalendar.style.visibility = "visible";
    oCalendar.focus();
	}
	return false;
}

function cal_isDate(oSource) {
  cal_formatAsDate(oSource);
  var dateParts = String(oSource.value).split("/");

  if (dateParts.length != 3) {
    return false;
  }
  
  if (!(1 <= Number(dateParts[0]) && Number(dateParts[0]) <= 31)) {
    return false;
  }
  switch (dateParts[1].toLowerCase()) {
    case "feb":
      if (dateParts[0] > 29) {
        return false;
      }
      if (dateParts[0] == 29) { // check leap year
        if ((dateParts[2] % 4) != 0) {
          return false;
        } else if (((dateParts[2] % 100) == 0) && ((dateParts[2] % 400) != 0)) {
          return false;
        }
      }
      break;
    case "abr": case "jun": case "sep": case "nov":
      if (dateParts[0] == 31) {
        return false;
      }
      break;
    case "ene": case "mar": case "may": case "jul": case "ago": case "oct": case "dic":
      break;
    default:
      return false;
  }
  return true;
}

function cal_formatAsDate(oSource) {
  if (oSource.value == "") {
    return;
  }  
  var temp = String(oSource.value).toLowerCase();
	var regex = /-/g;
	temp = temp.replace(regex, "/");
	regex = /[.]/g;
	temp = temp.replace(regex, "/");
  var dateParts = temp.split("/");
  
  if (dateParts.length != 3) {
    return;
  }
  if (!isNumericValue(dateParts[0]) || !isNumericValue(dateParts[2])) {
    return;
  }
  if (!(1 <= Number(dateParts[0]) && Number(dateParts[0]) <= 31)) {
    return;
  }
  if (Number(dateParts[0]) < 10) {
    dateParts[0] = "0" + Number(dateParts[0]); 
  }  
  if (Number(dateParts[2]) < 100) {
    var today = new Date();
    var year = Number(today.getFullYear().toString().substr(2, 2));
    if (Number(dateParts[2]) <= (year + 1)) {
      dateParts[2] = Number(dateParts[2]) + 2000;
    } else {
      dateParts[2] = Number(dateParts[2]) + 1900;
    }
  }
  if (isNumericValue(dateParts[1])) {
    if (!(1 <= Number(dateParts[1]) && Number(dateParts[1]) <= 12)) {
      return;
    }
    var months = new Array("Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic");
    dateParts[1] = months[Number(dateParts[1]) - 1];
  }
  oSource.value = dateParts[0] + "/" + dateParts[1] + "/" + dateParts[2];
  return;
}