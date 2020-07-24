<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.google.gdata.client.*"%> 
<%@ page import="com.google.gdata.client.calendar.*"%>
<%@ page import="com.google.gdata.client.calendar.CalendarService"%>
<%@ page import="com.google.gdata.data.acl.*"%> 
<%@ page import="com.google.gdata.data.*"%> 
<%@ page import="com.google.gdata.data.calendar.*"%> 
<%@ page import="com.google.gdata.data.extensions.*"%>
<%@ page import="com.google.gdata.util.*"%> 
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.lang.Exception"%>
<%@ page import="com.saltware.enhancer.event.service.EventVO" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
<title>구글일정추가</title>
<link href="<%=request.getContextPath()%>/hancer/css/event/core_popup.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<strong>기다려 주십시요...</strong>
<%
	try
	{
	//AuthSub Token 유무 검사 
	String token = (String)session.getAttribute("gAuthToken");
	if(token == null || "".equals(token)){
		String singleUseToken =  com.google.gdata.client.http.AuthSubUtil.getTokenFromReply(request.getQueryString());
		String sessionToken =  com.google.gdata.client.http.AuthSubUtil.exchangeForSessionToken(URLDecoder.decode(singleUseToken, "UTF-8"), null);
		session.setAttribute("gAuthToken",sessionToken);
		token = sessionToken;
	}
	
	//캘린터에 추가할 이벤트 정보
	EventVO eventVO = (com.saltware.enhancer.event.service.EventVO)request.getAttribute("eventVO");
	String langKnd = (String)(((Map)request.getAttribute("paramMap")).get("LANG_KND"));
	String title = ""; //이벤트 제목
	String place = ""; //이벤트 장소
	String memo  = ""; //이벤트 내용
	String stdDate = eventVO.getSTART_DATE1();	//이벤트 시작일
	String stdTimeDb = eventVO.getSTART_TIME();  //이벤트시작시간
	String endTimeDb = eventVO.getEND_TIME();	//이벤트 종료시간
	
	if(langKnd.equals("ko")){
		title = eventVO.getTITLE_KOR();
		place = eventVO.getPLACE_BUILDING_KOR();
		memo  = eventVO.getCONTENTS_KOR();
	}
	if(langKnd.equals("en")){
		title = eventVO.getTITLE_ENG();
		place = eventVO.getPLACE_BUILDING_ENG();
		memo  = eventVO.getCONTENTS_ENG();
	}
	
	//이벤트 등록용 클래스 정의
	EventEntry myEntry = new EventEntry();
	myEntry.setTitle(new PlainTextConstruct(title)); 
	myEntry.setContent(new PlainTextConstruct(memo)); 

	// 시작 , 종료 일시를 DateTime 형태 오브젝트로 설정
	String[] arrStdDate = stdDate.split("/");
	String eventStart = arrStdDate[0]+"-"+arrStdDate[1]+"-"+arrStdDate[2]+"T"+stdTimeDb+":00";
	String eventEnd   = arrStdDate[0]+"-"+arrStdDate[1]+"-"+arrStdDate[2]+"T"+endTimeDb+":00";
	DateTime startTime = DateTime.parseDateTime(eventStart); 
	DateTime endTime = DateTime.parseDateTime(eventEnd);
	
	// 시작 , 종료 일시를 When 형태 오브젝트에 대입해 이벤트 클래스에 추가
	When eventTimes = new When();
	eventTimes.setStartTime(startTime);
	eventTimes.setEndTime(endTime);
	myEntry.addTime(eventTimes);

	// 장소를 Where 형태 오브젝트에 대입해 이벤트 클래스에 추가
	Where evLocation = new Where();
	evLocation.setValueString(place);
	myEntry.addLocation(evLocation);

	//구글 캘린터 서비스 생성
	CalendarService calendarService = new CalendarService("google-ExampleApp-v1.0");
	calendarService.setAuthSubToken(token, null);

	//구글캘린더 서비스 URL 설정
	URL postUrl = new URL("http://www.google.com/calendar/feeds/default/private/full");
	
	// 스케줄 추가
	EventEntry insertedEntry = calendarService.insert(postUrl, myEntry);
%>
	<script type="text/javascript">
		<!--	
		//alert("일정에 추가 되었습니다.");
		location.href = "https://www.google.com/calendar/";
		//-->
	</script>
<%
	}catch(Exception e){
		String msg = e.toString();
%>
	<script type="text/javascript">
		<!--
		alert("일정에 추가 중 오류가 발생하였습니다.\n다시 시도해 주십시요.");	
		self.close();
		//-->
	</script>
<%
	}
%>
</body>
</html>