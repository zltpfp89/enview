<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.saltware.enboard.vo.BulletinVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld"%>
<c:set var="frameType"  value="${param.frameType}"/>
<c:set var="brdGrpType" value="${param.brdGrpType}"/>
<c:set var="brdType"    value="${param.brdType}"/>
<div class="title_box">
	<a class="boardName CF0501_nmFontColor CF0501_nmFontNm" href="<%= request.getContextPath()%>/board/list.brd?boardId=<c:out value="${boardVO.boardId}"/>&listOpt=selectMenu"><c:out value="${boardVO.boardNm}"/></a>	
</div>
<div class="boardList one_box CF0802_bgColor">
	<div class="one_desc"><c:out value="${boardVO.boardNm}"/></div>
	<c:if test="${boardVO.writableYn == 'Y' and boardVO.mergeType == 'A'}">
	<form name="editForm" onsubmit="return false">
		<%--if 익명글 --%>
	    <c:if test="${boardVO.ableAnonYn == 'Y'}">
	    <c:if test="${secPmsnVO.isLogin == 'true'}">
	    <div style="float:right;margin-right: 20px">
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
        </div>
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
	
		<input type="hidden" id="bltnSubj" name="bltnSubj" value="<util:message key='cf.title.oneMemo' />"/>
		<div class="one_cntt_div">
			<textarea id="editorCntt" class="one_cntt CF0802_extraBgColor CF0802_extraBrdrColor" name="editorCntt"></textarea>
			<input type="hidden" name="bltnOrgCntt">
			<div class="one_cntt_limit"><util:message key='cf.title.Max' /> 2000 Byte
			<input type="hidden" id="editorCnttMaxBytes" name="editorCnttMaxBytes" value="2000">
			</div>
		</div>
		<div class="editor_btn_div">
				<a class="editor_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" onclick="javascript:ebList.saveOnList();return false;">
					<span class="btn_bg bg01"></span><span class="btn_txt bt01" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>"><util:message key='ev.hnevent.label.reg' /></span>
				</a>
		</div>
	</form>
	</c:if>
	<div class="one_list">
		<table class="listTable"> 
			<!-- Bulletins are not exist.. -->
			<c:if test="${empty bltnList}">
				<tr class="listTr one CF0802_extraBrdrColor" align="center">
					<td class="listTd one"><util:message key='cf.error.not.exist.post' /></td>
				</tr>
				<tr class="listTr CF0802_extraBrdrColor">
					<td class="listTd"></td>
				</tr>
			</c:if>
			<!-- List of Bulletin -->
			<c:if test="${!empty bltnList}">
			<c:forEach items="${bltnList}" var="list" varStatus="status">	
			<tr class="listTr one CF0802_extraBrdrColor">
				<td class="listTd one">
					<span class="one_userNick"><c:out value="${list.userNick}"/></span>
					<span class="one_regDatim"><c:out value="${list.smartRegDatimSF}"/></span>
					<span class="mini_btn">
					<c:if test="${boardVO.replyableYn == 'Y' && boardVO.replyYn == 'Y'}">
						<a style=cursor:pointer onclick="ebList.actionOnList('reply',<c:out value="${list.bltnNo}"/>)">
							<c:out value="${boardVO.imgReply}" escapeXml="false"/>
						</a>&nbsp;
					</c:if>
					<c:if test="${list.editable == 'true'}"><%--수정권한이 있는 경우--%>
						<a style=cursor:pointer onclick="ebList.securityOnList('modify',<c:out value="${list.bltnNo}"/>,true)">
							<img src="<%=request.getContextPath()%>/cola/cafe/images/each/encafe/cntt/btn_upd.gif"/>
						</a>&nbsp;
					</c:if>
					<c:if test="${list.editable == 'false'}"><%--수정권한이 없는 경우--%>
						<c:if test="${empty list.userId}"><%--익명글이면--%>
							<c:if test="${list.editableUserId == '_is_admin_'}"><%--관리자인 경우--%>
								<a style=cursor:pointer onclick="ebList.securityOnList('modify',<c:out value="${list.bltnNo}"/>,true)">
									<img src="<%=request.getContextPath()%>/cola/cafe/images/each/encafe/cntt/btn_upd.gif"/>
								</a>&nbsp;
							</c:if>
							<c:if test="${list.editableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
								<c:if test="${boardVO.writableYn == 'Y'}">
									<a style=cursor:pointer onclick="ebList.securityOnList('modify',<c:out value="${list.bltnNo}"/>,false)">
										<img src="<%=request.getContextPath()%>/cola/cafe/images/each/encafe/cntt/btn_upd.gif"/>
									</a>&nbsp;
								</c:if>
							</c:if>
						</c:if>
					</c:if>
					<c:if test="${list.deletable == 'true'}"><%--삭제권한이 있는 경우--%>
						<a style=cursor:pointer onclick="ebList.securityOnList('delete',<c:out value="${list.bltnNo}"/>,true)">
							<img src="<%=request.getContextPath()%>/cola/cafe/images/each/encafe/cntt/btn_del.gif"/>
						</a>&nbsp;
					</c:if>
					<c:if test="${list.deletable == 'false'}"><%--삭제권한이 없는 경우--%>
						<c:if test="${empty list.userId}"><%--익명글이면--%>
							<c:if test="${list.deletableUserId == '_is_admin_'}"><%--관리자인 경우--%>
								<a style=cursor:pointer onclick="ebList.securityOnList('delete',<c:out value="${list.bltnNo}"/>,true)">
									<img src="<%=request.getContextPath()%>/cola/cafe/images/each/encafe/cntt/btn_del.gif"/>
								</a>&nbsp;
							</c:if>
							<c:if test="${list.deletableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
								<c:if test="${boardVO.writableYn == 'Y'}">
									<a style=cursor:pointer onclick="ebList.securityOnList('delete',<c:out value="${list.bltnNo}"/>,false)">
										<img src="<%=request.getContextPath()%>/cola/cafe/images/each/encafe/cntt/btn_del.gif"/>
									</a>&nbsp;
								</c:if>
							</c:if>
						</c:if>  
					</c:if>
					</span>
				</td>
			</tr>
			<tr class="listTr one2 CF0802_extraBrdrColor">
				<td class="listTd one2">
					<input type="hidden" id="bltnCntt<c:out value="${list.bltnNo}"/>" value="<c:out value="${list.bltnCntt}"/>"/>
					<c:out value="${list.bltnCntt}"/>
					<c:if test="${boardVO.ttlNewYn == 'Y'}">
						<span style="padding-right:10px"><c:if test="${list.recentBltn == 'Y'}"><img src="<%=request.getContextPath()%>/board/images/board/skin/cafe.one/imgNew.gif"/></c:if></span>
					</c:if>
				</td>
			</tr>
			</c:forEach>
			</c:if>		
		</table>
		<div class="pageIndex CF0802_extraBrdrColor" id="pageIndex"></div>
	</div>	
</div>
<script type="text/javascript">
	var currentPage = <c:out value="${boardSttVO.page}"/>;
	var totalPage   = <c:out value="${boardSttVO.totalPage}"/>;
	var setSize     = 10; <%--하단 Page Iterator에서의 Navigation 갯수--%>
	var imgUrl      = "<%=request.getContextPath()%>/board/images/board/skin/enboard/";
	var color       = "808080";
	
	var afpImg = "imgFirstActive.gif";
	var pfpImg = "imgFirstPassive.gif";
	var alpImg = "imgLastActive.gif";
	var plpImg = "imgLastPassive.gif";
	var apsImg = "imgPrev10Active.gif";
	var ppsImg = "imgPrev10Passive.gif";
	var ansImg = "imgNext10Active.gif";
	var pnsImg = "imgNext10Passive.gif";
	
	var startPage;    
	var endPage;      
	var cursor;      
	var curList = "";
	var prevSet = "";
	var nextSet = "";
	var firstP  = "";
	var lastP   = "";

	moduloCP = (currentPage - 1) % setSize / setSize ;
	startPage = Math.ceil((((currentPage - 1) / setSize) - moduloCP)) * setSize + 1;
	moduloSP = ((startPage - 1) + setSize) % setSize / setSize;
	endPage   = Math.ceil(((((startPage - 1) + setSize) / setSize) - moduloSP)) * setSize;

	if (totalPage <= endPage) endPage = totalPage;
		
	if (currentPage > setSize) {
		firstP = "<font onclick=ebList.next('1') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		firstP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+afpImg+"' align=absmiddle border=0 alt='맨 앞 페이지로 가기'></font>";
		cursor = startPage - 1;
		prevSet = "<font onclick=ebList.next('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		prevSet += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+apsImg+"' align=absmiddle border=0 alt='열 페이지 앞으로 가기'></font>";
	} else {
		firstP  = "<img src='"+imgUrl+pfpImg+"' align=absmiddle border=0>"; 
		prevSet = "<img src='"+imgUrl+ppsImg+"' align=absmiddle border=0>"; 
	}
		
	cursor = startPage;
	while( cursor <= endPage ) {
		if( endPage == 1 ) {
			curList = "<font class='curPage' color=#"+color+">"+currentPage+"</font>";
		}
		else if( cursor == currentPage ) 
			curList += "<font class='curPage' color=#"+color+">"+currentPage+"</font>&nbsp;";
		else if( cursor == endPage ) 
			curList += "<font class='page' onclick=ebList.next('"+cursor+"')>"+cursor+"</font>";
		else {
			curList += "<font class='page' onclick=ebList.next('"+cursor+"')>"+cursor+"</font>&nbsp;";
		}
		
		cursor++;
	}
	
	if( endPage == 0 ) {
			curList = "<font class='curPage' color=#"+color+">"+currentPage+"</font>";
		}
			 
	if ( totalPage > endPage) {
		lastP = "<font onclick=ebList.next('"+totalPage+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		lastP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+alpImg+"' align=absmiddle border=0 alt='맨 끝 페이지로 가기'></font>";
		cursor = endPage + 1;  
		nextSet = "<font onclick=ebList.next('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		nextSet += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+ansImg+"' align=absmiddle border=0 alt='열 페이지 뒤로 가기'></font>";
	} else {
		lastP  = "<img src='"+imgUrl+plpImg+"' align=absmiddle border=0>"; 
		nextSet = "<img src='"+imgUrl+pnsImg+"' align=absmiddle border=0>"; 
	}
	
	curList = firstP +"&nbsp;"+ prevSet +"&nbsp;&nbsp;"+ curList +"&nbsp;&nbsp;"+ nextSet +"&nbsp;"+ lastP;
	
	document.getElementById("pageIndex").innerHTML = curList;
</script>