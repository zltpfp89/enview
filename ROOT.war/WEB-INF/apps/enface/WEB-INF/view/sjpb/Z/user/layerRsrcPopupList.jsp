<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setAttribute("cPath", request.getContextPath());
%>
<link rel="stylesheet" href="${cPath }/javascript/jstree/themes/default/style.min.css" />
<script src="${cPath }/javascript/jstree/jstree.min.js" ></script>
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
	    			html += "		<label for=\"" + this.userId + "\"></label><input type=\"" + chkType + "\" name=\"chkValue\" id=\"" + this.userId + "\""; 
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
					url : "${cPath}/sjpb/Z/selectDeptTree.face",
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
   	
   	
   	$(document).ready(function () {
   		fn_drawTree();
   	});
   </script>
<div id="userSearch">
 	<div class="layer_popup_gray">
		<div class="w_p30 fl tm10">
			<div class="member_search" style="padding-right: 0px;">
				<div>
					<form id="deptSearchForm">
						<label for="pop_searchtxt" class="hide">직원검색</label>
						<input type="text" name="dummy" value="" style="display: none;" />
						<input type="text" id="text" name="text" class="" placeholder="부서검색" value="${param.searchValue }" onkeydown="if(event.keyCode==13){fn_searchTree();}"/>
						<a href="javascript:fn_searchTree();" class="btn_white">
							<span class="icon_search_gcgf">검색</span>
						</a>
					</form>
				</div>
				<!-- <p>↓검색 후 아래의 해당 이름을 클릭하시면 자동으로 입력됩니다.</p> -->
			</div>
			<div class="helper_search_wrap" >
				<div id="deptTree" style="padding-top: 10px; max-height: 327px; height: 327px;">
				
				</div>
			</div>
		</div>
		<div class="w_p65 fr tm10">
			<div class="member_search" style="padding-right: 0px;">
				<div>
					<form method="post" id="userTreeSearchForm" style="display: none;">
						<input type="hidden" id="orgCd" name="orgCd" value="">
					</form>
					 <form action="${cPath }/sjpb/Z/userList.face" method="post" id="userSearchForm">
						<label for="pop_searchtxt" class="hide">직원검색</label>
						<select id="searchType" name="searchType" >
							<option value="userId" >사번</option>
							<option value="nmKor" selected="selected">성명</option>
							<option value="criMbPosiNm" >직위</option>
							<option value="orgName" >부서</option>
							<option value="mobileTel" >휴대폰번호</option>
						</select>
						<input type="text" id="dummy" name="dummy" value="" style="display: none;" />
						<input type="text" id="searchValue" name="searchValue" class="" placeholder="직원검색" value="${param.searchValue }" onkeydown="if(event.keyCode==13){fn_searchAjax();}" style="width: 300px; margin-bottom: 1px;" />
						<a href="javascript:fn_searchAjax();" class="btn_white">
							<span class="icon_search_gcgf">검색</span>
						</a>
					</form>
				</div>
			</div>
			<div class="layer_popup_white  tx_c">
				<table class="popup_basic_table" summary="">
					<caption></caption>
					<colgroup>
						<c:if test="${not empty param.chkType }">
							<col style="width:10%;" />
						</c:if>
						<col style="width:30%;" />
						<col style="width:30%" />
						<col style="width:30%;" />
					</colgroup>
					<thead>
						<tr>
							<c:if test="${not empty param.chkType }">
								<c:choose>
									<c:when test="${param.chkType eq 'checkbox'}">
										<th scope="col">
											<input type="checkbox" onclick="javascript: fn_allCheck('chkValue', this);">
										</th>
									</c:when>
									<c:otherwise>
										<th scope="col">선택</th>
									</c:otherwise>
								</c:choose>
							</c:if>
							<th scope="col">성명</th>
							<th scope="col">직위</th>
							<th scope="col">부서</th>
						</tr>
					</thead>
				</table>
				<div class="h250 overflow_y table_scroll">
					<table class="popup_basic_table" summary="">
						<colgroup>
							<c:if test="${not empty param.chkType }">
									<col style="width:10%;" />
							</c:if>
							<col style="width:30%;" />
							<col style="width:30%" />
							<col style="width:30%;" />
						</colgroup>
						<tbody id="dataTable">
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="w_p100 fr tm10 none" id="layerPopupDeptInfo">
			<div class="layer_popup_white tx_c" id="layerPopupDeptInfoZone">
				
			</div>
		</div>
	</div>
	
</div>