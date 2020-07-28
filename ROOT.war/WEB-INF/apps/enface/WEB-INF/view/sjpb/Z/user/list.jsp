<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>:: 경기신용보증재단 ::</title>
		<%@ include file="/ssu/reference/common/commonScriptInclude.jsp"  %>
		<link rel="stylesheet" href="${cPath }/javascript/jstree/themes/default/style.min.css" />
		<script src="${cPath }/javascript/jstree/jstree.min.js" ></script>
		
		<script type="text/javascript">
			function fn_setSearchView(view) {
				$(".searchView").hide();
				$("#viewTab > li.on").removeClass("on");
				$("#" + view).addClass("on");
				$("." + view).show();
				if (view == "orgView") {
					$("#searchBtn").hide();
				} else {
					$("#searchBtn").show();
				}
			}
			
			function fn_ajaxSuccess(data) {
	    		var html = "";
	    		
	    		if (data.status == "SUCCESS") {
	    			if (data.data.length > 0) {
	    				$(data.data).each(function () {
	    		    		html += "<tr>";
	    		    		html += "	<td>" + this.id + "</td>";
	    		    		html += "	<td><a href=\"javascript:fn_getUserInfoPopup(" + this.id + ");\" target=\"_self\">" + this.name + "</a></td>";
	    		    		html += "	<td><img src=\"${cPath}/upload/common/photo/" + this.id + ".jpg\" alt=\"직원사진\" title=\"\" width=\"60\" height=\"80\" class=\"border\"/></td>";
	    		    		//html += "	<td>" + this.dept + " / " + (this.position == ""?this.oftl:this.position) + "</td>";
	    		    		html += "	<td>" + this.dept + " / " + (this.jbpn == "" ? this.oftl : this.jbpn) + "</td>";
	    		    		html += "	<td>" + this.jfnct + "</td>";
	    		    		html += "	<td>" + this.ofcTel + "</td>";
	    		    		html += "	<td>" + this.celPh + "</td>";
	    		    		html += "	<td>" + this.carNo + "</td>";
	    		    		html += "</tr>";
	    				});
	    			} else {
						html += "<tr>";
						html += "	<td colspan='9'>";
						html += "		조회된 데이터가 없습니다.";
						html += "	</td>";
						html += "</tr>";
	    			}
	    		} else {
					html += "<tr>";
					html += "	<td colspan='9'>";
					html += "		조회된 데이터가 없습니다.";
					html += "	</td>";
					html += "</tr>";
				}
	    		$("#totalCnt").text(data.data.length);
	    		$("#dataTable").html(html);
	    	}
	    	
	    	function fn_ajaxError(data) {
	    		//console.log(data)
	    	}
	    	
	    	function fn_searchAjax() {
	    		var isValue = false;
	    		$("#searchForm input[type='text']").each(function (index) {
	    			if (this.value != null && this.value != "" && this.value.length > 1) {
    					isValue = true;
					} 
	    		});
	    		
	    		if (!isValue) {
					alert("검색어는 최소 2글자 이상을 입력하십시오.");
					
					<c:if test="${!empty param.unifyChk && param.unifyChk ne '' && param.unifyChk eq 't' }">
						$("#unifyChk").remove();
					</c:if>
					
	    			return;	
	    		}
	    		
	    		<c:if test="${!empty param.unifyChk && param.unifyChk ne '' && param.unifyChk eq 't' }">
					$("#unifyChk").val("t");
				</c:if>
				
	    		param = $("#searchForm").serialize();
	    		
	    		<c:if test="${!empty param.unifyChk && param.unifyChk ne '' && param.unifyChk eq 't' }">
					$("#unifyChk").remove();
					$("#usrNm").val("");
				</c:if>
				
	    		fn_ajax({
	    			url : "${cPath}/sjpb/Z/selectUserListForJson.face"
	    			, param : param
	    		});
	    	}
	    	
	    	function fn_drawTree(text) {
	    		$("#deptTree").jstree('destroy');
	    		$('#deptTree').jstree({
	    			'core' : {
	    				'data' : {
	    					"url" : "${cPath }/sjpb/Z/selectDeptTree.face" + (text=='' || text==null  ? '' : '?text=' + encodeURIComponent(text)),
	    					"dataType" : "json",
	    					"data" : function (node) {
	    						return { "id" : node.id };
	    					}
	    				},
	    				"multiple" : false,
						"animation" : 0
	    			}
	    		}).on("select_node.jstree", function (e, data) {
	    			param = "usrDeptCd=" + data.node.id;
		    		
		    		fn_ajax({
		    			url : "${cPath}/sjpb/Z/selectUserListForJson.face"
		    			, param : param
		    		});
	    		});
				$("#deptTree").on('loaded.jstree', function (event, data) {
					$("#deptTree").jstree('open_node', '#00000001');
					$("#deptTree").jstree('open_node', '#01000100');
				}); 
	    		
	    		
			}
	    	
	    	function fn_showTelInfo() {
	    		$("#telInfo").css({
	        		"width" : 600,
	        		"height" : 748,
	        		"position" : "relative"
	        	});
	    		
	    		// 현제창의 중앙으로 이동시킨다.
				var windowWidth = 0;
				var windowHeight = 0;
				var layerWidth = 0;
				var layerHeight = 0;
				
				var windowWidth = $(window).width();
	        	var windowHeight = $(window).height() ;
	        	
        		layerWidth = $("#telInfo").width();
        		layerHeight = $("#telInfo").height();
	        	
	        	$("#telInfo").css({
	        		"left" : (windowWidth/2) - (layerWidth/2),
	        		"top"  : ((windowHeight/2) - (layerHeight/2)) - 50 < 0 ? 20 : ((windowHeight/2) - (layerHeight/2)) - 50,
	        		"position" : "absolute"
	        	}).show().draggable({ containment: "parent", handle: "div.layer_popup_header", cursor: "move" });
	    	}
	    	
	    	function fn_searchTree() {
	       		if ($("#text").val() == null || $("#text").val() == "") {
	       			alert("부서명을 입력하십시오.");
	       			return;
	       		}
	       		
	       		fn_drawTree($("#text").val());
	       	}

	    	$(document).ready(function () {
	    		$("#searchForm input[type='text']").keydown(function (event) {
	    			if (event.keyCode == 13) {
	    				// enter 입력시 검색
	    				fn_searchAjax();
	    			}
	    		});
	    		
	    		fn_drawTree();
	    		
	    		<c:if test="${!empty param.viewMode && param.viewMode ne '' }">
	    		fn_setSearchView('<c:out value="${param.viewMode}" />');
	    		if ('<c:out value="${param.viewMode}" />' == 'orgView') {
	    			// 부서
	    			$("#text").val('<c:out value="${param.text}" />');
	    			fn_drawTree('<c:out value="${param.text}" />');
	    		} else {
	    			$("#usrNm").val('<c:out value="${param.text}" />');
	    			fn_searchAjax();
	    		}
	    		</c:if>
	    	});
		</script>
		
		<style type="text/css">
			.popup_basic_table td {padding: 10px 0;}
		
		</style>
	</head>
	
	<body >
		<div class="sub_container">
			<!-- content start -->
			<div id="content">
				<h4 class="mb10">직원검색</h4>
				<ul class="guide_list">
					<li>띄어쓰기 포함 30자(한글 기준)이내로 입력해 주시기 바랍니다.</li>
				</ul>

				<div class="w_p25 fl tm10">
					<div class="board_top">
						<div class="board_btn_L">
							<div class="sub_tabmenu" style="margin: 0px;">
								<ul id="viewTab">
									<li id="userView" class="on"><a href="javascript:void(0);" target="_self" title="개인" onclick="fn_setSearchView('userView');">개인</a></li>
									<li id="orgView"><a href="javascript:void(0);" target="_self" title="조직" onclick="fn_setSearchView('orgView');">조직</a></li>
								</ul>
							</div>
						</div>
					</div>
					<form action="${cPath }/sjpb/Z/userList.face" method="post" id="searchForm">
						<input type="hidden" id="unifyChk" name="unifyChk" value="" />
						<table class="basic_table_write searchView userView" summary="직원검색 입력">
							<caption>직원검색 입력</caption>
							<colgroup>
								<col style="width:100px" />
								<col style="width:auto" />
							</colgroup>
							<tbody>
								<tr>
									<th class="first"><label for="usrId" >사번</label></th>
									<td><input type="text" name="usrId" id="usrId" class="w_p100" maxlength="30"/></td>
								</tr>
								<tr>
									<th class="first"><label for="usrNm" >성명</label></th>
									<td><input type="text" name="usrNm" id="usrNm" class="w_p100" maxlength="30"/></td>
								</tr>
								<tr>
									<th class="first"><label for="usrDeptNm" >부서</label></th>
									<td><input type="text" name="usrDeptNm" id="usrDeptNm" class="w_p100" maxlength="30"/></td>
								</tr>
								<tr>
									<th class="first"><label for="usrJbpnNm" >직위</label></th>
									<td><input type="text" name="usrJbpnNm" id="usrJbpnNm" class="w_p100" maxlength="30"/></td>
								</tr>
								<tr>
									<th class="first"><label for="usrOflvNm" >직급</label></th>
									<td><input type="text" name="usrOflvNm" id="usrOflvNm" class="w_p100" maxlength="30"/></td>
								</tr>
								<tr>
									<th class="first"><label for="usrJbkndNm" >직계</label></th>
									<td><input type="text" name="usrJbkndNm" id="usrJbkndNm" class="w_p100" maxlength="30"/></td>
								</tr>
								<tr>
									<th class="first"><label for="usrJfnctNm" >직무</label></th>
									<td><input type="text" name="usrJfnctNm" id="usrJfnctNm" class="w_p100" maxlength="30"/></td>
								</tr>
								<tr>
									<th class="first"><label for="usrOfcTelNo" >부서전화</label></th>
									<td><input type="text" name="usrOfcTelNo" id="usrOfcTelNo" class="w_p100" maxlength="30"/></td>
								</tr>
								<tr>
									<th class="first"><label for="usrCelphNo" >핸드폰</label></th>
									<td><input type="text" name="usrCelphNo" id="usrCelphNo" class="w_p100" maxlength="30"/></td>
								</tr>
								<tr>
									<th class="first"><label for="usrCarNo" >차량번호</label></th>
									<td><input type="text" name="usrCarNo" id="usrCarNo" class="w_p100" maxlength="30"/></td>
								</tr>
							</tbody>
						</table>
					</form>
					
					<div class="helper_search_wrap mh512 searchView orgView" style="display: none;">
						<div style="display: inline-block; width: 100%">
							<form action="${cPath }/sjpb/Z/userList.face" method="post" id="deptSearchForm">
								<label for="pop_searchtxt" class="hide">직원검색</label>
								<input type="text" name="dummy" value="" style="display: none;" />
								<input type="text" id="text" name="text" class="w_p70 lm_5" placeholder="부서검색" value="${param.searchValue }" onkeydown="if(event.keyCode==13){fn_searchTree();}"/>
								<a href="javascript:fn_searchTree();" class="btn_white" style="position:relative; top: 0px;">
									<span class="icon_search"></span>검색
								</a>
							</form>
						</div>
						<div id="deptTree" style="padding-top: 10px;">
						
						</div>
					</div>
					
					<div class="board_bottom">
						<div class="board_btn_L">
							<a href="javascript:void(0);" onclick="fn_showTelInfo();" class="btn_black">본사부대시설 보기</a>
						</div>
						<div class="board_btn_R">
							<a id="searchBtn" href="javascript:void(0);" onclick="fn_searchAjax();" class="btn_white">
								<span class="icon_search"></span>검색
							</a>
						</div>
					</div>
				</div>

				<div class="w_p73 fr tm10">
					<div class="board_top">
						<div class="board_total board_btn_L">
							총 <strong id="totalCnt">0</strong> 건
							<%--<select id="lineCount" name="lineCount" >
								<option value="10">10개</option>
								<option value="20">20개</option>
								<option value="50">50개</option>
							</select> --%>
						</div>
					</div>

					<div class="member_search_list">
						<table class="basic_table" summary="직원검색 목록">
							<caption>직원검색 목록</caption>
							<colgroup>
								<col style="width:90px" />
								<col style="width:120px" />
								<col style="width:120px" />
								<col style="width:40%;" />
								<col style="width:30%" />
								<col style="width:120px" />
								<col style="width:120px" />
								<col style="width:90px" />
								<col style="width:15px" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">사번</th>
									<th scope="col">성명</th>
									<th scope="col">사진</th>
									<th scope="col">부서/직함</th>
									<th scope="col">직무</th>
									<th scope="col">부서전화</th>
									<th scope="col">휴대폰</th>
									<th scope="col">차량번호</th>
									<th class="last" scope="col"></th>
								</tr>
							</thead>
						</table>
						<div class="scroll" style="max-height: 512px;">
						<table class="basic_table no_border_top" summary="직원검색 목록">
							<caption>직원검색 목록</caption>
							<colgroup>
								<col style="width:90px" />
								<col style="width:120px" />
								<col style="width:120px" />
								<col style="width:auto" />
								<col style="width:auto" />
								<col style="width:120px" />
								<col style="width:120px" />
								<col style="width:90px" />
							</colgroup>
							<tbody id="dataTable">
								<tr>
									<td colspan="9">조회된 데이터가 없습니다.</td>
								</tr>
							</tbody>
						</table>
						</div>
					</div>
				</div>
			</div>
			<!-- //content end -->
		</div>
		
		<!-- KNB0404xxxx start -->
		<div id="telInfo" class="sub_layer_popup" style="display:none;top: 0;left: 0;" > 
			<div class="layer_popup_header">
				구내/행정 전화번호 <span>* OA 장비 유지보수: 061-338-5233</span>
				<a class="popup_close" href="javascript:void(0);" onclick="$('#telInfo').hide();" title="닫기" >닫기</a>
			</div>
			<div class="layer_popup_white">
				<table class="popup_basic_table" summary="구내/행정 전화번호">
					<caption>구내/행정 전화번호</caption>
					<colgroup>
						<col style="width:25%;" />
						<col style="width:25%;" />
						<col style="width:25%;" />
						<col style="width:25%;" />
					</colgroup>
					<thead>
						<tr>
							<th>부대시설</th>
							<th>구내번호</th>
							<th>부대시설</th>
							<th class="last">구내번호</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="gray">당직실</td>
							<td>6801</td>
							<td class="gray">방송실</td>
							<td>6785</td>
						</tr>
						<tr>
							<td class="gray">방호실</td>
							<td>6802~3</td>
							<td class="gray">스튜디오</td>
							<td>6786</td>
						</tr>
						<tr>
							<td class="gray">안내데스크 정문</td>
							<td>5100</td>
							<td class="gray">대강당 방송실</td>
							<td>6811</td>
						</tr>
						<tr>
							<td class="gray">안내데스크 후문</td>
							<td>5300</td>
							<td class="gray">대강당 안내실</td>
							<td>6812</td>
						</tr>
						<tr>
							<td class="gray">신용협동조합</td>
							<td>6771~4</td>
							<td class="gray">소강당 방송실</td>
							<td>6813</td>
						</tr>
						<tr>
							<td class="gray">신용협동조합 FAX</td>
							<td>6776~7</td>
							<td class="gray">대회의실 방송실</td>
							<td>6814</td>
						</tr>
						<tr>
							<td class="gray">차량관리실</td>
							<td>6751~3</td>
							<td class="gray">지하상황실 방송실</td>
							<td>6815</td>
						</tr>
						<tr>
							<td class="gray">청사관리실</td>
							<td>6761</td>
							<td class="gray">중앙관재실</td>
							<td>6731~3</td>
						</tr>
						<tr>
							<td class="gray">미화반</td>
							<td>6762</td>
							<td class="gray">방재센터</td>
							<td>6741~3</td>
						</tr>
						<tr>
							<td class="gray">문서고</td>
							<td>6763~5</td>
							<td class="gray">통신실</td>
							<td>6000</td>
						</tr>
						<tr>
							<td class="gray">도서관</td>
							<td>6768~9</td>
							<td class="gray">체력단련실</td>
							<td>6787</td>
						</tr>
						<tr>
							<td class="gray">의무실</td>
							<td>6781</td>
							<td class="gray">이.미용실</td>
							<td>6788</td>
						</tr>
						<tr>
							<td class="gray">대식당</td>
							<td>6782</td>
							<td class="gray">구두수선소</td>
							<td>6789</td>
						</tr>
						<tr>
							<td class="gray">중식당</td>
							<td>6783</td>
							<td class="gray">세탁소</td>
							<td>6790</td>
						</tr>
						<tr>
							<td class="gray">어린이집</td>
							<td>6784</td>
							<td class="gray">당구장</td>
							<td>6791</td>
						</tr>
						<tr>
							<td class="gray"></td>
							<td></td>
							<td class="gray">카페테리아</td>
							<td>6792</td>
						</tr>
					</tbody>
				</table>

				<div class="layerpopup_bottom tx_c">
					<a href="javascript:void(0);" onclick="fn_print('telInfo', 'popup');" class="btn_black">인쇄</a>
				</div>
			</div>
		</div>
		<!-- //KNB0404xxxx end -->
	</body>
</html>
