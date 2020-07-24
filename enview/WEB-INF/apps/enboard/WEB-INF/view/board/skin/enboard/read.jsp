<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.saltware.enboard.vo.BoardVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="${pageContext.request.contextPath}/board/css/board/skin/enboard/bbs.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>

<c:set var="loginInfo" value="${secPmsnVO.loginInfo}" />

<c:if test="${boardVO.extUseYn == 'Y'}">
	<c:set var="rsExtnMapper" value="${boardVO.bltnExtnMapper}" />
</c:if>

<table width=100% border=0 cellspacing=0 cellpadding=0>
	<tr>
		<td align="center">
			<div class="board">

				<%-- Bulletins in mode of multiview --%>
				<c:forEach items="${bltnVOs}" var="list">
					<table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="2" colspan="15" bgcolor="blue"></td>
									</tr>
									<%--BEGIN::게시물 읽음여부를 표시할 때만--%>
									<tr>
										<td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">읽음여부</td>
										<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
										<td height="25" colspan="13" class="table_list_l"><c:if test="${!empty list.firstReadDatim}">
												<c:out value="${list.firstReadDatimF}" />
											</c:if></td>
									</tr>
									<tr>
										<td height="1" colspan="15" bgcolor="#dbdee7"></td>
									</tr>
									<%--END::게시물 읽음여부를 표시할 때만--%>
									<c:if test="${boardVO.cateYn == 'Y'}">
										<tr>
											<td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">Category</td>
											<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
											<td height="25" colspan="13" class="table_list_l"><c:out value="${list.cateNm}" escapeXml="false" /></td>
										</tr>
										<tr>
											<td height="1" colspan="15" bgcolor="#dbdee7"></td>
										</tr>
									</c:if>
									<%--확장필드 사용예 1--%>
									<c:if test="${boardVO.extUseYn == 'Y' && !empty list.bltnExtnVO}">
										<c:set var="rsExtnVO" value="${list.bltnExtnVO}" />
										<%--jsp:useBean id="rsExtnVO" type="com.saltware.enboard.integrate.DefaultBltnExtnVO"/--%>
									</c:if>
									<c:if test="${boardVO.extUseYn == 'Y' && rsExtnMapper.ext_str2Yn == 'Y'}">
										<tr>
											<td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">목 차</td>
											<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
											<td height="25" colspan="13" class="table_list_l"><c:if test="${!empty list.bltnExtnVO}">
													<c:out value="${rsExtnVO.ext_str2}" />
												</c:if></td>
										</tr>
										<tr>
											<td height="1" colspan="15" bgcolor="#dbdee7"></td>
										</tr>
									</c:if>
									<c:if test="${boardVO.extUseYn == 'Y' && rsExtnMapper.ext_str3Yn == 'Y'}">
										<tr>
											<td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">주 제 어</td>
											<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
											<td height="25" colspan="13" class="table_list_l"><c:if test="${!empty list.bltnExtnVO}">
													<c:out value="${rsExtnVO.ext_str3}" />
												</c:if></td>
										</tr>
										<tr>
											<td height="1" colspan="15" bgcolor="#dbdee7"></td>
										</tr>
									</c:if>
									<tr>
										<td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">제 목</td>
										<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
										<td height="25" colspan="13" class="table_list_l">
											<c:if test="${list.bltnBestLevel == '9'}"><c:out value="${boardVO.imgBest9}" escapeXml="false" /></c:if> 
											<c:if test="${list.delFlag=='T' }">  <font color='red'>[임시저장]</font>   </c:if>
											<c:out value="${list.bltnOrgSubj}" escapeXml="false" /> 
											<c:if test="${not empty list.bltnBgnYmd}"><c:out value="${list.bltnBgnYmdHmF}" /></c:if>
										</td>
									</tr>
									<tr>
										<td height="1" colspan="15" bgcolor="#dbdee7"></td>
									</tr>
									<%--확장필드 사용예 2--%>
									<c:if test="${boardVO.extUseYn == 'Y' && rsExtnMapper.ext_str1Yn == 'Y'}">
										<tr>
											<td height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">관 서</td>
											<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
											<td height="25" colspan="13" class="table_list_l"><c:if test="${!empty list.bltnExtnVO}">
													<c:out value="${rsExtnVO.ext_str1}" />
												</c:if></td>
										</tr>
										<tr>
											<td height="1" colspan="15" bgcolor="#dbdee7"></td>
										</tr>
									</c:if>
									<tr>
										<c:if test="${boardVO.anonYn == 'N'}">
											<%--익명게시판이 아니다--%>
											<td width="80" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" class="table_title_l">작 성 자</td>
											<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
											<td width="70" class="table_list_l"><c:out value="${list.userNick}" /></td>
										</c:if>
										<c:if test="${boardVO.boardType == 'C' && list.bltnGq == '0'}">
											<%-- 지식형인 경우, 원문이면 내건 점수 --%>
											<td width="37" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">포인트</td>
											<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
											<td width="35" class="table_list_l"><c:out value="${list.betPnt}" /></td>
										</c:if>
										<c:if test="${boardVO.boardType != 'C' || (boardVO.boardType == 'C' && list.bltnGq != '0')}">
											<td width="45" height="25"></td>
											<td width="3"></td>
											<td width="35"></td>
										</c:if>
										<td width="80" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">작성일</td>
										<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
										<td width="70" class="table_list_l"><c:out value="${list.regDatimSF}" /></td>
										<td width="65" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">최종수정일</td>
										<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
										<td width="70" class="table_list_l"><c:out value="${list.updDatimSF}" /></td>
										<td width="40" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">조회수</td>
										<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
										<td class="table_list_l"><c:out value="${list.bltnReadCnt}" /></td>
									</tr>
									<c:if test="${boardVO.bltnBadYn == 'Y'}">
										<%--불량게시물 신고기능 사용--%>
										<c:if test="${!empty list.badBltnCntt}">
											<%--불량게시물 신고된 경우--%>
											<tr>
												<td height="1" colspan="15" bgcolor="#dbdee7"></td>
											</tr>
											<tr>
												<td colspan="15" class="table_list_c">관리자에 의해 삭제되었습니다.<br> 사유 - <c:out value="${list.badBltnCntt}" />
												</td>
											</tr>
										</c:if>
									</c:if>
									<tr>
										<td height="1" colspan="15" bgcolor="#dbdee7"></td>
									</tr>
									<tr>
										<td colspan="15">
											<table width="100%" border="0" cellspacing="0" cellpadding="0" style="table-layout: fixed">
												<tr>
													<td align="left" valign="top" class="content_text" style="word-wrap: break-word; word-break: break-all"><c:out value="${list.bltnOrgCntt}" escapeXml="false" /></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<%-- Poll --%>
									<c:if test="${!empty list.pollList}">
										<form name=pollForm_ <c:out value="${list.bltnNo}"/> style="display: inline">
											<tr>
												<td height="1" colspan="4" bgcolor="#dbdee7"></td>
											</tr>
											<tr>
												<td width="100" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">전체투표수</td>
												<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
												<td width="70" height="25" class="table_list_l"><c:out value="${list.pollHitSum}" /></td>
												<c:if test="${boardVO.boardType == 'B'}">
													<td height="25" class="table_list_l"><a onclick="ebRead.actionBulletin('poll','<c:out value="${list.bltnNo}"/>')" style="cursor: pointer"> <c:out value="${boardVO.imgSmallPoll}" escapeXml="false" />
													</a></td>
												</c:if>
											</tr>
											<tr>
												<td height="1" colspan="4" bgcolor="#dbdee7"></td>
											</tr>
											<tr>
												<td class="td_pad" colspan="4">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<c:if test="${boardVO.pollImgYn != 'Y'}">
															<colgroup width="50%" />
															<colgroup width="50%" />
														</c:if>
														<c:if test="${boardVO.pollImgYn == 'Y'}">
															<colgroup width="30%" />
															<colgroup width="40%" />
															<colgroup width="30%" />
														</c:if>
														<c:set var="poll" value="${list.pollList}" />
														<c:forEach items="${poll}" var="pList">
															<tr>
																<c:if test="${boardVO.pollImgYn == 'Y'}">
																	<td align=absmiddle><c:out value="${pList.imgBdLine}" /></td>
																</c:if>
																<td>
																	<table>
																		<tr>
																			<td width=20><c:out value="${pList.pollSeq}" />.</td>
																			<td width=30><input type=radio name=poll value=<c:out value="${pList.pollSeq}"/>></td>
																			<td width=<c:out value="${pList.pollCnttSize}"/>><c:out value="${pList.pollCntt}" /></td>
																		</tr>
																	</table>
																</td>
																<td align=right><c:out value="${pList.pollRate}" />% [<c:out value="${pList.pollHit}" />] <input type=hidden name=pollGraphSize value=<c:out value="${pList.pollGraphSize}"/>> <c:out value="${boardVO.imgPollL}"
																		escapeXml="false" /> <c:out value="${boardVO.imgPollC}" escapeXml="false" /> <c:out value="${boardVO.imgPollR}" escapeXml="false" /></td>
															</tr>
														</c:forEach>
													</table>
												</td>
											</tr>
										</form>
									</c:if>

									<%-- Attached file --%>
									<c:set var="rsfile" value="${list.fileList}" />
									<c:if test="${!empty rsfile}">
										<tr>
											<td height="1" colspan="4" bgcolor="#dbdee7"></td>
										</tr>
										<tr>
											<td colspan="4">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="100" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">첨부파일</td>
														<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
														<td height="25" class="table_list_l"><c:forEach items="${rsfile}" var="fList">
																<!-- 다운로드 링크 -->
																<c:out value="${fList.downloadLink}" escapeXml="false" />&nbsp; (<c:out value="${fList.sizeSF}" />)<br>
																<%--
	              	<!-- 열기 링크 -->   
			        <c:out value="${fList.downopenLink}" escapeXml="false"/>&nbsp; (<c:out value="${fList.sizeSF}"/>)<br>
			        <!-- 다운로드 & 다운로드 & 카운트 증가 링크 -->
			        <c:out value="${fList.downloadCntLink}" escapeXml="false"/>&nbsp;  (<c:out value="${fList.sizeSF}"/>)(<c:out value="${fList.downCntCF}"/>)<br>
			        <!-- 열기 & 다운로드 카운트 증가 링크 -->
			        <c:out value="${fList.downopenCntLink}" escapeXml="false"/>&nbsp;  (<c:out value="${fList.sizeSF}"/>)(<c:out value="${fList.downCntCF}"/>)<br>
			         --%>
															</c:forEach></td>
													</tr>
												</table>
											</td>
										</tr>
									</c:if>

									<%-- Permit --%>
									<c:if test="${boardVO.permitYn == 'Y'}">
										<c:if test="${secPmsnVO.ablePermit == 'true'}">
											<tr>
												<td height="1" colspan="4" bgcolor="#dbdee7"></td>
											</tr>
											<tr>
												<td colspan="4">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="100" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">게시승인</td>
															<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
															<td height="25" class="table_list_l"><c:if test="${list.bltnPermitYn == 'Y'}">
																	<c:out value="${boardVO.imgPermit}" escapeXml="false" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a style="cursor: pointer" onclick="ebRead.actionBulletin('permit_no','<c:out value="${list.bltnNo}"/>')"> <c:out value="${boardVO.imgForbid}" escapeXml="false" />
																	</a>
																</c:if> <c:if test="${list.bltnPermitYn == 'N'}">
																	<a style="cursor: pointer" onclick="ebRead.actionBulletin('permit_yes','<c:out value="${list.bltnNo}"/>')"> <c:out value="${boardVO.imgPermit}" escapeXml="false" />
																	</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <c:out value="${boardVO.imgForbid}" escapeXml="false" />
																</c:if></td>
														</tr>
													</table>
												</td>
											</tr>
										</c:if>
									</c:if>

									<%-- Appraisal. two option(추천/반대). --%>
									<c:if test="${boardVO.rcmdYn == 'Y'}">
										<tr>
											<td height="1" colspan="4" bgcolor="#dbdee7"></td>
										</tr>
										<tr>
											<td colspan="4">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="100" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">추천/반대</td>
														<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
														<td height="25" class="table_list_l"><a style="cursor: pointer" onclick="ebRead.actionBulletin('eval-up','<c:out value="${list.bltnNo}"/>')"> <c:out value="${boardVO.imgRcmdUp}" escapeXml="false" /> Good
														</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a style="cursor: pointer" onclick="ebRead.actionBulletin('eval-dn','<c:out value="${list.bltnNo}"/>')"> <c:out value="${boardVO.imgRcmdDn}" escapeXml="false" /> Bad
														</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color=#ED7642><b>추천:<c:out value="${list.bltnRcmdUpCnt}" />명&nbsp;&nbsp;&nbsp;반대:<c:out value="${list.bltnRcmdDnCnt}" />명
															</b></font></td>
													</tr>
												</table>
											</td>
										</tr>
									</c:if>
									<%-- Appraisal. multiple option(평가).--%>
									<c:if test="${boardVO.evalYn == 'Y'}">
										<c:set var="evalLevel" value="${boardVO.evalLevelList}" />
										<%--jsp:useBean id="evalLevel" type="java.util.List"/--%>
										<c:if test="${!empty evalLevel}">
											<tr>
												<td height="1" colspan="4" bgcolor="#dbdee7"></td>
											</tr>
											<tr>
												<td colspan="4">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="100" height="50" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">글 평가</td>
															<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
															<td height="50" class="table_list_l">현재 <font color=#ED7642><b><c:out value="${list.bltnEvalCntCF}" /></b></font>분이 평가하셨습니다.&nbsp; 총점:&nbsp;<font color=#ED7642><b><c:out value="${list.bltnEvalSumCF}" /></b></font>&nbsp;
																평점:&nbsp;<font color=#ED7642><b><c:out value="${list.bltnEvalAvgCF}" /></b></font> <br> <c:if test="${list.bltnEvaled == 'Y'}">
																	<c:forEach items="${evalLevel}" var="levelList">
																		<c:if test="${levelList.code == list.bltnEvalPnt}">                      
				        이미 <font color=#ED7642><b>'<c:out value="${levelList.codeName}" />'(<c:out value="${levelList.code}" />)
																			</b></font> (으)로 평가하셨습니다.
                      </c:if>
																	</c:forEach>
																</c:if> <c:if test="${list.bltnEvaled == 'N'}">
																	<c:forEach items="${evalLevel}" var="levelList">
																		<input type="radio" name="pnt" value=<c:out value="${levelList.code}"/> onclick="ebRead.actionBulletin('eval','<c:out value="${list.bltnNo}"/>')">
																		<c:out value="${levelList.codeName}" />
																	</c:forEach>
																</c:if>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</c:if>
									</c:if>
									<tr>
										<td height="2" colspan="15" bgcolor="blue"></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td height="5"></td>
						</tr>
						<tr>
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<%-- Reply List --%>
									<c:if test="${boardVO.readReplyYn == 'Y'}">
										<c:if test="${!empty list.replyList}">
											<tr>
												<td>
													<table width=100% border=0 cellspacing=0 cellpadding=0>
														<tr height=0>
															<td width=20></td>
															<c:if test="${boardVO.cateYn == 'Y'}">
																<td width=60></td>
															</c:if>
															<td></td>
															<c:if test="${boardVO.anonYn == 'N'}">
																<td width=80></td>
															</c:if>
															<td width=110></td>
															<td width=40></td>
														</tr>
														<%-- list of reply --%>
														<c:forEach items="${list.replyList}" var="rList">
															<tr height=22>
																<td><c:if test="${rList.selected == 'true'}">
																		<img src="${pageContext.request.contextPath}/board/images/board/skin/enboard/icon_arrow.gif" align="absmiddle" />
																	</c:if></td>
																<c:if test="${boardVO.cateYn == 'Y'}">
																	<td align=center><c:if test="${rList.delFlag == 'N'}">
																			<%--삭제표시되지 않은 정상적인 글일때만--%>
																			<c:out value="${rList.cateNm}" escapeXml="false" />
																		</c:if></td>
																</c:if>
																<td align=left><c:if test="${rList.delFlag == 'N'}">
																		<%--삭제표시되지 않은 정상적인 글일때만--%>
																		<c:if test="${!empty rList.bltnBestLevel && rList.bltnBestLevel > '0'}">
																			<%--최고답변으로선정되었다--%>
																			<c:if test="${rList.bltnBestLevel == '9'}">
																				<c:out value="${boardVO.imgBest9}" escapeXml="false" />
																			</c:if>
																			<c:if test="${rList.bltnBestLevel == '8'}">
																				<c:out value="${boardVO.imgBest8}" escapeXml="false" />
																			</c:if>
																			<c:if test="${rList.bltnBestLevel == '7'}">
																				<c:out value="${boardVO.imgBest7}" escapeXml="false" />
																			</c:if>
																		</c:if>
																		<c:if test="${empty rList.bltnBestLevel || rList.bltnBestLevel == '0'}">
																			<c:if test="${boardVO.permitYn == 'Y' && rList.bltnPermitYn == 'N'}">
																				<%--승인기능을 사용하는데 승인이 되질 않았다.--%>
																				<c:out value="${boardVO.imgProhibit}" escapeXml="false" />
																			</c:if>
																			<c:if test="${boardVO.permitYn == 'N' || rList.bltnPermitYn != 'N' }">
																				<c:if test="${rList.bltnIcon == 'A'}">
																					<c:out value="${boardVO.imgDoc}" escapeXml="false" />
																				</c:if>
																				<c:if test="${rList.bltnIcon == 'B'}">
																					<c:out value="${boardVO.imgFile}" escapeXml="false" />
																				</c:if>
																				<c:if test="${rList.bltnIcon == 'C'}">
																					<c:out value="${boardVO.imgPoll}" escapeXml="false" />
																				</c:if>
																				<c:if test="${rList.bltnIcon == 'D'}">
																					<c:out value="${boardVO.imgSecret}" escapeXml="false" />
																				</c:if>
																			</c:if>
																		</c:if>

																		<c:if test="${rList.bltnLev != '1'}">
																			<span style="visibility: hidden"><img src='' height=1 width=<c:out value="${rList.bltnLevLen}"/>></span>
																			<c:out value="${boardVO.imgRe}" escapeXml="false" />
																		</c:if>

																		<c:if test="${rList.betPnt > '0'}">
																			<font color=#A51818>$<c:out value="${rList.betPnt}" /></font>
																		</c:if>

																		<font style="cursor: pointer" OnMouseOver=this.style.textDecoration= 'underline' OnMouseOut=this.style.textDecoration=
																			'none'
					<%--게시판이 가상게시판일 수도 있으므로, 게시물이 아니라 게시물이 속한 게시판의 boardId 를 이용하여 읽기화면으로 가야 한다.--%>
					onclick="ebList.readBulletin('<c:out value="${boardVO.boardId}"/>','<c:out value="${rList.bltnNo}"/>')"> <c:out
																				value="${rList.bltnOrgSubj}" escapeXml="false" />
																		</font>

																		<c:if test="${not empty rList.bltnBgnYmd}">
																			<c:out value="${rList.bltnBgnYmdHmF}" />
			    ~<c:out value="${rList.bltnEndYmdHmF}" />
																		</c:if>

																		<c:if test="${rList.bltnMemoCnt != '0'}">
																			<font color="#CC4848">(<c:out value="${rList.bltnMemoCnt}" />)
																			</font>
																		</c:if>

																		<c:if test="${rList.recentBltn == 'Y'}">
																			<c:out value="${boardVO.imgNew}" escapeXml="false" />
																		</c:if>
																	</c:if> <c:if test="${rList.delFlag == 'y'}">
																		<%--답글이 있어서 실제로 삭제되지 않고 삭제표시만 된 답글있는 글--%>
				  삭제된 글입니다.
				</c:if></td>
																<c:if test="${empty rList.fileList}">
																	<%--답변글에 첨부파일 목록이 없으면--%>
																	<td align=center></td>
																</c:if>
																<c:if test="${!empty rList.fileList}">
																	<%--답변글에 첨부파일 목록이 있으면--%>
																	<td align=center><c:if test="${rList.delFlag == 'N'}">
																			<%--삭제표시되지 않은 정상적인 글일때만--%>
																			<c:forEach items="${rList.fileList}" var="rfList">
																				<c:out value="${rfList.downloadImgLink}" escapeXml="false" />
																			</c:forEach>
																		</c:if></td>
																</c:if>
																<c:if test="${boardVO.anonYn == 'N'}">
																	<td><c:if test="${rList.delFlag == 'N'}">
																			<%--삭제표시되지 않은 정상적인 글일때만--%>
																			<c:out value="${rList.userNick}" escapeXml="false" />
																		</c:if></td>
																</c:if>
																<td align=center><c:if test="${rList.delFlag == 'N'}">
																		<%--삭제표시되지 않은 정상적인 글일때만--%>
																		<c:out value="${rList.regDatimSF}" />
																	</c:if></td>
																<td align=right><c:if test="${rList.delFlag == 'N'}">
																		<%--삭제표시되지 않은 정상적인 글일때만--%>
																		<c:out value="${rList.bltnReadCnt}" />&nbsp;
				  </c:if></td>
																<c:if test="${!empty rList.firstReadDatim}">
																	<td align=center><c:if test="${rList.delFlag == 'N'}">
																			<%--삭제표시되지 않은 정상적인 글일때만--%>
																			<c:if test="${empty rList.firstReadDatim}">N</c:if>
																			<c:if test="${!empty rList.firstReadDatim}">Y</c:if>
																		</c:if></td>
																</c:if>
																<td><c:if test="${rList.delFlag == 'N'}">
																		<%--삭제표시되지 않은 정상적인 글일때만--%>
																		<c:if test="${boardVO.anonYn == 'N'}">
																			<%--'익명/실명인증 게시판'이 아니면--%>
																			<c:if test="${rList.editable == 'true'}">
																				<%--수정권한이 있는 경우--%>
																				<a style="cursor: pointer" onclick="ebRead.actionSecurity('modify',<c:out value="${rList.bltnNo}"/>,true)"> <c:out value="${boardVO.imgModify}" escapeXml="false" />
																				</a>&nbsp;
				  </c:if>
																			<c:if test="${rList.editable == 'false'}">
																				<%--수정권한이 없는 경우--%>
																				<c:if test="${empty rList.userId}">
																					<%--익명글이면--%>
																					<c:if test="${rList.editableUserId == '_is_admin_'}">
																						<%--관리자인 경우--%>
																						<a style="cursor: pointer" onclick="ebRead.actionSecurity('modify',<c:out value="${rList.bltnNo}"/>,true)"> <c:out value="${boardVO.imgModify}" escapeXml="false" />
																						</a>&nbsp;
					  </c:if>
																					<c:if test="${rList.editableUserId != '_is_admin_'}">
																						<%--관리자가 아닌 경우--%>
																						<c:if test="${boardVO.writableYn == 'Y'}">
																							<a style="cursor: pointer" onclick="ebRead.actionSecurity('modify',<c:out value="${rList.bltnNo}"/>,false)"> <c:out value="${boardVO.imgModify}" escapeXml="false" />
																							</a>&nbsp;
						</c:if>
																					</c:if>
																				</c:if>
																			</c:if>
																			<c:if test="${rList.deletable == 'true'}">
																				<%--삭제권한이 있는 경우--%>
																				<a style="cursor: pointer" onclick="ebRead.actionSecurity('delete',<c:out value="${rList.bltnNo}"/>,true)"> <c:out value="${boardVO.imgDelete}" escapeXml="false" />
																				</a>&nbsp;
				  </c:if>
																			<c:if test="${rList.deletable == 'false'}">
																				<%--삭제권한이 없는 경우--%>
																				<c:if test="${empty rList.userId}">
																					<%--익명글이면--%>
																					<c:if test="${rList.deletableUserId == '_is_admin_'}">
																						<%--관리자인 경우--%>
																						<a style="cursor: pointer" onclick="ebRead.actionSecurity('delete',<c:out value="${rList.bltnNo}"/>,true)"> <c:out value="${boardVO.imgDelete}" escapeXml="false" />
																						</a>&nbsp;
					  </c:if>
																					<c:if test="${rList.deletableUserId != '_is_admin_'}">
																						<%--관리자가 아닌 경우--%>
																						<c:if test="${boardVO.writableYn == 'Y'}">
																							<a style="cursor: pointer" onclick="ebRead.actionSecurity('delete',<c:out value="${rList.bltnNo}"/>,false)"> <c:out value="${boardVO.imgDelete}" escapeXml="false" />
																							</a>&nbsp;
						</c:if>
																					</c:if>
																				</c:if>
																			</c:if>
																		</c:if>
																	</c:if></td>
															</tr>
														</c:forEach>
													</table>
												</td>
											</tr>
											<tr>
												<td height="5" colspan="4"></td>
											</tr>
										</c:if>
									</c:if>

									<%-- List of Memo --%>
									<c:if test="${!empty list.memoList}">
										<c:set var="memo" value="${list.memoList}" />
										<%--jsp:useBean id="memo" type="java.util.List"/--%>
										<tr>
											<td colspan=4>
												<table width=100% border="0" cellpadding="4" cellspacing="1" bgcolor="#E0E0E0">
													<c:forEach items="${memo}" var="mList" varStatus="mVar">
														<tr>
															<td align="left" valign="top" bgcolor="#F5F5F5" onMouseOver="this.style.backgroundColor= 'CCCCCC';" onMouseOut="this.style.backgroundColor='#F5F5F5';">
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tr>
																		<td><c:if test="${mList.memoLev != '1'}">
																				<span style="visibility: hidden"><img src='' height=1 width=<c:out value="${mList.memoLevLen}"/>></span>
																				<c:out value="${boardVO.imgRe}" escapeXml="false" />
																			</c:if></td>
																		<td align="left"><c:if test="${boardVO.anonYn == 'N'}">
																				<img src="${pageContext.request.contextPath}/board/images/board/skin/enboard/icon_person.gif" align="absmiddle" />
																				<b><c:out value="${mList.userNick}" escapeXml="false" /></b>
																			</c:if> (<c:out value="${mList.regDatimF}" />)&nbsp;&nbsp;<font color=#888888><c:out value="${mList.maskUserIp}" /></font></td>
																		<td align=right><c:if test="${boardVO.badStdCnt > '0'}">
																				<c:if test="${mList.badCnt > '0'}">
																					<font style="font-size: 7pt" color=#264C72>+<c:out value="${mList.badCnt}" /></font>
																				</c:if>
																				<img src=${pageContext.request.contextPath}/board/images/board/skin/enboard/i_bad.gif align=absmiddle style="cursor: pointer" title=신고하기
																					onclick="ebRead.actionBulletin('bad-memo','<c:out value="${mList.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>')">&nbsp;
                        </c:if> <c:if test="${boardVO.memoReplyYn == 'Y' && boardVO.memoReplyableYn == 'Y'}">
																				<c:if test="${mList.memoLev == '1'}">
																					<%--댓답글은 1레벨까지만--%>
																					<c:if test="${list.memoReplyable || secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete}">
																						<a style="cursor: pointer" onclick="ebRead.actionBulletin('reply-init-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>')"> <c:out value="${boardVO.imgMemoR}" escapeXml="false" />
																						</a>
																					</c:if>
																					<c:if test="${!list.memoReplyable && !(secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete)}">
																						<a style="cursor: pointer" onclick="alert('작성자가 댓답글쓰기를 허용하지 않았습니다.')"> <c:out value="${boardVO.imgMemoR}" escapeXml="false" />
																						</a>
																					</c:if>
																				</c:if>
																			</c:if> <c:if test="${mList.editable == 'true'}">
																				<a style="cursor: pointer" onclick="ebRead.actionBulletin('modify-init-memo','<c:out value="${mList.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>')"> <c:out value="${boardVO.imgMemoU}" escapeXml="false" />
																				</a>
																			</c:if> <c:if test="${mList.deletable == 'true'}">
																				<a style="cursor: pointer" onclick="ebRead.actionBulletin('delete-memo','<c:out value="${mList.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>')"> <c:out value="${boardVO.imgMemoX}" escapeXml="false" />
																				</a>
																			</c:if></td>
																	</tr>
																	<tr>
																		<td><c:if test="${mList.memoLev != '1'}">
																				<span style="visibility: hidden"><img src='' height=1 width=<c:out value="${mList.memoLevLen}"/>></span>
																			</c:if></td>
																		<td class="td_pad" colspan=2><c:out value="${mList.memoCntt}" escapeXml="false" /> <c:forEach items="${mList.fileList}" var="f" varStatus="fs">
																				<!-- 다운로드 링크 -->
																				<c:out value="${f.downloadLink}" escapeXml="false" />&nbsp; (<c:out value="${f.sizeSF}" />)${fs.last ? "" :  ","}
					      													</c:forEach></td>
																	</tr>
																	<tr>
																		<td><c:if test="${mList.memoLev != '1'}">
																				<span style="visibility: hidden"><img src='' height=1 width=<c:out value="${mList.memoLevLen}"/>></span>
																			</c:if></td>
																		<td colspan=2>
																			<div id="memoReplyDiv_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" style="display: none">
																				<form name="memoReplyForm_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
																					<input type=hidden name="memoOrgCntt" value="<c:out value="${mList.memoOrgCntt}"/>"> <input type=hidden name=rorm> 
																					<input type="hidden" name="fileName" value="${mList.fileName}" > 
																					<input type="hidden" name="fileSize" value="${mList.fileSize}" > 
																					<input type="hidden" name="fileMask" value="${mList.fileMask}" >
																					<table width=100%>
																						<tr>
																							<td width="100" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l"><c:if test="${boardVO.anonYn == 'N'}">
																									<%--익명/실명인증 게시판이 아닌 경우--%>작성자<br>
																									<input type=text name=userNick size=10 value='<c:out value="${loginInfo.nm_kor}" escapeXml="false"/>' readonly>
																								</c:if> <c:if test="${boardVO.anonYn == 'Y'}">
																									<%--익명게시판인 경우--%>
								작성자<br>
																									<input type=text name=userNick size=10>
																								</c:if> <c:if test="${boardVO.anonYn == 'R' || boardVO.anonYn == 'P'}">
																									<%--실명인증 게시판인 경우--%>
								작성자<br>
																									<input type="text" name="userNick" size="10" readonly
																										value='<%=(session.getAttribute(Enview.getConfiguration().getString("session.realManNm.attr.name")) == null) ? "" : (String) session.getAttribute(Enview.getConfiguration().getString("session.realManNm.attr.name"))%>'>
																								</c:if></td>
																							<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
																							<td bgcolor="#F7F8F9" class="gab_3" id="memoReplyFileContainer_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">
																							<textarea name=memoCntt style="overflow: visible; height: 40; width: 100%">
																							</textarea>
																							<%--
																							<c:if test="${mVar.first}"><div id="vault_upload2"></div></c:if>
																							 --%>
																							</td>
																							<td width="113" bgcolor="#F0F3F5" class="gab_3"><a name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>"
																								onclick="ebRead.actionBulletin('rorm-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>');return false;" /> <c:out value="${boardVO.imgComment}" escapeXml="false" /> </a> <a
																								name="memoCancelBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>" onclick="ebRead.actionBulletin('cancel-memo','<c:out value="${list.bltnNo}"/>;<c:out value="${mList.memoSeq}"/>');return false;" /> <c:out
																									value="${boardVO.imgCommentX}" escapeXml="false" /> </a></td>
																						</tr>
																					</table>
																				</form>
																			</div>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</c:forEach>
												</table>
											</td>
										</tr>
									</c:if>
									<tr>
										<td height="5" colspan="4"></td>
									</tr>
									<%-- Write memo. --%>
									<c:if test="${boardVO.memoYn == 'Y' && boardVO.memoWritableYn == 'Y'}">
										<form name=memoForm_<c:out value="${list.bltnNo}"/>>
											<tr>
												<td height="2" colspan="4" bgcolor="#C8CBDB"></td>
											</tr>
											<tr>
												<td colspan=4>
													<table width=100%>
														<tr>
															<td width="100" height="25" align="center" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l"><c:if test="${boardVO.anonYn == 'N'}">
																	<%--익명게시판이 아닌 경우--%>
					작성자<br>
																	<input type=text name=userNick size=10 value='<c:out value="${secPmsnVO.userNick}"/>' readonly>
																</c:if> <c:if test="${boardVO.anonYn == 'Y'}">
																	<%--익명게시판인 경우--%>
					작성자<br>
																	<input type=text name=userNick size=10>
																</c:if> <c:if test="${boardVO.anonYn == 'R' || boardVO.anonYn == 'P'}">
																	<%--실명인증 게시판인 경우--%>
					작성자<br>
																	<input type="text" name="userNick" size="10" readonly
																		value='<%=(session.getAttribute(Enview.getConfiguration().getString("session.realManNm.attr.name")) == null) ? "" : (String) session.getAttribute(Enview.getConfiguration().getString("session.realManNm.attr.name"))%>'>
																</c:if></td>
															<td width="3" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/img_t_bar2.gif"></td>
															<td bgcolor="#F7F8F9" class="gab_3"><textarea name=memoCntt style="overflow: visible; height: 40; width: 100%"></textarea>
															<c:if test="${useMemoFile}">
																<div id="vault_upload"></div>
																<div id="vault_upload2"></div>
															</c:if>	
																</td>
															<td width="60" bgcolor="#F0F3F5" class="gab_3"><a name="memoBttn"
																<c:if test="${boardVO.memoWritableYn == 'Y'}">
					  <c:if test="${list.memoWritable || secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete}">
					    onclick="ebRead.actionBulletin('write-memo',<c:out value="${list.bltnNo}"/>);return false;"
					  </c:if>
																<c:if test="${!list.memoWritable && !(secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete)}">
					    onclick="alert('작성자가 댓글쓰기를 허용하지 않았습니다.');return false;"
					  </c:if>
									</c:if>
									<c:if test="${boardVO.memoWritableYn == 'N'}">
										<c:if test="${boardVO.anonYn == 'R' || boardVO.anonYn == 'P'}">
					    onclick="alert('댓글을 작성할 수 없습니다. 실명인증을 받으십시오.');return false;"
					  </c:if>
										<c:if test="${boardVO.anonYn != 'R' || boardVO.anonYn != 'P'}">
					    onclick="alert('댓글을 작성할 수 없습니다. 로그인 하십시오.');return false;"
					  </c:if>
									</c:if>
									/>
									<c:out value="${boardVO.imgComment}" escapeXml="false" />
									</a>
									</td>
									</tr>
								</table>
							</td>
						</tr>
						</form>
						<tr>
							<td height="2" colspan="4" bgcolor="#dbdee7"></td>
						</tr>
						</c:if>
						<tr>
							<td height="11" align="right" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_dot.gif"></td>
						</tr>
						<tr>
							<td align="left"><c:if test="${!empty list.nextBoardId && !empty list.nextBltnNo}">
									<strong><font color="blue">다음글</font></strong>
									<c:if test="${list.nextBoardId == 'del_flag_y'}">
				삭제된 글입니다.
			  </c:if>
									<c:if test="${list.nextBoardId != 'del_flag_y'}">
										<a style="cursor: pointer" onclick="ebRead.readPrevNextBltn('<c:out value="${list.nextBoardId}"/>','<c:out value="${list.nextBltnNo}"/>')"> <c:out value="${list.nextBltnOrgSubj}" escapeXml="false" />
										</a>
			    (<c:out value="${list.nextUserNick}" /> )
			    <!-- 등록일시 -->
										<c:out value="${list.nextRegDatimF}" />
										<%--
			    <!-- 등록일자 -->
			    <c:out value="${list.nextRegDatimSF}"/>
			    <!-- 수정일시 -->
			    <c:out value="${list.nextUpdDatimF}"/>
			    <!-- 수정일자 -->
			    <c:out value="${list.nextUpdDatimSF}"/>
			     --%>
										<br>
									</c:if>
								</c:if> <c:if test="${!empty list.prevBoardId && !empty list.prevBltnNo}">
									<strong><font color="blue">이전글</font></strong>&nbsp;&nbsp;&nbsp;
			  <c:if test="${list.prevBoardId == 'del_flag_y'}">
				삭제된 글입니다.
			  </c:if>
									<c:if test="${list.nextBoardId != 'del_flag_y'}">
										<a style="cursor: pointer" onclick="ebRead.readPrevNextBltn('<c:out value="${list.prevBoardId}"/>','<c:out value="${list.prevBltnNo}"/>')"> <c:out value="${list.prevBltnOrgSubj}" escapeXml="false" />
										</a>
			    ( <c:out value="${list.prevUserNick}" /> )
			    <!-- 등록일시 -->
										<c:out value="${list.prevRegDatimF}" />
										<%--
			    <!-- 등록일자 -->
			    <c:out value="${list.prevRegDatimSF}"/>
			    <!-- 수정일시 -->
			    <c:out value="${list.prevUpdDatimF}"/>
			    <!-- 수정일자 -->
			    <c:out value="${list.prevUpdDatimSF}"/>
			     --%>
									</c:if>
								</c:if></td>
						</tr>
						<c:if test="${boardVO.accSetYn == 'Y' && !empty list.bltnAuthList}">
							<tr>
								<td height="11" align="right" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_dot.gif"></td>
							</tr>
							<tr>
								<td align="left"><c:forEach items="${list.bltnAuthList}" var="bltnAuth">
										<c:out value="${bltnAuth.prinId}" />,<c:out value="${bltnAuth.prinType}" />,<c:out value="${bltnAuth.shortPath}" />,<c:out value="${bltnAuth.prinNm}" />
										<br>
			  =====목록조회:<c:out value="${bltnAuth.bltnList}" />,글읽기:<c:out value="${bltnAuth.bltnRead}" />,첨부파일다운로드:<c:out value="${bltnAuth.fileDown}" />,
			       답글쓰기:<c:out value="${bltnAuth.bltnReply}" />,댓글쓰기:<c:out value="${bltnAuth.memoWrite}" />,댓답글쓰기:<c:out value="${bltnAuth.memoReply}" />
										<br>
									</c:forEach></td>
							</tr>
						</c:if>
						<tr>
							<td height="11" align="right" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_dot.gif"></td>
						</tr>
						<tr>
							<td align="right"><c:if test="${!empty list.prevBoardId && !empty list.prevBltnNo}">
									<c:if test="${list.prevBoardId != 'del_flag_y'}">
										<a style="cursor: pointer" onclick="ebRead.readPrevNextBltn('<c:out value="${list.prevBoardId}"/>','<c:out value="${list.prevBltnNo}"/>')"> <c:out value="${boardVO.imgPrevBltn}" escapeXml="false" />
										</a>&nbsp;
			  </c:if>
								</c:if> <c:if test="${!empty list.nextBoardId && !empty list.nextBltnNo}">
									<c:if test="${list.nextBoardId != 'del_flag_y'}">
										<a style="cursor: pointer" onclick="ebRead.readPrevNextBltn('<c:out value="${list.nextBoardId}"/>','<c:out value="${list.nextBltnNo}"/>')"> <c:out value="${boardVO.imgNextBltn}" escapeXml="false" />
										</a>&nbsp;
			  </c:if>
								</c:if> <c:if test="${boardSttVO.cmd == 'SEARCH'}">
									<a style="cursor: pointer" onclick="ebRead.actionBulletin('search',-1)"> <c:out value="${boardVO.imgSearch}" escapeXml="false" />
									</a>&nbsp;
            </c:if> <a style="cursor: pointer" onclick="ebRead.actionBulletin('list',-1)"> <c:out value="${boardVO.imgList}" escapeXml="false" />
							</a>&nbsp; <c:if test="${boardVO.writableYn == 'Y'}">
									<%--글쓰기 권한이 있는 경우--%>
									<a style="cursor: pointer" onclick="ebRead.actionBulletin('write',-1)"> <c:out value="${boardVO.imgWrite}" escapeXml="false" />
									</a>&nbsp;
            </c:if> <c:if test="${boardVO.writableYn == 'N' && (boardVO.anonYn == 'R' || boardVO.anonYn == 'P')}">
									<%--글쓰기 권한이 없으나 실명인증 게시판인 경우--%>
									<a style="cursor: pointer" onclick="ebRead.actionBulletin('write',-1)"> <c:out value="${boardVO.imgWrite}" escapeXml="false" />
									</a>&nbsp;
            </c:if> <c:if test="${boardVO.replyableYn == 'Y' && boardVO.replyYn == 'Y'}">
									<%--답글쓰기 권한이 있는 경우--%>
									<c:if test="${list.replyable || secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete}">
										<a style="cursor: pointer" onclick="ebRead.actionBulletin('reply',<c:out value="${list.bltnNo}"/>)"> <c:out value="${boardVO.imgReply}" escapeXml="false" />
										</a>&nbsp;
			  </c:if>
									<c:if test="${!list.replyable && !(secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete)}">
										<a style="cursor: pointer" onclick="alert('작성자가 답글쓰기를 허용하지 않았습니다.')"> <c:out value="${boardVO.imgReply}" escapeXml="false" />
										</a>&nbsp;
			  </c:if>
								</c:if> <c:if test="${boardVO.replyableYn == 'N' && boardVO.replyYn == 'Y' && (boardVO.anonYn == 'R' || boardVO.anonYn == 'P')}">
									<%--답글쓰기 권한이 없으나 실명인증 게시판인 경우--%>
									<a style="cursor: pointer" onclick="ebRead.actionBulletin('reply',<c:out value="${list.bltnNo}"/>)"> <c:out value="${boardVO.imgReply}" escapeXml="false" />
									</a>&nbsp;
            </c:if> <c:if test="${boardVO.anonYn == 'N'}">
									<%--'익명/실명인증 게시판'이 아니면--%>
									<c:if test="${list.editable == 'true'}">
										<%--수정권한이 있는 경우--%>
										<a style="cursor: pointer" onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true)"> <c:out value="${boardVO.imgModify}" escapeXml="false" />
										</a>&nbsp;
              </c:if>
									<c:if test="${list.editable == 'false'}">
										<%--수정권한이 없는 경우--%>
										<c:if test="${empty list.userId}">
											<%--익명글이면--%>
											<c:if test="${list.editableUserId == '_is_admin_'}">
												<%--관리자인 경우--%>
												<a style="cursor: pointer" onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true)"> <c:out value="${boardVO.imgModify}" escapeXml="false" />
												</a>&nbsp;
                  </c:if>
											<c:if test="${list.editableUserId != '_is_admin_'}">
												<%--관리자가 아닌 경우--%>
												<c:if test="${boardVO.writableYn == 'Y'}">
													<a style="cursor: pointer" onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,false)"> <c:out value="${boardVO.imgModify}" escapeXml="false" />
													</a>&nbsp;
					</c:if>
											</c:if>
										</c:if>
									</c:if>
									<c:if test="${list.deletable == 'true'}">
										<%--삭제권한이 있는 경우--%>
										<a style="cursor: pointer" onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true)"> <c:out value="${boardVO.imgDelete}" escapeXml="false" />
										</a>&nbsp;
              </c:if>
									<c:if test="${list.deletable == 'false'}">
										<%--삭제권한이 없는 경우--%>
										<c:if test="${empty list.userId}">
											<%--익명글이면--%>
											<c:if test="${list.deletableUserId == '_is_admin_'}">
												<%--관리자인 경우--%>
												<a style="cursor: pointer" onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true)"> <c:out value="${boardVO.imgDelete}" escapeXml="false" />
												</a>&nbsp;
                  </c:if>
											<c:if test="${list.deletableUserId != '_is_admin_'}">
												<%--관리자가 아닌 경우--%>
												<c:if test="${boardVO.writableYn == 'Y'}">
													<a style="cursor: pointer" onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,false)"> <c:out value="${boardVO.imgDelete}" escapeXml="false" />
													</a>&nbsp;
					</c:if>
											</c:if>
										</c:if>
									</c:if>
									<c:if test="${secPmsnVO.isAdmin == 'true'}">
										<img title="게시물 신고하기" align="absMiddle" style="cursor: pointer;" onclick="ebRead.showBadBltnForm('true','<c:out value="${boardVO.boardId}"/>','<c:out value="${list.bltnNo}"/>')" src="/board/images/board/skin/enboard/i_bad.gif" />
									</c:if>
								</c:if> <c:if test="${boardVO.anonYn != 'N'}">
									<%--'익명/실명인증 게시판'인 경우--%>
									<c:if test="${list.editableUserId == '_is_admin_'}">
										<%--관리자인 경우--%>
										<a style="cursor: pointer" onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,true)"> <c:out value="${boardVO.imgModify}" escapeXml="false" />
										</a>&nbsp;
			  </c:if>
									<c:if test="${list.editableUserId != '_is_admin_'}">
										<%--관리자가 아닌 경우--%>
										<a style="cursor: pointer" onclick="ebRead.actionSecurity('modify',<c:out value="${list.bltnNo}"/>,false)"> <c:out value="${boardVO.imgModify}" escapeXml="false" />
										</a>&nbsp;
			  </c:if>
									<c:if test="${list.deletableUserId == '_is_admin_'}">
										<%--관리자인 경우--%>
										<a style="cursor: pointer" onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,true)"> <c:out value="${boardVO.imgDelete}" escapeXml="false" />
										</a>&nbsp;
			  </c:if>
									<c:if test="${list.deletableUserId != '_is_admin_'}">
										<%--관리자가 아닌 경우--%>
										<a style="cursor: pointer" onclick="ebRead.actionSecurity('delete',<c:out value="${list.bltnNo}"/>,false)"> <c:out value="${boardVO.imgDelete}" escapeXml="false" />
										</a>&nbsp;
			  </c:if>
								</c:if> <%-- select best reply --%> <c:if test="${boardVO.boardType == 'C'}">
									<c:if test="${list.bltnGq != '0'}">
										<c:if test="${secPmsnVO.isLogin == 'true'}">
											<%--점수를 건 원문 게시자와 관리자에게 어떤 레벨의 답변글을 선정할 권한을 줄 것인지를 여기서 결정해준다.--%>
											<c:if test="${secPmsnVO.isAdmin == 'true'}">
												<a style="cursor: pointer" onclick="ebRead.actionBulletin('best',<c:out value="${list.bltnNo}"/>, '9')"><c:out value="${boardVO.imgBestAn9}" escapeXml="false" /></a> &nbsp;
                  </c:if>
											<c:if test="${secPmsnVO.isAdmin == 'false'}">
												<c:if test="${list.userId != secPmsnVO.loginId}">
													<c:if test="${list.bestableUserId == secPmsnVO.loginId}">
														<a style="cursor: pointer" onclick="ebRead.actionBulletin('best',<c:out value="${list.bltnNo}"/>, '9')"><c:out value="${boardVO.imgBestAn9}" escapeXml="false" /></a> &nbsp;
                      </c:if>
												</c:if>
											</c:if>
										</c:if>
									</c:if>
								</c:if></td>
						</tr>
						<tr>
							<td height="11" align="right" background="${pageContext.request.contextPath}/board/images/board/skin/enboard/bg_dot.gif"></td>
						</tr>
					</table>
		</td>
	</tr>
	<%-- Reply Bulletin List --%>
	<c:if test="${boardVO.readReplyCnttYn == 'Y'}">
		<tr>
			<td align="center">
				<div class="board">
					<table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="1" bgcolor="#E0E0E0" cellpadding="0">
						<c:if test="${empty list.replyList}">
							<tr>
								<td align="center" colspan=20>등록된 답변이 존재하지 않습니다.</td>
							</tr>
						</c:if>

						<c:set var="replyBltn" value="${list.replyList}" />
						<%--jsp:useBean id="replyBltn" type="java.util.List"/--%>
						<c:if test="${!empty replyBltn}">
							<c:forEach items="${replyBltn}" var="rbList">
								<c:if test="${rbList.bltnGq != '0'}">
									<tr>
										<td>
											<table width=100% border=0 bgcolor='#FFFFFF' onMouseOver=this.style.backgroundColor= '#F5F5F5'; onMouseOut=this.style.backgroundColor= '#FFFFFF'; cellspacing=0 cellpadding=0>
												<tr height=22>
													<td width=20 align=center><c:if test="${rbList.bltnBestLevel == '9'}">
															<c:out value="${boardVO.imgBest9}" escapeXml="false" />
														</c:if> <c:if test="${rbList.bltnBestLevel == '8'}">
															<c:out value="${boardVO.imgBest8}" escapeXml="false" />
														</c:if> <c:if test="${rbList.bltnBestLevel == '7'}">
															<c:out value="${boardVO.imgBest7}" escapeXml="false" />
														</c:if></td>
													<td width=60 align=center><c:if test="${boardVO.cateYn == 'Y'}">
															<c:out value="${rbList.cateNm}" escapeXml="false" />
														</c:if></td>
													<td align=left><c:if test="${rbList.bltnIcon == 'A'}">
															<c:if test="${rbList.bltnPermitYn == 'Y'}">
																<c:out value="${boardVO.imgDoc}" escapeXml="false" />
															</c:if>
															<c:if test="${rbList.bltnPermitYn == 'N'}">
																<c:out value="${boardVO.imgProhibit}" escapeXml="false" />
															</c:if>
														</c:if> <c:if test="${rbList.bltnIcon == 'B'}">
															<c:out value="${boardVO.imgFile}" escapeXml="false" />
														</c:if> <c:if test="${rbList.bltnIcon == 'C'}">
															<c:out value="${boardVO.imgPoll}" escapeXml="false" />
														</c:if> <c:if test="${rbList.bltnIcon == 'D'}">
															<c:out value="${boardVO.imgSecret}" escapeXml="false" />
														</c:if> <c:if test="${rbList.bltnLev != '1'}">
															<span style="visibility: hidden"><img src='' height=1 width=<c:out value="${rbList.bltnLevLen}"/>></span>
															<c:out value="${boardVO.imgRe}" escapeXml="false" />
														</c:if> <c:if test="${rbList.betPnt > '0'}">
															<font color=#A51818>$<c:out value="${rbList.betPnt}" /></font>
														</c:if> <font onclick="ebList.readBulletin('<c:out value="${rbList.boardId}"/>','<c:out value="${rbList.bltnNo}"/>')" style="cursor: pointer" OnMouseOver=this.style.textDecoration= 'underline' OnMouseOut=this.style.textDecoration='none'>
															<c:out value="${rbList.bltnOrgSubj}" escapeXml="false" />
													</font> <c:if test="${rbList.bltnMemoCnt != '0'}">
															<font color="#CC4848">(<c:out value="${rbList.bltnMemoCnt}" />)
															</font>
														</c:if> <c:if test="${rbList.recentBltn == 'Y'}">
															<c:out value="${boardVO.imgNew}" escapeXml="false" />
														</c:if></td>
													<td width=80><c:if test="${boardVO.anonYn == 'N'}">
															<c:out value="${rbList.userNick}" />
														</c:if></td>
													<td width=110 align=center><c:out value="${rbList.regDatimSF}" /></td>
													<td width=40 align=right><c:out value="${rbList.bltnReadCnt}" />&nbsp;</td>
													<%-- select best reply --%>
													<c:if test="boardVO.boardType == 'C'}">
														<c:if test="${rbList.bltnGq != '0'}">
															<c:if test="secPmsnVO.isLogin == 'true'}">
																<%--점수를 건 원문 게시자와 관리자에게 어떤 레벨의 답변글을 선정할 권한을 줄 것인지를 여기서 결정해준다.--%>
																<c:if test="${secPmsnVO.isAdmin == 'true'}">
																	<td width=228 align=right><a style="cursor: pointer" onclick="ebRead.actionBulletin('best',<c:out value="${rbList.bltnNo}"/>, '8')"><c:out value="${boardVO.imgBestAn8}" escapeXml="false" /></a> &nbsp; <a style="cursor: pointer"
																		onclick="ebRead.actionBulletin('best',<c:out value="${rbList.bltnNo}"/>, '7')"><c:out value="${boardVO.imgBestAn7}" escapeXml="false" /></a> &nbsp;</td>
																</c:if>
																<c:if test="${secPmsnVO.isAdmin == 'false'}">
																	<c:if test="${rbList.userId != secPmsnVO.loginId}">
																		<c:if test="${rbList.bestableUserId == secPmsnVO.loginId}">
																			<td width=228 align=right><a style="cursor: pointer" onclick="ebRead.actionBulletin('best',<c:out value="${rbList.bltnNo}"/>, '8')"><c:out value="${boardVO.imgBestAn8}" escapeXml="false" /></a> &nbsp; <a
																				style="cursor: pointer" onclick="ebRead.actionBulletin('best',<c:out value="${rbList.bltnNo}"/>, '7')"><c:out value="${boardVO.imgBestAn7}" escapeXml="false" /></a> &nbsp;</td>
																		</c:if>
																	</c:if>
																</c:if>
															</c:if>
														</c:if>
													</c:if>
												</tr>
												<tr>
													<td colspan=7 height=1 bgcolor='#E0E0E0' style='padding: 0 20 0 20;'></td>
												</tr>
												<tr>
													<td colspan=7 height="150" colspan="15" valign="top" class="content_text"><c:out value="${rbList.bltnOrgCntt}" escapeXml="false" /></td>
												</tr>
											</table>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</table>
				</div>
			</td>
		</tr>
	</c:if>
</table>
</c:forEach>
</div>
</td>
</tr>
</table>

<br style="line-height: 5px;" />
<%-- Bulletin List  --%>
<c:if test="${!empty bltnList && boardVO.readListYn == 'Y'}">
	<table width=100% border=0 cellspacing=0 cellpadding=0>
		<%@ include file="list.jsp"%>
	</table>
</c:if>
