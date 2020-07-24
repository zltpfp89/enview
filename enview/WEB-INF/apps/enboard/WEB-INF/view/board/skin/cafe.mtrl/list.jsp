<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
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
<div class="title_box">
	<a class="boardName CF0501_nmFontColor CF0501_nmFontNm" href="<%= request.getContextPath()%>/board/list.brd?boardId=<c:out value="${boardVO.boardId}"/>&listOpt=selectMenu"><c:out value="${boardVO.boardNm}"/></a>
	<span class="boardPipe">|</span>
	<span class="boardDesc"><c:out value="${boardVO.boardNm}"/></span>
</div>
<div class="controlBox" style="padding-bottom: 5px;">
	<c:if test="${boardVO.writableYn == 'Y' and boardVO.mergeType == 'A'}">
		<a class="btnWrite" href="javascript:ebList.writeBulletin();" target="_self">
			<span class="btn_bg bg03"></span>
			<span class="btn_txt bt03 w07 bold">
				<span class="btn_icon_write"><util:message key='eb.info.title.write' /></span>
			</span>
		</a>
	</c:if>
	<div class="search_box">
		<form name="setSrch" OnSubmit="return ebList.srchBulletin()">		
			<c:if test="${boardVO.cateYn == 'Y'}">
			<select name="cateSel" style=font-size:9pt;width:110 onchange="ebList.cateList(this.value)">
			<option style=background-color:#444444;color:#dddddd value=-1>** Category **</option>
			<c:forEach items="${bltnCateList}" var="cList">
			<c:if test="${!empty cList.bltnCateNm}">
			<option style=background-color:#dddddd value=<c:out value="${cList.bltnCateId}"/> <c:out value="${cList.selected}"/>><c:out value="${cList.bltnCateNm}"/></option>
			</c:if>
			</c:forEach>
			</select>
			</c:if>
			<c:if test="${boardVO.srchReplyYn == 'Y'}">
			<input type="checkbox" name="srchType" id="srchType" value="Repl" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchType == 'Repl'}">checked</c:if>/><util:message key='eb.info.ttl.replyYn' />
			<input type="radio" name="srchReplYn" id="srchReplYn" value="Y" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchReplYn == 'Y'}">checked</c:if>/><util:message key='eb.label.reply.existOnly' />
			<input type="radio" name="srchReplYn" id="srchReplYn" value="N" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchReplYn == 'N'}">checked</c:if>/><util:message key='eb.label.reply.nonExistOnly' />
			</c:if>
			<c:if test="${boardVO.srchMemoYn == 'Y'}">
			<input type="checkbox" name="srchType" id="srchType" value="Memo" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchType == 'Memo'}">checked</c:if>/><util:message key='eb.info.ttl.commentYn' />
			<input type="radio" name="srchMemoYn" id="srchMemoYn" value="Y" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchMemoYn == 'Y'}">checked</c:if>/><util:message key='eb.label.memo.existOnly' />
			<input type="radio" name="srchMemoYn" id="srchMemoYn" value="N" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchMemoYn == 'N'}">checked</c:if>/><util:message key='eb.label.memo.notExistOnly' />
			<br>
			</c:if>
			<select id="srchType" class="srchType CF0601_brdrColor" name="srchType">
			<c:forEach items="${srchList}" var="list">         
			<option value="<c:out value="${list.srchType}"/>" <c:if test="${boardSttVO.srchType == list.srchType}">selected="selected"</c:if>><c:out value="${list.srchText}"/></option>
			</c:forEach>
			</select>
			<input name="srchKey" class="CF0601_bgColor CF0601_brdrColor CF0601_brdrStyle CF0601_fontColor srchKey" type="text" value="<c:out value="${boardSttVO.srchKey}"/>"/>
			<input id="srchBtn" title="<util:message key='eb.title.search'/>" type="submit" alt="<util:message key='eb.title.search'/>" class="CF0601_srchBtn srchBtn" value="<util:message key='eb.title.search'/>"/>
		</form> 
	</div>	
</div>
<div class="boardList CF0802_extraBrdrColor">
	<table class="listTable CF0802_extraBrdrColor">
		<tr class="listTr2 CF0802_extraBrdrColor">
			<th class="listTh2_bltnCnt"></th>
			<th class="listTh2_bltnSubj"><util:message key='eb.info.ttl.bltnSubj' /></th>
			<th class="listTh2_UserNick"><util:message key='eb.info.ttl.bltnWriter' /></th>
			<th class="listTh2_regDatim"><util:message key='eb.info.ttl.date' /></th>
			<th class="listTh2_bltnReadCnt"><util:message key='eb.info.ttl.hits' /></th>
		</tr>
		<c:if test="${empty bltnList}">
			<tr class="listTr CF0802_extraBrdrColor">
				<td colspan="5" class="listTd" height="82">
					<div class="boardMsg"><util:message key='cf.error.not.exist.post' /></div>
				</td>
			</tr>					
		</c:if>
		<c:if test="${!empty bltnList}">					
			<c:forEach items="${bltnList}" var="list" varStatus="status">						
				<tr class="listTr CF0802_extraBrdrColor">
					<td class="listTd2_bltnCnt">
						<c:if test="${list.boardRow == '0'}">
							<c:if test="${list.bltnGn > 9900000000 }">
								<img src="<%=request.getContextPath()%>/cola/cafe/images/each/encafe/cntt/icon_top_noti.png" />
							</c:if>
							<c:if test="${9000000000 < list.bltnGn  && list.bltnGn < 9900000000}">
								<img src="<%=request.getContextPath()%>/cola/cafe/images/each/encafe/cntt/icon_noti.gif" />
							</c:if>
						</c:if>
              			<c:if test="${list.boardRow != '0'}">
              				<span><c:out value="${list.boardRow}"/></span>
              			</c:if>
					</td>
					<td class="listTd2">
						<c:if test="${list.bltnLev != '1'}">
							<span style=visibility:hidden><img height=1 width=<c:out value="${list.bltnLevLen}"/>/></span>
							<c:out value="${boardVO.imgRe}" escapeXml="false"/>
						</c:if>
						<c:if test="${boardVO.ttlPntYn == 'Y'}">
							<c:if test="${list.betPnt > '0'}"><font color=#A51818>$<c:out value="${list.betPnt}"/></font></c:if>
						</c:if>								
						<a class="bulLink CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm" target="_self" 
						<c:if test="${list.readable == 'true'}">
							href="javascript:ebList.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>')"
						</c:if>
						<c:if test="${list.readable == 'false'}">
							href="javascript:alert('<util:message key='eb.info.message.notAllowRead' />');"
						</c:if>>
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
							<c:if test="${list.recentBltn == 'Y'}"><c:out value="${boardVO.imgNew}" escapeXml="false"/></c:if>
						</c:if>	           
					</td>
					<td class="listTd2_UserNick CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm">
						<c:out value="${list.userNick}"/>
					</td>
					<td class="listTd2_regDatim CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm">
						<c:out value="${list.regDatimSF}"/>
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
		else if( cursor==endPage && endPage == currentPage ) 
			curList += "<font class='curPage' color=#"+color+">"+cursor+"</font>";
		else if( cursor == endPage ) 
			curList += "<font class='page' onclick=ebList.next('"+cursor+"')>"+cursor+"</font>";
		else if( cursor == currentPage ) 
			curList += "<font class='curPage' color=#"+color+">"+currentPage+"</font>&nbsp;&nbsp;";
		else {
			curList += "<font class='page' onclick=ebList.next('"+cursor+"')>"+cursor+"</font>&nbsp;&nbsp;";
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

