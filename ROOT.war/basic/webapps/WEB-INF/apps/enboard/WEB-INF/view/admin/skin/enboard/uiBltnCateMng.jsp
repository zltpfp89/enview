<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<c:if test="${!empty boardVO}">
	<c:if test="${boardVO.boardId != boardVO.boardRid || boardVO.mergeType != 'A'}">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="*" />
			</colgroup>	
			<tr>
				<td>
					<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
					<c:choose>
						<c:when test="${boardVO.boardId != boardVO.boardRid}">
						선택된 게시판 <font color='blue'>"<c:out value="${boardVO.boardTtl}"/>"(게시판 아이디:<c:out value="${boardVO.boardId}"/>)</font>은 <font color='red'><b>"가상 게시판"</b></font>입니다.
						</c:when>
						<c:when test="${boardVO.mergeType == 'G'}">
						선택된 게시판 <font color='blue'>"<c:out value="${boardVO.boardTtl}"/>"(게시판 아이디:<c:out value="${boardVO.boardId}"/>)</font>은 <font color='red'><b>"나만의 자료실형 게시판"</b></font>입니다.
						</c:when>
						<c:when test="${boardVO.mergeType == 'H'}">
						선택된 게시판 <font color='blue'>"<c:out value="${boardVO.boardTtl}"/>"(게시판 아이디:<c:out value="${boardVO.boardId}"/>)</font>은 <font color='red'><b>"내게 온 글형 게시판"</b></font>입니다.
						</c:when>
						<c:otherwise>
						선택된 게시판 <font color='blue'>"<c:out value="${boardVO.boardTtl}"/>"(게시판 아이디:<c:out value="${boardVO.boardId}"/>)</font>은 <font color='red'><b>"통합형 게시판"</b></font>입니다.
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
		</c:if>
	<c:if test="${boardVO.boardId == boardVO.boardRid && boardVO.mergeType == 'A'}">
		<form id="bltnCateMngForm" name="bltnCateMngForm" onsubmit="return false">
			<input type="hidden" id="base_selected_bltnCateId" />
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="30px" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
				</colgroup>	
				<thead>
					<tr>
						<th class="first"><span class="table_title">선택</span></th>
						<th class="C"><span class="table_title">카테고리 아이디</span></th>
						<th class="C"><span class="table_title">순서</span></th>
						<th class="C"><span class="table_title">카테고리 명</span></th>
						<th class="C"><span class="table_title">카테고리 등록일</span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${bltnCateList}" varStatus="status">
						<tr>
							<td class="first">
								<input	type="checkbox" id="bltnCate_checkRow_<c:out value="${status.index}"/>" name="bltnCate_checkRow" value="<c:out value="${list.bltnCateId}"/>"
										bltnCateOrder="<c:out value="${list.bltnCateOrder}"/>" bltnCateNm="<c:out value="${list.bltnCateNm}"/>"
								>
							</td>
							<td class="C" onclick="aBM.getBltnCateMngr().doSelect('<c:out value="${status.index}"/>')"><c:out value="${list.bltnCateId}"/></td>
							<td class="C" onclick="aBM.getBltnCateMngr().doSelect('<c:out value="${status.index}"/>')"><c:out value="${list.bltnCateOrder}"/></td>
							<td class="C" onclick="aBM.getBltnCateMngr().doSelect('<c:out value="${status.index}"/>')"><c:out value="${list.bltnCateNm}"/></td>
							<td class="C" onclick="aBM.getBltnCateMngr().doSelect('<c:out value="${status.index}"/>')"><c:out value="${list.updDatimF}"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!-- btnArea-->
			<div class="btnArea"> 
				<div class="rightArea">
					<a href="javascript:aBM.getBltnCateMngr().doCreate()" class="btn_B"><span>신규</span></a>
					<a href="javascript:aBM.getBltnCateMngr().doDelete()" class="btn_B"><span>삭제</span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</form>
	
		<div id="bltnCateEditDiv" style="display:none;">
			<form id="bltnCateEditForm" style="display:inline" name="bltnCateEditForm" action="" method="post" onsubmit="return false;">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="140px" />
						<col width="*" />
						<col width="140px" />
						<col width="*" />
					</colgroup>	
					<tr class="first">
						<th class="L ">카테고리 아이디</th>
						<td class="L"><input type='text' id='base_bltnCateId' maxlength='10' size='16' class="txt_100"></td>
						<th class="L">카테고리 순서</th>
						<td class="L"><input type='text' id='base_bltnCateOrder' maxlength='3' size='3' class="txt_100"></td>
					</tr>
					<tr>	
						<th class="L">카테고리 명</th>
						<td class='L' colspan="3">
							<input type='text' id='base_bltnCateNm' maxlength='120' size='21' class="txt_400">
							<a href="javascript:aBM.getBltnCateMngr().doShowMultiLangMngr()" class="btn_B"><span>제목</span></a>
						</td>
					</tr>
				</table>
			</form>
			<!-- btnArea-->
			<div class="btnArea" id="bltnCateEditBtnTable"> 
				<div class="rightArea">
					<a href="javascript:aBM.getBltnCateMngr().doSave()" class="btn_O"><span>저장</span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</div>
	</c:if>
</c:if>