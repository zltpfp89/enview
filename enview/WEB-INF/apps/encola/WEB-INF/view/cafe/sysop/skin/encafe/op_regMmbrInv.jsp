<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="board_btn_wrap">
	<form id="inv_srchForm" name="inv_srchForm" method="POST" onsubmit="return false;">
	<div class="board_btn_wrap_left">
		<util:message key="cf.title.mmbrCnt"/> : <strong class="font_blue rm30"><c:out value="${cmntVO.mmbrTotCF}"/></strong>
		<util:message key='cf.title.currentViews'/> : <strong class="font_blue"><c:out value="${opForm.totalSize}"/></strong>
	</div>
	<div class="board_btn_wrap_right">
			<fieldset>
				<legend>검색</legend>
				<select id="srchType" name="srchType">
				  <c:forEach items="${srchTypeList}" var="srchType">
				    <option value="<c:out value="${srchType.code}"/>" <c:if test="${opForm.srchType==srchType.code}">selected</c:if>><c:out value="${srchType.codeName}"/></option>
				  </c:forEach>
				</select>
				<div>
					<label for="search" class="none">검색어입력</label>
					<input type="text" id="rchKey" name="srchKey" value="<c:out value="${opForm.srchKey}"/>"/>
					<label for="search_submin"></label>
					<input type="submit" value="<util:message key='eb.title.search'/>" class="" id="search_submin" onclick="cfOp.regMmbr.search('inv_srchForm')"/>
				</div>
			<select id="srchState" name="srchState">
			  <c:forEach items="${srchStateList}" var="srchState">
			    <option value="<c:out value="${srchState.code}"/>" <c:if test="${opForm.srchState==srchState.code}">selected</c:if>><c:out value="${srchState.codeName}"/></option>
			  </c:forEach>
			</select>
				<select id="pageSize" name="pageSize">
				  <c:forEach items="${pageSizeList}" var="pageSize">
				    <option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
				  </c:forEach>
				</select>
			</fieldset>
			<input type="hidden" id="cmd" name="cmd" value="inv"/>
		    <input type="hidden" id="sortMethod" name="sortMethod" value="<c:out value="${opForm.sortMethod}"/>"/>
		    <input type="hidden" id="sortColumn" name="sortColumn"/>
		    <input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
		    <input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
		    <input type="hidden" id="pageFunction" name="pageFunction" value="doPage"/>
		    <input type="hidden" id="naviDivNm" name="naviDivNm" value="inv_PAGE_ITERATOR"/>
		</form>
	</div>
</div>
	<form id="inv_listForm" name="inv_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
<table class="table_type01 " summary="게시판">
		<thead>
		  <tr style="cursor: pointer;">
			<th class="cafegridheader" align="center" width="30px">
			  <input type="checkbox" id="delCheck" onclick="cfOp.m_checkBox.chkAll(this)"/>
			</th>
			<th class="cafegridheader"><span><util:message key="mm.title.id"/></span></th>
			<th class="cafegridheader"><span><util:message key="ev.title.user.Username"/></span></th>
			<th class="cafegridheader"><span><util:message key="ev.prop.batchResult.status"/></span></th>
			<th class="cafegridheaderlast" onclick="cfOp.regMmbr.sort('inv_srchForm','reg_datim')"><span><util:message key="cf.title.applicationDate"/></span>
					<c:if test="${opForm.sortColumn=='reg_datim' and opForm.sortMethod=='ASC'}">
				 		<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tiny_up_arrow.gif" style="margin-left:5px;margin-top:7px"/>
				 	</c:if>
					<c:if test="${opForm.sortColumn=='reg_datim' and opForm.sortMethod=='DESC'}">
				 		<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tiny_down_arrow.gif" style="margin-left:5px;margin-top:7px"/>
				 	</c:if>
			</th>	
		  </tr>
		</thead>
		<tbody id="inv_listBody">
		<c:if test="${empty mmbrList}">
		<tr><td colspan="5"> <util:message key="cf.prop.not.exist.data"/></td>
		</tr>
		</c:if>
		<c:forEach items="${mmbrList}" var="mmbr" varStatus="status">
		  <tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="${status.index % 2 != 0}">cafegridline</c:if>">
			<td align="center" class="cafegrid">
			  <input type="checkbox" id="inv_checkRow" name="inv_checkRow" value="<c:out value="${mmbr.userId}"/>"
					 stateFlag="<c:out value="${mmbr.stateFlag}"/>" mmbrGrd="<c:out value="${mmbr.mmbrGrd}"/>"/>
			</td>
			<td align="left" class="cafegrid">
			  <span style="margin-left:10px">
			    <font style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
                      onclick="cfOp.viewUserDtl('<c:out value="${mmbr.userId}"/>')">
			      <c:out value="${mmbr.userId}"/>
				</font>
			  </span>
			</td>
			<td align="left" class="cafegrid">
			  <span style="margin-left:10px">
			    <font style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
                      onclick="cfOp.regMmbr.selectMmbr('inv','<c:out value="${mmbr.userId}"/>')">
			      <c:out value="${mmbr.nmKor}"/>
				</font>
			  </span>
			</td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${mmbr.stateFlagNm}"/></span></td>
			<td align="left" class="cafegridlast"><span style="margin-left:10px"><c:out value="${mmbr.regDatimPF}"/></span></td>
		  </tr>
		</c:forEach>
		</tbody>
	  </table>
	</form>
  <div>
	<table style="width:100%;">
	<tr>
	  <td align="center">
		<div id="inv_PAGE_ITERATOR"></div>
	  </td>    
	</tr>
	</table>
  </div>
  
  
<div class="board_btn_wrap tp30">
	<div class="board_btn_wrap_left">
		  <string><util:message key="cf.title.selectedMember"/></strong>
		  <c:if test="${cmntVO.regType != 'A'}">
		  	<a href="#" onclick="javascript:cfOp.regMmbr.checkChangeState('inv','20')" class="btn white"><util:message key="cf.title.joinApproval"/></a>
		  	<a href="#" onclick="javascript:cfOp.regMmbr.checkChangeState('inv','21')" class="btn white"><util:message key="cf.title.joinRefuse"/></a>
		  </c:if>
		  <c:if test="${cmntVO.regType == 'V'}">
		  	<a href="#" onclick="javascript:cfOp.regMmbr.checkChangeState('inv','22')" class="btn white"><util:message key="cf.title.invitationApproval"/></a>
		  	<a href="#" onclick="javascript:cfOp.regMmbr.checkChangeState('inv','23')" class="btn white"><util:message key="cf.title.invitationRefuse"/></a>
		  </c:if>
	</div>
</div>
