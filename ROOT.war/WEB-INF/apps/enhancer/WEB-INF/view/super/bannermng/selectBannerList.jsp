<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld"%>
<%@ page import="java.util.List"%>
<%@ page import="com.saltware.enview.login.LoginConstants"%>

<%@ page import="java.util.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ page import="com.saltware.enview.Enview" %> 

<%
 Map userInfoMap = null;
 userInfoMap = EnviewSSOManager.getUserInfoMap(request);
 String langKnd = (String)userInfoMap.get("lang_knd");
 String saUid = (String)userInfoMap.get("user_id");	   //본인작성글 여부를 판별하기 위해..
 MultiResourceBundle msgs = null;
 msgs = EnviewMultiResourceManager.getInstance().getBundle(langKnd);

 String flag = "Y";
 
 request.setAttribute("menuAuth",flag);	//관리자여부 구분자
 request.setAttribute("saUid",saUid);		//sso로그인 아이디
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>배너승인</title>
	<%-- 
	<link href="<%=request.getContextPath()%>/hancer/css/super/banner/core_approval.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/hancer/css/super/banner/cssbasic.css" rel="stylesheet" type="text/css" /> 
	--%>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/contents.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/banner/objCalendarCtrl.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/jquery-1.4.2.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/json2.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/banner/validUtil.js"></script>
	<%
		List bannerList = (List)request.getAttribute("bannerList");
		int len = bannerList.size();
		request.setAttribute("bannerListLen",len);
	%>
	<script type="text/javascript">
		var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
		var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer";
		var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer/banner";
		var bannerListLen = 0;
		
		//화면초기화
		window.onload=function(){
			maskOn(document.getElementById("REG_FROM").id);
			maskOn(document.getElementById("REG_TO").id);
			
			//이벤트승인리스트 갯수
			var len = '<c:out value="${bannerListLen}" />';
			bannerListLen = len;

			//더보기 후 포커스 하단으로 이동
			document.getElementById("lastIndexFocus").focus();
			document.getElementById("lastIndexFocus").disabled = true;
		}
		
		//배너승인목록 조회
		function srchBannerApprove(){
			
			maskOff(document.getElementById("REG_FROM").id);
			maskOff(document.getElementById("REG_TO").id);			
			var startDate = document.getElementById('REG_FROM').value;
			var endDate = document.getElementById('REG_TO').value;
			//조회기간 유효성체크
			if(trim(startDate) == ""){
				alert('<%=msgs.getString("ev.hnevent.msg.event.enterStdDate")%>');
				this.maskOn(document.getElementById("REG_FROM").id);
				this.maskOn(document.getElementById("REG_TO").id);
				return;
			}
			if(trim(endDate) == ""){
				alert('<%=msgs.getString("ev.hnevent.msg.event.enterEndDate")%>');
				this.maskOn(document.getElementById("REG_FROM").id);
				this.maskOn(document.getElementById("REG_TO").id);
				return;
			}
			if(trim(startDate) != "" && trim(endDate) != ""){
				if(startDate > endDate){
					alert('<%=msgs.getString("ev.hnevent.msg.event.checkPeriod")%>');
					this.maskOn(document.getElementById("REG_FROM").id);
					this.maskOn(document.getElementById("REG_TO").id);
					return;
				}
			}
						
			document.getElementById("setTransfer").submit();
		}
		
		//배너추가
		function addBanner(){
			var frm = document.getElementById("setTransfer");
			maskOff(document.getElementById("REG_FROM").id);
			maskOff(document.getElementById("REG_TO").id);
			frm.action = actPath +"/addViewBanner.hanc";
			frm.submit();			
		}
		
		//배너 승인 및 수정
		function modifyBanner(seq){
			var frm = document.getElementById("setTransfer");
			document.getElementById("mode").value = "MODIFY";
			document.getElementById("BANNER_SEQ").value = seq;

			//배너추가에서 목록으로 복귀를 위한 기간파라미터(2012.01.27)
			maskOff(document.getElementById("REG_FROM").id);
			maskOff(document.getElementById("REG_TO").id);
			frm.action = actPath +"/addViewBanner.hanc";
			frm.submit();	
		}
		
		//배너삭제
		function deleteEvent(){
			//Ajax로 삭제-->PageSize초기화해서Form Refresh
			
			var dataArr = new Array(); 
			var chkCnt = 0;
			var bannerSeq = "";
			for(var i=1; i<eval(bannerListLen)+1; i++){
				if(document.getElementById("chkNo"+i).checked){//선택한 배너만 추출;
					bannerSeq+= (document.getElementById("chkNo"+i).name)+"/";
					chkCnt++;
				}
			}
			if(chkCnt == 0){
				alert('<%=msgs.getString("ev.hnevent.msg.event.noBannerList")%>');
				return;
			}
			
			//선택하지 않은 Row가 null로 들어가는것 처리
			var splitData = bannerSeq.split('/');
			for(var j=0; j<eval(splitData.length)-1; j++){
				var row = {BANNER_SEQ : splitData[j] };
				dataArr[j] = row;
			}

			var jsonStr = dataArr.toJSONString();
			var jsonArray = '{data:'+jsonStr+'}';
			$.ajax({ 
			   type: "POST", 
			   url: actPath+"/deleteMultiBanner.hanc", 
			   data: "data="+jsonArray ,
			   dataType:"text",
			   success: function(msg){ 
					alert(msg);
					location.reload();
			   }, 
			   error: function(request, status, error) {
					alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
							//alert(request.responseText);
						}
					});
		}

		//더보기버튼 클릭시 10건씩 리스트에 추가
		var dispCnt = '<c:out value="${paramMap.PAGE_SIZE}"/>';
		function moreBanner(n) {
			dispCnt = eval(dispCnt) + n;
			document.getElementById("PAGE_NUM").value = "1";
			document.getElementById("PAGE_SIZE").value = dispCnt;
			srchBannerApprove();
		}

		//검색버튼 클릭시 PAGE_SIZE초기화 하여검색
		function srchBannerList() {
			document.getElementById("PAGE_SIZE").value = "10";
			srchBannerApprove();
		}
	</script>
</head>
<body>
	<!-- sub_contents -->
	<div class="sub_contents">
		<!-- detail -->
		<div class="detail">
			<!-- board first -->
			<div class="board first">
				<!-- searchArea-->
				<div class="tsearchArea">
					<!--pageTitle -->
					<h1><%=msgs.getString("ev.hnevent.label.approvalBanner")%></h1>
					<!--pageTitle// -->
				</div>
				<!-- searchArea//-->
				<form name="setTransfer" id="setTransfer" method="post" action="<%=request.getContextPath()%>/hancer/banner/selectBannerList.hanc">
					<input type="hidden" id="PAGE_NUM" name="PAGE_NUM" value="<c:out value='${paramMap.PAGE_NUM}'/>" />
					<input type="hidden" id="PAGE_SIZE" name="PAGE_SIZE" value="<c:out value='${paramMap.PAGE_SIZE}'/>" />
					<input type="hidden" id="mode" name="mode" value="WRITE" />
					<input type="hidden" id="userType" name="userType" value="ADMIN" />
					<input type="hidden" id="BANNER_SEQ" name="BANNER_SEQ" value="" />
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
						<caption><%=msgs.getString("ev.hnevent.label.approvalBanner")%></caption>
						<colgroup>
							<col width="80px" />
							<col width="80px" />
							<col width="80px" />
							<col width="80px" />
							<col width="80px" />
							<col width="80px" />
							<col width="80px" />
							<col width="*" />
							<col width="*" />
						</colgroup>
						<tr>
							<th scope="row"><%=msgs.getString("ev.hnevent.label.title")%></th>
							<td><input class="txt_70" type="text" id="TITLE_NM" name="TITLE_NM" value="<c:out value="${paramMap.TITLE_NM}"/>" /></td>
							<th scope="row"><%=msgs.getString("ev.hnevent.label.state")%></th>
							<td>
								<div class="sel_70">
									<select name="STATE" id="STATE" class="txt_70">
										<option value=""></option>
										<c:forEach items="${bnStateList}" var="data">
											<option value="<c:out value="${data.CODE}"/>"
												<c:if test="${paramMap.STATE eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}" />
											</option>
										</c:forEach>
									</select>
								</div>
							</td>
							<c:if test="${adminRole == 'Y'}">
								<th scope="row"><%=msgs.getString("ev.hnevent.label.domainNm")%></th>
								<td>
									<div class="sel_70">
										<select id="DOMAIN_ID" name="DOMAIN_ID" class="txt_70">
											<c:forEach items="${domainList}" var="domainInfo">
												<option value="<c:out value="${domainInfo.domainId}"/>" <c:if test="${paramMap.DOMAIN_ID eq domainInfo.domainId}">selected</c:if>><c:out value="${domainInfo.domainNm}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>	
							</c:if>
							<th scope="row"><%=msgs.getString("ev.hnevent.label.when")%></th>
							<td>
								<input class="txt_70" title="when" type="text" name="REG_FROM" id="REG_FROM" value="<c:out value="${paramMap.REG_FROM}"/>" readonly />
								<a id="calendar_switch"  href="#link" style="cursor: pointer;" onclick="javascript:Calendar_Create('REG_FROM','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch');">
									<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/bbs/bu_icon_carlendar.gif" alt="calendar"/>
								</a> 
								~ 
								<input class="txt_70" title="when" type="text" name="REG_TO" id="REG_TO" value="<c:out value="${paramMap.REG_TO}"/>" readonly />
								<a id="calendar_switch1" href="#link" style="cursor: pointer;" onclick="javascript:Calendar_Create('REG_TO','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch1');">
									<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/bbs/bu_icon_carlendar.gif" alt="calendar"/>
								</a>
							</td>
							<th scope="row" rowspan="2">
								<a href="#link" style="cursor: pointer;" onclick="javascript:srchBannerList();" class="btn_search"><span><%=msgs.getString("ev.hnevent.label.search")%></span></a>
								<a href="#link" style="cursor: pointer;" onclick="javascript:addBanner();" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.add")%></span></a>
								<a href="#link" style="cursor: pointer;" onclick="javascript:deleteEvent();" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.delete")%></span></a>
							</th>
						</tr>
					</table>
				</form>				
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="3%" />
						<col width="6%" />
						<col width="10%" />
						<col width="7%" />
						<col width="*%" />
						<col width="13%" />
						<col width="21%" />
					</colgroup>
					<thead>
						<tr>
							<th class="first" scope="col"></th>
							<th class="C" scope="col"><span class="table_title">NO</span></th>
							<th class="C" scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.state")%></span></th>
							<th class="C" scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.topBanner")%></span></th>
							<th class="C" scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.title")%></span></th>
							<th class="C" scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.regUserId")%></span></th>
							<th class="C" scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.date")%></span></th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${menuAuth eq 'Y'}">
							<!---이벤트관리자는 모든리스트-->
							<c:forEach var="item" items="${bannerList}" varStatus="status">
								<tr>
									<td><input type="checkbox" id="chkNo<c:out value="${status.count}"/>" name="<c:out value="${item.BANNER_SEQ}"/>" /></td>
									<td><c:out value="${status.count}" /></td>
									<td><c:out value="${item.STATE}" /></td>
									<td><c:out value="${item.TOP_BANNER}" /></td>
									<td><a href="javascript:modifyBanner('<c:out value="${item.BANNER_SEQ}"/>');"><c:out value="${item.TITLE}" /></a></td>
									<td><c:out value="${item.REG_USER_ID}" /></td>
									<td><c:out value="${item.START_DATE}" /> ~ <c:out value="${item.END_DATE}" /></td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${menuAuth eq 'N'}">
							<!---이벤트관리자가 아니면 본인작성글만-->
							<c:forEach var="item" items="${bannerList}" varStatus="status">
								<c:if test="${saUid eq item.REG_USER_ID}">
									<tr>
										<td><input type="checkbox" id="chkNo<c:out value="${status.count}"/>" name="<c:out value="${item.BANNER_SEQ}"/>" /></td>
										<td><c:out value="${status.count}" /></td>
										<td><c:out value="${item.STATE}" /></td>
										<td><c:out value="${item.TOP_BANNER}" /></td>
										<td><a href="javascript:modifyBanner('<c:out value="${item.BANNER_SEQ}"/>');"><c:out value="${item.TITLE}" /></a></td>
										<td><c:out value="${item.REG_USER_ID}" /></td>
										<td><c:out value="${item.START_DATE}" /> ~ <c:out value="${item.END_DATE}" /></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</tbody>					 
				</table>
				<c:if test="${bannerListLen == 0}">
					<p><center><span><strong><%=msgs.getString("ev.hnevent.msg.event.noEvent")%></strong></span></center></p>
				</c:if>
				<c:if test="${bannerListLen != 0 and bannerListLen < totalCount}">
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea">
							<a href="javascript:moreBanner(10);" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.more")%></span></a>
						</div>
					</div>
					<!-- btnArea//-->
				</c:if>
				<input type="text" style="width: 0px; height: 0px; border: none;" id="lastIndexFocus" name="lastIndexFocus" maxlength="0" />
				<!--더보기이후 포커스 이동대상-->			
			</div>
			<!-- board first// -->
		</div>
		<!-- detail// -->
	</div>
	<!-- sub_contents// -->
</body>
</html>