<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enboard.integrate.DefaultBltnExtnMapper,com.saltware.enboard.integrate.DefaultBltnExtnVO"%>

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
<c:set var="colCnt" value="15"/>
<c:set var="emptyCol" value="${5}"/>
<div class="title_box">
	<a class="boardName CF0501_nmFontColor CF0501_nmFontNm" href="<%= request.getContextPath()%>/board/list.brd?boardId=<c:out value="${boardVO.boardId}"/>&listOpt=selectMenu"><c:out value="${boardVO.boardNm}"/></a>
	<span class="boardPipe">|</span>
	<span class="boardDesc"><c:out value="${boardVO.boardTtl}"/></span>
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
			<input id="srchBtn" value="<util:message key='eb.title.search'/>" type="submit" alt="<util:message key='eb.title.search'/>" class="CF0601_srchBtn srchBtn"/>
		</form> 
	</div>	
</div>
<div class="boardList CF0802_extraBrdrColor" style="float: left; border-top-width: 1px; border-top-style: solid;">	
	<ul class="IMG IMG_<c:out value="${brdGrpType}"/>">
	<c:if test="${!empty bltnList}">					
		<c:forEach items="${bltnList}" begin="0" end="${colCnt-1}" var="list" varStatus="status">
		<li class="img_box<c:if test="${!status.first && status.count % 5 == 0}">_last</c:if>">
			<dl class="img_data">				
				<dt>
					<c:if test="${list != null}">
						<a onclick="parent.cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)">
							<img id="<c:out value="${list.fileMask}"/>" class="img_img" src="<%=request.getContextPath()%><c:out value="${list.thumbImgSrc100}"/>" onerror="src='<%=request.getContextPath()%>/upload/board/thumb/no.gif'"/>						
						</a>
					</c:if>
					<c:if test="${list == null}">
						<div class="img_blank_thumb CF0802_bgColor CF0802_extraBrdrColor"></div>
					</c:if>
				</dt>
				<dd class="img_subject"><a onclick="parent.cfCntt.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>', <c:out value="${list.readable}"/>)"><c:out value="${list.bltnSubj}"/></a></dd>
				<dd class="img_regDatim"><c:out value="${list.regDatimSSF}"/></dd>
				<dd class="img_userNick"><c:out value="${list.userNick}"/></dd>
			</dl>
		</li>
		<c:if test="${status.last}">
			<c:set var="emptyCol" value="${(colCnt - status.count )%5}"/>
		</c:if>
		</c:forEach>		
		<c:if test="${emptyCol > 0}">
			<c:forEach begin="0" end="${emptyCol-1}" varStatus="status">		
			<li class="img_box<c:if test="${ (emptyCol - status.count + 5 ) % 5 == 0}">_last</c:if>">
				<dl class="img_data"><dd><div class="img_blank_thumb CF0802_bgColor CF0802_extraBrdrColor"></div></dd></dl>
			</li>
			</c:forEach>
		</c:if>
	</c:if>
	<c:if test="${empty bltnList}">				
		<li class="msgbox">
			<div class="boardMsg">등록된 컨텐츠가 없습니다.</div>
		</li>
	</c:if>
	</ul>
</div>
<div class="pageIndex CF0802_extraBrdrColor" id="pageIndex"></div>
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