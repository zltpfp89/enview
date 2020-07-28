<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enview.codebase.Codebase,com.saltware.enboard.vo.CodebaseVO"%>
<%
	String evcp = request.getContextPath();
	pageContext.setAttribute("userInfo", EnviewSSOManager.getUserInfo(request));
%>

<div class="sub_contents">
	<div class="detail">
		<%--BEGIN::마일리지 내역 관리--%>
		<%--BEGIN::상단 내역 목록만--%>
		<c:if test="${empty amForm.view}">
		<div id="mngArea" name="mngArea" class="adgridpanel">
		</c:if>
		<c:if test="${empty amForm.view || amForm.view == 'list'}">
			<div class="board first">
				<!-- searchArea-->
				<div class="tsearchArea">
					<p style="background: none;"></p>
					<fieldset>
						<form name="frmML" method="post" action="" onsubmit="return false">
							<input type="hidden" id="mileTrIndex" />
							<input type="hidden" name="pageNo"		value="<c:out value="${amForm.pageNo}"/>">
							<input type="hidden" name="pageSize"	value="10">
							<input type="hidden" name="totalSize" value="<c:out value="${amForm.totalSize}"/>">
							<div class="sel_100">
								<select name="srchOrder" class="txt_100">
									<c:forEach items="${orderList}" var="order">
									<option value="<c:out value="${order.code}"/>" <c:if test="${order.code == amForm.srchOrder}">selected</c:if>><c:out value="${order.codeName}"/>
									</c:forEach>
								</select>
							</div>
							
							<input type='text' name='fromYmd' id='fromYmd' value='<c:out value="${amForm.fromYmdF}"/>' class="txt_100 hasDatepicker" maxlength='10'>
							<span class="sel_txt"><img src="<%=evcp%>/board/images/admin/calendar.gif" onclick="displayCalendar(new Date(), 'fromYmd', event)"></span>
							<span class="sel_txt"> ~ </span>
							<input type='text' name='toYmd' id='toYmd' value='<c:out value="${amForm.toYmdF}"/>' class="txt_100 hasDatepicker" maxlength='10'>
							<span class="sel_txt"><img src="<%=evcp%>/board/images/admin/calendar.gif" onclick="displayCalendar(new Date(), 'toYmd', event)"></span>
							
							<div class="sel_100">
								<select name="srchMileSys" class="txt_100">
									<c:forEach items="${sysList}" var="sys">
										<option value="<c:out value="${sys.code}"/>" <c:if test="${sys.code == amForm.srchMileSys}">selected</c:if>><c:out value="${sys.codeName}"/>
									</c:forEach>
								</select>
							</div>
							
							<input type="text" name="srchUserId" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'*사용자ID*');" onblur="ebUtil.whenSrchBlur(this,'*사용자ID*');"
								<c:if test="${empty amForm.srchUserId}">value="*사용자ID*"</c:if><c:if test="${!empty amForm.srchUserId}">value="<c:out value="${amForm.srchUserId}"/>"</c:if>>
							<input type="text" name="srchMileCd" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'*마일리지코드*');" onblur="ebUtil.whenSrchBlur(this,'*마일리지코드*');"
								<c:if test="${empty amForm.srchMileCd}">value="*마일리지코드*"</c:if><c:if test="${!empty amForm.srchMileCd}">value="<c:out value="${amForm.srchMileCd}"/>"</c:if>>
								 
							<a href="javascript:admMileageMngr.onMileageList('list','srch')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
						</form>
					</fieldset>
				</div>
				<!-- searchArea//-->
			
				<%--Begin::list--%>
				<table cellpadding="0" cellspacing="0" border="0" class="table_board">
					<colgroup>
						<col width='6%'/>
						<col width='19%'/>
						<col width='22%'/>
						<col width="*"/>
						<col width='8%'/>
						<col width='8%'/>
						<col width='8%'/>
					</colgroup>
					
					<thead>
					<tr >
						<th class="first"><span class="table_title">순번</span></th>
						<th ><span class="table_title">발생일시</span></th>
						<th ><span class="table_title">사용자 ID</span></th>
						<th ><span class="table_title">마일리지</span></th>
						<th ><span class="table_title">가감</span></th>
						<th ><span class="table_title">발생</span></th>
						<th ><span class="table_title">합계</span></th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${mileList}" var="mile" varStatus='status'>
						<tr id='mileTr<c:out value="${status.index}"/>'	onclick="ebUtil.selectTr('mileTr',<c:out value="${status.index}"/>);admMileageMngr.onMileageList('edit','sel','<c:out value="${mile.userId}"/>','<c:out value="${mile.mileCd}"/>','<c:out value="${mile.mileDatim}"/>');">
							<td class="C"><c:out value="${mile.rnum}"/></td>
							<td class="C"><c:out value="${mile.mileDatimPF}"/></td>
							<td class="C"><c:out value="${mile.userId}"/></td>
							<td class="C"><c:out value="${mile.mileNm}"/>(<c:out value="${mile.mileCd}"/>)</td>
							<td class="C">
								<c:if test="${mile.mileIo == 'I'}">증가</c:if>
								<c:if test="${mile.mileIo == 'O'}">차감</c:if>
							</td>
							<td class="C"><c:out value="${mile.milePntCF}"/></td>
							<td class="C"><c:out value="${mile.mileSumCF}"/></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="mileagePageIterator">				
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
				<!-- btnArea-->
				<div class="btnArea"> 
					<div class="rightArea">
						<a href="javascript:admMileageMngr.onMileageList('edit','ins')" class="btn_W"><span><util:message key='ev.title.add'/></span></a>
					</div>
				</div>
				<!-- btnArea//-->
			</div>
			<div id="mileArea" name="mileArea">
			
			</div>
		</c:if>
		<c:if test="${empty amForm.view}">
		</div>
		</c:if>
		<%--END::상단 내역 목록만--%>
		<%--BEGIN::하단 내역만--%>
		<c:if test="${amForm.view == 'edit'}">
		<div class="board">
		<form name="frmME" method="post" action="" onsubmit="return false">
		<input type="hidden" name="view"				value="<c:out value="${amForm.view}"/>">
		<input type="hidden" name="act"				 value="<c:out value="${amForm.act}"/>">
		<input type="hidden" name="pageNo"			value="<c:out value="${amForm.pageNo}"/>">
		<input type="hidden" name="pageSize"		value="10">
		<input type="hidden" name="totalSize"	 value="<c:out value="${amForm.totalSize}"/>">
		<input type="hidden" name="srchOrder"	 value="<c:out value="${amForm.srchOrder}"/>">
		<input type="hidden" name="fromYmd"		 value="<c:out value="${amForm.fromYmd}"/>">
		<input type="hidden" name="toYmd"			 value="<c:out value="${amForm.toYmd}"/>">
		<input type="hidden" name="srchMileSys" value="<c:out value="${amForm.srchMileSys}"/>">
		<input type="hidden" name="srchUserId"	value="<c:out value="${amForm.srchUserId}"/>">
		<input type="hidden" name="srchMileCd"	value="<c:out value="${amForm.srchMileCd}"/>">
		<input type="hidden" name="srchMileNm"	value="<c:out value="${amForm.srchMileNm}"/>">
		
		<table cellpadding=0 cellspacing=0 border=0 class="table_board">
			<colgroup>
				<col width='140px'/>
				<col width='*'/>
				<col width='140px'/>
				<col width='*'/>
			</colgroup>
			<tr >
				<th class="L">사용자 ID</th>
				
				<c:if test="${amForm.act != 'ins'}">
				<td class="L">
					<c:out value="${mileVO.userId}"/>
					<input type=hidden name=userId id=userId value=<c:out value="${mileVO.userId}"/>>
				</td>
				</c:if>
				
				<c:if test="${amForm.act == 'ins'}">
				<td class="L">
					<input type="text" name="userId" id="userId" class="txt_200" maxlength=30>
				</td>
				</c:if>
				
				<th class="L">발생일시</th>
				
				<c:if test="${amForm.act != 'ins'}">
				<td class="L">
					<c:out value="${mileVO.mileDatimPF}"/>
					<input type=hidden name=mileDatim id=mileDatim value=<c:out value="${mileVO.mileDatim}"/>>
				</td>
				</c:if>
				
				<c:if test="${amForm.act == 'ins'}">
				<td class="L">
					<input type="text" name="mileDatim" id="mileDatim" class="txt_100" maxlength=14>
				</td>
				</c:if>
			</tr>
		
			<tr >
				<th class="L">마일리지 코드</th>
				
				<c:if test="${amForm.act != 'ins'}">
				<td class="L">
					<c:out value="${mileVO.mileCd}"/>
					<input type="hidden" name="mileCd" id="mileCd" value="<c:out value="${mileVO.mileCd}"/>">
				</td>
				</c:if>
				
				<c:if test="${amForm.act == 'ins'}">
				<td class="L">
					<input type="text" name="mileCd" id="mileCd" class="txt_100" maxlength=18>
				</td>
				</c:if>
				
				<th class="L">도메인</tthd>
				<td class="L">
				<select id="domainId" name="domainId" class="selbox" <c:if test="${!(userInfo.hasAdminRole || userInfo.hasManagerRole)}">disabled</c:if> >
					<c:forEach items="${domainList}" var="domain">
					<c:if test="${amForm.act != 'ins'}">
							<option value="<c:out value="${domain.domainId}"/>" <c:if test="${domain.domainId == mileVO.domainId}">selected</c:if>><c:out value="${domain.domainNm}"/>
					</c:if>
					<c:if test="${amForm.act == 'ins'}">
							<option value="<c:out value="${domain.domainId}"/>" <c:if test="${domain.domainId == sessionScope.userDomain.domainId}">selected</c:if>><c:out value="${domain.domainNm}"/>
					</c:if>
					</c:forEach>
				</select>
				</td>
			</tr>
		
			<tr >
				<th class="L">시스템 코드</th>
				<td class="L">
					<select name="mileSys" id="mileSys" class="selbox">
						<c:forEach items="${sysList}" var="list">
							<option value=<c:out value="${list.code}"/> <c:if test="${mileVO.mileSys==list.code}">selected=true</c:if>><c:out value="${list.codeName}"/></option>
						</c:forEach>
					</select>
				</td>
				<th class="L">증가/차감 구분</th>
				<td class="L">
					<c:forEach items="${ioList}" var="list">
						<input type=radio name=mileIo id=mileIo value=<c:out value="${list.code}"/> <c:if test="${mileVO.mileIo==list.code}">checked=true</c:if>>
						<label for="mileIo">&nbsp;<c:out value="${list.codeName}"/>&nbsp;&nbsp;</label>
					</c:forEach>
				</td>
			</tr>
		
			<tr >
				<th class="L">그룹/롤 구분</th>
				<td class="L">
					<c:forEach items="${prinList}" var="prin">
					<input type="radio" name="prinType" id="prinType" value="<c:out value="${prin.code}"/>"
								 <c:if test="${mileVO.prinType==prin.code}">checked=true</c:if>
							 onclick="admMileageMngr.changePrinType()"
					>
					<label for="prinType">&nbsp;<c:out value="${prin.codeName}"/>&nbsp;&nbsp;</label>
					</c:forEach>
				</td>
				<th class="L">그룹/롤/등급 아이디</th>
				<td class="L">
					<input type="text" id="showPrinId" name="showPrinId" value="<c:out value="${mileVO.prinId}"/>" class="" disabled>
					<input type="hidden" id="prinId" name="prinId" value="<c:out value="${mileVO.prinId}"/>">
				</td>
			</tr>
		
			<tr >
				<th class="L">가감 마일리지</th>
				<td class="L">
					<input type=text name=milePnt id=milePnt class="txt_100" maxlength=6 value=<c:out value="${mileVO.milePnt}"/>>
				</td>
				<th class="L">누적 마일리지</th>
				<td class="L">
					<input type="text" name="mileSum" id="mileSum" class="txt_100" maxlength=12 value=<c:out value="${mileVO.mileSum}"/>>
				</td>
			</tr>
		
			<tr >
				<th class="L">통계예비코드1</th>
				<td class="L">
					<input type="text" name="sttsCd1" id="sttsCd1" class="txt_100" maxlength=10 value=<c:out value="${mileVO.sttsCd1}"/>>
				</td>
				<th class="L">통계예비코드2</th>
				<td class="L">
					<input type="text" name="sttsCd2" id="sttsCd2" class="txt_100" maxlength=10 value=<c:out value="${mileVO.sttsCd2}"/>>
				</td>
			</tr>
		
			<tr >
				<th class="L">통계예비코드3</th>
				<td class="L">
					<input type="text" name="sttsCd3" id="sttsCd3" class="txt_100" maxlength=10 value=<c:out value="${mileVO.sttsCd3}"/>>
				</td>
				<th class="L">비고</th>
				<td class="L">
					<input type="text" name="remark" id="remark" class="txt_100per" maxlength=64 value=<c:out value="${mileVO.remark}"/>>
				</td>
			</tr>
			<c:if test="${amForm.act != 'ins'}">
			<tr >
				<th class="L">최종수정자</th>
				<td class="L"><c:out value="${mileVO.updUserId}"/></td>
				<th class="L">최종수정일시</th>
				<td class="L"><c:out value="${mileVO.updDatimPF}"/></td>
			</tr>
			</c:if>
		
		</table>
		<!-- btnArea-->
		<div class="btnArea"> 
			<div class="rightArea">
				<a href="javascript:admMileageMngr.onMileageForm('list')" class="btn_B"><span>목록</span></a>
				<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole 
								|| (userInfo.hasDomainManagerRole && (sessionScope.userDomain.domainId == mileVO.domainId || amForm.act == 'ins'))}">
				<a href="javascript:admMileageMngr.onMileageForm('save')" class="btn_B"><span>저장</span></a>
				<a href="javascript:admMileageMngr.onMileageForm('del')" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
				</c:if>
			</div>
		</div>
		<!-- btnArea//-->
		</form>
		</div>
		</c:if>
		<%--END::하단 내역만--%>
	</div>
</div>
<c:if test="${empty amForm.view}">
<div id="abmRoleChooser" title="<util:message key="eb.title.roleChooser"/>"></div>
<div id="abmGroupChooser" title="<util:message key="eb.title.groupChooser"/>"></div>
<div id="abmGradeChooser" title="<util:message key="eb.title.gradeChooser"/>"></div>
<link rel="stylesheet" type="text/css" href="<%=evcp%>/board/css/admin/admin-common.css">
<link type="text/css" rel="stylesheet" href="<%=evcp%>/board/calendar/css/calendar.css">
<script type="text/javascript" src="<%=evcp%>/board/javascript/enboard_util.js"></script>
<script type="text/javascript" src="<%=evcp%>/board/calendar/calendar.js"></script>
<script type="text/javascript" src="<%=evcp%>/board/calendar/ko-kr/generatecalendar.js"></script>
<script type="text/javascript" src="<%=evcp%>/board/javascript/admin_mile.js"></script>
<script type="text/javascript">
	function initAdmMileageMngr() {
		admMileageMngr = new AdmMileageMngr();
		admMileCdMngr = new AdmMileCdMngr(); // 그룹/롤/등급 선택기를 사용하기 위해 초기화 해준다.
		// 초기 목록 page navigation 표시
		var frm = document.frmML;
		var pageNo		= frm.pageNo.value;
		var pageSize	= frm.pageSize.value;
		var totalSize = frm.totalSize.value;
		document.getElementById("mileagePageIterator").innerHTML = admMileageMngr.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "frmML", "admMileageMngr.doMileagePage");
	}
	function finishAdmMileageMngr() {}

	// Attach to the onload event
	if (window.attachEvent) {
		window.attachEvent ("onload", initAdmMileageMngr);
	window.attachEvent ("onunload", finishAdmMileageMngr);
	} else if (window.addEventListener ) {
		window.addEventListener ("load", initAdmMileageMngr, false);
	window.addEventListener ("unload", finishAdmMileageMngr, false);
	} else {
		window.onload = initAdmMileageMngr;
	window.onunload = finishAdmMileageMngr;
	}
</script>
</c:if>