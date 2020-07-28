<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enhancer.event.service.EventVO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %> 
<%@ page import="com.saltware.enview.Enview" %> 
<%
 Map userInfoMap = null;
 userInfoMap = EnviewSSOManager.getUserInfoMap(request);
 String langKnd = (String)userInfoMap.get("lang_knd");
 MultiResourceBundle msgs = null;
 msgs = EnviewMultiResourceManager.getInstance().getBundle(langKnd);
 String token = (String)session.getAttribute("gAuthToken");

 String flag = "Y";
 request.setAttribute("menuAuth",flag);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
<title>이벤트 상세보기</title>
<link href="<%=request.getContextPath()%>/hancer/css/event/cssbasic.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
	var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+'/hancer';	 // 리소스루트
	var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+'/event';    // 컨텍스트루트	
	var eventSeq = '<c:out value="${explEvent.EVENT_SEQ}"/>';					     // 이벤트SEQ
	var hisBackType = '<c:out value="${paramMap.HIST_BACK_TYPE}"/>';				 // 되돌아갈 화면

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
					var frm = document.getElementById("eventListFrom");
					frm.action = actPath+"/detailEvent.hanc?EVENT_SEQ="+eventSeq;
					frm.submit();
			   }, 
			   error: function(request, status, error){
					alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
			   }
			}); 
		}
	}
	
	//이벤트목록페이지로 이동
	function retriveEvent(knd,val,val2){
		var frm = document.getElementById("eventListFrom");
		switch (knd) {
		case 3://카테고리별
			document.getElementById("SRCH_CATE").value = val;
			document.getElementById("SRCH_CATE_NM").value = val2;
			document.getElementById("SRCH_TYPE").value = "C";
			document.getElementById("SRCH_STR").value = "";
			document.getElementById("SRCH_DEPT").value = "";
			document.getElementById("SRCH_STD_DATE").value = "";
			document.getElementById("SRCH_END_DATE").value = "";
			document.getElementById("SRCH_DATE_DIV").value = "D";
			break;
		case 4://기관별
			document.getElementById("SRCH_DEPT").value = val;
			document.getElementById("SRCH_TYPE").value = "O";
			document.getElementById("SRCH_STR").value = "";
			document.getElementById("SRCH_CATE").value = "";
			document.getElementById("SRCH_STD_DATE").value = "";
			document.getElementById("SRCH_END_DATE").value = "";
			document.getElementById("SRCH_DATE_DIV").value = "D";
			break;
		default:
			break;
		}
		frm.action = actPath+"/selectEventList.hanc";
		frm.target = "";
		frm.submit();
	}
	//파일다운로드
	function downLoadFile(fileNm,fileMask){
		document.getElementById("fileMask").value = fileMask;
		document.getElementById("fileName").value = fileNm;
		var frm = document.getElementById("eventListFrom");
		frm.action = actPath+"/fileMgr?cmd=down";
		frm.target = "invisible";
		frm.submit();
	}
	
	//문자열 개수(byte체크) : 댓글길이체크
	function LengthCheck(message) {
		var nbytes = 0;

		for (i=0; i<message.length; i++) {
			var ch = message.charAt(i);
			if (escape(ch).length > 4) {
				nbytes += 2;
			} else if (ch != '\r') {
				nbytes++;
			}
		}
		return nbytes;
	}

	//댓글작성
	function saveReply(){
		var replyCntt = document.getElementById("comment");
		if(LengthCheck(replyCntt.value) > 500){
			alert('<%=msgs.getString("ev.hnevent.msg.event.insertReply")%>');
			replyCntt.focus();
			return;
		}else{
			$.ajax({ 
			   type: "POST", 
			   url: actPath+"/insertComment.hanc", 
			   data: "EVENT_REPLY="+replyCntt.value+"&EVENT_SEQ="+eventSeq,
			   dataType:"json",
			   success: function(data){ 
					var msg = data.errorMsg;
					if(msg == 'NoError'){
						var frm = document.getElementById("eventListFrom");
						frm.action = actPath+"/detailEvent.hanc?EVENT_SEQ="+eventSeq;
						frm.submit();
					}else{
						alert(msg);
					}
			   }, 
			   error: function(request, status, error) {
					alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
			   }
			}); 
		}
	}

	//본인댓글 삭제
	function deleteReply(evSeq,reSeq){
		if(confirm('<%=msgs.getString("ev.hnevent.msg.event.delete")%>')){
			$.ajax({ 
			   type: "POST", 
			   url: actPath+"/deleteCommentEvent.hanc", 
			   data: "REPLY_SEQ="+reSeq+"&EVENT_SEQ="+evSeq,
			   dataType:"text",
			   success: function(data){ 
					alert(data);
					var frm = document.getElementById("eventListFrom");
					frm.action = actPath+"/detailEvent.hanc?EVENT_SEQ="+eventSeq;
					frm.submit();
			   }, 
			   error: function(request, status, error) {
					alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
			   }
			}); 
		}
	}

	//이전화면으으로 돌아가기(Main OR List)
	function backToList(){
		var frm = document.getElementById("eventListFrom");
		if(hisBackType == 'MAIN'){
			frm.action = actPath+"/selectMainEventList.hanc";
		}
		if(hisBackType == 'LIST'){
			frm.action = actPath+"/selectEventList.hanc";
		}
		frm.target = "";
		frm.submit();
	}

	//SNS링크 공유
	function shareSnsLink(type, langKnd, linkUrl){ 
		var width = 1000;
		var hdight = 0;
		var url = "";
		var title = (document.getElementById("eventTitle").textContent)?document.getElementById("eventTitle").textContent : document.getElementById("eventTitle").innerText;

		//트위터 공유 url,link 설정
		if(type == "twitter"){
			url = "http://twitter.com/home?status=" + encodeURIComponent(title) + " " + encodeURIComponent(linkUrl);   
			hdight = 320;
		}
		//페이스북 공유 url,link 설정
		if(type == "facebook"){
			/*href = 'http://www.hancbook.com/sharer.php?s=100&p[url]='+encodeURIComponent(url)+'&p[title]='+encodeURIComponent(titleKor)+'&p[summary]='+encodeURIComponent(content);*/
			url = 'http://www.hancbook.com/sharer.php?s=100&p[url]='+encodeURIComponent(linkUrl)+'&p[title]='+encodeURIComponent(title); 
			hdight = 570;
		}
		openWinCenter(url, "", width, hdight);
	}
	
	//구글켈린더에 일정추가
	/*function addSchedule(seq){
		alert("서비스 업데이트 중입니다.\n사용에 불편을 드려 죄송합니다.");return;
		var sUrl = actPath+"/selectGoogleAddEvent.hanc?EVENT_SEQ="+seq;
		var sOption = "width=680, height=300, scrollbars=no, resizable=no";
		openWinCenter(sUrl, "", 680, 300);
	}
	*/
	function addSchedule(seq){
		var url = '';
		var siteUrl ='';
		if('<%=token%>'==null || '<%=token%>'=='null' || '<%=token%>'=='' || '<%=token%>'=='undefined')
			url = 'https://www.google.com/accounts/AuthSubRequest?next=' + siteUrl + '/enview/event/selectGoogleAddEvent.hanc?EVENT_SEQ='+seq+'&scope=http://www.google.com/calendar/feeds/&secure=0&session=1';
		if('<%=token%>'!=null && '<%=token%>'!='null' && '<%=token%>'!='' && '<%=token%>'!='undefined')
			url = siteUrl + '/enview/event/selectGoogleAddEvent.hanc?EVENT_SEQ='+seq;
		
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
	
	//프린트
	function printLayer () { 
		if(document.all && window.print){ 
			window.print(); 
		} 
    } 

	//이메일추천
	function recomendEmail(eventSeq){
		var sUrl = actPath+"/recommeMailEvent.hanc?EVENT_SEQ="+eventSeq;
		openWinCenter(sUrl, "", 560, 220);
	}

	//정보더보기 링크
	function moreInfo(linkUrl){
		var regexp=/http:\/\//ig;
		var index = linkUrl.search(regexp);
		if(index == 0){
			window.open(linkUrl);
		}	
		else{
			alert("URL형식이 잘못되었습니다.");
			return;
		}
	}
	
	function modifyEvent(seq){
		var frm = document.getElementById("setTransfer");
		document.getElementById("mngMode").value = "MODIFY";
		document.getElementById("EVENT_SEQ").value = seq;
		document.getElementById("studentYn").value = 'N';//2012.01.16이벤트관리 메뉴오픈으로 수정
		frm.action = actPath +"/insertEventByUser.hanc";
		frm.submit();
	}
	
</script>
</head>
<body>
	<div id="content"> 
		<div id="body">
			<div class="event_Maincontents">
				<!-- Maincontents -->
				<div class="latestEvent_box">
					<!-- 이벤트뷰 -->
					<div class="event_view">
						<div class="article_head">
							<div class="title" id="eventTitle"><c:if test="${paramMap.LANG_KND == 'ko'}"><c:out value="${explEvent.TITLE_KOR}"/></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><c:out value="${explEvent.TITLE_ENG}"/></c:if></div>
							<div class="tpo"><c:if test="${paramMap.LANG_KND == 'ko'}"><c:out value="${explEvent.PLACE_BUILDING_KOR}"/> <c:out value="${explEvent.PLACE_NM}"/></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><c:out value="${explEvent.PLACE_BUILDING_ENG}"/> <c:out value="${explEvent.PLACE_NM}"/></c:if> | <c:out value="${explEvent.EVENT_START_DATE1}"/> ~ <c:out value="${explEvent.EVENT_END_DATE1}"/> | <c:out value="${explEvent.EVENT_START_TIME}"/> ~ <c:out value="${explEvent.EVENT_END_TIME}"/></div>
							<div class="btn"><a href="#link" style="cursor:pointer;" onclick="javascript:backToList();"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_pre_event.gif"alt="back" /></a><c:if test="${explEvent.CATEGORY_SEQ != '9'}"><a href="#link" style="cursor:pointer;" onclick="javascript:applyEvent(<c:out value='${explEvent.EVENT_SEQ}'/>);"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_imgoing2.gif"alt="I'M GOING" /></a></c:if></div>
						</div>
						<div class="article_body">
							<div class="content">
								<c:if test="${paramMap.LANG_KND == 'ko'}">
									<c:if test="${explEvent.IMAGE_PATH_KOR != null}">
										<div><img src="<%=request.getContextPath()%><c:out value="${explEvent.IMAGE_PATH_KOR}"/>" alt="event image" class="content_img"></div>
									</c:if>
									<c:if test="${explEvent.IMAGE_PATH_KOR == null}">
										<c:if test="${explEvent.IMAGE_PATH_ENG != null}">
											<div><img src="<%=request.getContextPath()%><c:out value="${explEvent.IMAGE_PATH_ENG}"/>" alt="event image" class="content_img"></div>
										</c:if>
										<c:if test="${explEvent.IMAGE_PATH_ENG == null}">
											<div><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/default01.gif" alt="이벤트이미지" class="content_img"></div>
										</c:if>
									</c:if>
								</c:if>
								<c:if test="${paramMap.LANG_KND == 'en'}">
									<c:if test="${explEvent.IMAGE_PATH_ENG != null}">
										<div><img src="<%=request.getContextPath()%><c:out value="${explEvent.IMAGE_PATH_ENG}"/>" alt="event image" class="content_img"></div>
									</c:if>
									<c:if test="${explEvent.IMAGE_PATH_ENG == null}">
										<c:if test="${explEvent.IMAGE_PATH_KOR != null}">
											<div><img src="<%=request.getContextPath()%><c:out value="${explEvent.IMAGE_PATH_KOR}"/>" alt="event image" class="content_img"></div>
										</c:if>
										<c:if test="${explEvent.IMAGE_PATH_KOR == null}">
											<div><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/default01_en.gif" alt="event image" class="content_img"></div>
										</c:if>
									</c:if>
								</c:if>
								<div class="content_txt"><c:if test="${paramMap.LANG_KND == 'ko'}"><c:out value="${explEvent.CONTENTS_KOR}" escapeXml="false"/></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><c:out value="${explEvent.CONTENTS_ENG}" escapeXml="false"/></c:if></div>
							</div>
							<div class="btn right"><a href="#link" style="cursor:pointer;" onclick="javascript:shareSnsLink('twitter','<c:out value="${paramMap.LANG_KND}"/>','<c:out value="${explEvent.TARGET_LINK}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_twitter3.gif" alt="to Twitter" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:addSchedule('<c:out value="${explEvent.EVENT_SEQ}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_googleplus3.gif" alt="to Google+" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:shareSnsLink('facebook','<c:out value="${paramMap.LANG_KND}"/>','<c:out value="${explEvent.TARGET_LINK}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_facebook3.gif" alt="to Facebook" /></a> <a href="javascript:recomendEmail('<c:out value="${explEvent.EVENT_SEQ}"/>');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_mail.gif" alt="to Email" /></a> <a href="#link" style="cursor:pointer;" onclick="javascript:printLayer();"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_print.gif" alt="print" /></a></div>

							<div class="detail">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabletype3" summary="현재 이벤트 페이지의 자세한 정보입니다.">
									<caption></caption>
									<colgroup>
										<col width="15%" />
										<col width="15%" />
										<col width="15%" />
										<col width="*" />
									</colgroup>
									<tr>
										<th scope="row"><%=msgs.getString("ev.hnevent.label.category")%></th>
										<td><c:out value="${explEvent.CATEGORY_NM}"/></td>
										<th scope="row"><%=msgs.getString("ev.hnevent.label.relDoc")%></th>
										<td>
											<c:forEach  items="${attachFileList}" var="data" varStatus="status">											
												<a href="#link" style="cursor:pointer;" onclick="javascript:downLoadFile('<c:out value="${data.FILE_NM}"/>','<c:out value="${data.FILE_MASK}"/>');"><c:out value="${data.FILE_NM}"/></a><c:if test="${!status.last}">,</c:if>
											</c:forEach>&nbsp;
										</td>
									</tr>
									<tr>
										<th scope="row"><%=msgs.getString("ev.hnevent.label.webSite")%></th>
										<td><a href="#link" onclick="moreInfo('<c:out value="${explEvent.TARGET_LINK}"/>')">
											<c:if test="${explEvent.TARGET_LINK != 'http://' and explEvent.TARGET_LINK != ''}">
												<c:if test="${!empty explEvent.TARGET_LINK}">
												<span title="'<c:out value="${explEvent.TARGET_LINK}"/>'">click</span>
												</c:if>
											</c:if></a>&nbsp;
										</td>
										<th scope="row"><%=msgs.getString("ev.hnevent.label.where")%></th>
										<td><c:if test="${paramMap.LANG_KND == 'ko'}"><c:out value="${explEvent.PLACE_BUILDING_KOR}"/></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><c:out value="${explEvent.PLACE_BUILDING_ENG}"/></c:if></td>										
									</tr>
									<tr>
										<th scope="row"><%=msgs.getString("ev.hnevent.label.cost")%></th>
										<td><c:if test="${paramMap.LANG_KND == 'ko'}"><c:out value="${explEvent.EVENT_FEE_KOR}"/></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><c:out value="${explEvent.EVENT_FEE_ENG}"/></c:if>&nbsp;</td>
										<th scope="row"><%=msgs.getString("ev.hnevent.label.contact")%></th>
										<td><c:out value="${explEvent.OWNER_USER_ID}"/> / <c:out value="${explEvent.OWNER_PHONE}"/> / <c:out value="${explEvent.OWNER_EMAIL}"/>&nbsp;</td>
									</tr>
								</table>
							</div>
							<c:if test="${myEventUserFlag == 'yes'}">
							<div class="btn right"><span  class="btn_s"><a href="#link" style="cursor:pointer;" onclick="javascript:modifyEvent('<c:out value="${explEvent.EVENT_SEQ}" escapeXml="false"/>');">수정</a></span></div>
							</c:if>
						</div>
						<div class="opinion_list">
							<!-- 댓글작성 --> 
							<fieldset>
								<legend>댓글작성</legend>
								<div class="write">
									<div>
										<label for="comment"></label>
										<textarea name="comment" id="comment"></textarea><input name="" type="button" class="comment" onclick="saveReply();"/>
									</div>
								</div>
							</fieldset>
							<!-- 댓글작성// -->
							<!-- 댓글리스트 -->
							<div class="list" id="reply_list">
								<ul>
								<c:forEach  items="${replyList}" var="data" varStatus="status">
									<li>
										<dl>
											<dt><c:out value="${data.USER_KR_NM}"/></dt>
											<dd>&nbsp;<c:out value="${data.EVENT_REPLY}"/>&nbsp;<c:if test="${paramMap.USER_ID eq data.REG_USER_ID or menuAuth eq 'Y'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_edel.gif" alt="delete" border="0" onclick="deleteReply('<c:out value="${data.EVENT_SEQ}"/>','<c:out value="${data.REPLY_SEQ}"/>')"/></c:if></dd>
										</dl>
									</li>
								</c:forEach>
								</ul>
							</div>
							<!-- 댓글리스트// -->
						</div>
					</div>
					<!-- 이벤트뷰// -->
				</div>
			</div>
			<!-- //Maincontents -->
			<div class="event_Sidebar">
				<div id="peopleGoing" class="event_Sidebarbox">
					<div class="people_title"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/people_title.gif" alt="People Going" border="0" /></div>
					<ul class="people">
						<c:forEach  items="${applyList}" begin="0" end="0" var="data" varStatus="status">
							<li class="first"><c:out value="${data.NAME}"/></li>
						</c:forEach>
						<c:forEach  items="${applyList}" begin="1" var="data" varStatus="status">
							<li><c:out value="${data.NAME}"/></li>
						</c:forEach>
					</ul>
				</div>
				<div id="googleMap" class="event_Sidebarbox">
					<div class="map_title"><c:if test="${paramMap.LANG_KND == 'ko'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/map_title.gif" alt="Google Map" border="0" /></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/map_title_en.gif" alt="Google Map" border="0" /></c:if></div>
					
					<div class="map" style="width:217px; height:240px;"><iframe src="<%=request.getContextPath()%>/event/detailGoogleMapEvent.hanc?LAT=<c:out value="${explEvent.PLACE_LATITUDE}"/>&LON=<c:out value="${explEvent.PLACE_LONGITUDE}"/>" width="100%" height="100%" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" title="google Map"></iframe></div>
				</div>
				<!-- category -->
				<div id="eventCatgory" class="event_Sidebarbox">
					<div class="cate_title"><c:if test="${paramMap.LANG_KND == 'ko'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title1.gif" alt="category" border="0" /></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title1_en.gif" alt="cagegory" border="0" /></c:if></div>
					<ul>
						<c:forEach  items="${cateEventList}" var="data" varStatus="status">
							<li><a href="#link" onclick="retriveEvent(3,'<c:out value="${data.CATEGORY_SEQ}"/>','<c:out value="${data.CATEGORY_NM}"/>')"><c:out value="${data.CATEGORY_NM}"/><c:out value="${data.CNT}"/></a></li>
						</c:forEach>
					</ul>
				</div>
				<div id="eventOrg" class="event_Sidebarbox">
					<div class="cate_title"><c:if test="${paramMap.LANG_KND == 'ko'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title2.gif" alt="organization" border="0" /></c:if><c:if test="${paramMap.LANG_KND == 'en'}"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title2_en.gif" alt="dept" border="0" /></c:if></div>
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
	<form action="" id="eventListFrom" name="eventListFrom" method="post">
		<input type="hidden" id="HIST_BACK_TYPE" name="HIST_BACK_TYPE" value="<c:out value='${paramMap.HIST_BACK_TYPE}'/>"/>
		<input type="hidden" id="fileMask"  name="fileMask"  value=""/>
		<input type="hidden" id="fileName"  name="fileName"  value=""/>
		<input type="hidden" id="SRCH_STR"  name="SRCH_STR"  value="<c:out value='${paramMap.SRCH_STR}'/>"/>
		<input type="hidden" id="SRCH_DEPT" name="SRCH_DEPT" value="<c:out value='${paramMap.SRCH_DEPT}'/>"/>
		<input type="hidden" id="SRCH_CATE" name="SRCH_CATE" value="<c:out value='${paramMap.SRCH_CATE}'/>"/>
		<input type="hidden" id="SRCH_TYPE" name="SRCH_TYPE" value="<c:out value='${paramMap.SRCH_TYPE}'/>"/>
		<input type="hidden" id="SRCH_CATE_NM" name="SRCH_CATE_NM" value="<c:out value='${paramMap.SRCH_CATE_NM}'/>"/>
		<input type="hidden" id="SRCH_STD_DATE" name="SRCH_STD_DATE" value="<c:out value='${paramMap.SRCH_STD_DATE}'/>"/>
		<input type="hidden" id="SRCH_END_DATE" name="SRCH_END_DATE" value="<c:out value='${paramMap.SRCH_END_DATE}'/>"/>
		<input type="hidden" id="SRCH_DATE_DIV" name="SRCH_DATE_DIV" value="<c:out value='${paramMap.SRCH_DATE_DIV}'/>"/>
	</form> 
	<!-- //move to eventList -->
	<form name="setTransfer" id="setTransfer" method="post" action="<%=request.getContextPath()%>/event/selectConfirmEvent.hanc">
		<input type="hidden" id="mngMode" name="mngMode" value=""/>
		<input type="hidden" id="EVENT_SEQ" name="EVENT_SEQ" value=""/>
		<input type="hidden" id="studentYn" name="studentYn" value=""/><!--2012.01.16-->
	</form>
							
	<!-- //iframe Of used by attachFileUpload -->
	<iframe src="<%=request.getContextPath()%>/event/blank.hanc" name="invisible" frameborder="0" width="0" height="0" title="blank"></iframe>
</body>
</html>