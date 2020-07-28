<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <div class="portlet p_2auto monitering">
 	<div class="portlet_bg">
		<h2 class="fl">사건현황 <span>모니터링</span></h2>
<%-- 		<c:if test="${not empty yearList }"> --%>
<!-- 			<div class="inputbox w15per"> -->
<!-- 				<p class="txt" id="curYearMonitor"></p> -->
<!-- 				<select onchange="javascript:processYearMonitor(this.value);"> -->
<%-- 					<c:forEach items="${yearList }" var="year"> --%>
<%-- 						<option value="${year}">${year}</option> --%>
<%-- 					</c:forEach> --%>
<!-- 				</select> -->
<!-- 			</div> -->
<%-- 		</c:if> --%>
		<table class="list" cellpadting="0" cellspacing="0">
			<colgroup>
				<col width="*%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>  
			<thead>
				<tr>
					<th rowspan="2" class="C">구분</th>
					<th rowspan="2" class="C">내사중</th>
					<th colspan="2" class="C">수사중</th>
					<th rowspan="2" class="C">지휘중</th>
					<th colspan="2" class="C">송치</th>
					<th colspan="2" class="C no_border">송치율</th>
				</tr>
				<tr>    
					<th class="C">고발</th>
					<th class="C">인지</th>
					<th class="C">고발</th>
					<th class="C">인지</th>
					<th class="C">고발</th>
					<th class="C no_border">인지</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${part == 'T' }">
					<c:forEach items="${statList}" var="stat" varStatus="status">
						<tr <c:if test="${stat.criTmDiv == 'total' }">class="txt_on"</c:if>>
							<td class="C first_txt" rowspan="2">${stat.sort }</td>
							<td class="C" rowspan="2" id="secinv_${stat.criTmId }">${stat.secinv }</td>
							<td class="C" colspan="2" id="invst_${stat.criTmId }">${stat.invst }</td>
							<td class="C" rowspan="2" id="cmnd_${stat.criTmId }">${stat.cmnd }</td>
							<td class="C" colspan="2" id="trnsr_${stat.criTmId }">${stat.trnsr }</td>
							<td class="C no_border" colspan="2" id="trnsrPer_${stat.criTmId }">${stat.trnsrPer }%</td>
						</tr>	
						<tr <c:if test="${stat.criTmDiv == 'total'}">class="txt_on"</c:if>>
							<td class="C" id="accuse_${stat.criTmId }">${stat.accuse}</td>
							<td class="C" id="papstmp_${stat.criTmId }">${stat.papstmp}</td>
							<td class="C" id="trnAccus_${stat.criTmId }">${stat.trnAccus}</td>
							<td class="C" id="trnPapst_${stat.criTmId }">${stat.trnPapst}</td>
							<td class="C" id="trnAccusPer_${stat.criTmId }">${stat.trnAccusPer}%</td>
							<td class="C" id="trnPapstPer_${stat.criTmId }">${stat.trnPapstPer}%</td>
						</tr>
					</c:forEach>
				</c:if>		
				<c:if test="${part != 'T' }">
					<c:forEach items="${statList}" var="stat" varStatus="status">
						<c:if test="${stat.criTmDiv == 'total' }">
							<tr class="txt_on">
								<td class="C first_txt" rowspan="2">
									<c:if test="${not empty stat.dept}">
										<a href="javascript:ptl03(${stat.dept });">
											<img src="/sjpb/images/btn_down.gif" alt="펼치기" id="btnUpDown_${stat.dept }"/>
										</a>
									</c:if>
									${stat.sort }
								</td>
								<td class="C" rowspan="2" id="secinv_${stat.criTmId }">${stat.secinv }</td>
								<td class="C" colspan="2" id="invst_${stat.criTmId }">${stat.invst }</td>
								<td class="C" rowspan="2" id="cmnd_${stat.criTmId }">${stat.cmnd }</td>
								<td class="C" colspan="2" id="trnsr_${stat.criTmId }">${stat.trnsr }</td>
								<td class="C no_border" colspan="2" id="trnsrPer_${stat.criTmId }">${stat.trnsrPer }%</td>
							</tr>	
							<tr class="txt_on" >
								<td class="C" id="accuse_${stat.criTmId }">${stat.accuse}</td>
								<td class="C" id="papstmp_${stat.criTmId }">${stat.papstmp}</td>
								<td class="C" id="trnAccus_${stat.criTmId }">${stat.trnAccus}</td>
								<td class="C" id="trnPapst_${stat.criTmId }">${stat.trnPapst}</td>
								<td class="C" id="trnAccusPer_${stat.criTmId }">${stat.trnAccusPer}%</td>
								<td class="C" id="trnPapstPer_${stat.criTmId }">${stat.trnPapstPer}%</td>
							</tr>
						</c:if>
						<c:if test="${stat.criTmDiv != 'total' }">
							<tr name="${stat.dept }" style="display:none">
								<td class="C first_txt" rowspan="2">${stat.sort }</td>
								<td class="C" rowspan="2" id="secinv_${stat.criTmId }">${stat.secinv }</td>
								<td class="C" colspan="2" id="invst_${stat.criTmId }">${stat.invst }</td>
								<td class="C" rowspan="2" id="cmnd_${stat.criTmId }">${stat.cmnd }</td>
								<td class="C" colspan="2" id="trnsr_${stat.criTmId }">${stat.trnsr }</td>
								<td class="C no_border" colspan="2" id="trnsrPer_${stat.criTmId }">${stat.trnsrPer }%</td>
							</tr>	
							<tr name="${stat.dept }" style="display:none">
								<td class="C" id="accuse_${stat.criTmId }">${stat.accuse}</td>
								<td class="C" id="papstmp_${stat.criTmId }">${stat.papstmp}</td>
								<td class="C" id="trnAccus_${stat.criTmId }">${stat.trnAccus}</td>
								<td class="C" id="trnPapst_${stat.criTmId }">${stat.trnPapst}</td>
								<td class="C" id="trnAccusPer_${stat.criTmId }">${stat.trnAccusPer}%</td>
								<td class="C" id="trnPapstPer_${stat.criTmId }">${stat.trnPapstPer}%</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:if>		
			</tbody>
		</table>
	</div>
</div>
<script>
// $( document ).ready(function(){
// 	var currentTime = new Date();
// 	var year = currentTime.getFullYear();
// 	alert("ASDASD");
// 	processYearMonitor(year);
// });
function processYearMonitor(value){
	$.ajax({
		type: "POST",
		url: "/sjpb/Z/PTL03.face",
		data: {"year":value},
		datatype : 'json',
		success: function(data){
			$.each(data.statList, function(i, monitor) {
				if(monitor.criTmId == null){
					monitor.criTmId='';
				}
				$("#secinv_"+monitor.criTmId).html(monitor.secinv);
				$("#invst_"+monitor.criTmId).html(monitor.invst);
				$("#cmnd_"+monitor.criTmId).html(monitor.cmnd);
				$("#trnsr_"+monitor.criTmId).html(monitor.trnsr);
				$("#trnsrPer_"+monitor.criTmId).html(monitor.trnsrPer);
				$("#accuse_"+monitor.criTmId).html(monitor.accuse);
				$("#papstmp_"+monitor.criTmId).html(monitor.papstmp);
				$("#trnAccus_"+monitor.criTmId).html(monitor.trnAccus);
				$("#trnPapst_"+monitor.criTmId).html(monitor.trnPapst);
				$("#trnAccusPer_"+monitor.criTmId).html(monitor.trnAccusPer);
				$("#trnPapstPer_"+monitor.criTmId).html(monitor.trnPapstPer);
			});
			$("#curYearMonitor").html(data.curYearMonitor);
		},error : function(request,status,error) {
			alert("code:"+ request.status+ "\n"+ "message:"+ request.responseText+ "\n"+ "error:"+ error);
		}
	});
}

function ptl03(name){
	
	if($("tr[name~="+name+"]").css("display")=='none'){
		$("tr[name~="+name+"]").css("display","");
		$("#btnUpDown_"+name).attr("src","/sjpb/images/btn_up.gif");
		$("#btnUpDown_"+name).attr("alt","접기");
	}else if($("tr[name~="+name+"]").css("display")=='table-row' || $("tr[name~="+name+"]").css("display")=='' || $("tr[name~="+name+"]").css("display")=='block'){
		$("tr[name~="+name+"]").css("display","none");
		$("#btnUpDown_"+name).attr("src","/sjpb/images/btn_down.gif");
		$("#btnUpDown_"+name).attr("alt","펼치기");
	}
	
}
</script>
