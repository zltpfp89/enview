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
			<c:set var="rowCnt" value="9"/>
		</c:if>
		<c:if test="${brdGrpType != 'FLT20' && brdGrpType != 'MLT20' && brdGrpType != 'MRT20'}">
			<c:set var="rowCnt" value="6"/>
		</c:if>
	</c:if>
	<c:if test="${brdType == 'SUM1'}">
		<c:if test="${brdGrpType == 'FLT20' || brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
			<c:set var="rowCnt" value="3"/>
		</c:if>
		<c:if test="${brdGrpType != 'FLT20' && brdGrpType != 'MLT20' && brdGrpType != 'MRT20'}">
			<c:set var="rowCnt" value="1"/>
		</c:if>
	</c:if>
	<c:if test="${brdType == 'SUM2'}">
		<c:if test="${brdGrpType == 'FLT20'}">
			<c:set var="rowCnt" value="7"/>
		</c:if>
		<c:if test="${brdGrpType == 'FLT10' || brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
			<c:set var="rowCnt" value="3"/>
		</c:if>
		<c:if test="${brdGrpType == 'MLT10' || brdGrpType == 'MLB10' || brdGrpType == 'MRT10' || brdGrpType == 'MRB10'}">
			<c:set var="rowCnt" value="1"/>
		</c:if>
	</c:if>
	<c:if test="${brdType == 'SUM3'}">
		<c:if test="${brdGrpType == 'FLT20'}">
			<c:set var="rowCnt" value="5"/>
		</c:if>
		<c:if test="${brdGrpType == 'FLT10'}">
			<c:set var="rowCnt" value="3"/>
		</c:if>
		<c:if test="${brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
			<c:set var="rowCnt" value="3"/>
		</c:if>
		<c:if test="${brdGrpType == 'MLT10' || brdGrpType == 'MRT10' || brdGrpType == 'MLB10' || brdGrpType == 'MRB10'}">
			<c:set var="rowCnt" value="1"/>
		</c:if>
	</c:if>
	<c:if test="${brdType == 'SUM4'}">
		<c:if test="${brdGrpType == 'FLT20' || brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
			<c:set var="rowCnt" value="3"/>
		</c:if>
		<c:if test="${brdGrpType != 'FLT20' && brdGrpType != 'MLT20' && brdGrpType != 'MRT20'}">
			<c:set var="rowCnt" value="1"/>
		</c:if>
	</c:if>
	<div class="title_box">
		<a class="boardName CF0501_nmFontColor CF0501_nmFontNm" href="<%= request.getContextPath()%>/board/list.brd?boardId=<c:out value="${boardVO.boardId}"/>&listOpt=selectMenu"><c:out value="${boardVO.boardNm}"/></a>
		<span class="boardPipe">|</span>
		<span class="boardDesc"><c:out value="${boardVO.boardTtl}"/></span>
	</div>
	<div class="boardList CF0802_extraBrdrColor" style="padding-top: 0px;">
		<table class="listTable CF0802_extraBrdrColor">
			<tr class="listTr2 CF0802_extraBrdrColor">
				<th class="listTh2_bltnCnt"></th>
				<th class="listTh2_bltnSubj">제목</th>
				<th class="listTh2_UserNick">글쓴이</th>
				<th class="listTh2_regDatim">작성일</th>
				<th class="listTh2_bltnReadCnt">조회</th>
			</tr>
			<c:if test="${empty bltnList}">
				<tr class="listTr CF0802_extraBrdrColor">
					<td colspan="6" class="listTd" height="82">
						<div class="boardMsg">작성된 글이 없습니다</div>
					</td>
				</tr>					
			</c:if>
			<c:if test="${!empty bltnList}">					
				<c:forEach items="${bltnList}" var="list" varStatus="status">						
					<tr class="listTr CF0802_extraBrdrColor">
						<td class="listTd2_bltnCnt">
							<span><c:out value="${list.boardRow}"/></span>
						</td>
						<td class="listTd2">
							<c:if test="${list.bltnLev != '1'}">
								<span style=visibility:hidden><img height=1 width=<c:out value="${list.bltnLevLen}"/>/></span>
								<c:out value="${boardVO.imgRe}" escapeXml="false"/>
							</c:if>
							<c:if test="${boardVO.ttlPntYn == 'Y'}">
								<c:if test="${list.betPnt > '0'}"><font color=#A51818>$<c:out value="${list.betPnt}"/></font></c:if>
							</c:if>								
							<a class="bulLink CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm" 
							<c:if test="${list.readable == 'true'}">
								onclick="ebList.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>')"
							</c:if>
							<c:if test="${list.readable == 'false'}">
								onclick="alert('작성자가 글읽기를 허용하지 않았습니다');"
							</c:if>>
							<c:out value="${list.bltnSubj}"/>									
							</a>
							<c:if test="${boardVO.ttlNewYn == 'Y'}">
								<c:if test="${list.recentBltn == 'Y'}"><c:out value="${boardVO.imgNew}" escapeXml="false"/></c:if>
							</c:if>
							<c:if test="${boardVO.ttlReplyYn == 'Y'}">
								<c:if test="${list.bltnReplyCnt != '0'}">
									<c:out value="${boardVO.imgReCnt}" escapeXml="false"/><font class="CF0501_rplFontColor">[<c:out value="${list.bltnReplyCnt}"/>]</font>
								</c:if>
							</c:if>
							<c:if test="${boardVO.ttlMemoYn == 'Y'}">
								<c:if test="${list.bltnMemoCnt != '0'}">
									<c:out value="${boardVO.imgMemo}" escapeXml="false"/><font class="CF0501_rplFontColor">[<c:out value="${list.bltnMemoCnt}"/>]</font>
								</c:if>
							</c:if>            
						</td>
						<td class="listTd2_UserNick CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm">
							<c:out value="${list.userNick}"/>
						</td>
						<td class="listTd2_regDatim CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm">
							<c:out value="${list.regDatimSSF}"/>
						</td>
						<td class="listTd2_bltnReadCnt CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm">
							<c:if test="${list.bltnReadCnt >= boardVO.raiseCnt}"><b><font color=<c:out value="${boardVO.raiseColor}"/>></c:if>
							<c:out value="${list.bltnReadCnt}"/>&nbsp;
							<c:if test="${list.bltnReadCnt >= boardVO.raiseCnt}"></b></font></c:if>
						</td>
					</tr>						
				</c:forEach>
			</c:if>
		</table>
	</div>
	<div class="pageIndex" id="pageIndex"></div>
	<script type="text/javascript">
		var currentPage = <c:out value="${boardSttVO.page}"/>;
		var totalPage   = <c:out value="${boardSttVO.totalPage}"/>;
		var setSize     = 10; <%--하단 Page Iterator에서의 Navigation 갯수--%>
		var imgUrl      = "<%=request.getContextPath()%>/board/images/board/skin/enboard/";
		var color       = "808080";
		
		var afpImg = "imgFirstActive.gif";
		var pfpImg = "imgFirstPassive.gif";
		var alpImg = "imgLastActive.gif";
		var plpImg = "imgLastPassive.gif";
		var apsImg = "imgPrev10Active.gif";
		var ppsImg = "imgPrev10Passive.gif";
		var ansImg = "imgNext10Active.gif";
		var pnsImg = "imgNext10Passive.gif";
		
		var startPage;    
		var endPage;      
		var cursor;      
		var curList = "";
		var prevSet = "";
		var nextSet = "";
		var firstP  = "";
		var lastP   = "";

		moduloCP = (currentPage - 1) % setSize / setSize ;
		startPage = Math.ceil((((currentPage - 1) / setSize) - moduloCP)) * setSize + 1;
		moduloSP = ((startPage - 1) + setSize) % setSize / setSize;
		endPage   = Math.ceil(((((startPage - 1) + setSize) / setSize) - moduloSP)) * setSize;

		if (totalPage <= endPage) endPage = totalPage;
			
		if (currentPage > setSize) {
			firstP = "<font onclick=ebList.next('1') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			firstP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+afpImg+"' align=absmiddle border=0 alt='맨 앞 페이지로 가기'></font>";
			cursor = startPage - 1;
			prevSet = "<font onclick=ebList.next('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			prevSet += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+apsImg+"' align=absmiddle border=0 alt='열 페이지 앞으로 가기'></font>";
		} else {
			firstP  = "<img src='"+imgUrl+pfpImg+"' align=absmiddle border=0>"; 
			prevSet = "<img src='"+imgUrl+ppsImg+"' align=absmiddle border=0>"; 
		}
			
		cursor = startPage;
		while( cursor <= endPage ) {
			if( endPage == 1 ) {
				curList = "<font class='curPage' color=#"+color+">"+currentPage+"</font>";
			}
			else if( cursor == currentPage ) 
				curList += "<font class='curPage' color=#"+color+">"+currentPage+"</font>&nbsp;";
			else if( cursor == endPage ) 
				curList += "<font class='page' onclick=ebList.next('"+cursor+"')>"+cursor+"</font>";
			else {
				curList += "<font class='page' onclick=ebList.next('"+cursor+"')>"+cursor+"</font>&nbsp;";
			}
			
			cursor++;
		}
		
		if( endPage == 0 ) {
				curList = "<font class='curPage' color=#"+color+">"+currentPage+"</font>";
			}

		if ( totalPage > endPage) {
			lastP = "<font onclick=ebList.next('"+totalPage+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			lastP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+alpImg+"' align=absmiddle border=0 alt='맨 끝 페이지로 가기'></font>";
			cursor = endPage + 1;  
			nextSet = "<font onclick=ebList.next('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			nextSet += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+ansImg+"' align=absmiddle border=0 alt='열 페이지 뒤로 가기'></font>";
		} else {
			lastP  = "<img src='"+imgUrl+plpImg+"' align=absmiddle border=0>"; 
			nextSet = "<img src='"+imgUrl+pnsImg+"' align=absmiddle border=0>"; 
		}
		
		curList = firstP +"&nbsp;"+ prevSet +"&nbsp;&nbsp;"+ curList +"&nbsp;&nbsp;"+ nextSet +"&nbsp;"+ lastP;
		
		document.getElementById("pageIndex").innerHTML = curList;
	</script>