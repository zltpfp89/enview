<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafepanel" style="width:100%;">
  <br style='line-height:5px;'>
  <div>
	<form id="all_srchForm" name="all_srchForm" method="POST" onsubmit="return false;">
	  <table width="100%">
	    <tr>
		  <td align="left">
		    <span style="margin:0px 10px 0px 30px"><b>총 회원수:</b></span><c:out value="${cmntVO.mmbrTotCF}"/>
		    <span style="margin:0px 10px 0px 30px"><b>현재 조회수:</b></span><c:out value="${opForm.totalSize}"/>
		  </td>
		  <td align="right">
			<select id="srchType" name="srchType">
			  <c:forEach items="${srchTypeList}" var="srchType">
			    <option value="<c:out value="${srchType.code}"/>" <c:if test="${opForm.srchType==srchType.code}">selected</c:if>><c:out value="${srchType.codeName}"/></option>
			  </c:forEach>
			</select>
			<input type="text" id="srchKey" name="srchKey" value="<c:out value="${opForm.srchKey}"/>"/>
			<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand" onclick="cfOp.regMmbr.search('all_srchForm')"/>
			<select id="srchGrd" name="srchGrd">
			  <c:forEach items="${srchGrdList}" var="srchGrd">
			    <option value="<c:out value="${srchGrd.code}"/>" <c:if test="${opForm.srchGrd==srchGrd.code}">selected</c:if>><c:out value="${srchGrd.codeName}"/></option>
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
	  <input type="hidden" id="cmd" name="cmd" value="all"/>
	  <input type="hidden" id="sortMethod" name="sortMethod" value="<c:out value="${opForm.sortMethod}"/>"/>
	  <input type="hidden" id="sortColumn" name="sortColumn"/>
	  <input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
	  <input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
	  <input type="hidden" id="pageFunction" name="pageFunction" value="cfOp.regMmbr.doPage"/>
	  <input type="hidden" id="naviDivNm" name="naviDivNm" value="all_PAGE_ITERATOR"/>
	</form>
  </div>
  <div class="cafegridpanel">
	<form id="all_listForm" name="all_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
		  <tr style="cursor: pointer;">
			<th class="cafegridheader" align="center" width="30px">
			  <input type="checkbox" id="delCheck" class="cafecheckbox" onclick="cfOp.m_checkBox.chkAll(this)"/>
			</th>
			<th class="cafegridheader"><span><c:out value="${cmntVO.nmTypeNm}"/></span></th>
			<th class="cafegridheader"><span>회원등급</span></th>
			<th class="cafegridheader" onclick="cfOp.regMmbr.sort('all_srchForm','a.reg_datim')"><span>가입일</span>
			  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/<c:if test="${opForm.sortMethod!='ASC'}">tiny_down_arrow.gif</c:if><c:if test="${opForm.sortMethod=='ASC'}">tiny_up_arrow.gif</c:if>" style="margin-left:5px"/></span>
			</th>	
			<th class="cafegridheader" onclick="cfOp.regMmbr.sort('all_srchForm','last_access')"><span>최종방문일</span>
			  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/<c:if test="${opForm.sortMethod!='ASC'}">tiny_down_arrow.gif</c:if><c:if test="${opForm.sortMethod=='ASC'}">tiny_up_arrow.gif</c:if>" style="margin-left:5px"/></span>
			</th>	
			<th class="cafegridheader" onclick="cfOp.regMmbr.sort('all_srchForm','visit_cnt')"><span>방문횟수</span>
			  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/<c:if test="${opForm.sortMethod!='ASC'}">tiny_down_arrow.gif</c:if><c:if test="${opForm.sortMethod=='ASC'}">tiny_up_arrow.gif</c:if>" style="margin-left:5px"/></span>
			</th>	
			<th class="cafegridheaderlast" onclick="cfOp.regMmbr.sort('all_srchForm','bltn_cnt')"><span>게시글수</span>
			  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/<c:if test="${opForm.sortMethod!='ASC'}">tiny_down_arrow.gif</c:if><c:if test="${opForm.sortMethod=='ASC'}">tiny_up_arrow.gif</c:if>" style="margin-left:5px"/></span>
			</th>	
		  </tr>
		</thead>
		<tbody id="all_listBody">
		<c:forEach items="${mmbrList}" var="mmbr" varStatus="status">
		  <tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="{$status % 2 != 0}">cafegridline</c:if>"
              onmouseover="ebUtil.activeLine(this,true)" onmouseout="ebUtil.activeLine(this,false)")">
			<td align="center" class="cafegrid">
			  <input type="checkbox" id="all_checkRow" name="all_checkRow" class="cafecheckbox" value="<c:out value="${mmbr.userId}"/>"
					 stateFlag="<c:out value="${mmbr.stateFlag}"/>" mmbrGrd="<c:out value="${mmbr.mmbrGrd}"/>"/>
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
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${mmbr.mmbrGrdNm}"/></span></td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${mmbr.regDatimPF}"/></span></td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${mmbr.lastAccessPF}"/></span></td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${mmbr.visitCntCF}"/></span></td>
			<td align="left" class="cafegridlast"><span style="margin-left:10px"><c:out value="${mmbr.bltnCntCF}"/></span></td>
		  </tr>
		</c:forEach>
		  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr style="cursor:pointer;">
		    <td colspan="100">
			  <span style="margin-left:30px">선택된 회원</span>
			  <span style="margin-left:10px">
				<select id="all_changeGrd" name="all_changeGrd">
				  <c:forEach items="${changeGrdList}" var="changeGrd">
					<option value="<c:out value="${changeGrd.code}"/>" <c:if test="${opForm.changeGrd==changeGrd.code}">selected</c:if>><c:out value="${changeGrd.codeName}"/></option>
				  </c:forEach>
				</select>
				<span class="btn_pack small">
					<a href="#" onclick="javascript:cfOp.regMmbr.changeGrade('all')">변경</a>
				</span>
			  </span>
			  <span style="margin-left:30px">
			  	 <span class="btn_pack small">
					<a href="#" onclick="javascript:cfOp.regMmbr.checkChangeState('all','40')">활동중지</a>
				</span>
				 <span class="btn_pack small">
					<a href="#" onclick="javascript:cfOp.regMmbr.checkChangeState('all','51')">강제탈퇴</a>
				</span>
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
		<div id="all_PAGE_ITERATOR"></div>
	  </td>    
	</tr>
	</table>
  </div>
</div>
