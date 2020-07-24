//////////////////////////////////////////////////////////////////////
//
//  ======================================================
//  GLADIATOR JAVASCRIPT CALENDAR AND JULIAN DAY FUNCTIONS
//  ======================================================
//  
//  Javascript Calendar and Julian day to Gregorian date
//  conversion functions
//
//  VERSION: 1.0.0 dated 2003.10.15
//
//  COPYRIGHT (c) 2003 by Edward H. Trager.  ALL RIGHTS RESERVED.
//  Ann Arbor, Michigan, USA.  
//
//  This file and the accompanying Cascading Style Sheet file,
//  calendar.css, are released under the 
//  GNU GENERAL PUBLIC LICENSE (GPL) -- see terms below.  You
//  are basically free to use and modify these files, but you 
//  must preserve the copyright notice above.
//
//  AUTHOR 
//  ------
//
//  Edward H. Trager  <ehtrager@umich.edu>
//
//  Last Modified by: Zahid Udaipurwala
//  Last Modified on: 2004/02/02
//
//
//  SUMMARY OF GPL LICENSING TERMS
//  ------------------------------
//
//  This program is free software; you can redistribute it and/or     
//  modify it under the terms of the GNU General Public               
//  License as published by the Free Software Foundation; either      
//  version 2 of the License, or (at your option) any later version.  
//                                                                    
//  This program is distributed in the hope that it will be useful,   
//  but WITHOUT ANY WARRANTY; without even the implied warranty of    
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
//  General Public License for more details.                          
//                                                                    
//  You should have received a copy of the GNU General Public         
//  License along with this software source code distribution; if not,
//  write to the Free Software Foundation, Inc., 59 Temple Place -    
//  Suite 330, Boston, MA 02111-1307, USA, or review the license                           
//  online at:
//
//     http://www.gnu.org/licenses/gpl.txt
//  
//////////////////////////////////////////////////////////////////////
//
// generatecalendar.js
//
//////////////////////////////////////////////////////////////////////


//
// generateCalendar()
//
// Arguments: Year, Month, Day, ID of the target element, date entry format,
//            calendar folder path, calendar css file, display mode, language code.
//
// This function creates the popup calendar.  Clicking on a date
// populates the target element with the chosen date in ISO 8601
// YYYY-MM-DD format (for Common Era years: years before Common Era
// are prefixed with a negative sign) and closes the popup window.
//
function generateCalendar(Y, M, D, targetId, dateEntryFormat, ymdSeperator, calendarPath, calendarCss, displayMode, languageCode) {

	if (dateEntryFormat == undefined || dateEntryFormat == "") {
	   dateEntryFormat = "yyyymmdd";
	}

	if (ymdSeperator == undefined || ymdSeperator == "") {
	   ymdSeperator = "-"; 
	}

	if (calendarPath == undefined || calendarPath == "") {
	   calendarPath = "../calendar";
	}

	if (calendarCss == undefined || calendarCss == "") {
	   calendarCss = "../calendar/css/calendar.css";
	}
	
	if (displayMode == undefined || displayMode == "") {
           displayMode = "1";
	}
	
        if (languageCode == undefined || languageCode == "") {
           languageCode = "en-us";
        }

	
	// Names of the Months:
	//var Month = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
	var Month = new Array("Ιανουάριος","Φεβρουάριος","Μάρτιος","Απρίλιος","Μάϊος","Ιούνιος","Ιούλιος","Αύγουστος","Σεπτέμβριος","Οκτώβριος","Νοέμβριος","Δεκέμβριος");
	
	// Days of the Week:
	//var Day = new Array("Sun","Mon","Tue","Wed","Thu","Fri","Sat");
	var Day = new Array("Κυρ","Δευ","Τρι","Τετ","Πεμ","Παρ","Σαβ");
	// Digits (if you want to use something other than Arabic-Indic digits):
	// var Digits = new Array("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31");
	
	var daysInMonth = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	var daysInAWeek=7;
	var OutputString;
	
	// Guard against arguments that are really passed as strings:
	// Get year:
	var today = new Date();
	if( Y=="" || isNaN(Y) ){
		thisYear=today.getFullYear();
	}else{
		thisYear=parseInt(Y);
	}
	// Get month:
	if( M=="" || isNaN(M) ){
		thisMonth=today.getMonth()+1;
	}else{
		thisMonth=parseInt(M);
		if(thisMonth<1) thisMonth=1;
		if(thisMonth>12) thisMonth=12;
	}
	// Get day:
	if( D=="" || isNaN(D) ){
		thisDay=today.getDate();
	}else{
		thisDay=parseInt(D);
		if(thisDay<0) thisDay=1;
		if(thisDay>31) thisDay=31;
	}
	
	// Calculate the number of days in February:
	if ((thisYear % 4) == 0){
		daysInMonth[ 1 ] = 29;
		if((thisYear % 100) == 0 && (thisYear % 400) != 0){
			daysInMonth[ 1 ] = 28;
		}
	}
	
	// Document header:
	OutputString = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\"\n";
	OutputString += "   \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n";
	OutputString += "<html>\n <head>\n";
	OutputString += "  <title>Gladiator Calendar</title>\n";
	OutputString += "  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n";
	OutputString += "  <link rel=\"stylesheet\" title=\"Default Style\" href=\"" + calendarCss + "\" type=\"text/css\" media=\"screen\">\n";
	OutputString += "  <script type=\"text/javascript\" src=\"" + calendarPath + "/calendar.js\"></script>\n";
	OutputString += "  <script type=\"text/javascript\" src=\"" + calendarPath + "/" + languageCode + "/generateCalendar.js\"></script>\n";
	OutputString += " </head>\n <body id=\"mycal\">\n";
	
	// Start the calendar table with day headings:
	OutputString += "<table border='1'>\n <tr>\n";
	OutputString += " <td class=\"calendarheading\"><div class=\"cssleftstretcharrow\" onclick=\"previousYear()\"><!-- left arrow --></div></td>\n";
	OutputString += " <td class=\"calendarheading\"><div class=\"cssleftarrow\" onclick=\"previousMonth()\"><!-- left arrow --></div></td>\n";
	// Print the month heading:
	OutputString += " <td class=\"calendarheading\" colspan=\"3\">" + Month[ thisMonth-1 ] + "<br>";
	// Print the year heading: If year<0, negate and print "BCE"; if 0<year<1000, print "CE":
	if( thisYear < 0 ) yearString = -thisYear + " BCE";
	else if( thisYear < 1000 ) yearString = thisYear + " CE";
	else yearString = thisYear;
	OutputString += yearString + "</td>\n";
	OutputString += " <td class=\"calendarheading\"><div class=\"cssrightarrow\" onclick=\"nextMonth()\"><!-- right arrow --></div></td>\n";
	OutputString += " <td class=\"calendarheading\"><div class=\"cssrightstretcharrow\" onclick=\"nextYear()\"><!-- right arrow --></div></td>\n";
	OutputString += "</tr>\n <tr>\n";
	for(i=0;i<daysInAWeek;i++){
		OutputString += "  <th>" + Day[i] + "</th>\n";
	}
	OutputString += " </tr>\n <tr>\n";
	
	// Get the day of week of the first of the month:
	var firstDay=dayOfWeek( julianDay( thisYear, thisMonth, 1 ) ); 
	//alert( Day[ firstDay ] );
	
	// First week:
	for(i=0;i<firstDay;i++){
		OutputString += "  <td onclick=\"previousMonth()\">&nbsp;</td>\n";
	}
	for(d=1;i<daysInAWeek;i++,d++){
		// Special handling for October of 1582:
		if( d==5 && thisMonth==10 && thisYear==1582 ) d+=10;
		OutputString += "  <td";
		if(d==thisDay) OutputString += " class='thisday'";
		OutputString += " onclick=\"setDate(" + d + ")\">" + d + "</td>\n";
	}
	
	// Subsequent weeks;
	var lastDayOfMonth=daysInMonth[thisMonth-1];
	for(j=1;j<6 && d<=lastDayOfMonth;j++){
		OutputString += " </tr>\n <!-- Week " + (j+1) + " -->\n<tr>\n";
		// Days in this month:
		for( i=0; i<daysInAWeek && d<=lastDayOfMonth;i++,d++){  
			OutputString += "  <td";
			if(d==thisDay) OutputString += " class='thisday'";
			OutputString += " onclick=\"setDate(" + d + ")\">" + d + "</td>\n";
		}
		// Finish out the row:
		for(;i<daysInAWeek;i++){
			OutputString += "  <td onclick=\"nextMonth()\">&nbsp;</td>\n";      
		}
	}
	// Finish the HTML, with hidden vars:
	OutputString += "  </tr>\n";
	OutputString += " </table>\n";
	OutputString += " <p>\n";
	OutputString += "  <input type=\"hidden\" id=\"currentYear\" value=\"" + thisYear + "\">\n";
	OutputString += "  <input type=\"hidden\" id=\"currentMonth\" value=\"" + thisMonth + "\">\n";
	OutputString += "  <input type=\"hidden\" id=\"currentDay\" value=\"" + thisDay + "\">\n";
	OutputString += "  <input type=\"hidden\" id=\"destinationId\" value=\"" + targetId + "\">\n";   
	OutputString += "  <input type=\"hidden\" id=\"dateEntryFormat\" value=\"" + dateEntryFormat + "\">\n";   
	OutputString += "  <input type=\"hidden\" id=\"ymdSeperator\" value=\"" + ymdSeperator + "\">\n";   
	OutputString += "  <input type=\"hidden\" id=\"calendarPath\" value=\"" + calendarPath + "\">\n";   
	OutputString += "  <input type=\"hidden\" id=\"calendarCss\" value=\"" + calendarCss + "\">\n";   
	OutputString += "  <input type=\"hidden\" id=\"displayMode\" value=\"" + displayMode + "\">\n";   
	OutputString += "  <input type=\"hidden\" id=\"languageCode\" value=\"" + languageCode + "\">\n";   
	OutputString += " </p>\n </body>\n</html>\n";
	
	var calendarWindow;
	if( !calendarWindow || calendarWindow.closed() ){
		calendarWindow = window.open("","Calendar","screenX=50, screenY=50, width=325, height=275,resizable=no");
	}   
	calendarWindow.document.write(OutputString);
	calendarWindow.document.close();
	
}
