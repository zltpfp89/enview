<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List,java.util.ArrayList" %>
<%@ page import="com.saltware.enboard.vo.BoardVO,com.saltware.enboard.vo.BulletinVO,com.saltware.enboard.vo.BltnPollVO" %>
<%@ page import="com.saltware.enview.request.RequestContext"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/each/encafe.css" />
	<%
		if( request.getAttribute("windownId") == null ) {
	%>
		<%--포틀릿으로서 동작하고 있지 않을 때에는 enView의 Javascript를 포함시켜준다--%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<c:if test="${empty secPmsnVO}">
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-<%=request.getLocale().getLanguage()%>.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_mm.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_eb.js"></script>
		</c:if>
		<c:if test="${!empty secPmsnVO}">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-<c:out value="${secPmsnVO.locale}"/>.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${secPmsnVO.locale}"/>_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${secPmsnVO.locale}"/>_eb.js"></script>
		</c:if>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/ko-kr/generatecalendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_list.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_read.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_edit.js"></script>
		
		<!-- fckeditor js -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/fckeditor/fckeditor.js"></script>
		<!--smarteditor js-->
		<script type="text/javascript" src="<%=request.getContextPath()%>/smarteditor/js/HuskyEZCreator.js"></script>
	<%
		}
	%>  
		<!--  valut-->	
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/vault/skins/skyblue/dhtmlxvault.css" />
	  	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/vault/skins/terrace/dhtmlxvault.css" />
	  	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/vault/skins/web/dhtmlxvault.css" />
	  	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/vault/dhtmlxvault.css" />
	  	<script type="text/javascript" src="${pageContext.request.contextPath}/dhtmlx/vault/dhtmlxvault.js"></script>
	  	<script type="text/javascript" src="${pageContext.request.contextPath}/dhtmlx/vault/swfobject.js"></script>
	
		<script type="text/javascript">
			function adminEventFree (win) {
				// 관리자/중간관리자가 아니면 바로 return.
				<c:if test="${secPmsnVO.isAdmin != 'true'}">
					return;
				</c:if>
				ebUtil.eventReset (win.document);
				for (var i=0; i<win.frames.length; i++) {
					try {
						adminEventFree (win.frames[i]);
					} catch(e) {}
				}
			}
		<c:if test="${clientInfo.name != 'Phone' && clientInfo.name != 'Tablet'}">		  			
			<c:if test="${!empty bltnVO.fileList}">
				<c:forEach items="${bltnVO.fileList}" var="fList">
					ebEdit.fileList += "<c:out value="${fList.fileMask}"/>-<c:out value="${fList.fileSize}"/>;";
				</c:forEach>
			</c:if>
			window.onload   = ebEdit.edit_init;
			window.onunload = ebEdit.edit_destroy;
		</c:if>
		<c:if test="${clientInfo.name == 'Phone' || clientInfo.name == 'Tablet'}">
			window.onload   = ebEdit.mobile_edit_init;
			window.onunload = ebEdit.mobile_edit_destroy;
		</c:if>
		
		</script>
	</head>
	<body class="CF0802_bgColor">
        
        
		<input id="editorHeight" name="editorHeight" type="hidden" value="219px"/>
		<div class="boardNameBorder CF0501_nmBrdrWidth CF0501_nmBrdrStyle CF0501_nmBrdrColor">			
			<div class="title">
				<span class="boardName CF0501_nmFontColor CF0501_nmFontNm">글쓰기</span>
			</div>
		</div>
		<form name="editForm" onsubmit="return false">
		
		<%--if 익명글 --%>
	    <c:if test="${boardVO.ableAnonYn == 'Y'}">
	    <c:if test="${secPmsnVO.isLogin == 'true'}">
          <b><util:message key="eb.info.ttl.anon"/> : </b>
		    <c:if test="${boardSttVO.cmd == 'MODIFY'}">
			  <c:if test="${empty bltnVO.userId}"><input type="checkbox" name="anonFlag" checked onclick="ebEdit.checkAbleAnon(this)">&nbsp;Y / N</c:if>
			  <c:if test="${!empty bltnVO.userId}"><input type="checkbox" name="anonFlag" onclick="ebEdit.checkAbleAnon(this)">&nbsp;Y / N</c:if>
			</c:if>
		    <c:if test="${boardSttVO.cmd != 'MODIFY'}">
			  <input type="checkbox" name="anonFlag" onclick="ebEdit.checkAbleAnon(this)">&nbsp;Y / N
			</c:if>
			
			  <b><util:message key="ev.prop.userName"/> : </b> 
				<input type="text" maxlength="30" name="userNick" style="width:100px" class="form"
						value="<c:out value="${ boardSttVO.cmd != 'MODIFY' ? secPmsnVO.userNick : bltnVO.userNick}"/>"
						${empty bltnVO.userId ? 'readonly' : ''}
				  />
			
	        <c:if test="${boardVO.anonYn == 'N'}">
			  <b> <util:message key="eb.info.ttl.password"/> :  </b>
			  <input type="password" name="userPass" value="<c:out value="${bltnVO.userPass}"/>" maxlength="12" size="14"/>				
            </c:if>
        </c:if>
        </c:if>
        <%-- else 익명글 아님 --%>
	    <c:if test="${boardVO.ableAnonYn != 'Y'}">
		<input type="hidden" maxlength="30" name="userNick" style="width:300px" class="form"
				<c:if test="${boardSttVO.cmd != 'MODIFY'}">value="<c:out value="${secPmsnVO.userNick}"/>"</c:if>
		        <c:if test="${boardSttVO.cmd == 'MODIFY'}">value="<c:out value="${bltnVO.userNick}"/>"</c:if>
		  />
		</c:if>
		<%--end 익명글 --%>
		
		
		<c:set var="loginInfo" value="${secPmsnVO.loginInfo}"/>
		<%--jsp:useBean id="loginInfo" type="java.util.Map"/--%>

		<c:if test="${boardVO.extUseYn == 'Y'}">
		  <c:set var="extnMapper" value="${boardVO.bltnExtnMapper}"/>
		  <%--jsp:useBean id="extnMapper" type="com.saltware.enboard.integrate.DefaultBltnExtnMapper"/--%>
		  <c:if test="${!empty bltnVO.bltnExtnVO}">
			<c:set var="extnVO" value="${bltnVO.bltnExtnVO}"/>
			<%--jsp:useBean id="extnVO" type="com.saltware.enboard.integrate.DefaultBltnExtnVO"/--%>
		  </c:if>
		</c:if>
		<%-- Notice --%>
		
		<div class="bltnNotice" ${boardSttVO.cmd=='REPLY' ?  'style="display:none"' : ''}>
			<c:if test="${boardVO.noticeYn == 'Y' && secPmsnVO.ableNotice == 'true'}" var="isAbleNotice">
		           	<input type="checkbox" class="bltnCheckbox" name="bltnTopTag" id="bltnTopTag1"<c:if test="${bltnVO.bltnTopTag == 'N'}"> checked="checked"</c:if> value="N" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'N')"/><label for="bltnTopTag1" class="bltnCheckLabel"><util:message key='eb.info.ttl.notice.not'/></label>
		            <input type="checkbox" class="bltnCheckbox" name="bltnTopTag" id="bltnTopTag2"<c:if test="${bltnVO.bltnTopTag == 'Y'}"> checked="checked"</c:if> value="Y" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'Y')"/><label for="bltnTopTag2" class="bltnCheckLabel"><util:message key='eb.info.designated.notice'/></label>
		            <input type="checkbox" class="bltnCheckbox" name="bltnTopTag" id="bltnTopTag3"<c:if test="${bltnVO.bltnTopTag == 'T'}"> checked="checked"</c:if> value="T" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'T')"/><label for="bltnTopTag3" class="bltnCheckLabel"><util:message key='eb.info.designated.top.notice'/></label>
        	</c:if>
        </div>
		<div class="bltnSubj">
			<c:set var="bltnSubj" value="${bltnVO.bltnSubj}"/>
			<c:set var="bltnSubjCheck" value="Y"/>
			<c:if test="${bltnVO.bltnSubj == '' }">
				<c:set var="bltnSubj" value="제목을 입력해주세요"/>
				<c:set var="bltnSubjCheck" value="N"/>
			</c:if>
			<input id="bltnSubj" type="text" value="<c:out value="${bltnSubj}"/>"  maxlength="120" name="bltnSubj" class="input_bltnSubj" onfocus="javascript:parent.cfCntt.onfocusBltnSubj();" onblur="javascript:parent.cfCntt.onblurBltnSubj();" onkeydown="javascript:parent.cfCntt.onkeydownBltnSubj();" />
			<input id="bltnSubjCheck" type="hidden" value="<c:out value="${bltnSubjCheck}"/>"/>
		</div>
		<div class="bltnCntt" id="smarteditor">
			<textarea id="editorCntt" style="width:99%;min-height:450px"><c:out value="${bltnVO.bltnCntt}"/></textarea>
			<input type="hidden" name="bltnOrgCntt"/>
		</div>
		</form>
		<c:if test="${boardVO.maxFileCnt != '0'}">
		<%-- Attach File --%>
		<div class="bltnAttach">
			<div class="bltnAttach_subj CF0501_nmBrdrWidth CF0501_nmBrdrStyle CF0501_nmBrdrColor">
				<span class="boardName CF0501_nmFontColor CF0501_nmFontNm"><util:message key='ev.title.fileUpload'/></span>
			</div>
			<div class="bltnAttach_file">
				<%-- <form name="setUpload" method="post" enctype="multipart/form-data" target="invisible" action="fileMngr?cmd=upload">
					<% 
						int remainWidth = Integer.parseInt(((BoardVO)request.getAttribute("boardVO")).getBoardWidth()) - 103;
						int fileWidth = remainWidth - 20 - ( 65 * 2 ); 
					%>
					<input type="file" name="filename" style="width: 100%; height: 20px;"/>					
					<input type="hidden" name="viewsize" readonly="readonly" value="총 파일 크기: 0KB"/>
					<input type="hidden" name="boardId" value="<c:out value="${boardSttVO.boardId}"/>"/>
					<input type="hidden" name="totalsize" value="0"/>
					<input type="hidden" name="subId" value="sub01"/>
					<input type="hidden" name="mode" value="attach"/>
				</form> --%>
			</div>
			<div class="bltnAttach_fileList" style="height: 220px;">
				<form name="setFileList" method="post" target="invisible" action="fileMngr?cmd=delete">
					<%-- <select class="file_select" name="list" multiple="multiple">
						<option value="-1" style="background-color: #444; color: white;">Upload List</option>
						<c:if test="${boardSttVO.cmd == 'MODIFY'}">
							<c:set var="file" value="${bltnVO.fileList}"/>
							<c:forEach items="${file}" var="fList">
								<option value="<c:out value="${fList.fileMask}"/>-<c:out value="${fList.fileSize}"/>"><c:out value="${fList.fileName}"/>&nbsp;(<c:out value="${fList.sizeSF}"/>)</option>
							</c:forEach>
						</c:if>
						<option></option><option></option><option></option>
					</select> --%>
					<input type="hidden" name="semaphore" value="<c:out value="${boardSttVO.semaphore}"/>"/>
					<input type="hidden" name="vaccum"/>
					<%-- 게시판별 별도 디렉터리에 첨부파일 관리하는 것 때문에 추가 2009.02.25.KWShin. --%>
					<input type="hidden" name="delBoardId" value="<c:out value="${boardVO.boardId}"/>"/>
					<input type="hidden" name="unDelList"/>
					<input type="hidden" name="delList"/>
					<input type="hidden" name="subId" value="sub01"/>									
					<%-- <span id="uploading" style="display: none;"><c:out value="${boardVO.imgLoading}" escapeXml="false"/><span id="uploadStatus"></span></span>
					<div class="bltnAttach_control">
						<img src='/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/imgUpload.gif' onclick="ebEdit.uploadFile()" class="control_btn" alt="파일올리기" width="65" height="24" align="middle"/>
						<img src='/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/imgUpoff.gif' onclick="ebEdit.deleteFile()" class="control_btn" alt="파일내리기" width="65" height="24" align="middle"/>
					</div>	 --%>
				</form>			
				<div id="vault_upload" style="height: 200px;"></div>
	          	<c:if test="${boardSttVO.cmd eq 'MODIFY'}">
	          	<c:set var="fileList" value="${bltnVO.fileList}"/>
	          	<ul id="vault_fileList" style="display: none;">
	          		<c:forEach items="${fileList}" var="file">
	          		<li data-name="<c:out value='${file.fileName}'/>" data-mask="<c:out value='${file.fileMask}'/>" data-size="<c:out value='${file.fileSize}'/>"><c:out value="${file.fileName}"/> (<c:out value="${file.sizeSF}"/>)</li>
	          		</c:forEach>	
	          	</ul>
	          	</c:if>	
			</div>	
		</div>
		</c:if>
		<div class="controlBox" style="padding-bottom: 5px;">		
			<a class="save_btn"	onclick="javascript:if(parent.cfCntt.checkBltn()) ebEdit.save();">
				<span class="btn_bg bt03"></span>
				<span class="btn_txt bt03 w03">
					<c:if test="${boardSttVO.cmd != 'MODIFY'}"><util:message key='ev.title.save'/></c:if>
					<c:if test="${boardSttVO.cmd == 'MODIFY'}"><util:message key='eb.info.btn.edit'/></c:if>
				</span>
			</a>
			<a class="cancel_btn" onclick="<c:if test="${boardSttVO.cmd != 'MODIFY'}">javascript:ebEdit.list();</c:if><c:if test="${boardSttVO.cmd == 'MODIFY'}">javascript:history.go(-1);</c:if>">
				<span class="btn_bg bt03"></span>
				<span class="btn_txt bt03 w03">
					취소
				</span>
			</a>				
		</div>
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
		</form>
		<iframe name="invisible" frameborder=0 width=0 height=0></iframe>
		<iframe name="download" frameborder=0 width=0 height=0></iframe>
	</body>
</html>