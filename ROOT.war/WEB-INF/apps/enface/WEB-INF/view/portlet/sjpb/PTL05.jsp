<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
$( document ).ready(function(){
	var currentTime = new Date();
	var year = currentTime.getFullYear();
	processYear(year);
});
function processYear(value){
	$.ajax({
		type: "POST",
		url: "/sjpb/Z/PTL05.face",
		data: {"year":value},
		datatype : 'json',
		success: function(data){
// 			$("#secinv").html(data.vo.secinv);
			$("#prsct").html(data.vo.prsct);
// 			$("#prsAccus").html(data.vo.prsAccus);
			$("#prsPapst").html(data.vo.prsPapst);
			$("#trnsr").html(data.vo.trnsr);
			$("#trnsrPer").html(data.vo.trnsrPer);
			$("#trnExpPer").html(data.vo.trnExpPer);
			$("#trnGoal").html(data.vo.trnGoal);
			$("#curYear").html(data.curYear);
		},error : function(request,status,error) {
			alert("code:"+ request.status+ "\n"+ "message:"+ request.responseText+ "\n"+ "error:"+ error);
		}
	});
}
</script>
<div class="portlet p_22">
	<h2 class="fl">사건처리 <span>현황</span></h2>
	<div class="inputbox w15per">
		<p class="txt" id="curYear"></p>
		<select onchange="javascript:processYear(this.value);">
			<c:forEach items="${yearList }" var="year">
				<option value="${year }">${year}</option>
			</c:forEach>
		</select>
	</div>             
	<div class="status">
		<dl>
			<dt>입건</dt>
			<dd class="status_one"><span class="all_txt"><em class="value" id="prsPapst"></em>건</span></dd>
		</dl>
<!-- 		<dl> -->
<!--        		<dt class="status_top"> -->
<!--        			입건 -->
<!--        			<span class="top_value"><span id="prsct"></span><em class="key">건</em></span> -->
<!--        		</dt> -->
<!--        		<dd class="status_two"> -->
<!--        			<span class="all_txt"> -->
<!--        				<span class="half_txt_down first"><em class="value_down">고발</em><em class="value" id="prsAccus"></em>건</span> -->
<!--        				<span class="half_txt_down"><em class="value_down">인지</em><em class="value" id="prsPapst"></em>건</span> -->
<!--        			</span> -->
<!--        		</dd> -->
<!-- 		</dl> -->
		<dl>
			<dt>송치</dt>
			<dd class="status_one"><span class="all_txt"><em class="value" id="trnsr"></em>건</span></dd>
		</dl>
		<dl>
			<dt>송치율</dt>
			<dd class="status_one"><span class="all_txt"><em class="value" id="trnsrPer"></em>%</span></dd>
		</dl>
		<dl>
			<dt>예상송치율</dt>
			<dd class="status_one"><span class="all_txt"><em class="value" id="trnExpPer"></em>%</span></dd>
		</dl>
		<dl>
			<dt>목표</dt>
			<dd class="status_one"><span class="all_txt"><em class="value" id="trnGoal"></em>%</span></dd>
		</dl>
	</div>
</div>
