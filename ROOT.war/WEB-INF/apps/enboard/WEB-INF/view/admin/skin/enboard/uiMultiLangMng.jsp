<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<form id="multiLangListForm" style="display:inline" name="multiLangListForm" action="" method="post" onsubmit="return false;">
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
		<caption>게시판</caption>
		<colgroup>
			<col width="50px" />
			<col width="50px" />
			<col width="*" />
		</colgroup>
		<thead>
			<tr>
				<th class="first">
					<input type="checkbox" id="delCheck" onclick="ebUtil.getMLMngr().m_checkBox.chkAll(this)"/>
				</th>
				<th class="C" ch="0" align="center"><span>언어</span></th>
				<c:if test="${abForm.tblNm == 'board'}">
					<th class="C" ch="0"><span>게시판 명</span></th>
					<th class="C" ch="0"><span>게시판 타이틀</span></th>
				</c:if>
				<c:if test="${abForm.tblNm == 'poll'}">
					<th class="C" ch="0"><span>설문 명</span></th>
					<th class="C" ch="0"><span>설문 설명</span></th>
				</c:if>
				<c:if test="${abForm.tblNm == 'bltnCate'}">
					<th class="C" ch="0"><span>카테고리 명</span></th>
				</c:if>
				<c:if test="${abForm.tblNm == 'bltnExtnProp'}">
					<th class="C" ch="0"><span>확장필드 타이틀</span></th>
				</c:if>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${multiLangList}" varStatus="status">
				<tr height=22 <c:if test="${status.index % 2 == 1 }">class='L'</c:if>>
				  <td class='L'>
					<input type="checkbox" id="multiLang_checkRow_<c:out value="${status.index}"/>" name="multiLang_checkRow" value="<c:out value="${list.langKnd}"/>"
					  <c:if test="${abForm.tblNm == 'board' || abForm.tblNm == 'poll'}">boardNm="<c:out value="${list.boardNm}"/>" boardTtl="<c:out value="${list.boardTtl}"/>"</c:if>
					  <c:if test="${abForm.tblNm == 'bltnCate'}">cateNm="<c:out value="${list.cateNm}"/>"</c:if>
					  <c:if test="${abForm.tblNm == 'bltnExtnProp'}">title="<c:out value="${list.title}"/>"</c:if>
					>
				  </td>
				  <td class='L' onclick="ebUtil.getMLMngr().doSelect(<c:out value="${status.index}"/>)"><c:out value="${list.langKnd}"/></td>
				  <td class='L' onclick="ebUtil.getMLMngr().doSelect(<c:out value="${status.index}"/>)">
					  <c:if test="${abForm.tblNm == 'board' || abForm.tblNm == 'poll'}"><c:out value="${list.boardNm}"/></td></c:if>
					  <c:if test="${abForm.tblNm == 'bltnCate'}"><c:out value="${list.cateNm}"/></td></c:if>
					  <c:if test="${abForm.tblNm == 'bltnExtnProp'}"><c:out value="${list.title}"/></td></c:if>
				  <c:if test="${abForm.tblNm == 'board' || abForm.tblNm == 'poll'}">
					<td class='L' onclick="ebUtil.getMLMngr().doSelect(<c:out value="${status.index}"/>)"><c:out value="${list.boardTtl}"/></td>
				  </c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- btnArea-->
	<div class="btnArea"> 
		<div class="rightArea">
			<a href="#none" onclick="ebUtil.getMLMngr().doCreate()" class="btn_B"><span>신규</span></a>
			<a href="#none" onclick="ebUtil.getMLMngr().doDelete()" class="btn_B"><span>삭제</span></a>
		</div>
	</div>
	<!-- btnArea//-->
</form>

<div id="multiLangEditDiv" style="display:none;">
	<form id="multiLangEditForm" style="display:inline" name="multiLangEditForm" action="" method="post" onsubmit="return false;">
	  <input type="hidden" id="multiLang_act"/>
	  <table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
			<caption>게시판</caption>
			<colgroup>
				<col width="100px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th class="L">언어</th>
					<td class="L">
						<div class="sel_100">
							<select id="multiLang_langKnd" class="txt_100">
								<c:forEach items="${langList}" var="lang">
									<option value="<c:out value="${lang.code}"/>"><c:out value="${lang.codeName}"/></option>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th class="L">
						<c:if test="${abForm.tblNm == 'board'}">&nbsp;게시판 명</c:if>
						<c:if test="${abForm.tblNm == 'poll'}">&nbsp;설문 명</c:if>
						<c:if test="${abForm.tblNm == 'bltnCate'}">&nbsp;카테고리 명</c:if>
						<c:if test="${abForm.tblNm == 'bltnExtnProp'}">&nbsp;확장필드 타이틀</c:if>
					</th>
					<td class="L"><input type="text" id="multiLang_title1" name="multiLang_title1" size="20" maxLength="50" required="true" class="txt_400"/></td>
				</tr>
				<c:if test="${abForm.tblNm == 'board' || abForm.tblNm == 'poll'}">
					<tr>
						<th class="L">
							<c:if test="${abForm.tblNm == 'board'}">게시판 타이틀</c:if>
							<c:if test="${abForm.tblNm == 'poll'}">설문 설명</c:if>
						</th>
						<td class="L"><input type="text" id="multiLang_title2" name="multiLang_title2" size="20" maxLength="50" required="true" class="txt_400"/></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<!-- btnArea-->
		<div class="btnArea"> 
			<div class="rightArea">
				<a href="#none" onclick="ebUtil.getMLMngr().doSave()" class="btn_B"><span>저장</span></a>
			</div>
		</div>
		<!-- btnArea//-->
	</form>
</div>