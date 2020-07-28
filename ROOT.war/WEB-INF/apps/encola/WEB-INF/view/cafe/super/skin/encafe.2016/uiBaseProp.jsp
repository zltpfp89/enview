<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<%--BEGIN::초기 전체 화면--%>
<c:if test="${empty suForm.view || suForm.view == 'init'}">
	<div id="basePropTabs">
		<ul>
	  		<li><a href="#cafePropTab" onclick="superMngr.getBPMngr().doGet('cafe')">카페 설정</a></li>   
			<li><a href="#boardPropTab" onclick="superMngr.getBPMngr().doGet('board.list')">게시판 설정</a></li>
			<li><a href="#mcdPropTab" onclick="superMngr.getBPMngr().doGet('mcd.list')">마일리지 설정</a></li>
			<li><a href="#mgrdPropTab" onclick="superMngr.getBPMngr().doGet('mgrd.list')">회원등급 설정</a></li>
		</ul>
		<div id="cafePropTab"  class="adgridpanel" style="width:99%;"></div>
		<div id="boardPropTab" class="adgridpanel" style="width:99%;"></div>
		<div id="mcdPropTab" class="adgridpanel" style="width:99%;"></div>
		<div id="mgrdPropTab" class="adgridpanel" style="width:99%;"></div>
	</div>
<link rel="stylesheet" type="text/css" href="<%=evcp%>/board/css/admin/admin-common.css">
<script type="text/javascript" src="<%=evcp%>/board/javascript/enboard_util.js"></script>
<script type="text/javascript" src="<%=evcp%>/cola/cafe/javascript/super/encafe.js"></script>
<script type="text/javascript">
  function initSuperMngr() {
	superMngr = new SuperMngr();
	superMngr.getBPMngr().init();
  }
  function finishSuperMngr() {
  }
  // Attach to the onload event
  if (window.attachEvent) {
    window.attachEvent ("onload", initSuperMngr);
	window.attachEvent ("onunload", finishSuperMngr);
  } else if (window.addEventListener ) {
    window.addEventListener ("load", initSuperMngr, false);
	window.addEventListener ("unload", finishSuperMngr, false);
  } else {
    window.onload = initSuperMngr;
	window.onunload = finishSuperMngr;
  }
</script>
</c:if>
<%--END::초기 전체 화면--%>
<%--BEGIN::카페 설정탭--%>
<c:if test="${suForm.view == 'cafe'}">
	<!-- board -->
	<div class="board" >
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width='25%'/>
				<col width='25%'/>
				<col width='25%'/>
				<col width='25%'/>
			</colgroup>
			<tr>
				<td colspan="4">
					<img src='<%=evcp%>/cola/cafe/images/super/encafe/ic_triangle.gif' style='margin:0 5 0 0;' align=absmiddle>
		  			사용자의 카페 개설 시 디폴트로 적용될 카페의 속성들을 설정하실 수 있습니다. 이미 개설된 카페의 속성에는 영향을 미치지 않습니다.				
				</td>
			</tr>
			<tr>
			    <th class="R" style="padding:0px 10px 0px 10px">개설 방식</th>
				<td class="L" colspan="3">
					<input type="radio" name="base_cmntState" value="10" <c:if test="${cmntVO.cmntState=='10'}">checked</c:if>>승인필요&nbsp;&nbsp;&nbsp;
					<input type="radio" name="base_cmntState" value="11" <c:if test="${cmntVO.cmntState=='11'}">checked</c:if>>자동개설
			  	</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">공개 여부</th>
			  	<td class="L" colspan="3">
			    	<c:forEach items="${openYnList}" var="openYn">
			        	<input type=radio name="base_openYn" value="<c:out value="${openYn.code}"/>" <c:if test="${cmntVO.openYn==openYn.code}">checked</c:if>>
						<c:out value="${openYn.codeName}"/>&nbsp;&nbsp;
			       	</c:forEach>
			  	</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">회원 가입 방식</th>
				<td class="L" colspan="3">
			    	<c:forEach items="${regTypeList}" var="regType">
			       		<input type=radio name="base_regType" value="<c:out value="${regType.code}"/>" <c:if test="${cmntVO.regType==regType.code}">checked</c:if>>
						<c:out value="${regType.codeName}"/>&nbsp;&nbsp;
			     	</c:forEach>
			  	</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">회원 기본 등급</th>
			 	<td class="L" colspan="3">
			 		<div class="sel_100">
				 		<select id="base_mmbrDefGrd" class="txt_100">
				 			<c:forEach items="${grdList}" var="grd">
				 				<option value="<c:out value="${grd.code}"/>" <c:if test="${cmntVO.mmbrDefGrd == grd.code}">selected</c:if>><c:out value="${grd.codeName}"/>
				 			</c:forEach>
				      	</select>
			      	</div>
			 	</td>
				<%-- 
				<td class='adformlabeldark' align=right style="padding:0px 10px 0px 10px">회원기본등급 아이콘 종류</td>
				<td class='adformfielddarklast'>
				    <select id="base_mmbrGrdIcon">
						<c:forEach items="${iconList}" var="icon">
							<option value="<c:out value="${icon.code}"/>" <c:if test="${cmntVO.mmbrGrdIcon == icon.code}">selected</c:if>><c:out value="${icon.codeName}"/>
						</c:forEach>
			   		</select>
				</td>
				--%>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">커뮤니티 등급</th>
			 	<td class="L" colspan="3">
			 		<div class="sel_100">
				 		<select id="base_cmntLevel" class="txt_100">
				 			<c:forEach items="${levelList}" var="level">
				 				<option value="<c:out value="${level.code}"/>" <c:if test="${cmntVO.cmntLevel == level.code}">selected</c:if>><c:out value="${level.codeName}"/>
				 			</c:forEach>
				 		</select>
					</div>				 		
			 	</td>
				<%-- 
				<td class='adformlabel' align=right style="padding:0px 10px 0px 10px">개설허용 소모임 갯수</td>
			   	<td class='adformfieldlast'><input type=text id="base_somoLimitCnt" maxlength=10 value="<c:out value="${cmntVO.somoLimitCnt}"/>"></td>
			   	 --%>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">카페 내 회원명 표기</th>
			 	<td class="L" colspan="3">
			 		<c:forEach items="${nmTypeList}" var="nmType">
			        	<input type=radio name="base_nmType" value="<c:out value="${nmType.code}"/>" <c:if test="${cmntVO.nmType==nmType.code}">checked</c:if>>
						<c:out value="${nmType.codeName}"/>&nbsp;&nbsp;
			      	</c:forEach>
			 	</td>
				<%-- <td class='adformlabeldark' align=right style="padding:0px 10px 0px 10px">최대 허용 용량</td>
				<td class='adformfielddarklast'><input type=text id="base_MaxCpct" maxlength=13 value="<c:out value="${cmntVO.maxCpctCF}"/>">BYTE</td> --%>
			</tr>
			<tr>
				<td class="R" colspan="4">
		    		<input type="hidden" id="base_cmntId" name="base_cmntId" value="<c:out value="${cmntVO.cmntId}"/>"/>
		    		<a href="javascript:superMngr.getBPMngr().doGet('cafe')" class="btn_B"><span>새로고침</span></a>
		    		<a href="javascript:superMngr.getBPMngr().doSave('cafe')" class="btn_B"><span>저장</span></a>
		  		</td>		
			</tr>				
		</table>	
	</div>
	<!-- board// -->
</c:if>	
<%--END::카페 설정탭--%>
<%--BEGIN::게시판 설정탭.상단목록--%>
<c:if test="${suForm.view == 'board.list'}">
	<!-- board -->
	<div class="board" >
		<form id="boardListForm" style="display:inline" name="boardListForm" action="" method="post">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="30px" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
					<col width="120px" />
				</colgroup>
				<thead>
					<tr>
					  <th class="C"></th>
					  <th class="C" ch="0"><span class="table_title">아이디</span></th>
					  <th class="C" ch="0"><span class="table_title">게시판 명</span></th>
					  <th class="C" ch="0"><span class="table_title">게시판 타이틀</span></th>
					  <th class="C" ch="0"><span class="table_title">적용된 스킨</span></th>
					</tr>
				 </thead>
				 <tbody>
					 <c:forEach items="${boardList}" var="board" varStatus="status">
						<tr id="boardList<c:out value="${status.index}"/>" style="cursor:pointer" <c:if test="${status.index%2==1}">class="adgridline"</c:if>
						ch="<c:out value="${status.index}"/>">
							<td class="C" onclick="superMngr.getBPMngr().doSelect('board',this)">
								<input type="checkbox" id="boardList<c:out value="${status.index}"/>_checkRow" class="txt_100"/>
								<input type="hidden" id="boardList<c:out value="${status.index}"/>_boardId" value="<c:out value="${board.boardId}"/>"/>
							</td>
							<td class="L" onclick="superMngr.getBPMngr().doSelect('board',this)">
								<c:out value="${board.boardId}"/>
							</td>
							<td class="L" onclick="superMngr.getBPMngr().doSelect('board',this)">
								<c:out value="${board.boardNm}"/>
							</td>
							<td class="L" onclick="superMngr.getBPMngr().doSelect('board',this)">
								<c:out value="${board.boardTtl}"/>
							</td>
							<td class="L" onclick="superMngr.getBPMngr().doSelect('board',this)">
								<c:out value="${board.boardSkin}"/>
							</td>
						</tr>
					 </c:forEach>
				 </tbody>									
			</table>
		</form>
	</div>
	<!-- board// -->
	<div id="boardEditDiv"></div>
</c:if>	
<%--END::게시판 설정탭.상단목록--%>
<%--BEGIN::게시판 설정탭.하단편집--%>
<c:if test="${suForm.view == 'board.edit'}">
	<!-- board -->
	<div class="board" >
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
	 		<caption>게시판</caption>
			<colgroup>
				<col width="20%" />
				<col width="30%" />
				<col width="20%" />
				<col width="30%" />
			</colgroup>
			<tr>
				<td colspan="4">
			  		<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0 5 0 0;' align=absmiddle>
			  		선택된 유형의 게시판의 속성을 설정하실 수 있습니다. <font color="blue"><b>이미 개설된 카페의 동일 유형 게시판들에도 영향을 미칩니다.</b></font>
				</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">답글 기능</th>
				<td class="L">
					<c:forEach  items="${ynList}" var="yn">
						<input type=radio name="board_replyYn" value="<c:out value="${yn.code}"/>" <c:if test="${boardVO.replyYn==yn.code}">checked</c:if>><c:out value="${yn.codeName}"/>&nbsp;&nbsp;
					</c:forEach>
				</td>
				<th class="R" style="padding:0px 10px 0px 10px">댓글 기능</th>
				<td class="L">
					<c:forEach  items="${ynList}" var="yn">
						<input type=radio name="board_memoYn" value="<c:out value="${yn.code}"/>" <c:if test="${boardVO.memoYn==yn.code}">checked</c:if>><c:out value="${yn.codeName}"/>&nbsp;&nbsp;
			   		</c:forEach>
			  	</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">댓답글 기능</th>
				<td class="L">
			    	<c:forEach  items="${ynList}" var="yn">
			    		<input type=radio name="board_memoReplyYn" value="<c:out value="${yn.code}"/>" <c:if test="${boardVO.memoReplyYn==yn.code}">checked</c:if>><c:out value="${yn.codeName}"/>&nbsp;&nbsp;
			  		</c:forEach>
				</td>
				<th class="R" style="padding:0px 10px 0px 10px">악플신고기능</th>
				<td class="L">
					<c:forEach  items="${ynList}" var="yn">
			    		<input type=radio name="board_memoBadYn" value="<c:out value="${yn.code}"/>" <c:if test="${boardVO.memoBadYn==yn.code}">checked</c:if>><c:out value="${yn.codeName}"/>&nbsp;&nbsp;
			  		</c:forEach>
			  	</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">첨부파일명 검색여부</th>
			 	<td class="L">
					<c:forEach  items="${ynList}" var="yn">
						<input type=radio name="board_srchAtchYn" value="<c:out value="${yn.code}"/>" <c:if test="${boardVO.srchAtchYn==yn.code}">checked</c:if>><c:out value="${yn.codeName}"/>&nbsp;&nbsp;
					</c:forEach>
			 	</td>
			 	<th class="R" style="padding:0px 10px 0px 10px">작성일 검색여부</th>
			 	<td class="L">
					<c:forEach  items="${ynList}" var="yn">
						<input type=radio name="board_srchRegYn" value="<c:out value="${yn.code}"/>" <c:if test="${boardVO.srchRegYn==yn.code}">checked</c:if>><c:out value="${yn.codeName}"/>&nbsp;&nbsp;
					</c:forEach>
			  	</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">게시물 번호 컬럼</th>
				<td class="L">
					<c:forEach  items="${cynList}" var="cyn">
						<input type=radio name="board_ttlNoYn" value="<c:out value="${cyn.code}"/>" <c:if test="${boardVO.ttlNoYn==cyn.code}">checked</c:if>><c:out value="${cyn.codeName}"/>&nbsp;&nbsp;
					</c:forEach>
				</td>
				<th class="R" style="padding:0px 10px 0px 10px">게시물 아이콘 표시</th>
				<td class="L">
			    	<c:forEach  items="${cynList}" var="cyn">
			      		<input type=radio name="board_ttlIconYn" value="<c:out value="${cyn.code}"/>" <c:if test="${boardVO.ttlIconYn==cyn.code}">checked</c:if>><c:out value="${cyn.codeName}"/>&nbsp;&nbsp;
			    	</c:forEach>
			  	</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">새로운 글 아이콘 표시</th>
				<td class="L">
					<c:forEach  items="${cynList}" var="cyn">
						<input type=radio name="board_ttlNewYn" value="<c:out value="${cyn.code}"/>" <c:if test="${boardVO.ttlNewYn==cyn.code}">checked</c:if>><c:out value="${cyn.codeName}"/>&nbsp;&nbsp;
					</c:forEach>
				</td>
				<th class="R" style="padding:0px 10px 0px 10px">답글 갯수 표시</th>
				<td class="L">
			    	<c:forEach  items="${cynList}" var="cyn">
						<input type=radio name="board_ttlReplyYn" value="<c:out value="${cyn.code}"/>" <c:if test="${boardVO.ttlReplyYn==cyn.code}">checked</c:if>><c:out value="${cyn.codeName}"/>&nbsp;&nbsp;
					</c:forEach>
			  	</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">댓글 갯수 표시</th>
				<td class="L">
					<c:forEach  items="${cynList}" var="cyn">
			     		<input type=radio name="board_ttlMemoYn" value="<c:out value="${cyn.code}"/>" <c:if test="${boardVO.ttlMemoYn==cyn.code}">checked</c:if>><c:out value="${cyn.codeName}"/>&nbsp;&nbsp;
					</c:forEach>
				</td>
				<th class="R"  style="padding:0px 10px 0px 10px">작성자명 컬럼</th>
				<td class="L">
				    <c:forEach  items="${cynList}" var="cyn">
				    	<input type=radio name="board_ttlNickYn" value="<c:out value="${cyn.code}"/>" <c:if test="${boardVO.ttlNickYn==cyn.code}">checked</c:if>><c:out value="${cyn.codeName}"/>&nbsp;&nbsp;
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">작성일 컬럼</th>
			 	<td class="L">
			    	<c:forEach  items="${cynList}" var="cyn">
			        	<input type=radio name="board_ttlRegYn" value="<c:out value="${cyn.code}"/>" <c:if test="${boardVO.ttlRegYn==cyn.code}">checked</c:if>><c:out value="${cyn.codeName}"/>&nbsp;&nbsp;
			      	</c:forEach>
			 	</td>
			 	<th class="R" style="padding:0px 10px 0px 10px">조회 횟수 컬럼</th>
			 	<td class="L">
			    	<c:forEach  items="${cynList}" var="cyn">
			        	<input type=radio name="board_ttlReadYn" value="<c:out value="${cyn.code}"/>" <c:if test="${boardVO.ttlReadYn==cyn.code}">checked</c:if>><c:out value="${cyn.codeName}"/>&nbsp;&nbsp;
			      	</c:forEach>
			  	</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">공지글 기능</th>
			  	<td class="L">
			    	<c:forEach  items="${ynList}" var="yn">
			        	<input type=radio name="board_noticeYn" value="<c:out value="${yn.code}"/>" <c:if test="${boardVO.noticeYn==yn.code}">checked</c:if>><c:out value="${yn.codeName}"/>&nbsp;&nbsp;
			       	</c:forEach>
			  	</td>
			  	<th class="R" style="padding:0px 10px 0px 10px">게시판 전체 너비</th>
			  	<td class="L">
			 		<input type=text id="board_boardWidth" maxlength=10 value="<c:out value="${boardVO.boardWidth}"/>">
			  	</td>
			</tr>
			<tr>
				<th class="R" align="right" style="padding:0px 10px 0px 10px">제목 컬럼 너비</th>
				<td class="L">
			    	<input type=text id="board_subjSize" value="<c:out value="${boardVO.subjSize}"/>" maxlength="4">
				</td>
				<th class="R" style="padding:0px 10px 0px 10px">작성자명 컬럼 너비</th>
				<td class="L">
			    	<input type=text id="board_nickSize" value="<c:out value="${boardVO.nickSize}"/>" maxlength="4">
			  	</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">스킨 선택</th>
			 	<td class="L">
			 		<div class="sel_100">
				    	<select id="board_boardSkin" class="txt_100">
							<c:forEach items="${fileList}" var="list">
				 				<option value="<c:out value="${list.code}"/>" <c:if test="${boardVO.boardSkin == list.code}">selected</c:if>><c:out value="${list.codeName}"/>
							</c:forEach>
				      	</select>
			      	</div>
			 	</td>
			 	<th class="R" style="padding:0px 10px 0px 10px">최신글 기준 경과 시간</th>
			 	<td class="R">
					<input type=text id="board_newTerm" maxlength=4 value="<c:out value="${boardVO.newTerm}"/>">
				</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">목록화면 목록 수</th>
			  	<td class="L">
			 		<input type=text id="board_listSetCnt" maxlength=4 value="<c:out value="${boardVO.listSetCnt}"/>">
				</td>
			   	<th class="R" style="padding:0px 10px 0px 10px">자동 악플 처리 기준 신고 수</th>
			  	<td class="L">
			 		<input type=text id="board_badStdCnt" maxlength=4 value="<c:out value="${boardVO.badStdCnt}"/>">
			  	</td>
			</tr>
			<c:if test="${boardVO.boardId == 'CAFE.BASE.ENCAFE.NORM' || boardVO.boardId == 'CAFE.BASE.ENCAFE.QNA' || boardVO.boardId == 'CAFE.BASE.ENCAFE.PHO'
           	 			|| boardVO.boardId == 'ENBOARD.BASE.CF.ENCAFE.BASE' || boardVO.boardId == 'ENBOARD.BASE.CF.ENCAFE.MTRL'}">
				<tr>
					<th class="R" style="padding:0px 10px 0px 10px">첨부파일 최대 갯수</th>
				 	<td class="R">
						<input type=text id="board_maxFileCnt" maxlength=2 value="<c:out value="${boardVO.maxFileCnt}"/>">
					</td>
					<td class="L" colspan="2">
						0: 첨부 기능 사용 안함
					</td>
				</tr>
				<tr>
					<th class="R" style="padding:0px 10px 0px 10px">첨부파일 최대 크기</th>
				 	<td class="R">
						<input type=text id="board_maxFileSize" maxlength=10 value="<c:out value="${boardVO.maxFileSize}"/>">
				 	</td>
				  	<td class="L" colspan="2">
				 		단위: Byte
				  	</td>
				</tr>	        	 			
           	</c:if>			 																																				
		</table>
		<!-- btnArea-->
		<div class="btnArea">
			<div class="rightArea">
				<a href="javascript:superMngr.getBPMngr().doGet('board.edit')" class="btn_B"><span>새로고침</span></a>
				<a href="javascript:superMngr.getBPMngr().doSave('board')" class="btn_B"><span>저장</span></a>
			</div>
		</div>
		<!-- btnArea//-->
	</div>
	<!-- board// -->
</c:if>	
<%--END::게시판 설정탭.하단 편집--%>
<%--BEGIN::마일리지 설정탭.상단 목록--%>
<c:if test="${suForm.view == 'mcd.list'}">
	<!-- board -->
	<div id="LangManager_EditFormPanel" class="board" >
		<form id="mcdListForm" style="display:inline" name="mcdListForm" action="" method="post">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="30px" />
					<col width="*" />
					<col width="*" />
					<col width="100px" />
					<col width="100px" />
				</colgroup>
				<thead>
					<tr>
						<th class="C"></th>
						<th class="C" ch="0"><span class="table_title">마일리지 코드</span></th>
						<th class="C" ch="0"><span class="table_title">마일리지 명</span></th>
						<th class="C" ch="0"><span class="table_title">활성화 여부</span></th>
						<th class="C" ch="0"><span class="table_title">점수</span></th>
					</tr>
	  			</thead>
			  	<tbody>
				  	<c:forEach items="${mcdList}" var="mcd" varStatus="status">
						<tr id="mcdList<c:out value="${status.index}"/>" style="cursor:pointer" <c:if test="${status.index%2==1}">class="adgridline"</c:if>
						ch="<c:out value="${status.index}"/>"">
							<td class="C" onclick="superMngr.getBPMngr().doSelect('mcd',this)">
								<input type="checkbox" id="mcdList<c:out value="${status.index}"/>_checkRow" />
								<input type="hidden" id="mcdList<c:out value="${status.index}"/>_mileCd" value="<c:out value="${mcd.mileCd}"/>"/>
							</td>
							<td class="L" onclick="superMngr.getBPMngr().doSelect('mcd',this)">
								<c:out value="${mcd.mileCd}"/>
							</td>
							<td class="L" onclick="superMngr.getBPMngr().doSelect('mcd',this)">
								<c:out value="${mcd.mileNm}"/>
							</td>
							<td class="C" onclick="superMngr.getBPMngr().doSelect('mcd',this)">
								<c:out value="${mcd.mileActiveNm}"/>
							</td>
							<td class="C" onclick="superMngr.getBPMngr().doSelect('mcd',this)">
								<c:if test="${mcd.mileIo == 'O'}">-</c:if><c:out value="${mcd.milePntCF}"/>
							</td>
						</tr>
					</c:forEach>
			  	</tbody>					
			</table>				
		</form>
	</div>
	<!-- board// -->
	<div id="mcdEditDiv"></div>
</c:if>	
<%--END::마일리지 설정탭.상단 목록--%>
<%--BEGIN::마일리지 설정탭.하단편집--%>
<c:if test="${suForm.view == 'mcd.edit'}">
	<!-- board -->
	<div id="LangManager_EditFormPanel" class="board" >
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
	 		<caption>게시판</caption>
			<colgroup>
				<col width="20%" />
				<col width="30%" />
				<col width="20%" />
				<col width="30%" />
			</colgroup>
			<tr>
			    <td colspan="4">
			    	<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0 5 0 0;' align=absmiddle>
				  	선택된 마일리지 코드의 속성을 설정하실 수 있습니다.
				</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">활성화 여부</th>
				<td class="L" colspan="3">
			    	<c:forEach  items="${activeList}" var="active">
			        	<input type=radio name="mcd_mileActive" value="<c:out value="${active.code}"/>" <c:if test="${mcdVO.mileActive==active.code}">checked</c:if>><c:out value="${active.codeName}"/>&nbsp;&nbsp;
			       	</c:forEach>
			  	</td>
			</tr>
			<tr>
			    <th class="R" style="padding:0px 10px 0px 10px">증가/차감</th>
			    <td class="L">
			         <c:forEach  items="${ioList}" var="io">
			         	<input type=radio name="mcd_mileIo" value="<c:out value="${io.code}"/>" <c:if test="${mcdVO.mileIo==io.code}">checked</c:if>><c:out value="${io.codeName}"/>&nbsp;&nbsp;
			         </c:forEach>
			    </td>
			    <th class="R" style="padding:0px 10px 0px 10px">점수</th>
			    <td class="L">
					<input type=text id="mcd_milePnt" maxlength=6 value="<c:out value="${mcdVO.milePnt}"/>">
			    </td>
			</tr>
			<tr>
			  	<th class="R" style="padding:0px 10px 0px 10px">정책 유무</th>
			 	<td class="L">
			    	<c:forEach  items="${ynList}" var="yn">
			        	<input type=radio name="mcd_mileSttg" value="<c:out value="${yn.code}"/>" <c:if test="${mcdVO.mileSttg==yn.code}">checked</c:if>><c:out value="${yn.codeName}"/>&nbsp;&nbsp;
			      	</c:forEach>
			 	</td>
			 	<th class="R" style="padding:0px 10px 0px 10px">시간별 횟수 제한</th>
			 	<td class="L">
					<input type=text id="mcd_tlimitCnt" maxlength=3 value="<c:out value="${mcdVO.tlimitCnt}"/>">
			  	</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">일별 횟수 제한</th>
			    <td class="L">
					<input type=text id="mcd_dlimitCnt" maxlength=3 value="<c:out value="${mcdVO.dlimitCnt}"/>">
			    </td>
			    <th class="R" style="padding:0px 10px 0px 10px">주별 횟수 제한</th>
			    <td class="L">
					<input type=text id="mcd_wlimitCnt" maxlength=3 value="<c:out value="${mcdVO.wlimitCnt}"/>">
			    </td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">월별 횟수 제한</th>
			    <td class="L">
			    	<input type=text id="mcd_mlimitCnt" maxlength=3 value="<c:out value="${mcdVO.mlimitCnt}"/>">
			    </td>
			    <th class="R" style="padding:0px 10px 0px 10px">년별 횟수 제한</th>
			    <td class="L">
			    	<input type=text id="mcd_ylimitCnt" maxlength=3 value="<c:out value="${mcdVO.ylimitCnt}"/>">
			    </td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">마일리지 명</th>
				<td class="L" colspan="3">
					<input type=text id="mcd_mileNm" maxlength=30 size=20 value="<c:out value="${mcdVO.mileNm}"/>">
				</td>
			</tr>
			<tr>
				<th class="R" style="padding:0px 10px 0px 10px">마일리지 설명</th>
			    <td class="L" colspan="3">
					<input type=text id="mcd_mileRem" maxlength=50 size=40 value="<c:out value="${mcdVO.mileRem}"/>">
			    </td>
			</tr>
			<tr>
			    <th class="R" style="padding:0px 10px 0px 10px">최종수정자</th>
			    <td class="L">
			    	<c:out value="${mcdVO.updUserId}"/>
			    </td>
			    <th class="R" style="padding:0px 10px 0px 10px">최종수정일시</th>
			    <td class="L">
			    	<c:out value="${mcdVO.updDatimPF}"/>
			    </td>
			</tr>
		</table>
		<!-- btnArea-->
		<div class="btnArea">
			<div class="rightArea">
				<a href="javascript:superMngr.getBPMngr().doGet(" class="btn_B"><span>새로고침</span></a>
				<a href="javascript:superMngr.getBPMngr().doSave('mcd')" class="btn_B"><span>저장</span></a>
			</div>
		</div>
		<!-- btnArea//-->	
	</div>
	<!-- board// -->
</c:if>	
<%--END::마일리지 설정탭.하단 편집--%>
<%--BEGIN::회원등급 설정탭.상단목록--%>
<c:if test="${suForm.view == 'mgrd.list'}">
	<!-- board -->
	<div id="LangManager_EditFormPanel" class="board" >
		<form id="mgrdListForm" name="mgrdListForm" onsubmit="return false">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="100px" />
					<col width="100px" />
					<col width="100px" />
					<col width="100px" />
				</colgroup>
				<thead>
					<th class="first C"><span class="table_title">선택</span></th>
					<th class="C"><span class="table_title">등급</span></th>
					<th class="C"><span class="table_title">등급명</span></th>
					<th class="C"><span class="table_title">순서</span></th>
				</thead>
				<tbody>
					<c:forEach items="${mgrdList}" var="mgrd" varStatus="status">
						<tr id="mgrdList<c:out value="${status.index}"/>" style="cursor:pointer" <c:if test="${status.index % 2 == 1 }">class='adgridline'</c:if>
						 	ch="<c:out value="${status.index}"/>">
							<td class="C" onclick="superMngr.getBPMngr().doSelect('mgrd',this)">
								<input type="checkbox" id="mgrdList<c:out value="${status.index}"/>_checkRow"/>
								<input type="hidden" id="mgrdList<c:out value="${status.index}"/>_code" value="<c:out value="${mgrd.code}"/>"/>
							</td>
							<td class="C" onclick="superMngr.getBPMngr().doSelect('mgrd',this)"><c:out value="${mgrd.code}"/></td>
							<td class="C" onclick="superMngr.getBPMngr().doSelect('mgrd',this)"><c:out value="${mgrd.codeName}"/></td>
							<td class="C" onclick="superMngr.getBPMngr().doSelect('mgrd',this)">
								<c:if test="${!status.last}">
						 			<input type="button" name="grdUp<c:out value="${status.index}"/>" value="높은 등급으로" onclick="superMngr.getBPMngr().doMGrdUp('<c:out value="${status.index}"/>')">&nbsp;
								</c:if>
								<c:if test="${!status.first}">
									<input type="button" name="grdDown<c:out value="${status.index}"/>" value="낮은 등급으로" onclick="superMngr.getBPMngr().doMGrdDown('<c:out value="${status.index}"/>')">
								</c:if>
						  	</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:superMngr.getBPMngr().doGet('mgrd.edit','ins')" class="btn_W"><span>신규</span></a>
					<a href="javascript:aConfigurationManager.doRemove()" class="btn_W"><span>저장</span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</form>
	</div>
	<!-- board// -->
    <div id="mgrdEditDiv"></div>
</c:if>	
<%--END::회원등급 설정탭.상단 목록--%>
<%--BEGIN::회원등급 설정탭.하단 편집--%>
<c:if test="${suForm.view == 'mgrd.edit'}">
	<!-- board -->
	<div id="LangManager_EditFormPanel" class="board" >
		<form id="mgrdEditForm" name="mgrdEditForm" style="display:inline" action="" method="post" onsubmit="return false;">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="25%" />
					<col width="75%" />
				</colgroup>
				<tr>
					<th class="R" style="padding:0px 10px 0px 10px">등급</th>
					<td class="L"><input type='text' id='mgrd_code' size="3" disabled='true' value="<c:out value="${cdVO.code}"/>"></td>
				</tr>
				<tr>
					<th class="R" style="padding:0px 10px 0px 10px">등급명</th>
					<td class="L"><input type='text' id="mgrd_codeName" style='width:98%' maxlength='20' value="<c:out value="${cdVO.codeName}"/>"></td>
				</tr>
			</table>
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:superMngr.getBPMngr().doSave('mgrd')" class="btn_B"><span>저장</span></a>
					<c:if test="${suForm.act == 'upd'}">
						<a href="javascript:superMngr.getBPMngr().doMGrdDelete()" class="btn_B"><span>삭제</span></a>
					</c:if>
				</div>
			</div>
			<!-- btnArea//-->			  
		</form>
	</div>
	<!-- board// -->
</c:if>	
<%--END::회원등급 설정탭.하단 편집--%>
