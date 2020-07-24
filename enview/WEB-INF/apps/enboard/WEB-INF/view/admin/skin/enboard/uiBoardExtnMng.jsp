<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
		<!-- actnAccordion -->
		<div id="extnAccordion">
			<h3><a href="#"><util:message key="eb.title.extn.prop"/></a></h3>
	        <div class="board">
	        	<c:if test="${boardVO.boardId == boardVO.boardRid}">
					<c:if test="${boardVO.extUseYn == 'N'}">
						<table cellpadding="0" cellspacing="0" border="0" class="table_board">
							<tr>
								<td class="L">
									<util:message key="eb.info.notUse.extendField"/>
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
										<th class="first"><util:message key="ev.hnevent.label.select"/></th>
										<th class="C"><span class="table_title"><util:message key="eb.title.extendField.Name"/></span></th>
										<th class="C"><span class="table_title"><util:message key="mm.title.title"/></span></th>
										<th class="C"><span class="table_title"><util:message key="ev.prop.lang.langUseYn"/></span></th>
										<th class="C"><span class="table_title"><util:message key="ev.prop.list"/></span></th>
										<th class="C"><span class="table_title"><util:message key="eb.title.searchCondition"/></span></th>
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
										<a href="javascript:aBM.getExtnMngr().doShowMultiLangMngr()" class="btn_B"><span><util:message key="ev.info.title"/></span></a>
									</div>
									<div class="rightArea">
										<a href="javascript:aBM.getExtnMngr().doCreate()" class="btn_O"><span><util:message key="ev.title.new"/></span></a>
										<a href="javascript:aBM.getExtnMngr().doDelete()" class="btn_O"><span><util:message key="ev.title.remove"/></span></a>
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
										<th class="L"><util:message key="eb.title.extendField.Name"/></td>
										<td class="L"><input type='text' id='extn_fldNm' class="txt_100per" maxlength=30></td>
										<th class="L"><util:message key="ev.prop.lang.langUseYn"/></td>
										<td class="L">
											<c:forEach	items="${radioList}" var="list">
												<input type=radio name="extn_useYn" value="<c:out value="${list.code}"/>" <c:if test="${list.code=='N'}">checked</c:if>>
												<label>&nbsp;<c:out value="${list.codeName}"/>&nbsp;&nbsp;</label>
											</c:forEach>
										</td>
									</tr>
									<tr>
										<th class="L" ><util:message key="eb.title.listScren.showYN"/></td>
										<td class="L">
											<c:forEach	items="${radioList}" var="list">
												<input type=radio name="extn_ttlYn" value="<c:out value="${list.code}"/>" <c:if test="${list.code=='N'}">checked</c:if>>
												<label>&nbsp;<c:out value="${list.codeName}"/>&nbsp;&nbsp;</label>
											</c:forEach>
										</td>
										<th class="L" ><util:message key="eb.title.searchCondition.useYN"/></td>
										<td class="L">
											<c:forEach	items="${radioList}" var="list">
												<input type=radio name="extn_srchYn" value="<c:out value="${list.code}"/>" <c:if test="${list.code=='N'}">checked</c:if>>
												<label>&nbsp;<c:out value="${list.codeName}"/>&nbsp;&nbsp;</label>
											</c:forEach>
										</td>
									</tr>
									
									<tr>
										<th class="L"><util:message key="eb.title.dataType"/></td>
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
										<th class="L" ><util:message key="eb.title.extendField.title"/></td>
										<td class="L" colspan="3"><input type=text id="extn_title" class="txt_100per" maxlength=50></td>
									</tr>
									
									<tr>
										<th class="L"><util:message key="eb.title.fieldControl.utilClass.name"/></td>
										<td class="L" colspan="3"><input type=text id="extn_utilClassNm" class="txt_100per" maxlength=60></td>
									</tr>									
								</table>
								<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
									<!-- btnArea-->
									<div class="btnArea"> 
										<div class="rightArea">
											<a href="javascript:aBM.getExtnMngr().doSave()" class="btn_O"><span><util:message key="ev.title.save"/></span></a>
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