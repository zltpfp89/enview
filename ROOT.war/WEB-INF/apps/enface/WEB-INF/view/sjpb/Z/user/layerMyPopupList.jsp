<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setAttribute("cPath", request.getContextPath());
%>
<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.js"></script>
<script type="text/javascript"src="${cPath}/sjpb/js/Z/jquery-ui-1.10.3.js"></script>
<script type="text/javascript" src="${cPath}/sjpb/js/Z/common.js"></script>
<script type="text/javascript" src="${cPath}/sjpb/js/Z/main.js"></script>
<script type="text/javascript"src="${cPath }/javascript/jstree/jstree.min.js"></script>

<link rel="stylesheet" type="text/css"href="${cPath}/sjpb//css/popup.css" />
<link rel="stylesheet" type="text/css"href="${cPath}/sjpb//css/contents.css" />
<link rel="stylesheet" type="text/css"href="${cPath}/sjpb//css/sjpb_custom.css" />
<link rel="stylesheet"href="${cPath }/javascript/jstree/themes/default/style.min.css" />
<script src="${cPath }/javascript/jstree/jstree.min.js"></script>
<script type="text/javascript">
   	function fn_ajaxSuccess(data) {
   		var html = "";
   		var chkType = "${ empty param.chkType ? 'checkbox' : param.chkType }";
   		
   		if (data.status == "SUCCESS") {
   			if (data.data.length > 0) {
   				//사번,이름,부서코드,부서명,직급,직위
   				$(data.data).each(function () {
   		    		html += "<tr>";
   		    		<c:if test="${not empty param.chkType }">
   		    		html += "  <td class=\"C\">";
	    			html += "		<label for=\"" + this.userId + "\"></label><input type=\"" + chkType + "\" name=\"srchChkValue\" id=\"" + this.userId + "\""; 
	  		    	html += " value=\"" + this.userId + "|" + this.nmKor + "|" + this.orgCd + "|" + this.orgName + "|"  + this.criMbPosiNm + "\" />";
   		    		html += "	</td>";
   		    		</c:if>
   		    		
   		    		html += "	<td class=\"C\">" + this.nmKor + "</td>";
   		    		html += "	<td class=\"C\">" + this.criMbPosiNm + "</td>";
   		    		html += "	<td class=\"C\">" + this.orgName + "</td>";
   		    		html += "</tr>";
   				});
   			} else {
				html += "<tr>";
				<c:if test="${not empty param.chkType }">
					html += "	<td class=\"C\" colspan='4'>";
				</c:if>
				<c:if test="${empty param.chkType }">
					html += "	<td class=\"C\" colspan='3'>";
				</c:if>
				html += "		조회된 데이터가 없습니다.";
				html += "	</td>";
				html += "</tr>";
   			}
   		} else {
			html += "<tr>";
			html += "	<td class=\"C\" colspan='3'>";
			html += "		조회된 데이터가 없습니다.";
			html += "	</td>";
			html += "</tr>";
		}
   		
   		$("#dataTable").html(html);
   	}
   	
   	function fn_ajaxError(data) {
   		//console.log(data)
   	}
   	
   	function fn_searchAjax() {
   		
   		$("#usrDeptCd").val("");
   		
   		var param = $("#userSearchForm").serialize();
   		fn_ajax({
   			url : "${cPath}/sjpb/Z/selectUserListForJson.face"
   			, param : param
   		});
   	}
   	
   	function fn_drawTree(text) {
   		

		
   		var param = (text=='' || text==null ) ? {} : { text : text};
   		$("#deptTree").jstree('destroy');
		$('#deptTree').jstree({
			'core' : {
				'data' : {
					url : "${cPath}/sjpb/Z/selectMyDeptTree.face",
					data : param, 
					type : "post",
					dataType : "json"
				},
				"multiple" : false,
				"animation" : 0
			},
			"search": {
	            "case_insensitive": true,
	            "show_only_matches" : true
	        },
		    "plugins": ["search"]
		}).on("select_node.jstree", function (e, data) {
			var orgCd = $('#deptTree').jstree(true).get_selected()[0];
	   		if (isDefined(orgCd)) {
				$("#orgCd").val(orgCd);
				var param = $("#userTreeSearchForm").serialize();
		   		fn_ajax({
		   			url : "${cPath}/sjpb/Z/selectUserListForJson.face"
		   			, param : param
		   		});
	   		}
		}).on('loaded.jstree', function (event, data) {
			$("#deptTree").jstree('open_all');
		});
	}
   	
   	function fn_searchTree() {
   		//fn_drawTree($("#text").val());
   		if ($("#text").val() == null || $("#text").val() == "") {
			alert("부서명을 입력하십시오.");
			return;
		}
		 $('#deptTree').jstree('search', $("#text").val());
   	}
   	
	function fn_getSelectUserInfo() {
   		var html = "";
		$("input[name='srchChkValue']").each(function () {
			if ($(this).prop("checked")) {
				var arr = $(this).val().split("|");
				if ($("#userTr"+arr[0]).html() == undefined || $("#userTr"+arr[0]).html() == null) {
					html += "<tr id=\"userTr"+arr[0]+"\" >";
			    	html += "	<td class=\"C\">";
	    			html += "		<label for=\"" + arr[0] + "\"></label><input type=\"checkbox\" name=\"chkValue\" id=\"" + arr[0] + "\""; 
	  		    	html += " value=\"" + arr[0] + "|" + arr[1] + "|" + arr[2] + "|" + arr[3] + "|"  + arr[4] + "\" />";
		    		html += "	</td>";
		    		html += "	<td class=\"C\">" + arr[1] + "</td>";
		    		html += "	<td class=\"C\">" + arr[4] + "</td>";
		    		html += "	<td class=\"C\">" + arr[3] + "</td>";
		    		html += "</tr>";
				}
			}
		});
		
		$("#selectDataTable").append(html);

   	}
	
	function fn_AssinDircUserList(){
		var html = "";
		var pollTgUsrIdList ="";
		var totalInfo = new Object();
		var personArray = new Array();
		$("input[name='srchChkValue']").each(function (idx) {
			if ($(this).prop("checked")) {
				var arr = $(this).val().split("|");
				var personInfo = new Object();
				personInfo.userId =arr[0];
				personInfo.userName = arr[1];
				debugger;
				personInfo.criTmId = arr[2];
				personArray.push(personInfo);
			}
		});
		totalInfo.person = personArray;
		window.parent.commonLayerPopup.closeLayerPopup(JSON.stringify(totalInfo));
	}
	
	function fn_delUser(){
		if ($("input[name='chkValue']").is(":checked")){ 
			for(var i=$("[name='chkValue']:checked").length-1; i>-1; i--){
				$("[name='chkValue']:checked").eq(i).closest("tr").remove(); 
			} 
		}
	}
	function fn_AssinUserList(){
		var html = "";
		var pollTgUsrIdList ="";
		var totalInfo = new Object();
		var personArray = new Array();
		$("input[name='chkValue']").each(function (idx) {
			var arr = $(this).val().split("|");
			var personInfo = new Object();
			personInfo.userId =arr[0];
			personInfo.userName = arr[1];
			personArray.push(personInfo);
		});
		totalInfo.person = personArray;
		window.parent.commonLayerPopup.closeLayerPopup(JSON.stringify(totalInfo));
		
		
	}
	
	function fn_closeLayer(){
		window.parent.commonLayerPopup.closeLayerPopupOnly();	
	}
	
	
	/**
	 * Date		:	2017.01.25
	 * name 	:	Developwon
	 * subject	:	objName으로 받은 element들은 check
	 * param 	:	objName, element(this)
	 */
	function fn_allCheck(objName, el){
		var gc = document.getElementsByName(objName);
		
		for(var i = 0; i < gc.length; i++){
			if(el.checked == true){
				gc[i].checked = true;
			} else {
				gc[i].checked = false; 
			}
		}
	}
   	
   	$(document).ready(function () {
   		fn_drawTree();
   	  	$("#text").keyup(function() {
   	  		var searchString = $(this).val();
            $('#deptTree').jstree('search', searchString);
     	 });
   	});
   </script>
<body class="popup">
	<h2>
		<span>부서 지정</span>
	</h2>
	<div class="content_wrap">
		<!-- pop content-->
		<c:if test="${not empty param.chkType }">
			<c:choose>
				<c:when test="${param.chkType eq 'checkbox'}">
					<div class="pop_leftArea">
				</c:when>
				<c:otherwise>
					<div class="leftArea">
				</c:otherwise>
			</c:choose>
		</c:if>
		<p class="subtitle">조직도</p>
		<div id="deptTree" class="part normal_scroll"></div>
	</div>
	<c:if test="${not empty param.chkType }">
		<c:choose>
			<c:when test="${param.chkType eq 'checkbox'}">
				<div class="pop_centerArea">
			</c:when>
			<c:otherwise>
				<div class="rightArea">
			</c:otherwise>
		</c:choose>
	</c:if>

	<!-- pop content-->
	<p class="subtitle">부서원 목록</p>
	<form method="post" id="userTreeSearchForm" style="display: none;">
		<input type="hidden" id="orgCd" name="orgCd" value="">
	</form>
	<div class="part mar_02">
		<div class="scroll_title">
			<table class="list mrg_0" cellpadding="0" cellspacing="0">
				<colgroup>
					<c:if test="${not empty param.chkType }">
						<col style="width: 10%" />
					</c:if>
					<col width="25%" />
					<col width="30%" />
					<col width="*%" />
				</colgroup>
				<thead>
					<tr>
						<c:if test="${not empty param.chkType }">
							<c:choose>
								<c:when test="${param.chkType eq 'checkbox'}">
									<th class="C"><input type="checkbox" class="check_box" onclick="javascript: fn_allCheck('srchChkValue', this);">
									</th>
								</c:when>
								<c:otherwise>
									<th class="C">선택</th>
								</c:otherwise>
							</c:choose>
						</c:if>
						<th class="C">성명</th>
						<th class="C">직위</th>
						<th class="C">부서</th>
					</tr>
				</thead>
			</table>
		</div>
		<div class="t_scroll">
			<table class="list" cellpadding="0" cellspacing="0">
				<colgroup>
					<c:if test="${not empty param.chkType }">
						<col width="10%" />
					</c:if>
					<col width="25%" />
					<col width="30%" />
					<col width="*%" />
				</colgroup>
				<tbody id="dataTable">
				</tbody>
			</table>
		</div>
		<c:if test="${not empty param.chkType }">
			<c:choose>
				<c:when test="${param.chkType eq 'checkbox'}">
					<div class="t_btnArea">
						<div class="c_btn">
							<a href="javascript:fn_getSelectUserInfo();" class="btn_white"><span>추가</span></a>
						</div>
					</div>
				</c:when>
			</c:choose>
		</c:if>
	</div>
	</div>

	<!-- rightArea -->
	<c:if test="${not empty param.chkType }">
		<c:choose>
			<c:when test="${param.chkType eq 'checkbox'}">
				<div class="pop_rightArea">
					<!-- pop content-->
					<p class="subtitle">선택 목록</p>
					<div class="part mar_02">
						<div class="scroll_title">
							<table class="list mrg_0" cellpadding="0" cellspacing="0">
								<colgroup>
									<c:if test="${not empty param.chkType }">
										<col width="16%" />
									</c:if>
									<col width="25%" />
									<col width="25%" />
									<col width="*%" />
								</colgroup>
								<thead>
									<tr>
										<c:if test="${not empty param.chkType }">
											<c:choose>
												<c:when test="${param.chkType eq 'checkbox'}">
													<th class="C"><label for="checkbox_07"></label><inputtype="checkbox" id="checkbox_07" class="check_box"onclick="javascript: fn_allCheck('chkValue', this);"></th>
												</c:when>
												<c:otherwise>
													<th class="C">선택</th>
												</c:otherwise>
											</c:choose>
										</c:if>
										<th class="C">성명</th>
										<th class="C">직위</th>
										<th class="C">부서</th>
									</tr>
								</thead>
							</table>
						</div>
						<div class="t_scroll">
							<table class="list" cellpadding="0" cellspacing="0">
								<colgroup>
									<c:if test="${not empty param.chkType }">
										<col width="16%" />
									</c:if>
									<col width="25%" />
									<col width="25%" />
									<col width="*%" />
								</colgroup>
								<tbody id="selectDataTable">
								</tbody>
							</table>
						</div>
						<div class="t_btnArea">
							<div class="c_btn">
								<a href="javascript:fn_delUser();" class="btn_grey"><span>삭제</span></a>
							</div>
						</div>
					</div>
				</div>
			</c:when>
		</c:choose>
	</c:if>

	<div class="btnArea pop_back">
		<div class="r_btn">
			<c:if test="${not empty param.chkType }">
				<c:choose>
					<c:when test="${param.chkType eq 'checkbox'}">
						<a href="javascript:fn_AssinUserList();" class="btn_blue save"><span>확인</span></a>
					</c:when>
					<c:otherwise>
						<a href="javascript:fn_AssinDircUserList();" class="btn_blue save"><span>확인</span></a>
					</c:otherwise>
				</c:choose>
			</c:if>
			<a href="javascript:fn_closeLayer();" class="btn_light_blue_line appointed"><span>닫기</span></a>
		</div>
	</div>
	</div>
</body>