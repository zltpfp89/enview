<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class=cafegridpanel>
  <table cellpadding=0 cellspacing=0 border=0 width=100% class=cafeformpanel>
    <%--BEGIN::'폐쇄신청' 상태이면--%>
	<c:if test="${cmntVO.cmntState == '13'}">
	<tr>
	  <td colspan=2 style=padding:10px;background-color:#EEEEEE;border-top-color:#E6E6E6;border-top-style:solid;border-top-width:1px>
		<font color=blue><b><c:out value="${cmntVO.updDatimSF}"/> 에 이미 폐쇄 신청을 하신 상태이며, 현재 카페지기를 포함한 잔류 회원은 <c:out value="${cmntVO.mmbrTot}"/> 명입니다.</b></font><br>
		폐쇄 신청일로부터 <b><c:out value="${cafeCloseNoticeDays}"/></b> 일 동안 공지 안내 후에 폐쇄가 진행됩니다.<br>
		공지기간이 경과한 후에는 가입 회원이 남아 있더라도 <b><c:out value="${cafeCloseDeferedDays}"/></b> 일 동안 작성된 글이 없으면 자동으로 폐쇄가 진행됩니다.<br>
		폐쇄가 진행된 후에는 게시글을 포함한 카페 데이터에 대한 복구가 불가능합니다.
	  </td>
	</tr>
	<tr><td height=10></td></tr>
	<tr><td height=2 colspan=2 class=cafegridlimit></td></tr>
	<tr>
	  <td width=20% class=cafeformlabel>
	    <img src=<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif width=5 height=5 align=absmiddle>
	    제    목
	  </td>
	  <td class=cafeformfieldlast align=left>
		<input type=text id=close_title name=close_title maxLength=50 class=full_cafetextfield maxlength=100 size=60>
	  </td>
	</tr>
	<tr>
	  <td width=20% class=cafeformlabel>
	    <img src=<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif width=5 height=5 align=absmiddle>
		공지내용
	  </td>
	  <td class=cafeformfieldlast align=left>
		<textarea id=close_content name=close_content style=width:100%;height:120px>
		  &lt;font color=blue&gt;&lt;b&gt;카페 폐쇄 취소 공지&lt;/b&gt;&lt;/font&gt;&lt;br&gt;
		  &lt;br&gt;
		  안녕하십니까? 카페지기입니다.&lt;br&gt;
		  &lt;br&gt;
		  <c:out value="${cmntVO.updDatimSF}"/> 에 신청한 카페 폐쇄를 취소하고자 합니다.&lt;br&gt;
		  변합없는 사랑을 부탁드립니다.
		</textarea>
		<input type=hidden id=set_close_content name=set_close_content>
	  </td>
	</tr>
	<tr><td height=2 colspan=2 class=cafegridlimit></td></tr>
	<tr><td height=10></td></tr>
	<tr>
	  <td colspan=2 align=center><input type=button value=폐쇄취소 style=cursor:pointer onclick=cfOp.baseInfo.closeCafe('cancel')></td>
	</tr>
	</c:if>
    <%--END::'폐쇄신청' 상태이면--%>
    <%--BEGIN::'개설승인'(정상) 상태이면--%>
    <c:if test="${cmntVO.cmntState == '11'}">
	<%--BEGIN::회원이 있는 상태이면--%>
	<c:if test="${cmntVO.mmbrTot > 1}">
	<tr>
	  <td colspan=2 style=padding:10px;background-color:#EEEEEE;border-top-color:#E6E6E6;border-top-style:solid;border-top-width:1px>
		<font color=blue><b>현재 카페지기를 포함한 회원이 <c:out value="${cmntVO.mmbrTot}"/> 명으로 카페를 당장은 폐쇄할 수 없습니다.</b></font><br>
		카페 폐쇄 공지를 작성하신 후 폐쇄신청을 하시면, <b><c:out value="${cafeCloseNoticeDays}"/></b> 일 동안 공지 안내 후에 폐쇄가 진행됩니다.<br>
		공지기간이 경과한 후에는 가입 회원이 남아 있더라도 <b><c:out value="${cafeCloseDeferedDays}"/></b> 일 동안 작성된 글이 없으면 자동으로 폐쇄가 진행됩니다.<br>
		폐쇄가 진행된 후에는 게시글을 포함한 카페 데이터에 대한 복구가 불가능합니다.
	  </td>
	</tr>
	<tr><td height=10></td></tr>
	<tr><td height=2 colspan=2 class=cafegridlimit></td></tr>
	<tr>
	  <td width=20% class=cafeformlabel>
	    <img src=<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif width=5 height=5 align=absmiddle>
	    제    목
	  </td>
	  <td class=cafeformfieldlast align=left>
		<input type=text id=close_title name=close_title maxLength=50 class=full_cafetextfield maxlength=100 size=60>
	  </td>
	</tr>
	<tr>
	  <td width=20% class=cafeformlabel>
	    <img src=<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif width=5 height=5 align=absmiddle>
		공지내용
	  </td>
	  <td class=cafeformfieldlast align=left>
		<textarea id=close_content name=close_content style=width:100%;height:120px>
		  &lt;font color=blue&gt;&lt;b&gt;카페 폐쇄 공지&lt;/b&gt;&lt;/font&gt;&lt;br&gt;
		  &lt;br&gt;
		  안녕하십니까? 카페지기입니다.&lt;br&gt;
		  &lt;br&gt;
		  폐쇄 예정일: <c:out value="${opForm.stateDatimSF}"/>
		</textarea>
		<input type=hidden id=set_close_content name=set_close_content>
	  </td>
	</tr>
	<tr><td height=2 colspan=2 class=cafegridlimit></td></tr>
	<tr><td height=10></td></tr>
	<tr>
	  <td colspan=2 align=center><input type=button value=폐쇄신청 style=cursor:pointer onclick=cfOp.baseInfo.closeCafe('defered')></td>
	</tr>
	</c:if>
	<%--END::회원이 있는 상태이면--%>
	<%--BEGIN::회원이 없는 상태이면--%>
	<c:if test="${cmntVO.mmbrTot == 1}">
	<tr>
	  <td colspan=2 style=padding:10px;background-color:#EEEEEE;border-top-color:#E6E6E6;border-top-style:solid;border-top-width:1px>
		<font color=blue><b>현재 카페지기를 제외한 회원이 없으므로 카페를 폐쇄할 수 있습니다.</b></font><br>
		폐쇄가 진행된 후에는 게시글을 포함한 카페 데이터에 대한 복구가 불가능합니다.
	  </td>
	</tr>
	<tr><td height=10></td></tr>
	<tr>
	  <td colspan=2 align=center><input type=button value=폐쇄신청 style=cursor:pointer onclick=cfOp.baseInfo.closeCafe('realtime')></td>
	</tr>
	</c:if>
	<%--END::회원이 없는 상태이면--%>
	</c:if>
    <%--END::'개설승인'(정상) 상태이면--%>
  </table>
  <input type=hidden id=close_try name=close_try>
</div>
