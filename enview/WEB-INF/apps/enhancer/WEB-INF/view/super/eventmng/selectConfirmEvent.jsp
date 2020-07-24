<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
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
 String saUid = (String)userInfoMap.get("user_id");
 String siteName = (String)userInfoMap.get("site_name");
 String studentYn = "";
	if(siteName.equals("/MS010"))//학생일때
		studentYn = "Y";
	if(!siteName.equals("/MS010"))//학생이 아닐때
		studentYn = "N";
 MultiResourceBundle msgs = null;
 msgs = EnviewMultiResourceManager.getInstance().getBundle(langKnd);

 List roleList = (List)userInfoMap.get("roleIdList");
 ArrayList<String> arrayRoleIds = new ArrayList<String>();
 for (int i = 0; i < roleList.size(); i++) {
	Map roleMap =(Map)roleList.get(i) ;
	arrayRoleIds.add((String)roleMap.get("id"));
 }

 String[] roles = new String[arrayRoleIds.size()];
 arrayRoleIds.toArray(roles);

 String flag = "Y";
 String leftFlag = "N";
 String pageType  = "";
  pageType  = (String)request.getParameter("page");

  if(pageType == null){
	  leftFlag = "show";
  }else{
	  if("MY15".equals(pageType)){
		  leftFlag = "hide" ;
	  }else   leftFlag = "show" ;
  }
  request.setAttribute("leftMenuAuth",leftFlag);
  request.setAttribute("menuAuth",flag);
  request.setAttribute("saUid",saUid);
  request.setAttribute("siteName",siteName);
  request.setAttribute("studentYn",studentYn);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
	<title>이벤트승인</title>
	<%-- 
	<link href="<%=request.getContextPath()%>/hancer/css/super/event/core_approval.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/hancer/css/super/event/cssbasic.css"rel="stylesheet" type="text/css" /> 
	--%>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/contents.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/objCalendarCtrl.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/jquery-1.4.2.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/json2.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/validUtil.js"></script>
	<%
		List approveList = (List)request.getAttribute("approveList");
		int len = approveList.size();
		request.setAttribute("approveListLen",len);
	%>
	<script type="text/javascript">
		var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
		var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer";
		var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer/event";
		var approveListLen = 0;
		var userId = '<c:out value="${paramMap.USER_ID}"/>';
		//참여인원순 검색(2012.01.27) : order by joincnt desc
		function srchEventByMember(){
			document.getElementById("SORT_JOIN").value = "orderByJoin";
			srchEventApprove();
		}

		//등록일최신순 검색(2012.01.27) : order by reg_datim desc
		function srchEventByRegister(){
			document.getElementById("SORT_JOIN").value = "";
			document.getElementById("PAGE_SIZE").value = "10";
			srchEventApprove();
		}

		//이벤트승인목록 조회
		function srchEventApprove(){
			
			maskOff(document.getElementById("REG_FROM").id);
			maskOff(document.getElementById("REG_TO").id);			
			var startDate = document.getElementById('REG_FROM').value;
			var endDate = document.getElementById('REG_TO').value;
			//조회기간 유효성체크
			if(trim(startDate) == ""){
				alert('<%=msgs.getString("ev.hnevent.msg.event.enterStdDate")%>');
				maskOn(document.getElementById("REG_FROM").id);
				maskOn(document.getElementById("REG_TO").id);
				return;
			}
			if(trim(endDate) == ""){
				alert('<%=msgs.getString("ev.hnevent.msg.event.enterEndDate")%>');
				maskOn(document.getElementById("REG_TO").id);
				maskOn(document.getElementById("REG_FROM").id);
				return;
			}
			if(trim(startDate) != "" && trim(endDate) != ""){
				if(startDate > endDate){
					alert('<%=msgs.getString("ev.hnevent.msg.event.checkPeriod")%>');
					maskOn(document.getElementById("REG_FROM").id);
					maskOn(document.getElementById("REG_TO").id);
					return;
				}
			}
			
			//주요이벤트 체크여부
			var chkYn = document.getElementById("PRIORTY").checked;
			if(chkYn)
				document.getElementById("PRIORTY").value = "Y";

			//폼서브밋
			document.getElementById("setTransfer").submit();
		}
		
		//이벤트추가
		function addEvent(){
			var frm = document.getElementById("setTransfer");
			document.getElementById("mngMode").value = "WRITE";
			frm.action = actPath +"/insertEventMng.hanc";
			frm.submit();			
		}
		
		//이벤트 승인 및 수정
		function modifyEvent(seq,cate,usrId){
			maskOff(document.getElementById("REG_FROM").id);
			maskOff(document.getElementById("REG_TO").id);
			var frm = document.getElementById("setTransfer");
			
			//카테고리'취업'은 등록기관:경력개발원 & 본인글만 수정 , 관리자는 수정가능
			if(cate == '15'){
				if(usrId == '<%=saUid%>' || '<%=flag%>'=='Y'){	
					document.getElementById("mngMode").value = "MODIFY";
					document.getElementById("EVENT_SEQ").value = seq;
					document.getElementById("studentYn").value = '<c:out value="${studentYn}"/>';//2012.01.16이벤트관리 메뉴오픈으로 수정
					frm.action = actPath +"/insertEventMng.hanc";
					frm.submit();	
				}else{
					if('<%=langKnd%>'=='ko')
						alert("수정권한이 없습니다.");
					if('<%=langKnd%>'=='en')
						alert("You do not have permission to modify.");

					maskOn(document.getElementById("REG_FROM").id);
					maskOn(document.getElementById("REG_TO").id);
					return;
				}
			}else{	
				document.getElementById("mngMode").value = "MODIFY";
				document.getElementById("EVENT_SEQ").value = seq;
				document.getElementById("studentYn").value = '<c:out value="${studentYn}"/>';//2012.01.16이벤트관리 메뉴오픈으로 수정
				frm.action = actPath +"/insertEventMng.hanc";
				frm.submit();
			}
		}
		
		//이벤트삭제
		function deleteEvent(){
			if(confirm('<%=msgs.getString("ev.hnevent.msg.event.delete")%>')){
				var dataArr = new Array(); 
				var chkCnt = 0;
				var eventSeq = "";
				for(var i=1; i<eval(approveListLen)+1; i++){
					if(document.getElementById("chkNo"+i).checked){//선택한 이벤트만 추출;
						/*승인된 목록은 삭제할 수 없는경우
						if(document.getElementById("chkNo"+i).value == '1'){
							alert("승인된 목록은 삭제할 수 없습니다.");
							document.getElementById("chkNo"+i).focus();
							return;
						}else{
							eventSeq+= (document.getElementById("chkNo"+i).name)+"/";
							chkCnt++;
						}
						*/
						eventSeq+= (document.getElementById("chkNo"+i).name)+"/";
						chkCnt++;
					}
				}
				if(chkCnt == 0){
					alert('<%=msgs.getString("ev.hnevent.msg.event.noSelectEvent")%>');
					return;
				}
				
				//선택하지 않은 Row가 null로 들어가는것 처리
				var splitData = eventSeq.split('/');
				for(var j=0; j<eval(splitData.length)-1; j++){
					var row = {EVENT_SEQ : splitData[j] , USER_ID : userId};
					dataArr[j] = row;
				}

				var jsonStr = dataArr.toJSONString();
				var jsonArray = '{data:'+jsonStr+'}';
				$.ajax({ 
				   type: "POST", 
				   url: actPath+"/deleteConfirmEvent.hanc", 
				   data: "data="+jsonArray ,
				   dataType:"text",
				   success: function(data){ 
						alert(data);
						location.reload();
				   }, 
				   error: function(request, status, error) {
						alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
						//alert(request.responseText);
				   }
				});
			}
		}
		
		//더보기버튼 클릭시 10건씩 리스트에 추가
		var dispCnt = '<c:out value="${paramMap.PAGE_SIZE}"/>';
		function moreCategory(n){
			dispCnt = eval(dispCnt) + n;
			document.getElementById("PAGE_NUM").value = "1";
			document.getElementById("PAGE_SIZE").value = dispCnt;
			srchEventApprove();
		}
		
		//화면초기화
		window.onload=function(){
			maskOn(document.getElementById("REG_FROM").id);
			maskOn(document.getElementById("REG_TO").id);
			
			//이벤트승인리스트 갯수
			var len = '<c:out value="${approveListLen}" />';
			approveListLen = len;

			//더보기 후 포커스 하단으로 이동
			document.getElementById("lastIndexFocus").focus();
			document.getElementById("lastIndexFocus").disabled = true;
		}

		//학생일경우 삭제가능여부 검사(신청만 삭제가능:2012.01.16)
		function checkDelYn(state,id){
			var studentYn = '<c:out value="${studentYn}"/>';
			if(studentYn == 'Y' && state == '1'){
				if('<%=langKnd%>'=='ko')
					alert("승인된 이벤트는 선택할 수 없습니다.");
				if('<%=langKnd%>'=='en')
					alert("You can not select an approved event.");

				document.getElementById(id).checked = false;
				return;
			}
		}

		//검색할 신분선택 팝업
		function srchEvTarget(){
			var targetCd = document.getElementById("GROUP_CD").value;
			var sUrl = actPath+"/selectGroup.hanc?target_cd="+targetCd;
			var sStatus="toolbar=0,status=0,scrollbars=1,resizable=0,location=0";
			openWinCenter(sUrl,"_blank",450,550,sStatus)
		}

		//신분선택 팝업 리턴데이터 셋팅
		function setSrchGroup(targetVal){
			var rtnVal = targetVal;
			if(rtnVal != "/" && rtnVal != ""){
				var gpCode = rtnVal.split('/')[0]; //신분코드
				var gpName = rtnVal.split('/')[1]; //신분명
				document.getElementById("GROUP_CD").value  = gpCode;
				document.getElementById("srchGroup").value = gpName;
			}
		}
	</script>
</head>
<body style="min-width:1000px;">
	<!-- sub_contents -->
	<div class="sub_contents">
		<!-- detail -->
		<div class="detail">
			<!-- board first -->
			<div class="board first">
				<!-- searchArea-->
				<div class="tsearchArea">
					<!--pageTitle -->
					<h1><c:if test="${menuAuth eq 'Y'}"><%=msgs.getString("ev.hnevent.label.approvalEvent")%></c:if><c:if test="${menuAuth eq 'hide'}">이벤트관리</c:if></h1>
					<!--pageTitle// -->
				</div>
				<!-- searchArea// -->
				<form name="setTransfer" id="setTransfer" method="post" action="<%=request.getContextPath()%>/hancer/event/selectConfirmEvent.hanc">
					<input type="hidden" id="PAGE_NUM" name="PAGE_NUM" value="<c:out value='${paramMap.PAGE_NUM}'/>"/>
					<input type="hidden" id="PAGE_SIZE" name="PAGE_SIZE" value="<c:out value='${paramMap.PAGE_SIZE}'/>"/>
					<input type="hidden" id="mngMode" name="mngMode" value=""/>
					<input type="hidden" id="EVENT_SEQ" name="EVENT_SEQ" value=""/>
					<input type="hidden" id="studentYn" name="studentYn" value=""/><!--2012.01.16-->
					<input type="hidden" id="SORT_JOIN" name="SORT_JOIN" value="<c:out value='${paramMap.SORT_JOIN}'/>"/><!--2012.01.27-->
					<input type="hidden" id="GROUP_CD" name="GROUP_CD" value="<c:out value='${paramMap.GROUP_CD}'/>"/><!--2012.02.02-->
					<input type="hidden" id="DOMAIN_ID" name="DOMAIN_ID" value="<c:out value='${paramMap.DOMAIN_ID}'/>"/><!--2012.02.02-->
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
						<caption>이벤트 승인 조회</caption>
						<colgroup>
							<col width="10%" />
							<col width="15%" />
							<col width="10%" />
							<col width="*" />
							<col width="13%" />
							<col width="20%" />
						</colgroup>
						<tr>
							<th scope="row"><%=msgs.getString("ev.hnevent.label.admin")%></th>
							<td><input class="txt_145" title="reg user" type="text" id="REG_USER" name="REG_USER" value="<c:out value="${paramMap.REG_USER}"/>" /></td>
							<th scope="row"><%=msgs.getString("ev.hnevent.label.regDate")%></th>
							<td><input class="txt_100" title="when" type="text" name="REG_FROM" id="REG_FROM" value="<c:out value="${paramMap.REG_FROM}"/>" readonly /> <a id="calendar_switch" href="#link" style="cursor:pointer;" onclick="javascript:Calendar_Create('REG_FROM','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/bbs/bu_icon_carlendar.gif" alt="calendar"></a> ~ <input class="txt_100" title="when" type="text" name="REG_TO" id="REG_TO" value="<c:out value="${paramMap.REG_TO}"/>" readonly /> <a id="calendar_switch1" href="#link" style="cursor:pointer;" onclick="javascript:Calendar_Create('REG_TO','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch1');"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/bbs/bu_icon_carlendar.gif" alt="calendar"></a></td>
							<th scope="row"><%=msgs.getString("ev.hnevent.label.category")%></th>
							<td>
								<div class="sel_100">
									<select name="CATE_CD" id="CATE_CD" class="txt_100" title="category">
										<option value=""></option>
										<c:forEach items="${categoryList}" var="data">
											<option value="<c:out value="${data.CATEGORY_SEQ}"/>" <c:if test="${paramMap.CATE_CD eq data.CATEGORY_SEQ}">selected</c:if>><c:out value="${data.CATEGORY_NM}"/></option>
										</c:forEach>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><%=msgs.getString("ev.hnevent.label.state")%></th>
							<td>
								<div class="sel_100">
									<select name="STATE" id="STATE" class="txt_100" title="state">
										<option value=""></option>
										<c:forEach items="${stateList}" var="data">
											<option value="<c:out value="${data.CODE}"/>" <c:if test="${paramMap.STATE eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
										</c:forEach>
									</select>
								</div>
							</td>
							<th scope="row"><%=msgs.getString("ev.hnevent.label.eventName")%></th>
							<td><input class="txt_145" title="event name" type="text" id="TITLE_NM" name="TITLE_NM" value="<c:out value="${paramMap.TITLE_NM}"/>" /></td>
							<th scope="row"><%=msgs.getString("ev.hnevent.label.deptInfo")%></th>
							<td>
								<div class="sel_100">
									<select name="DEPT_CODE" id="DEPT_CODE" class="txt_100" title="dept code">
										<option value=""></option>
										<c:forEach items="${regDeptList}" var="data">
											<option value="<c:out value="${data.DEPT_CODE}"/>" <c:if test="${paramMap.DEPT_CODE eq data.DEPT_CODE}">selected</c:if>><c:out value="${data.DEPT_CODE}"/></option>
										</c:forEach>
									</select>
								</div>
							</td>									
						</tr>
						<tr>
							<th scope="row"><%=msgs.getString("ev.hnevent.label.majorEvents")%></th>
							<td>
								<input name="PRIORTY" id="PRIORTY" type="checkbox" value="<c:out value="${paramMap.PRIORTY}"/>" <c:if test="${paramMap.PRIORTY eq 'Y'}">checked</c:if> />
							</td>
							<th scope="row"><%=msgs.getString("ev.hnevent.label.selectGroup")%></th>
							<td>
								<input type="text" id="srchGroup" name="srchGroup" class="txt_145" title="group" value="<c:out value="${paramMap.srchGroup}"/>" readonly/>
								<a href="#popGroup" style="cursor:pointer;" onclick="javascript:srchEvTarget();" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.select")%></span></a>
							</td>
							<c:if test="${adminRole == 'Y'}">
								<th scope="row"><%=msgs.getString("ev.hnevent.label.domainNm")%></th>
								<td>
									<div class="sel_100">
										<select id="DOMAIN" name="DOMAIN" class="txt_100">
											<c:forEach items="${domainList}" var="domainInfo">
												<option value="<c:out value="${domainInfo.domainId}"/>" <c:if test="${paramMap.DOMAIN_ID eq domainInfo.domainId}">selected</c:if>><c:out value="${domainInfo.domainNm}"/></option>
											</c:forEach>
										</select>
									</div>
									<a href="#link" style="cursor:pointer;" onclick="javascript:srchEventByRegister();" class="btn_search"><span><%=msgs.getString("ev.hnevent.label.search")%></span></a>
								</td>
							</c:if>
						</tr>
					</table>
				</form>	
			</div>
			<!-- board first -->
			<!-- board -->
			<div class="board">
				<!-- btnArea-->
				<div class="btnArea"> 
					<div class="rightArea">
						<a href="#link" style="cursor:pointer;" onclick="javascript:addEvent();" class="btn_W"><span>이벤트추가</span></a>
						<a href="#link" style="cursor:pointer;" onclick="javascript:srchEventByMember();" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.viewOrderByJoinCnt")%></span></a>
						<a href="#link" style="cursor:pointer;" onclick="javascript:deleteEvent();" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.delete")%></span></a>
					</div>
				</div>
				<!-- btnArea//-->		
			</div>
			<!-- board// -->
			<!-- board -->
			<div class="board">
				<table cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="3%" />
						<col width="6%" />
						<col width="8%" />
						<col width="12%" />
						<col width="*%" />
						<col width="12%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th class="first" scope="col"></th>
							<th class="C" scope="col"><span class="table_title">NO</span></th>
							<th class="C" scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.state")%></span></th>
							<th class="C" scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.category")%></span></th>									
							<th class="C" scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.eventInfo")%></span></th>
							<th class="C" scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.regDate")%></span></th>
							<th class="C" scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.participant")%></span></th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${approveListLen == 0}">
							<tr>
								<td class="C" colspan="7">
									<%=msgs.getString("ev.hnevent.msg.event.noEvent")%>
								</td>
							</tr>
						</c:if>				
						<c:if test="${menuAuth eq 'Y'}"><!---이벤트관리자는 모든리스트-->
							<c:forEach var="item" items="${approveList}" varStatus="status">
								<tr>
									<td><input type="checkbox" id="chkNo<c:out value="${status.count}"/>" name="<c:out value="${item.EVENT_SEQ}"/>" value="<c:out value="${item.STATE_CODE}"/>"/></td>
									<td><c:out value="${status.count}" /></td>
									<td><c:out value="${item.STATE}"/></td>
									<td><c:out value="${item.CATEGORY_NM}"/></td>
									<td style="text-align:left;">
										<a href="#link" style="cursor:pointer;" onclick="javascript:modifyEvent('<c:out value="${item.EVENT_SEQ}"/>','<c:out value="${item.CATEGORY_SEQ}"/>','<c:out value="${item.REG_USER_ID}"/>');">
											<c:out value="${item.TITLE}"/><strong>|</strong>
											<c:out value="${item.PLACE_BUILDING}"/><strong>|</strong>
											<c:out value="${item.DEPT_CODE}"/><strong>|</strong>
											<c:out value="${item.REG_USER_NM}"/><strong>|</strong>
											<c:out value="${item.START_DATE}"/> ~ <c:out value="${item.END_DATE}"/>
										</a>
									</td>
									<td><c:out value="${item.REG_DATIM}"/></td>
									<td><c:out value="${item.JOINCNT}"/></td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${menuAuth eq 'N'}"><!---관리자외 본인작성글-->
							<c:forEach var="item" items="${approveList}" varStatus="status">
								<c:if test="${saUid eq item.REG_USER_ID}">
									<tr>
										<td><input type="checkbox" id="chkNo<c:out value="${status.count}"/>" name="<c:out value="${item.EVENT_SEQ}"/>" value="<c:out value="${item.STATE_CODE}"/>" onclick="checkDelYn('<c:out value="${item.STATE_CODE}"/>','chkNo<c:out value="${status.count}"/>')"/></td>
										<td><c:out value="${status.count}" /></td>
										<td><c:out value="${item.STATE}"/></td>
										<td><c:out value="${item.CATEGORY_NM}"/></td>
										<td style="text-align:left;">
											<a href="#link" style="cursor:pointer;" onclick="javascript:modifyEvent('<c:out value="${item.EVENT_SEQ}"/>','<c:out value="${item.CATEGORY_SEQ}"/>','<c:out value="${item.REG_USER_ID}"/>');">
												<c:out value="${item.TITLE}"/><strong>|</strong>
												<c:out value="${item.PLACE_BUILDING}"/><strong>|</strong>
												<c:out value="${item.DEPT_CODE}"/><strong>|</strong>
												<c:out value="${item.REG_USER_NM}"/><strong>|</strong>
												<c:out value="${item.START_DATE}"/> ~ <c:out value="${item.END_DATE}"/>
											</a>
										</td>
										<td><c:out value="${item.REG_DATIM}"/></td>
										<td><c:out value="${item.JOINCNT}"/></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				<c:if test="${approveListLen != 0 and approveListLen < totalCount}">
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea">
							<a href="#link" style="cursor:pointer;" onclick="javascript:moreCategory(10);" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.more")%></span></a>			
						</div>
					</div>
					<!-- btnArea// -->		
				</c:if>
				<input type="text" style="width:0px;height:0px;border:none;" id="lastIndexFocus" name="lastIndexFocus" maxlength="0"/><!--더보기이후 포커스 이동대상-->		
			</div>
			<!-- board// -->		
		</div>
		<!-- detail// -->
	</div>
	<!-- sub_contents// -->
</body>
</html>