<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
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
<td align=center >

<div class="board">
  
  <table width=800 border="0" cellspacing="0" cellpadding="0" >
  <form name="frmSearch" action="poll.brd">
  <input type="hidden" name="cmd" value="LIST"/>
  <input type="hidden" name="page" value="1"/>
  <input type="hidden" name="srchType" id="srchType" value="Subj"/>
  
    <tr>
	  <td height="30" align="left" valign=bottom>
      </td>
	  <td height="30" align="right" valign=bottom>
       	<input name="srchKey" class="tb_input" style="width:120px;height:18px" value=''  />
        <span style=cursor:pointer onClick=ebList.srchBulletin()><img src='/board/images/board/skin/default/imgSrch.gif' align='absmiddle'></span>
      </td>
    </tr>
    <tr>
      <td height="30" align="left" style="padding-left:5px;" valign=bottom>
        <img src='/board/images/board/skin/default/imgTotal.gif' align='absmiddle'>전체 <font color="blue"><b><c:out value="${bpForm.totalRecs}"/></b></font>건
      </td>
      
      <td></td>
      
      <td height="30" align="right" style="padding-right:5px;" valign=bottom>
        현재  ${bpForm.page}  페이지 / 전체  ${bpForm.totalPage} 페이지
      </td>
    </tr>
    <tr hieght="5"><td colspan="3"><td></tr>
  </form>      
  </table>
  
  
  <table width=800 border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" >
	  <form name="frmlist" onsubmit="return false">
	  <table width=100% border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td height="2" colspan="28" bgcolor="blue"></td>
	    </tr>
	    <tr>
          <td width="40" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>번호</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
          <td width="60" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>진행상태</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
          <td width="20" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b></b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"></td>
	      <td align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>제목</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="80" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>작성자</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="90" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>기간</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="50" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>참여여부</b></td>
	    </tr>
        <tr><td height="1" colspan="28" bgcolor="#dbdee7" ></td></tr>
		<c:forEach items="${pollList}" var="poll" varStatus="seq">
        <tr onMouseOver=this.style.backgroundColor='#E8ECF9' onMouseOut=this.style.backgroundColor=''>
          <td class="table_list_c"><c:out value="${poll.pollNo}"></c:out></td>
          <td width="3" nowrap></td>
          <td class="table_list_c"><c:out value="${poll.procYn}"></c:out></td>
          <td width="3" nowrap></td>
          <td class="table_list_c"></td>
          <td width="3" nowrap></td>
          <td class="table_list_l">
			  <a style=cursor:pointer OnMouseOver=this.style.textDecoration='underline' OnMouseOut=this.style.textDecoration='none' onclick="alert('oops')">
	          <c:out value="${poll.boardNm}"></c:out>
              </a>
          </td>
          <td width="3" nowrap></td>
          <td class="table_list_c"><c:out value="${poll.updUserId}"></c:out></td>
          <td width="3" nowrap></td>
          <td class="table_list_c">
	          <c:out value="${poll.pollBgnYmd}"></c:out>~<c:out value="${poll.pollEndYmd}"></c:out>
		  </td>
          <td width="3" nowrap></td>
          <td class="table_list_c"><c:out value="${poll.attendYn}"></c:out></td>
        </tr>
        </c:forEach>
        <tr><td height="2" colspan="28" bgcolor="#dbdee7" ></td></tr>
      </table>
      </form>
    </td>
  </tr>
  <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
  <tr>
    <td align="right">
      <table width=100% border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td id="pageIndex" align="center" class="board_num"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
  </table>
</div>
</td>
</tr>

</form>
<script language="javascript">
	function goPage( page) {
		var f = document.forms["frmSearch"];
		f.page.value = page;
		f.submit();
	}

	var currentPage = <c:out value="${bpForm.page}"/>;
	var totalPage   = <c:out value="${bpForm.totalPage}"/>;
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
		firstP = "<font onclick=goPage('1') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		firstP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+afpImg+"' align=absmiddle border=0 alt='맨 앞 페이지로 가기'></font>";
	    cursor = startPage - 1;
	    prevSet = "<font onclick=goPage('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
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
	    	curList += "<font onclick=goPage('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			curList += " onmouseout=this.style.textDecoration='none'>"+cursor+"</font>&nbsp;";
		}
		
		cursor++;
	}
		     
	if ( totalPage > endPage) {
		lastP = "<font onclick=goPage('"+totalPage+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		lastP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+alpImg+"' align=absmiddle border=0 alt='맨 끝 페이지로 가기'></font>";
		cursor = endPage + 1;  
		nextSet = "<font onclick=goPage('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		nextSet += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+ansImg+"' align=absmiddle border=0 alt='열 페이지 뒤로 가기'></font>";
	} else {
		lastP  = "<img src='"+imgUrl+plpImg+"' align=absmiddle border=0>"; 
		nextSet = "<img src='"+imgUrl+pnsImg+"' align=absmiddle border=0>"; 
	}
	
	curList = firstP +"&nbsp;"+ prevSet +"&nbsp;&nbsp;"+ curList +"&nbsp;&nbsp;"+ nextSet +"&nbsp;"+ lastP;
	
	document.getElementById("pageIndex").innerHTML = curList;
</script>
