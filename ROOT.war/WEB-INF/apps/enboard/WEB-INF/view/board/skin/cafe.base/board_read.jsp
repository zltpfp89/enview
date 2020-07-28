<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.saltware.enboard.vo.BoardVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" />
		
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/each/encafe.css" />
	<%
		if( request.getAttribute("windownId") == null ) {
	%>
		<%--포틀릿으로서 동작하고 있지 않을 때에는 enView의 Javascript를 포함시켜준다--%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_eb.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_cf.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/ko-kr/generatecalendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_list.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_read.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/fckeditor/fckeditor.js"></script>
	<%
		}
	%>  		
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
			ebUtil.eventSet();
			
			if (window.attachEvent) {
				window.attachEvent ("onload", ebRead.initRead);
			} else if (window.addEventListener ) {
				window.addEventListener ("load", ebRead.initRead, false);
			} else {
				window.onload = ebRead.initRead;
			}
			ebRead.loadPoll();
			
			function lastestList (){
				document.setForm.page.value = 1;
				ebRead.actionBulletin('list');
			}
			
		</script>
	</head>
	<body class="CF0802_bgColor">
		<form name="setForm" method="post">
			<input type="hidden" name="boardId"        value="<c:out value="${boardSttVO.boardId}"/>" />
			<input type="hidden" name="cmpBrdId"       value="<c:out value="${boardSttVO.cmpBrdId}"/>" />
			<input type="hidden" name="srchKey"        value="<c:out value="${boardSttVO.srchKey}"/>" />
			<input type="hidden" name="srchType"       value="<c:out value="${boardSttVO.srchType}"/>" />
			<input type="hidden" name="srchBgnReg"     value="<c:out value="${boardSttVO.srchBgnReg}"/>" />
			<input type="hidden" name="srchEndReg"     value="<c:out value="${boardSttVO.srchEndReg}"/>" />
			<input type="hidden" name="srchReplYn"     value="<c:out value="${boardSttVO.srchReplYn}"/>" />
			<input type="hidden" name="srchMemoYn"     value="<c:out value="${boardSttVO.srchMemoYn}"/>" />
			<input type="hidden" name="page"           value="<c:out value="${boardSttVO.page}"/>" />
			<input type="hidden" name="pageSize"       value="<c:out value="${boardSttVO.pageSize}"/>" />
			<input type="hidden" name="cateId"         value="<c:out value="${boardSttVO.cateId}"/>" />
			<input type="hidden" name="bltnCateId"     value="<c:out value="${boardSttVO.bltnCateId}"/>" />
			<input type="hidden" name="rtnBltnNo"      value="<c:out value="${boardSttVO.rtnBltnNo}"/>" />
			<input type="hidden" name="bltnNo"         value="<c:out value="${boardSttVO.bltnNo}"/>" />
			<input type="hidden" name="cmd"            value="<c:out value="${boardSttVO.cmd}"/>" />
			<input type="hidden" name="onlyReplYn"     value="<c:out value="${boardSttVO.onlyReplYn}"/>" />
			<input type="hidden" name="onlyMemoYn"     value="<c:out value="${boardSttVO.onlyMemoYn}"/>" />
			<input type="hidden" name="wallUserId"     value="<c:out value="${boardSttVO.wallUserId}"/>" />
			<input type="hidden" name="badNickDflt"    value="<c:out value="${boardVO.badNickDflt}"/>" />
			<input type="hidden" name="badCnttDflt"    value="<c:out value="${boardVO.badCnttDflt}"/>" />
			<input type="hidden" name="boardSkinDflt"  value="<c:out value="${boardVO.boardSkinDflt}"/>" /> 
			<input type="hidden" name="boardWidth"     value="<c:out value="${boardVO.boardWidth}"/>" />
			<input type="hidden" name="writableYn"     value="<c:out value="${boardVO.writableYn}"/>" />
			<input type="hidden" name="replyableYn"    value="<c:out value="${boardVO.replyableYn}"/>" />
			<input type="hidden" name="memoWritableYn" value="<c:out value="${boardVO.memoWritableYn}"/>" />

			<input type="hidden" name="userPass" />
			<input type="hidden" name="userNick" />
			<input type="hidden" name="memoCntt" />
			<input type="hidden" name="memoSeq" value="0" />
			<input type="hidden" name="memoGn" value="0" />
			<input type="hidden" name="memoGq" value="0" />
			<input type="hidden" name="memoLev" value="0" />
			<input type="hidden" name="pollSeq" />
			<input type="hidden" name="evalPnt" />
			<input type="hidden" name="bltnBestLevel" />
			<input type="hidden" name="rtnURI" />
			<input type="hidden" name="befCmd" />
		</form>
		<iframe name="download" frameborder="0" width="0" height="0"></iframe>
		<c:set var="loginInfo" value="${secPmsnVO.loginInfo}"/>
		<c:if test="${boardVO.extUseYn == 'Y'}">
		  <c:set var="rsExtnMapper" value="${boardVO.bltnExtnMapper}"/>
		</c:if>
		<c:forEach items="${bltnVOs}" var="list">
		<c:if test="${!empty list.nextBoardId && !empty list.nextBltnNo}" var="isNext"/>
		<c:if test="${!empty list.prevBoardId && !empty list.prevBltnNo}" var="isPrev"/>
		<div class="read_controlBox" style="padding-bottom: 5px;">
			<a class="read_btnWrite" onclick="ebList.writeBulletin();">
				<span class="btn_bg bg03"></span>
				<span class="btn_txt bt03 w07 bold">
					<span class="btn_icon_write"><util:message key='eb.info.title.write' /></span>
				</span>
			</a>			
			<c:if test="${boardVO.replyableYn == 'Y' && boardVO.replyYn == 'Y'}">
				<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
					onclick="javascript:ebRead.actionBulletin('reply',<c:out value="${list.bltnNo}"/>);">
					<span class="btn_bg bt03"></span>
					<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
						<util:message key='eb.label.replyYn' />
					</span>
				</a>				
			</c:if>
			<c:if test="${list.editable == 'true'}"><%--수정권한이 있는 경우--%>
				<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
					onclick="javascript:ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true);">
					<span class="btn_bg bt03"></span>
					<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
						<util:message key='eb.info.btn.edit' />
					</span>
				</a>	
			</c:if>
			<c:if test="${list.editable == 'false'}"><%--수정권한이 없는 경우--%>
				<c:if test="${empty list.userId}"><%--익명글이면--%>
					<c:if test="${list.editableUserId == '_is_admin_'}"><%--관리자인 경우--%>
						<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
							onclick="javascript:ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true);">
							<span class="btn_bg bt03"></span>
							<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
								<util:message key='eb.info.btn.edit' />
							</span>
						</a>	
					</c:if>
					<c:if test="${list.editableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
						<c:if test="${boardVO.writableYn == 'Y'}">							
							<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
								onclick="javascript:ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,false);">
								<span class="btn_bg bt03"></span>
								<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
									<util:message key='eb.info.btn.edit' />
								</span>
							</a>
						</c:if>
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${list.deletable == 'true'}"><%--삭제권한이 있는 경우--%>
				<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
					onclick="javascript:ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true);">
					<span class="btn_bg bt03"></span>
					<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
						<util:message key='ev.info.menu.delete' />
					</span>
				</a>
			</c:if>
			<c:if test="${list.deletable == 'false'}"><%--삭제권한이 없는 경우--%>
				<c:if test="${empty list.userId}"><%--익명글이면--%>
					<c:if test="${list.deletableUserId == '_is_admin_'}"><%--관리자인 경우--%>						
						<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
							onclick="javascript:ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true);">
							<span class="btn_bg bt03"></span>
							<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
								<util:message key='ev.info.menu.delete' />
							</span>
						</a>
					</c:if>
					<c:if test="${list.deletableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
						<c:if test="${boardVO.writableYn == 'Y'}">
							<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
								onclick="javascript:ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,false);">
								<span class="btn_bg bt03"></span>
								<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
									<util:message key='ev.info.menu.delete' />
								</span>
							</a>
						</c:if>
					</c:if>
				</c:if>  
			</c:if>
			<span class="list_paging">
				<a onclick="lastestList();"><util:message key='eb.titile.latestList' /></a>
				<span class="readPipe CF0802_extraColor">|</span>
				<a onclick="ebRead.actionBulletin('list');"><util:message key='ev.prop.list' /></a>
				<span class="readPipe CF0802_extraColor">|</span>
				<c:if test="${isNext}">
					<span class="bltn_label_arrow">▲</span>
					<a onclick="ebRead.readPrevNextBltn('<c:out value="${list.nextBoardId}"/>','<c:out value="${list.nextBltnNo}"/>');"><util:message key='eb.title.Previouspost' /></a>
				</c:if>
				<c:if test="${!isNext}">
					<span class="bltn_label_arrow nonLink">▲</span>
					<span class="nonLink"><util:message key='eb.title.Previouspost' /></span>
				</c:if>
				<span class="readPipe CF0802_extraColor">|</span>
				<c:if test="${isPrev}">
					<span class="bltn_label_arrow">▼</span>
					<a onclick="ebRead.readPrevNextBltn('<c:out value="${list.prevBoardId}"/>','<c:out value="${list.prevBltnNo}"/>');"><util:message key='eb.title.Nextpost' /></a>
				</c:if>
				<c:if test="${!isPrev}">
					<span class="bltn_label_arrow nonLink">▼</span>
					<span class="nonLink"><util:message key='eb.title.Nextpost' /></span>
				</c:if>
			</span>
		</div>
		<div class="read_box CF0802_extraBrdrColor">
			<span class="readName"><c:out value="${list.bltnOrgSubj}"/></span>
			<span class="readPipe CF0802_extraColor">|</span>
			<span class="readDesc"><c:out value="${boardVO.boardNm}"/></span>
		</div>
		<div class="read_info">			
			<div class="read_hit"><util:message key='eb.info.ttl.hits' />&nbsp;<c:out value="${list.bltnReadCnt}"/></div>
			<span class="readPipe2 CF0802_extraColor">|</span>
			<div class="read_regDatim"><c:out value="${list.regDatimF}"/></div>
		</div>
		<div class="read_cntt">
			<c:out value="${list.bltnOrgCntt}" escapeXml="false"/>
		</div>
		<c:set var="rsfile" value="${list.fileList}"/>
		<c:if test="${!empty rsfile}">
		<%-- Attached file --%>
		<div class="read_attach">
			<c:forEach items="${rsfile}" var="fList" varStatus="status">
				<c:set var="rsfilesize" value="${status.count}"/>
			</c:forEach>
			<div class="read_attach_subj">
				<a class="read_attach_toggle" onclick="javascript:parent.cfCntt.toggleAttach();"><util:message key='cf.board.attachment'/> <span class="fileCnt"><c:out value="${rsfilesize}"/></span><util:message key='eb.title.count'/> </a>
				<span class="arrowTR">▼</span></div>
			<div id="read_attach_fileList" class="read_attach_fileList">
				<c:forEach items="${rsfile}" var="fList" varStatus="status">
			        <span class="read_attach_file">
						<c:out value="${fList.downloadLink}" escapeXml="false"/>&nbsp;(<c:out value="${fList.sizeSF}"/>)
					</span><br />
				</c:forEach>
			</div>
		</div>
        </c:if>
		
		<div class="memo_view" id="memo_view">
			<span id="bltnMemoCnt" class="bltnMemoCnt">
					<a onclick="parent.cfCntt.toggleMemoView(); return false;">
						<util:message key='eb.info.ttl.memo' /> <span id=cmtCnt><c:out value="${list.bltnMemoCnt}"/></span>
					</a>
			</span>	
		</div>
		
		<c:if test="${!empty list.memoList}">
		<div id="read_memo" class="read_memo CF0802_extraBgColor">
			<%-- List of Memo --%>        
			<c:set var="memo" value="${list.memoList}"/>
            <c:forEach items="${memo}" var="mList" varStatus="status">
				<div class="memo<c:if test="${!status.first && mList.memoLev == '1'}"> line</c:if> CF0802_extraBrdrColor">
					<div class="memo_label">
						<div class="memo_user">
							<c:if test="${mList.memoLev != '1'}">
								<span class="memo_reply">┗</span>
							</c:if>
							<c:out value="${mList.userNick }"/>
							<span class="memo_regDatim"><c:out value="${mList.regDatimF}"/></span>
							<c:if test="${mList.recentMemo == 'Y'}"><c:out value="${boardVO.imgNew}" escapeXml="false"/></c:if>
							
						</div>
						<div class="memo_control" id="memo_control_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
							<c:if test="${boardVO.memoReplyYn == 'Y' && boardVO.memoReplyableYn == 'Y'}">
								<c:if test="${mList.memoLev == '1'}"><%--댓답글은 1레벨까지만--%>
									<a class="memo_control_link" onclick="ebRead.actionBulletin('reply-init-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>'); parent.cfCntt.actionBulletin('reply-init-memo', '<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>');">
										<util:message key='eb.label.replyYn' />
									</a>
									<span class="memo_control_pipe CF0802_extraColor">|</span>
								</c:if>
							</c:if>
							<c:if test="${mList.editable == 'true'}">
								<a class="memo_control_link" onclick="ebRead.actionBulletin('modify-init-memo','<c:out value="${mList.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>'); parent.cfCntt.actionBulletin('modify-init-memo', '<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>');">
									<util:message key='eb.info.btn.edit' />
								</a>
							</c:if>
							<c:if test="${mList.deletable == 'true'}">
								<span class="memo_control_pipe CF0802_extraColor">|</span>
								<a class="memo_control_link" onclick="ebRead.actionBulletin('delete-memo','<c:out value="${mList.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>');">
									<util:message key='ev.info.menu.delete' />
								</a>
							</c:if>
							<c:if test="${boardVO.badStdCnt > '0'}">
								<span class="memo_control_pipe CF0802_extraColor">|</span>
								<c:if test="${mList.badCnt > '0'}">
									<!-- font style=font-size:7pt color=#264C72>+<c:out value="${mList.badCnt}"/></font-->
								</c:if>
								<a class="memo_control_link" onclick="ebRead.actionBulletin('bad-memo','<c:out value="${mList.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>');">
									<util:message key='eb.prop.report'/>
								</a>
							</c:if>
						</div>
					</div>
					<div id="memo_cntt_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" class="memo_cntt<c:if test="${mList.memoLev != '1'}"> memo_indent</c:if>"><c:out value="${mList.memoCntt}" escapeXml="false"/></div>
					<div class="memoReply" id="memoReplyDiv_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" style="display:none;">
						<form id="memoReplyForm_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" name="memoReplyForm_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
							<input type="hidden" name="memoOrgCntt" value="<c:out value="${mList.memoOrgCntt}"/>" />
							<input type="hidden" name="rorm" />						
							<c:if test="${boardVO.anonYn == 'N'}"><%--익명게시판이 아닌 경우--%>
								<input type="hidden" name="userNick" value="<c:out value="${secPmsnVO.userNick}"/>" />
							</c:if>
							<c:if test="${boardVO.anonYn == 'Y'}"><%--익명게시판인 경우--%>
								<input type="hidden" name="userNick" />
							</c:if>
							<textarea name="memoCntt" class="memoReply_cntt CF0802_bgColor CF0802_extraBrdrColor" maxlength="3000"><c:out value="${mList.memoOrgCntt}"/></textarea>
							<div class="memoReply_btn_div">
								<a class="memoReply_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" onclick="javascript:ebRead.actionBulletin('rorm-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>');return false;">
									<span class="btn_bg bg05"></span><span class="btn_txt bt05 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>"><util:message key='ev.hnevent.label.reg' /></span>
								</a>
								<a class="memoReply_btn" name="memoCancelBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" onclick="javascript:ebRead.actionBulletin('cancel-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>'); parent.cfCntt.actionBulletin('cancel-memo', '<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>');return false;">
									<span class="btn_bg bg05"></span><span class="btn_txt bt05 w03" id="cancel_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>"><util:message key='ev.title.cancel' /></span>
								</a>
							</div>
						</form>
					</div>
				</div>				
			</c:forEach>
		</div>
        </c:if>
		<c:if test="${boardVO.memoYn == 'Y' && boardVO.memoWritableYn == 'Y'}">
		<div id="write_memo" class="write_memo CF0802_extraBgColor">
			<%-- Write memo. --%>		
			<form name="memoForm_<c:out value="${list.bltnNo}"/>">
				<input type="hidden" name="userNick" value="<c:out value="${secPmsnVO.userNick}"/>" />
				<textarea name="memoCntt" class="write_memo_cntt CF0802_bgColor CF0802_extraBrdrColor" maxlength="3000"></textarea>
				<div class="editor_btn_div">
					<a class="editor_btn write_memo_btn" name="memoBttn" onclick="ebRead.actionBulletin('write-memo',<c:out value="${list.bltnNo}"/>);return false;">
						<span class="btn_bg bg01"></span><span class="btn_txt bt01" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>"><util:message key='ev.hnevent.label.reg' /></span>
					</a>
				</div>
			</form>
		</div>
		</c:if>
		<div class="read_controlBox" style="padding-bottom: 5px;">
			<a class="read_btnWrite" onclick="ebRead.actionBulletin('write');">
				<span class="btn_bg bg03"></span>
				<span class="btn_txt bt03 w07 bold">
					<span class="btn_icon_write"><util:message key='eb.info.title.write' /></span>
				</span>
			</a>			
			<c:if test="${boardVO.replyableYn == 'Y' && boardVO.replyYn == 'Y'}">
				<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
					onclick="javascript:ebRead.actionBulletin('reply',<c:out value="${list.bltnNo}"/>);">
					<span class="btn_bg bt03"></span>
					<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
						<util:message key='eb.label.replyYn' />
					</span>
				</a>				
			</c:if>
			<c:if test="${list.editable == 'true'}"><%--수정권한이 있는 경우--%>
				<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
					onclick="javascript:ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true);">
					<span class="btn_bg bt03"></span>
					<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
						<util:message key='eb.info.btn.edit' />
					</span>
				</a>	
			</c:if>
			<c:if test="${list.editable == 'false'}"><%--수정권한이 없는 경우--%>
				<c:if test="${empty list.userId}"><%--익명글이면--%>
					<c:if test="${list.editableUserId == '_is_admin_'}"><%--관리자인 경우--%>
						<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
							onclick="javascript:ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true);">
							<span class="btn_bg bt03"></span>
							<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
								<util:message key='eb.info.btn.edit' />
							</span>
						</a>	
					</c:if>
					<c:if test="${list.editableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
						<c:if test="${boardVO.writableYn == 'Y'}">							
							<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
								onclick="javascript:ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,false);">
								<span class="btn_bg bt03"></span>
								<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
									<util:message key='eb.info.btn.edit' />
								</span>
							</a>
						</c:if>
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${list.deletable == 'true'}"><%--삭제권한이 있는 경우--%>
				<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
					onclick="javascript:ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true);">
					<span class="btn_bg bt03"></span>
					<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
						<util:message key='ev.info.menu.delete' />
					</span>
				</a>
			</c:if>
			<c:if test="${list.deletable == 'false'}"><%--삭제권한이 없는 경우--%>
				<c:if test="${empty list.userId}"><%--익명글이면--%>
					<c:if test="${list.deletableUserId == '_is_admin_'}"><%--관리자인 경우--%>						
						<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
							onclick="javascript:ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true);">
							<span class="btn_bg bt03"></span>
							<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
								<util:message key='ev.info.menu.delete' />
							</span>
						</a>
					</c:if>
					<c:if test="${list.deletableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
						<c:if test="${boardVO.writableYn == 'Y'}">
							<a class="read_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" 
								onclick="javascript:ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,false);">
								<span class="btn_bg bt03"></span>
								<span class="btn_txt bt03 w03" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
									<util:message key='ev.info.menu.delete' />
								</span>
							</a>
						</c:if>
					</c:if>
				</c:if>  
			</c:if>
			<span class="list_paging">
				<a onclick="lastestList();"><util:message key='eb.titile.latestList' /></a>
				<span class="readPipe CF0802_extraColor">|</span>
				<a onclick="ebRead.actionBulletin('list');"><util:message key='ev.prop.list' /></a>
				<span class="readPipe CF0802_extraColor">|</span>
				<c:if test="${isNext}">
					<span class="bltn_label_arrow">▲</span>
					<a onclick="ebRead.readPrevNextBltn('<c:out value="${list.nextBoardId}"/>','<c:out value="${list.nextBltnNo}"/>');"><util:message key='eb.title.Previouspost' /></a>
				</c:if>
				<c:if test="${!isNext}">
					<span class="bltn_label_arrow nonLink">▲</span>
					<span class="nonLink"><util:message key='eb.title.Previouspost' /></span>
				</c:if>
				<span class="readPipe CF0802_extraColor">|</span>
				<c:if test="${isPrev}">
					<span class="bltn_label_arrow">▼</span>
					<a onclick="ebRead.readPrevNextBltn('<c:out value="${list.prevBoardId}"/>','<c:out value="${list.prevBltnNo}"/>');"><util:message key='eb.title.Nextpost' /></a>
				</c:if>
				<c:if test="${!isPrev}">
					<span class="bltn_label_arrow nonLink">▼</span>
					<span class="nonLink"><util:message key='eb.title.Nextpost' /></span>
				</c:if>
			</span>
		</div>
		<div class="bltn_control">
			<ul>
			<c:if test="${isNext}">
				<li class="nextBltn">
					<span class="bltn_label_arrow">▲</span>
					<a class="bltn_label" onclick="ebRead.readPrevNextBltn('<c:out value="${list.nextBoardId}"/>','<c:out value="${list.nextBltnNo}"/>')">
						<util:message key='eb.title.Previouspost' />
					</a>
					<span class="readPipe3 CF0802_extraColor">|</span>
					<a class="bltn_link" onclick="ebRead.readPrevNextBltn('<c:out value="${list.nextBoardId}"/>','<c:out value="${list.nextBltnNo}"/>')">
						<c:out value="${list.nextBltnOrgSubj}" escapeXml="false" />
					</a>
					<span class="bltn_regDatim"><c:out value="${list.nextRegDatimSF}"/></span>
				</li>
			</c:if>
			<c:if test="${isPrev}">
				<li class="prevBltn">
					<span class="bltn_label_arrow">▼</span>
					<a class="bltn_label" onclick="ebRead.readPrevNextBltn('<c:out value="${list.prevBoardId}"/>','<c:out value="${list.prevBltnNo}"/>')">
						<util:message key='eb.title.Nextpost' />
					</a>
					<span class="readPipe3 CF0802_extraColor">|</span>
					<a class="bltn_link" onclick="ebRead.readPrevNextBltn('<c:out value="${list.prevBoardId}"/>','<c:out value="${list.prevBltnNo}"/>')">
						<c:out value="${list.prevBltnOrgSubj}" escapeXml="false" />
					</a>
					<span class="bltn_regDatim"><c:out value="${list.prevRegDatimSF}"/></span>
				</li>
			</c:if>
			</ul>
		</div>
		</c:forEach>
	</body>
</html>
