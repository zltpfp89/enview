// 달력root
var image_root = "/hancer/images/eventCommon/mng/calendar";
var global_langKnd = "";
if (typeof(CALENDAR_JS) == 'undefined') // 한번만 실행
{
	var CALENDAR_JS = true;

	var Cal_Today = new Date();
	var Cal_Year = Cur_Year = parseInt(Cal_Today.getFullYear());
	var Cal_Month = Cur_Month = parseInt(Cal_Today.getMonth()) + 1;
	var Cal_Date = Cur_Date = parseInt(Cal_Today.getDate());
	var Fld_Obj;
/* 달력 환경설정 */
	function Calendar_Config(type){
		//날짜 셀의 크기지정 가로, 세로
		var cell = new Array(25, 21);
		//요일타이틀 색깔지정 혹은 이미지 대체 (일, 월, 화, 수, 목, 금, 토) 순으로
		var yoil = new Array("<img src='" + image_root + "/cal_0.jpg'>","<img src='" + image_root + "/cal_1.jpg'>","<img src='" + image_root + "/cal_2.jpg'>","<img src='" + image_root + "/cal_3.jpg'>","<img src='" + image_root + "/cal_4.jpg'>","<img src='" + image_root + "/cal_5.jpg'>","<img src='" + image_root + "/cal_6.jpg'>");
		//날짜 색깔지정 (일, 월, 화, 수, 목, 금, 토) 순으로
		var yoil_color = new Array("#CC0000", "#000000", "#000000", "#000000", "#000000", "#000000", "#0000CC");
		//오늘 날짜 색깔 및 배경지정 (스타일태그시작, 종료,스타일(배경등))
		var today = new Array("<b style='color:#006600'>", "</b>", "background: url('" + image_root + "/mini3.gif') no-repeat; background-position:2 0;");
		//마우스 오버 색깔
		var over = '#E1E1E1';
		//달력 이동 버튼들
		var move = new Array("<img src='" + image_root + "/month_prev.gif' border=0><img src='" + image_root + "/month_prev.gif' border=0>", "<img src='" + image_root + "/month_prev.gif' border=0>", "<img src='" + image_root + "/month_next.gif' border=0>", "<img src='" + image_root + "/month_next.gif' border=0><img src='" + image_root + "/month_next.gif' border=0>");
		//분리문자 2009-01-01
		var sp = "-";
		return eval(type);
	}
/* 달력 초기화 및 삭제 */
	function Calendar_Reset(){
		Fld_Obj = null;
		Cal_Year = parseInt(Cal_Today.getFullYear());
		Cal_Month = parseInt(Cal_Today.getMonth()) + 1;
		Cal_Date = parseInt(Cal_Today.getDate());
		var Cal_Div = document.getElementById('Calendar_Div');
		Cal_Div.parentNode.removeChild(Cal_Div);
	}
	var global_calId = '';
/* 달력 초기세팅 및 출력 */
	function Calendar_Create(id,lang_knd,cal_id, pos, move){
		var Cal_Div = document.getElementById('Calendar_Div');
		global_calId = id;
		global_langKnd = lang_knd;
		if(id){
			Fld_Obj = document.getElementById(id);
		}
		if((Fld_Obj.value && Fld_Obj.value != ('0000' + Calendar_Config('sp') + '00' + Calendar_Config('sp') + '00')) && !move){
			var tmp = Fld_Obj.value.split(Calendar_Config('sp'));
			//Cal_Year = parseInt(tmp[0]);
			//Cal_Month = parseInt(tmp[1]);

			Cal_Year = eval(tmp[0]);
			Cal_Month = eval(tmp[1]);
		} else if(!move){
			Cal_Year = parseInt(Cal_Today.getFullYear());
			Cal_Month = parseInt(Cal_Today.getMonth())+1;
		}
		
		//월검사 12보다 크면 오늘날짜
		if(Cal_Month > 12)
		{
			Cal_Year = parseInt(Cal_Today.getFullYear());
			Cal_Month = parseInt(Cal_Today.getMonth())+1;
		}
		
		Cal_Date = 1;
		Cal_Time = new Date(Cal_Year, Cal_Month, 1);
		Start_Date = new Date(Cal_Year, Cal_Month-1, 1).getDay();
		Last_Date = Calendar_LastDate(Cal_Year, Cal_Month);

		Calendar_Display(Start_Date, Last_Date,cal_id, pos);
	}
/* 인풋박스의 위치값 */
	function Calendar_Get_XY(fld, pos){
		Fld_Element = new Object();
		/* 2009-02-20 getBoxObjectFor 파폭 미지원으로 삭제
	    if(document.all) {
			var obj = fld.getBoundingClientRect();
			Fld_Element.left = obj.left + (document.documentElement.scrollLeft || document.body.scrollLeft);
			Fld_Element.top = obj.top + (document.documentElement.scrollTop || document.body.scrollTop);
			Fld_Element.height = obj.bottom - obj.top;
	    } else {
			var obj = document.getBoxObjectFor(fld);
			Fld_Element.left = obj.x;
			Fld_Element.top = obj.y;
			Fld_Element.height = obj.height;
	    }
		*/
		var obj = fld.getBoundingClientRect();
		Fld_Element.left = obj.left + (document.documentElement.scrollLeft || document.body.scrollLeft);
		Fld_Element.top = obj.top + (document.documentElement.scrollTop || document.body.scrollTop);
		Fld_Element.height = obj.bottom - obj.top;
		
		var XY = null;
		
		if(pos == "up")
			XY = new Array(Fld_Element.left, Fld_Element.top - 225, Fld_Element.height);
		else if(pos == "left")
			XY = new Array(Fld_Element.left + 110, Fld_Element.top - 50, Fld_Element.height);
		else
			XY = new Array(Fld_Element.left, Fld_Element.top, Fld_Element.height);		

		return XY;
	}
/* 달력 마지막 일자 계산 */
	function Calendar_LastDate(year, month){
		var dateCount = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

		if( (year%400 == 0) || ((year%4 == 0) && (year % 100 != 0)) ) {
			dateCount[1] = 29;
		}
		return dateCount[Number(month)-1];
	}
/* 년 +, - 이동 */
	function Calendar_Move_Year(num, pos,cal_id){
		Cal_Year += num;
		Calendar_Create("",global_langKnd,cal_id, pos, true);
	}
/* 월 +, - 이동 */
	function Calendar_Move_Month(num, pos,cal_id){
		Cal_Month += num;
		if(Cal_Month < 1) { Cal_Year--; Cal_Month = 12; }
		if(Cal_Month > 12) { Cal_Year++; Cal_Month = 1; }
		Calendar_Create("",global_langKnd,cal_id, pos, true);
	}
/* 년월 동시 이동 */
	function Calendar_Move_All(year, month,cal_id, pos){
		Cal_Year = year;
		Cal_Month = month;
		Calendar_Create("",global_langKnd,cal_id, pos, true);
	}
/* 달력 실제 출력부 */
	function Calendar_Display(sd, ld,cal_id, pos){
		if(!document.getElementById('Calendar_Div')){
			if(document.layers){ 
				document.layers['Calendar_Div'] = new Layer(1);
			} else if (document.all){ //익스플로러
				document.body.insertAdjacentHTML("BeforeEnd","<DIV ID='Calendar_Div'></DIV>");
			} else { 
				Make_Div = document.createElement('div');
				Make_Div.setAttribute("id", "Calendar_Div");
				document.body.appendChild(Make_Div);
			}
		}
		var Cal_Div = document.getElementById('Calendar_Div');
		var _offset = $("#"+cal_id).offset();
		var XY = XY = Calendar_Get_XY(Fld_Obj, pos); //위치값 계산
		var _top = _offset.top;  //Calendar_Div top
		var _left = _offset.left;  //Calendar_Div left
		//환경설정 값 읽어옴
		var disp_date = 1; //날짜출력
		var disp_yoil = 0; //요일출력
		var yoil = Calendar_Config('yoil'); //요일타이틀
		var yoil_color = Calendar_Config('yoil_color'); //요일별 날짜색상
		var today_style = Calendar_Config('today'); //오늘표기
		var button = Calendar_Config('move'); //버튼
		var size = Calendar_Config('cell'); //셀크기
		var div_width = size[0] * 7 + 10; //레이어 크기계산

		with(Cal_Div.style){
			position = 'absolute';
			width =  div_width +'px';
			backgroundColor = '#e1e1e1';
			padding = '2px';
			display = 'block';
			zIndex = '99'
		}
		if(cal_id == 'calendar_switch'){
			$("#Calendar_Div").css("top",_top+"px");
			$("#Calendar_Div").css("left",_left+"px");	
		}else{
			$("#Calendar_Div").css("top",_top+"px");
			$("#Calendar_Div").css("left",_left-190+"px");
		}
		

		var In_HTML = "";
		var disp_y = "";
		var disp_m = "";
		if(global_langKnd == 'ko'){
			disp_y = Cal_Year + "년";
			disp_m = Cal_Month < 10 ? "0"+Cal_Month+"월" : Cal_Month+"월";
		}
		if(global_langKnd == 'en'){
			disp_y = Cal_Year + "Year";
			switch (Cal_Month) {
			case 1:
				disp_m = "Jan";
				break;
			case 2:
				disp_m = "Feb";
				break;
			case 3:
				disp_m = "Mar"
				break;
			case 4:
				disp_m = "Apr";
				break;
			case 5:
				disp_m = "May";
				break;
			case 6:
				disp_m = "Jun";
				break;
			case 7:
				disp_m = "Jul";
				break;
			case 8:
				disp_m = "Aug";
				break;
			case 9:
				disp_m = "Sep";
				break;
			case 10:
				disp_m = "Oct"
				break;
			case 11:
				disp_m = "Nov";
				break;
			case 12:
				disp_m = "Dec";
				break;
			default:
				break;
			}
			//disp_m = Cal_Month < 10 ? "0"+Cal_Month+"Mon" : Cal_Month+"Mon";
		}
		In_HTML += "<table border=0 width=100% cellpadding=0 cellspacing=0 bgcolor='#FFFFFF'>\n"
				+  "<tr align=center height=30><td colspan=7>"
				+  "<a href='javascript:Calendar_Move_Year(-1, \""+pos+"\",\""+cal_id+"\" );'>" + button[0] + "</a> "
				+  "<a href='javascript:Calendar_Move_Month(-1, \""+pos+"\" ,\""+cal_id+"\");'>" + button[1] + "</a>"
				+  "&nbsp;&nbsp;&nbsp;<b>" + disp_y + " " + disp_m + "</b>&nbsp;&nbsp;&nbsp;"
				+  "<a href='javascript:Calendar_Move_Month(1, \""+pos+"\",\""+cal_id+"\");'>" + button[2] + "</a> "
				+  "<a href='javascript:Calendar_Move_Year(1, \""+pos+"\",\""+cal_id+"\");'>" + button[3] + "</a></td></tr>\n"
				+  "<tr><td colspan='7' bgcolor='e1e1e1'></td></tr>"
				+  "<tr align=center height=22>";
		//요일출력
		for(var i=0; i<yoil.length; i++){
			In_HTML += "<td>" + yoil[i] + "</td>";
		}
		In_HTML += "</tr>\n"
				+  "<tr><td colspan='7' bgcolor='e1e1e1'></td></tr>";
		//날짜출력
		for(var i=0; i<ld+sd; i++){
			if(disp_yoil > 6) disp_yoil = 0;

			if(i == 0) In_HTML += "\n<tr height="+size[1]+">";
			if(i>0 && i%7 == 0){
				if(i%7 == 0) In_HTML += "\n</tr>\n<tr height="+size[1]+">\n";
			}
			if(i < sd) {
				In_HTML += "<td>&nbsp;</td>";
			} else if(Cal_Year == Cur_Year && Cal_Month == Cur_Month && disp_date == Cur_Date){
				In_HTML += "<td align=center style=\"cursor:pointer;";
				if(today_style[2]) In_HTML += " " + today_style[2];
				In_HTML += "\" onclick='Calendar_SetValue(" + disp_date + ");'>" + today_style[0] + disp_date + today_style[1] + "</td>";
				disp_date++;
			} else {
				In_HTML += "<td align=center style=\"cursor:pointer;\" onclick='Calendar_SetValue(" + disp_date + ");' onmouseover=\"Calendar_ChangeBG(this, 'set');\" onmouseout=\"Calendar_ChangeBG(this, 'unset');\"><font color='" + yoil_color[disp_yoil] + "'>" + disp_date + "</font></td>";
				disp_date++;
			}
			disp_yoil++;
		}
		//빈칸 메꾸기
		if(disp_yoil < 7){
			for(var i=disp_yoil; i<7; i++){
				In_HTML += "<td>&nbsp;</td>";
			}
		}
		//In_HTML += "\n</tr>"
			//	+  "<tr><td colspan='7' bgcolor='e1e1e1'></td></tr>"
				if(global_langKnd == 'ko'){
					In_HTML += "\n</tr>"
							+  "<tr><td colspan='7' bgcolor='e1e1e1'></td></tr>"	
							+  "<tr><td colspan=7 align=right style='padding:3 3;'><a href='javascript:Calendar_Move_All(" + Cur_Year + ", " + Cur_Month + ",\""+cal_id+"\");'>[오늘]</a> <a href='javascript:Calendar_Reset();'>[닫기]</a></td></tr></table>";
				}
				if(global_langKnd == 'en'){
					In_HTML += "\n</tr>"
							+  "<tr><td colspan='7' bgcolor='e1e1e1'></td></tr>"
							+  "<tr><td colspan=7 align=right style='padding:3 3;'><a href='javascript:Calendar_Move_All(" + Cur_Year + ", " + Cur_Month + ",\""+cal_id+"\");'>[today]</a> <a href='javascript:Calendar_Reset();'>[close]</a></td></tr></table>";
				}
				
		Cal_Div.innerHTML = In_HTML;
	}
/* 날짜클릭으로 인풋박스에 값 넣기 */
	function Calendar_SetValue(date){
		var sp = Calendar_Config('sp');
		Fld_Obj.value = Cal_Year + sp + (Cal_Month < 10 ? '0'+Cal_Month : Cal_Month) + sp + (date < 10 ? '0'+date : date);
		Calendar_Reset();
	}
/* [오늘] 을 클릭했을시 달력이 사라지면서 오늘날짜를 바로 넣기 */
	function Calendar_SetToday(){
		Cal_Year = Cur_Year;
		Cal_Month = Cur_Month;
		Calendar_SetValue(Cur_Date);
	}
/* 날짜에 마우스 오버시 배경색 변경 */
	function Calendar_ChangeBG(obj, type){
		if(type == 'set'){
			obj.style.backgroundColor = Calendar_Config('over');
		} else {
			obj.style.backgroundColor = '';
		}
	}
}
//입력 값 삭제 후 닫기
function Calendar_Del(){
	document.getElementById(global_calId).value = '';
	//Calendar_Reset();
}