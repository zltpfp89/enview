<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/cola/cafe/css/styles.css">
  <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/board/calendar/css/calendar.css">

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="1" cellpadding="0" cellspacing="0">
  <tr colspan="2">
	<td valign="top">[HEADER]</td>
  </tr>
  <tr colspan="2">
    <td>
	  <span style="cursor:hand" onclick="cfOp.goJigi()">카페관리</span>
	  |
	  <span style="cursor:hand" onclick="cfOp.goEachHome()"><c:out value="${cmntVO.cmntNm}"/></span>
	</td>
  </tr>
  <tr> 
	<td width="100%" height="100%" valign="top">
	  <table width="100%" height="100%" border="1" cellpadding="0" cellspacing="0">
		<tr> 
		  <!-- left menu begin -->
		  <td width="182" valign="top" class="leftmenu_bg">
		    <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
			  <li><h3 title="카페 정보 관리">카페 정보 관리</h3>
			    <ul>
				  <li><a href="javascript:cfOp.chgOpArea('baseInfo')">기본 정보</a></li>
				  <li><a href="javascript:cfOp.chgOpArea('regInfo')">가입 정보</a></li>
				  <%--li><a href="javascript:cfOp.chgOpArea('statistics')">통계 보기</a></li--%>
			    </ul>
			  </li>
			  <li><h3 title="메뉴/게시물 관리">메뉴/게시물 관리</h3>
			    <ul>
				  <li><a href="javascript:cfOp.chgOpArea('menuMng')">메뉴 관리</a></li>
				  <li><a href="javascript:cfOp.chgOpArea('bltnMng')">게시글 관리</a></li>
				  <%--li><a href="javascript:cfOp.chgOpArea('somoMng')">소모임 관리</a></li--%>
			    </ul>
			  </li>
			  <li><h3 title="회원 정보 관리">회원 정보 관리</h3>
			    <ul>
				  <li><a href="javascript:cfOp.chgOpArea('regMmbr')">가입 회원</a></li>
				  <li><a href="javascript:cfOp.chgOpArea('brdSysop')">게시판지기</a></li>
				  <li><a href="javascript:cfOp.chgOpArea('rsgnMmbr')">탈퇴 회원</a></li>
				  <li><a href="javascript:cfOp.chgOpArea('mmbrGrd')">회원 등급</a></li>
				  <%--li><a href="javascript:cfOp.chgOpArea('mailSms')">메일/쪽지</a></li--%>
			    </ul>
			  </li>
			  <%--li class="end"><h3 title="화면 관리">화면 관리</h3--%>
			    <%--ul--%>
				  <%--li><a href="javascript:cfOp.chgOpArea('homeDeco')">홈 꾸미기</a></li--%>
				  <%--li><a href="javascript:cfOp.chgOpArea('ttlDeco')">타이틀</a></li--%>
				  <%--li><a href="javascript:cfOp.chgOpArea('gateDeco')">대문</a></li--%>
				  <%--li><a href="javascript:cfOp.chgOpArea('decoArch')">보관함</a></li--%>
				  <%--li><a href="javascript:cfOp.chgOpArea('rcmdDeco')">추천세트</a></li--%>
			    <%--/ul--%>
			  <%--/li--%>
		    </div>
		  </td>
		  <%--left menu end--%>
		  <td valign="top" class="padd_cons">
		    <div id="opArea" width=100% height=100% valign="top" style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
			  <div>
			    오늘의 방문자수: <c:out value="${opForm.todayVisitCntCF}"/>
				<br>오늘의 가입자: <c:out value="${opForm.todayRegCntCF}"/>
				<br>오늘의 게시글: <c:out value="${opForm.todayBltnCntCF}"/>
			  </div>
			  <div>
			    <h3 title="카페 기본 정보">카페 기본 정보</h3>
			    <ul>
				  <li><span><label>카페 이름</label><span style="margin-left:10px"><c:out value="${cmntVO.cmntNm}"/></span></span></li>
				  <li><span><label><util:message key="mm.title.category"/><%--카테고리--%></label><span style="margin-left:10px"><c:out value="${cmntVO.cateIdNm}"/></span></span></li>
				  <li><span><label>검색어</label><span style="margin-left:10px">
				                                       <c:forEach items="${tagList}" var="tag" varStatus="status">
													     <c:if test="${!status.first}">|</c:if>
														 <c:out value="${tag.tag}"/>
													   </c:forEach>
											      </span>
			          </span>
				  </li>
			    </ul>
			  </div>
			</div>
		  </td>
	    </tr>
	  </table>
	</td>
  </tr>
  <tr>
	<td valign="top">[FOOTER]</td>
  </tr>
</table>
<div id="brdUserChooser" title="<util:message key="eb.title.userChooser"/>"></div>
<%--가입상태 변경 사유 관리 화면을 띄울 DIV--%>
<div id="stateCodeGetter" title="회원 상태 변경 관리"></div>
<form name=transferForm id=transferForm method=post action= onsubmit="return false;">
  <input type=hidden id=m  name="m" />
  <input type=hidden id=cmntId  name=cmntId  value=<c:out value="${cmntVO.cmntId}"/>>
  <input type=hidden id=cmntUrl name=cmntUrl value=<c:out value="${cmntVO.cmntUrl}"/>>
  <input type=hidden id=langKnd name=langKnd value=<c:out value="${opForm.langKnd}"/>>
</form>
</body>

  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
  <script type="text/javㅋascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_mm.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_ev.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_cf.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_eb.js"></script>
		
  <link type="text/css" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" rel="stylesheet" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
  <!--script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-<c:out value="${cmntVO.langKnd}"/>.js"></script-->
  <!--script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-ko.js"></script-->
  
  <script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/calendar.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/ko-kr/generatecalendar.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/cafe_home.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/cafe_op.js"></script>
  
  <script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_list.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_read.js"></script>
  <%--
  <script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_edit_cafe.js"></script>
   --%>
  <!-- fckeditor js -->
  <script type="text/javascript" src="<%=request.getContextPath()%>/board/fckeditor/fckeditor.js"></script>
  <!--smarteditor js-->
  <script type="text/javascript" src="<%=request.getContextPath()%>/smarteditor/js/HuskyEZCreator.js"></script>
  
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/vault/skins/skyblue/dhtmlxvault.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/vault/skins/terrace/dhtmlxvault.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/vault/skins/web/dhtmlxvault.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/vault/dhtmlxvault.css" />
  <script type="text/javascript" src="${pageContext.request.contextPath}/dhtmlx/vault/dhtmlxvault.js"></script>
  
  <script type="text/javascript">
	<c:if test="${!empty bltnVO.fileList}">
	  <c:forEach items="${bltnVO.fileList}" var="fList">
		ebEdit.fileList += "<c:out value="${fList.fileMask}"/>-<c:out value="${fList.fileSize}"/>;";
	  </c:forEach>
	</c:if>
	window.onload = function(){ alert("Hi there"));ebEdit.edit_init;}
	<!--window.onload   = ebEdit.edit_init;-->
	window.onunload = ebEdit.edit_destroy;
	
	function dext_editor_before_insert_url_event(editorID, insertUrl) {
		var path = insertUrl.substring(0, insertUrl.indexOf('?'));
		var postfix =  insertUrl.substring(insertUrl.indexOf('?'), insertUrl.length);
		
		var result = "";
		$.ajax({
			url : "${contextRootPath}/statics/decrypt.jsp",
			type: "POST",
			timeout:5000,
			data : {e : path},
			async : false,
			dataType : "json",
			success : function (data) {
				result = data.d;
			}
		});
		return result + postfix;
	}
  </script>
  <script type="text/javascript">
	if (!portalPage) portalPage = new enview.portal.Page();
	portalPage.m_contextPath = ebUtil.getContextPath();
  </script>
	<form name="setTransfer" method="post" action="list.brd">   
			<input type="hidden" name="boardId"       value="<c:out value="${boardSttVO.boardId}"/>" />
			<input type="hidden" name="cmpBrdId"      value="<c:out value="${boardSttVO.cmpBrdId}"/>" />
			<input type="hidden" name="srchKey"       value="<c:out value="${boardSttVO.srchKey}"/>" />
			<input type="hidden" name="srchType"      value="<c:out value="${boardSttVO.srchType}"/>" />
			<input type="hidden" name="srchBgnReg"    value="<c:out value="${boardSttVO.srchBgnReg}"/>" />
			<input type="hidden" name="srchEndReg"    value="<c:out value="${boardSttVO.srchEndReg}"/>" />
			<input type="hidden" name="srchReplYn"    value="<c:out value="${boardSttVO.srchReplYn}"/>" />
			<input type="hidden" name="srchMemoYn"    value="<c:out value="${boardSttVO.srchMemoYn}"/>" />
			<input type="hidden" name="page"          value="<c:out value="${boardSttVO.page}"/>" />
			<input type="hidden" name="pageSize"      value="<c:out value="${boardSttVO.pageSize}"/>" />
			<input type="hidden" name="cateId"        value="<c:out value="${boardSttVO.cateId}"/>" />
			<input type="hidden" name="bltnCateId"    value="<c:out value="${boardSttVO.bltnCateId}"/>" />
			<input type="hidden" name="bltnNo"        value="<c:out value="${boardSttVO.bltnNo}"/>" />
			<input type="hidden" name="cmd"       	  value="<c:out value="${boardSttVO.cmd}"/>" />
			<input type="hidden" name="ie"            value="<c:out value="${boardSttVO.ie}"/>" />
			<input type="hidden" name="onlyReplYn"    value="<c:out value="${boardSttVO.onlyReplYn}"/>" />
			<input type="hidden" name="onlyMemoYn"    value="<c:out value="${boardSttVO.onlyMemoYn}"/>" />
			<input type="hidden" name="wallUserId"    value="<c:out value="${boardSttVO.wallUserId}"/>" />
			<input type="hidden" name="boardRid"      value="<c:out value="${boardVO.boardRid}"/>" />
			<input type="hidden" name="accSetYn"      value="<c:out value="${boardVO.accSetYn}"/>" />
			<input type="hidden" name="boardSkinDflt" value="<c:out value="${boardVO.boardSkinDflt}"/>" />
			<input type="hidden" name="boardWidth"    value="<c:out value="${boardVO.boardWidth}"/>" />
			<input type="hidden" name="maxFileCnt"    value="<c:out value="${boardVO.maxFileCnt}"/>" />
			<input type="hidden" name="thumbSize"     value="<c:out value="${boardVO.thumbSize}"/>" />
			<input type="hidden" name="badNickDflt"   value="<c:out value="${boardVO.badNickDflt}"/>" />
			<input type="hidden" name="badCnttDflt"   value="<c:out value="${boardVO.badCnttDflt}"/>" />
			<input type="hidden" name="limitSize"     value="<c:out value="${boardVO.limitSize}"/>" />
			<%--BEGIN::Keep this snippet for compatiablility with old version--%>
			<input type="hidden" name="ableListGrade" value="<c:out value="${bltnVO.ableListGrade}"/>" />
			<input type="hidden" name="ableListGroup" value="<c:out value="${bltnVO.ableListGroup}"/>" />
			<input type="hidden" name="ableListRole"  value="<c:out value="${bltnVO.ableListRole}"/>" />
			<input type="hidden" name="ableReadGrade" value="<c:out value="${bltnVO.ableReadGrade}"/>" />
			<input type="hidden" name="ableReadGroup" value="<c:out value="${bltnVO.ableReadGroup}"/>" />
			<input type="hidden" name="ableReadRole"  value="<c:out value="${bltnVO.ableReadRole}"/>" />
			<%--END::Keep this snippet for compatiablility with old version--%>
			<input type="hidden" name="accSetInfo" />
			<input type="hidden" name="totFileSize"   value="<c:out value="${bltnVO.totFileSize}"/>" />
			<input type="hidden" name="sizeSF"        value="<c:out value="${bltnVO.sizeSF}"/>" />
			<c:set var="loginInfo" value="${secPmsnVO.loginInfo}"/>
			<input type="hidden" name="mileTot"       value="<c:out value="${loginInfo.mile_tot}"/>" />
			<input type="hidden" name="bltnSubj" />
			<input type="hidden" name="bltnCntt" />
			<input type="hidden" name="ext_str0" />
			<input type="hidden" name="ext_str1" />
			<input type="hidden" name="ext_str2" />
			<input type="hidden" name="ext_str3" />
			<input type="hidden" name="ext_str4" />
			<input type="hidden" name="ext_str5" />
			<input type="hidden" name="ext_str6" />
			<input type="hidden" name="ext_str7" />
			<input type="hidden" name="ext_str8" />
			<input type="hidden" name="ext_str9" />
			<input type="hidden" name="bltnSecretYn" />
			<input type="hidden" name="userNick" />
			<input type="hidden" name="userPass" />
			<input type="hidden" name="anonFlag" />
			<input type="hidden" name="fileName" />
			<input type="hidden" name="fileMask" />
			<input type="hidden" name="fileSize" />
			<input type="hidden" name="pollCntt" />
			<input type="hidden" name="pollMask" />
			<input type="hidden" name="betPnt" />
			<input type="hidden" name="bltnTopTag" />
			<input type="hidden" name="bltnBgnYmd" />
			<input type="hidden" name="bltnEndYmd" />
			<input type="hidden" name="rtnURI" />
			<input type="hidden" name="langKnd" value="<c:out value="${secPmsnVO.locale}"/>" />
			<input type="hidden" name="boardType" value="<c:out value="${boardType}"/>"/>
		</form>
</html>