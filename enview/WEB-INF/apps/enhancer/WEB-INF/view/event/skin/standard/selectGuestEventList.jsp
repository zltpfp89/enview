<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="java.util.List" %>
<%@ page import="com.saltware.enhancer.admin.event.model.EventMngListVO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %> 
<%
  String langKnd ="ko";
  MultiResourceBundle msgs = null;
  msgs = EnviewMultiResourceManager.getInstance().getBundle(langKnd);

  String token = (String)session.getAttribute("gAuthToken");
 %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
<title>이벤트 리스트</title>
<link href="<%=request.getContextPath()%>/hancer/css/event/cssbasic.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/hancer/css/event/core_top.css" rel="stylesheet" type="text/css" />
<%
	List newestEvObj = (List<com.saltware.enhancer.event.service.EventUserListVO>)request.getAttribute("eventList");
	int lenNew = newestEvObj.size();
	request.setAttribute("newestEvLen",lenNew);
%>
<script type="text/javascript">
	var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
	var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+'/hancer';
	var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+'/event';
	var dateType = '<c:out value="${paramMap.SRCH_DATE_DIV}"/>';	// 검색날짜기준(일:D/주:W/월:M) Default-일별검색(메인화면에서D로...)

	//화면초기화
	function initEventList(){
		var stdDate = '<c:out value="${paramMap.SRCH_STD_DATE}"/>';
		var endDate = '<c:out value="${paramMap.SRCH_END_DATE}"/>';
		if(stdDate != ""){
			switch (dateType) {
				case 'D':
					document.getElementById("date_disp").innerHTML = "<span id='date_val'>"+stdDate.substr(0,4)+"."+stdDate.substr(4,2)+"."+stdDate.substr(6,2)+"</span>";
					break;
				case 'W':
					document.getElementById("date_disp").innerHTML = "<span id='date_val'>"+stdDate.substr(0,4)+"."+stdDate.substr(4,2)+"."+stdDate.substr(6,2)+"~"
																	+endDate.substr(0,4)+"."+endDate.substr(4,2)+"."+endDate.substr(6,2)+"</span>";
					break;
				case 'M':
					document.getElementById("date_disp").innerHTML = "<span id='date_val'>"+stdDate.substr(0,4)+"."+stdDate.substr(4,2)+"</span>";
					break;
				default:
					break;
			}			
		}else{
			//검색조건 오늘 날짜 셋팅
			var now = new Date();
			var year= now.getFullYear();
			var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
			var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
			document.getElementById("date_disp").innerHTML = "<span id='date_val'>"+year+"."+mon+"."+day+"</span>";
		}

		//더보기 후 포커스 하단으로 이동
		if('<c:out value="${newestEvLen}"/>' > 5){
			document.getElementById("lastIndexFocus").focus();
			document.getElementById("lastIndexFocus").disabled = true;
		}
	}
	
	//더보기버튼 클릭시 5건씩 리스트에 추가
	var dispCnt = '<c:out value="${paramMap.PAGE_SIZE}"/>';
	function moreNewEvent(n){
		dispCnt = eval(dispCnt) + eval(n);
		document.getElementById("PAGE_SIZE").value = dispCnt;
		document.getElementById("eventListFrom").action = actPath+"/selectGuestEventList.hanc";
		document.getElementById("eventListFrom").submit();
	}
	
	//이벤트 참가(I'm Going)
	function applyEvent(eventKey){
		if(confirm('<%=msgs.getString("ev.hnevent.msg.event.applyEvent")%>')){
			$.ajax({ 
			   type: "POST", 
			   url: actPath+"/insertParticipation.hanc", 
			   data: "EVENT_SEQ="+eventKey,
			   dataType:"text",
			   success: function(data){ 
					alert(data);
			   }, 
			   error: function(request, status, error) {
					//alert(request.responseText);
					alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
			   }
			}); 
		}
	}
	
	//이벤트목록페이지로 이동
	function retriveEvent(knd,val,val2){
		var frm = document.getElementById("eventListFrom");
		switch (knd) {
		case 1://이벤트검색(이벤트명)			
			var eventNm = document.getElementById("event_search").value;
			document.getElementById("SRCH_STR").value = eventNm;
			document.getElementById("SRCH_TYPE").value = "N";
			document.getElementById("SRCH_DATE_DIV").value = "D";
			break;
		case 2://날짜선택
			document.getElementById("SRCH_STD_DATE").value = val;
			document.getElementById("SRCH_TYPE").value = "D";
			document.getElementById("SRCH_END_DATE").value = val;
			document.getElementById("SRCH_DATE_DIV").value = "D";
			break;
		case 3://카테고리별
			document.getElementById("SRCH_CATE").value = val;
			document.getElementById("SRCH_CATE_NM").value = val2;
			document.getElementById("SRCH_TYPE").value = "C";
			document.getElementById("SRCH_DATE_DIV").value = "D";
			break;
		case 4://기관별
			document.getElementById("SRCH_DEPT").value = val;
			document.getElementById("SRCH_TYPE").value = "O";
			document.getElementById("SRCH_DATE_DIV").value = "D";
			break;
		default:
			break;
		}
		document.getElementById("PAGE_SIZE").value = "";
		frm.submit();
	}

	//일.주.월별 날짜변경
	function changeDateDisp(flag){
		var txtVal = (document.getElementById("date_val").textContent)?document.getElementById("date_val").textContent : document.getElementById("date_val").innerText;
		var sdate = "";
		var rtnVal = "";
		switch (dateType) {
			case 'D'://일별	
				sdate = txtVal.split('.');
				rtnVal = makeSingleDate(flag,sdate);
				break;
			case 'W'://주별
				sdate = txtVal.split('~');			
				rtnVal = makeWeekDate(flag,sdate);
				break;
			case 'M'://월별
				sdate = txtVal.split('.');
				rtnVal = makeMonthDate(flag,sdate);
				break;
			default:
				break;
		}
		var parseData = rtnVal.split('/');				
		document.getElementById("date_disp").innerHTML = "<span id='date_val'>"+parseData[0]+"</span>";

		//조건별로 검색
		srchEvent(dateType);
	}
	
	//일별검색 날짜생성모듈
	function makeSingleDate(flag,date){
		var sDate = date;
		var newDay = nowDay = new Date(sDate[0],sDate[1]-1,sDate[2]);
		
		if(flag == "pre")//이전
			newDay.setDate(nowDay.getDate()-1); // 기준 일자에서 날짜를 가져다 간격일수 만큼 더해서 새로운 일자에 넣음
		if(flag == "next")//다음
			newDay.setDate(nowDay.getDate()+1);
			
		var newyy=newDay.getFullYear();  														   // 새로운 일자에서 년도 가져오기
		var newmm=(newDay.getMonth()+1)>9 ? ''+(newDay.getMonth()+1) : '0'+(newDay.getMonth()+1);  // 새로운 일자에서 월 가져오기 (+1)
		var newdd=newDay.getDate()>9 ? ''+newDay.getDate() : '0'+newDay.getDate();      		   // 새로운 일자에서 날짜 가져오기
		
		//리턴할 날짜데이터
		var inTxt = newyy+"."+newmm+"."+newdd;
		var stdDate = newyy+newmm+newdd;
		return inTxt+"/"+stdDate;
	}
	
	//주별검색 날짜생성모듈(yyyymmdd~yyyymmdd포맷)
	function makeWeekDate(flag,date){
		var sWeek = date;
		var sWeekDate1 = sWeek[0].split('.');
		var sWeekDate2 = sWeek[1].split('.');
		
		var newWeek1 = nowWeek1 = new Date(sWeekDate1[0],sWeekDate1[1]-1,sWeekDate1[2]);
		var newWeek2 = nowWeek2 = new Date(sWeekDate2[0],sWeekDate2[1]-1,sWeekDate2[2]);

		if(flag == "pre"){
			newWeek1.setDate(nowWeek1.getDate()-7);
			newWeek2.setDate(nowWeek2.getDate()-7);
		}
		if(flag == "next"){
			newWeek1.setDate(nowWeek1.getDate()+7);
			newWeek2.setDate(nowWeek2.getDate()+7);
		}
		//해당주의 시작날짜
		var newyy1 = newWeek1.getFullYear();
		var newmm1 = (newWeek1.getMonth()+1)>9 ? ''+(newWeek1.getMonth()+1) : '0'+(newWeek1.getMonth()+1);
		var newdd1 = newWeek1.getDate()>9 ? ''+newWeek1.getDate() : '0'+newWeek1.getDate();
		
		//해당주의 마지말날짜
		var newyy2 = newWeek2.getFullYear();
		var newmm2 = (newWeek2.getMonth()+1)>9 ? ''+(newWeek2.getMonth()+1) : '0'+(newWeek2.getMonth()+1);
		var newdd2 = newWeek2.getDate()>9 ? ''+newWeek2.getDate() : '0'+newWeek2.getDate();
		
		//리턴할 날짜데이터
		var inTxt = newyy1+"."+newmm1+"."+newdd1+"~"+newyy2+"."+newmm2+"."+newdd2;
		var stdDate = newyy1+newmm1+newdd1;
		var endDate = newyy2+newmm2+newdd2;
		
		return inTxt+"/"+stdDate+"/"+endDate;
	}
	
	//주별검색 날짜생성모듈(yyyymmdd포맷)
	function makeWeekDate2(date){
		var sDate = date;
		var nowDay = new Date(sDate[0],sDate[1]-1,sDate[2]);
		var i = nowDay.getDay(); //{"일","월","화","수","목","금","토"} : 0~6
		var cal_st = new Date(nowDay.getFullYear(),nowDay.getMonth(),nowDay.getDate()-i);
		var cal_en = new Date(nowDay.getFullYear(),nowDay.getMonth(),nowDay.getDate()+(6-i));

		//리턴할 날짜데이터
		var stdDate = (cal_st.getFullYear())+((cal_st.getMonth()+1)>9 ? ''+(cal_st.getMonth()+1) : '0'+(cal_st.getMonth()+1))+(cal_st.getDate()>9 ? ''+cal_st.getDate() : '0'+cal_st.getDate());
		var endDate = (cal_en.getFullYear())+((cal_en.getMonth()+1)>9 ? ''+(cal_en.getMonth()+1) : '0'+(cal_en.getMonth()+1))+(cal_en.getDate()>9 ? ''+cal_en.getDate() : '0'+cal_en.getDate());
		
		return stdDate+"/"+endDate;
	}
	
	//월별검색 날짜생성모듈
	function makeMonthDate(flag,date){
		var sMonth = date;
		var newMonth = nowMonth = new Date(sMonth[0],sMonth[1]-1);
		
		if(flag == "pre")
			newMonth.setMonth(nowMonth.getMonth()-1);
		if(flag == "next")
			newMonth.setMonth(nowMonth.getMonth()+1);

		var newyy=newMonth.getFullYear();
		var newmm=(newMonth.getMonth()+1)>9 ? ''+(newMonth.getMonth()+1) : '0'+(newMonth.getMonth()+1);
		var newdd=newMonth.getDate()>9 ? ''+newMonth.getDate() : '0'+newMonth.getDate();
		
		//리턴할 날짜데이터
		var inTxt = newyy+"."+newmm;
		var stdDate = newyy+newmm+newdd;
		var endDate = newyy+newmm+(new Date( newyy, newmm, 0) ).getDate();
		
		return inTxt+"/"+stdDate+"/"+endDate;
	}
	
	//화면 날짜포맷과 검색모드가 다를때(dateType!=dType)
	function srchChangeMod(dType){
		switch (dType) {
			case 'D'://일별이벤트보기 클릭 :: yyyymmdd포맷으로변경	
				var rtnData = "";
				if(dateType == 'W'){//화면날짜포맷 : 2011.11.06~2011.11.12->시작일자를 보내서 데이터리턴받음
					var txtVal = (document.getElementById("date_val").textContent)?document.getElementById("date_val").textContent : document.getElementById("date_val").innerText;
					var sdate = txtVal.split('~')[0];
					rtnData = makeSingleDate("cur",sdate.split('.'));					
				}
				if(dateType == 'M'){//화면날짜포맷 : 2011.11
					var txtVal = (document.getElementById("date_val").textContent)?document.getElementById("date_val").textContent : document.getElementById("date_val").innerText;
					var sdate = txtVal.split('.');
					rtnData = makeMonthDate("cur",sdate);					
				}
				document.getElementById("SRCH_STD_DATE").value = rtnData.split('/')[1];
				document.getElementById("SRCH_END_DATE").value = rtnData.split('/')[1];
				break;
			case 'W'://주별이벤트보기 클릭 :: yyyymmdd~yyyymmdd포맷으로변경
				var sdate = "";
				var rtnData = "";
				if(dateType == 'D'){//화면날짜포맷 : 2011.11.06
					var txtVal = (document.getElementById("date_val").textContent)?document.getElementById("date_val").textContent : document.getElementById("date_val").innerText;
					sdate = txtVal.split('.');
				}if(dateType == 'M'){//화면날짜포맷 : 2011.11
					var txtVal = (document.getElementById("date_val").textContent)?document.getElementById("date_val").textContent : document.getElementById("date_val").innerText;
					sdate = (txtVal+".01").split('.');
				}
				rtnData = makeWeekDate2(sdate);
				document.getElementById("SRCH_STD_DATE").value = rtnData.split('/')[0];
				document.getElementById("SRCH_END_DATE").value = rtnData.split('/')[1];
				break;
			case 'M'://월별이벤트보기 클릭
				var sdate = "";
				var rtnData = "";
				if(dateType == 'D'){//화면날짜포맷 : 2011.11.06
					var txtVal = (document.getElementById("date_val").textContent)?document.getElementById("date_val").textContent : document.getElementById("date_val").innerText;
					sdate = txtVal.split('.');
				}
				if(dateType == 'W'){//화면날짜포맷 : 2011.11.06~2011.11.12
					var txtVal = (document.getElementById("date_val").textContent)?document.getElementById("date_val").textContent : document.getElementById("date_val").innerText;
					sdate = (txtVal.split('~')[0]).split('.');
				}
				rtnData = makeMonthDate("cur",sdate);	
				document.getElementById("SRCH_STD_DATE").value = rtnData.split('/')[1];
				document.getElementById("SRCH_END_DATE").value = rtnData.split('/')[2];
				break;
			default:
				break;
		}
	}
	
	//화면 날짜포맷과 검색모드가 같을때(dateType==sType)
	function srchFixMod(dType){
		var sdate = "";
		var rtnData = "";
		switch (dType) {
		case 'D':
			var txtVal = (document.getElementById("date_val").textContent)?document.getElementById("date_val").textContent : document.getElementById("date_val").innerText;
			sdate = txtVal.split('.');
			rtnData = makeSingleDate("cur",sdate);
			document.getElementById("SRCH_END_DATE").value = rtnData.split('/')[1];
			break;
		case 'W':
			var txtVal = (document.getElementById("date_val").textContent)?document.getElementById("date_val").textContent : document.getElementById("date_val").innerText;
			sdate = txtVal.split('~');
			rtnData = makeWeekDate("cur",sdate);
			document.getElementById("SRCH_END_DATE").value = rtnData.split('/')[2];
			break;
		case 'M':
			var txtVal = (document.getElementById("date_val").textContent)?document.getElementById("date_val").textContent : document.getElementById("date_val").innerText;
			sdate = txtVal.split('.');
			rtnData = makeMonthDate("cur",sdate);
			document.getElementById("SRCH_END_DATE").value = rtnData.split('/')[2];
			break;
		default:
			break;
		}
		document.getElementById("SRCH_STD_DATE").value = rtnData.split('/')[1];
	}
	
	//일/주/월별검색
	function srchEvent(dType){

		if(dateType == dType) 
			srchFixMod(dType);
		else 
			srchChangeMod(dType);
		
		document.getElementById("SRCH_DATE_DIV").value = dType;
		document.getElementById("PAGE_SIZE").value = "";
		var frm = document.getElementById("eventListFrom");
		frm.submit();
	}
	
	//이벤트상세보기로 이동
	function viewEvent(evSeq){
		document.getElementById("EVENT_SEQ").value = evSeq;
		var frm = document.getElementById("eventListFrom");
		frm.action = actPath+"/detailEventByGuest.hanc";
		frm.submit();
	}

	//SNS링크 공유
	function shareSnsLink(type,idx,url){ 
		var sUrl = "";
		var sWidth = 1000;
		var sHdight = 0;
		var title = (document.getElementById("evShare"+idx).textContent)?document.getElementById("evShare"+idx).textContent : document.getElementById("evShare"+idx).innerText;

		if(type == "twitter"){
			sUrl = "http://twitter.com/home?status=" + encodeURIComponent(title) + " " + encodeURIComponent(url);   
			sHdight = 320;
		}
		if(type == "facebook"){
			//sUrl = "http://www.hancbook.com/sharer.php?u=" + url + "&t=" + encodeURIComponent(title); 
			sUrl = 'http://www.hancbook.com/sharer.php?s=100&p[url]='+encodeURIComponent(url)+'&p[title]='+encodeURIComponent(title); 
			sHdight = 570;
		}
		openWinCenter(sUrl, "", sWidth, sHdight);
	}
	
	//구글켈린더에 일정추가
	function addSchedule(seq){
		var url = '';
		var siteUrl = 'http://portal.saltware.co.kr';
		if('<%=token%>'==null || '<%=token%>'=='null' || '<%=token%>'=='' || '<%=token%>'=='undefined')
			url = 'https://www.google.com/accounts/AuthSubRequest?next=' + siteUrl + '/event/selectGoogleAddEvent.hanc?EVENT_SEQ='+seq+'&scope=http://www.google.com/calendar/feeds/&secure=0&session=1';
		if('<%=token%>'!=null && '<%=token%>'!='null' && '<%=token%>'!='' && '<%=token%>'!='undefined')
			url = siteUrl + '/event/selectGoogleAddEvent.hanc?EVENT_SEQ='+seq;
		openWinCenter(url, "", 1000, 800);
	}

	//팝업창 화면 가운데 정렬
	function openWinCenter(url, target, intwidth, intheight, options) {
		var top = 0;
		var left = 0;
		var w_width = intwidth; 	//창 넓이
		var w_height = intheight; 	//창 높이
		var option;
		if(left == 0){
			var x= screen.width/2 - w_width/2; //화면중앙으로위치
			left = x;
		}
		if(top == 0){
			var y= screen.height/2 - w_height/2;
			top = y;
		}
		
		option = "top="+top+",left="+left+",width="+intwidth+",height="+intheight+",resizable=1,scrollbars=0";
		if(options != null && options != ""){
			option = "top="+top+",left="+left+",width="+intwidth+",height="+intheight+","+options;
		}
		
		window.open(url, target, option);
	}
</script>
</head>
<body onload="initEventList()">
	<div id="common_wrap">
		<div id="content">
			<div id="common_top">
				<h1><a href ="<%=request.getContextPath()%>/event/mainEventGuest.hanc"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/logo_event_en.png" alt="" /></a></h1>
				<h2><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/logo_event_ko.png" alt="" /></h2>
			</div>
		</div>
	</div>
	<div id="content"> 
		<div id="body">
			<div class="event_Maincontents"> 
				<!-- mainContents --> 
				<div class="latestEvent_box">
					<h1>
						<c:if test="${paramMap.SRCH_TYPE == 'C'}"><c:out value="${paramMap.SRCH_CATE_NM}"/></c:if>
						<c:if test="${paramMap.SRCH_TYPE == 'D'}"><%=msgs.getString("ev.hnevent.label.searchByDate")%></c:if>
						<c:if test="${paramMap.SRCH_TYPE == 'N'}"><c:out value="${paramMap.SRCH_STR}"/></c:if>
						<c:if test="${paramMap.SRCH_TYPE == 'O'}"><c:out value="${paramMap.SRCH_DEPT}"/></c:if>
						(<c:out value="${totalCount}"/>)
					</h1>
					<div class="contentIn">
						<div class="page_head"><a href="#link" style="cursor:pointer;" onclick="javascript:changeDateDisp('pre');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/btn_prev.gif" alt="이전 달"></a> <strong id="date_disp"></strong> <a href="#link" style="cursor:pointer;" onclick="javascript:changeDateDisp('next');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/btn_next.gif" alt="다음 달"></a> <c:if test="${paramMap.LANG_KND == 'ko'}"><span class="btn_dwm"><a href="<%=request.getContextPath()%>/event/mainEventGuest.hanc?HIST_BACK_TYPE=MAIN"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_pre_event.gif"alt="BackHome" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:srchEvent('D');"><c:if test="${paramMap.SRCH_DATE_DIV=='D'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_day_on.gif" alt="일"></c:if><c:if test="${paramMap.SRCH_DATE_DIV!='D'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_day.gif" alt="일"></c:if></a> <a href="#link" style="cursor:pointer;" onclick="javascript:srchEvent('W');"><c:if test="${paramMap.SRCH_DATE_DIV=='W'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_week_on.gif" alt="주"></c:if><c:if test="${paramMap.SRCH_DATE_DIV!='W'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_week.gif" alt="주"></c:if></a> <a href="#link" style="cursor:pointer;" onclick="javascript:srchEvent('M');"><c:if test="${paramMap.SRCH_DATE_DIV=='M'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_month_on.gif" alt="월"></c:if><c:if test="${paramMap.SRCH_DATE_DIV!='M'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_month.gif" alt="월"></c:if></a></span></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><span class="btn_dwm"><a href="<%=request.getContextPath()%>/event/mainEventGuest.hanc?HIST_BACK_TYPE=MAIN"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_pre_event.gif"alt="BackHome" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:srchEvent('D');"><c:if test="${paramMap.SRCH_DATE_DIV=='D'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_day_on_en.gif" alt="day"></c:if><c:if test="${paramMap.SRCH_DATE_DIV!='D'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_day_en.gif" alt="day"></c:if></a> <a href="#link" style="cursor:pointer;" onclick="javascript:srchEvent('W');"><c:if test="${paramMap.SRCH_DATE_DIV=='W'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_week_on_en.gif" alt="week"></c:if><c:if test="${paramMap.SRCH_DATE_DIV!='W'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_week_en.gif" alt="week"></c:if></a> <a href="#link" style="cursor:pointer;" onclick="javascript:srchEvent('M');"><c:if test="${paramMap.SRCH_DATE_DIV=='M'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_month_on_en.gif" alt="month"></c:if><c:if test="${paramMap.SRCH_DATE_DIV!='M'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_month_en.gif" alt="month"></c:if></a></span></c:if></div>
						<!-- eventList -->
						<c:if test="${!empty eventList}">
						<div class="event_list" id="event_list">
							<c:forEach  items="${eventList}" begin="0" end="0" var="data" varStatus="status">
								<dl class="first">
									<c:if test="${data.IMAGE_PATH == null}">
										<c:if test="${data.IMAGE_PATH_SUB != null}">
											<dd class="realimage"><img src="<%=request.getContextPath()%><c:out value="${data.IMAGE_PATH_SUB}"/>" width="130px" height="85px" alt="이벤트썸네일이미지"/></dd>
										</c:if>
										<c:if test="${data.IMAGE_PATH_SUB == null}">
											<dd class="image"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/default04.gif" width="130px" height="85px" alt="이벤트썸네일이미지"/></dd>
										</c:if>
									</c:if>
									<c:if test="${data.IMAGE_PATH !=null}">
									<dd class="realimage"><img src="<%=request.getContextPath()%><c:out value='${data.IMAGE_PATH}'/>" alt="이벤트썸네일이미지" width="130px" height="85px"/></dd>
									</c:if>
									<dt id='evShare<c:out value="${status.index}"/>'><a href="#link" style="cursor:pointer;" onclick="javascript:viewEvent('<c:out value="${data.EVENT_SEQ}"/>')">[<c:out value="${data.CATEGORY_NM}"/>] <c:out value="${data.TITLE}"/></a></dt>
									<dd class="tpo"><c:out value="${data.START_DATE}"/> ~ <c:out value="${data.END_DATE}"/> | <c:out value="${data.START_TIME}"/> ~ <c:out value="${data.END_TIME}"/> | <c:out value="${data.PLACE_BUILDING}"/></dd>
									<dd class="desc"><a href="#link" style="cursor:pointer;" onclick="javascript:viewEvent('<c:out value="${data.EVENT_SEQ}"/>')"><c:out value="${data.CONTENTS}" escapeXml="false"/></a></dd>								
									<dd class="more"><a href="#link" style="cursor:pointer;" onclick="javascript:shareSnsLink('twitter','<c:out value="${status.index}"/>','<c:out value="${data.TARGET_LINK}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_twitter3.gif" alt="to Twitter" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:addSchedule('<c:out value="${data.EVENT_SEQ}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_googleplus3.gif" alt="to Google+" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:shareSnsLink('facebook','<c:out value="${status.index}"/>','<c:out value="${data.TARGET_LINK}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_facebook3.gif" alt="to Facebook" /></a><br />
								</dl>
							</c:forEach>
							<c:forEach  items="${eventList}" begin="1" var="data" varStatus="status">
								<dl>
									<c:if test="${data.IMAGE_PATH == null}">
										<c:if test="${data.IMAGE_PATH_SUB != null}">
											<dd class="realimage"><img src="<%=request.getContextPath()%><c:out value="${data.IMAGE_PATH_SUB}"/>" width="130px" height="85px" alt="이벤트썸네일이미지"/></dd>
										</c:if>
										<c:if test="${data.IMAGE_PATH_SUB == null}">
											<dd class="image"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/default04.gif" width="130px" height="85px" alt="이벤트썸네일이미지"/></dd>
										</c:if>
									</c:if>
									<c:if test="${data.IMAGE_PATH != null}">
									<dd class="realimage"><img src="<%=request.getContextPath()%><c:out value='${data.IMAGE_PATH}'/>" alt="이벤트썸네일이미지"  width="130px" height="85px"/></dd>
									</c:if>
									<dt id='evShare<c:out value="${status.index}"/>'><a href="#link" style="cursor:pointer;" onclick="javascript:viewEvent('<c:out value="${data.EVENT_SEQ}"/>')">[<c:out value="${data.CATEGORY_NM}"/>] <c:out value="${data.TITLE}"/></a></dt>
									<dd class="tpo"><c:out value="${data.EVENT_START_DATE}"/> ~ <c:out value="${data.EVENT_END_DATE}"/> | <c:out value="${data.EVENT_START_TIME}"/> ~ <c:out value="${data.EVENT_END_TIME}"/> | <c:out value="${data.PLACE_BUILDING}"/></dd>
									<dd class="desc"><a href="#link" style="cursor:pointer;" onclick="javascript:viewEvent('<c:out value="${data.EVENT_SEQ}"/>')"><c:out value="${data.CONTENTS}" escapeXml="false"/></a></dd>								
									<dd class="more"><a href="#link" style="cursor:pointer;" onclick="javascript:shareSnsLink('twitter','<c:out value="${status.index}"/>','<c:out value="${data.TARGET_LINK}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_twitter3.gif" alt="to Twitter" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:addSchedule('<c:out value="${data.EVENT_SEQ}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_googleplus3.gif" alt="to Google+" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:shareSnsLink('facebook','<c:out value="${status.index}"/>','<c:out value="${data.TARGET_LINK}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_facebook3.gif" alt="to Facebook" /></a><br />
								</dl>
							</c:forEach>
						</div>
						<!-- eventList// -->
						<c:if test="${newestEvLen != 0 and newestEvLen < totalCount}">
							<div class="btn_more"> <a href="#link" style="cursor:pointer;" onclick="javascript:moreNewEvent(5);"><%=msgs.getString("ev.hnevent.label.more")%></a> </div>
						</c:if>
						</c:if>
					</div>
					<c:if test="${empty eventList}">
						<p><center><span><strong><%=msgs.getString("ev.hnevent.msg.event.noEvent")%></strong></span></center></p>
					</c:if>
					<input type="text" style="width:0px;height:0px;border:none;" id="lastIndexFocus" name="lastIndexFocus" maxlength="0"/><!--더보기이후 포커스 이동대상-->
				</div>
			</div>
			<!-- //Maincontents -->
			<div class="event_Sidebar">
				<div class="event_Sidebarbox first">
					<div id="eventSearch">
						<fieldset>
							<legend>이벤트검색</legend>
							<div class="searchbg">
								<label for="event_search"></label>
								<input name="event_search" type="text" id="event_search" value="<c:out value='${paramMap.SRCH_STR}'/>" />
								<span class="btn"><a href="#link" style="cursor:pointer;" onclick="javascript:retriveEvent(1);"><%=msgs.getString("ev.hnevent.label.eventSearch")%></a></span> </div>
						</fieldset>
					</div>
				</div>
				<div class="event_Sidebarbox">
					<div id="eventCalendar">
						<iframe src="<%=request.getContextPath()%>/event/selectEventCalendar1.hanc?baseDate=<c:out value='${paramMap.SRCH_STD_DATE}'/>" width="210px" height="175px" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" title="calendar"></iframe>
					</div>
				</div>
				<!-- category -->
				<div id="eventCatgory" class="event_Sidebarbox">
					<div class="cate_title"><c:if test="${paramMap.LANG_KND == 'ko'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title1.gif" alt="카테고리별" border="0" /></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title1_en.gif" alt="cagegory" border="0" /></c:if></div>
					<ul>
						<c:forEach  items="${cateEventList}" var="data" varStatus="status">
							<li><a href="#link" onclick="retriveEvent(3,'<c:out value="${data.CATEGORY_SEQ}"/>','<c:out value="${data.CATEGORY_NM}"/>')"><c:out value="${data.CATEGORY_NM}"/><c:out value="${data.CNT}"/></a></li>
						</c:forEach>
					</ul>
				</div>
				<div id="eventOrg" class="event_Sidebarbox">
					<div class="cate_title"><c:if test="${paramMap.LANG_KND == 'ko'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title2.gif" alt="기관별" border="0" /></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title2_en.gif" alt="dept" border="0" /></c:if></div>
					<ul>
						<c:forEach  items="${deptEventList}" var="data" varStatus="status">
							<li><a href="#link" onclick="retriveEvent(4,'<c:out value="${data.DEPT_CODE}"/>')"><c:out value="${data.DEPT_CODE}"/><c:out value="${data.CNT}"/></a></li>
						</c:forEach>
					</ul>
				</div>
				<!-- category// --> 
			</div>
			<!-- // body_R --> 
		</div>
		<!-- // body -->
	</div>
	<!-- //content -->
	<!-- move to eventList -->
	<form action="<%=request.getContextPath()%>/event/selectGuestEventList.hanc" id="eventListFrom" name="eventListFrom" method="post">
		<input type="hidden" id="EVENT_SEQ" name="EVENT_SEQ" value="<c:out value='${paramMap.EVENT_SEQ}'/>"/>
		<input type="hidden" id="PAGE_SIZE" name="PAGE_SIZE" value="<c:out value='${paramMap.PAGE_SIZE}'/>"/>
		<input type="hidden" id="HIST_BACK_TYPE" name="HIST_BACK_TYPE" value="LIST"/>
		<input type="hidden" id="SRCH_STR"  name="SRCH_STR"  value="<c:out value='${paramMap.SRCH_STR}'/>"/><!--검색어-->
		<input type="hidden" id="SRCH_DEPT" name="SRCH_DEPT" value="<c:out value='${paramMap.SRCH_DEPT}'/>"/><!--기관명-->
		<input type="hidden" id="SRCH_CATE" name="SRCH_CATE" value="<c:out value='${paramMap.SRCH_CATE}'/>"/><!--카테고리코드-->
		<input type="hidden" id="SRCH_TYPE" name="SRCH_TYPE" value="<c:out value='${paramMap.SRCH_TYPE}'/>"/><!--검색구분(행사명:기관:카테고리:날자)검색결과 타이틀표시 구분-->
		<input type="hidden" id="SRCH_CATE_NM" name="SRCH_CATE_NM" value="<c:out value='${paramMap.SRCH_CATE_NM}'/>"/><!--카테고리명-->
		<input type="hidden" id="SRCH_STD_DATE" name="SRCH_STD_DATE" value="<c:out value='${paramMap.SRCH_STD_DATE}'/>"/><!--검색시작일-->
		<input type="hidden" id="SRCH_END_DATE" name="SRCH_END_DATE" value="<c:out value='${paramMap.SRCH_END_DATE}'/>"/><!--검색종료일-->
		<input type="hidden" id="SRCH_DATE_DIV" name="SRCH_DATE_DIV" value="<c:out value='${paramMap.SRCH_DATE_DIV}'/>"/><!--일 주 월 구분-->
	</form> 
	<!-- //move to eventList -->
</body>
</html>