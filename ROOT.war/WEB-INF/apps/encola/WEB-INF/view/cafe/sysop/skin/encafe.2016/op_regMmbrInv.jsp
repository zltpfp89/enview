<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafepanel" style="width:100%;">
  <br style='line-height:5px;'>
  <div>
	<form id="inv_srchForm" name="inv_srchForm" method="POST" onsubmit="return false;">
	  <table width="100%">
	    <tr>
		  <td align="left">
		    <span style="margin:0px 10px 0px 30px"><b>현재 조회수:</b></span><c:out value="${opForm.totalSize}"/>
		  </td>
		  <td align="right">
			<select id="srchType" name="srchType">
			  <c:forEach items="${srchTypeList}" var="srchType">
			    <option value="<c:out value="${srchType.code}"/>" <c:if test="${opForm.srchType==srchType.code}">selected</c:if>><c:out value="${srchType.codeName}"/></option>
			  </c:forEach>
			</select>
			<input type="text" id="rchKey" name="srchKey" value="<c:out value="${opForm.srchKey}"/>"/>
			<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand" onclick="cfOp.regMmbr.search('inv_srchForm')"/>
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
			<%--input type="button" id="all_btnDtlSrch" name="all_btnDtlSrch" value="상세검색" onclick="cfOp.regMmbr.toggleDtlSrchAll()"/--%>
		  </td>
	  </tr>
	  </table>    
	  <input type="hidden" id="cmd" name="cmd" value="inv"/>
	  <input type="hidden" id="sortMethod" name="sortMethod" value="<c:out value="${opForm.sortMethod}"/>"/>
	  <input type="hidden" id="sortColumn" name="sortColumn"/>
	  <input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
	  <input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
	  <input type="hidden" id="pageFunction" name="pageFunction" value="doPage"/>
	  <input type="hidden" id="naviDivNm" name="naviDivNm" value="inv_PAGE_ITERATOR"/>
	</form>
  </div>
  <div class="cafegridpanel">
	<form id="inv_listForm" name="inv_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
		  <tr style="cursor: pointer;">
			<th class="cafegridheader" align="center" width="30px">
			  <input type="checkbox" id="delCheck" onclick="cfOp.m_checkBox.chkAll(this)"/>
			</th>
			<th class="cafegridheader"><span>아 이 디</span></th>
			<th class="cafegridheader"><span>사용자명</span></th>
			<th class="cafegridheader"><span>상    태</span></th>
			<th class="cafegridheaderlast" onclick="cfOp.regMmbr.sort('inv_srchForm','reg_datim')"><span>신 청 일</span>
			  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/<c:if test="${opForm.sortMethod!='ASC'}">tiny_down_arrow.gif</c:if><c:if test="${opForm.sortMethod=='ASC'}">tiny_up_arrow.gif</c:if>" style="margin-left:5px"/></span>
			</th>	
		  </tr>
		</thead>
		<tbody id="inv_listBody">
		<c:forEach items="${mmbrList}" var="mmbr" varStatus="status">
		  <tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="${status.index % 2 != 0}">cafegridline</c:if>"
              onmouseover="ebUtil.activeLine(this,true)" onmouseout="ebUtil.activeLine(this,false)")">
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
		  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr style="cursor:pointer;">
		    <td colspan="100">
			  <span style="margin-left:30px">선택된 회원</span>
			  <c:if test="${cmntVO.regType != 'A'}">
			  <span style="margin-left:10px">
				<input type="button" value="가입승인" onclick="cfOp.regMmbr.checkChangeState('inv','20')"/>
				<input type="button" value="가입거부" onclick="cfOp.regMmbr.checkChangeState('inv','21')"/>
              </span>
			  </c:if>
			  <c:if test="${cmntVO.regType == 'V'}">
			  <span style="margin-left:30px">
				<input type="button" value="초대승인" onclick="cfOp.regMmbr.checkChangeState('inv','22')"/>
				<input type="button" value="초대거부" onclick="cfOp.regMmbr.checkChangeState('inv','23')"/>
			  </span>
			  </c:if>
			</td>
		  </tr>
		</tbody>
	  </table>
	</form>
  </div>
  <div>
	<table style="width:100%;">
	<tr>
	  <td align="center">
		<div id="inv_PAGE_ITERATOR"></div>
	  </td>    
	</tr>
	</table>
  </div>
</div>
