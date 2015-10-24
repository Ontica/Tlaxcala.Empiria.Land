/* Empiria ***************************************************************************************************
*																																																						 *
*	 Solution  : Empiria Web																			System   : Javascript Core Library					 *
*	 File      : /clock.js																				Pattern  : JavaScript Methods Library				 *
*  Version   : 2.0                                              License  : Please read license.txt file      *
*																																																						 *
*  Summary   : Displays the client system date-time in an html item.                                         *
*																																																						 *
********************************** Copyright(c) 1994-2015. La Vía Óntica SC, Ontica LLC and contributors.  **/

// region Public methods

function setClock(elementId, displayClock, useSpanish, useMilitar) {
	if (displayClock) {
		displayDate(elementId, useSpanish, useMilitar);
	} else {
		setInnerText(getElement(elementId), "Agenda");
	}
}

// endregion Public methods

// region Private methods

function displayDate(elementId, useSpanish, useMilitar) {
  var aMonthsSpanish = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto",
																 "Septiembre", "Octubre", "Noviembre", "Diciembre");
  var aMonthsEnglish = new Array("January", "February", "March", "April", "May", "June", "July", "August",
																 "September", "October", "November", "December");
  var aDaysSpanish   = new Array("Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado");
  var aDaysEnglish   = new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");
  var today          = new Date();
	var dateString		 = "";
	
  if (useSpanish) {
    dateString = aDaysSpanish[today.getDay()] + " " + today.getDate() + (today.getDate() == 1 ? "º" : "") + " de " + aMonthsSpanish[today.getMonth()] + " » " + getTime(useMilitar);
  } else {
    dateString = aDaysEnglish[today.getDay()] + ", " + aMonthsEnglish[today.getMonth()] + " " + today.getDate() + (today.getDate() == 1 ? "st" : "") + " » " + getTime(useMilitar);
  }
  setInnerText(getElement(elementId), dateString);
  setTimeout("displayDate('" + elementId + "', " + useSpanish + ", " + useMilitar + ");", 999);
}

function getTime(useMilitar) {
  var hours, minutes, ap;
  var intHours, intMinutes;
  var today;
  today      = new Date();
  intHours   = today.getHours();
  intMinutes = today.getMinutes();

  if (!useMilitar) {
      if (intHours == 0) {
       hours = "12";
       ap = "a.m.";
    } else if (intHours < 12) {
       hours = intHours;
       ap = "a.m.";
    } else if (intHours == 12) {
       hours = "12";
       ap = "p.m.";
    } else {
       intHours = intHours - 12;
       hours = intHours;
       ap = "p.m.";
    }
    minutes = intMinutes;
  } else {
     hours = intHours;
     minutes = intMinutes;
     ap = "hrs"; //"hrs"
   }

  if (intHours < 10 && intHours != 0) {
    hours = "0" + hours;
  }

  if (intMinutes < 10) {
    minutes = "0" + minutes;
  }
  return (hours + ":" + minutes + ' ' + ap);
}

// endregion Private methods
