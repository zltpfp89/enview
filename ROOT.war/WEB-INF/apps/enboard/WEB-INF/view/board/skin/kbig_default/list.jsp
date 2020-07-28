<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List,java.util.ArrayList"%>

<%@ page import="com.saltware.enview.Enview"%>
<%@ page import="com.saltware.enboard.integrate.DefaultBltnExtnMapper,com.saltware.enboard.integrate.DefaultBltnExtnVO"%>
<%@ page import="com.saltware.enview.components.dao.ConnectionContext"%>
<%@ page import="com.saltware.enview.components.dao.ConnectionContextForRdbms"%>
<%@ page import="com.saltware.enboard.security.SecurityMngr"%>
<%@ page import="com.saltware.enboard.vo.BoardVO"%>
<%@ page import="com.saltware.enview.components.dao.DAOFactory"%>
<%@ page import="com.saltware.enboard.dao.AdminDAO"%>
<%@ page import="com.saltware.enboard.form.AdminCateForm"%>


<%--BEGIN::현재 게시판이 속한 카테고리의 아들카테고리(바로 한레벨 밑의 카테고리)에 속한 게시판들의 목록을 뿌리는 예제--%>
<%
	ConnectionContext connCtxt = null;
	try {
		connCtxt = new ConnectionContextForRdbms (true);

		BoardVO brdVO = (BoardVO)request.getAttribute ("boardVO");
		AdminDAO admDAO = (AdminDAO)DAOFactory.getInst().getDAO (AdminDAO.DAO_NAME_PREFIX);

		String cateId = admDAO.getCateOfBoard (brdVO.getBoardId(), connCtxt);
		List childCateList = admDAO.getChildCatebase (cateId, true, SecurityMngr.getLocale (request), connCtxt);
		List boardList = new ArrayList();
		AdminCateForm acForm = new AdminCateForm();
		for (int i=0; i<childCateList.size(); i++) {
			acForm.setCateId ((String)childCateList.get(i));
			boardList.addAll (admDAO.getCateBoard (acForm, null, true, connCtxt));
		}
		
		System.out.println("boardList=["+boardList+"]");
		
		com.saltware.enboard.cache.CacheMngr ebCacheMngr = (com.saltware.enboard.cache.CacheMngr)Enview.getComponentManager().getComponent ("com.saltware.enboard.cache.CacheMngr");
		List directChildBoardList = new ArrayList();
		for (int i=0; i<boardList.size(); i++) {
			directChildBoardList.add (ebCacheMngr.getBoard ((String)boardList.get(i), SecurityMngr.getLocale (request)));
		}
		
		request.setAttribute ("dcBoardList", directChildBoardList);	
	
	} catch (Exception e) {
		if (connCtxt != null) connCtxt.rollback();
		// Ignore...
	} finally {
		if (connCtxt != null) connCtxt.release();
	}
%>
<!DOCTYPE HTML>
<html lang="ko-KR">
<head>
	<meta charset="UTF-8">
	<title>K-ICT 빅데이터 센터</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
	<!-- kbig 관련 소스 파일 -->
	<link rel="stylesheet" href="${cPath}/kbig/css/reset.css" />
	<link rel="stylesheet" href="${cPath}/kbig/css/nav.css" />
	<link rel="stylesheet" href="${cPath}/kbig/css/sub.css" />
	<%-- <script type="text/javascript" src="${cPath}/kbig/js/jquery-1.9.1.js"></script> --%>
	<script type="text/javascript" src="${cPath}/kbig/js/run.js"></script>
	<script type="text/javascript" src="${cPath}/kbig/js/kbig_common.js"></script>
</head>
<body>
		
<%--END::현재 게시판이 속한 카테고리의 아들카테고리(바로 한레벨 밑의 카테고리)에 속한 게시판들의 목록을 뿌리는 예제--%>
<%-- 확장필드 Mapper 설정 --%>
<c:if test="${boardVO.extUseYn == 'Y'}">
	<c:set var="extnMapper" value="${boardVO.bltnExtnMapper}"/>
</c:if>

	<!-- <div class="text_infor">
		<p class="tit">타이틀이 들어갑니다.</p>
		<p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p>
		<p>내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.내용이 들어갑니다.</p>
	</div> -->
	<div id="content_body">
		<div class="article">
			<div class="table_top cf">
				<p class="page_text"><span class="txt_point_01"><c:out value="${boardSttVO.page}"/></span>/<c:out value="${boardSttVO.totalPage}"/> 페이지(총 <c:out value="${boardSttVO.totalBltns}"/>건)</p>
				<form id="setSrch" name="setSrch" method="post" onsubmit="return ebList.srchBulletin();">
					<div class="sch_wrap">
						<c:if test="${boardVO.cateYn == 'Y' and boardVO.boardId != 'education'}">
						<div class="select_box">
						        <select name="cateSel" onchange="ebList.cateList(this.value)">
						          <option value="-1">전체</option>
						          <c:forEach items="${bltnCateList}" var="cList">
								    <c:if test="${!empty cList.bltnCateNm}">
						              <option value='<c:out value="${cList.bltnCateId}"/>' <c:if test="${cList.bltnCateId == boardSttVO.bltnCateId}">selected="selected"</c:if>><c:out value="${cList.bltnCateNm}"/></option>
									</c:if>
								  </c:forEach>
						        </select>
						  </div>
					      </c:if>
						<div class="select_box">
							<select id="list_order" name="srchType" title="Search Type" >
								<c:forEach items="${srchList}" var="list">
									<%-- <c:if test="${boardVO.boardId eq 'knowledge_notice' }">
										<c:if test="${ list.srchType ne 'Nick' }">
											<option value="<c:out value="${list.srchType}"/>" <c:if test="${boardSttVO.srchType == list.srchType}">selected="selected"</c:if>><c:out value="${list.srchText}"/></option>
										</c:if>
									</c:if> --%>
									<c:choose>
										<c:when test="${boardVO.boardId eq 'knowledge_notice' }">
											<c:if test="${ list.srchType ne 'Nick' }">
												<option value="<c:out value="${list.srchType}"/>" <c:if test="${boardSttVO.srchType == list.srchType}">selected="selected"</c:if>><c:out value="${list.srchText}"/></option>
											</c:if>
										</c:when>
										<c:otherwise>
											<option value="<c:out value="${list.srchType}"/>" <c:if test="${boardSttVO.srchType == list.srchType}">selected="selected"</c:if>><c:out value="${list.srchText}"/></option>										
										</c:otherwise>
									</c:choose>									
								</c:forEach>
							</select>			
						</div>
						<div class="board_sch">
							<fieldset>
								<label for="search" class="label_none"></label>
								<input type="text" placeholder="" class="" name="srchKey" id="search" value="<c:out value="${boardSttVO.srchKey}"/>" />
								<button id="" type="submit">검색</button>
							</fieldset>
						</div>
					</div> <!-- //board_sch_wrap -->
				</form>
			</div> <!-- //select_box -->
			<c:if test="${boardVO.cateYn == 'Y' and boardVO.boardId == 'education'}">
			<div class="tab_wrap">
				<ul class="tab_st01 no_${fn:length(bltnCateList) + 1}">
					<li class="${boardSttVO.bltnCateId =='-1'? 'on' : '' }" onclick="ebList.cateList(-1)"><button>전체</button></li>
		          <c:forEach items="${bltnCateList}" var="cList">
				    <c:if test="${!empty cList.bltnCateNm}">
		              <li class="${cList.bltnCateId == boardSttVO.bltnCateId ? 'on' : ''}"  onclick="ebList.cateList('${cList.bltnCateId}')"><button><c:out value="${cList.bltnCateNm}"/></button> 
					</c:if>
				  </c:forEach>
				</ul>
			</div>
			</c:if>			
			<table summary="게시판 리스트" class="table_m" <c:out value="${boardVO.boardWidthDflt}"/> <c:out value="${boardVO.boardBgColorDflt}"/> >
				<caption>게시판 리스트</caption>
				<colgroup class="pc">
		        	<%-- 글번호 --%>
		        	<c:if test="${boardVO.ttlNoYn == 'Y'}">
		        		<c:set var="colspanSize" value="${colspanSize + 1 }" />
		        		<col width="8%;" />
		        	</c:if>
		        	
		        	<%-- 카테고리 --%>
		        	<c:if test="${boardVO.ttlCateYn == 'Y'}">
			        	<c:if test="${boardVO.cateYn == 'Y'}">
			       			<c:set var="colspanSize" value="${colspanSize + 1 }" />
			       			<col width="10%" />
			        	</c:if>
		        	</c:if>
		        	
		        	<%-- 섬네일 미리보기 --%>
		       		<c:if test="${boardVO.ttlThumbYn == 'Y' || boardVO.listImageYn == 'Y'}">
		       			<c:set var="colspanSize" value="${colspanSize + 1 }" />
		       			<col width="10%" />
		       		</c:if>
		       		
		        	<%-- 제목 --%>
		        	<c:set var="colspanSize" value="${colspanSize + 1 }" />
		        	<col width="*" />
		        	
		        	<%-- 작성자 --%>
					<c:if test="${boardVO.ttlNickYn == 'Y'}">
						<c:set var="colspanSize" value="${colspanSize + 1 }" />
						<col width="14%;" />	
					</c:if>
					
					<%-- 확장필드 --%>
					<c:if test="${boardVO.extUseYn == 'Y'}">
					      <c:if test="${extnMapper.ext_str0Yn == 'Y' && extnMapper.ext_str0TtlYn == 'Y'}">
					      	<c:set var="colspanSize" value="${colspanSize + 1 }" />
			       			<col width="10%" />
					      </c:if>
					      <c:if test="${extnMapper.ext_str1Yn == 'Y' && extnMapper.ext_str1TtlYn == 'Y'}">
					      	<c:set var="colspanSize" value="${colspanSize + 1 }" />
			       			<col width="10%" />
					      </c:if>
					      <c:if test="${extnMapper.ext_str2Yn == 'Y' && extnMapper.ext_str2TtlYn == 'Y'}">
					      	<c:set var="colspanSize" value="${colspanSize + 1 }" />
			       			<col width="10%" />
					      </c:if>
					      <c:if test="${extnMapper.ext_str3Yn == 'Y' && extnMapper.ext_str3TtlYn == 'Y'}">
					      	<c:set var="colspanSize" value="${colspanSize + 1 }" />
			       			<col width="10%" />
					      </c:if>
					      <c:if test="${extnMapper.ext_str4Yn == 'Y' && extnMapper.ext_str4TtlYn == 'Y'}">
					      	<c:set var="colspanSize" value="${colspanSize + 1 }" />
			       			<col width="10%" />
					      </c:if>
					      <c:if test="${extnMapper.ext_str5Yn == 'Y' && extnMapper.ext_str5TtlYn == 'Y'}">
					      	<c:set var="colspanSize" value="${colspanSize + 1 }" />
			       			<col width="10%" />
					      </c:if>
					      <c:if test="${extnMapper.ext_str6Yn == 'Y' && extnMapper.ext_str6TtlYn == 'Y'}">
					      	<c:set var="colspanSize" value="${colspanSize + 1 }" />
			       			<col width="10%" />
					      </c:if>
					      <c:if test="${extnMapper.ext_str7Yn == 'Y' && extnMapper.ext_str7TtlYn == 'Y'}">
					      	<c:set var="colspanSize" value="${colspanSize + 1 }" />
			       			<col width="10%" />
					      </c:if>
					      <c:if test="${extnMapper.ext_str8Yn == 'Y' && extnMapper.ext_str8TtlYn == 'Y'}">
					      	<c:set var="colspanSize" value="${colspanSize + 1 }" />
			       			<col width="10%" />
					      </c:if>
					      <c:if test="${extnMapper.ext_str9Yn == 'Y' && extnMapper.ext_str9TtlYn == 'Y'}">
					      	<c:set var="colspanSize" value="${colspanSize + 1 }" />
			       			<col width="10%" />
					      </c:if>
					</c:if>
					
					<%-- 첨부파일 --%>
					<c:if test="${boardVO.listAtchYn == 'Y'}">
						<c:set var="colspanSize" value="${colspanSize + 1 }" />
						<col width="7%;" />	
					</c:if>
					
					<%-- 게시일 --%>
					<c:if test="${boardVO.ttlRegYn == 'Y'}">
						<c:set var="colspanSize" value="${colspanSize + 1 }" />
						<col width="14%;" />
					</c:if>
					
					<%-- 조회수 --%>
		        	<c:if test="${boardVO.ttlReadYn == 'Y'}">
		        		<c:set var="colspanSize" value="${colspanSize + 1 }" />
		        		<col width="10%;" />
		        	</c:if>
		        	
		        	<%-- 읽음여부 --%>
		       		<c:if test="${isUseReadYn eq true }">
		       			<c:set var="colspanSize" value="${colspanSize + 1 }" />
		       			<col width="10%;" />
		       		</c:if>
				</colgroup>
				<thead class="m_none">
					<tr>
						<%-- 글번호 --%>
			        	<c:if test="${boardVO.ttlNoYn == 'Y'}">
			        		<th class="num">번호</th>
			        	</c:if>
			        	<%-- 카테고리 --%>
			        	<c:if test="${boardVO.ttlCateYn == 'Y'}">
				        	<c:if test="${boardVO.cateYn == 'Y'}">
				        		<th><b>머리글</b></th>
				        	</c:if>
			        	</c:if>
			        	
						<%-- 섬네일 미리보기 --%>
			        	<c:if test="${boardVO.ttlThumbYn == 'Y' || boardVO.listImageYn == 'Y'}">
			        		<th><b>쎔네일</b></th>
			        	</c:if>
			           	<%-- 제목 --%>
						<th>제목</th>
						
						<%-- 작성자 --%>
						<c:if test="${boardVO.ttlNickYn == 'Y'}">
							<th>작성자</th>
						</c:if>
						
						<%-- 확장필드 사용 --%>
					      <c:if test="${boardVO.extUseYn == 'Y'}">
						      <c:if test="${extnMapper.ext_str0Yn == 'Y' && extnMapper.ext_str0TtlYn == 'Y'}">
							      	<th><c:out value="${extnMapper.ext_str0Ttl}"/></th>
						      </c:if>
						      <c:if test="${extnMapper.ext_str1Yn == 'Y' && extnMapper.ext_str1TtlYn == 'Y'}">
							      	<th><c:out value="${extnMapper.ext_str1Ttl}"/></th>
						      </c:if>
						      <c:if test="${extnMapper.ext_str2Yn == 'Y' && extnMapper.ext_str2TtlYn == 'Y'}">
							      	<th><c:out value="${extnMapper.ext_str2Ttl}"/></th>
						      </c:if>
						      <c:if test="${extnMapper.ext_str3Yn == 'Y' && extnMapper.ext_str3TtlYn == 'Y'}">
							      	<th><c:out value="${extnMapper.ext_str3Ttl}"/></th>
						      </c:if>
						      <c:if test="${extnMapper.ext_str4Yn == 'Y' && extnMapper.ext_str4TtlYn == 'Y'}">
							      	<th><c:out value="${extnMapper.ext_str4Ttl}"/></th>
						      </c:if>
						      <c:if test="${extnMapper.ext_str5Yn == 'Y' && extnMapper.ext_str5TtlYn == 'Y'}">
							      	<th><c:out value="${extnMapper.ext_str5Ttl}"/></th>
						      </c:if>
						      <c:if test="${extnMapper.ext_str6Yn == 'Y' && extnMapper.ext_str6TtlYn == 'Y'}">
							      	<th><c:out value="${extnMapper.ext_str6Ttl}"/></th>
						      </c:if>
						      <c:if test="${extnMapper.ext_str7Yn == 'Y' && extnMapper.ext_str7TtlYn == 'Y'}">
							      	<th><c:out value="${extnMapper.ext_str7Ttl}"/></th>
						      </c:if>
						      <c:if test="${extnMapper.ext_str8Yn == 'Y' && extnMapper.ext_str8TtlYn == 'Y'}">
							      	<th><c:out value="${extnMapper.ext_str8Ttl}"/></th>
						      </c:if>
						      <c:if test="${extnMapper.ext_str9Yn == 'Y' && extnMapper.ext_str9TtlYn == 'Y'}">
							      	<th><c:out value="${extnMapper.ext_str9Ttl}"/></th>
						      </c:if>
							</c:if>
							
						<%-- 첨부파일 --%>
						<c:if test="${boardVO.listAtchYn == 'Y'}">
							<th>첨부</th>
						</c:if>
						
						<%-- 게시일 --%>
						<c:if test="${boardVO.ttlRegYn == 'Y'}">
							<th>게시일</th>
						</c:if>
						<%-- 조회수 --%>
			        	<c:if test="${boardVO.ttlReadYn == 'Y'}">
			        		<th>조회수</th>
			        	</c:if>
			        	<%-- 읽음여부 --%>
			        	<c:if test="${isUseReadYn eq true }">
			        		<th>읽음여부</th>
			        	</c:if>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty bltnList }">
						<tr>
							<td colspan="${colspanSize }">등록된 게시물이 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty bltnList }">
		       			<c:forEach items="${bltnList}" var="list">
			       				<c:if test="${list.bltnLev == '1'}"><%-- 답글이 아닐 때 --%>
			            			<c:if test="${list.boardRow == '0'}"><!--  -->
				            			<c:if test="${list.bltnTopTag == 'T'}">
				            				<tr class="notice">
				            			</c:if>
				            			<c:if test="${list.bltnTopTag == 'Y'}">
				            				<tr class="notice">
				            			</c:if>
				            			<c:if test="${list.bltnTopTag == 'N'}">
				            				<tr class="notice">
				            			</c:if>
				            		</c:if>
				            	</c:if>
				            	<c:if test="${list.bltnLev != '1'}"><%-- 답글이 아닐 때 --%>
				            		<tr class="reply">
				            	</c:if>
			       				
							 	<c:if test="${boardVO.ttlNoYn == 'Y'}">
					            	<td class="num">
					            		<%-- 읽기화면에서 목록 출력시 읽고 있는 글 표시 안할경우 --%>
					            		<%-- <c:if test="${list.selected == 'false'}"> --%>
							            		<%-- 일반글 --%>
							            		<c:if test="${list.boardRow != '0'}">
							            			<c:out value="${list.boardRow}"/>
							            		</c:if>
					            		<%-- </c:if> --%>
					            		<%-- 읽기화면에서 목록 출력시 읽고 있는 글 표시 할경우 --%>
					            		<%-- <c:if test="${list.selected != 'false'}">[선택됨]</c:if> --%>
					            	</td>
				            	</c:if>
				            	<!-- 카테고리 -->
						        <c:if test="${boardVO.ttlCateYn == 'Y'}">
							          <c:if test="${boardVO.cateYn == 'Y'}">
								          <td>
										    <c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
										      <c:out value="${list.cateNm}" escapeXml="false"/>
											</c:if>
										  </td>
							          </c:if>
						        </c:if>
						        
				                <!-- 썸내일 이미지 -->
				            	<c:if test="${boardVO.ttlThumbYn == 'Y' || boardVO.listImageYn == 'Y'}">
						          <td width="<c:out value="${boardVO.thumbSize}"/>" height="<c:out value="${boardVO.thumbSize}"/>">
								    <c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
									  <img src="<c:out value="${list.thumbImgSrc50}"/>" style="border:1px #dddddd solid;" />
									</c:if>
						          </td>
						        </c:if>
								<td class="table_tit_wrap">
									<a 
										href="javascript:void(0)"
										class="table_tit"
									    <c:if test="${list.readable == 'true'}">
									      <%--게시판이 가상게시판일 수도 있으므로, 게시물이 아니라 게시물이 속한 게시판의 boardId 를 이용하여 읽기화면으로 가야 한다.--%>
										  <c:if test="${boardVO.mergeType == 'A'}">
									        onclick="javascript:ebList.readBulletin('<c:out value="${boardVO.boardId}"/>','<c:out value="${list.bltnNo}"/>');"
										  </c:if>
										  <c:if test="${boardVO.mergeType != 'A'}">
									        onclick="javascript:ebList.readBulletin('<c:out value="${list.eachBoardVO.boardId}"/>','<c:out value="${list.bltnNo}"/>');"
										  </c:if>
									    </c:if>
									    <c:if test="${list.readable == 'false'}">
										  onclick="javascript:alert('작성자가 글읽기를 허용하지 않았습니다');"
									    </c:if>
									    title="<c:out value="${list.bltnOrgSubj}" escapeXml="false" />"
									  >
									  	<!-- 답글 여부 -->
										<c:if test="${list.bltnLev != '1'}">
										</c:if>
									  	<!-- 제목 표출 -->
										<c:out value="${list.bltnOrgSubj}" escapeXml="false" />
										<c:if test="${list.delFlag == 'y'}"><%--삭제표시된 답글있는 글--%>
										  삭제된 글입니다.
										</c:if>
									  </a>
									<p class="tit_icon">
										<!-- new -->
										<c:if test="${list.readable == 'true'}">
											<c:if test="${boardVO.ttlIconYn == 'Y'}">
												<c:if test="${boardVO.ttlNewYn == 'Y'}">
								                    <c:if test="${list.recentBltn == 'Y'}">
								                    	<span class="i_new">새글</span>
								                    </c:if>
								                </c:if>
											</c:if>
										</c:if>
										<c:if test="${list.boardRow != '0'}"><!-- 공지글이 아닐 때 -->
											<c:if test="${boardVO.ttlMemoYn == 'Y'}">
												<c:if test="${list.bltnMemoCnt != '0'}">
													<span class="i_reply">( <c:out value="${list.bltnMemoCnt}"/> )</span>
												</c:if>
											</c:if>
										</c:if>
										<%-- <c:if test="${boardVO.ttlReplyYn == 'Y'}">
							                <c:if test="${list.bltnReplyCnt != '0'}">
							               		<span class="i_reply">( <c:out value="${list.bltnReplyCnt}"/> )</span>
							                </c:if>
							             </c:if> --%>
										<!-- 비밀글 여부 -->
										<c:if test="${list.bltnSecretYn == 'Y'}">
											<span class="i_secret">비밀글</span>
										</c:if>
									</p>
								</td>
					        	<!-- 작성자 -->
				               	<c:if test="${boardVO.ttlNickYn == 'Y'}">
									<td class="L">
										<c:out value="${list.userNick}"/>
									</td>
								</c:if>
						        <%-- 확장필드 데이터 설정 --%>
								<c:if test="${boardVO.extUseYn == 'Y'}">
									<c:set var="extnVO" value="${list.bltnExtnVO}"/>
								</c:if>
						        <%-- 확장필드 사용 --%>
							      <c:if test="${boardVO.extUseYn == 'Y'}">
							        <c:if test="${extnMapper.ext_str0Yn == 'Y' && extnMapper.ext_str0TtlYn == 'Y'}">
							          <td id="i<c:out value="${list.bltnNo}"/>">
										<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
							              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str0}"/></c:if>
										</c:if>
							          </td>
							        </c:if>
							        <c:if test="${extnMapper.ext_str1Yn == 'Y' && extnMapper.ext_str1TtlYn == 'Y'}">
							          <td id="i<c:out value="${list.bltnNo}"/>">
										<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
							              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str1}"/></c:if>
										</c:if>
							          </td>
							        </c:if>
							        <c:if test="${extnMapper.ext_str2Yn == 'Y' && extnMapper.ext_str2TtlYn == 'Y'}">
							          <td id="i<c:out value="${list.bltnNo}"/>">
										<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
							              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str2}"/></c:if>
										</c:if>
							          </td>
							        </c:if>
							        <c:if test="${extnMapper.ext_str3Yn == 'Y' && extnMapper.ext_str3TtlYn == 'Y'}">
							          <td id="i<c:out value="${list.bltnNo}"/>">
										<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
							              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str3}"/></c:if>
										</c:if>
							          </td>
							        </c:if>
							        <c:if test="${extnMapper.ext_str4Yn == 'Y' && extnMapper.ext_str4TtlYn == 'Y'}">
							          <td id="i<c:out value="${list.bltnNo}"/>">
										<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
							              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str4}"/></c:if>
										</c:if>
							          </td>
							        </c:if>
							        <c:if test="${extnMapper.ext_str5Yn == 'Y' && extnMapper.ext_str5TtlYn == 'Y'}">
							          <td id="i<c:out value="${list.bltnNo}"/>">
										<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
							              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str5}"/></c:if>
										</c:if>
							          </td>
							        </c:if>
							        <c:if test="${extnMapper.ext_str6Yn == 'Y' && extnMapper.ext_str6TtlYn == 'Y'}">
							          <td id="i<c:out value="${list.bltnNo}"/>">
										<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
							              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str6}"/></c:if>
										</c:if>
							          </td>
							        </c:if>
							        <c:if test="${extnMapper.ext_str7Yn == 'Y' && extnMapper.ext_str7TtlYn == 'Y'}">
							          <td id="i<c:out value="${list.bltnNo}"/>">
										<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
							              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str7}"/></c:if>
										</c:if>
							          </td>
							        </c:if>
							        <c:if test="${extnMapper.ext_str8Yn == 'Y' && extnMapper.ext_str8TtlYn == 'Y'}">
							          <td id="i<c:out value="${list.bltnNo}"/>">
										<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
							              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str8}"/></c:if>
										</c:if>
							          </td>
							        </c:if>
							        <c:if test="${extnMapper.ext_str9Yn == 'Y' && extnMapper.ext_str9TtlYn == 'Y'}">
							          <td id="i<c:out value="${list.bltnNo}"/>">
										<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
							              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str9}"/></c:if>
										</c:if>
							          </td>
							        </c:if>
							        
							      </c:if>
							      <!-- 첨부파일 -->
					                <c:if test="${boardVO.listAtchYn == 'Y'}">
						                <td class="file">
											<c:if test="${list.fileDownable}">
												<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
								                  <c:if test="${!empty list.fileList}">
											          <a id="i<c:out value="${list.bltnNo}"/>" name="i<c:out value="${list.bltnNo}"/>">파일다운로드</a>
								                  </c:if>
												</c:if>
											</c:if>
						                </td>
					                </c:if>
							      <%-- 게시일 --%>
					            	<c:if test="${boardVO.ttlRegYn == 'Y'}">
					            		<td class="day"><c:out value="${list.regDatimSF}"/></td>
					            	</c:if>
									<%-- 조회수 --%>
					            	<c:if test="${boardVO.ttlReadYn == 'Y'}">
					            		<td class="num"><fmt:formatNumber value="${list.bltnReadCnt}" pattern="#,##0" /></td>
					            	</c:if>
								<c:if test="${isUseReadYn eq true }">
							          <td>
										<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
									      <c:if test="${empty list.firstReadDatim}">N</c:if>
									      <c:if test="${!empty list.firstReadDatim}">Y</c:if>
										</c:if>
									  </td>
								</c:if>
							</tr>
							 <c:if test="${boardVO.listCnttYn == 'Y'}"><!-- 게시글 내용 표시하기 -->
					            <tr>
					            	<td colspan="${colspanSize }" class="L">
					            		<div class="viewArea">
					                        <c:out value="${list.bltnOrgCntt}" escapeXml="false"/>
					                    </div>
					            	</td>
					            </tr>
				            </c:if>
		       			</c:forEach>
		       		</c:if>
				</tbody>
			</table>
			<div class="btn_wrap">
				<div class="box_right">
					<c:if test="${boardVO.writableYn == 'Y'}">
						<c:if test="${boardVO.mergeType == 'A'}">
							<a class="btn btn_point" style="cursor:pointer" onclick="javascript:ebList.writeBulletin();"><span>글쓰기</span></a>
						</c:if>
					</c:if>
					<c:if test="${(secPmsnVO.isAdmin || secPmsnVO.isSysop) && isInternal}">
						<a class="btn btn_point" style="cursor:pointer" onclick="javascript:location.href='/portal/default/home/manage.page';"><span>글쓰기</span></a>
					</c:if>
				</div>
			</div>
		</div> <!-- //article -->					
		<div class="paging" id="pageIndex">
		</div> <!-- //paging -->
	</div><!-- //content_body -->
<script language="javascript">
	try{
		fn_enboardPaging("${boardSttVO.page}", "${boardSttVO.totalPage}", 10);
		//var boardId = "${boardVO.boardId}";
		var iFrameId = "";
		parent.$('#EnviewContentArea').each(function(){
			iFrameId = $(this).children().attr('id');
		});	
		var hiddenH = $("#content_body").height();
		parent.fn_dataset_resize_Id(iFrameId, hiddenH); 	
		//parent.fn_childIframeAutoresize(parent.document.getElementById(window.name),parseInt($("#content_body").height())+50);
		//parent.fn_scrollTop();	
	}catch(e){
	}
</script>
	</body>
</html>

