/***********************************************************************************************************/
/*  Operaciones generales para la validación de información																					       */
/***********************************************************************************************************/

function alphaKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (arguments.length == 2 && arguments[1] == true) {
    convertToUpperCaseKeyCode(oEvent, keyCode);
  }
  if (isLetterKeyCode(keyCode)) {
    return true;
  } else {
    return false;
  }
}

function alphaSpaceKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (arguments.length == 2 && arguments[1] == true) {
    convertToUpperCaseKeyCode(oEvent, keyCode);
  }
  if (isLetterKeyCode(keyCode) || isSpaceKeyCode(keyCode)) {
    return true;
  } else {
    return false;
  }
}

function alphaNumericCodeFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (arguments.length == 2 && arguments[1] == true) {
    convertToUpperCaseKeyCode(oEvent, keyCode);
  }
  if (isLetterKeyCode(keyCode) || isNumericKeyCode(keyCode) || keyCode == 109) {
    return true;
  } else {
    oEvent.preventDefault();
    return false;
  }
}

function notSpaceKeyFilter(oEvent) {
    var keyCode = getKeyCode(oEvent);
    if (arguments.length == 2 && arguments[1] == true) {
        convertToUpperCaseKeyCode(oEvent, keyCode);
    }
    if (isLetterKeyCode(keyCode) || isNumericKeyCode(keyCode)) {
        return true;
    } else {
        return false;
    }
}

function alphaNumericKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (arguments.length == 2 && arguments[1] == true) {
    convertToUpperCaseKeyCode(oEvent, keyCode);
  }
  if (isLetterKeyCode(keyCode) || isNumericKeyCode(keyCode) || isSpecialKeyCode(keyCode)) {
    return true;
  } else {
    return false;
  }
}

function searchTextBoxKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);

  if (keyCode == 60 || keyCode == 62) {
    return false;
  } else if ((keyCode == 13) && (getEventSource(oEvent).value != '')) {
    sendPageCommand('loadData');
    return true;
  } else {
    return true;
  }
}

function eMailAddressKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);

  convertToLowerCaseKeyCode(oEvent, keyCode);
  if (isEnglishLetterKeyCode(keyCode) || isNumericKeyCode(keyCode) || isPeriodKeyCode(keyCode) ||
     (keyCode == 45) || (keyCode == 64) || (keyCode == 95) ) {
    return true;
  } else {
    return false;
  }
}

function urlKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);

  convertToLowerCaseKeyCode(oEvent, keyCode);

  if (isEnglishLetterKeyCode(keyCode) || isNumericKeyCode(keyCode) ||
      isPeriodKeyCode(keyCode) || keyCode == 47 || keyCode == 58 || keyCode == 95) {
    return true;
  } else {
    return false;
  }
}

function upperCaseKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  convertToUpperCaseKeyCode(oEvent, keyCode);
}

function notSpaceKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (arguments.length == 2 && arguments[1] == true) {
    convertToUpperCaseKeyCode(oEvent, keyCode);
  }
  if (isLetterKeyCode(keyCode) || isNumericKeyCode(keyCode) || isPeriodKeyCode(keyCode)) {
    return true;
  } else {
    return false;
  }
}

function phoneKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (isNumericKeyCode(keyCode) || keyCode == 45) {
    return true;
  } else {
    return false;
  }
}

function taxKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (arguments.length == 2 && arguments[1] == true) {
    convertToUpperCaseKeyCode(oEvent, keyCode);
  }
  if (isLetterKeyCode(keyCode) || isNumericKeyCode(keyCode)) {
    return true;
  } else {
    return false;
  }
}

function currencyKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (isNumericKeyCode(keyCode) || isPeriodKeyCode(keyCode) || keyCode == 36) {
    return true;
  } else {
    return false;
  }
}

function integerKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (isNumericKeyCode(keyCode)) {
    return true;
  } else {
    return false;
  }
}

function positiveKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (isNumericKeyCode(keyCode) || isPeriodKeyCode(keyCode)) {
    return true;
  } else {
    return false;
  }
}

function quantityKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (isNumericKeyCode(keyCode) || isPeriodKeyCode(keyCode) || keyCode == 45) {
    return true;
  } else {
    return false;
  }
}

function hourKeyFilter(oEvent) {
  var keyCode = getKeyCode(oEvent);
  if (isNumericKeyCode(keyCode) || keyCode == 58) {
    return true;
  } else {
    return false;
  }
}

function convertToUpperCase(oSource) {
  oSource.value = String(oSource.value).toUpperCase();

  return true;
}

function equateValues(controlAName, controlBName) {
  var oControlA = getElement(controlAName);
  var oControlB = getElement(controlBName);

  if (oControlA.value.length != 0) {
    oControlB.value = oControlA.value;
  } else if (oControlB.value.length != 0) {
    oControlA.value = oControlB.value;
  }
}

function convertToLowerCaseKeyCode(oEvent, keyCode) {
  if (isLowerCaseKeyCode(keyCode)) {
    return;
  }
  if (65 <= keyCode && keyCode <= 90) {
    keyCode = keyCode + 32;
  } else if (keyCode == 193) {
    keyCode = 225;
  } else if (keyCode == 201) {
    keyCode = 233;
  } else if (keyCode == 205) {
    keyCode = 237;
  } else if (keyCode == 209) {
    keyCode = 241;
  } else if (keyCode == 211) {
    keyCode = 243;
  } else if (keyCode == 218) {
    keyCode = 250;
  } else if (keyCode == 220) {
    keyCode = 252;
  }
  if (oEvent.which == undefined || oEvent.which == null) {
    oEvent.keyCode = keyCode;
  } else {
    // oEvent.which = keyCode; // Firefox bug or not yet resolved
  }
}

function convertToUpperCaseKeyCode(oEvent, keyCode) {
  if (!isLowerCaseKeyCode(keyCode)) {
    return;
  }
  if (97 <= keyCode && keyCode <= 122) {
    keyCode = keyCode - 32;
  } else if (keyCode == 225) {
    keyCode = 193;
  } else if (keyCode == 233) {
    keyCode = 201;
  } else if (keyCode == 237) {
    keyCode = 205;
  } else if (keyCode == 241) {
    keyCode = 209;
  } else if (keyCode == 243) {
    keyCode = 211;
  } else if (keyCode == 250) {
    keyCode = 218;
  } else if (keyCode == 252) {
    keyCode = 220;
  }
  if (oEvent.which == undefined || oEvent.which == null) {
    oEvent.keyCode = keyCode;
  } else {
    // oEvent.which = keyCode; // Firefox bug
  }
}

function getKeyCode(oEvent) {
  var theEvent = getEvent(oEvent);
  if (theEvent.which == undefined || theEvent.which == null) {
    return theEvent.keyCode;
  } else {
    return theEvent.which;
  }
}

function isLowerCaseKeyCode(keyCode) {
  return ( (97 <= keyCode && keyCode <= 122) ||
           (keyCode == 225) || (keyCode == 233) || (keyCode == 237) || (keyCode == 241) ||
           (keyCode == 243) || (keyCode == 250) || (keyCode == 252) );
}


function isEnglishLetterKeyCode(keyCode) {
  return ( (65 <= keyCode && keyCode <= 90) || (97 <= keyCode && keyCode <= 122) );
}

function isLetterKeyCode(keyCode) {
  return ( (65 <= keyCode && keyCode <= 90) || (97 <= keyCode && keyCode <= 122) ||
           (keyCode == 193) || (keyCode == 201) || (keyCode == 205) || (keyCode == 209) ||
           (keyCode == 211) || (keyCode == 218) || (keyCode == 220) ||
           (keyCode == 225) || (keyCode == 233) || (keyCode == 237) || (keyCode == 241) ||
           (keyCode == 243) || (keyCode == 250) || (keyCode == 252) );
}

function isNumericKeyCode(keyCode) {
  return (48 <= keyCode && keyCode <= 57);
}

function isPeriodKeyCode(keyCode) {
  return (keyCode == 46);
}

function isSpaceKeyCode(keyCode) {
  return (keyCode == 32);
}

function isSpecialKeyCode(keyCode) {
  return ( (32 <= keyCode && keyCode <= 47 && keyCode != 34 && keyCode != 39) ||
           (keyCode == 58) || (keyCode == 59) || (keyCode == 61) || (keyCode == 63) ||
           (keyCode == 64) || (keyCode == 92) || (keyCode == 95) || (keyCode == 124) ||
           (keyCode == 161) || (keyCode == 191) );
}

function isDate(oSource) {
  formatAsDate(oSource);
  var dateParts = String(oSource.value).split("/");

  if (dateParts.length != 3) {
    return false;
  }

  if (!(1 <= Number(dateParts[0]) && Number(dateParts[0]) <= 31)) {
    return false;
  }
  if (!Number(dateParts[2])) {
    return false;
  }
  if (dateParts[2].length != 2 && dateParts[2].length != 4) {
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

function isDatePeriod(oFromDateSource, oToDateSource) {
  formatAsDate(oFromDateSource);
  formatAsDate(oToDateSource);

  if (!isDate(oFromDateSource) || !isDate(oToDateSource)) {
    return false;
  }
  return isValidDatePeriod(oFromDateSource.value, oToDateSource.value);
}

function isHour(oHour) {
  var value = oHour.value;
  var regex = /[.]/g; // Regular expression

  value = value.replace(regex, ":");    //Cleans "."
  regex = /[ \t]/g;
  value = value.replace(regex, "");    //Cleans spaces or tabs

  oHour.value = value;

  var hoursParts = value.split(":");

  if (hoursParts.length != 2) {
    return false;
  }
  if (hoursParts[0].length == 0 || hoursParts[1].length != 2) {
    return false;
  }
  if (!isNumericValue(hoursParts[0]) || !isNumericValue(hoursParts[1])) {
    return false;
}
  if (!(0 <= Number(hoursParts[0]) && Number(hoursParts[0]) <= 23)) {
    return false;
  }
  if (!(0 <= Number(hoursParts[1]) && Number(hoursParts[1]) <= 59)) {
    return false;
  }
  return true;
}

function formatAsTime(time) {
  var hoursParts = time.split(":");

  var hourPart = "";
  var minutesPart = "";

  if (hoursParts[0].length == 1) {
    hourPart = "0" + hoursParts[0];
  } else {
    hourPart = hoursParts[0];
  }
  if (hoursParts[1].length == 1) {
    minutesPart = hoursParts[1] + "0";
  } else {
    minutesPart = hoursParts[1];
  }
  return hourPart + ":" + minutesPart;
}

function isValidDatePeriod(fromDate, toDate) {
  var months = new Array("ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic");
  var fromDateParts = fromDate.toLowerCase().split("/");
  var toDateParts = toDate.toLowerCase().split("/");

  if (fromDateParts[2] < toDateParts[2]) {
    return true;
  } else if (fromDateParts[2] > toDateParts[2]) {
    return false;
  }
  if (!isNumericValue(fromDateParts[1])) {
    for (var i = 0; i < months.length; i++) {
      if (fromDateParts[1] == months[i]) {
        fromDateParts[1] = i + 1;
        break;
      }
    } // for
  }
  if (!isNumericValue(toDateParts[1])) {
    for (var i = 0; i < months.length; i++) {
      if (toDateParts[1] == months[i]) {
        toDateParts[1] = i + 1;
        break;
      }
    } // for
  }
  if (fromDateParts[1] < toDateParts[1]) {
    return true;
  } else if (fromDateParts[1] > toDateParts[1]) {
    return false;
  }
  if (fromDateParts[0] < toDateParts[0]) {
    return true;
  } else if (fromDateParts[0] > toDateParts[0]) {
    return false;
  }
  return true;
}

function isEmailAddress(oSource) {
  var emailReg = "^[\\w-_\.]*[\\w-_\.]\@[\\w]\.+[\\w]+[\\w]$";
  var regex = new RegExp(emailReg);

  return regex.test(oSource.value);
}

function isEmpty(oSource) {
  if (oSource == null || oSource == undefined) {
  alert("No puedo validar el control debido a que no existe en la página.")
    return true;
  }
  if (oSource.name.substring(0, 3) == "txt") {
    if (oSource.value.length != 0) {
      oSource.value = oSource.value.replace(/^\s+/,'');
      oSource.value = oSource.value.replace(/\s+$/,'');
    }
  }
  if (oSource.name.substring(0, 3) != "grd") {
    return (oSource.value == '');
  } else {
    return isGridEmpty(oSource);
  }
}

function isUnique(oSource, objectTypeInfoName, attributeName, objectId) {
  if (oSource == null || oSource == undefined) {
    return true;
  }
  var attributeValue = oSource.value;
  return (alreadyExistsObjectWithUniqueAttribute(objectTypeInfoName, attributeName,
                                                 objectId, attributeValue) == false);
}

function isGridEmpty(oSource) {
  if (oSource == undefined || oSource == null) {
    return true;
  }
  var elements = getElements(oSource.name);
   if (elements == undefined || elements == null) {
    return true;
   }
  for (var i = 0; i < elements.length; i++) {
    if (elements[i].checked) {
      return false;
    }
  }
  return true;
}

function getGridSelectedItems(oSource) {
  var temp = "";
  if (oSource == undefined || oSource == null) {
    return "";
  }
  var elements = getElements(oSource.name);
   if (elements == undefined || elements == null) {
    return "";
   }
  for (var i = 0; i < elements.length; i++) {
    if (elements[i].checked) {
      if (temp == "") {
        temp = elements[i].value;
      } else {
        temp += "|" + elements[i].value;
      }
    }
  }
  return temp;
}

function isNumeric(oSource) {
  return isNumericValue(oSource.value);
}

function isNumericValue(value) {
  var re = /,/g; // Regular expression
  value = value.replace(re, "");    //Cleans ","

  if (value == '' || value == undefined) {
    return false;
  }
  if (!isNaN(Number(value))) {
    return true;
  }
  if (value.length > 0) {
    if (value.charAt(0) == "$") {
      value = value.substring(1, value.length - 1);
      return (!isNaN(Number(value)));
    }
  }
  return false;
}

function convertToNumber(value) {
  var re = /,/g; // Regular expression
  value = value.replace(re, "");    //Cleans ","

  re = /\$/g; // Regular expression
  value = value.replace(re, "");    //Cleans "$"

  return Number(value);
}

function isNonEmptyNumeric(oSource) {
  var value = oSource.value;

  if (value == '') {
    return false;
  }
  if (!isNaN(Number(value))) {
    return true;
  }
  if (value.length > 0) {
    if (value.charAt(0) == "$") {
      value = value.substring(1, value.length - 1);
      return (!isNaN(Number(value)));
    }
  }
  return false;
}

function isUrl(oSource) {
  var urlRegExp = /^(http:\/\/www.|https:\/\/www.|ftp:\/\/www.|www.|http:\/\/|https:\/\/){1}([\w]+)(.[\w]+){1,2}$/;
  var checkValue = oSource.value;

  if (checkValue.match(urlRegExp)) {
    return true;
  }
  return checkValue.match(urlRegExp);
}

function formatAsCurrency(theNumber) {
  theNumber = theNumber.toString().replace(/\$|\,/g,'');
  if (isNaN(theNumber)) {
    alert("El valor proporcionado no es numérico, por lo que no puede convertirse a moneda.");
    return "errorValue";
  }
  sign = (theNumber == (theNumber = Math.abs(theNumber)));
  theNumber = Math.floor((theNumber * 100) + 0.50000000001);
  cents = theNumber % 100;
  theNumber = Math.floor(theNumber / 100).toString();
  if (cents < 10) {
    cents = "0" + cents;
  }
  for (var i = 0; i < Math.floor((theNumber.length-(1+i))/3); i++) {
    theNumber = theNumber.substring(0, theNumber.length-(4*i+3)) + ',' +
                theNumber.substring(theNumber.length-(4*i+3));
  }
  return (((sign)?'':'-') + '$' + theNumber + '.' + cents);
}

function formatAsDate(oSource) {
  if (oSource.value == "") {
    return;
  }
  var temp = String(oSource.value).toLowerCase();
  var regex = /-/g;
  temp = temp.replace(regex, "/");
  regex = /[.]/g;
  temp = temp.replace(regex, "/");
  regex = /[ \t]/g;
  temp = temp.replace(regex, "");    //Cleans spaces or tabs
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

function formatAsNumber(theNumber) {
  theNumber = theNumber.toString().replace(/\$|\,/g,'');
  if (isNaN(theNumber)) {
    alert("El valor proporcionado no es numérico, por lo que no puede convertirse a moneda.");
    return "errorValue";
  }
  var decimalPlaces = 2;
  if (arguments[1] != null) {
    decimalPlaces = arguments[1];
  }
  sign = (theNumber == (theNumber = Math.abs(theNumber)));
  theNumber = Math.floor((theNumber * Math.pow(10, decimalPlaces)) + 0.50000000001);
  cents = theNumber % Math.pow(10, decimalPlaces);
  theNumber = Math.floor(theNumber / Math.pow(10, decimalPlaces)).toString();
  if (cents < 10) {
    cents = "0" + cents;
  }
  for (var i = 0; i < Math.floor((theNumber.length-(1+i))/3); i++) {
    theNumber = theNumber.substring(0, theNumber.length-(4*i+3)) + ',' +
                theNumber.substring(theNumber.length-(4*i+3));
  }
  return (((sign)?'':'-') + theNumber + '.' + cents);
}

function formatAsInteger(theNumber) {
  theNumber = theNumber.toString().replace(/\$|\,/g,'');
  if (isNaN(theNumber)) {
    alert("El valor proporcionado no es numérico, por lo que no puede convertirse a entero.");
    return "errorValue";
  }
  sign = (theNumber == (theNumber = Math.abs(theNumber)));
  theNumber = Math.floor((theNumber * 100) + 0.50000000001);
  theNumber = Math.floor(theNumber / 100).toString();
  for (var i = 0; i < Math.floor((theNumber.length-(1+i))/3); i++) {
    theNumber = theNumber.substring(0, theNumber.length-(4*i+3)) + ',' +
                theNumber.substring(theNumber.length-(4*i+3));
  }
  return (((sign)?'':'-') + theNumber);
}

function getComboSelectedOption(elementId) {
  var oCombo = getElement(elementId);
  if (oCombo.selectedIndex != -1) {
    return oCombo.options[oCombo.selectedIndex];
  } else {
    return null;
  }
}

function getComboOptionText(oSource) {
   return oSource.options(oSource.selectedIndex).text;
}

function formatAsTaxKey(oSource) {
  var temp = String(oSource.value).toUpperCase();

  if (!(temp.length == 12 || temp.length == 13)) {
    return;
  }
  if (temp.length == 12) {
    temp = temp.substr(0, 3) + "-" + temp.substr(3, 6) + "-" + temp.substr(9, 3);
  } else if (temp.length == 13) {
    temp = temp.substr(0, 4) + "-" + temp.substr(4, 6) + "-" + temp.substr(10, 3);
  }
  oSource.value = temp;
  return;
}

function isTaxKeyAltern(oSource) {
  var temp = oSource.value;
  var validation = "";

  if (temp.length == 0) {
    return true;
  }
  if (temp.length == 12 || temp.length == 13) {
    return true;
  }
  if (temp.length == 9 || temp.length == 10) {
    return true;
  }
}

function isTaxKey(oSource) {
  formatAsTaxKey(oSource);
  var temp = oSource.value;

  if (temp.length == 0) {
    return true;
  }

  if (!(temp.length == 14 || temp.length == 15)) {
    return false;
  }
  var regex;
  if (temp.length == 14) {
    regex = /[A-Z]{3}-\d{6}-.../;
    if (temp.match(regex) == null) {
      return false;
    } else {
      return true;
    }
  }
  if (temp.length == 15) {
    regex = /[A-Z]{4}-\d{6}-.../;
    if (temp.match(regex) == null) {
      return false;
    } else {
      return true;
    }
  }
}

function setCurrentDate(oSource) {
  if (oSource.value != "") {
    return true;
  }
  var today = new Date();
  var temp = today.getDate() + "/";
  temp += (today.getMonth() + 1) + "/";
  temp += today.getYear();

  oSource.value = temp;
  formatAsDate(oSource);

  return true;
}
