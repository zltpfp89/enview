<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/admin/css/contents.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/admin/css/styles.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/jquery.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/rulemng.js" ></script>
<script type="text/javascript">	
	$(document).ready(function () {	
		
		var result = '<c:out value="${result}"/>';
		if(result == 'success') {
			alert("저장되었습니다.");
		} else if(result == 'error') {
			alert("오류가 발생했습니다.");
		}
		
		if(pRule != null) {
			pRule.init("idmngForm", document.idmngForm);
		}
		
	});
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<div class="board">
			<div class="table_wrap">
			<ul class="summary_table">
				<form name="idmngForm" id="idmngForm" action="${pageContext.request.contextPath}/idmng/update.face">
					<table border="0" cellspacing="0" cellpadding="0" class="table_board" style="width:100%;border-top:0px;">	
						<tbody>
							<c:forEach items="${ruleInfo}" var="rule" varStatus="rule_status">
								<c:if test="${rule.ruleSubCnt == 0}">
									<tr class="even">
										<th class="L"><c:out value="${rule.ruleNm}"/></<th>
										<td class="L" colspan="2">
											<c:if test="${rule.ruleSt == 'SELECT'}">
												<div class="sel_100">
													<select name="${rule.ruleCd}" class="txt_100">
														<option value="N" <c:if test="${rule.ruleSubData1 == 'N'}">selected</c:if>>허용안함</option>
														<option value="Y" <c:if test="${rule.ruleSubData1 == 'Y'}">selected</c:if>>허용함</option>
													</select>
												</div>
											</c:if>
										</td>
									</tr>
								</c:if>	
								<c:if test="${rule.ruleSubCnt != 0}">
									<c:if test="${beforeCd != rule.ruleCd}">
										<tr>
											<th class="L" rowspan="${rule.ruleSubCnt}"><c:out value="${rule.ruleNm}"/></th>
											<th class="L"><c:out value="${rule.ruleSubNm}"/></th>
											<td class="L">
												<input type="radio" class="isuse" name="${rule.ruleSubCd}" data="${rule.ruleCd}" alt="사용" value="Y" <c:if test="${rule.ruleSubData1 == 'Y'}">checked</c:if>/>&nbsp;사용&nbsp;&nbsp;
												<input type="radio" class="isuse" name="${rule.ruleSubCd}" data="${rule.ruleCd}" alt="사용안함" value="N" <c:if test="${rule.ruleSubData1 == 'N'}">checked</c:if>/>사용 안함
											</td>
										</tr>
									</c:if>
									<c:if test="${beforeCd == rule.ruleCd}">
										<tr class="${rule.ruleCd}">
											<th class="L"><c:out value="${rule.ruleSubNm}"/></th>
											<td class="L">
												<input type="${rule.ruleSt}" name="${rule.ruleSubCd}" class="full_input" value="<c:out value="${rule.ruleSubData1}"/>"/>
											</td>
										</tr>
									</c:if>
								</c:if>
								<c:set var="beforeCd" value="${rule.ruleCd}"/>
							</c:forEach>
						</tbody>
					</table>
				</form>
				<!-- btnArea-->
				<div class="btnArea">
					<div class="rightArea">
						<a href="javascript:pRule.update();" class="btn_B"><span>저장</span></a>
					</div>
				</div>
				<!-- btnArea//-->				
			</ul>
			</div>
		</div>
	</div>
</div>