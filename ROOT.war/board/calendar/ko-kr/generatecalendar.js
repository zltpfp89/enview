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
// generateCalendar.js
//
//////////////////////////////////////////////////////////////////////

var _isIE_ = (navigator.appName.indexOf("Microsoft") == 0);
var _isW3C_ = (document.documentElement) ? true : false;

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
function generateCalendar(Y, M, D, targetId, posX, posY, dateEntryFormat, ymdSeperator, calendarPath, calendarCss, displayMode, languageCode) {
	if (dateEntryFormat == undefined || dateEntryFormat == "") {
	   dateEntryFormat = "yyyymmdd";
	}

	if (ymdSeperator == undefined || ymdSeperator == "") {
	   ymdSeperator = "."; 
	}

	if (calendarPath == undefined || calendarPath == "") {
	   calendarPath = "./calendar";
	}

	if (calendarCss == undefined || calendarCss == "") {
	   calendarCss = "./calendar/css/calendar.css";
	}
	
	if (displayMode == undefined || displayMode == "") {
           displayMode = "1";
	}
	
	if (languageCode == undefined || languageCode == "") {
		languageCode = "ko-kr";
	}


	// Names of the Months:
	var Month = new Array("1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월");
	
	// Days of the Week:
	var Day = new Array("일","월","화","수","목","금","토");
	// Digits (if you want to use something other than Arabic-Indic digits):
	// var Digits = new Array("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31");
	
	var daysInMonth = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	var daysInAWeek =7;
	var str;
	
	// Guard against arguments that are really passed as strings:
	// Get year:
	var today = new Date();
	if (Y=="" || isNaN(Y)){
		thisYear = today.getFullYear();
	} else {
		thisYear = parseInt(Y);
	}
	// Get month:
	if (M == "" || isNaN(M)){
		thisMonth = today.getMonth()+1;
	} else {
		thisMonth = parseInt(M);
		if (thisMonth < 1 ) thisMonth = 1;
		if (thisMonth > 12) thisMonth = 12;
	}
	// Get day:
	if (D == "" || isNaN(D)) {
		thisDay = today.getDate();
	} else {
		thisDay = parseInt(D);
		if (thisDay < 0 ) thisDay = 1;
		if (thisDay > 31) thisDay = 31;
	}
	
	// Calculate the number of days in February:
	if ((thisYear % 4) == 0) {
		daysInMonth[1] = 29;
		if ((thisYear % 100) == 0 && (thisYear % 400) != 0) {
			daysInMonth[1] = 28;
		}
	}
	
	// Document header:
	//str += "  <link rel=\"stylesheet\" title=\"Default Style\" href=\"" + calendarCss + "\" type=\"text/css\" media=\"screen\">\n";
	//str += "  <script type=\"text/javascript\" src=\"" + calendarPath + "/calendar.js\"></script>\n";
	//str += "  <script type=\"text/javascript\" src=\"" + calendarPath + "/" + languageCode + "/generateCalendar.js\"></script>\n";
	
	// Start the calendar table with day headings:
	str = "<table class=\"cldtable\" border='1'>\n <tr>\n";
	
	str += "<td class=\"cldhead\" colspan=\"2\"><table><tr>";
	
	str += " <td><div class=\"leftyear10\" onclick=\"previousYear(10)\"><!-- left arrow --></div></td>\n";
	str += " <td><div class=\"leftyear\" onclick=\"previousYear(1)\"><!-- left arrow --></div></td>\n";
	str += " <td><div class=\"leftmonth\" onclick=\"previousMonth()\"><!-- left arrow --></div></td>\n";
	
	str += "</tr></table></td>";
	
	// Print the month heading:
	str += " <td class=\"cldhead\" colspan=\"3\">";
	
	// Print the year heading: If year<0, negate and print "BCE"; if 0<year<1000, print "CE":
	if (thisYear < 0) yearString = -thisYear + " BCE";
	else if (thisYear < 1000) yearString = thisYear + " CE";
	else yearString = thisYear;
	str += yearString + "년<br>" + Month[ thisMonth-1 ] + "</td>\n";
	
	
	str += "<td class=\"cldhead\" colspan=\"2\"><table><tr>";
	
	str += " <td><div class=\"rightmonth\" onclick=\"nextMonth()\"><!-- right arrow --></div></td>\n";
	str += " <td><div class=\"rightyear\" onclick=\"nextYear(1)\"><!-- right arrow --></div></td>\n";
	str += " <td><div class=\"rightyear10\" onclick=\"nextYear(10)\"><!-- right arrow --></div></td>\n";
	
	str += "</tr></table></td>";
	

	str += "</tr>\n<tr>\n";

	for (i=0; i<daysInAWeek; i++) {
		str += "  <th class=\"cldth\">" + Day[i] + "</th>\n";
	}
	str += " </tr>\n <tr>\n";
	
	// Get the day of week of the first of the month:
	var firstDay = dayOfWeek (julianDay (thisYear, thisMonth, 1)); 
	//alert( Day[ firstDay ] );
	
	// First week:
	for(i=0; i<firstDay; i++) {
		str += "  <td class=\"cldtd\" onclick=\"previousMonth()\">&nbsp;</td>\n";
	}

	var fgStyle = "";
	for(d=1; i<daysInAWeek; i++,d++) {
		// Special handling for October of 1582:
		if (d==5 && thisMonth==10 && thisYear==1582) d+=10;
		str += "  <td";

		if (d == thisDay) str += " class=\"thisday\"";
		else              str += " class=\"cldtd\"";

		if      (i==0) fgStyle = "<font color=red>"+d+"</font>";
		else if (i==6) fgStyle = "<font color=blue>"+d+"</font>";
		else           fgStyle = d;

		str += " onclick=\"setDate(" + d + ")\">" + fgStyle + "</td>\n";
	}
	
	// Subsequent weeks;
	var lastDayOfMonth = daysInMonth[thisMonth-1];
	for (j=1; j<6 && d<=lastDayOfMonth; j++) {
		str += " </tr>\n <!-- Week " + (j+1) + " -->\n<tr>\n";
		// Days in this month:
		for (i=0; i<daysInAWeek && d<=lastDayOfMonth; i++,d++) {  
			str += "  <td";

			if (d == thisDay) str += " class='thisday'";
			else              str += " class=\"cldtd\"";

			if      (i==0) fgStyle = "<font color=red>"+d+"</font>";
			else if (i==6) fgStyle = "<font color=blue>"+d+"</font>";
			else           fgStyle = d;

			str += " onclick=\"setDate(" + d + ")\">" + fgStyle + "</td>\n";
		}
		// Finish out the row:
		for (; i<daysInAWeek; i++) {
			str += "  <td class=\"cldtd\" onclick=\"nextMonth()\">&nbsp;</td>\n";      
		}
	}
	// Finish the HTML, with hidden vars:
	str += "  </tr>\n";
	str += "  <input type=\"hidden\" id=\"currentYear\" value=\"" + thisYear + "\">\n";
	str += "  <input type=\"hidden\" id=\"currentMonth\" value=\"" + thisMonth + "\">\n";
	str += "  <input type=\"hidden\" id=\"currentDay\" value=\"" + thisDay + "\">\n";
	str += "  <input type=\"hidden\" id=\"destinationId\" value=\"" + targetId + "\">\n";   
	str += "  <input type=\"hidden\" id=\"posX\" value=\"" + posX + "\">\n";   
	str += "  <input type=\"hidden\" id=\"posY\" value=\"" + posY + "\">\n";   
	str += "  <input type=\"hidden\" id=\"dateEntryFormat\" value=\"" + dateEntryFormat + "\">\n";   
	str += "  <input type=\"hidden\" id=\"ymdSeperator\" value=\"" + ymdSeperator + "\">\n";   
	str += "  <input type=\"hidden\" id=\"calendarPath\" value=\"" + calendarPath + "\">\n";   
	str += "  <input type=\"hidden\" id=\"calendarCss\" value=\"" + calendarCss + "\">\n";   
	str += "  <input type=\"hidden\" id=\"displayMode\" value=\"" + displayMode + "\">\n";   
	str += "  <input type=\"hidden\" id=\"languageCode\" value=\"" + languageCode + "\">\n";   
	str += "  <tr><td colspan=7><a href=# onclick='enboardCalendar.remove()'>닫기</a></td></tr>";
	str += " </table>\n";
	
	enboardCalendar.remove();
	enboardCalendar.init();
	enboardCalendar.show (posX, posY, str);
}


/*=============================================================================
 * Generate a calendar object which diplay a date was selected.
 * 2008.03.11. KWShin. Saltware.
 =============================================================================*/
function displayCalendar( aDate, targetId, evt) {

	var e = (evt) ? evt : window.event;
	var posX = e.clientX + document.body.scrollLeft;
	var posY = e.clientY + document.body.scrollTop;
	
	generateCalendar(aDate.getFullYear(), aDate.getMonth()+1, aDate.getDate(), targetId, posX, posY );
}

/*=============================================================================
 * Definition of objec for creating popup-dialog.
 * 2008.03.11. KWShin. Saltware.
 =============================================================================*/
popupCalendar = function() {}

popupCalendar.prototype = {
	mDiv : null,
	mVeilDiv : null,
	
	init : function() {
		this.mDiv = document.createElement("div");
		this.mDiv.style.background = "#EEEEEE";
		this.mDiv.style.border = "1px solid #999999";
		this.mDiv.style.position = "absolute";
		//this.mDiv.style.width = w + "px";
		this.mDiv.style.padding = 3;
		this.mDiv.style.zIndex = "999";
		this.mDiv.style.display = "none";

		document.body.appendChild( this.mDiv );

		this.mVeilDiv = document.createElement("div");
		this.mVeilDiv.style.background = "#EEEEEE";
		this.mVeilDiv.style.border = "0";
		this.mVeilDiv.style.position = "absolute";
		this.mVeilDiv.style.top = "0px";
		this.mVeilDiv.style.left = "0px";
		if (_isIE_) this.mVeilDiv.style.width = document.body.scrollWidth;
		else      this.mVeilDiv.style.width = document.width;
		if (_isIE_) this.mVeilDiv.style.height = document.body.scrollHeight;
		else      this.mVeilDiv.style.height = document.height;
		this.mVeilDiv.style.zIndex = "998";
		if (_isIE_) this.mVeilDiv.style.filter = "alpha(opacity=30)";
		else      this.mVeilDiv.style.opacity = "0.3";
		this.mVeilDiv.style.display = "none";

		document.body.appendChild( this.mVeilDiv );
	},
	
	show : function(l, t, ctt) {

		this.mDiv.innerHTML = ctt;

		this.mDiv.style.left = l + "px";
		this.mDiv.style.top  = t + "px";
		this.mDiv.style.display = "";
		
		if (this.mVeilDiv != null) {
			this.mVeilDiv.style.display = "block";
		}
	},
	
	remove : function() {
		if (this.mDiv != null ) { 
			document.body.removeChild(this.mDiv);
			this.mDiv = null;
		}
		if (this.mVeilDiv != null ) {
			document.body.removeChild(this.mVeilDiv);
			this.mVeilDiv = null;
		}
	}
}

var enboardCalendar = new popupCalendar();
