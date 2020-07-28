<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Iterator"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld"%>

<html>
<head>
<title>사건수사지휘부</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-style-type" content="text/css" />

<script type="text/javascript">
        
        	//const CRI_DTA_CATG_CD = "8916" //수사지휘자료
        	const CRI_DTA_CATG_CD = "${criDtaCatgCd}"; //수사지휘자료
        	
			var uploadInitFlag = false;  //vaultUploader 업로드 호출 여부 플래그
			function initEditActionManager() {
				if(uploadInitFlag == false){
					uploadInitFlag = sjpbFile.init(); //vaultUploader 업로드 호출이 안되어있을시에만 업로드 모듈 초기화
				}
			}
	
		   	$(document).ready(function () {
		   	 	initEditActionManager();		  
		   	});

		   </script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/sjpb/js/C/C0101.js?r=<%=Math.random()%>"></script>

</head>
<body class="iframe">
	<!-- report -->
	<form name="reportForm" method="post">
		<input type="hidden" id="reptNm" name="reptNm" value="" /> 
		<input type="hidden" id="xmlData" name="xmlData" value="" />
	</form>
	<!-- contents -->
	<form name="contentsFormData" id="contentsFormData">
		<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />
		<!-- 사용자계정 -->
		<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />
		<!-- 사용자이름 -->
		<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />
		<!-- 수사팀코드 -->
		<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />
		<!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->
		<input type="hidden" id="today" name="today" value="${today}" />
		<!-- 오늘날짜 -->
		<!-- searchArea -->
		<div class="searchArea">
			<ul>
				<li><span class="title">관할지점</span>
					<div class="inputbox w65per">
						<p class="txt"></p>
						<select id="respDppoCdSC" name="respDppoCdSC">
							<option value="">전체</option>
							<c:forEach items="${respDppoCdList}" var="item">
								<option value="${item.code}">${item.codeName}</option>
							</c:forEach>
						</select>
					</div></li>
				<li><span class="title">담당자</span> <label for="nmKorSC"></label><input type="text" class="w65per" id="respTrfOffiSC" name="respTrfOffiSC" /></li>
				<li><span class="title">지휘일자</span> <label for="beDtFromSC"></label><input type="text" class="w30per calendar datepicker" id="criCmdProDtFromSC" name="criCmdProDtFromSC" value="${criCmdProDtFromSC}" /> ~ <label for="txt_03"></label>
				<input type="text" class="w30per calendar datepicker" id="criCmdProDtToSC"name="criCmdProDtToSC" value="${criCmdProDtToSC}" /></li>
				<li><span class="title">사건번호</span> <label for="rcptIncNumSC"></label><input type="text" class="w65per" id="rcptIncNumSC" name="rcptIncNumSC" />
				</li>
				<li><span class="title">피의자</span> <label for="spNmSC"></label><input type="text" class="w65per" id="spNmSC" name="spNmSC" />
				</li>
				<li></li>
			</ul>
			<div class="searchbtn">
				<a href="#" class="btn_white" id="initBtn"><span>초기화</span></a>
				<a href="#" class="btn_blue" id="srchBtn"><span>검색</span></a>
			</div>
		</div>
		<!-- searchArea //-->
		<!-- listArea -->
		<div id="sheet" class="listArea" style="height: 200px; width: 100%">
		</div>
		<!-- listArea //-->
		<!-- btnArea -->
		<div class="btnArea">
			<div class="r_btn">
				<a href="#" class="btn_white" id="cmdBkDelBtn"><span>삭제</span></a>
				<a href="#" class="btn_white" id="newBtn"><span>사건수사지휘부신규</span></a>
			</div>
		</div>
		<!-- btnArea //-->
		<div class="tab_mini_wrap m1" id="contentsArea">
			<ul>
				<li class="m1"><a href="#" class="tabtitle" id="intiIncTab"><span>사건수사지휘부상세</span></a>
				 <!-- tab_contents -->
					<div class="tab_mini_contents" id="tab_mini_m1_contents">
						<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="15%" />
								<col width="35%" />
								<col width="15%" />
								<col width="35%" />
							</colgroup>
							<tbody>
								<tr>
									<th class="C">관할지검</th>
									<td class="L">
										<div class="inputbox w50per">
											<p class="txt"></p>
											<select id="respDppoCd" name="respDppoCd" data-type="select">
												<option value="">선택</option>
												<c:forEach items="${respDppoCdList}" var="item">
													<option value="${item.code}">${item.codeName}</option>
												</c:forEach>
											</select>
										</div>
									</td>
									<th class="C">지휘년월일</th>
									<td class="L"><label for="criCmdProDt"></label>
									<input type="text" data-type="date" data-optional-value="true"data-error-message="유효한 날짜를 입력해주세요."class="50per calendar datepicker" name="criCmdProDt"id="criCmdProDt" /></td>
								</tr>
							</tbody>
						</table>
						<p>&nbsp;</p>
						<div id="sheetItem" class="listArea"style="height: 200px; width: 100%"></div>
						<div class="btnArea" id="step1Btn">
							<div class="r_btn">
								<a href="#" class="btn_white" id="addBtn"><span>추가 </span></a>
								<a href="#" class="btn_white" id="delBtn"><span>삭제 </span></a> 
								<a href="#" class="btn_white" id="saveBtn"><span>저장 </span></a>
								<a href="#" class="btn_white" id="prnBtn"><span>출력 </span></a> 
								<a href="#" class="btn_blue" id="comfBtn"><span>지휘요청완료</span></a>
							</div>
						</div>
                       	<div class="btnArea" id="step2Btn">
					   	      <div class="r_btn">										   	    
						   	    <a href="#" class="btn_blue" id="prnBtn2"><span>출력 </span></a>												   	    
					   	      </div>
					    </div>  						

					</div> <!-- tab_contents //--></li>
			</ul>
		</div>

		<!--//ocrt_wrap-->
		<div class="ocrt_wrap clearfix" id="step2Area">
			<!--사건관리-->
			<div class="ocrt_01 ocrt_list_tab0 list"></div>
		</div>
		<!--//ocrt_wrap-->
		<!--//ocrt_wrap-->
		<div class="ocrt_wrap clearfix" id="step3Area">
			<!--사건관리-->
			<div class="ocrt_01 ocrt_list_tab0 list">
				<h4>지휘서류 업로드</h4>
				<div id="vault_upload" class="righr_box"></div>
				<ul id="vault_fileList" style="display: none;">
				</ul>
				<form name="setFileList" method="post" target="invisible" action="${cPath }/sjpb/fileMngr?cmd=delete">
					<input type=hidden name=semaphore value="<c:out value=""/>">
					<input type=hidden name=vaccum> 
					<input type=hidden name=delBoardId value="<c:out value=""/>">
					<input type=hidden name=unDelList> 
					<input type=hidden name=delList> 
					<input type=hidden name=subId value=sub01>
				</form>
				<div class="btnArea">
					<div class="r_btn">
						<a href="#" id="fileBtn" class="btn_white"><span>저장</span></a>
					</div>
				</div>
			</div>
			<h4>지휘서류 목록</h4>
			<div id="sheetDT" class="listArea area-mousewheel"style="height: 200px; width: 100%"></div>
		</div>
		<!--//ocrt_wrap-->
	</form>
	<!-- contents //-->
</body>


</html>

