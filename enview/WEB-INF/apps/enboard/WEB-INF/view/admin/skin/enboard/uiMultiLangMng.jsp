<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
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
				<th class="C" ch="0" align="center"><span><util:message key="eb.title.lang"/></span></th>
				<c:if test="${abForm.tblNm == 'board'}">
					<th class="C" ch="0"><span><util:message key="eb.prop.boardNm"/></span></th>
					<th class="C" ch="0"><span><util:message key="eb.prop.boardTtl"/></span></th>
				</c:if>
				<c:if test="${abForm.tblNm == 'poll'}">
					<th class="C" ch="0"><span><util:message key="eb.title.o.pollNm"/></span></th>
					<th class="C" ch="0"><span><util:message key="eb.title.explain.survey"/></span></th>
				</c:if>
				<c:if test="${abForm.tblNm == 'bltnCate'}">
					<th class="C" ch="0"><span><util:message key="eb.title.cateNm"/></span></th>
				</c:if>
				<c:if test="${abForm.tblNm == 'bltnExtnProp'}">
					<th class="C" ch="0"><span><util:message key="eb.title.extendField.title"/></span></th>
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
			<a href="#none" onclick="ebUtil.getMLMngr().doCreate()" class="btn_B"><span><util:message key="ev.title.new"/></span></a>
			<a href="#none" onclick="ebUtil.getMLMngr().doDelete()" class="btn_B"><span><util:message key="ev.title.remove"/></span></a>
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
					<th class="L"><util:message key="eb.title.lang"/></th>
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
						<c:if test="${abForm.tblNm == 'board'}">&nbsp;<util:message key="eb.prop.boardNm"/></c:if>
						<c:if test="${abForm.tblNm == 'poll'}">&nbsp;<util:message key="eb.title.o.pollNm"/></c:if>
						<c:if test="${abForm.tblNm == 'bltnCate'}">&nbsp;<util:message key="eb.title.cateNm"/></c:if>
						<c:if test="${abForm.tblNm == 'bltnExtnProp'}">&nbsp;<util:message key="eb.title.extendField.title"/></c:if>
					</th>
					<td class="L"><input type="text" id="multiLang_title1" name="multiLang_title1" size="20" maxLength="50" required="true" class="txt_400"/></td>
				</tr>
				<c:if test="${abForm.tblNm == 'board' || abForm.tblNm == 'poll'}">
					<tr>
						<th class="L">
							<c:if test="${abForm.tblNm == 'board'}"><util:message key="eb.prop.boardTtl"/></c:if>
							<c:if test="${abForm.tblNm == 'poll'}"><util:message key="eb.title.explain.survey"/></c:if>
						</th>
						<td class="L"><input type="text" id="multiLang_title2" name="multiLang_title2" size="20" maxLength="50" required="true" class="txt_400"/></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<!-- btnArea-->
		<div class="btnArea"> 
			<div class="rightArea">
				<a href="#none" onclick="ebUtil.getMLMngr().doSave()" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
			</div>
		</div>
		<!-- btnArea//-->
	</form>
</div>