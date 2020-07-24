<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.saltware.enboard.vo.BulletinVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%--BEGIN::한줄메모장 본문 풍선글--%>
<c:if test="${opForm.m == 'getBltnCntt'}">
  <table>
    <tr>
	  <td style="padding:5px;word-wrap:break-word;word-break:break-all">
		<c:out value="${bltnVO.bltnOrgCntt}"/>
	  </td>
	</tr>
  </table>
</c:if>
<%--END::한줄메모장 본문 풍선글--%>
<c:if test="${opForm.m != 'getBltnCntt'}">
<div class="cafepanel" style="width:100%;">
  <br style='line-height:5px;'>
  <div>
	<form id="all_srchForm" name="all_srchForm" method="POST" onsubmit="return false;">
	  <table width="100%">
	    <tr>
		  <td align="left">
		    <span style="margin:0px 10px 0px 30px"><b>게시글 건수:</b></span><c:out value="${opForm.totalSize}"/>
		  </td>
		  <td align="right">
			<select id="srchType" name="srchType">
			  <option value="Subj" <c:if test="${opForm.srchType=='Subj'}">selected</c:if>>제    목</option>
			  <option value="Cntt" <c:if test="${opForm.srchType=='Cntt'}">selected</c:if>>본    문</option>
			  <option value="Nick" <c:if test="${opForm.srchType=='Nick'}">selected</c:if>>작 성 자</option>
			  <option value="Atch" <c:if test="${opForm.srchType=='Atch'}">selected</c:if>>첨부파일</option>
			</select>
			<input type="text" id="srchKey" name="srchKey" value="<c:out value="${opForm.srchKey}"/>"/>
			<img src="<%=request.getContextPath()%>/cola/cafe/images/button/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand" onclick="cfOp.bltnMng.search('all_srchForm')"/>
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
			<%--input type="button" id="all_btnDtlSrch" name="all_btnDtlSrch" value="상세검색" onclick="cfOp.bltnMng.toggleDtlSrchAll()"/--%>
		  </td>
	  </tr>
	  </table>    
	  <input type="hidden" id="cmd" name="cmd" value="all"/>
	  <input type="hidden" id="sortMethod" name="sortMethod" value="<c:out value="${opForm.sortMethod}"/>"/>
	  <input type="hidden" id="sortColumn" name="sortColumn"/>
	  <input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
	  <input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
	  <input type="hidden" id="pageFunction" name="pageFunction" value="cfOp.bltnMng.doPage"/>
	  <input type="hidden" id="naviDivNm" name="naviDivNm" value="all_PAGE_ITERATOR"/>
	</form>
  </div>
  <div class="cafegridpanel">
	<form id="all_listForm" name="all_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr><td height="2" colspan="100" class="cafegridlimit"></td></tr>
		  <tr style="cursor: pointer;">
			<th class="cafegridheader" align="center" width="30px">
			  <input type="checkbox" id="delCheck" class="cafecheckbox" onclick="cfOp.m_checkBox.chkAll(this)"/>
			</th>
			<th class="cafegridheader"><span>제    목</span></th>
			<th class="cafegridheader"><span>작성자</span></th>
			<th class="cafegridheader" onclick="cfOp.bltnMng.sort('all_srchForm','reg_datim')"><span>작성일</span>
			  <img src="<%=request.getContextPath()%>/cola/cafe/images/<c:if test="${opForm.sortMethod!='ASC'}">tiny_down_arrow.gif</c:if><c:if test="${opForm.sortMethod=='ASC'}">tiny_up_arrow.gif</c:if>" style="margin-left:5px"/></span>
			</th>	
			<th class="cafegridheaderlast"><span>조회수</span></th>
		  </tr>
		</thead>
		<tbody id="all_listBody">
		<c:forEach items="${bltnList}" var="bltn" varStatus="status">
		  <tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="${status.index % 2 != 0}">cafegridline</c:if>"
              onmouseover="ebUtil.activeLine(this,true)" onmouseout="ebUtil.activeLine(this,false)">
			<td align="center" class="cafegrid">
			  <input type="checkbox" id="all_checkRow" name="all_checkRow" class="cafecheckbox" value="<c:out value="${bltn.bltnNo}"/>"/>
			</td>
			<td align="left" class="cafegrid" style="width:40%">
			  <span style="margin-left:10px">
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
			  </span>
			</td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${bltn.userNick}"/></span></td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${bltn.regDatimSF}"/></span></td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${bltn.bltnReadCntCF}"/></span></td>
		  </tr>
		</c:forEach>
		  <tr><td height="2" colspan="100" class="cafegridlimit"></td></tr>
		  <tr><td colspan="100" height="20" align="center"><div id="all_PAGE_ITERATOR"></div></td></tr>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr>
		    <td colspan="100">
			  <span style="margin-left:30px"><b><c:out value="${selectedBoardNm}"/></b>의 선택된 게시글</span>
			  <span style="margin-left:10px">
				<select id="all_changeBrd" name="all_changeBrd">
				  <c:forEach items="${srchBoardList}" var="changeBrd">
					<option value="<c:out value="${changeBrd.code}"/>" cnttType="<c:out value="${changeBrd.codeTag}"/>" <c:if test="${opForm.changeBrd==changeBrd.code}">selected</c:if>><c:out value="${changeBrd.codeName}"/></option>
				  </c:forEach>
				</select>
				으로
				<input type="button" value="이동" style="cursor:pointer" onclick="cfOp.bltnMng.moveBulletin('MOVE')"/>
			  </span>
			  <span style="margin-left:30px">
				<input type="button" value="삭제"  style="cursor:pointer" onclick="cfOp.bltnMng.moveBulletin('DELETE')"/>
				<%--input type="button" value="스팸처리" style="cursor:pointer" onclick="cfOp.bltnMng.moveBulletin('SPAM')"/--%>
			  </span>
			</td>
		  </tr>
		</tbody>
	  </table>
	  <input type="hidden" id="boardId" name="boardId"/>
	  <input type="hidden" id="bltnNo"  name="bltnNo"/>
	</form>
  </div>
</div>
</c:if>