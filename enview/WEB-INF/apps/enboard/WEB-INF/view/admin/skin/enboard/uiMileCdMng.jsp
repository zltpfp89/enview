<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enview.codebase.Codebase,com.saltware.enboard.vo.CodebaseVO"%>
<%
	String evcp = request.getContextPath();
%>

<%--BEGIN::마일리지 코드 관리--%>
<%--BEGIN::상단 마일리지코드 목록만--%>
<c:if test="${empty amForm.view || amForm.view == 'list'}">
	<!-- board -->
	<div class="board">
		<c:if test="${empty amForm.view}">
			<div id="mngArea" name="mngArea">
		</c:if>
		<!-- searchArea-->
		<div class="tsearchArea">
			<p><util:message key="eb.info.choose.searchMileageCode"/></p>
			<form name="frmMCL" method="post" action="" onsubmit="return false">
				<div class="sel_100">
					<select name="srchOrder" class="txt_100">
						<c:forEach items="${orderList}" var="order">
							<option value="<c:out value="${order.code}"/>" <c:if test="${order.code == amForm.srchOrder}">selected</c:if>><c:out value="${order.codeName}"/>
						</c:forEach>
					</select>
				</div>
				<div class="sel_100">
					<select name="srchMileSys" class="txt_100">
						<c:forEach items="${sysList}" var="sys">
							<option value="<c:out value="${sys.code}"/>" <c:if test="${sys.code == amForm.srchMileSys}">selected</c:if>><c:out value="${sys.codeName}"/>
						</c:forEach>
					</select>
				</div>
				<input type="text" name="srchMileCd" style="width:100;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.mileCd"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.mileCd"/>');"
				<c:if test="${empty amForm.srchMileCd}">value="<util:message key="eb.info.ttl.l.mileCd"/>"</c:if><c:if test="${!empty amForm.srchMileCd}">value="<c:out value="${amForm.srchMileCd}"/>"</c:if>>
				<input type="text" name="srchMileNm" style="width:100;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.mileNm"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.mileNm"/>');"
				<c:if test="${empty amForm.srchMileNm}">value="<util:message key="eb.info.ttl.l.mileNm"/>"</c:if><c:if test="${!empty amForm.srchMileNm}">value="<c:out value="${amForm.srchMileNm}"/>"</c:if>>
			  	<a href="javascript:admMileCdMngr.onMileCdList('list','srch')" class="btn_search"><span><util:message key="ev.title.search"/></span></a>
			  	
			  	<p style="background: none"></p>
			  	<p><util:message key="eb.info.check.MileageCode.policyList"/></p>
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
					<colgroup width='6%'/>
					<colgroup width='17%'/>
					<colgroup width='25%'/>
					<colgroup width='22%'/>
					<colgroup width='11%'/>
					<colgroup width='19%'/>
					<thead>
						<tr>
							<th class="first"><span class="table_title"><util:message key="eb.info.ttl.seq"/></span></th>
							<th class="C"><span class="table_title"><util:message key="eb.title.sysName"/></span></th>
							<th class="C"><span class="table_title"><util:message key="eb.title.mildCd"/></span></th>
							<th class="C"><span class="table_title"><util:message key="eb.title.mildNm"/></span></th>
							<th class="C"><span class="table_title"><util:message key="eb.title.applicationYN"/></span></th>
							<th class="C"><span class="table_title"><util:message key="eb.title.updateDate"/></span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${mcdList}" var="mcd" varStatus='status'>
							<tr id='mcdTr<c:out value="${status.index}"/>' height=22 <c:if test="${mcd.rnum % 2 == 0 }">class='adgridline'</c:if>
							  onclick="ebUtil.selectTr('mcdTr',<c:out value="${status.index}"/>);admMileCdMngr.onMileCdList('edit','sel','<c:out value="${mcd.mileCd}"/>');">
								<td class='C'><c:out value="${mcd.rnum}"/></td>
								<td class='C'><c:out value="${mcd.mileSysNm}"/></td>
								<td class='C'><c:out value="${mcd.mileCd}"/></td>
								<td class='C'><c:out value="${mcd.mileNm}"/></td>
								<td class='C'>
									<c:if test="${mcd.mileActive == 'N'}"><util:message key="eb.prop.mileActive.N"/></c:if>
									<c:if test="${mcd.mileActive == 'Y'}"><util:message key="eb.prop.mileActive.Y"/></c:if>
								</td>
								<td class='C'><c:out value="${mcd.updDatimPF}"/></td>
							</tr>
						</c:forEach>
					</tbody>
					<input type=hidden id=mcdTrIndex name=mcdTrIndex>
				</table>
				<input type="hidden" name="pageNo"    value="<c:out value="${amForm.pageNo}"/>">
				<input type="hidden" name="pageSize"  value="10">
				<input type="hidden" name="totalSize" value="<c:out value="${amForm.totalSize}"/>">				
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div id="mileCdPageIterator" class="paging">
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
				<!-- btnArea-->
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole}">
					<div class="btnArea">
						<div class="rightArea">
							<a href="javascript:admMileCdMngr.onMileCdList('edit','ins')" class="btn_W"><span><util:message key="ev.title.add"/></span></a>
						</div>
					</div>
				</c:if>
				<!-- btnArea// -->							  	
			</form>
		</div>
		<!-- searchArea//-->
		<c:if test="${empty amForm.view}">
			</div>
		</c:if>			
	</div>
	<!-- board// -->
	<c:if test="${empty amForm.view}">
	<div id="mileCdArea"></div>
	</c:if>
</c:if>
<%--END::상단 마일리지코드 목록만--%>
<%--BEGIN::하단에 마일리지 코드 내역만--%>
<c:if test="${amForm.view == 'edit'}">
	<!-- board -->
	<div class="board">
		<!-- searchArea -->
		<div class="tsearchArea">
			<p><util:message key="eb.info.controlMileage.Code"/></p>
		</div>
		<!-- searchArea// -->
		<form name="frmMCE" method="post" action="" onsubmit="return false">
			<input type="hidden" name="view"        value="<c:out value="${amForm.view}"/>">
			<input type="hidden" name="act"         value="<c:out value="${amForm.act}"/>">
			<input type="hidden" name="pageSize"    value="10">
			<input type="hidden" name="totalSize"   value="<c:out value="${amForm.totalSize}"/>">
			<input type="hidden" name="srchOrder"   value="<c:out value="${amForm.srchOrder}"/>">
			<input type="hidden" name="srchMileSys" value="<c:out value="${amForm.srchMileSys}"/>">
			<input type="hidden" name="srchMileCd"  value="<c:out value="${amForm.srchMileCd}"/>">
			<input type="hidden" name="srchMileNm"  value="<c:out value="${amForm.srchMileNm}"/>">		
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
				<colgroup>
					<col width="140px"/> 
					<col width="*"/>
					<col width="140px"/>
					<col width="*"/>
				</colgroup>
				<tr>
					<th class="R"><util:message key="eb.title.mildCd"/></th>
					<c:if test="${amForm.act != 'ins'}">
						<td class="L">
							<c:out value="${mcdVO.mileCd}"/>
							<input type=hidden name=mileCd id=mileCd value=<c:out value="${mcdVO.mileCd}"/>>
						</td>
					</c:if>
					<c:if test="${amForm.act == 'ins'}">
						<td class="R">
							<input type="text" name="mileCd" id="mileCd" class="txt_200" maxlength=18>
						</td>
					</c:if>
					<th class="R"><util:message key="ev.prop.codebase.domain"/></th>
					    <td class="L">
					    <div class="sel_100">
							<select id="domainId" name="domainId" class="txt_100" <c:if test="${!(sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole)}">disabled</c:if> >
								<c:forEach items="${domainList}" var="domain">
									<option value="<c:out value="${domain.domainId}"/>" <c:if test="${domain.domainId == mcdVO.domainId}">selected</c:if>><c:out value="${domain.domainNm}"/>
								</c:forEach>
							</select>
						</div>
					 </td>
				</tr>
				<tr>
					<th class="R"><util:message key="eb.title.mildNm"/></th>
					<td class="L" colspan=3>
						<input type="text" name="mileNm" id="mileNm" class="txt_600" maxlength="30" value="<c:out value="${mcdVO.mileNm}"/>">
					</td>
				</tr>
				<tr>
					<th class="R"><util:message key="eb.title.mileageExplanation"/></th>
					<td class="L" colspan=3>
						<input type="text" name="mileRem" id="mileRem" class="txt_600" maxlength=50 value="<c:out value="${mcdVO.mileRem}"/>">
					</td>
				</tr>
				<tr>
					<th class="R"><util:message key="eb.title.activateYN"/></th>
					<td class="L">
						<c:forEach items="${activeList}" var="list">
							<input type="radio" name="mileActive" id="mileActive" value="<c:out value="${list.code}"/>" <c:if test="${list.code==mcdVO.mileActive}">checked=true</c:if>><c:out value="${list.codeName}"/>&nbsp;&nbsp;
						</c:forEach>
					</td>
					<th class="R"><util:message key="eb.prop.mileSys"/></th>
					<td class="L">
						<div class="sel_100">
							<select name="mileSys" id="mileSys" class="txt_200">
								<c:forEach items="${sysList}" var="list">
									<option value=<c:out value="${list.code}"/> <c:if test="${mcdVO.mileSys==list.code}">selected=true</c:if>><c:out value="${list.codeName}"/></option>
								</c:forEach>
							</select>								
						</div>
					</td>
				</tr>
				<tr>
					<th class="R"><util:message key="eb.info.mileIo"/></th>
					<td class="L">
						<c:forEach items="${ioList}" var="list">
							<input type=radio name=mileIo id=mileIo value=<c:out value="${list.code}"/> <c:if test="${mcdVO.mileIo==list.code}">checked=true</c:if>><c:out value="${list.codeName}"/>&nbsp;&nbsp;
						</c:forEach>
					</td>
					<th class="R"><util:message key="eb.title.decreaseMileage"/></th>
					<td class="L">
						<input type="text" name="milePnt" id="milePnt" class="txt_100" maxlength=6 value=<c:out value="${mcdVO.milePnt}"/>>
					</td>
				</tr>
				<tr>
					<th class="R"><util:message key="eb.title.mileSttg"/></th>
					<td class="L">
						<c:forEach items="${ynList}" var="list">
							<input type=radio name=mileSttg id=mileSttg value=<c:out value="${list.code}"/> <c:if test="${mcdVO.mileSttg==list.code}">checked=true</c:if>><c:out value="${list.codeName}"/>&nbsp;&nbsp;
						</c:forEach>
					</td>
					<th class="R"><util:message key="eb.title.TimesLimit.T"/></th>
					<td class="L">
				  		<input type="text" name="tlimitCnt" id="tlimitCnt" class="txt_100" maxlength=3 value=<c:out value="${mcdVO.tlimitCnt}"/>>
				  	</td>
				</tr>
				<tr>
					<th class="R"><util:message key="eb.title.TimesLimit.D"/></th>
					<td class="L">
						<input type="text" name="dlimitCnt" id="dlimitCnt" class="txt_100" maxlength=3 value=<c:out value="${mcdVO.dlimitCnt}"/>>
					</td>
					<th class="R"><util:message key="eb.title.TimesLimit.W"/></th>
					<td class="L">
						<input type="text" name="wlimitCnt" id="wlimitCnt" class="txt_100" maxlength=3 value=<c:out value="${mcdVO.wlimitCnt}"/>>
					</td>
				</tr>
				<tr>
					<th class="R"><util:message key="eb.title.TimesLimit.M"/></th>
					<td class="L">
						<input type="text" name="mlimitCnt" id="mlimitCnt" class="txt_100" maxlength=3 value=<c:out value="${mcdVO.mlimitCnt}"/>>
					</td>
					<th class="R"><util:message key="eb.title.TimesLimit.Y"/></th>
					<td class="L">
						<input type="text" name="ylimitCnt" id="ylimitCnt" class="txt_100"maxlength=3 value=<c:out value="${mcdVO.ylimitCnt}"/>>
					</td>
				</tr>
				<c:if test="${amForm.act != 'ins'}">
					<tr>
						<th class="R"><util:message key="eb.prop.updUserId"/></th>
						<td class="L"><c:out value="${mcdVO.updUserId}"/></td>
						<th class="R"><util:message key="eb.title.updateDate"/></th>
						<td class="L"><c:out value="${mcdVO.updDatimPF}"/></td>
					</tr>
				</c:if>
			</table>
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:admMileCdMngr.onMileCdForm('list')" class="btn_B"><span><util:message key="ev.prop.list"/></span></a>
				  	<a href="javascript:admMileCdMngr.onMileCdForm('save')" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole}">
						<a href="javascript:admMileCdMngr.onMileCdForm('del')" class="btn_B"><span><util:message key="ev.title.remove"/></span></a>
					</c:if>
				</div>
			</div>
			<!-- btnArea//-->
		</form>	
		<div id="sttgListArea"></div>
	</div>
	<!-- board// -->
</c:if>
<%--END::하단에 마일리지 코드 내역만--%>
<%--BEGIN::하단에 마일리지 정책 목록만--%>
<c:if test="${amForm.view == 'sttgList'}">
	<!-- board -->
	<div class="board">
		<!-- searchArea -->
		<div class="tsearchArea">
			<p><util:message key="eb.info.check.mileagePolicyList.U"/></p>			
		</div>
		<!-- searchArea// -->
	  	<form name="frmMSL" method="post" action="" onsubmit="return false">
			<input type="hidden" name="pageNo"		value="<c:out value="${amForm.pageNo}"/>">
			<input type="hidden" name="pageSize"	value="10">
			<input type="hidden" name="totalSize" value="<c:out value="${amForm.totalSize}"/>">
			<input type="hidden" id="sttgTrIndex" />  	
			
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
				<colgroup>
					<col width="30px" />
					<col width="*" />
					<col width="*" />
					<col width="100px" />
					<col width="100px" />
					<col width="140px" />
				</colgroup>
				<thead>
					<tr>
						<th class="first"><span class="table_title"><util:message key="eb.info.ttl.seq"/></span></th>
						<th class="C"><span class="table_title"><util:message key="eb.prop.prinType"/></span></th>
						<th class="C"><span class="table_title"><util:message key="eb.title.groupRoleGrade"/></span></th>
						<th class="C"><span class="table_title"><util:message key="eb.title.mileage"/></span></th>
						<th class="C"><span class="table_title"><util:message key="eb.title.policyYN"/></span></th>
						<th class="C"><span class="table_title"><util:message key="eb.title.updateDate"/></span></th>
					</tr>
				</thead>
			 	<tbody>
					<c:forEach items="${sttgList}" var="sttg" varStatus='status'>
						<tr id='sttgTr<c:out value="${status.index}"/>' 
							onclick="ebUtil.selectTr('sttgTr',<c:out value="${status.index}"/>);admMileCdMngr.onMileSttgList('sttgEdit','sel','<c:out value="${sttg.mileCd}"/>','<c:out value="${sttg.prinId}"/>');">
							<td class="C"><c:out value="${sttg.rnum}"/></td>
							<td class="C">
								<c:if test="${sttg.prinType == 'G'}"><util:message key="eb.prop.group"/></c:if>
								<c:if test="${sttg.prinType == 'R'}"><util:message key="eb.prop.role"/></c:if>
								<c:if test="${sttg.prinType == 'g'}"><util:message key="eb.prop.grade"/></c:if>
							</td>
							<td class="C"><c:out value="${sttg.prinIdNm}"/>(<c:out value="${sttg.prinId}"/>)</td>
							<td class="C"><c:out value="${sttg.milePnt}"/></td>
							<td class="C">
								<c:if test="${sttg.mileSttg == 'N'}"><util:message key="eb.title.not.exist"/></c:if>
								<c:if test="${sttg.mileSttg == 'Y'}"><util:message key="eb.title.exist"/></c:if>
							</td>
							<td class="C"><c:out value="${sttg.updDatimPF}"/></td>
						</tr>
					</c:forEach>
			 	</tbody>
			</table>	  
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="mileSttgPageIterator" class="paging">
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->	  	
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:admMileCdMngr.onMileSttgList('sttgEdit','ins','<c:out value="${amForm.mileCd}"/>')" class="btn_B"><span><util:message key="eb.prop.add.policy"/></span></a>
				</div>
			</div>
			<!-- btnArea//-->	
		</form>
	</div>
  </form>
  <div id="sttgArea"></div>
</c:if>
<%--END::하단에 마일리지 정책 목록만--%>
<%--BEGIN::하단에 마일리지 정책 내역만--%>
<c:if test="${amForm.view == 'sttgEdit'}">
	<!-- board -->
	<div class="board">
		<!-- searchArea -->
		<div class="tsearchArea">
			<p><util:message key='eb.info.controlMileage.policy'/></p>			
		</div>
		<!-- searchArea// -->
		<form name="frmMSE" method="post" action="" onsubmit="return false">
			<input type="hidden" name="view"			value="<c:out value="${amForm.view}"/>">
			<input type="hidden" name="act"			 value="<c:out value="${amForm.act}"/>">
			<input type="hidden" name="mileCd"		value="<c:out value="${amForm.mileCd}"/>">
			<input type="hidden" name="prinId"		value="<c:out value="${amForm.prinId}"/>">
			<input type="hidden" name="pageNo"		value="<c:out value="${amForm.pageNo}"/>">
			<input type="hidden" name="pageSize"	value="10">
			<input type="hidden" name="totalSize" value="<c:out value="${amForm.totalSize}"/>">		
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
				<colgroup>	
					<col width="150px"/>
					<col width="*"/>
					<col width="150px"/>
					<col width="*"/>
				</colgroup>
				<tr>
			  		<th class="L"><util:message key="eb.title.groupRoleGrade"/></th>
					<td class="L">
						<c:forEach items="${prinList}" var="prin">
							<input type=radio name=prinType id=prinType value=<c:out value="${prin.code}"/>
						    	<c:if test="${sttgVO.prinType==prin.code}">checked=true</c:if>
						    	<c:if test="${amForm.act != 'ins'}">disabled</c:if>
							 	onclick="admMileCdMngr.changePrinType()">
							<c:out value="${prin.codeName}"/>&nbsp;&nbsp;
						</c:forEach>
					</td>
					<th class="L"><util:message key="eb.title.groupRoleGradeId"/></th>
					<td class="L">
						<input type="text" id="showPrinId" name="showPrinId" class="txt_100" value="<c:out value="${sttgVO.prinId}"/>" disabled>
					</td>
				</tr>
				<tr>
					<th class="L"><util:message key="eb.title.decreaseMileage"/></th>
					<td class="L" colspan="3">
						<input type="text" name="milePnt" id="milePnt" class="txt_100" maxlength=6 value=<c:out value="${sttgVO.milePnt}"/>>
					</td>
				</tr>
				<tr>
					<th class="L"><util:message key="eb.title.mileSttg"/></th>
					<td class="L">
						<c:forEach items="${ynList}" var="list">
							<input type=radio name=mileSttg id=mileSttg value=<c:out value="${list.code}"/> <c:if test="${sttgVO.mileSttg==list.code}">checked=true</c:if>>
							<c:out value="${list.codeName}"/>&nbsp;&nbsp;
						</c:forEach>
					</td>
					<th class="L"><util:message key="eb.title.TimesLimit.T"/></th>
					<td class="L">
				  		<input type="text" name="tlimitCnt" id="tlimitCnt" class="txt_100" maxlength=3 value=<c:out value="${sttgVO.tlimitCnt}"/>>
				  	</td>
				</tr>
				<tr>
					<th class="L"><util:message key="eb.title.TimesLimit.D"/></th>
					<td class="L">
						<input type="text" name="dlimitCnt" id="dlimitCnt" class="txt_100" maxlength=3 value=<c:out value="${sttgVO.dlimitCnt}"/>>
					</td>
					<th class="L"><util:message key="eb.title.TimesLimit.W"/></th>
					<td class="L">
				  		<input type="text" name="wlimitCnt" id="wlimitCnt" class="txt_100" maxlength=3 value=<c:out value="${sttgVO.wlimitCnt}"/>>
				  	</td>
				</tr>
				<tr>
					<th class="L"><util:message key="eb.title.TimesLimit.M"/></th>
					<td class="L">
						<input type="text" name="mlimitCnt" id="mlimitCnt" class="txt_100" maxlength=3 value=<c:out value="${sttgVO.mlimitCnt}"/>>
					</td>
					<th class="L"><util:message key="eb.title.TimesLimit.Y"/></th>
					<td class="L">
						<input type="text" name="ylimitCnt" id="ylimitCnt" class="txt_100" maxlength=3 value=<c:out value="${sttgVO.ylimitCnt}"/>>
					</td>
				</tr>
			   	<c:if test="${amForm.act != 'ins'}">
					<tr>
						<th class="L"><util:message key="eb.prop.updUserId"/></th>
						<td class="L"><c:out value="${sttgVO.updUserId}"/></td>
						<th class="L"><util:message key="eb.title.updateDate"/></th>
						<td class="L"><c:out value="${sttgVO.updDatimPF}"/></td>
					</tr>
			   	</c:if>
			</table>
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
				  <a href="javascript:admMileCdMngr.onMileSttgForm('list')" class="btn_B"><span><util:message key="ev.prop.list"/></span></a>
				  <a href="javascript:admMileCdMngr.onMileSttgForm('save')" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
				  <a href="javascript:admMileCdMngr.onMileSttgForm('del')" class="btn_B"><span><util:message key="ev.title.remove"/></span></a>
				</div>
			</div>
			<!-- btnArea//-->		 
		</form>		
	</div>
	<!-- board// -->
</c:if>
<%--END::하단에 마일리지 정책 내역만--%>
<%--BEGIN::사용자/그룹/롤 선택 팝업 화면 부분--%>
<c:if test="${amForm.view == 'chooseList'}">
	<c:if test="${amForm.act == 'role'}">
		<!-- board -->
		<div class="board">
			<!-- searchArea -->
			<div class="tsearchArea">
				<p style="background: none;"></p>
				<fieldset>
					<form id="abmRoleChooserForm" style="display:inline" name="abmRoleChooserForm" action="" method="post" onsubmit="return false;" onkeydown="if(event.keyCode==13) admMileCdMngr.getRoleChooser().doSearch();">
						<input type='hidden' name='totalSize' value="<c:out value="${amForm.totalSize}"/>"/>
						<input type="text" name="srchShortPath" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.roleId"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.roleId"/>');"
					    <c:if test="${empty amForm.srchShortPath}">value="<util:message key="eb.info.ttl.l.roleId"/>"</c:if><c:if test="${!empty amForm.srchShortPath}">value="<c:out value="${amForm.srchShortPath}"/>"</c:if>>
						<input type="text" name="srchPrincipalName" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.roleNm"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.roleNm"/>');"
					    <c:if test="${empty amForm.srchPrincipalName}">value="<util:message key="eb.info.ttl.l.roleNm"/>"</c:if><c:if test="${!empty amForm.srchPrincipalName}">value="<c:out value="${amForm.srchPrincipalName}"/>"</c:if>>
						<a href="javascript:admMileCdMngr.getRoleChooser().doSearch()" class="btn_search"><span>검색</span></a>
					</form>				
				</fieldset>
			</div>
			<!-- searchArea// -->
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<colgroup>
					<col width="30px"/>
					<col width="100px"/>
					<col width="*"/>
					<col width="*"/>
				</colgroup>			
				<thead>
					<tr>
						<th class="first"><span class="table_title"></span></th>
						<th class="C" ch="0"><span class="table_title"><util:message key="ev.prop.securityUserRole.roleId"/></span></th>
						<th class="C" ch="0"><span class="table_title"><util:message key="ev.prop.o.roleName"/></span></th>
						<th class="C" ch="0"><span class="table_title"><util:message key="eb.title.explain"/></span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${roleList}" var="role" varStatus="status">
						<tr>
							<td class="C">
								<input type="checkbox" id="roleChooser_checkRow_<c:out value="${status.index}"/>" name="roleChooser_checkRow" value="<c:out value="${role.code}"/>">
							</td>
							<td class="L" onclick="admMileCdMngr.getRoleChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${role.code}"/></td>
							<td class="L" onclick="admMileCdMngr.getRoleChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${role.codeName}"/></td>
							<td class="L" onclick="admMileCdMngr.getRoleChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${role.remark}"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="abmRoleChooserPageIterator">				
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
		</div>
		<!-- board// -->
	</c:if>
	<c:if test="${amForm.act == 'group'}">
		<!-- board -->
		<div class="board">
			<!-- searchArea -->
			<div class="tsearchArea">
				<p style="background: none;"></p>
				<fieldset>
					<form id="abmGroupChooserForm" style="display:inline" name="abmGroupChooserForm" action="" method="post" onsubmit="return false;" onkeydown="if(event.keyCode==13) admMileCdMngr.getGroupChooser().doSearch()">
						<input type='hidden' name='totalSize' value="<c:out value="${amForm.totalSize}"/>"/>
						<input type="text" name="srchShortPath" style="width:120;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.groupId"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.groupId"/>');"
					 		<c:if test="${empty amForm.srchShortPath}">value="<util:message key="eb.info.ttl.l.groupId"/>"</c:if><c:if test="${!empty amForm.srchShortPath}">value="<c:out value="${amForm.srchShortPath}"/>"</c:if>>
						<input type="text" name="srchPrincipalName" style="width:160;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.groupNm"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.groupNm"/>');"
					 		<c:if test="${empty amForm.srchPrincipalName}">value="<util:message key="eb.info.ttl.l.groupNm"/>"</c:if><c:if test="${!empty amForm.srchPrincipalName}">value="<c:out value="${amForm.srchPrincipalName}"/>"</c:if>>
						<a href="javascript:admMileCdMngr.getGroupChooser().doSearch()" class="btn_search"><span>검색</span></a>
					</form>				
				</fieldset>
			</div>
			<!-- searchArea// -->
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<colgroup>
					<col width="30px"/>
					<col width="100px"/>
					<col width="*"/>
					<col width="*"/>
				</colgroup>			
				<thead>
					<tr>
						<th class="first"><span class="table_title"></span></th>
						<th class="C" ch="0"><span class="table_title"><util:message key="ev.title.statistics.groupId"/></span></th>
						<th class="C" ch="0"><span class="table_title">><util:message key="ev.title.o.groupName"/><</span></th>
						<th class="C" ch="0"><span class="table_title"><util:message key="eb.title.explain"/></span></th>
					</tr>
				</thead>
			 	<tbody>
					<c:forEach items="${groupList}" var="group" varStatus="status">
						<tr>
							<td class='C'>
								<input type="checkbox" id="groupChooser_checkRow_<c:out value="${status.index}"/>" name="groupChooser_checkRow" value="<c:out value="${group.code}"/>">
							</td>
							<td class='L' onclick="admMileCdMngr.getGroupChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${group.code}"/></td>
							<td class='L' onclick="admMileCdMngr.getGroupChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${group.codeName}"/></td>
							<td class='L' onclick="admMileCdMngr.getGroupChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${group.remark}"/></td>
						</tr>
					</c:forEach>
			 	</tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="abmGroupChooserPageIterator">				
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->					
		</div>
		<!-- board -->
	</c:if>
	<c:if test="${amForm.act == 'grade'}">
		<!-- board -->
		<div class="board">
			<!-- searchArea -->
			<div class="tsearchArea">
				<p style="background: none;"></p>
				<fieldset>
					<form id="abmGradeChooserForm" style="display:inline" name="abmGradeChooserForm" action="" method="post" onsubmit="return false;"  onkeydown="if(event.keyCode==13) admMileCdMngr.getGradeChooser().doSearch();">
						<input type='hidden' name='totalSize' value="<c:out value="${amForm.totalSize}"/>"/>
						<input type="text" name="srchShortPath" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.id"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.id"/>');"
					    	<c:if test="${empty amForm.srchShortPath}">value="<util:message key="eb.info.ttl.l.id"/>"</c:if><c:if test="${!empty amForm.srchShortPath}">value="<c:out value="${amForm.srchShortPath}"/>"</c:if>>
						<input type="text" name="srchPrincipalName" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.name"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.name"/>');"
					      	<c:if test="${empty amForm.srchPrincipalName}">value="<util:message key="eb.info.ttl.l.name"/>"</c:if><c:if test="${!empty amForm.srchPrincipalName}">value="<c:out value="${amForm.srchPrincipalName}"/>"</c:if>>
						<a href="javascript:admMileCdMngr.getGradeChooser().doSearch()" class="btn_search"><span>검색</span></a>
					</form>				
				</fieldset>
			</div>
			<!-- searchArea// -->
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<colgroup>
					<col width="30px"/>
					<col width="100px"/>
					<col width="*"/>
					<col width="*"/>
				</colgroup>				
				<thead>
					<tr>
					  <th class="first"><span class="table_title"></span></th>
					  <th class="C" ch="0"><span class="table_title"><util:message key="eb.title.gradeID"/></span></th>
					  <th class="C" ch="0"><span class="table_title"><util:message key="eb.title.gradeNm"/></span></th>
					  <th class="C" ch="0"><span class="table_title"><util:message key="eb.title.explain"/></span></th>
					</tr>
				</thead>
			 	<tbody>
					<c:forEach items="${gradeList}" var="grade" varStatus="status">
						<tr>
							<td class="C">
								<input type="checkbox" id="gradeChooser_checkRow_<c:out value="${status.index}"/>" name="gradeChooser_checkRow" value="<c:out value="${grade.code}"/>">
							</td>
							<td class="L" onclick="admMileCdMngr.getGradeChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${grade.code}"/></td>
							<td class="L" onclick="admMileCdMngr.getGradeChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${grade.codeName}"/></td>
							<td class="L" onclick="admMileCdMngr.getGradeChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${grade.remark}"/></td>
						</tr>
					</c:forEach>
			 	</tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="abmGradeChooserPageIterator">				
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->						
		</div>	
		<!-- board// -->
	</c:if>
</c:if>
<%--END::사용자/그룹/롤 선택 팝업 화면 부분--%>

<c:if test="${empty amForm.view}">
	<div id="abmRoleChooser" title="<util:message key="eb.title.roleChooser"/>"></div>
	<div id="abmGroupChooser" title="<util:message key="eb.title.groupChooser"/>"></div>
	<div id="abmGradeChooser" title="<util:message key="eb.title.gradeChooser"/>"></div>
	<link rel="stylesheet" type="text/css" href="<%=evcp%>/board/css/admin/admin-common.css">
	<script type="text/javascript" src="<%=evcp%>/board/javascript/enboard_util.js"></script>
	<script type="text/javascript" src="<%=evcp%>/board/javascript/admin_mile.js"></script>
	<script type="text/javascript">
	  function initAdmMileCdMngr() {
		admMileCdMngr = new AdmMileCdMngr();
		// 초기 목록 page navigation 표시
		var frm = document.frmMCL;
		var pageNo    = frm.pageNo.value;
		var pageSize  = frm.pageSize.value;
		var totalSize = frm.totalSize.value;
		document.getElementById("mileCdPageIterator").innerHTML = admMileCdMngr.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "frmMCL", "admMileCdMngr.doMileCdPage");			
	  }
	  function finishAdmMileCdMngr() {}
	
	  // Attach to the onload event
	  if (window.attachEvent) {
	    window.attachEvent ("onload", initAdmMileCdMngr);
		window.attachEvent ("onunload", finishAdmMileCdMngr);
	  } else if (window.addEventListener ) {
	    window.addEventListener ("load", initAdmMileCdMngr, false);
		window.addEventListener ("unload", finishAdmMileCdMngr, false);
	  } else {
	    window.onload = initAdmMileCdMngr;
		window.onunload = finishAdmMileCdMngr;
	  }
	</script>
</c:if>
