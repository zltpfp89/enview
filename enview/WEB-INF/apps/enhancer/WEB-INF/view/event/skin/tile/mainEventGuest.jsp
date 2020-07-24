<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %> 
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@ page import="com.saltware.enhancer.event.service.EventUserListVO" %>
<%
 String langKnd = "ko";
 MultiResourceBundle msgs = null;
 msgs = EnviewMultiResourceManager.getInstance().getBundle(langKnd);
 String token = (String)session.getAttribute("gAuthToken");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>행사 이벤트 메인</title>
<link href="<%=request.getContextPath()%>/hancer/css/event/cssbasic.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/hancer/css/event/core_top.css" rel="stylesheet" type="text/css" />
<%
	List mainEvObj = (List<com.saltware.enhancer.event.service.EventUserListVO>)request.getAttribute("mainEventList");
	List newestEvObj = (List<com.saltware.enhancer.event.service.EventUserListVO>)request.getAttribute("newestEventList");
	int len = mainEvObj.size();
	int lenNew = newestEvObj.size();
	request.setAttribute("mainEvLen",len);
	request.setAttribute("newestEvLen",lenNew);
%>

<script type="text/javascript">
<!--
	var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
	var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+'/hancer';
	var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+'/event';
	var mainEvLen = '<c:out value="${mainEvLen}" />';
	var rollingIdx = 1;

	//화면초기화
	function initEventMain(){
		//주요이벤트 오늘 날짜 셋팅
		var now = new Date();
	    var year= now.getFullYear();
	    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
	 	document.getElementById("today").innerHTML ="<div>"+ mon+"/"+day+"</div>";

		//더보기 후 포커스 하단으로 이동
		if('<c:out value="${newestEvLen}"/>' > 5){
			document.getElementById("lastIndexFocus").focus();
			document.getElementById("lastIndexFocus").disabled = true;
		}
	}
	var tid = setInterval('rollingEvent()',2000);

	//주요이벤트 Rolling
	function rollingEvent(){
		if(mainEvLen > 0){
			changeMainEvent(rollingIdx,'rolling');
			if(rollingIdx == mainEvLen) rollingIdx = 0;
			rollingIdx++;
	 	}
	}

	//번호클릭시 주요이벤트 디스플레이 변경
 	function changeMainEvent(idx,changeType){
		if(changeType == 'click')
			clearInterval(tid);

		for (var i = 1; i < eval(mainEvLen)+1; i++) {
			document.getElementById("mainEvent"+i).style.display = "none";
			document.getElementById("eventNum"+i).src = resPath+"/img/event/event_num0"+i+".gif";
		}
		document.getElementById("mainEvent"+idx).style.display = "block";
		document.getElementById("eventNum"+idx).src = resPath+"/img/event/event_num0"+idx+"_on.gif";
	}
	
	//더보기버튼 클릭시 5건씩 리스트에 추가
	var dispCnt = '<c:out value="${paramMap.PAGE_SIZE}"/>';
	function moreNewEvent(n){
		dispCnt = eval(dispCnt) + eval(n);
		document.getElementById("PAGE_SIZE").value = dispCnt;
		document.getElementById("eventListFrom").action = actPath+"/mainEventGuest.hanc";
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
			break;
		case 2://날짜선택
			document.getElementById("SRCH_STD_DATE").value = val;
			document.getElementById("SRCH_END_DATE").value = val;
			document.getElementById("SRCH_TYPE").value = "D";
			break;
		case 3://카테고리별
			document.getElementById("SRCH_CATE").value = val;
			document.getElementById("SRCH_CATE_NM").value = val2;
			document.getElementById("SRCH_TYPE").value = "C";
			break;
		case 4://기관별
			document.getElementById("SRCH_DEPT").value = val;
			document.getElementById("SRCH_TYPE").value = "O";
			break;
		default:
			break;
		}
		document.getElementById("PAGE_SIZE").value = "";
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
			url = 'https://www.google.com/accounts/AuthSubRequest?next='+ siteUrl + '/event/selectGoogleAddEvent.hanc?EVENT_SEQ='+seq+'&scope=http://www.google.com/calendar/feeds/&secure=0&session=1';
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
		
		var winObj = window.open(url, target, option);
		if (winObj){
			winObj.focus();    
		} 
	}
//-->
</script>
</head>
<body onload="initEventMain()">
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
				<!-- 주요이벤트 -->
				<div id="eventMain">
					<div class="eventTitle"> <c:if test="${paramMap.LANG_KND == 'ko'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/event_title.gif"alt="주요이벤트" /></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/event_title_en.gif"alt="major" /></c:if> <span class="eventToday" id="today"></span> </div>
					<div class="content">
						<c:if test="${!empty mainEventList}">
						<c:forEach  items="${mainEventList}" var="data" varStatus="status">
							<dl id="mainEvent<c:out value="${status.count}"/>" style="display: none;">
								<c:if test="${data.IMAGE_PATH == null}">
									<c:if test="${data.IMAGE_PATH_SUB != null}">
										<dd class="realimage"><img src="<%=request.getContextPath()%><c:out value="${data.IMAGE_PATH_SUB}"/>" width="300px" height="180px" alt="이벤트썸네일이미지"/></dd>
									</c:if>
									<c:if test="${data.IMAGE_PATH_SUB == null}">
										<dd class="image"></dd>
									</c:if>
								</c:if>
								<c:if test="${data.IMAGE_PATH != null}">
								<dd class="realimage"><img src="<%=request.getContextPath()%><c:out value="${data.IMAGE_PATH}"/>" width="300px" height="180px" alt="이벤트썸네일이미지"/></dd>
								</c:if>
								<dt class="title"><a href="#link" style="cursor:pointer;" onclick="javascript:viewEvent('<c:out value="${data.EVENT_SEQ}"/>')"><c:out value="${data.TITLE}"/></a></dt>
								<dd class="date"><c:out value="${data.EVENT_START_DATE}"/> ~ <c:out value="${data.EVENT_END_DATE}"/> | <c:out value="${data.EVENT_START_TIME}"/> ~ <c:out value="${data.EVENT_END_TIME}"/></dd>
								<dd class="place"><c:out value="${data.PLACE_BUILDING}"/></dd>
								<dd class="desc"><a href="#link" style="cursor:pointer;" onclick="javascript:viewEvent('<c:out value="${data.EVENT_SEQ}"/>')"><c:out value="${data.CONTENTS}" escapeXml="false"/></a></dd>
								<dd class="more"><a href="#link" style="cursor:pointer;" onclick="javascript:viewEvent('<c:out value="${data.EVENT_SEQ}"/>')"><%=msgs.getString("ev.hnevent.label.detail")%></a></dd>
							</dl>
						</c:forEach>
						<div id="eventMainnum">
							<ul>
							<c:forEach  items="${mainEventList}" var="data" varStatus="status">
								<c:if test="${status.count == 1}">
									<li class="first"><img id="eventNum<c:out value="${status.count}"/>" src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/event_num0<c:out value="${status.count}"/>_on.gif" alt="num<c:out value="${status.count}"/>" onclick="changeMainEvent(<c:out value="${status.count}"/>,'click')" /></li>
								</c:if>
								<c:if test="${1 < status.count}"><!--max7-->
									<li><img id="eventNum<c:out value="${status.count}"/>" src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/event_num0<c:out value="${status.count}"/>.gif" alt="num<c:out value="${status.count}"/>" onclick="changeMainEvent(<c:out value="${status.count}"/>,'click')"/></li>
								</c:if>
							</c:forEach>
							</ul>
						</div>
						</c:if>
						<c:if test="${empty mainEventList}">
							<p><center><span><strong><%=msgs.getString("ev.hnevent.msg.event.noEvent")%></strong></span></center></p>
						</c:if>
					</div>
				</div>
				<!-- 주요이벤트// --> 
				<!-- 최신이벤트 -->
				<div class="latestEvent_box">
					<div class="title"><c:if test="${paramMap.LANG_KND == 'ko'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/latestevent_title.gif"alt="최신이벤트" /></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/latestevent_title_en.gif"alt="new_event" /></c:if></div>
					<!-- eventList -->
					<c:if test="${!empty newestEventList}">
					<div class="event_list" id="event_list">
						<c:forEach  items="${newestEventList}" begin="0" end="0" var="data" varStatus="status">
							<dl class="first">
								<c:if test="${data.IMAGE_PATH == null}">
									<c:if test="${data.IMAGE_PATH_SUB != null}">
										<dd class="realimage"><img src="<%=request.getContextPath()%><c:out value="${data.IMAGE_PATH_SUB}"/>" width="130px" height="85px" alt="이벤트썸네일이미지"/></dd>
									</c:if>
									<c:if test="${data.IMAGE_PATH_SUB == null}">
										<dd class="image"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/default04.gif" width="130px" height="85px" alt="이벤트썸네일이미지"/></dd>
									</c:if>
								</c:if>
								<c:if test="${data.IMAGE_PATH != null}">
								<dd class="realimage"><img src="<%=request.getContextPath()%><c:out value="${data.IMAGE_PATH}"/>" width="130px" height="85px" alt="이벤트썸네일이미지"/></dd>
								</c:if>
								<dt id='evShare<c:out value="${status.index}"/>'><a href="#link" style="cursor:pointer;" onclick="javascript:viewEvent('<c:out value="${data.EVENT_SEQ}"/>')">[<c:out value="${data.CATEGORY_NM}"/>] <c:out value="${data.TITLE}"/></a></dt>
								<dd class="tpo"><c:out value="${data.START_DATE}"/> ~ <c:out value="${data.END_DATE}"/> | <c:out value="${data.START_TIME}"/> ~ <c:out value="${data.END_TIME}"/> | <c:out value="${data.PLACE_BUILDING}"/></dd>
								<dd class="desc" style="overflow:hidden;"><a href="#link" style="cursor:pointer;" onclick="javascript:viewEvent('<c:out value="${data.EVENT_SEQ}"/>')"><c:out value="${data.CONTENTS}" escapeXml="false"/></a></dd>								
								<dd class="more"><a href="#link" style="cursor:pointer;" onclick="javascript:shareSnsLink('twitter','<c:out value="${status.index}"/>','<c:out value="${data.TARGET_LINK}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_twitter3.gif" alt="to Twitter" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:addSchedule('<c:out value="${data.EVENT_SEQ}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_googleplus3.gif" alt="to Google+" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:shareSnsLink('facebook','<c:out value="${status.index}"/>','<c:out value="${data.TARGET_LINK}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_facebook3.gif" alt="to Facebook" /></a><br />
									<c:if test="${data.CATEGORY_SEQ != '9'}"><a href="#link" style="cursor:pointer;" onclick="javascript:applyEvent(<c:out value="${data.EVENT_SEQ}"/>);"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_imgoing3.gif"alt="I'M GOING" /></a></c:if></dd>
							</dl>
						</c:forEach>
						<c:forEach  items="${newestEventList}" begin="1" var="data" varStatus="status">
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
								<dd class="realimage"><img src="<%=request.getContextPath()%><c:out value="${data.IMAGE_PATH}"/>" width="130px" height="85px" alt="이벤트썸네일이미지" class="realimage"/></dd>
								</c:if>
								<dt id='evShare<c:out value="${status.index}"/>'><a href="#link" style="cursor:pointer;" onclick="javascript:viewEvent('<c:out value="${data.EVENT_SEQ}"/>')">[<c:out value="${data.CATEGORY_NM}"/>] <c:out value="${data.TITLE}"/></a></dt>
								<dd class="tpo"><c:out value="${data.START_DATE}"/> ~ <c:out value="${data.END_DATE}"/> | <c:out value="${data.START_TIME}"/> ~ <c:out value="${data.END_TIME}"/> | <c:out value="${data.PLACE_BUILDING}"/></dd>
								<dd class="desc"><a href="#link" style="cursor:pointer;" onclick="javascript:viewEvent('<c:out value="${data.EVENT_SEQ}"/>')"><c:out value="${data.CONTENTS}" escapeXml="false"/></a></dd>								
								<dd class="more"><a href="#link" style="cursor:pointer;" onclick="javascript:shareSnsLink('twitter','<c:out value="${status.index}"/>','<c:out value="${data.TARGET_LINK}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_twitter3.gif" alt="to Twitter" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:addSchedule('<c:out value="${data.EVENT_SEQ}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_googleplus3.gif" alt="to Google+" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:shareSnsLink('facebook','<c:out value="${status.index}"/>','<c:out value="${data.TARGET_LINK}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_facebook3.gif" alt="to Facebook" /></a><br />
									<c:if test="${data.CATEGORY_SEQ != '9'}"><a href="#link" style="cursor:pointer;" onclick="javascript:applyEvent(<c:out value="${data.EVENT_SEQ}"/>);"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_imgoing3.gif"alt="I'M GOING" /></a></c:if></dd>
							</dl>
						</c:forEach>
					</div>
					<!-- eventList// -->
						<c:if test="${newestEvLen != 0 and newestEvLen < totalCount}">
							<div class="btn_more"> <a href="#link" style="cursor:pointer;" onclick="javascript:moreNewEvent(5);"><%=msgs.getString("ev.hnevent.label.more")%></a> </div>
						</c:if>
					</c:if>
					<c:if test="${empty newestEventList}">
						<p><center><span><strong><%=msgs.getString("ev.hnevent.msg.event.noEvent")%></strong></span></center></p>
					</c:if>
					<input type="text" style="width:0px;height:0px;border:none;" id="lastIndexFocus" name="lastIndexFocus" maxlength="0"/><!--더보기이후 포커스 이동대상-->
				</div>
				<!-- 최신이벤트// --> 
			</div>
			<!-- //Maincontents -->
			<div class="event_Sidebar">
				<div class="event_Sidebarbox first">
					<div id="eventSearch">
						<fieldset>
							<legend>이벤트검색</legend>
							<div class="searchbg">
								<label for="event_search"></label>
								<input name="event_search" type="text" id="event_search" value="<c:out value="${paramMap.SRCH_STR}"/>" />
								<span class="btn"><a href="#link" style="cursor:pointer;" onclick="javascript:retriveEvent(1);"><%=msgs.getString("ev.hnevent.label.eventSearch")%></a></span> </div>
						</fieldset>
					</div>
				</div>
				<div class="event_Sidebarbox">
					<div id="eventCalendar">
						<iframe src="<%=request.getContextPath()%>/event/selectEventCalendar1.hanc" width="210px" height="175px" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" title="event frame"></iframe>
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
		<input type="hidden" id="HIST_BACK_TYPE" name="HIST_BACK_TYPE" value="MAIN"/>
		<input type="hidden" id="SRCH_STR" name="SRCH_STR" value=""/>
		<input type="hidden" id="SRCH_STD_DATE" name="SRCH_STD_DATE" value=""/>
		<input type="hidden" id="SRCH_END_DATE" name="SRCH_END_DATE" value=""/>
		<input type="hidden" id="SRCH_DATE_DIV" name="SRCH_DATE_DIV" value="D"/>
		<input type="hidden" id="SRCH_CATE" name="SRCH_CATE" value=""/>
		<input type="hidden" id="SRCH_CATE_NM" name="SRCH_CATE_NM" value=""/>
		<input type="hidden" id="SRCH_DEPT" name="SRCH_DEPT" value=""/>
		<input type="hidden" id="SRCH_TYPE" name="SRCH_TYPE" value=""/>
	</form> 
	<!-- //move to eventList -->
</body>
</html>
