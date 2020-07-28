<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.saltware.enboard.vo.BoardVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<c:set var="loginInfo" value="${secPmsnVO.loginInfo}"/>

<c:if test="${boardVO.extUseYn == 'Y'}">
  <c:set var="rsExtnMapper" value="${boardVO.bltnExtnMapper}"/>
</c:if>
	  
<%-- Bulletins in mode of multiview --%>
<body class="iframe">
<div class="board">
	<c:forEach items="${bltnVOs}" var="list">
		<!-- table-->
		<table cellpadding="0" cellspacing="0" summary="게시판뷰" class="list" >  
		    <caption>게시판보기</caption>
		    <colgroup>
		        <col width="20%" />
		        <col width="30%" />
		        <col width="20%" />
		        <col width="30%" />
		    </colgroup>
		    <tbody>
				<tr>
					<!-- 제목 -->
					<th class="L first th_line view_title" scope="col" colspan="4">
						<span class="table_title">
							<c:if test="${list.bltnBestLevel == '9'}">
								<c:out value="${boardVO.imgBest9}" escapeXml="false"/>
							</c:if>
							<c:out value="${list.bltnOrgSubj}" escapeXml="false"/>
							<c:if test="${not empty list.bltnBgnYmd}">
								<c:out value="${list.bltnBgnYmdHmF}"/>
							</c:if>
					     </span>
				    </th>
				    <!-- 제목// -->
				</tr>
			   	<tr>
					<c:if test="${boardVO.anonYn == 'N'}"><%--익명게시판이 아니다--%>
						<th class="C first td_line" scope="col"><span class="table_title">작 성 자</span></th>
						<td class="L td_line"><c:out value="${list.userNick}"/></td>
					</c:if>
					<th class="C first td_line" scope="col"><span class="table_title">등록일</span></th>
					<td class="L td_line"><c:out value="${list.regDatimSF}"/></td>
				</tr>
				<c:set var="rsfile" value="${list.fileList}"/>
				<c:if test="${!empty rsfile}">
					<tr>
				    	<th class="C first td_line" scope="col" rowspan="${fn:length(rsfile) }"><span class="table_title">첨부파일</span></th>
				   		<%-- Attached file --%>
						<c:forEach items="${rsfile}" var="fList" varStatus="i">
							<c:if test="${i.count !=1 }">
								<tr>
							</c:if>
							<!-- 다운로드 링크 -->   
							<td class="L td_line" colspan="3">
								<c:out value="${fList.downloadLink}" escapeXml="false"/>&nbsp; (<c:out value="${fList.sizeSF}"/>)
								<a href="${ fList.downloadUrl}"><img class="icon_file" src="/sjpb/images/icon_file.png" alt="첨부파일" /></a>
							<td>
							<c:if test="${i.count !=1 }">
								</tr>
							</c:if>
						</c:forEach>
		      		</tr>
	      		</c:if>
				<tr>
					<td class="L td_line view_con" colspan="4">
						<p><c:out value="${list.bltnOrgCntt}" escapeXml="false"/></p>
					</td>
				</tr>
			</tbody>
		</table>
		<table cellpadding="0" cellspacing="0" summary="게시판뷰" class="list" style="margin-top:20px;" >  
	    	<caption>게시판보기</caption>
		    <colgroup>
		        <col width="20%" />
		        <col width="*%" />
		        <col width="*%" />
		        <col width="*%" />
		        <col width="20%" />
		        <col width="20%" />
		    </colgroup>
		    <c:if test="${!empty list.prevBoardId && !empty list.prevBltnNo}">
		        <tr>
		        	<th class="C first th_line" scope="col" ><span class="table_title">이전글</span></th>
		        	<td class="L td_line" colspan="5">
		        		<p class="title">
							<c:if test="${list.prevBoardId == 'del_flag_y'}">
								삭제된 글입니다.
							</c:if>
							<c:if test="${list.nextBoardId != 'del_flag_y'}">
								<a style=cursor:pointer onclick="ebRead.readPrevNextBltn('<c:out value="${list.prevBoardId}"/>','<c:out value="${list.prevBltnNo}"/>')">
									<c:out value="${list.prevBltnOrgSubj}" escapeXml="false"/>
								</a>
							</c:if>
		   				</p>
	   				</td>
	        	</tr>
				</c:if>
				<c:if test="${!empty list.nextBoardId && !empty list.nextBltnNo}">
			        <tr>
			            <th class="C first th_line" scope="col" ><span class="table_title">다음글</span></th>
			            <td class="L td_line" colspan="5">
			            	<p class="title">
			            		<c:if test="${list.nextBoardId == 'del_flag_y'}">
						삭제된 글입니다.
					</c:if>
					<c:if test="${list.nextBoardId != 'del_flag_y'}">
						<a style=cursor:pointer onclick="ebRead.readPrevNextBltn('<c:out value="${list.nextBoardId}"/>','<c:out value="${list.nextBltnNo}"/>')">
							<c:out value="${list.nextBltnOrgSubj}" escapeXml="false" />
						</a>
					</c:if>
			            	</p>
			            </td>   
			        </tr>
				</c:if>
		</table>
		<!-- table//-->
	    <!-- btnArea-->
	    <div class="btnArea">	    
			<div class="R">
	            <a class="btn_gray" style=cursor:pointer onclick="ebRead.actionBulletin('list',-1)">
				  <span>목록</span>
				</a>
				<c:if test="${boardVO.anonYn == 'N'}"><%--'익명/실명인증 게시판'이 아니면--%>
					<c:if test="${list.editable == 'true'}"><%--수정권한이 있는 경우--%>
						<a class="btn_white" style=cursor:pointer onclick="ebRead.actionSecurity('modify',${list.bltnNo},true)"><span>수정</span></a>
					</c:if>
					<c:if test="${list.editable == 'false'}"><%--수정권한이 없는 경우--%>
						<c:if test="${empty list.userId}"><%--익명글이면--%>
							<c:if test="${list.editableUserId == '_is_admin_'}"><%--관리자인 경우--%>
								<a class="btn_white" style=cursor:pointer onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true)"><span>수정</span></a>
							</c:if>
							<c:if test="${list.editableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
								<c:if test="${boardVO.writableYn == 'Y'}">
									<a class="btn_white" style=cursor:pointer onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,false)"><span>수정</span></a>
								</c:if>
							</c:if>
						</c:if>
					</c:if>			
					<c:if test="${list.editableUserId == '_is_admin_'}"><%--관리자인 경우--%>
						<a class="btn_white" style=cursor:pointer onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true)"><span>수정</span></a>
					</c:if>
				</c:if>
				<c:if test="${list.deletable == 'true'}"><%--삭제권한이 있는 경우--%>
					<a class="btn_white" style=cursor:pointer onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true)"><span>삭제</span></a>
				</c:if>
				<c:if test="${list.deletable == 'false'}"><%--삭제권한이 없는 경우--%>
					<c:if test="${empty list.userId}"><%--익명글이면--%>
						<c:if test="${list.deletableUserId == '_is_admin_'}"><%--관리자인 경우--%>
							<a class="btn_white" style=cursor:pointer onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true)"><span>삭제</span></a>
						</c:if>
						<c:if test="${list.deletableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
							<c:if test="${boardVO.writableYn == 'Y'}">
								<a class="btn_white" style=cursor:pointer onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,false)"><span>삭제</span></a>
							</c:if>
						</c:if>
					</c:if>  
				</c:if>
			</div>
		</div>
	</c:forEach>
	<!-- boardbtnArea// -->
</div>
</body>
<!-- board// -->
