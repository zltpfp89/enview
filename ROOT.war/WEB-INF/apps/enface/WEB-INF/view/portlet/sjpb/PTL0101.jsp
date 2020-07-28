<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet_2_0" %>

<div class="portlet p_22">
	<h2>수사업무 <span>요청처리 현황</span></h2>
	<div class="table_title">
		<table class="list" cellpadding="0" cellspacing="0">
			<colgroup>
				<col width="12%" />
				<col width="*%" />
				<col width="12%" />
				<col width="12%" />
				<col width="15%" />
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
				<col width="12%" />
				<col width="*%" />
				<col width="12%" />
				<col width="12%" />
				<col width="15%" />
			</colgroup>                        
			<tbody>
				<c:if test="${not empty statCdList}">
					<c:forEach items="${statCdList}" var="stat">
						<tr>
							<td class="C first_txt">${stat.rcptIncNum }</td>
							<td class="L">
								<c:if test="${stat.criStatCd != 1 }">
									<c:if test="${stat.criStatCd<20 }">
										<a href="javascript:void();" class="lmenuOpen" id="tm001_sm001" data-root="tm001" data-title="내사사건관리" rel="/sjpb/A/A0101.face">
									</c:if>
									<c:if test="${stat.criStatCd>=20 }">
										<a href="javascript:void();" class="lmenuOpen" id="tm001_sm002" data-root="tm002" data-title="사건관리(인지/고발)" rel="/sjpb/B/B0101.face">
									</c:if>
								</c:if>
								<c:if test="${stat.criStatCd==1 }">
									<a href="javascript:void();" class="lmenuOpen" id="tm003_sm002" data-root="tm003" data-title="범죄수사자료조회" rel="/sjpb/F/F0101.face">
								</c:if>
								<span class="title">
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
								<c:if test="${stat.criStatCd != 1 }">
									<c:if test="${stat.criStatCd<20 }">
										<a href="javascript:void();" class="lmenuOpen" id="tm001_sm001" data-root="tm001" data-title="내사사건관리" rel="/sjpb/A/A0101.face">
											<span class="notice_04">${stat.criStatCdDesc }</span>
										</a>
									</c:if>
									<c:if test="${stat.criStatCd>=20 }">
										<a href="javascript:void();" class="lmenuOpen" id="tm001_sm002" data-root="tm002" data-title="사건관리(인지/고발)" rel="/sjpb/B/B0101.face">
											<span class="<c:if test="${stat.criStatCd>=20 and stat.criStatCd<30 }">notice_05</c:if>
														<c:if test="${stat.criStatCd>=30 and stat.criStatCd<=40 }">notice_06</c:if>
														<c:if test="${stat.criStatCd>=50 and stat.criStatCd<60}">notice_01</c:if>
														<c:if test="${stat.criStatCd>=70 and stat.criStatCd<80 }">notice_07</c:if>
														<c:if test="${stat.criStatCd>=90 and stat.criStatCd<95 }">notice_03</c:if>
														">
												${stat.criStatCdDesc }
											</span>
										</a>
									</c:if>
								</c:if>
								<c:if test="${stat.criStatCd==1 }">
									<a href="javascript:void();" class="lmenuOpen" id="tm003_sm002" data-root="tm003" data-title="범죄수사자료조회" rel="/sjpb/F/F0101.face">
										<span class="notice_02">${stat.criStatCdDesc }</span>
									</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty statCdList}">
					<tr>
						<td class="C" colspan="5">
							수사업무 요청처리현황이 없습니다.
						</td>
					</tr>
				</c:if>					
			</tbody>
		</table>	
	</div>
</div>