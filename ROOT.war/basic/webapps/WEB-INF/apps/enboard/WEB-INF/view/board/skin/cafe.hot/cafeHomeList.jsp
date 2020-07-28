<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.saltware.enboard.vo.BulletinVO"%>

<% int subjLen = 0, cnttLen = 0;%>
<c:set var="frameType"  value="${param.frameType}"/>
<c:set var="brdGrpType" value="${param.brdGrpType}"/>
<c:set var="brdType"    value="${param.brdType}"/>
<c:if test="${brdGrpType == 'FLT10' || brdGrpType == 'FLT20'}">
  <c:if test="${frameType == 'ONE' || frameType == 'TWO1' || frameType == 'TWO2'}">
	<% subjLen = 80;%>
  </c:if>
<c:if test="${frameType == 'THREE1' || frameType == 'THREE2' || frameType == 'THREE3' || frameType == 'THREE4'}">
	<% subjLen = 56;%>
  </c:if>
</c:if> 
<c:if test="${brdGrpType != 'FLT10' && brdGrpType != 'FLT20'}">
  <c:if test="${frameType == 'ONE' || frameType == 'TWO1' || frameType == 'TWO2'}">
	<% subjLen = 35;%>
  </c:if>
<c:if test="${frameType == 'THREE1' || frameType == 'THREE2' || frameType == 'THREE3' || frameType == 'THREE4'}">
	<% subjLen = 28;%>
  </c:if>
</c:if> 
<c:if test="${brdType == 'LIST'}">
	<c:if test="${brdGrpType == 'FLT20' || brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
		<c:set var="colCnt" value="1"/>
		<c:set var="rowCnt" value="10"/>
	</c:if>
	<c:if test="${brdGrpType != 'FLT20' && brdGrpType != 'MLT20' && brdGrpType != 'MRT20'}">
		<c:set var="colCnt" value="1"/>
		<c:set var="rowCnt" value="5"/>
	</c:if>
</c:if>
<c:if test="${brdType == 'SUM1'}">
	<c:if test="${brdGrpType == 'FLT20' || brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
		<c:set var="colCnt" value="1"/>
		<c:set var="rowCnt" value="4"/>
	</c:if>
	<c:if test="${brdGrpType != 'FLT20' && brdGrpType != 'MLT20' && brdGrpType != 'MRT20'}">
		<c:set var="colCnt" value="1"/>
		<c:set var="rowCnt" value="2"/>
	</c:if>
</c:if>
<c:if test="${brdType == 'SUM2'}">
	<c:if test="${brdGrpType == 'FLT10' || brdGrpType == 'FLT20'}">
		<c:set var="colCnt" value="4"/>
		<c:set var="rowCnt" value="1"/>
	</c:if>
	<c:if test="${ brdGrpType == 'MLT10' || brdGrpType == 'MRT10' || brdGrpType == 'MLB10' || brdGrpType == 'MRB10'}">
		<c:set var="colCnt" value="2"/>
		<c:set var="rowCnt" value="1"/>
	</c:if>
	<c:if test="${ brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
		<c:set var="colCnt" value="2"/>
		<c:set var="rowCnt" value="2"/>
	</c:if>
</c:if>
<c:if test="${brdType == 'SUM3'}">
	<c:if test="${brdGrpType == 'FLT20'}">
		<c:set var="colCnt" value="4"/>
		<c:set var="rowCnt" value="3"/>
	</c:if>
	<c:if test="${brdGrpType == 'FLT10'}">
		<c:set var="colCnt" value="4"/>
		<c:set var="rowCnt" value="2"/>
	</c:if>	
</c:if>
<c:if test="${brdType == 'SUM4'}">
	<c:if test="${brdGrpType == 'FLT20' || brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
		<c:set var="colCnt" value="2"/>
		<c:set var="rowCnt" value="2"/>
	</c:if>
	<c:if test="${brdGrpType != 'FLT20' && brdGrpType != 'MLT20' && brdGrpType != 'MRT20'}">
		<c:set var="colCnt" value="2"/>
		<c:set var="rowCnt" value="1"/>
	</c:if>
</c:if>
<c:set var="totalSize" value="${colCnt * rowCnt}"/>
<c:set var="lastSize" value="${colCnt * rowCnt}"/>
<c:set var="emptyCol" value="${colCnt}"/>
<c:set var="emptyRow" value="${rowCnt}"/>
<c:set var="lastCol" value="${colCnt / rowCnt}"/>
<div class="boardNameBorder CF0501_nmBrdrStyle CF0501_nmBrdrWidth CF0501_nmBrdrColor">			
	<div class="title">
		<a class="boardName CF0501_nmFontColor CF0501_nmFontNm" href="javascript:cfCntt.readBulletin('<c:out value="${boardVO.boardId}"/>');"><c:out value="${boardVO.boardNm}"/></a>
	</div>
	<div class="more">
		<a class="more_view" onclick="cfCntt.readBulletin('<c:out value="${boardVO.boardId}"/>')">
			<util:message key="ev.prop.more"/>+
		</a>
	</div>
</div>
<div class="boardList">
	<c:if test="${brdType == 'LIST'}">
	<table class="listTable"> 
		<!-- Bulletins are not exist.. -->
		<c:if test="${empty bltnList}">
			<tr class="listTr CF0802_extraBrdrColor">
				<td class="listTd">작성된 글이 없습니다</td>
			</tr>
			<c:forEach begin="2" end="${rowCnt}" varStatus="status">	
			<tr class="listTr CF0802_extraBrdrColor<c:if test="${status.last}"> last</c:if>">
				<td></td>
			</tr>					
			</c:forEach>
		</c:if>
		<!-- List of Bulletin -->
		<c:if test="${!empty bltnList}">				
			<c:set var="emptyRow" value="0"/>
			<c:forEach items="${bltnList}" var="list" begin="0" end="${rowCnt-1}" varStatus="status">						
				<tr class="listTr CF0802_extraBrdrColor<c:if test="${status.last && status.index == rowCnt-1}"> last</c:if>">
					<td class="listTd CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm">
						<c:if test="${list.bltnLev != '1'}">
							<span style=visibility:hidden><img height=1 width=<c:out value="${list.bltnLevLen}"/>/></span>
							<img align="middle" src="<%=request.getContextPath()%>/board/images/board/skin/cafe.hot/imgRe.gif"/>
						</c:if>
						<c:if test="${boardVO.ttlPntYn == 'Y'}">
							<c:if test="${list.betPnt > '0'}"><font color=#A51818>$<c:out value="${list.betPnt}"/></font></c:if>
						</c:if>
						<strong>ㆍ</strong>
						<a class="bulLink" onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
						<c:out value="${list.bltnSubj}"/>									
						</a>
						<c:if test="${boardVO.ttlMemoYn == 'Y'}">
							<c:if test="${list.bltnMemoCnt != '0'}">
								<font class="CF0501_rplFontColor">[<c:out value="${list.bltnMemoCnt}"/>]</font>
							</c:if>
						</c:if>
						<c:if test="${!empty list.fileList}">
							<img src="<%=request.getContextPath()%>/cola/cafe/images/each/encafe/cntt/icon_file.png"/>
						</c:if>
						<c:if test="${boardVO.ttlNewYn == 'Y'}">
							<c:if test="${list.recentBltn == 'Y'}"><img align="middle" src="<%=request.getContextPath()%>/board/images/board/skin/cafe.hot/imgNew.gif"/></c:if>
						</c:if>          
					</td>
					<td class="listTd_UserNick CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm">
						<c:out value="${list.userNick}"/>
					</td>
					<c:if test="${brdGrpType == 'FLT10' || brdGrpType == 'FLT20'}">
					<td class="listTd_regDatim CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm">
						<c:out value="${list.regDatimSSF}"/>
					</td>
					<td class="listTd_bltnReadCnt CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm">
						<c:if test="${list.bltnReadCnt >= boardVO.raiseCnt}"><b><font color=<c:out value="${boardVO.raiseColor}"/>></c:if>
						<c:out value="${list.bltnReadCnt}"/>&nbsp;
						<c:if test="${list.bltnReadCnt >= boardVO.raiseCnt}"></b></font></c:if>
					</td>
					</c:if>
				</tr>
				<c:if test="${status.last }">
					<c:set var="emptyRow" value="${rowCnt - status.count - 1}"/>
				</c:if>
			</c:forEach>
			<c:if test="${emptyRow > 0 }">
				<c:forEach begin="0" end="${emptyRow}" varStatus="status">
					<tr class="listTr CF0802_extraBrdrColor<c:if test="${status.last}"> last</c:if>">
						<td colspan="4"></td>
					</tr>
				</c:forEach>
			</c:if>
		</c:if>			
	</table>
	</c:if>
	<c:if test="${brdType == 'SUM1'}">					
	<ul class="SUM1">
		<c:forEach items="${bltnList}" var="list" begin="0" end="${totalSize-1}" varStatus="status">
		<li class="sum1_line CF0802_extraBrdrColor<c:if test="${status.count%rowCnt == 0}"> last</c:if>">
			<dl class="sum1_data">
				<c:if test="${list != null}">
					<c:if test="${!empty list.fileMask}">
					<dt>
						<a onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<img id="<c:out value="${list.fileMask}"/>" class="img1_img" src="<%=request.getContextPath()%><c:out value="${list.thumbImgSrc100}"/>" onerror="src='<%=request.getContextPath()%>/upload/board/thumb/no.gif'"/>
						</a>
					</dt>
					</c:if>
					<dd>
						<a class="sum1_bulLink CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm"
						onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<c:out value="${list.bltnSubj}"/>
						</a>
						<c:if test="${boardVO.ttlNewYn == 'Y'}">
							<c:if test="${list.recentBltn == 'Y'}"><img align="middle" src="<%=request.getContextPath()%>/board/images/board/skin/cafe.hot/imgNew.gif"/></c:if>
						</c:if>
						<br/>
						<span class="sum1_userNick"><c:out value="${list.regDatimSF}"/>&nbsp;&nbsp;&nbsp;<c:out value="${list.userNick}"/></span>
						<br/>
						<p class="sum1_cntt" style="word-wrap:break-word;word-break:break-all">
							<% String bltnCnttEllipsis = ((BulletinVO)pageContext.getAttribute("list")).getBltnCnttEllipsis(80);%>
							<%=bltnCnttEllipsis%>
						</p>
					</dd>
				</c:if>
				<c:if test="${list == null}">
					<div class="img_blank_thumb CF0802_extraBrdrColor CF0802_bgColor"></div>
				</c:if>
			</dl>
		</li>						
		<c:if test="${status.last}">
			<c:set var="emptyRow" value="${totalSize - status.count }"/>
		</c:if>
		</c:forEach>
		<c:if test="${emptyRow > 0}">
			<c:forEach begin="0" end="${emptyRow-1}" varStatus="status">		
			<li class="sum1_line CF0802_extraBrdrColor<c:if test="${(emptyRow - status.count + rowCnt ) % rowCnt == 0 }"> last</c:if> emptyRow_<c:out value="${emptyRow}"/>">
				<dl class="sum1_data"><dd><div class="img_blank_thumb CF0802_extraBrdrColor CF0802_bgColor"></div></dd></dl>
			</li>
			</c:forEach>
		</c:if>
	</ul>
	</c:if>
	<c:if test="${brdType == 'SUM2'}">
	<ul class="SUM2">
		<c:forEach items="${bltnList}" var="list" begin="0" end="${totalSize-1}" varStatus="status">
		<li class="sum2_col CF0802_extraBrdrColor<c:if test="${status.count%colCnt == 0}"> last</c:if>">
			<dl class="sum2_data">
				<c:if test="${list != null}">
					<c:if test="${!empty list.fileMask}">
					<dt>
						<a onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<img id="<c:out value="${list.fileMask}"/>" class="img2_img" src="<%=request.getContextPath()%><c:out value="${list.thumbImgSrc150}"/>" onerror="src='<%=request.getContextPath()%>/upload/board/thumb/no.gif'"/>
						</a>
					</dt>
					</c:if>
					<dd>
						<a class="sum2_bulLink CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm"
						onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<c:out value="${list.bltnSubj}"/>
						</a>
						<c:if test="${boardVO.ttlNewYn == 'Y'}">
							<c:if test="${list.recentBltn == 'Y'}"><img align="middle" src="<%=request.getContextPath()%>/board/images/board/skin/cafe.hot/imgNew.gif"/></c:if>
						</c:if>
						<br/>
						<span class="sum2_userNick"><c:out value="${list.regDatimSF}"/>&nbsp;&nbsp;&nbsp;<c:out value="${list.userNick}"/></span>
						<br/>
						<p class="sum2_cntt" style="word-wrap:break-word;word-break:break-all">
							<% String bltnCnttEllipsis = ((BulletinVO)pageContext.getAttribute("list")).getBltnCnttEllipsis(80);%>
							<%=bltnCnttEllipsis%>
						</p>
					</dd>
				</c:if>
				<c:if test="${list == null}">
					<div class="img3_blank_thumb CF0802_extraBrdrColor CF0802_bgColor"></div>
				</c:if>
			</dl>
		</li>
		<c:if test="${status.last}">
			<c:set var="emptyCol" value="${totalSize - status.count }"/>
		</c:if>
		</c:forEach>
		<c:if test="${emptyCol > 0}">
			<c:forEach begin="0" end="${emptyCol-1}" varStatus="status">		
				<li class="sum2_col CF0802_extraBrdrColor<c:if test="${(emptyCol - status.count + lastCol ) % lastCol == 0 }"> last</c:if> emptyCol_<c:out value="${emptyCol}"/>">
					<dl class="sum2_data"><dd><div class="img3_blank_thumb CF0802_extraBrdrColor CF0802_bgColor"></div></dd></dl>
				</li>
			</c:forEach>
		</c:if>
	</ul>
	</c:if>
	<c:if test="${brdType == 'SUM3'}">
	<ul class="SUM3">
		<c:forEach items="${bltnList}" var="list" end="${totalSize-3}" varStatus="status">
		<c:if test="${status.count <= colCnt * (rowCnt-1)}">
			<li class="sum3_col CF0802_extraBrdrColor<c:if test="${status.count > 4}"> line</c:if>">
				<dl class="sum3_data">
					<c:if test="${!empty list.fileMask}">
					<dt>
						<a onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<img id="<c:out value="${list.fileMask}"/>" class="img3_img" src="<%=request.getContextPath()%><c:out value="${list.thumbImgSrc150}"/>" onerror="src='<%=request.getContextPath()%>/upload/board/thumb/no.gif'"/>
						</a>
					</dt>
					</c:if>
					<dd>
						<a class="sum3_bulLink CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm"
						onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<c:out value="${list.bltnSubj}"/>
						</a>
						<c:if test="${boardVO.ttlNewYn == 'Y'}">
							<c:if test="${list.recentBltn == 'Y'}"><img align="middle" src="<%=request.getContextPath()%>/board/images/board/skin/cafe.hot/imgNew.gif"/></c:if>
						</c:if>
						<br/>
						<span class="sum3_userNick"><c:out value="${list.regDatimSF}"/>&nbsp;&nbsp;&nbsp;<c:out value="${list.userNick}"/></span>
						<br/>
						<p class="sum3_cntt" style="word-wrap:break-word;word-break:break-all">
							<% String bltnCnttEllipsis = ((BulletinVO)pageContext.getAttribute("list")).getBltnCnttEllipsis(80);%>
							<%=bltnCnttEllipsis%>
						</p>
					</dd>
				</dl>
			</li>
		</c:if>
		<c:if test="${status.count > colCnt * (rowCnt-1)}">
			<li class="sum3_col2 line CF0802_extraBrdrColor">
				<dl class="sum3_data2">
					<c:if test="${!empty list.fileMask}">
					<dt>
						<a onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<img id="<c:out value="${list.fileMask}"/>" class="img3_img" src="<%=request.getContextPath()%><c:out value="${list.thumbImgSrc100}"/>" onerror="src='<%=request.getContextPath()%>/upload/board/thumb/no.gif'"/>
						</a>
					</dt>
					</c:if>
					<dd>
						<a class="sum3_bulLink2 CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm"
						onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<c:out value="${list.bltnSubj}"/>
						</a>
						<c:if test="${boardVO.ttlNewYn == 'Y'}">
							<c:if test="${list.recentBltn == 'Y'}"><img align="middle" src="<%=request.getContextPath()%>/board/images/board/skin/cafe.hot/imgNew.gif"/></c:if>
						</c:if>
						<br/>
						<span class="sum3_userNick2"><c:out value="${list.regDatimSF}"/>&nbsp;&nbsp;&nbsp;<c:out value="${list.userNick}"/></span>
						<br/>
						<p class="sum3_cntt2" style="word-wrap:break-word;word-break:break-all">
							<% String bltnCnttEllipsis = ((BulletinVO)pageContext.getAttribute("list")).getBltnCnttEllipsis(80);%>
							<%=bltnCnttEllipsis%>
						</p>
					</dd>
				</dl>
			</li>
		</c:if>
		<c:if test="${status.last}">
			<c:set var="lastSize" value="${totalSize - status.count }"/>
		</c:if>
		</c:forEach>
		<c:if test="${lastSize > 2}">
			<c:forEach begin="0" end="${lastSize-3}" varStatus="status">
				<li class="sum3_col CF0802_extraBrdrColor<c:if test="${status.count >= lastSize-3}">2</c:if><c:if test="${ totalSize - lastSize + status.count > 4 }"> line</c:if>">
					<dl class="sum3_data<c:if test="${status.count > lastSize-4}">2</c:if>"><dt></dt></dl>
				</li>
			</c:forEach>
		</c:if>
		</ul>
	</c:if>
	<c:if test="${brdType == 'SUM4'}">
	<ul class="SUM4">
		<c:forEach items="${bltnList}" var="list" end="${totalSize-1}" varStatus="status">
		<li class="sum4_col CF0802_extraBrdrColor<c:if test="${status.count > colCnt }"> line</c:if>">
			<dl class="sum4_data">
				<c:if test="${!empty list.fileMask}">
				<dt>
					<a onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
						<img id="<c:out value="${list.fileMask}"/>" class="img4_img" src="<%=request.getContextPath()%><c:out value="${list.thumbImgSrc150}"/>" onerror="src='<%=request.getContextPath()%>/upload/board/thumb/no.gif'"/>
					</a>
				</dt>
				</c:if>
				<dd>
					<a class="sum4_bulLink CF0501_subjFontColor CF0501_subjFontNm"
					onclick="cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
						<c:out value="${list.bltnSubj}"/>
					</a>
					<c:if test="${boardVO.ttlNewYn == 'Y'}">
						<c:if test="${list.recentBltn == 'Y'}"><img align="middle" src="<%=request.getContextPath()%>/board/images/board/skin/cafe.hot/imgNew.gif"/></c:if>
					</c:if>
					<br/>
					<span class="sum4_userNick"><c:out value="${list.regDatimSF}"/>&nbsp;&nbsp;&nbsp;<c:out value="${list.userNick}"/></span>
					<br/>
					<p class="sum4_cntt" style="word-wrap:break-word;word-break:break-all">
						<% String bltnCnttEllipsis = ((BulletinVO)pageContext.getAttribute("list")).getBltnCnttEllipsis(80);%>
						<%=bltnCnttEllipsis%>
					</p>
				</dd>
			</dl>
		</li>
		<c:if test="${status.last}">
			<c:set var="emptyCol" value="${totalSize - status.count }"/>
		</c:if>
		</c:forEach>
		<c:if test="${emptyCol > 0}">
			<c:forEach begin="0" end="${emptyCol-1}" varStatus="status">		
				<li class="sum4_col CF0802_extraBrdrColor<c:if test="${(emptyCol - status.count + lastCol ) % lastCol == 0 }"> last</c:if> emptyCol_<c:out value="${emptyCol}"/>">
					<dl class="sum4_data"><dd><div class="img3_blank_thumb CF0802_extraBrdrColor CF0802_bgColor"></div></dd></dl>
				</li>
			</c:forEach>
		</c:if>
	</ul>
	</c:if>
</div>