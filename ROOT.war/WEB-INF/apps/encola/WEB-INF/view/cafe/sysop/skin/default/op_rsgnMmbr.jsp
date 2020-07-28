<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafepanel" style="width:100%;">
  <br style='line-height:5px;'>
  <div>
	<form id="rsgn_srchForm" name="rsgn_srchForm" method="POST" onsubmit="return false;">
	  <table width="100%">
	    <tr>
		  <td align="right">
			<select id="srchType" name="srchType">
			  <c:forEach items="${srchTypeList}" var="srchType">
			    <option value="<c:out value="${srchType.code}"/>" <c:if test="${opForm.srchType==srchType.code}">selected</c:if>><c:out value="${srchType.codeName}"/></option>
			  </c:forEach>
			</select>
			<input type="text" id="rchKey" name="srchKey" value="<c:out value="${opForm.srchKey}"/>"/>
			<img src="<%=request.getContextPath()%>/cola/cafe/images/button/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand" onclick="cfOp.rsgnMmbr.search('rsgn_srchForm')"/>
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
			<%--input type="button" id="rsgn_btnDtlSrch" name="rsgn_btnDtlSrch" value="상세검색" onclick="cfOp.rsgnMmbr.toggleDtlSrchAll()"/--%>
		  </td>
	  </tr>
	  </table>    
	  <input type="hidden" id="cmd" name="cmd" value="all"/>
	  <input type="hidden" id="sortMethod" name="sortMethod" value="<c:out value="${opForm.sortMethod}"/>"/>
	  <input type="hidden" id="sortColumn" name="sortColumn"/>
	  <input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
	  <input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
	  <input type="hidden" id="pageFunction" name="pageFunction" value="doPage"/>
	  <input type="hidden" id="naviDivNm" name="naviDivNm" value="rsgn_PAGE_ITERATOR"/>
	</form>
  </div>
  <div class="cafegridpanel">
	<form id="rsgn_listForm" name="rsgn_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
		  <tr style="cursor: pointer;">
			<th class="cafegridheader" align="center" width="30px">
			  <input type="checkbox" id="delCheck" onclick="cfOp.m_checkBox.chkAll(this)"/>
			</th>
			<th class="cafegridheader"><span><c:out value="${cmntVO.nmTypeNm}"/></span></th>
			<th class="cafegridheader"><span>상   태</span></th>
			<th class="cafegridheader" onclick="cfOp.rsgnMmbr.sort('rsgn_srchForm','state_datim')"><span>상태변경일</span>
			  <img src="<%=request.getContextPath()%>/cola/cafe/images/<c:if test="${opForm.sortMethod!='ASC'}">tiny_down_arrow.gif</c:if><c:if test="${opForm.sortMethod=='ASC'}">tiny_up_arrow.gif</c:if>" style="margin-left:5px"/></span>
			</th>	
			<th class="cafegridheaderlast"><span>사    유</span></th>	
		  </tr>
		</thead>
		<tbody id="rsgn_listBody">
		<c:forEach items="${mmbrList}" var="mmbr" varStatus="status">
		  <tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="{$status % 2 != 0}">cafegridline</c:if>"
              onmouseover="ebUtil.activeLine(this,true)" onmouseout="ebUtil.activeLine(this,false)">
			<td align="center" class="cafegrid">
			  <input type="checkbox" id="rsgn_checkRow" name="rsgn_checkRow" value="<c:out value="${mmbr.userId}"/>" stateFlag="<c:out value="${mmbr.stateFlag}"/>" class="cafecheckbox"/>
			</td>
			<td align="left" class="cafegrid">
			  <span style="margin-left:10px">
			    <font style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
                      onclick="cfOp.viewUserDtl('<c:out value="${mmbr.userId}"/>')">
			      <c:if test="${cmntVO.nmType=='A'}"><c:out value="${mmbr.userNick}"/></c:if>
			      <c:if test="${cmntVO.nmType=='I'}"><c:out value="${mmbr.userId}"/></c:if>
			      <c:if test="${cmntVO.nmType=='N'}"><c:out value="${mmbr.nmKor}"/></c:if>
				</font>
			  </span>
			</td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${mmbr.stateFlagNm}"/></span></td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${mmbr.stateDatimPF}"/></span></td>
			<td align="left" class="cafegridlast"><span style="margin-left:10px">
			  <c:if test="${mmbr.stateCode != '99'}"><c:out value="${mmbr.stateCodeNm}"/></c:if>
			  <c:if test="${mmbr.stateCode == '99'}"><c:out value="${mmbr.stateDesc}"/></c:if>
			</span></td>
		  </tr>
		</c:forEach>
		  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr style="cursor:pointer;">
		    <td colspan="100">
			  <span style="margin-left:30px">선택된 회원</span>
			  <span style="margin-left:10px">
				<input type="button" value="활동중지 해제" onclick="cfOp.rsgnMmbr.changeState('rsgn','40')"/>
				<input type="button" value="강제탈퇴 해제" onclick="cfOp.rsgnMmbr.changeState('rsgn','51')"/>
				<%--'자진탈퇴' 회원에 대해 카페지기가 임의로 '가입승인'상태로 바꿀 수 있게 사이트를 운영하는 경우 아래를 풀것.--%>
				<%--input type="button" value="자진탈퇴 해제" onclick="cfOp.rsgnMmbr.changeState('rsgn','50')"/--%>
			  </span>
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
		<div id="rsgn_PAGE_ITERATOR"></div>
	  </td>    
	</tr>
	</table>
  </div>
</div>
