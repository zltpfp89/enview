<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.saltware.enboard.integrate.DefaultBltnExtnMapper,com.saltware.enboard.integrate.DefaultBltnExtnVO"%>

<link href="./css/board/skin/enboard/bbs.css" rel="stylesheet" type="text/css" />
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

<tr>
<td align="center" valign="top" <c:out value="${boardVO.boardBgPicDflt}"/>>
<%-- Details of Board --%>
<div class="board">
  <%-- search --%>
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0" <c:out value="${boardVO.boardBgColorDflt}"/>>
	<tr><td height="60" colspan="28"><font style="color:blue;font-weight:bold;font-size:18px"><c:out value="${boardVO.boardNm}"/></font>&nbsp;|&nbsp;<c:out value="${boardVO.boardTtl}"/></td></tr>
	<tr><td height="2"  colspan="28" bgcolor="blue"></td></tr>
	<tr><td height="4"  colspan="28"></td></tr>
    <form name="setSrch" OnSubmit="return ebList.srchBulletin()">
    <tr>
	  <td height="30" align="left" valign=bottom>
		<c:if test="${boardVO.srchRegYn == 'Y'}">
		  <input type="checkbox" name="srchType" id="srchType" value="RegD" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchType == 'RegD'}">checked</c:if> />작성일
		  <input type=text id=srchBgnReg value=<c:out value="${boardSttVO.srchBgnReg}"/> class="tb_input" style="width:70" readonly="true">
          <img align=absmiddle src=/board/images/board/skin/enboard/calendar.gif <c:if test="${empty boardSttVO.srchType}">onclick="displayCalendar(new Date(), 'srchBgnReg', event)"</c:if>>
		  &nbsp;~&nbsp;
          <input type=text id=srchEndReg value=<c:out value="${boardSttVO.srchEndReg}"/> class="tb_input" style="width:70" readonly="true">
          <img align=absmiddle src=/board/images/board/skin/enboard/calendar.gif <c:if test="${empty boardSttVO.srchType}">onclick="displayCalendar(new Date(), 'srchEndReg', event)"</c:if>>
		</c:if>
      </td>
	  <c:if test="${boardVO.cateYn == 'Y'}">
      <td width=100 align="center" valign="bottom">
        <select name="cateSel" style=font-size:9pt;width:110 onchange="ebList.cateList(this.value)">
          <option style=background-color:#444444;color:#dddddd value=-1>** Category **</option>
          <c:forEach items="${bltnCateList}" var="cList">
		    <c:if test="${!empty cList.bltnCateNm}">
              <option style=background-color:#dddddd value=<c:out value="${cList.bltnCateId}"/> <c:out value="${cList.selected}"/>><c:out value="${cList.bltnCateNm}"/></option>
			</c:if>
		  </c:forEach>
        </select>
      </td>
      </c:if>
	  <td height="30" align="right" valign=bottom>
		<c:if test="${boardVO.srchReplyYn == 'Y'}">
          <input type="checkbox" name="srchType" id="srchType" value="Repl" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchType == 'Repl'}">checked</c:if>/>답글여부
		  <input type="radio" name="srchReplYn" id="srchReplYn" value="Y" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchReplYn == 'Y'}">checked</c:if>/>답글있는글만
		  <input type="radio" name="srchReplYn" id="srchReplYn" value="N" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchReplYn == 'N'}">checked</c:if>/>답글없는글만
		</c:if>
		<c:if test="${boardVO.srchMemoYn == 'Y'}">
          <input type="checkbox" name="srchType" id="srchType" value="Memo" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchType == 'Memo'}">checked</c:if>/>댓글여부
		  <input type="radio" name="srchMemoYn" id="srchMemoYn" value="Y" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchMemoYn == 'Y'}">checked</c:if>/>댓글있는글만
		  <input type="radio" name="srchMemoYn" id="srchMemoYn" value="N" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchMemoYn == 'N'}">checked</c:if>/>댓글없는글만
		  <br>
		</c:if>
        <c:forEach items="${srchList}" var="list">         
          <input type="checkbox" name="srchType" id="srchType" value="<c:out value="${list.srchType}"/>" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> 
		         <c:if test="${boardSttVO.srchType == list.srchType}">checked</c:if>
		  /><c:out value="${list.srchText}"/>
        </c:forEach>
        <input name="srchKey" class="tb_input" style="width:120px;height:18px" value='<c:out value="${boardSttVO.srchKey}"/>' <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> />
        <c:if test="${empty boardSttVO.srchType}">
          <span style=cursor:pointer onClick=ebList.srchBulletin()><c:out value="${boardVO.imgSrch}" escapeXml="false"/></span>
		</c:if>
        <c:if test="${!empty boardSttVO.srchType}">
          <span style=cursor:pointer onClick=ebList.disableSrch()><c:out value="${boardVO.imgSrchX}" escapeXml="false"/></span>
        </c:if>
      </td>
    </tr>
    <tr>
      <td height="30" align="left" style="padding-left:5px;" valign=bottom>
        <c:out value="${boardVO.imgTotal}" escapeXml="false"/>전체 <font color="blue"><b><c:out value="${boardSttVO.totalBltns}"/></b></font>건
      </td>
      <c:if test="${boardVO.cateYn == 'Y'}">
      <td></td>
      </c:if>
      <td height="30" align="right" style="padding-right:5px;" valign=bottom>
        현재 <c:out value="${boardSttVO.page}"/> 페이지 / 전체 <c:out value="${boardSttVO.totalPage}"/> 페이지
      </td>
    </tr>
    <tr hieght="5"><td colspan="3"><td></tr>
  </form>      
  </table>
  
  <%-- contents start --%>
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="3" <c:out value="${boardVO.boardBgColorDflt}"/>>
  <%--list title --%>
  <form name="frmlist">
	<%-- Bulletins are not exist.. --%>
    <c:if test="${empty bltnList}">
    <tr><td height="1" bgcolor="#dbdee7" ></td></tr>
    <tr height=22>
      <td align="center" >등록된 게시물이 존재하지 않습니다.<input type=hidden name=chk></td>
    </tr>
    <tr><td height="2" bgcolor="#dbdee7" ></td></tr>
    </c:if>

    <%-- List of Bulletin --%>
    <c:forEach items="${bltnList}" var="list" varStatus="status">         
	<c:if test="${status.count % 4 == 1}">
	<tr height="200"><%--BEGIN::한 줄에 네개씩 시작--%>
	</c:if>
	  <td valign="top" width="25%" height="100%">
		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
		  <td valign="top" style="border:1px silver solid" onMouseOver="this.style.backgroundColor='#E8ECF9'" onMouseOut="this.style.backgroundColor=''">
			<table width="100%" align="center" border="0" cellspacing="6" cellpadding="0">
			  <c:if test="${boardVO.ttlNoYn == 'Y'}">
			  <tr>
				<td>
				  <c:if test="${list.selected == 'false'}">
					<c:if test="${list.boardRow == '0'}"><c:out value="${boardVO.imgNotice}" escapeXml="false"/></c:if>
					<c:if test="${list.boardRow != '0'}"><c:out value="${list.boardRow}"/></c:if>
					<%--c:if test="${list.boardRow != '0'}"><c:out value="${list.bltnGn}"/></c:if--%>
				  </c:if>
				  <c:if test="${list.selected != 'false'}">
					<c:out value="${boardVO.imgSelected}" escapeXml="false"/>
				  </c:if>
				</td>
			  <tr>
			  </c:if>
			  <%-- Picture --%>
			  <tr height="200">
                <td align=center>
                  <table border=0 cellspacing=0 cellpadding=0>
                    <tr>
					  <td align="center" style="border:1px #999999 solid;cursor:pointer">
						<img id="<c:out value="${list.fileMask}"/>" src="<c:out value="${list.thumbImgSrc150}"/>" onerror="<c:out value="${list.imgOnError}"/>"
							 onload="ebList.imageResize(this,160,160)" onclick="'<c:out value="${list.imgSrc}"/>'.popupView()" align="absmiddle" style="cursor:pointer">
					  </td>                   
					</tr>
				  </table>
				</td>
			  </tr>
			  <tr>
				<td style="word-wrap:break-word;word-break:break-all">
				  <c:if test="${boardVO.readMultiYn == 'Y'}">
					<span style=cursor:pointer onclick=ebList.checkBulletin(this) id=box name=box checkeditem=N value=<c:out value="${list.bltnNo}"/>>
					  <c:out value="${boardVO.imgXox}" escapeXml="false"/>
					</span>
				  </c:if>
				  <c:if test="${boardVO.ttlPntYn == 'Y'}">
					<c:if test="${list.betPnt > '0'}"><font color=#A51818>$<c:out value="${list.betPnt}"/></font></c:if>
				  </c:if>
				  <a style=cursor:pointer OnMouseOver=this.style.textDecoration='underline' OnMouseOut=this.style.textDecoration='none'
					<c:if test="${list.readable == 'true'}">
					  onclick="ebList.readBulletin('<c:out value="${list.boardId}"/>','<c:out value="${list.bltnNo}"/>')"
					</c:if>
					<c:if test="${list.readable == 'false'}">
					  onclick="alert('작성자가 글읽기를 허용하지 않았습니다');"
					</c:if>
				  >
					<c:out value="${list.bltnOrgSubj}" escapeXml="false"/>
				  </a>
				  <c:if test="${boardVO.ttlReplyYn == 'Y'}">
					<c:if test="${list.bltnReplyCnt != '0'}">
					  <c:out value="${boardVO.imgReCnt}" escapeXml="false"/>
					  <font color="#CC4848">(<c:out value="${list.bltnReplyCnt}"/>)</font>
					</c:if>
				  </c:if>
				  <c:if test="${boardVO.ttlMemoYn == 'Y'}">
					<c:if test="${list.bltnMemoCnt != '0'}">
					  <c:out value="${boardVO.imgMemo}" escapeXml="false"/>
					  <font color="#CC4848">(<c:out value="${list.bltnMemoCnt}"/>)</font>
					</c:if>
				  </c:if>
				  <c:if test="${boardVO.ttlNewYn == 'Y'}">
					<c:if test="${list.recentBltn == 'Y'}"><c:out value="${boardVO.imgNew}" escapeXml="false"/></c:if>
				  </c:if>
				  <br>
				  <c:if test="${boardVO.ttlCateYn == 'Y' && boardVO.cateYn == 'Y'}">
					<c:out value="${list.cateNm}"/>
				  </c:if>
				  <c:if test="${boardVO.ttlNickYn == 'Y'}">
					<c:out value="${list.userNick}"/>
				  </c:if>
				  <c:if test="${boardVO.ttlRegYn == 'Y'}">
					<c:out value="${list.regDatimSF}"/>
				  </c:if>
				  <c:if test="${boardVO.ttlReadYn == 'Y'}">
					<c:if test="${list.bltnReadCnt >= boardVO.raiseCnt}"><b><font color=<c:out value="${boardVO.raiseColor}"/>></c:if>
					<c:out value="${list.bltnReadCnt}"/>&nbsp;
					<c:if test="${list.bltnReadCnt >= boardVO.raiseCnt}"></b></font></c:if>
				  </c:if>
				  <c:if test="${boardVO.listCnttYn == 'Y'}">
					<br><c:out value="${list.bltnOrgCntt}" escapeXml="false"/>
				  </c:if>
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
		</table>
	  </td>
	<c:if test="${status.count % 4 == 0 || status.last}">
	</tr><%--END::한 줄에 네개씩--%>
	</c:if>
    </c:forEach>
    <%-- End of List of Bulletin --%>
  </form>
  </table>
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0" <c:out value="${boardVO.boardBgColorDflt}"/>>
	<tr><td height="2" bgcolor="#dbdee7" ></td></tr>
    <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
    <tr>
      <td>
        <table width=100% border="0" cellspacing="0" cellpadding="0">
          <tr>
            <c:if test="${boardVO.readMultiYn == 'Y'}">
              <td width=22 align=center onClick=ebList.readBulletin('<c:out value="${boardVO.boardId}"/>',-1) style=cursor:pointer>
                <c:out value="${boardVO.imgAllsee}" escapeXml="false"/>
              </td>
            </c:if>
            <td id="pageIndex" align="center" class="board_num"></td>
            <c:if test="${boardVO.writableYn == 'Y' && boardVO.mergeType == 'A'}">
              <td width=80 align="right"><a onClick=ebList.writeBulletin() style=cursor:pointer><c:out value="${boardVO.imgWrite}" escapeXml="false"/></a></td>
            </c:if>
          </tr>
        </table>
      </td>
    </tr>
    <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
  </table>
</div>
<%--이용만족도 조사.Draft.2010.02.19.KWShin.--%>
<%--div>
  <form name='rcmdForm'>
  <input type='hidden' name='cMen' value=''>
  <input type='hidden' name='cScore' value=''>
  <table style="border-top:1px solid #e6e6e6; border-bottom:1px solid #e6e6e6; font-family:돋움; font-size:12px;" width="600" border="0" cellspacing="0" cellpadding="0" summary="만족도조사">
    <caption style='display:none;height:0px;'>만족도조사</caption>
    <tr style="border-bottom:1px solid #e6e6e6">
	  <th width="90" rowspan="2" bgcolor="#f6f6f6" style="color:#7c7c7c">만족도조사</th>
	  <td height="29" style="color:#666666; padding-left:9px; border-bottom:1px solid #e6e6e6;">유용한 정보가 되셨습니까?</td>
	  <td></td>
    </tr>
    <tr>
	  <td height="29" style="padding-left:6px">
	    <input type="radio" name='pnt' id='pnt'  value='5' checked title="5점"/>
	    <img src="$themePath/images/rcmd/icon_star5.gif" alt="5점" width="45" height="8" align="absmiddle" />&nbsp;&nbsp;
	    <input type="radio"  name='pnt' id='pnt' value='4' title="4점"/>
	    <img src="$themePath/images/rcmd/icon_star4.gif" alt="4점" width="45" height="8" align="absmiddle" />&nbsp;&nbsp;
	    <input type="radio"  name='pnt' id='pnt' value='3' title="3점"/>
	    <img src="$themePath/images/rcmd/icon_star3.gif" alt="3점" align="absmiddle" width="45" height="8" />&nbsp;&nbsp;
	    <input type="radio"  name='pnt' id='pnt' value='2' title="2점"/>
	    <img src="$themePath/images/rcmd/icon_star2.gif" align="absmiddle" alt="2점" width="45" height="8" />&nbsp;&nbsp;
	    <input type="radio"  name='pnt' id='pnt' value='1' title="1점"/>
	    <img src="$themePath/images/rcmd/icon_star1.gif" alt="1점" align="absmiddle" width="46" height="8" />
	  </td>
	  <td align="right">
	    <a href="javascript:saveRcmd(document.rcmdForm);">
		  <img src="$themePath/images/rcmd/ok_btn01.gif" alt="확인" border="0" width="50" height="18" align="absmiddle" />
	    </a>
	  </td>
    </tr>
  </table>
  <input type="hidden" name="sCd" value="enBoard">
  <input type="hidden" name="cId" value="$site.getPage().getId()">
  <input type="hidden" name="oId" value="$rc.getPage().getOwnerInfoList().get(0).get('user_id')">
  </form>
</div--%>
</td>
</tr>

<script language="javascript">
	var currentPage = <c:out value="${boardSttVO.page}"/>;
	var totalPage   = <c:out value="${boardSttVO.totalPage}"/>;
	var setSize     = 10; <%--하단 Page Iterator에서의 Navigation 갯수--%>
	var imgUrl      = "/board/images/board/skin/enboard/";
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
		if( cursor == currentPage ) 
	   		curList += "<font color=#"+color+">"+currentPage+"</font>&nbsp;";
		else {
	    	curList += "<font onclick=ebList.next('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			curList += " onmouseout=this.style.textDecoration='none'>"+cursor+"</font>&nbsp;";
		}
		
		cursor++;
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
