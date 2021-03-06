<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Iterator" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<html>
	<head>
		<title>금융자료분석상세대장</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/N/N0102.js?r=<%=Math.random()%>"></script>
		<script type="text/javascript" src="${cPath }/sjpb/reference/js/ekr_fileUpload.js"></script>

	</head>
	<body class="iframe">
	
		<!-- report -->
		<form name="reportForm" method="post">
			<input type="hidden" id="reptNm" name="reptNm" value="" />
			<input type="hidden" id="xmlData" name="xmlData" value="" />
		</form>
	
		
		<!-- searchArea -->
	   <div class="searchArea">
		   <ul>
				<li><span class="title">구분</span>
				   <div class="inputbox w65per">
					   <p class="txt"></p>
					   <select id="inptOuptDivSc" name="inptOuptDivSc">
						   <option value="">전체</option>
							<c:forEach items="${inptOuptDivList}" var="inptOuptDivList" varStatus="status">
								<option value="${inptOuptDivList.code}">${inptOuptDivList.codeName}</option>
							</c:forEach>
					   </select>
				   </div>
			   </li>				   
			   <li><span class="title">거래계좌은행</span>
				   <div class="inputbox w65per">
					   <p class="txt"></p>
					   <select id="opntFincCdSc" name="opntFincCdSc">
						   <option value="">전체</option>
							<c:forEach items="${bankCodeList}" var="bank" varStatus="status">
								<option value="${bank.code}">${bank.codeName}(${bank.code})</option>
							</c:forEach>
					   </select>
				   </div>
			   </li>		   
			   <li><span class="title">입출금명</span>
				   <label for="inptOuptNmSc"></label><input type="text" class="w65per" id="inptOuptNmSc" name="inptOuptNmSc" />
			   </li>
			   <li><span class="title">영장 대상계좌번호</span>
				   <label for="wrntTrgtAcctNumSc"></label><input type="text" class="w65per" id="wrntTrgtAcctNumSc" name="wrntTrgtAcctNumSc" />
			   </li>
			   <li><span class="title">상대 대상계좌번호</span>
				   <label for="opntAcctNumSc"></label><input type="text" class="w65per" id="opntAcctNumSc" name="opntAcctNumSc" />
			   </li>	
			   	<li><span class="title">적요</span>
				   <label for="acctAbstSc"></label><input type="text" class="w50per" id="acctAbstSc" name="acctAbstSc"/>
			   </li>
			   <li><span class="title">거래조회기간</span>
				   <label for="sDateSc"></label><input type="text" class="w30per calendar datepicker" id="sDateSc" name="sDateSc" value="${sDateSc}" data-type="date" data-optional-value=true title="등록일자시작일"/> ~ <label for="eDateSc"></label><input type="text" class="w30per calendar datepicker" id="eDateSc" name="eDateSc" value="${eDateSc}" data-type="date" data-optional-value=true title="등록일자종료일"/>
			   </li>
			   <li><span class="title">거래금액</span>
				   <label for="sTrntAmtSc"></label><input type="text" class="w30per" id="sTrntAmtSc" name="sTrntAmtSc" value="${sDateSc}" data-type="date" data-optional-value=true title="등록일자시작일"/> ~ <label for="eTrntAmtSc"></label><input type="text" class="w30per" id="eTrntAmtSc" name="eTrntAmtSc" value="${eDateSc}" data-type="date" data-optional-value=true title="등록일자종료일"/>
			   </li>
			   <li></li>
			</ul>
		<div class="searchbtn"><a href="javascript:initSearchData();" class="btn_white"><span>초기화</span></a><a href="javascript:doSearch();" class="btn_blue"><span>검색</span></a></div>
	   </div>
	   <!-- searchArea //-->
	   <!-- listArea -->
	   <!-- btnArea -->
	   <div class="btnArea">
		   <div class="r_btn">
			   <a href="javascript:void(0);" id="exceldown" class="btn_white excel"><span>엑셀다운로드</span></a>
			   <a href="javascript:insertFincExcelUploadViewBtn();" id="insertFincExcelUploadViewBtn" class="btn_blue"><span>자료 업로드</span></a>
			   <a href="javascript:insertFincExcelUploadViewCloseBtn();" id="insertFincExcelUploadViewCloseBtn" class="btn_blue" style="display:none;"><span>자료 업로드 닫기</span></a>
			   <a href="javascript:deleteFincDtaDts();" id="deleteFincDtaDtsBtn" class="btn_blue"><span>삭제</span></a>
			   <a href="/sjpb/N/N0101.face" class="btn_white"><span>목록</span></a>
		   </div>
	   </div>
	   	   
	   <div id="sheet" class="listArea area-mousewheel mrt15" style="height: 300px; width: 100%">
		
	   </div>
	   

 		<table class="list" cellpadding="0" cellspacing="0">
                <caption>요청정보</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                </colgroup>
             <tbody>
             	 <form id="editForm" name="editForm" method="post" action="" >
                     <input type="hidden" name="cmd"         id="cmd" value="WRITE"/>           <%-- 작성 : WRITE, 수정 : MODIFY --%>
                     <input type="hidden" name="maxFileCnt"  id="maxFileCnt" value="1"/>        <%-- 최대파일 갯수 --%>
                     <input type="hidden" name="limitSize"   id="limitSize"  value="10485760"/> <%-- 파일별 최대 용량 --%>
                     <input type="hidden" name="totFileSize" id="totFileSize" />                <%-- 전체 파일사이즈 --%>
                     <input type="hidden" name="sizeSF"      id="sizeSF" />                     <%-- 파일 사이즈 format --%>
                     <input type="hidden" name="contents"    id="contents" />                   <%-- 본문내용, 저장시 여기 값이 저장 --%>
                     <input type="hidden" name="fileId"      id="fileId" />                      
                     <input type="hidden" name="fileNm"      id="fileNm" />
                     <input type="hidden" name="fileSize"    id="fileSize" />
                     <input type="hidden" name="fileType"    id="fileType" />
                     <input type="hidden" name="filePath"    id="filePath" />
                     <input type="hidden" name="fileCtype"   id="fileCtype" />
                     <input type="hidden" name="fileCnt"     id="fileCnt" value="0" />
                     <input type="hidden" name="delFileIds"  id="delFileIds" />             	       
                </form>
				<tr id ="insertDiv" style="display:none;">
					<th class="C first th_line" scope="col" ><span class="table_title">첨부파일</span></th>
					<td class="L td_line"  colspan="3" >	
						<form name="setFileList" method="post" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=delete">					
						<div class="addFile">
							<div class="filelist">
								<p>파일은 <span>1개까지</span> 첨부할 수 있으며, 전체 용량은 <span>100Mbyte</span>를 넘을 수 없습니다.</p>
                                 <ul id="uploadFileList">
                                 </ul>
							</div>
						</div>
                             <input type="hidden" name="semaphore" value="${semaphore}" />
                             <input type="hidden" name="vaccum" />
                             <input type="hidden" name="unDelList" />
                             <input type="hidden" name="delList" />						
						</form>
                       <form name="setUpload" method="post" enctype="multipart/form-data" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=upload&menuType=finc">
                             <input type="hidden" name="viewsize" readonly value='총 파일 크기: 0KB' />
                             <input type="hidden" name="totalsize" value="0" />
                             <input type="hidden" name="mode" value="attach" />
                             <input type="file" name="filename"  maxlength="" size="26" class="file_input" id="selectFileName"/>
                              <span id="uploading" style="display: none;" >
                                 <img src="<%=request.getContextPath()%>/board/images/board/skin/lesNotice/imgLoading.gif" align="absmiddle"/>
                                 <span id="uploadStatus"></span>
                             </span>
                            <div class="btnArea">
								<a href="#" onclick="ekrFile.uploadFile();$('#selectFileName').val('');" class="btn_blue"><span>파일추가</span></a> <a href="#" onclick="ekrFile.deleteFile();" class="btn_white"><span>파일삭제</span></a>
								<div class="r_btn" >
					        		<%-- 그리는 영역 --%>
					            	<a href="javascript:uplodateFincExcelData();" class="btn_blue"><span>저장</span></a>
					            </div>
							</div>
                         </form>						
					</td>
				</tr>               
             </tbody>
       		</table>   
	   <!-- btnArea //-->
	    
	   
        <div class="list" id="contentsArea">
        	<input type="hidden" id="fincDtaBkNum" name="fincDtaBkNum" value="${fincDtaBkNum}" />
        	<input type="hidden" id="fincDtaDtsNum" name="fincDtaDtsNum" value="" />
        </div>
	<div class="tab_mini_wrap m1" id="mngTab">                               	
	   	<ul>
			<!-- 범죄수사 상세탭 -->
	       	<li class="m1"><a href="javascript:void(0);" class="tabtitle" id="wrntTrgtAcctNumTab"><span>계좌별 통계</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents">
					<!-- 수령자 버튼 영역 -->
	       			<div class="btnArea">
						<div class="r_btn"><a href="javascript:void(0);" id="exceldownWrntTrgtAcctNum" class="btn_white excel"><span>엑셀다운로드</span></a></div>
	       			</div>
	       			<!-- listArea -->
					<div id="sheetwrntTrgtAcctNum" class="listArea mrt15 area-mousewheel" style="height: 300px; width: 100%">
						
					</div> 
					<h4 id="subTitle" style="display:none;" >계좌별 통계 상세</h4>
       				<div class="btnArea" id="exceldownWrntTrgtAcctNumAllBtnArea" style="display:none;">
						<div class="r_btn"><a href="javascript:void(0);" id="exceldownWrntTrgtAcctNumAll" class="btn_white excel"><span>엑셀다운로드</span></a></div>
	       			</div>					
					<div id="sheetwrntTrgtAcctNumList" class="listArea mrt15 area-mousewheel" style="display:none;height: 300px; width: 100%">
						
					</div>		
	
					<!-- //listArea -->
				</div>
				<!-- //tab_contents -->
			</li>
			<!-- //범죄수사 상세탭 -->
			
			<!-- 승인 이력탭 -->
			<li class="m2"><a href="javascript:void(0);" class="tabtitle" id="trntDtTab"><span>일자별 통계</span></a>
				<!-- tab_contents -->
	       		<div class="tab_mini_contents">
					<!-- listArea -->
	       			<div class="btnArea">
						<div class="r_btn"><a href="javascript:void(0);" id="exceldownTrantDt" class="btn_white excel"><span>엑셀다운로드</span></a></div>
	       			</div>					
					<div id="trantDtSheet" class="listArea mrt15 area-mousewheel" style="height: 300px; width: 100%">
					</div>
					<h4 id="subTitleDay" style="display:none;" >일자별 통계 상세</h4> 		
	       			<div class="btnArea" id="exceldownTrantDtAllBtnArea" style="display:none;">
						<div class="r_btn"><a href="javascript:void(0);" id="exceldownTrantDtAll" class="btn_white excel"><span>엑셀다운로드</span></a></div>
	       			</div>					
					<div id="dayAllSheet" class="listArea mrt15 area-mousewheel" style="display:none;height: 300px; width: 100%">
					</div> 					
					<!-- //listArea -->
				</div>
				<!-- //tab_contents  -->
			</li>
			<!-- //승인 이력탭 -->
		</ul>
	</div>
	<!-- //contentsArea -->        
		
		
	</body>
	 <iframe name='invisible' frameborder="0" width="0" height="0"></iframe>
</html>
<script>
autoResize();
window.onload = ekrFile.edit_init;
</script>