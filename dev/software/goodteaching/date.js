/* * * * * * * * * * * * * * * * * * * * * * * *
 * WEBSITE_NAME
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Javascript - Date validation 
 *
 * $Id: date.js 485 2007-07-29 19:59:18Z craig $
 * 
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

// extract front part of string prior to searchString
function getFront(mainStr,searchStr){
  foundOffset = mainStr.indexOf(searchStr)
  if (foundOffset == -1) {
    return null
  }
  return mainStr.substring(0,foundOffset)
}

// extract back end of string after searchString
function getEnd(mainStr,searchStr) {
  foundOffset = mainStr.indexOf(searchStr)
  if (foundOffset == -1) {
    return null
  }
  return mainStr.substring(foundOffset+searchStr.length,mainStr.length)
}

// insert insertString immediately before searchString
function insertString(mainStr,searchStr,insertStr) {
  var front = getFront(mainStr,searchStr)
  var end = getEnd(mainStr,searchStr)
  if (front != null && end != null) {
    return front + insertStr + searchStr + end
  }
  return null
}

// remove deleteString
function deleteString(mainStr,deleteStr) {
  return replaceString(mainStr,deleteStr,"")
}

// replace searchString with replaceString
function replaceString(mainStr,searchStr,replaceStr) {
  var front = getFront(mainStr,searchStr)
  var end = getEnd(mainStr,searchStr)
  if (front != null && end != null) {
    return front + replaceStr + end
  }
  return null
}

// date field validation (called by other validation functions that specify minYear/maxYear)
function isDate(gField, validateTime) {
  var dd, mm;
  var inputStr = gField.value;
  var timeStr = "";
  if (validateTime){
    var timePos = inputStr.lastIndexOf(" ");
    if (timePos > 0){
      timeStr = inputStr.substr(timePos+1);
      inputStr = inputStr.substring(0, timePos);
    }
  }

  var months = new Array(12)
  months["jan"] = 1; months["feb"] = 2; months["mar"] = 3; months["apr"] = 4; months["may"] = 5; months["jun"] = 6;
  months["jul"] = 7; months["aug"] = 8; months["sep"] = 9; months["oct"] = 10; months["nov"] = 11; months["dec"] = 12;
  var dispMonths = new Array("", "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");

  var DDMMYYYY = 1;
  var MMDDYYYY = 2;
  var timezones = new Array(41);
  timezones["UTC-1200"] = MMDDYYYY;
  timezones["UTC-1100"] = MMDDYYYY;
  timezones["UTC-1000"] = MMDDYYYY;
  timezones["UTC-0900"] = MMDDYYYY;
  timezones["UTC-0800"] = MMDDYYYY;
  timezones["PDT"]      = MMDDYYYY;
  timezones["PST"]      = MMDDYYYY;
  timezones["MDT"]      = MMDDYYYY;
  timezones["MST"]      = MMDDYYYY;
  timezones["CDT"]      = MMDDYYYY;
  timezones["CST"]      = MMDDYYYY;
  timezones["EDT"]      = MMDDYYYY;
  timezones["EST"]      = MMDDYYYY;
  timezones["UTC-0400"] = MMDDYYYY;
  timezones["UTC-0300"] = MMDDYYYY;
  timezones["UTC-0330"] = MMDDYYYY;
  timezones["UTC-0200"] = DDMMYYYY;
  timezones["UTC-0230"] = MMDDYYYY;
  timezones["UTC-0100"] = DDMMYYYY;
  timezones["UTC"]      = DDMMYYYY;
  timezones["UTC+0100"] = DDMMYYYY;
  timezones["UTC+0200"] = DDMMYYYY;
  timezones["UTC+0300"] = DDMMYYYY;
  timezones["UTC+0400"] = DDMMYYYY;
  timezones["UTC+0430"] = DDMMYYYY;
  timezones["UTC+0500"] = DDMMYYYY;
  timezones["UTC+0530"] = DDMMYYYY;
  timezones["UTC+0545"] = DDMMYYYY;
  timezones["UTC+0600"] = DDMMYYYY;
  timezones["UTC+0630"] = DDMMYYYY;
  timezones["UTC+0645"] = DDMMYYYY;
  timezones["UTC+0700"] = DDMMYYYY;
  timezones["UTC+0730"] = DDMMYYYY;
  timezones["UTC+0800"] = DDMMYYYY;
  timezones["UTC+0900"] = DDMMYYYY;
  timezones["UTC+0930"] = DDMMYYYY;
  timezones["UTC+1000"] = DDMMYYYY;
  timezones["UTC+1030"] = DDMMYYYY;
  timezones["UTC+1200"] = DDMMYYYY;
  timezones["UTC+1300"] = DDMMYYYY;
  timezones["UTC+1400"] = DDMMYYYY;


  var timezoneDate = new Date(Date.UTC(2002,2,12,12,0,0));
  var timezone = timezoneDate.toString();
  var timezoneEnd = timezone.indexOf(" ", 20);
  timezone = timezone.substring(20, timezoneEnd);
  var dateFormat = timezones[timezone];

  if (isNaN(dateFormat)){
    dateFormat = DDMMYYYY;
  }

  if(inputStr == "" || inputStr == " ") {
    return true;
  }

  // Check for "today", and replace with today's date
  if (inputStr.substring(0,3) == "tod") {
    var today = new Date() ;
    gField.focus() ;
    gField.select() ;
    gField.value = (today.getDate()<10?"0":"") + today.getDate() + "-" + dispMonths[today.getMonth()+1] + "-" + today.getYear();
    if (validateTime){
      var todayHours = today.getHours();
      var todayMins  = today.getMinutes();

      gField.value += " " + (todayHours<10?"0":"") + todayHours + ":" + (todayMins<10?"0":"") + todayMins;
    }
    return true ;
  }

  // convert space delimiters to slashes
  while (inputStr.indexOf(" ") != -1) {
    inputStr = replaceString(inputStr," ","/")
  }
  // convert hyphen delimiters to slashes
  while (inputStr.indexOf("-") != -1) {
    inputStr = replaceString(inputStr,"-","/")
  }
  // convert period delimiters to slashes
  while (inputStr.indexOf(".") != -1) {
    inputStr = replaceString(inputStr,".","/")
  }
  var delim1 = inputStr.indexOf("/")
  var delim2 = inputStr.lastIndexOf("/")
  if (delim1 != -1 && delim1 == delim2) {
    // there is only one delimiter in the string
    alert("The date entry is not in an acceptable format.\n\nYou can enter dates in the following formats: " + ((dateFormat == DDMMYYYY)?"ddmm":"mmdd") + "yyyy, dd-mon-yyyy or " + ((dateFormat == DDMMYYYY)?"dd-mm":"mm-dd") + "-yyyy.  (If the month or date data is not available, enter \'01\' in the appropriate location.)")
    gField.focus()
    gField.select()
    gField.value = "";
    return false
  }
  if (delim1 != -1) {
    // there are delimiters; extract component values
    if (dateFormat == MMDDYYYY){
      mm = parseInt(inputStr.substring(0,delim1),10)
      dd = parseInt(inputStr.substring(delim1 + 1,delim2), 10)
      if (isNaN(dd)){
        dd = parseInt(inputStr.substring(0,delim1),10)
        mm = inputStr.substring(delim1 + 1,delim2)
      }
    }else{
      dd = parseInt(inputStr.substring(0,delim1),10)
      mm = inputStr.substring(delim1 + 1,delim2)
    }
    var yyyy = parseInt(inputStr.substring(delim2 + 1, inputStr.length),10)
  } else {
    // there are no delimiters; extract component values
    if (dateFormat == MMDDYYYY){
      mm = parseInt(inputStr.substring(0,2),10)
      dd = parseInt(inputStr.substring(2,4),10)
    }else{
      dd = parseInt(inputStr.substring(0,2),10)
      mm = parseInt(inputStr.substring(2,4),10)
    }
    var yyyy = parseInt(inputStr.substring(4,inputStr.length),10)
  }

  if (isNaN(dd) || isNaN(yyyy)) {
    // there is a non-numeric character in one of the component values
    alert("The date entry is not in an acceptable format.\n\nYou can enter dates in the following formats: " + ((dateFormat == DDMMYYYY)?"ddmm":"mmdd") + "yyyy, dd-mon-yyyy or " + ((dateFormat == DDMMYYYY)?"dd-mm":"mm-dd") + "-yyyy.  (If the month or date data is not available, enter \'01\' in the appropriate location.)")
    gField.focus()
    gField.select()
    gField.value = "";
    return false
  }
  if( isNaN(mm) ) {
    var mon = new String(mm);
    mon = mon.toLowerCase();
    mm = months[mon];
    if (!mm) {
      alert("The date entry is not in an acceptable format.\n\nYou can enter dates in the following formats: " + ((dateFormat == DDMMYYYY)?"ddmm":"mmdd") + "yyyy, dd-mon-yyyy or " + ((dateFormat == DDMMYYYY)?"dd-mm":"mm-dd") + "-yyyy.  (If the month or date data is not available, enter \'01\' in the appropriate location.)")
      gField.focus()
      gField.select()
      gField.value = "";
      return false;
    }
  }

  if (mm < 1 || mm > 12) {
    // month value is not 1 thru 12
    alert("Months must be entered between the range of 01 (January) and 12 (December).")
    gField.focus()
    gField.select()
    gField.value = "";
    return false
  }
  if (dd < 1 || dd > 31) {
    // date value is not 1 thru 31
    alert("Days must be entered between the range of 01 and a maximum of 31 (depending on the month and year).")
    gField.focus()
    gField.select()
    gField.value = "";
    return false
  }

  // validate year, allowing for checks between year ranges
  // passed as parameters from other validation functions
  if (yyyy < 100) {
    // entered value is two digits, which we allow for 1930-2029
    if (yyyy >= 30) {
      yyyy += 1900
    } else {
      yyyy += 2000
    }
  }

  var today = new Date()

  if (!checkMonthLength(mm,dd)) {
    gField.focus()
    gField.select()
    gField.value = "";
    return false
  }
  if (mm == 2) {
    if (!checkLeapMonth(mm,dd,yyyy)) {
      gField.focus()
      gField.select()
      gField.value = "";
      return false
    }
  }

  if (validateTime){
    if (timeStr == ""){
      timeStr = ' 00:00';
    }else{
      var time = timeStr.split(':');
      if (time.length != 2){
        alert("Invalid Time. A time must be entered in 24 hour format with hours and minutes seperated by a :");
        gField.focus()
        gField.select()
        gField.value = "";
        return false;
      }else{
        try{
          var hours = parseInt(time[0], 10);
          var minutes = parseInt(time[1], 10);

          if (hours >= 0 && hours < 24 && minutes >= 0 && minutes < 60){
            timeStr = " " + (hours<10?"0":"") + hours + ":" + (minutes<10?"0":"") + minutes;
          }else{
            alert("Invalid Time. A time must be entered in 24 hour format with hours and minutes seperated by a :");
            gField.focus()
            gField.select()
            gField.value = "";
            return false;
          }
        }catch (e) {
          alert("Invalid Time. A time must be entered in 24 hour format with hours and minutes seperated by a :");
          gField.focus()
          gField.select()
          gField.value = "";
          return false;
        }
      }
    }
  }


  // put the Oracle-friendly format back into the field
  var iMon = parseInt(""+mm,10);

  if (dd<10) {
    gField.value = "0" + dd + "-" + dispMonths[iMon] + "-" + yyyy + timeStr;
  } else {
    gField.value = dd + "-" + dispMonths[iMon] + "-" + yyyy + timeStr;
  }

  return true
}

// check the entered month for too high a value
function checkMonthLength(mm,dd) {
  var months = new Array("","January","February","March","April","May","June","July","August","September","October","November","December")
  if ((mm == 4 || mm == 6 || mm == 9 || mm == 11) && dd > 30) {
    alert(months[mm] + " has only 30 days.")
    return false
  } else if (dd > 31) {
    alert(months[mm] + " has only 31 days.")
    return false
  }
  return true
}

// check the entered February date for too high a value
function checkLeapMonth(mm,dd,yyyy) {
  if (yyyy % 4 > 0 && dd > 28) {
    alert("February of " + yyyy + " has only 28 days.")
    return false
  } else if (dd > 29) {
    alert("February of " + yyyy + " has only 29 days.")
    return false
  }
  return true
}

function checkDate(Field) {
  if (!isDate(Field,false)) {
  }
}
