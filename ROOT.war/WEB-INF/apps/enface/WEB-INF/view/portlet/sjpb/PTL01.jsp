<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet_2_0" %>

<div class="portlet p_22">
	<h2>수사업무 <span>처리현황</span></h2>
	<div id="small_step_tab">
    	<ul class="small_step_tab ocrt_tab clearfix">
			<c:forEach items="${codeList}" var="item" varStatus="status">
				<li class="ocrt_sub_tab<c:if test="${status.index == 0 }"> sub_tab_on</c:if>" id="ocrt_list_tab${status.index}">
					<span class="on<c:if test="${status.index == 0 }"> first</c:if>">
						<a href="javascript:ajaxPTL01('${item.codeId}','${item.remark}','${status.index}','${item.codeName2}');">${item.codeName}<em id="tab_num${status.index}">${item.codeTag1}건</em></a>
					</span>
				</li>
			</c:forEach>
		</ul>
		<div class="ocrt_wrap_02 clearfix">
	        
	        <div class="ocrt_01 ocrt_list_tab list">
	            <div class="bottom_list">
					<div class="table_title">
						<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="20%" />
								<col width="*%" />
								<col width="8%" />
								<col width="12%" />
								<col width="25%" />
							</colgroup>   
							<thead>
								<tr class="top">
									<th class="C">사건번호</th>
									<th class="C">사건내용</th>
									<th class="C">수사관</th>
									<th class="C">요청일</th>
									<th class="C">상태</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="event_scroll">	
						<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="20%" />
								<col width="*%" />
								<col width="8%" />
								<col width="12%" />
								<col width="25%" />
							</colgroup>   
				                    
							<tbody id="vvvv">
								<c:if test="${not empty statCdList}">
									<c:forEach items="${statCdList}" var="stat">
										<tr>
											<td class="C first_txt"><span class="reqVio">${stat.rcptIncNum }</span></td>
											<td class="L">
												<a href="javascript:void();" class="lmenuOpen" id="tm001_sm002" data-root="tm001" data-title="사건관리" rel="/sjpb/B/B0101.face?rcptNum=${stat.rcptNum }">					
													<span class="title reqVio">
														<c:if test="${not empty stat.vioCont or not empty stat.rltActCriNmCdDesc }">
															<c:if test="${not empty stat.rltActCriNmCdDesc }">
																<b>[ ${stat.rltActCriNmCdDesc }
																<c:if test="${stat.vioCount != 0 }">
																	외${stat.vioCount }개 위반
																</c:if>
																]</b> 
															</c:if>
															${stat.vioCont }
														</c:if>
														<c:if test="${empty stat.vioCont and empty stat.rltActCriNmCdDesc }">
															${stat.criStatCdDesc }
														</c:if>
													</span>
												</a>
											</td>
											<td class="C">${stat.nmKor }</td>
											<td class="C">${stat.updDate }</td>
											<td class="C">
												<a href="javascript:void(0);" class="lmenuOpen" id="tm001_sm002" data-root="tm001" data-title="사건관리" rel="/sjpb/B/B0101.face?rcptNum=${stat.rcptNum }">
													<span class="<c:if test="${stat.criStatCd>=20 and stat.criStatCd<=46 }">notice_05</c:if>  <%-- 남색--%>
																<c:if test="${stat.criStatCd>=50 and stat.criStatCd<70 }">notice_01</c:if>  <%-- 주황색--%>
																<c:if test="${stat.criStatCd>=70 and stat.criStatCd<80}">notice_07</c:if>  <%-- 연두색--%>
																<c:if test="${stat.criStatCd>=90 and stat.criStatCd<=99}">notice_03</c:if>  <%-- 밝은회색--%>
																">
														${stat.criStatCdDesc }
													</span>
												</a>														
											</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty statCdList}">
									<tr>
										<td class="C" colspan="6">
											수사업무 요청처리현황이 없습니다.
										</td>
									</tr>
								</c:if>					
							</tbody>
						</table>	
					</div>
				</div>
			</div>
		</div>
	<!-- 피의자 이력 비교 팝업 -->
	<form id="spHistPopForm" name="spHistPopForm">
		<input type="hidden" id="incMfNum" name="incMfNum" value="" />	<!-- 사건수정번호 -->	
		<input type="hidden" id="rcptNum" name="rcptNum" value="" />	<!-- 사건수정번호 -->   
	</form>
	</div>
</div>

<script>
$( document ).ready(function(){
	$(".ocrt_sub_tab").click(function(){
		var f = $(this).siblings();
		var num = $(this).attr("id");
		
		$(f).each(function( index ) {
			var n = $(this).attr("id");
			$(this).removeClass("sub_tab_on");
			$("." + n ).hide();
		});
		
		$(this).addClass("sub_tab_on");
		$("." + num ).show();
	});
});



function ajaxPTL01(criStatCdArray,type,ord,endStatCdArray){
 	$.ajax({
		url			: "/sjpb/Z/PTL0101.face",
		type		: "POST",
		dataType	: "json",
		data		: {"criStatCdArray" : criStatCdArray,"type" : type,"ord" : ord,"endStatCdArray":endStatCdArray},
		cache		: false,
		success: function (result) {
			var StringBuffer = function(){
				this.buffer = new Array();
			};
			StringBuffer.prototype.append = function(str){
				this.buffer.push(str);
				return this;
			};
			StringBuffer.prototype.toString = function(){
				return this.buffer.join("");
			};
			
			
			var spHtml = new StringBuffer();
			$("#vvvv").empty();
			$("#tab_num"+result.ord).html(result.cdSize+"건");
			if(result.statCdList.length != 0){
				$.each(result.statCdList, function(i, stat) {
					spHtml.append('<tr>');
					spHtml.append('<td class="C first_txt"><span class="reqVio">');
					if(stat.rcptIncNum != null){
						spHtml.append(stat.rcptIncNum);
					}
					spHtml.append('</span></td>');
					spHtml.append('<td class="L">');
					
					spHtml.append('<a href="javascript:void(0);" class="lmenuOpen" id="tm001_sm002" data-root="tm001" data-title="사건관리" rel="/sjpb/B/B0101.face?rcptNum='+stat.rcptNum+'">');
					
					spHtml.append('<span class="title reqVio">');
					if( stat.vioCont != null || stat.rltActCriNmCdDesc != null){
						if(stat.rltActCriNmCdDesc != null){
							spHtml.append('<b>['+stat.rltActCriNmCdDesc);
							if(stat.vioCount != 0){
								spHtml.append('외'+stat.vioCount+'개 위반');
							}
							spHtml.append(']</b>');
						}
						spHtml.append(stat.vioCont);
					}else{
						spHtml.append(stat.criStatCdDesc);
					}
					spHtml.append('</span>');
					spHtml.append('</a>');
					spHtml.append('</td>');
					spHtml.append('<td class="C">'+stat.nmKor+'</td>');
					spHtml.append('<td class="C">'+stat.updDate+'</td>');
					spHtml.append('<td class="C">');
					spHtml.append('<a href="javascript:void(0);" class="lmenuOpen" id="tm001_sm002" data-root="tm001" data-title="사건관리" rel="/sjpb/B/B0101.face?rcptNum='+stat.rcptNum+'">');
						
					if(stat.criStatCd>=20 && stat.criStatCd<=46) {
						spHtml.append('<span class="notice_05">'+stat.criStatCdDesc+'</span>'); 
					}else if(stat.criStatCd>=50 && stat.criStatCd<70){
						spHtml.append('<span class="notice_01">'+stat.criStatCdDesc+'</span>'); 
					}else if(stat.criStatCd>=70 && stat.criStatCd<80){
						spHtml.append('<span class="notice_07">'+stat.criStatCdDesc+'</span>');
					}else if(stat.criStatCd>=90 && stat.criStatCd<=99){
						spHtml.append('<span class="notice_03">'+stat.criStatCdDesc+'</span>');
					}
					spHtml.append('</a>');
					spHtml.append('</td></tr>');
					
				});
			}else{
				spHtml.append('<tr>');
				spHtml.append('	<td class="C" colspan="5">');
				spHtml.append('		수사업무 요청처리현황이 없습니다.');
				spHtml.append('	</td>');
				spHtml.append('</tr>');
			}
			
			$("#vvvv").html(spHtml.toString());	
			
		},
		error: function (xhr, status, error) {
			alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
		}
	});
}
		
</script>