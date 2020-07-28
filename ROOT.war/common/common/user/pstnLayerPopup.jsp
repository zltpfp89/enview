<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="common" uri="/WEB-INF/tld/common.tld" %>
<style>
.tree_box{background:#fff; border:1px solid #b6b6b6; box-sizing:border-box; width:100%; height:300px;  overflow-y:auto; margin-bottom:10px;}

</style>

	<div class="layerpopup_top">
		<div class="layerpopup_search">
			<label for="pop_meetroon_reserv" class="hide">검색</label><input id="deptPopup_deptCd" type="text" name="" maxlength="" id="pop_meetroon_reserv" placeholder="찾고자 하는 이름, 직위, 소속을 입력하신 후 검색버튼을 누르십시오." />
			<a href="#" class="btn_white" id="deptTree_searchBtn"><span class="icon_zoom"></span>검색</a>
		</div>
	</div>

	<div class="layerpopup_white ">      
	<div class="tree_box">
		<table class="popup_basic_table" summary="경영보고 수신자 검색">
			<caption>경영보고 수신자 검색</caption>
			<colgroup>
				<col style="width:;" />
				<col style="width:;" />
				<col style="width:;" />
				<col style="width:;" />
			</colgroup>
			<thead>
				<th scope="col">성명</th>
				<th scope="col">사번</th>
				<th scope="col">직급</th>
				<th class="last" scope="col">부서</th>
			</thead>
			<tbody>
				<tr>
					<td>홍길동</td>
					<td>00000000</td>
					<td>팀원4급</td>
					<td>경영정보부</td>
				</tr>
				<tr>
					<td>홍길동</td>
					<td>11111111</td>
					<td>팀원4급</td>
					<td>경영정보부</td>
				</tr>
				<tr>
					<td>홍길동</td>
					<td>11111111</td>
					<td>팀원4급</td>
					<td>경영정보부</td>
				</tr>
				<tr>
					<td>홍길동</td>
					<td>11111111</td>
					<td>팀원4급</td>
					<td>경영정보부</td>
				</tr>
				<tr>
					<td>홍길동</td>
					<td>11111111</td>
					<td>팀원4급</td>
					<td>경영정보부</td>
				</tr>
				<tr>
					<td>홍길동</td>
					<td>11111111</td>
					<td>팀원4급</td>
					<td>경영정보부</td>
				</tr>
			</tbody>
		</table>
	</div>
	</div>
