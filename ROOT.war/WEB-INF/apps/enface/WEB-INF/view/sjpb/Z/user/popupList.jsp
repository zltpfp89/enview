<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setAttribute("cPath", request.getContextPath());
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>:: 경기신용보증재단 ::</title>
    <link rel="stylesheet" type="text/css" href="${cPath}/ssu/reference/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="${cPath}/ssu/reference/css/common.css" />
    <link rel="stylesheet" type="text/css" href="${cPath}/ssu/reference/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="${cPath}/ssu/reference/css/main.css" />
    <link rel="stylesheet" type="text/css" href="${cPath}/ssu/reference/css/sub.css" />
    
    <script type="text/javascript" src="${cPath}/ssu/reference/js/jquery.js" ></script>
    <script type="text/javascript" src="${cPath}/ssu/reference/js/jquery-ui-1.10.3.js" ></script>
    <script type="text/javascript" src="${cPath}/ssu/js/common_ssu.js" ></script>
    <script type="text/javascript">
    	function fn_ajaxSuccess(data) {
    		console.log(data);
    	}
    	 
    	function fn_ajaxError(data) {
    		console.log(data)
    	}
    	
    	function fn_searchAjax() {
    		var param = $("#searchForm").serialize();
    		fn_ajax({
    			url : "${cPath}/sjpb/Z/selectUserListForJson.face"
    			, param : param
    		});
    	}
    	
    	function fn_search() {
    		if ($("#searchValue").val() == null || $("#searchValue").val() == "") {
    			alert("검색어를 입력하십시오.");
    			return;
    		} 
    		
    		if ($("#searchValue").val().length < 2) {
    			alert("검색어를 2자 이상 입력하십시오.");
    			return;
    		}
    		
    		$("#searchForm").submit();
    	}
    	/* 
		// 팝업창에 있는 확인버튼 클릭시 부모창의 아래 함수가 작동한다.
    	function fn_getChkUserInfo() {
    		// 체크한 사용자를 확인한다.
    		var returnIds = [];
    		
    		$("input[name='chkValue']").each(function () {
    			if ($(this).prop("checked")) {
    				returnIds.push($(this).val());
    			}
    		});
    		
    		// 필요 업무 처리
    		alert(returnIds);
    	}
    	c
    	$(document).ready(function() {
    		$("#layerPopup").load("${cPath}/sjpb/Z/layerPopupList.face", function () {});
    	}); */
    </script>
</head>
<body>
    <div class="sub_layer_popup" style="display: block; position: absolute; top: 0px; left: 0px; width: 530px;" >
    	<div class="layer_popup_header">
    		직원검색<a class="popup_close" title="닫기" >닫기</a>
		</div>
		<div class="layer_popup_gray">
			<div class="member_search" style="padding-right: 0px;">
				<div>
					<form action="${cPath }/sjpb/Z/popupList.face" method="post" id="searchForm">
						<label for="pop_searchtxt" class="hide">직원검색</label>
						<input type="hidden" id="cPage" name="cPage" />
						<select id="searchType" name="searchType" >
							<option value="id" <c:if test="${param.searchType eq 'id' }">selected="selected"</c:if>>사번</option>
							<option value="name" <c:if test="${param.searchType eq 'name' || empty param.searchType }">selected="selected"</c:if>>성명</option>
							<option value="dept" <c:if test="${param.searchType eq 'dept' }">selected="selected"</c:if>>부서</option>
							<option value="jbpn" <c:if test="${param.searchType eq 'jbpn' }">selected="selected"</c:if>>직위</option>
							<option value="oflv" <c:if test="${param.searchType eq 'oflv' }">selected="selected"</c:if>>직급</option>
							<option value="jbknd" <c:if test="${param.searchType eq 'jbknd' }">selected="selected"</c:if>>직계</option>
							<option value="jfnct" <c:if test="${param.searchType eq 'jfnct' }">selected="selected"</c:if>>직무</option>
							<option value="ofcTel" <c:if test="${param.searchType eq 'ofcTel' }">selected="selected"</c:if>>부서전화</option>
							<option value="celph" <c:if test="${param.searchType eq 'celph' }">selected="selected"</c:if>>핸드폰</option>
							<option value="carNo" <c:if test="${param.searchType eq 'carNo' }">selected="selected"</c:if>>차량번호</option>
						</select>
						<input type="text" id="searchValue" name="searchValue" class="" style="width: 406px;" placeholder="입력 후 검색버튼을 누르십시오." value="${param.searchValue }" onkeydown="if(event.keyCode==13){fn_search();}"/>
						<a href="javascript:fn_search();" class="btn_white">
							<span class="icon_search"></span>검색
						</a>
					</form>
				</div>
				<!-- <p>↓검색 후 아래의 해당 이름을 클릭하시면 자동으로 입력됩니다.</p> -->
			</div>
			<div class="layer_popup_white  tx_c">
				<table class="popup_basic_table" summary="">
					<caption></caption>
					<colgroup>
						<col style="width:60px;" />
						<col style="width:;" />
						<col style="width:;" />
						<col style="width:;" />
						<col style="width:;" />
						<col style="width:15px;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">성명</th>
							<th scope="col">사번</th>
							<th scope="col">직급</th>
							<th class="last" scope="col">부서</th>
							<th class="last" scope="col"></th>
						</tr>
					</thead>
				</table>
				<div class="h250 overflow_y table_scroll">
					<table class="popup_basic_table" summary="">
						<colgroup>
							<col style="width:60px;" />
							<col style="width:;" />
							<col style="width:;" />
							<col style="width:;" />
							<col style="width:;" />
						</colgroup>
						<tbody>
						<c:if test="${empty list }">
							<tr>
								<td colspan="5">조회된 데이터가 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${!empty list }">
						<c:forEach items="${list }" var="user" varStatus="status">
							<tr>
								<td>
									<%-- <label for="MemberList6" class="hide">선택</label><input type="radio" name="" value="${user.usrId }" id="MemberList6" /> --%>
									<c:out value="${user.rnum }" />
									<input type="hidden" name="usrId" value="${user.usrId }" />
								</td> 
								<!-- 다중 선택시 input타입 checkbox로 변경 -->
								<td><a href="javascript:fn_getUserInfoPopup(${user.usrId });" target="_self"><c:out value="${user.usrNm }" /></a></td>
								<td><c:out value="${user.usrId }" /></td>
								<td><c:out value="${user.usrOflvNm }" /></td>
								<td><c:out value="${user.usrDeptNm }" /></td>
							</tr>
						</c:forEach>
						</c:if>
						</tbody>
					</table>
				</div>
			</div>
			<!-- <div class="layerpopup_bottom tx_c">
				<a href="#" class="btn_black">확인</a>
			</div> -->
		</div>
    </div>
</body>
</html>

        