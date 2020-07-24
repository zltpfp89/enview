<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.saltware.enboard.vo.BulletinVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
  	
<%--BEGIN::상단 공지글 목록--%>
<c:if test="${empty opForm.view || opForm.view == 'list'}">
<form id="ntc_srchForm" name="ntc_srchForm" method="POST" onsubmit="return false;">
	<div class="board_btn_wrap">
		<div class="board_btn_wrap_left">
			<util:message key="cf.title.noticeCnt"/> : <strong class="font_blue"><c:out value="${opForm.totalSize}"/></strong>
		</div>
		<div class="board_btn_wrap_right">
				<fieldset>
					<legend>검색</legend>
					<select id="srchType" name="srchType">
					  <option value="Subj" <c:if test="${opForm.srchType=='Subj'}">selected</c:if>><util:message key="ev.info.title"/></option>
					</select>
					<div>
						<label for="search" class="none">검색어입력</label>
						<input type="text" id="srchKey" name="srchKey" value="<c:out value="${opForm.srchKey}"/>"/>
						<label for="search_submin"></label>
						<input type="submit" value="<util:message key="eb.title.search"/>" class="" id="search_submin" onclick="cfOp.bltnMng.search('ntc_srchForm')">
					</div>
					<select id="pageSize" name="pageSize">
					  <c:forEach items="${pageSizeList}" var="pageSize">
					    <option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
					  </c:forEach>
					</select>
				</fieldset>
				<input type="hidden" id="cmd" name="cmd" value="ntc"/>
				<input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
				<input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
				<input type="hidden" id="pageFunction" name="pageFunction" value="cfOp.bltnMng.doPage"/>
				<input type="hidden" id="naviDivNm" name="naviDivNm" value="ntc_PAGE_ITERATOR"/>
			</div>
			</div>
			</form>
			<form id="ntc_listForm" name="ntc_listForm" style="display:inline" action="" method="post" onsubmit="return false;">	
			<table class="table_type01" summary="게시판">
				<caption>게시판</caption>
				<colgroup>
					<col width="80px;">
					<col width="auto;">
					<col width="120px;">
					<col width="120px;">
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="delCheck" class="cafecheckbox" onclick="cfOp.m_checkBox.chkAll(this)"/></th>
						<th><util:message key="ev.info.title"/></th>
						<th><util:message key="cf.title.startDate.notice"/></th>
						<th><util:message key="cf.title.endDate.notice"/></th>
					</tr>
				</thead>
				<tbody id="ntc_listBody">
					<c:if test="${empty noticeList}" >
						<tr>
							<td colspan="4">
								<util:message key="cf.info.not.exist.notice"/>
							</td>
						  </tr>
					</c:if>
					<c:if test="${!empty noticeList}" >
						<c:forEach items="${noticeList}" var="notice" varStatus="status">
						  <tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="${status.index % 2 != 0}">cafegridline</c:if>"
				           >
							<td onclick="cfOp.bltnMng.selectNotice(this)">
							  <input type="checkbox" id="ntc<c:out value="${status.index}"/>_checkRow" name="ntc<c:out value="${status.index}"/>_checkRow" class="cafecheckbox"
							         value="<c:out value="${notice.noticeId}"/>"
							  >
							</td>
							<td onclick="cfOp.bltnMng.selectNotice(this)">
							  <span style="margin-left:10px"><c:out value="${notice.title}"/></span>
							</td>
							<td onclick="cfOp.bltnMng.selectNotice(this)">
							  <span style="margin-left:10px"><c:out value="${notice.startDateSF}"/></span>
							</td>
							<td onclick="cfOp.bltnMng.selectNotice(this)">
							  <span style="margin-left:10px"><c:out value="${notice.endDateSF}"/></span>
							</td>
						  </tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
			</form>
			<div class="board_btn_wrap">				
				<div class="board_btn_wrap_right">
					<a href="#" onclick="javascript:cfOp.bltnMng.processNotice('add');" class="btn black new"><util:message key="ev.title.new"/></a>
				</div>
			</div>
			<!-- 페이징 start -->
			<div class="paging  bm50">
				<div id="ntc_PAGE_ITERATOR"></div>
			</div>
			<!-- //페이징 end -->	
			<div id="noticeDetailArea"></div>
			<input type="hidden" id="noticeDatail_cmd" name="noticeDatail_cmd">
</c:if>

<%--END::상단 공지글 목록--%>
<%--BEGIN::하단 공지글 상세보기 탭--%>
  <c:if test="${opForm.view == 'edit'}">
  
	<div class="board_btn_wrap tp30">
		<div class="board_btn_wrap_left">
			<h4 class="cafeadm_title"><util:message key="ev.title.new"/> <util:message key="eb.title.navi.notice"/></h4>
		</div>
	</div>
	<table class="table_type01 write" summary="게시판">
		<caption>게시판</caption>
	<colgroup>
		<col width="150px;">
		<col width="auto;">
	</colgroup>			
	<tbody>
		<tr>
			<th><label for="notice_subject"><util:message key="ev.info.title"/></label></th>
			<td>
				<input type="text" id="ntc_title" name="ntc_title" value="<c:out value="${noticeVO.title}"/>" class="w_p100"  />
			</td>
		</tr>
		<tr>
			<th><util:message key="eb.info.ttl.noticePeriod"/></th>
		  	<td>
		  		<label for="in_txt_01">
					<input type="text"  id="ntc_startDate" value="<c:out value="${noticeVO.startDateSF}"/>"  class="w100 lm10 datepicker" >
					<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/calendar.png">
				</label>
				&nbsp;~&nbsp;
				<label for="in_txt_02">
					<input type="text" id="ntc_endDate" value="<c:out value="${noticeVO.endDateSF}"/>"  class="w100 lm10 datepicker"/>
					<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/calendar.png">
				</label>
		  	</td>
		</tr>
		<tr>
		  <th><label for="notice_content"><util:message key="cf.title.noticeContent"/></label></th>
		  <td>
		    <div class="bltnCntt" id="dextEditor">
				<div id="editorCntt"></div>
				<input type="hidden" id="set_ntc_content" name="set_ntc_content">
	    		<textarea id="ntc_content" name="ntc_content" style="width:100%;height:120px;display: none;"><c:out value="${noticeVO.contentOrg}"/></textarea>
			</div>
		  </td>
		</tr>
		</tbody>
		</table>
		<div class="board_btn_wrap">				
			<div class="board_btn_wrap_right">
				<a href="#" onclick="javascript:cfOp.bltnMng.processNotice('save')" class="btn black"><util:message key="cf.title.save"/></a>
				<a href="#" onclick="javascript:cfOp.bltnMng.processNotice('del')" class="btn white"><util:message key="ev.info.menu.delete"/></a>
			</div>
		</div>
  </c:if>
<%--END::하단 공지글 상세보기 탭--%> 
