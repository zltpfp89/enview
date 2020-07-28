<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<%--BEGIN::초기화면--%>
<c:if test="${apForm.view == 'init'}">
	<c:if test="${!empty boardVO}">
		<!-- rsltAccordion -->
		<div id="rsltAccordion">
			<h3><a href="#">결과조회</a></h3>
			<div class="board">
				<form name="apmRsltSrchForm" onsubmit="return false">
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						<colgroup>
							<col width="130px" />
							<col width="190px" />
							<col width="130px" />
							<col width="190px" />
						</colgroup>	
						<tr>
							<th class="L">설문 명</th>
							<td class="L" colspan="3">
								<c:out value="${boardVO.boardNm}"/>
							</td>
						</tr>
						<tr>
							<th class="L">설문 설명</th>
							<td class="L" colspan="3">
						  		<c:out value="${boardVO.boardTtl}"/>
						  	</td>
						</tr>
						<tr>
							<th class="L">설문기간</th>
							<td class="L" colspan="3">
								<c:out value="${pollPropVO.pollBgnYmdF}"/>&nbsp;~&nbsp;<c:out value="${pollPropVO.pollEndYmdF}"/>
						  	</td>
						</tr>
					</table>
	  				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						<tr>
							<td>
								<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
								설문결과를 Exel 파일로 다운로드 하실 수 있습니다
							</td>
						  	<td class="R">
								<a href="javascript:aPM.getRsltMngr().doExelDown('xls')" class="btn_B"><span><b>-Exel2007(.xls)</b></span></a>
								<a href="javascript:aPM.getRsltMngr().doExelDown('xlsx')" class="btn_B"><span><b>+Exel2007(.xlsx)</b></span></a>
						  	</td>
						</tr>
						<tr>
							<td colspan="2">
								<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
								응답결과를 확인하고자 하는 사용자를 선택하여 조회하실 수 있습니다.
						  	</td>
						</tr>
	  				</table>
	  				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
	  					<tr>
	  						<td class="R">
								<input type="text" id="rslt_srchUserId" name="rslt_srchUserId" style="width:160;" onfocus="ebUtil.whenSrchFocus(this,'*아이디*')" onblur="ebUtil.whenSrchBlur(this,'*아이디*')"
						   			<c:if test="${empty apForm.srchUserId}">value="*아이디*"</c:if><c:if test="${!empty apForm.srchUserId}">value="<c:out value="${apForm.srchUserId}"/>"</c:if>>
								<input type="text" id="rslt_srchNmKor" name="rslt_srchNmKor" style="width:160;" onfocus="ebUtil.whenSrchFocus(this,'*이름*')" onblur="ebUtil.whenSrchBlur(this,'*이름*')"
						   			<c:if test="${empty apForm.srchNmKor}">value="*이름*"</c:if><c:if test="${!empty apForm.srchNmKor}">value="<c:out value="${apForm.srchNmKor}"/>"</c:if>>
								<a href="javascript:aPM.getRsltMngr().pollRequest('','listU','srch')" class="btn_search"><span>검색</span></a>
	  						</td>
	  					</tr>
	 				</table>
 				</form>
  				<input type="hidden" id="rslt_totalSize" name="rslt_totalSize" value="<c:out value="${apForm.totalSize}"/>"/>
				<table id="grid-table" border="0" cellspacing="0" cellpadding="0" class="table_board">
			    	<tr><td id="pollTRUArea" valign="top"></td></tr>
				</table>
			</div>				
		</div>
		<!-- rsltAccordion// -->
	</c:if>
</c:if>
<%--END::초기화면--%>

<%--BEGIN::종합결과--%>
<c:if test="${apForm.view == 'rsltT'}">
	<form name="apmRsltPageForm" onsubmit="return false">
		<input type="hidden" id="rslt_totalSize"  name="rslt_totalSize"  value="<c:out value="${apForm.totalSize}"/>"/>
	</form>
	<div class="board">
	  	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<colgroup>
				<col width="133px" />
				<col width="80px" />
				<col width="133px" />
				<col width="80px" />
				<col width="134px" />
				<col width="80px" />
			</colgoup>
			<tr>
				<c:if test="${empty boardVO.pollTotTrgt || boardVO.pollTotTrgt == '0'}">
					<th class="L">설문대상자</th>
					<td class="C" colspan="5">
				  		설문대상자를 확정할 수 없습니다.
					</td>
			 	</c:if>
				<c:if test="${!empty boardVO.pollTotTrgt && boardVO.pollTotTrgt != '0'}">
					<th class="L">설문대상자</th>
					<td class="C">
						<c:out value="${boardVO.pollTotTrgt}"/>
					</td>
					<th class="L">설문응답자</th>
					<td class="L">
						<c:out value="${boardVO.pollHitSum}"/>
					</td>
					<th class="L">미&nbsp;응답자</th>
					<td class="C">
					  	<c:out value="${boardVO.pollHitYet}"/>
					</td>
				</c:if>
			</tr>			
		</table>
	  	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgoup>
			<thead>
				<tr>
		  			<th class="first"><span class="table_title">순번</span></th>
		  			<th class="C"><span class="table_title">문항</span></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty pollRList}">
	    			<tr><td class="C" colspan="5">배속된 설문문항이 존재하지 않습니다.</td></tr>
	    		</c:if>
	    
				<c:if test="${!empty pollRList}">
	    			<c:forEach items="${pollRList}" var="pollR" varStatus="status">
						<tr id='pollTRTr<c:out value="${status.index}"/>' onMouseOver=this.style.backgroundColor='#E9E9EC' onMouseOut=this.style.backgroundColor=''>
	      					<td colspan="2">
		    					<table width="100%" cellpadding=0 cellspacing=0 border=0>
									<colgroup width='10%'/>
									<colgroup width='5%'/>
									<colgroup width='35%'/>
									<colgroup width='45%'/>
									<tr>
										<td class="C"><c:out value="${pollR.bltnGq}"/></td>
									 	<td class="L" colspan="3">
											<c:out value="${pollR.bltnCntt}"/><br/>
											<c:if test="${!empty pollR.pollImageSrc}">
												<img src="${pollR.pollImageSrc}" align='absmiddle' style='border:1px #dddddd solid; max-width:600px;max-height:400px; '  onerror="this.src='${requestContext.contextPath}/images/no.gif'"/><br/>
											</c:if>
									  	</td>
									</tr>
			  						<c:if test="${!empty pollR.pollList}">
			  							<c:set var="pollAs" value="${pollR.pollList}"/>
										<%--jsp:useBean id="pollAs" type="java.util.ArrayList"/--%>
										<c:forEach items="${pollAs}" var="pollA">           
		      								<tr>
												<td class="C">(<c:out value="${pollA.pollSeq}"/>).</td>
												<td class="L">
													<c:if test="${pollA.pollKind == 'A'}"><%--선택형--%>
														<c:if test="${!empty pollA.pollPnt && pollA.pollPnt != '0'}">
															[<c:out value="${pollA.pollPnt}" escapeXml="false"/>&nbsp;점]
														</c:if>
														<c:out value="${pollA.pollCntt}" escapeXml="false"/>
													</c:if>
													<c:if test="${pollA.pollKind == 'B'}"><%--서술형--%>
														<c:if test="${!empty pollA.pollPnt && pollA.pollPnt != '0'}">
															[<c:out value="${pollA.pollPnt}" escapeXml="false"/>&nbsp;점]
														</c:if>
														<c:if test="${empty pollA.pollCntt}">
															**서술형 답변항목입니다**
														</c:if>
														<c:if test="${!empty pollA.pollCntt}">
															<c:out value="${pollA.pollCntt}" escapeXml="false"/>
														</c:if>
													</c:if>
													<c:if test="${!empty pollA.pollImageSrc}">
														<img src="${pollA.pollImageSrc}" align='absmiddle' style='border:1px #dddddd solid; max-width:600px;max-height:400px; '  onerror="this.src='${requestContext.contextPath}/images/no.gif'"/><br/>
														${pollA.pollImageSrc}
													</c:if>
												</td>
												<td class="R">
													<c:if test="${pollA.pollKind == 'A'}"><%--선택형--%>
														<c:out value="${pollA.pollRate}"/>%
														[<c:out value="${pollA.pollHit}"/>]
														<a href="#" onclick="javascript:aPM.getPollJoinUserMngr().doShow('${pollR.boardId}','${pollR.bltnNo}','${pollA.pollSeq}','${pollR.bltnCntt}', '${pollA.pollCntt}')"><img src="<%=evcp%>/board/images/admin/i_poll_l.gif" align="absmiddle"><img src="<%=evcp%>/board/images/admin/i_poll_c.gif" align="absmiddle" width="<c:out value="${pollA.pollGraphSize}"/>" height="12"><img src="<%=evcp%>/board/images/admin/i_poll_r.gif" align="absmiddle"></a>
													</c:if>
												</td>            
		      								</tr>
										</c:forEach>
			  							<c:remove var="pollAs"/>
			  						</c:if>
									<c:if test="${!empty pollR.pollPntAvg && pollR.pollPntAvg != '0'}">
										<tr height='20'>
											<td colspan="2" class="C">
									  			평&nbsp;점:&nbsp;<c:out value="${pollR.pollPntAvg}" escapeXml="false"/>
											</td>
									 	</tr>
									</c:if>
		    					</table>
	     					</td>
						</tr>
	    			</c:forEach>
				</c:if>
			<input type="hidden" id="pollTRTrIndex">
	  	</table>
		<!-- tcontrol-->
		<div class="tcontrol">
			<!-- paging -->
			<div class="paging" id="rslt_rslt_page_iterator">
			</div>
			<!-- paging//-->
		</div>
		<!-- tcontrol//--> 
	</div>
</c:if>
<%--END::종합결과--%>

<%--BEGIN::상단 응답자 목록--%>
<c:if test="${apForm.view == 'listU'}">
	<form name="apmRsltPageForm" onsubmit="return false">
		<div class="board">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="15%" />
					<col width="*" />
					<col width="*" />
				</colgroup>			
				<tr>
					<td colspan="3">
						<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
						사용자 아이디를 클릭하시면 선택된 사용자의 응답결과를 조회하실 수 있습니다.
				  	</td>
				</tr>
				<tr>
					<th class="first">순번</th>
					<th class="C"><span class="table_title">아이디</span></th>
					<th class="C"><span class="table_title">이름</span></th>
				</tr>
				<c:set var="userSeq" scope="request" value="0"/>
				<c:forEach items="${userList}" var="user" varStatus="status">
					<c:set var="userSeq" scope="request" value="${user.codeId}"/>
					<tr id='userTr<c:out value="${status.index}"/>' height=22 <c:if test="${user.codeId % 2 == 0 }">class='adgridline'</c:if>>
						<td class="C"><c:out value="${user.codeId}"/></td>
						<td class="C">
	  						<font style='cursor:pointer' onmouseover=this.style.textDecoration='underline' onmouseout=this.style.textDecoration='none'
								  onclick="ebUtil.selectTr('userTr',<c:out value="${status.index}"/>);aPM.getRsltMngr().pollRequest('','rsltU','','<c:out value="${user.code}"/>')"><c:out value="${user.code}"/></font>
						</td>
						<td class="C"><c:out value="${user.codeName}"/></td>
					</tr>
				</c:forEach>
				<input type=hidden id=userTrIndex>
			</table>
			<input type="hidden" id="rslt_totalSize"  name="rslt_totalSize"  value="<c:out value="${apForm.totalSize}"/>"/>
			<input type="hidden" id="rslt_srchUserId" name="rslt_srchUserId" value="<c:out value="${apForm.srchUserId}"/>"/>
			<input type="hidden" id="rslt_srchNmKor"  name="rslt_srchNmKor"  value="<c:out value="${apForm.srchNmKor}"/>"/>
			<input type="hidden" id="rslt_userId"     name="rslt_userId"/>
			<input type="hidden" id="rslt_userIp"     name="rslt_userIp"/>				
		</div>	
	</form>
		<!-- tcontrol-->
		<div class="tcontrol">
			<!-- paging -->
			<div class="paging" id="rslt_user_page_iterator">
			</div>
			<!-- paging//-->
		</div>
		<!-- tcontrol//-->			
</c:if>
<%--END::상단 응답자 목록--%>

<%--BEGIN::하단 응답자 응답결과--%>
<c:if test="${apForm.view == 'rsltU'}">
	<div class="board">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<tr>
				<c:if test="${boardVO.isPolled == 'true'}">
					<td>
						<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
						<font color='blue'><b>설문참여 결과</b></font>입니다.
						<c:if test="${boardVO.evalYn=='Y'}">
							(총점:<c:out value="${sumPnt}"/>,평가:<c:out value="${evalRemark}"/>)
						</c:if>
					</td>
				</c:if>			
			</tr>
		</table>
		<table id="grid-table" border="0" cellspacing="0" cellpadding="0" class="table_board">
			<colgroup>
				<col width="20%"/>
				<col width="80%" />
			</colgroup>		
			<thead>
				<tr>
				  <th class="first">순번</th>
				  <th class="C"><span class="table_title">문항</span></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty pollQList}">
					<tr><td class="C" colspan="5">배속된 설문문항이 존재하지 않습니다.</td></tr>
				</c:if>
				<c:if test="${!empty pollQList}">
					<c:forEach items="${pollQList}" var="pollQ" varStatus='status'>
						<tr id='pollQTr<c:out value="${status.index}"/>'>
							<td class="C"><c:out value="${pollQ.bltnGq}"/></td>
							<td class="L">&nbsp;&nbsp;&nbsp;<c:out value="${pollQ.bltnCntt}"/></td>
				 		</tr>
				 		<tr>
							<td colspan='2' onMouseOver=this.style.backgroundColor='#E9E9EC' onMouseOut=this.style.backgroundColor=''>
								<c:if test="${!empty pollQ.pollList}">
				 					<c:set var="pollAs" value="${pollQ.pollList}"/>
									<%--jsp:useBean id="pollAs" type="java.util.ArrayList"/--%>
				 					<table>
										<colgroup width='40'/>
										<colgroup width='40'/>
										<colgroup width='40'/>
										<colgroup width='520'/>
										<c:forEach items="${pollAs}" var="pollA">           
											<tr>
				  								<td></td>
				  								<td class="C">(<c:out value="${pollA.pollSeq}"/>).</td>
				  								<c:if test="${pollA.pollKind == 'A'}">
				 									<td class="C">
														<input type="radio" name='poll<c:out value="${pollQ.bltnGq}"/>'
														  	id='poll<c:out value="${pollQ.bltnGq}"/>'
														<c:if test="${pollQ.polledSeq == pollA.pollSeq}">checked</c:if> disabled
														/> 
				 									</td>
				 									<td class="L"><c:out value="${pollA.pollCntt}" escapeXml="false"/></td>
			  									</c:if>
				  								<c:if test="${pollA.pollKind == 'B'}">
				 									<td colspan="2" class="L">
														<c:if test="${!empty pollA.pollCntt}">
				  											<c:out value="${pollA.pollCntt}" escapeXml="false"/><br>
				   										</c:if>
														<%--textarea는 태그 사이에 있는 문자를 모두 value로 인식하므로 꽉 붙여야 한다.2010.05.05.KWShin.--%>
														<textarea name='pollReply<c:out value="${pollQ.bltnGq}"/>' 
														 		id='pollReply<c:out value="${pollQ.bltnGq}"/>' style="height:60;width:560" disabled
														><c:out value="${pollQ.polledReply}" escapeXml="false"/></textarea>
				 									</td>
				  								</c:if>
											</tr>
										</c:forEach>
				 					</table>
								</c:if>
							</td>
				 		</tr>
					</c:forEach>
				</c:if>
			</tbody>
			<input type="hidden" id="pollQTrIndex">
		</table>		
	</div>
</c:if>
<%--END::하단 응답자 응답결과--%>

<%--BEGIN::설문참여자 팝업 화면 부분--%>
<c:if test="${apForm.view == 'rsltTUP'}">
	<form id="apmPollJoinUserMngrForm" style="display:inline" name="apmPollJoinUserMngrForm" action="" method="post" onsubmit="return false;">
		<div class="board">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<colgroup>
					<col width="50%"/>
					<col width="50%" />
				</colgroup>
				<thead>
					<tr>
						<th class="first">사용자 ID</th>
					  	<th class="C" ch="0"><span class="table_title">사용자 명</span></th>
					</tr>
			  	</thead>
			 	<tbody>
					<c:forEach items="${pollJoinUserList}" var="user" varStatus="status">
						<tr height=22 <c:if test="${status.index % 2 == 1 }">class='adgridline'</c:if>>
							<td class="L"><c:out value="${user.userId}"/></td>
							<td class="L"><c:out value="${user.userNick}"/></td>
						</tr>
					</c:forEach>
					<tr><td class="C" colspan="3"><div id="apmPollJoinUserPageIterator"></div></td></tr>
			  </tbody>
			</table>
			<input type='hidden' name='totalSize' value="<c:out value="${apForm.totalSize}"/>"/>
  		</div>
	</form>
</c:if>
<%--BEGIN::설문참여자 팝업 화면 부분--%>