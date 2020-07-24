<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>

<div class="sub_contents">
	<div class="detail">
		<c:if test="${empty aaForm.view}">
			<div id="mngArea" name="mngArea">
		</c:if>
		<c:if test="${empty aaForm.view || aaForm.view == 'list'}">
			<div class="board first">
				<div class="tsearchArea">
					<p style="background: none;"></p>
					<fieldset>
						<form name="frmBTL" method="post" action="" onsubmit="return false">
							<div class="sel_100">
								<select name="srchOrder" class="txt_100">
									<c:forEach items="${orderList}" var="order">
										<option value="<c:out value="${order.code}"/>" <c:if test="${order.code == aaForm.srchOrder}">selected</c:if>><c:out value="${order.codeName}"/>
									</c:forEach>
								</select>
							</div>
							<input type="text" name="srchTableNm" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.title.l.boardTbl"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.title.l.boardTbl"/>');"
								<c:if test="${empty aaForm.srchTableNm}">value="<util:message key="eb.title.l.boardTbl"/>"</c:if><c:if test="${!empty aaForm.srchTableNm}">value="<c:out value="${aaForm.srchTableNm}"/>"</c:if>>
							
							<a href="javascript:admBrdTblMngr.onBrdTblList('list','srch')" class="btn_search">
								<span><util:message key='ev.title.search'/></span>
							</a>
							<input type="hidden" name="pageNo"		value="<c:out value="${aaForm.pageNo}"/>">
							<input type="hidden" name="pageSize"	value="10">
							<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>">
						</form>
					</fieldset>
				</div>
				<table cellpadding=0 cellspacing=0 border=0 class="table_board">
					<colgroup>
						<col width="6%" />
						<col width="*" />
						<col width="28%" />
						<col width="19%" />
					</colgroup>
					<thead>
						<tr>
							<th ch="0" class="first"><util:message key="eb.info.ttl.seq"/></th>
							<th ch="0"><span class="table_title"><util:message key="eb.title.boardTbl"/></span></th>
							<th ch="0"><span class="table_title"><util:message key="eb.title.dataCount"/></span></th>
							<th ch="0"><span class="table_title"><util:message key="eb.title.updateDate"/></span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${tblList}" var="bt" varStatus='status'>
							<tr id='btTr<c:out value="${status.index}"/>'>
								<td class="C"><c:out value="${bt.rnum}"/></td>
								<td class="C">
									<font style='cursor:pointer' onmouseover=this.style.textDecoration='underline' onmouseout=this.style.textDecoration='none'
										onclick="ebUtil.selectTr('btTr',<c:out value="${status.index}"/>);admBrdTblMngr.onBrdTblList('edit','sel','<c:out value="${bt.tblId}"/>');"><c:out value="${bt.tblFix}"/></font>
								</td>
								<td class="C"><c:out value="${bt.rowCnt}"/></td>
								<td class="C"><c:out value="${bt.updDatimPF}"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="brdTblPageIterator">				
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
				<!-- btnArea-->
				<div class="btnArea"> 
					<div class="rightArea">
						<a href="javascript:admBrdTblMngr.onBrdTblList('edit','ins')" class="btn_W"><span><util:message key="ev.title.add"/></span></a>
					</div>
				</div>
				<!-- btnArea//-->
			</div>
			<div id="brdTblArea" class="board">
				
			</div>
		</c:if>
		<c:if test="${empty aaForm.view}">
		</div>
		</c:if>
		
		<c:if test="${aaForm.view == 'edit'}">
			<div class="board first">
				<form name="frmBTE" method="post" action="" onsubmit="return false">
					<table cellpadding=0 cellspacing=0 border=0 class="table_board">
						<colgroup>
							<col width="30%" />
							<col width="70%" />
						</colgroup>
						<c:if test="${aaForm.act != 'ins'}">
						<tr>
							<th clsss="L"><util:message key="ev.title.serialNumber"/></th>
							<td class='L'><c:out value="${brdTblVO.tblId}"/></td>
						</tr>
						</c:if>
						<tr>
							<th class="L"><util:message key="eb.title.boardTbl"/></th>
							<td class="L">
								<c:if test="${aaForm.act == 'ins'}">
								<input type="text" name="tblFix" value="<c:out value="${brdTblVO.tblFix}"/>" id="tblFix" style="width:220px" maxlength=10>
								</c:if>
								<c:if test="${aaForm.act != 'ins'}">
								<c:out value="${brdTblVO.tblFix}"/>
								</c:if>
							</td>
						</tr>
						<tr>
							<th class="L"><util:message key="eb.title.explain"/></th>
							<td class="L">
								<c:if test="${aaForm.act == 'ins'}">
								<input type="text" name="tblDesc" value="<c:out value="${brdTblVO.tblDesc}"/>" id="tblDesc" style="width:440px">
								</c:if>
								<c:if test="${aaForm.act != 'ins'}">
								<c:out value="${brdTblVO.tblDesc}"/>
								</c:if>
							</td>
						</tr>
						<c:if test="${aaForm.act != 'ins'}">
						<tr>
							<th class="L"><util:message key="eb.prop.updUserId"/></th>
							<td class="L"><c:out value="${brdTblVO.updUserId}"/></td>
						</tr>
						<tr>
							<th class="L"><util:message key="eb.title.updateDate"/></th>
							<td class="L"><c:out value="${brdTblVO.updDatimPF}"/></td>
						</tr>
						</c:if>
					</table>
					<!-- btnArea-->
					<div class="btnArea"> 
						<div class="rightArea">
							<a href="javascript:admBrdTblMngr.onBrdTblForm('list')" class="btn_B"><span><util:message key="ev.prop.list"/></span></a>
							<a href="javascript:admBrdTblMngr.onBrdTblForm('save')"" class="btn_B"><span><util:message key="mm.title.save"/></span></a>
						</div>
					</div>
					<!-- btnArea//-->
					<input type="hidden" name="cmd"				 value="<c:out value="${aaForm.cmd}"/>">
					<input type="hidden" name="view"				value="<c:out value="${aaForm.view}"/>">
					<input type="hidden" name="act"				 value="<c:out value="${aaForm.act}"/>">
					<input type="hidden" name="tblId"			 value="<c:out value="${aaForm.tblId}"/>">
					<input type="hidden" name="pageNo"			value="<c:out value="${aaForm.pageNo}"/>">
					<input type="hidden" name="pageSize"		value="10">
					<input type="hidden" name="totalSize"	 value="<c:out value="${aaForm.totalSize}"/>">
					<input type="hidden" name="srchTableNm" value="<c:out value="${aaForm.srchTableNm}"/>">
					<input type="hidden" name="srchOrder"	 value="<c:out value="${aaForm.srchOrder}"/>">
				</form>
			</div>
		</c:if>
	</div>
</div>
<c:if test="${empty aaForm.view}">
<link rel="stylesheet" type="text/css" href="<%=evcp%>/board/css/admin/admin-common.css">
<script type="text/javascript" src="<%=evcp%>/board/javascript/enboard_util.js"></script>
<script type="text/javascript">
AdmBrdTblMngr = function() {
	this.m_contextPath = portalPage.getContextPath();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath (this.m_contextPath);
	this.m_pageNavi = new enview.util.PageNavigationUtil();
}
AdmBrdTblMngr.prototype = {
	m_contextPath : null,
	m_ajax        : null,
	m_pageNavi    : null,
	m_msgBox      : null,

	m_view  : null,
	m_act   : null,
	m_tblId : null,
  
	onBrdTblList : function (view, act, tblId) {

		this.m_view  = view;
		this.m_act   = act;
		this.m_tblId = tblId;

		var frm = document.frmBTL;
		if (frm.srchTableNm.value == '<util:message key="eb.title.l.boardTbl"/>') frm.srchTableNm.value = "";

		var param = "m=uiBrdTblMng";
		param += "&view="+view + "&act="+act + "&tblId="+tblId;
		param = ebUtil.completeParam(frm, param)
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admBrdTblMngr.onBrdTblListHandler(htmlData); }});		
	},
	onBrdTblListHandler : function (htmlData) {
		if (this.m_view == "list") {
			document.getElementById("mngArea").innerHTML = htmlData;
		} else {	
			document.getElementById("brdTblArea").innerHTML = htmlData;
		}

		var frm = document.frmBTL;
		if (frm.srchTableNm.value == "") frm.srchTableNm.value = '<util:message key="eb.title.l.boardTbl"/>';
		
		var pageNo    = frm.pageNo.value;
		var pageSize  = frm.pageSize.value;
		var totalSize = frm.totalSize.value;
		document.getElementById("brdTblPageIterator").innerHTML = this.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "frmBTL", "admBrdTblMngr.doBrdTblPage");		
	},
	doBrdTblPage : function (formName, pageNo) {
		var frm = document.forms[formName];
	    frm.pageNo.value = pageNo;
		admBrdTblMngr.onBrdTblList("list","list");
	},
	onBrdTblForm : function (flag) {
	
		var respText = "";
		var frm = document.frmBTE;
		
		if (flag == "list") { // 목록화면으로
			
			//frm.view.value = "list";
			//frm.act.value  = "list";
			admBrdTblMngr.onBrdTblList("list","list");
			return;
			
		} else if (flag == "save") { // 수정/추가
			
			if (!ebUtil.chkValue (frm.tblFix, '<util:message key="eb.title.o.boardTbl"/>', 'true')) return;
			if (!ebUtil.chkTableName (frm.tblFix, '<util:message key="eb.title.p.boardTbl"/>', 'true')) return;

			frm.view.value = "list";
			if (frm.act.value == "sel") frm.act.value = "upd"; // 조회해서 들어왔으면 수정하러 가는거다..

		} else if (flag == "del") { // 삭제
			
			frm.view.value = "list";
			frm.act.value = "del"; 
		}
		var param = "m=setBrdTbl"
		param = ebUtil.completeParam (frm, param);
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admBrdTblMngr.onBrdTblFormHandler(htmlData); }});
	},
	onBrdTblFormHandler : function (htmlData) {
		admBrdTblMngr.getMsgBox().doShow (ebUtil.getMessage("mm.info.success"));
		//document.getElementById("mngArea").innerHTML = htmlData;
		admBrdTblMngr.onBrdTblForm('list');
	},
	getMsgBox : function() {
		if (this.m_msgBox == null) {
			if (enviewMessageBox == null) {
				enviewMessageBox = new enview.portal.MessageBox(300, 100, 1000);
			}
			this.m_msgBox = enviewMessageBox;
		}
		return this.m_msgBox
	}
}
function initAdmBrdTblMngr() {
	admBrdTblMngr = new AdmBrdTblMngr();
	// 초기 목록 page navigation 표시
	var frm = document.frmBTL;
	var pageNo    = frm.pageNo.value;
	var pageSize  = frm.pageSize.value;
	var totalSize = frm.totalSize.value;
	document.getElementById("brdTblPageIterator").innerHTML = admBrdTblMngr.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "frmBTL", "admBrdTblMngr.doBrdTblPage");			
}
function finishAdmBrdTblMngr() {}

// Attach to the onload event
if (window.attachEvent) {
    window.attachEvent ("onload", initAdmBrdTblMngr);
	window.attachEvent ("onunload", finishAdmBrdTblMngr);
} else if (window.addEventListener ) {
    window.addEventListener ("load", initAdmBrdTblMngr, false);
	window.addEventListener ("unload", finishAdmBrdTblMngr, false);
} else {
    window.onload = initAdmBrdTblMngr;
	window.onunload = finishAdmBrdTblMngr;
}
</script>
</c:if>