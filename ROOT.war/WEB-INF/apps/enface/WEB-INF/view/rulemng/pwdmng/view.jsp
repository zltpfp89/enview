<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/admin/css/contents.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/admin/css/styles.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/jquery-ui.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/jquery.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/rulemng.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/jquery-ui.min.js" ></script>

<script type="text/javascript">
$(function() {
	$('.datepicker').datepicker({ dateFormat: "yy-mm-dd" });
});
</script>
<style>
	.no_std {
		display : none;
	}
</style>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<div class="board">
			<div class="table_wrap">
			<ul class="summary_table">
				<form name="pwdmngForm" id="pwdmngForm" action="${pageContext.request.contextPath}/pwdmng/update.face">
					<table border="0" cellspacing="0" cellpadding="0" class="table_board" style="width:100%;border-top:0px;">	
						<tbody>
							<c:forEach items="${ruleInfo}" var="rule" varStatus="rule_status">
								<c:if test="${rule.ruleSubCnt == 0}">
									<tr class="even">
										<th class="L"><c:out value="${rule.ruleNm}"/></th>
										<td class="L" colspan="2">
											<c:if test="${rule.ruleSt == 'SELECT'}">
												<div class="sel_100">
													<select name="${rule.ruleCd}" class="txt_100">
														<option value="N" <c:if test="${rule.ruleSubData1 == 'N'}">selected</c:if>>허용안함</option>
														<option value="Y" <c:if test="${rule.ruleSubData1 == 'Y'}">selected</c:if>>허용함</option>
													</select>
												</div>
											</c:if>
											<c:if test="${rule.ruleSt == 'CHECKBOX'}">
												<input type="checkbox" name="${rule.ruleCd}" alt="특수문자" value="S" <c:if test="${rule.ruleSubData1 == 'S' || rule.ruleSubData2 == 'S' || rule.ruleSubData3 == 'S'}">checked</c:if>/>&nbsp;특수문자&nbsp;&nbsp;
												<input type="checkbox" name="${rule.ruleCd}" alt="영문" value="E" <c:if test="${rule.ruleSubData1 == 'E' || rule.ruleSubData2 == 'E' || rule.ruleSubData3 == 'E'}">checked</c:if>/>&nbsp;영문&nbsp;&nbsp;
												<input type="checkbox" name="${rule.ruleCd}" alt="숫자" value="N" <c:if test="${rule.ruleSubData1 == 'N' || rule.ruleSubData2 == 'N' || rule.ruleSubData3 == 'N'}">checked</c:if>/>&nbsp;숫자
											</c:if>
										</td>
									</tr>
								</c:if>	
								<c:if test="${rule.ruleSubCnt != 0}">
									<c:if test="${beforeCd != rule.ruleCd}">
										<tr class="even">
											<th class="L" rowspan="${rule.ruleSubCnt}"><c:out value="${rule.ruleNm}"/></th>
											<th class="L" ><c:out value="${rule.ruleSubNm}"/></th>
											<td class="L">
												<input type="radio" class="isuse" name="${rule.ruleSubCd}" data="${rule.ruleCd}" alt="사용" value="Y" <c:if test="${rule.ruleSubData1 == 'Y'}">checked</c:if>/>&nbsp;사용&nbsp;&nbsp;
												<input type="radio" class="isuse" name="${rule.ruleSubCd}" data="${rule.ruleCd}" alt="사용안함" value="N" <c:if test="${rule.ruleSubData1 == 'N'}">checked</c:if>/>사용 안함
											</td>
										</tr>
									</c:if>
									<c:if test="${beforeCd == rule.ruleCd}">
										<tr class="even ${rule.ruleCd}">
											<th class="L"><c:out value="${rule.ruleSubNm}"/></th>
											<td class="L">
												<c:if test="${rule.ruleSubCd == 'PWD_LENGTH_STD'}">
													<input type="radio" name="${rule.ruleSubCd}" alt="특수문자" value="S" <c:if test="${rule.ruleSubData1 == 'S'}">checked</c:if> />&nbsp;특수문자&nbsp;&nbsp;
													<input type="radio" name="${rule.ruleSubCd}" alt="영문" value="E" <c:if test="${rule.ruleSubData1 == 'E'}">checked</c:if>/>&nbsp;영문&nbsp;&nbsp;
													<input type="radio" name="${rule.ruleSubCd}" alt="숫자" value="N" <c:if test="${rule.ruleSubData1 == 'N'}">checked</c:if>/>&nbsp;숫자&nbsp;&nbsp;
													<input type="radio" name="${rule.ruleSubCd}" alt="없음" value="None" <c:if test="${rule.ruleSubData1 == 'None'}">checked</c:if>/>&nbsp;없음
												</c:if>
												<c:if test="${rule.ruleSubCd == 'PWD_LENGTH_MIN'}">
													<div class="std" style="margin-bottom : 5px;">
														<span class="label min_len_y">특수문자 포함 시 : </span>
														<input type="text" name="${rule.ruleSubCd}" class="full_input" value="<c:out value="${rule.ruleSubData1}"/>"/>
													</div>
													<div class="std">
														<span class="label min_len_n">특수문자 미포함 시 : </span>
														<input type="text" name="${rule.ruleSubCd}" class="full_input" value="<c:out value="${rule.ruleSubData2}"/>"/>
													</div>
													<div class="no_std">
														<input type="text" name="${rule.ruleSubCd}" class="full_input" value="<c:out value="${rule.ruleSubData3}"/>"/>
													</div>
												</c:if>
												<c:if test="${rule.ruleSubCd == 'PWD_LENGTH_MAX'}">
													<div class="std" style="margin-bottom : 5px;">
														<span class="label max_len_y">특수문자 포함 시 : </span>
														<input type="text" name="${rule.ruleSubCd}" class="full_input" value="<c:out value="${rule.ruleSubData1}"/>"/>
													</div>
													<div class="std">
														<span class="label max_len_n">특수문자 미포함 시 : </span>
														<input type="text" name="${rule.ruleSubCd}" class="full_input" value="<c:out value="${rule.ruleSubData2}"/>"/>
													</div>
													<div class="no_std">
														<input type="text" name="${rule.ruleSubCd}" class="full_input" value="<c:out value="${rule.ruleSubData3}"/>"/>
													</div>
												</c:if>
												<c:if test="${rule.ruleSubCd == 'RULE_SUPER_STARTTIME'}">
													<input type="${rule.ruleSt}" name="${rule.ruleSubCd}" class="full_input datepicker" value="<c:out value="${rule.ruleSubData1}"/>"/>
												</c:if>
												<c:if test="${rule.ruleSubCd == 'RULE_SUPER_ENDTIME'}">
													<input type="${rule.ruleSt}" name="${rule.ruleSubCd}" class="full_input datepicker" value="<c:out value="${rule.ruleSubData1}"/>"/>
												</c:if>
												<c:if test="${rule.ruleSubCd != 'PWD_LENGTH_STD' && rule.ruleSubCd != 'PWD_LENGTH_MIN' && rule.ruleSubCd != 'PWD_LENGTH_MAX'&& rule.ruleSubCd != 'RULE_SUPER_STARTTIME'&& rule.ruleSubCd != 'RULE_SUPER_ENDTIME'}">
													<input type="${rule.ruleSt}" name="${rule.ruleSubCd}" class="full_input" value="<c:out value="${rule.ruleSubData1}"/>"/>
												</c:if>
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

<script type="text/javascript">
	$(document).ready(function () {	
		
		var result = '<c:out value="${result}"/>';
		if(result == 'success') {
			alert("저장되었습니다.");
		} else if(result == 'error') {
			alert("오류가 발생했습니다.");
		}
		
		if(pRule != null) {
			pRule.init("pwdmngForm", document.pwdmngForm);
		}
		
		setLenStd();
		
		$("input[name=PWD_LENGTH_STD]").change(function() {
			var stdPwd = $(this).val();
			setLenStd(stdPwd);
		});
		
		function setLenStd(stdPwd) {
			
			if(stdPwd == null || stdPwd == "") {
				stdPwd = $("input[name=PWD_LENGTH_STD]:checked").val();
			}
			
			$(".no_std").css("display","none");
			$(".std").css("display","inline-block");
			
			if(stdPwd == 'S') {
				$(".min_len_y").text("특수문자 포함 시 :");
				$(".min_len_n").text("특수문자 미포함 시 :");
				$(".max_len_y").text("특수문자 포함 시 :");
				$(".max_len_n").text("특수문자 미포함 시 :");
			} else if(stdPwd == 'E') {
				$(".min_len_y").text("영문 포함 시 :");
				$(".min_len_n").text("영문 미포함 시 :");
				$(".max_len_y").text("영문 포함 시 :");
				$(".max_len_n").text("영문 미포함 시 :");
			} else if(stdPwd == 'N') {
				$(".min_len_y").text("숫자 포함 시 :");
				$(".min_len_n").text("숫자 미포함 시 :");
				$(".max_len_y").text("숫자 포함 시 :");
				$(".max_len_n").text("숫자 미포함 시 :");
			} else {
				$(".no_std").css("display","inline-block");
				$(".std").css("display","none");
			}
		}
	});
</script>

