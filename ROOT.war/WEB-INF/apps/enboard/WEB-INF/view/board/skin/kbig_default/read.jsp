<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.saltware.enboard.vo.BoardVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="loginInfo" value="${secPmsnVO.loginInfo}"/>

<c:if test="${boardVO.extUseYn == 'Y'}">
  <c:set var="rsExtnMapper" value="${boardVO.bltnExtnMapper}"/>
</c:if>
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
	<script>
		$(function(){
			try{
				parent.fn_childIframeAutoresize(parent.document.getElementById(window.name),parseInt($("#content_body").height())+50);
				parent.fn_scrollTop();
			}catch(e){
			}
			
			//댓글 개수 구하기
			var bltn_memo_count = $(".reply_row").size();
			$("#bltn_memo_count").text(bltn_memo_count+"개");
			
			$(".memoUpdateBtn, .cancelMemoBtn").click(function(){
				//iframe_resize
				parent.fn_childIframeAutoresize(parent.document.getElementById(window.name),parseInt($("#content").height()+50));
			})
		})
		$(document).ready(function(){
			$(".memo_reply_btn").click(function(){
				id = $(this).parents(".comment_top").find(".memo_real_id").val()
				$("#" + id).removeClass("reply").addClass("reply");
			})
			$(".memo_modify_btn").click(function(){
				id = $(this).parents(".comment_top").find(".memo_real_id").val()
				$("#" + id).removeClass("reply");
			})	
		})
		
		
	</script>
</head>
<body>
<div id="content_body">
	<%-- Bulletins in mode of multiview --%>
	<c:forEach items="${bltnVOs}" var="list">
		<div class="con_article">
			<div class="article">
				<%-- <table summary="게시판 상세" <c:out value="${boardVO.boardWidthDflt}"/>> --%>
				<table summary="게시판 상세">
					<caption>게시판 상세</caption>
					<colgroup>
						<col width="130px">
						<col width="*">
					</colgroup>							
					<tbody>
			        <c:if test="${boardVO.cateYn == 'Y'}">
				            <tr>
				                <th>카테고리</th>
				               	<td><c:out value="${list.cateNm}" escapeXml="false"/></td>
				            </tr>
				    </c:if>
						<tr>
							<td class="view_tit" colspan="2">
								<p class="tit"><c:out value="${list.bltnOrgSubj}" escapeXml="false"/></p>
								<ul class="cf">
									<li><c:out value="${list.regDatimSF}"/></li>
									<li>조회수 <span><c:out value="${list.bltnReadCnt}"/></span></li>
								</ul>
							</td>
						</tr>
		    	<c:if test="${boardVO.termYn == 'Y'}">
					<tr>
						<th>게시기간</th>
				        <td>
				        ${list.bltnBgnYmdF}~${list.bltnEndYmdF}
				        </td>
					</tr>
				</c:if>
						
	    <c:if test="${boardVO.extUseYn == 'Y'}">
		    <c:if test="${rsExtnMapper.ext_str0Yn == 'Y'}">
				            <tr>
				                <th>${rsExtnMapper.ext_str0Ttl} </th>
				               	<td>
				               		<c:choose>
					               		<c:when test="${boardVO.boardId=='popup_zone'}">
					               			<c:out value="${list.bltnExtnVO.ext_str0=='_self' ? '현재창' : '새창'}"/>
					               		</c:when>
					               		<c:otherwise>
										    <c:out value="${list.bltnExtnVO.ext_str0}"/>
					               		</c:otherwise>
				               		</c:choose>
				                </td>
				            </tr>
    	    </c:if>
		    <c:if test="${rsExtnMapper.ext_str1Yn == 'Y'}">
				            <tr>
				                <th>${rsExtnMapper.ext_str1Ttl} </th>
				               	<td>
								    <c:out value="${list.bltnExtnVO.ext_str1}"/>
				                </td>
				            </tr>
    	    </c:if>
        </c:if>


						<tr>
							<td colspan="2" class="viewArea">
								<c:out value="${list.bltnOrgCntt}" escapeXml="false"/>
							</td>
						</tr>
						 <c:set var="rsfile" value="${list.fileList}"/>
						<c:if test="${!empty rsfile}">
				            <tr>
				                <th>첨부파일</th>
				               	<td class="file_down">
				               		<ul>
					                	<c:forEach items="${rsfile}" var="fList">
							              	<!-- 다운로드 링크 -->  
									        	<li><c:out value="${fList.downloadLink}" escapeXml="false"/></li>
					              		</c:forEach>
				                	</ul>
				                </td>
				            </tr>
			            </c:if>	
					</tbody>
				</table> <!-- //table_left -->
				<div class="btn_wrap">
					<div class="box_left">
						<a class="btn btn_basic" href="#" onclick="ebRead.actionBulletin('list',-1); return false;">목 록</a>
					</div>
					<div class="box_right">
						<c:if test="${boardVO.replyableYn == 'Y' && boardVO.replyYn == 'Y'}"><%--답글쓰기 권한이 있는 경우--%>
						  <c:if test="${list.replyable || secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete}">
			                <a class="btn btn_point" href="#" onclick="javascript:ebRead.actionBulletin('reply',<c:out value="${list.bltnNo}"/>); return false;">답 변</a>
						  </c:if>
						  <c:if test="${!list.replyable && !(secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete)}">
			                <a class="btn btn_point" href="#" onclick="alert('작성자가 답글쓰기를 허용하지 않았습니다.'); return false;">답 변</a>
						  </c:if>
			            </c:if>
			            <c:if test="${boardVO.replyableYn == 'N' && boardVO.replyYn == 'Y' && (boardVO.anonYn == 'R' || boardVO.anonYn == 'P')}"><%--답글쓰기 권한이 없으나 실명인증 게시판인 경우--%>
			              <a class="btn btn_point" href="#" onclick="javascript:ebRead.actionBulletin('reply',<c:out value="${list.bltnNo}"/>); return false;">답 변</a>
			            </c:if>
		            	<c:if test="${boardVO.anonYn == 'N'}"><%--'익명/실명인증 게시판'이 아니면--%>
						  <c:if test="${list.editable == 'true'}"><%--수정권한이 있는 경우--%>
			                <a class="btn btn_point" href="#" onclick="javascript:ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true); return false;">수 정</a>
			              </c:if>
						  <c:if test="${list.editable == 'false'}"><%--수정권한이 없는 경우--%>
						    <c:if test="${empty list.userId}"><%--익명글이면--%>
						      <c:if test="${list.editableUserId == '_is_admin_'}"><%--관리자인 경우--%>
			                    <a class="btn btn_point" href="#" onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true); return false;">>수정</a>
			                  </c:if>
						      <c:if test="${list.editableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
								<c:if test="${boardVO.writableYn == 'Y'}">
			                      <a class="btn btn_point" href="#" onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,false); return false;">수 정</a>
								</c:if>
			                  </c:if>
						    </c:if>
						  </c:if>
			              <c:if test="${list.deletable == 'true'}"><%--삭제권한이 있는 경우--%>
			                <a class="btn btn_point" href="#" onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true); return false;">삭 제</a>
			              </c:if>
			              <c:if test="${list.deletable == 'false'}"><%--삭제권한이 없는 경우--%>
						    <c:if test="${empty list.userId}"><%--익명글이면--%>
						      <c:if test="${list.deletableUserId == '_is_admin_'}"><%--관리자인 경우--%>
			                    <a class="btn btn_point" href="#" onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true); return false;">삭 제</a>
			                  </c:if>
						      <c:if test="${list.deletableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
								<c:if test="${boardVO.writableYn == 'Y'}">
			                      <a class="btn btn_point" href="#" onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,false); return false;">삭 제</a>
								</c:if>
			                  </c:if>
							</c:if>  
						  </c:if>
						</c:if>
			            <c:if test="${boardVO.anonYn != 'N'}"><%--'익명/실명인증 게시판'인 경우--%>
						  <c:if test="${list.editableUserId == '_is_admin_'}"><%--관리자인 경우--%>
			                <a class="btn btn_point" href="#" onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true); return false;">수 정</a>
						  </c:if>
						  <c:if test="${list.editableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
			                <a class="btn btn_point" href="#" onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,false); return false;">수 정</a>
						  </c:if>
						  <c:if test="${list.deletableUserId == '_is_admin_'}"><%--관리자인 경우--%>
			                <a class="btn btn_point" href="#" onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true); return false;">삭 제</a>
						  </c:if>
						  <c:if test="${list.deletableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
			                <a class="btn btn_point" href="#" onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,false); return false;">>삭 제</a>
						  </c:if>
						</c:if>
					</div>
				</div>
			</div> <!-- //article -->
			<%-- <c:if test="${list.bltnTopTag != 'Y'}"><!-- 공지글이 아닐 때 --> --%>
	        <c:if test="${list.bltnTopTag != 'T'}">
		        <c:if test="${boardVO.memoYn == 'Y' && boardVO.memoWritableYn == 'Y'}">
					<div class="article">
						<div class="comment_wrap">
							<form name="memoForm_<c:out value="${list.bltnNo}"/>">
								<div class="comment_infor">
									<div class="comment_text">
										  <c:if test="${boardVO.anonYn == 'N'}"><%--익명게시판이 아닌 경우--%>
											<input type="hidden" name="userNick" size="10" value='<c:out value="${secPmsnVO.userNick}"/>' readonly="readonly" />
										  </c:if>
										  <c:if test="${boardVO.anonYn == 'Y'}"><%--익명게시판인 경우--%>
											<input type="text" name="userNick" size="10" />
										  </c:if>
										  <c:if test="${boardVO.anonYn == 'R' || boardVO.anonYn == 'P'}"><%--실명인증 게시판인 경우--%>
											<input type="text" name="userNick" size="10" readonly="readonly" 
												   value='<%=(session.getAttribute(Enview.getConfiguration().getString("session.realManNm.attr.name"))==null) ? "" : (String)session.getAttribute(Enview.getConfiguration().getString("session.realManNm.attr.name"))%>'
											/>
										  </c:if>
										<label for="memoCntt">
											<!--textarea ::  style="overflow:visible;height:40;width:100%;" -->
											<textarea name="memoCntt" id="memoCntt" class="comment_textarea" placeholder="건전한 토론문화와 양질의 댓글 문화를 위해, 타인에게 불쾌감을 주는 욕설 또는 특정 계층/민족, 종교 등을 비하하는 단어들은 표시가 제한됩니다."></textarea>
										</label>
										<a 
											name="memoBttn"
											class="btn btn_basic" 
		                            		href="#"
										  	<c:if test="${boardVO.memoWritableYn == 'Y'}">
											  <c:if test="${list.memoWritable || secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete}">
											    onclick="javascript:ebRead.actionBulletin('write-memo',<c:out value="${list.bltnNo}"/>);return false;"
											  </c:if>
											  <c:if test="${!list.memoWritable && !(secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete)}">
											    onclick="javascript:alert('작성자가 댓글쓰기를 허용하지 않았습니다.');return false;"
											  </c:if>
											</c:if>
										    <c:if test="${boardVO.memoWritableYn == 'N'}">
											  <c:if test="${boardVO.anonYn == 'R' || boardVO.anonYn == 'P'}">
											    onclick="javascript:alert('댓글을 작성할 수 없습니다. 실명인증을 받으십시오.');return false;"
											  </c:if>
											  <c:if test="${boardVO.anonYn != 'R' || boardVO.anonYn != 'P'}">
											    onclick="javascript:alert('댓글을 작성할 수 없습니다. 로그인 하십시오.');return false;"
											  </c:if>
											</c:if>
										 >
	                 						댓글입력 
	                 					</a>
									</div>
								</div>
							</form>
							<c:if test="${!empty list.memoList}">
								<c:set var="memo" value="${list.memoList}"/>
								<c:forEach items="${memo}" var="mList">
									<c:if test="${mList.memoLev != '1'}">
										<div class="comment_infor reply">
									</c:if> <!-- 답글일 경우 이미지 -->
									<c:if test="${mList.memoLev == '1'}">
										<div class="comment_infor">
									</c:if> <!-- 답글이 아닐경우-->
										<div class="comment_top">
											<p class="tit">
												<!-- name -->
												<c:if test="${boardVO.anonYn == 'N'}">
						                    		<c:out value="${mList.userNick}" escapeXml="false"/>
						                    	</c:if>
												<span>
													(<c:out value="${mList.regDatimF}"/>)
												</span>
											</p>
											
											<div class="box_right">
												<input type="hidden" class="memo_real_id" value="memoReplyDiv_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>"/>
												<c:if test="${boardVO.memoReplyYn == 'Y' && boardVO.memoReplyableYn == 'Y'}">
								                  <c:if test="${mList.memoLev == '1'}"><%--댓답글은 1레벨까지만--%>
													<c:if test="${list.memoReplyable || secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete}">
												      <a class="btn btn_st01 memo_reply_btn" onclick="ebRead.actionBulletin('reply-init-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>')">
													    답변
												      </a>
													</c:if>
												  </c:if>
												</c:if>
												<c:if test="${mList.editable == 'true'}">
							                    	<a class="btn btn_st01 memo_modify_btn" href="#" onclick="javascript:ebRead.actionBulletin('modify-init-memo','<c:out value="${mList.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>'); return false;">
							                    		수정
							                    	</a>
						                    	</c:if>
						                    	<c:if test="${mList.deletable == 'true'}">
							                    	<a class="btn btn_st01" href="#" onclick="javascript:ebRead.actionBulletin('delete-memo','<c:out value="${mList.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>'); return false;">
							                    		삭제
							                    	</a>
						                    	</c:if>
											</div>
										</div>
										<div class="comment_middle">
											<c:out value="${mList.memoCntt}" escapeXml="false"/>
										</div>
									</div>
									<div class="comment_infor reply" id="memoReplyDiv_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" style="display:none">
										<form name="memoReplyForm_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
											<input type="hidden" name="memoOrgCntt" value="<c:out value="${mList.memoOrgCntt}"/>" />
											<input type="hidden" name="rorm" />
											<div class="comment_top">
												<p class="tit">
													<c:if test="${boardVO.anonYn == 'N'}"><%--익명게시판이 아닌 경우--%>
														<input type="hidden" name="userNick" size="10" value='<c:out value="${secPmsnVO.userNick}"/>' readonly="readonly" />
													  	<c:out value="${secPmsnVO.userNick}"/>
													  </c:if>
													  <c:if test="${boardVO.anonYn == 'Y'}"><%--익명게시판인 경우--%>
														<input type="text" name="userNick" size="10" />
													  </c:if>
													  <c:if test="${boardVO.anonYn == 'R' || boardVO.anonYn == 'P'}"><%--실명인증 게시판인 경우--%>
														<input type="text" name="userNick" size="10" readonly="readonly"
															   value='<%=(session.getAttribute(Enview.getConfiguration().getString("session.realManNm.attr.name"))==null) ? "" : (String)session.getAttribute(Enview.getConfiguration().getString("session.realManNm.attr.name"))%>'
														/>
													  </c:if>
												 </p>
												<div class="box_right">
													<a class="btn btn_st01" href="#" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" onclick="javascript:ebRead.actionBulletin('rorm-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>');return false;">취소</a>
												</div>
											</div>
											<div class="comment_middle comment_text">
												<label for="memoCntt">
													<textarea name="memoCntt" id="memoCntt" class="comment_textarea" placeholder="건전한 토론문화와 양질의 댓글 문화를 위해, 타인에게 불쾌감을 주는 욕설 또는 특정 계층/민족, 종교 등을 비하하는 단어들은 표시가 제한됩니다."></textarea>
												</label>
												<a class="btn btn_basic" href="#" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" onclick="javascript:ebRead.actionBulletin('rorm-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>');return false;">등록</a>
											</div>
										</form>
									</div>
									
								</c:forEach>
							</c:if>
							
							
							
							
						</div> <!-- //comment_wrap -->
					</div> <!-- //article -->
				</c:if>
			</c:if>
			<%-- </c:if> --%> <!-- //공지글이 아닐 때 -->
			<div class="article">
				<table summary="이전글, 다음글" class="table_left">
					<caption>이전글, 다음글</caption>
					<colgroup class="pc">
						<col width="130px">
						<col width="*">
						<col width="100px">
					</colgroup>	
					<%-- <colgroup class="mobile">
						<col width="130px">
						<col width="*">
					</colgroup>	 --%>
					<tbody>
						<c:if test="${!empty list.prevBoardId && !empty list.prevBltnNo}">
							<c:if test="${list.prevBoardId == 'del_flag_y'}">
								<tr>
									<th class="prev">이전글</th>
									<td class="table_tit_wrap">
										<a href="#" class="table_tit">삭제된 글입니다.</a>
									</td>
									<td class="m_none"></td>
								</tr>
							</c:if>
							<c:if test="${list.prevBoardId != 'del_flag_y'}">
								<tr>
									<th class="prev">이전글</th>
									<td class="table_tit_wrap">
										<a href="#" class="table_tit" onclick="ebRead.readPrevNextBltn('<c:out value="${list.prevBoardId}"/>','<c:out value="${list.prevBltnNo}"/>'); return false;"><c:out value="${list.prevBltnOrgSubj}" escapeXml="false"/></a>
									</td>
									<td class="m_none"><c:out value="${list.prevRegDatimF}"/></td>
								</tr>
							</c:if>
						</c:if>
						<c:if test="${!empty list.nextBoardId && !empty list.nextBltnNo}">
							<c:if test="${list.nextBoardId == 'del_flag_y'}">
								<tr>
									<th class="next">다음글</th>
									<td class="table_tit_wrap">
									<a href="#" class="table_tit">삭제된 글입니다.</a>
									</td>
									<td class="m_none"></td>
								</tr>			
							</c:if>
							<c:if test="${list.nextBoardId != 'del_flag_y'}">
								<tr>
									<th class="next">다음글</th>
									<td class="table_tit_wrap">
										<a href="#" class="table_tit" onclick="ebRead.readPrevNextBltn('<c:out value="${list.nextBoardId}"/>','<c:out value="${list.nextBltnNo}"/>'); return false;"><c:out value="${list.nextBltnOrgSubj}" escapeXml="false"/></a>
									</td>
									<td class="m_none"><c:out value="${list.nextRegDatimF}"/></td>
								</tr>			
							</c:if>
						</c:if>					
					</tbody>
				</table> <!-- //table_left -->
			</div>
		</div> <!-- //con_article -->
	</c:forEach>
</div>
</body>
</html>



<%-- Bulletin List  --%>
<c:if test="${!empty bltnList && boardVO.readListYn == 'Y'}">
<table width=100% border=0 cellspacing=0 cellpadding=0>
  <%@ include file="list.jsp"%>
</table>
</c:if>
