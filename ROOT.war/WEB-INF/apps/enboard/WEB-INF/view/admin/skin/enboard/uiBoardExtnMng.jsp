<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
		<!-- actnAccordion -->
		<div id="extnAccordion">
			<h3><a href="#">확장필드</a></h3>
	        <div class="board">
	        	<c:if test="${boardVO.boardId == boardVO.boardRid}">
					<c:if test="${boardVO.extUseYn == 'N'}">
						<table cellpadding="0" cellspacing="0" border="0" class="table_board">
							<tr>
								<td class="L">
									선택된 게시판 <font color='blue'>"<c:out value="${boardVO.boardTtl}"/>"(게시판 아이디:<c:out value="${boardVO.boardId}"/>)</font>은 <font color='red'><b>"확장필드 미사용"</b></font>으로 설정되어 있습니다.
								</td>
							</tr>
						</table>
					</c:if>	        		
		        	<c:if test="${boardVO.extUseYn == 'Y'}">
						<form id="bltnExtnPropMngForm" name="bltnExtnPropMngForm" onsubmit="return false">
							<input type=hidden id="extn_selected_fldNm" />
							<input type=hidden id="extn_act" />
							<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
								<caption>게시판</caption>
								<colgroup>
									<col width="30px"/>
									<col width="*"/>
									<col width="*"/>
									<col width="*"/>
									<col width="*"/>
									<col width="*"/>
								</colgroup>
								<thead>
									<tr>
										<th class="first">선택</th>
										<th class="C"><span class="table_title">확장필드명</span></th>
										<th class="C"><span class="table_title">타이틀</span></th>
										<th class="C"><span class="table_title">사용 여부</span></th>
										<th class="C"><span class="table_title">목록 화면</span></th>
										<th class="C"><span class="table_title">검색 조건</span></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${bltnExtnPropList}" var="list" varStatus="status">
										<tr>
											<td class="C">
												<input type="checkbox" id="extn_checkRow_<c:out value="${status.index}"/>" name="extn_checkRow" value="<c:out value="${list.fldNm}"/>"
													useYn="<c:out value="${list.useYn}"/>" ttlYn="<c:out value="${list.ttlYn}"/>" srchYn="<c:out value="${list.srchYn}"/>"
													dataType="<c:out value="${list.dataType}"/>" utilClassNm="<c:out value="${list.utilClassNm}"/>" title="<c:out value="${list.title}"/>"
											>
											</td>
											<td class="L" onclick="aBM.getExtnMngr().doSelect('<c:out value="${status.index}"/>')"><c:out value="${list.fldNm}"/></td>
											<td class="L" onclick="aBM.getExtnMngr().doSelect('<c:out value="${status.index}"/>')"><c:out value="${list.title}"/></td>
											<td class="L" onclick="aBM.getExtnMngr().doSelect('<c:out value="${status.index}"/>')"><c:out value="${list.useYn}"/></td>
											<td class="L" onclick="aBM.getExtnMngr().doSelect('<c:out value="${status.index}"/>')"><c:out value="${list.ttlYn}"/></td>
											<td class="C" onclick="aBM.getExtnMngr().doSelect('<c:out value="${status.index}"/>')"><c:out value="${list.srchYn}"/></td>
										</tr>
									</c:forEach>
								</tbody>														
							</table>
							<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
								<!-- btnArea-->
								<div class="btnArea">
									<div class="leftArea">
										<a href="javascript:aBM.getExtnMngr().doShowMultiLangMngr()" class="btn_B"><span>제목</span></a>
									</div>
									<div class="rightArea">
										<a href="javascript:aBM.getExtnMngr().doCreate()" class="btn_O"><span>신규</span></a>
										<a href="javascript:aBM.getExtnMngr().doDelete()" class="btn_O"><span>삭제</span></a>
									</div>
								</div>
								<!-- btnArea//-->					
							</c:if>
						</form>
						<div id="bltnExtnPropEditDiv" style="width:100%; display:none;">
							<form id="bltnExtnPropEditForm" style="display:inline" name="bltnExtnPropEditForm" action="" method="post" onsubmit="return false;">
								<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
									<colgroup >
										<col width="210px"/>
										<col width="25%"/>
										<col width="25%"/>
										<col width="25%"/>
									</colgroup>
									<tr>
										<th class="L">확장 필드 명</td>
										<td class="L"><input type='text' id='extn_fldNm' class="txt_100per" maxlength=30></td>
										<th class="L">사용 여부</td>
										<td class="L">
											<c:forEach	items="${radioList}" var="list">
												<input type=radio name="extn_useYn" value="<c:out value="${list.code}"/>" <c:if test="${list.code=='N'}">checked</c:if>>
												<label>&nbsp;<c:out value="${list.codeName}"/>&nbsp;&nbsp;</label>
											</c:forEach>
										</td>
									</tr>
									<tr>
										<th class="L" >목록화면 노출 여부</td>
										<td class="L">
											<c:forEach	items="${radioList}" var="list">
												<input type=radio name="extn_ttlYn" value="<c:out value="${list.code}"/>" <c:if test="${list.code=='N'}">checked</c:if>>
												<label>&nbsp;<c:out value="${list.codeName}"/>&nbsp;&nbsp;</label>
											</c:forEach>
										</td>
										<th class="L" >검색조건 사용 여부</td>
										<td class="L">
											<c:forEach	items="${radioList}" var="list">
												<input type=radio name="extn_srchYn" value="<c:out value="${list.code}"/>" <c:if test="${list.code=='N'}">checked</c:if>>
												<label>&nbsp;<c:out value="${list.codeName}"/>&nbsp;&nbsp;</label>
											</c:forEach>
										</td>
									</tr>
									
									<tr>
										<th class="L">데이터 유형</td>
										<td class="L" colspan="3">
											<div class="sel_100">
												<select id="extn_dataType" class="txt_100"> 
													<c:forEach items="${dataTypeList}" var="list">
														<option value="<c:out value="${list.code}"/>"><c:out value="${list.codeName}"/>
													</c:forEach>
												</select>
											</div>
										</td>
									</tr>
									
									<tr>
										<th class="L" >확장필드 타이틀</td>
										<td class="L" colspan="3"><input type=text id="extn_title" class="txt_100per" maxlength=50></td>
									</tr>
									
									<tr>
										<th class="L">필드 조작 유틸 클래스 명</td>
										<td class="L" colspan="3"><input type=text id="extn_utilClassNm" class="txt_100per" maxlength=60></td>
									</tr>									
								</table>
								<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
									<!-- btnArea-->
									<div class="btnArea"> 
										<div class="rightArea">
											<a href="javascript:aBM.getExtnMngr().doSave()" class="btn_O"><span>저장</span></a>
										</div>
									</div>
									<!-- btnArea//-->
								</c:if>								
							</form>
						</div>
		        	</c:if>
	        	</c:if>
	        </div>
		</div>
		<!-- actnAccordion// -->