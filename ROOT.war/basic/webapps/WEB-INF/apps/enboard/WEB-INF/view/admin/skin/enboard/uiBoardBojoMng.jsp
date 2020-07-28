<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
		<!-- bojoAccordion -->
		<div id="bojoAccordion">
			<h3><a href="#">보조속성</a></h3>
			<div class="board">
				<c:if test="${empty boardVO || boardVO.boardId == boardVO.boardRid}">
					<table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">
		            <caption>게시판 상세</caption>
		                <colgroup>
							<col width="200px" />
							<col width="*" />
							<col width="*" />					
		                </colgroup>
		                <tbody>
							<c:if test="${boardPropVO.boardId == 'ENBOARD.BASE'}">
								<tr>
								  <td colspan="3"><font color="red"><b>!! 자신만의 설정이 없는 게시판 전체에 영향을 미치는 디폴트 값을 편집 중입니다 !!</b></font></td>
								</tr>
							</c:if>
		               		<%--BEGIN::통합형인 경우에는 게시물에 영향을 미치는 설정은 못하도록 막는다.--%>
		               		<c:if test="${empty boardVO || boardVO.mergeType == 'A'}">
			                	<tr>
			                		<th class="L">글 평가 레벨</th>
			                		<td class="C"><textarea id="bojo_evalLevel" rows="2" class="txtbox"><c:out value="${boardPropVO.evalLevel}"/></textarea></td>
		                       		<td class="L">글평가 레벨의 '점수=설명'을	',' 구분으로 입력하십시오<br>예)5=매우좋음,4=좋음,3=보통</td>
		                       	</tr>
							    <tr>
									<th class="L">베스트 선정 제한횟수</th>
									<td class="C"><textarea id="bojo_bestLimit" rows="2" class="txtbox"><c:out value="${boardPropVO.bestLimit}"/></textarea></td>
									<td class="L">베스트글의 '레벨=제한횟수'를 ',' 구분으로 입력하십시오<br>예)8=1,7=2,6=3,5=5,4=10</td>
								</tr>
								<tr>
									<th class="L">첨부 허용 파일 확장자</th>
									<td class="C"><textarea id="bojo_extMask" rows="2" class="txtbox"><c:out value="${boardPropVO.extMask}"/></textarea></td>
									<td class="L">첨부를 허용할 파일 확장자를 ',' 구분으로 입력하십시오<br>예)pdf,doc</td>
								</tr>
								<tr>
									<th class="L">첨부 금지 파일 확장자</th>
									<td class="C"><textarea id="bojo_badExtMask" rows="2" class="txtbox"><c:out value="${boardPropVO.badExtMask}"/></textarea></td>
									<td class="L">첨부를 금지할 파일 확장자를 ',' 구분으로 입력하십시오<br>예)mpeg,avi</td>
								</tr>							
		               		</c:if>
		               		<%--END::통합형인 경우에는 게시물에 영향을 미치는 설정은 못하도록 막는다.--%>
							<tr>
								<th class="L">접근 허용 IP</th>
								<td class="C"><textarea id="bojo_acceptIp" rows="2" class="txtbox"><c:out value="${boardPropVO.acceptIp}"/></textarea></td>
								<td class="L">첨부를 금지할 파일 확장자를 ',' 구분으로 입력하십시오<br>예)mpeg,avi</td>
							</tr>
							<tr>
								<th class="L">접근 허용 ID</th>
								<td class="C"><textarea id="bojo_acceptId" rows="2" class="txtbox"><c:out value="${boardPropVO.acceptId}"/></textarea></td>
								<td class="L">게시판 접근을 허용할 아이디를 ';' 구분으로 입력하십시오<br>예)onlyme;methree</td>
							</tr>
							<tr>
								<th class="L">접근 차단 IP</th>
								<td class="C"><textarea id="bojo_badIp" rows="2" class="txtbox"><c:out value="${boardPropVO.badIp}"/></textarea></td>
								<td class="L">게시판 접근을 차단할 아이피를 ';' 구분으로 입력하십시오<br>예)333.33.3.*;444.44.4.44</td>
							</tr>
							<tr>
								<th class="L">접근 차단 ID</th>
								<td class="C"><textarea id="bojo_badId" rows="2" class="txtbox"><c:out value="${boardPropVO.badId}"/></textarea></td>
								<td class="L">게시판 접근을 차단할 아이디를 ';' 구분으로 입력하십시오<br>예)iamfool;youarecrazy</td>
							</tr>
							<%--BEGIN::통합형인 경우에는 게시물에 영향을 미치는 설정은 못하도록 막는다.--%>
							<c:if test="${empty boardVO || boardVO.mergeType == 'A'}">
								<tr>
									<th class="L">입력 금지어(닉네임)</th>
									<td class="C"><textarea id="bojo_badNick" rows="3" class="txtbox"><c:out value="${boardPropVO.badNickDflt}"/></textarea></td>
									<td class="L">닉네임(별명) 입력시 입력 금지 단어를 ';' 구분으로 입력하십시오<br>예)관리자;운영자</td>
								</tr>
								<tr>
									<th class="L">입력 금지어(제목/본문)</th>
									<td class="C"><textarea id="bojo_badCntt" rows="3" class="txtbox"><c:out value="${boardPropVO.badCnttDflt}"/></textarea></td>
									<td class="L">제목/본문 입력시 입력 제한 단어를 ';' 구분으로 입력하십시오<br>예)바보;빙딱</td>
								</tr>
								<tr>
									<th class="L">반복 입력 제한</th>
									<td class="C"><input type="text" id="bojo_inputTerm" value="<c:out value="${boardPropVO.inputTerm}"/>" maxlength="4" class="txt_100">&nbsp;<span class="sel_txt">초</span></td>
									<td class="L">예) 30 : 게시물 입력시 30초 경과후 재입력 가능. 즉, 30초동안 한번만 입력 가능합니다.<br> (10초이하로 설정한경우 10초로 간주 됩니다.)</td>
								</tr>
								<tr>
									<th class="L">공통금지어 닉네임 적용 여부</th>
									<td class="C" colspan=2>
										<c:forEach items="${radioList}" var="list">
											<input type=radio name="bojo_badNickYn" value="<c:out value="${list.code}"/>" <c:if test="${boardPropVO.badNickYn == list.code}">checked</c:if>>
											<label>&nbsp;<c:out value="${list.codeName}"/></label>&nbsp;&nbsp;
										</c:forEach>
									</td>
								</tr>
								<tr>
									<th class="L">공통금지어 적용 여부</th>
									<td class="C" colspan=2>
										<c:forEach items="${radioList}" var="list">
											<input type=radio name="bojo_badCnttYn" value="<c:out value="${list.code}"/>" <c:if test="${boardPropVO.badCnttYn == list.code}">checked</c:if>>
											<label>&nbsp;<c:out value="${list.codeName}"/></label>&nbsp;&nbsp;
										</c:forEach>
									</td>
								</tr>
							</c:if>						
							<%--END::통합형인 경우에는 게시물에 영향을 미치는 설정은 못하도록 막는다.--%>				
		                </tbody>
					</table>
		    	</c:if>
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
					<!-- btnArea-->
					<div class="btnArea">
						<div id="bojo_restore" class="fl"><a href="javascript:aBM.getBojoMngr().doRestore()" class="btn_B"><span>디폴트 값으로 복원</span></a></div>
						<div class="rightArea">
							<a href="javascript:aBM.getBojoMngr().doUpdateDef()" class="btn_B"><span>디폴트 값 편집</span></a>
							<a href="javascript:aBM.getBojoMngr().doSave('prop')" class="btn_O"><span>저장</span></a>
						</div>
					</div>
					<!-- btnArea//-->				
				</c:if>
			</div>    	
	        <h3><a href="#">공통 금지어 설정</a></h3>
	        	<div class="board">
				<table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">
	            <caption>게시판 상세</caption>
	                <colgroup>
						<col width="*" />					
	                </colgroup>
	                <tbody>
						<tr>
							<td>게시물 입력시 입력 제한 단어를 ';' 구분으로 입력하십시오. 예)XX;X;XXXX;XX</td>
						</tr>
						<tr>
			   				<td><textarea id="bojo_badCnttCommon" rows="10" style="width:97%" class="txtbox"><c:out value="${boardPropVO.badCnttCommonDflt}"/></textarea></td>			
						</tr>
	                </tbody>
				</table>
				<!-- btnArea-->
				<div class="btnArea">
					<div class="rightArea">
						<a href="javascript:aBM.getBojoMngr().doSave('cntt')" class="btn_B"><span>저장</span></a>
					</div>
				</div>
				<!-- btnArea//-->
			</div>
		</div>
		<!-- bojoAccordion// -->