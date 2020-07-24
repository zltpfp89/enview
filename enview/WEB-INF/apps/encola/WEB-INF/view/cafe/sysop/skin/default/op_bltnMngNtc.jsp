<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.saltware.enboard.vo.BulletinVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%--BEGIN::상단 공지글 목록--%>
<c:if test="${empty opForm.view || opForm.view == 'list'}">
<div class="cafepanel" style="width:100%;">
  <br style='line-height:5px;'>
  <div>
	<form id="ntc_srchForm" name="ntc_srchForm" method="POST" onsubmit="return false;">
	  <table width="100%">
	    <tr>
		  <td align="left">
		    <span style="margin:0px 10px 0px 30px"><b>공지 건수:</b></span><c:out value="${opForm.totalSize}"/>
		  </td>
		  <td align="right">
			<select id="srchType" name="srchType">
			  <option value="Subj" <c:if test="${opForm.srchType=='Subj'}">selected</c:if>>제    목</option>
			</select>
			<input type="text" id="srchKey" name="srchKey" value="<c:out value="${opForm.srchKey}"/>"/>
			<img src="<%=request.getContextPath()%>/cola/cafe/images/button/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand" onclick="cfOp.bltnMng.search('ntc_srchForm')"/>
			<select id="pageSize" name="pageSize">
			  <c:forEach items="${pageSizeList}" var="pageSize">
			    <option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
			  </c:forEach>
			</select>
		  </td>
	  </tr>
	  </table>    
	  <input type="hidden" id="cmd" name="cmd" value="ntc"/>
	  <input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
	  <input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
	  <input type="hidden" id="pageFunction" name="pageFunction" value="cfOp.bltnMng.doPage"/>
	  <input type="hidden" id="naviDivNm" name="naviDivNm" value="ntc_PAGE_ITERATOR"/>
	</form>
  </div>
  <div class="cafegridpanel">
	<form id="ntc_listForm" name="ntc_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr><td height="2" colspan="100" class="cafegridlimit"></td></tr>
		  <tr style="cursor: pointer;">
			<th class="cafegridheader" align="center" width="30px">
			  <input type="checkbox" id="delCheck" class="cafecheckbox" onclick="cfOp.m_checkBox.chkAll(this)"/>
			</th>
			<th class="cafegridheader"><span>제      목</span></th>
			<th class="cafegridheader"><span>공지시작일</span></th>	
			<th class="cafegridheaderlast"><span>공지종료일</span></th>
		  </tr>
		</thead>
		<tbody id="ntc_listBody">
		<c:forEach items="${noticeList}" var="notice" varStatus="status">
		  <tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="${status.index % 2 != 0}">cafegridline</c:if>">
			<td align="center" class="cafegrid" onclick="cfOp.bltnMng.selectNotice(this)">
			  <input type="checkbox" id="ntc<c:out value="${status.index}"/>_checkRow" name="ntc<c:out value="${status.index}"/>_checkRow" class="cafecheckbox"
			         value="<c:out value="${notice.noticeId}"/>"
			  >
			</td>
			<td align="left" class="cafegrid" onclick="cfOp.bltnMng.selectNotice(this)">
			  <span style="margin-left:10px"><c:out value="${notice.title}"/></span>
			</td>
			<td align="left" class="cafegrid" onclick="cfOp.bltnMng.selectNotice(this)">
			  <span style="margin-left:10px"><c:out value="${notice.startDateSF}"/></span>
			</td>
			<td align="left" class="cafegrid" onclick="cfOp.bltnMng.selectNotice(this)">
			  <span style="margin-left:10px"><c:out value="${notice.endDateSF}"/></span>
			</td>
		  </tr>
		</c:forEach>
		  <tr><td height="2" colspan="100" class="cafegridlimit"></td></tr>
		  <tr><td colspan="100" height="20" align="center"><div id="ntc_PAGE_ITERATOR"></div></td></tr>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr>
		    <td colspan="100" align="right">
			  <span style="margin-right:30px">
				<input type="button" value="신규" style="cursor:pointer" onclick="cfOp.bltnMng.processNotice('add')"/>
			  </span>
			</td>
		  </tr>
		</tbody>
	  </table>
	</form>
  </div>
  <div id="noticeDetailArea"></div>
  <input type="hidden" id="noticeDatail_cmd" name="noticeDatail_cmd">
</div>
</c:if>
<%--END::상단 공지글 목록--%>
<%--BEGIN::하단 공지글 상세보기 탭--%>
  <c:if test="${opForm.view == 'edit'}">
	<div class="cafegridpanel">
      <table cellpadding=0 cellspacing=0 border=0 width='100%' class="cafeformpanel">
		<tr><td height="2" colspan="2" width="100%" class="cafegridlimit"></td></tr>
		<tr>
		  <td width=20% class=cafeformlabel>
		    <img src=<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif width=5 height=5 align=absmiddle maxlength=100>
			제    목
		  </td>
		  <td class="cafeformfieldlast" align="left">
			<input type="text" id="ntc_title" name="ntc_title" value="<c:out value="${noticeVO.title}"/>" maxLength="50" class="full_cafetextfield" size=60/>
		  </td>
		</tr>
		<tr>
		  <td width="20%" class="cafeformlabeldark">
		    <img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">
			공지기간
		  </td>
		  <td class="cafeformfielddarklast" align="left">
			<input type="text" id="ntc_startDate" value="<c:out value="${noticeVO.startDateSF}"/>" style="width:80px" readonly="true">
			<img align="absmiddle" src="<%=request.getContextPath()%>/cola/cafe/images/calendar.gif" onclick="displayCalendar(new Date(), 'ntc_startDate', event)">
			부터
			<input type="text" id="ntc_endDate" value="<c:out value="${noticeVO.endDateSF}"/>" style="width:80px" readonly="true">
			<img align="absmiddle" src="<%=request.getContextPath()%>/cola/cafe/images/calendar.gif" onclick="displayCalendar(new Date(), 'ntc_endDate', event)">
			까지<c:out value="${noticeVO.contentOrg}"/>
		  </td>
		</tr>
		<tr>
		  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">공지내용</td>
		  <td class="cafeformfieldlast" align="left">
		    <textarea id="ntc_content" name="ntc_content" style="width:100%;height:120px"><c:out value="${noticeVO.contentOrg}"/></textarea>
			<input type="hidden" id="set_ntc_content" name="set_ntc_content">
		  </td>
		</tr>
		<tr><td height="2" colspan="2" class="cafegridlimit"></td></tr>
		<tr><td height="10" colspan="2"></td></tr>
		<tr>
		  <td colspan="100" align="right">
		    <span style="margin-right:10px"><input type="button" value="저장" style="cursor:pointer" onclick="cfOp.bltnMng.processNotice('save')"/></span>
		    <span style="margin-right:10px"><input type="button" value="삭제" style="cursor:pointer" onclick="cfOp.bltnMng.processNotice('del')"/></span>
		  </td>
		</tr>
	  </table>
	</div>
  </c:if>
<%--END::하단 공지글 상세보기 탭--%>
