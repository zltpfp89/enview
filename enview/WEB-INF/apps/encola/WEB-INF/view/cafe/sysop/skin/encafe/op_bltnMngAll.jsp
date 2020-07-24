<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.saltware.enboard.vo.BulletinVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="board_btn_wrap">
<%--BEGIN::한줄메모장 본문 풍선글--%>
<c:if test="${opForm.m == 'getBltnCntt'}">
  <table class="table_type01" >
    <tr>
	  <td style="padding:5px;word-wrap:break-word;word-break:break-all">
		<c:out value="${bltnVO.bltnOrgCntt}"/>
	  </td>
	</tr>
  </table>
</c:if>
<%--END::한줄메모장 본문 풍선글--%>
<c:if test="${opForm.m != 'getBltnCntt'}">
	<form id="all_srchForm" name="all_srchForm" method="POST" onsubmit="return false;">
		<div class="board_btn_wrap">
			<div class="board_btn_wrap_left">
				<util:message key="cf.title.postCnt"/> : <strong class="font_blue"><c:out value="${opForm.totalSize}"/></strong>
			</div>
			<div class="board_btn_wrap_right">
				<fieldset>
					<legend><util:message key="eb.title.search"/></legend>
					<select id="srchType" name="srchType">
						<option value="Subj"><util:message key="ev.info.title"/></option>
						<option value="Cntt"><util:message key="eb.info.ttl.bltnCntt"/></option>
						<option value="Nick"><util:message key="eb.info.ttl.author"/></option>
						<option value="Atch"><util:message key="eb.title.attach.file"/></option>
					</select>
					<div>
						<label for="search" class="none">검색어입력</label>
						<input type="text" id="srchKey" name="srchKey" value="<c:out value="${opForm.srchKey}"/>"/>
						<label for="search_submin"></label>
						<input type="submit" value="<util:message key="eb.title.search"/>" class="" id="search_submin" hspace="2"  onclick="cfOp.bltnMng.search('all_srchForm')"/>
					</div>
					<select id="srchBoard" name="srchBoard" onchange="cfOp.bltnMng.search('all_srchForm')">
					  <c:forEach items="${srchBoardList}" var="srchBoard">
					    <option value="<c:out value="${srchBoard.code}"/>" cnttType="<c:out value="${srchBoard.codeTag}"/>" <c:if test="${opForm.srchBoard==srchBoard.code}">selected</c:if>><c:out value="${srchBoard.codeName}"/></option>
					  </c:forEach>
					</select>
					<select id="pageSize" name="pageSize">
					  <c:forEach items="${pageSizeList}" var="pageSize">
					    <option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
					  </c:forEach>
					</select>
				</fieldset>
				<input type="hidden" id="cmd" name="cmd" value="all"/>
				<input type="hidden" id="sortMethod" name="sortMethod" value="<c:out value="${opForm.sortMethod}"/>"/>
				<input type="hidden" id="sortColumn" name="sortColumn"/>
				<input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
				<input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
				<input type="hidden" id="pageFunction" name="pageFunction" value="cfOp.bltnMng.doPage"/>
				<input type="hidden" id="naviDivNm" name="naviDivNm" value="all_PAGE_ITERATOR"/>
			</div>
		</div>
	</form>
	<form id="all_listForm" name="all_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
		<table id="grid-table" class="table_type01" summary="게시판">
			<caption>게시판</caption>
			<colgroup>
				<col width="80px;">
				<col width="auto;">
				<col width="120px;">
				<col width="120px;">
				<col width="120px;">
			</colgroup>
			<thead>
				<tr style="cursor: pointer;">
					<th><input type="checkbox" id="delCheck" class="cafecheckbox" onclick="cfOp.m_checkBox.chkAll(this)"/></th>
					<th><util:message key="ev.info.title"/></th>
					<th><util:message key="eb.info.ttl.author"/></th>
					<th onclick="cfOp.bltnMng.sort('all_srchForm','reg_datim')">
						<span><util:message key="eb.info.ttl.date"/></span>
						<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/<c:if test="${opForm.sortMethod!='ASC'}">tiny_down_arrow.gif</c:if><c:if test="${opForm.sortMethod=='ASC'}">tiny_up_arrow.gif</c:if>" style="margin-left:5px"/></span>	
					</th>
					<th><util:message key="eb.text.views"/></th>
				</tr>
			</thead>
			<tbody id="all_listBody">
			<c:if test="${empty bltnList}">
				<tr>
					<td colspan="5">
					 	<util:message key="cf.error.not.exist.post"/>
					</td>
				</tr>
			</c:if>
			<c:if test="${!empty bltnList}">
				<c:forEach items="${bltnList}" var="bltn" varStatus="status">
				<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="${status.index % 2 != 0}">cafegridline</c:if>">
					<td>
					  <input type="checkbox" id="all_checkRow" name="all_checkRow" value="<c:out value="${bltn.bltnNo}"/>"/>
					</td>
					<td class="left">
					    <font 
						      <c:if test="${boardVO.boardSkin != 'cafe.one'}">
		                        style="cursor:pointer" onmouseout="this.style.textDecoration='none';cfOp.bltnMng.showBltnCntt(false)"
								onmouseover="this.style.textDecoration='underline';cfOp.bltnMng.showBltnCntt(true,'<c:out value="${bltn.boardId}"/>','<c:out value="${bltn.bltnNo}"/>',event)" 
								onclick="cfOp.bltnMng.readBltn('<c:out value="${bltn.boardId}"/>','<c:out value="${bltn.bltnNo}"/>')"
						      </c:if>
						      <c:if test="${boardVO.boardSkin == 'cafe.one'}">
								onmouseout="cfOp.bltnMng.showBltnCntt(false)"
								onmouseover="cfOp.bltnMng.showBltnCntt(true,'<c:out value="${bltn.boardId}"/>','<c:out value="${bltn.bltnNo}"/>',event)" 
						      </c:if>
						>
						  <c:if test="${boardVO.boardSkin != 'cafe.one'}">
						    <%
								String subj = ((BulletinVO)pageContext.getAttribute("bltn")).getBltnSubjEllipsis(41);
							%>
					        <%=subj%>
						  </c:if>
						  <c:if test="${boardVO.boardSkin == 'cafe.one'}">
						    <%
								String cntt = ((BulletinVO)pageContext.getAttribute("bltn")).getBltnCnttEllipsis(41);
							%>
					        <%=cntt%>
						  </c:if>
						</font>
					</td>
					<td><c:out value="${bltn.userNick}"/></td>
					<td><c:out value="${bltn.regDatimSF}"/></td>
					<td><c:out value="${bltn.bltnReadCntCF}"/></td>
				 </tr>
				</c:forEach>
			</c:if>
			</tbody>
		</table>
		<div class="paging  bm50">
			<div id="all_PAGE_ITERATOR"></div>
		</div>	


		<div class="board_btn_wrap tp30">
			<div class="board_btn_wrap_left">
				<c:if test="${langKnd=='ko'}">
					<strong><c:out value="${selectedBoardNm}"/></strong> 의 선택된 게시글을
					<select id="all_changeBrd" name="all_changeBrd" class="lm10">
					  <c:forEach items="${srchBoardList}" var="changeBrd">
						<option value="<c:out value="${changeBrd.code}"/>" cnttType="<c:out value="${changeBrd.codeTag}"/>" <c:if test="${opForm.changeBrd==changeBrd.code}">selected</c:if>><c:out value="${changeBrd.codeName}"/></option>
					  </c:forEach>
					</select>
					으로 
				</c:if>
				<c:if test="${langKnd=='en'}">
					<strong><c:out value="${selectedBoardNm}"/></strong> 's post to
					<select id="all_changeBrd" name="all_changeBrd" class="lm10">
					  <c:forEach items="${srchBoardList}" var="changeBrd">
						<option value="<c:out value="${changeBrd.code}"/>" cnttType="<c:out value="${changeBrd.codeTag}"/>" <c:if test="${opForm.changeBrd==changeBrd.code}">selected</c:if>><c:out value="${changeBrd.codeName}"/></option>
					  </c:forEach>
					</select>
				</c:if>
				<a href="#" onclick="javascript:cfOp.bltnMng.moveBulletin('MOVE')" class="btn white"><util:message key="mm.title.move"/></a>
				<a href="#" onclick="javascript:cfOp.bltnMng.moveBulletin('DELETE')" class="btn white"><util:message key="ev.title.remove"/></a>
			</div>
		</div>
		<input type="hidden" id="boardId" name="boardId"/>
		<input type="hidden" id="bltnNo"  name="bltnNo"/>
	</form>
</c:if>
</div>

