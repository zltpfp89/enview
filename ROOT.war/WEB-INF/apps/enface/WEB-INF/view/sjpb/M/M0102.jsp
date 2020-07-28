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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-style-type" content="text/css" />
	<title>압수부</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0102.js?r=<%=Math.random()%>"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/reference/js/ekr_fileUpload.js"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0102_searchList" id="m0102_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0102_pageInit()">
			<ul>
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" name="rcptIncNumSc"/>
				</li>		   
				<li><span class="title">등록일자</span>
					<label for="regStart"></label><input type="text" id="regStart" name="regStart" class="w30per calendar datepicker" readonly/>~
					<label for="regEnd"></label><input type="text" id="regEnd" name="regEnd" class="w30per calendar datepicker" readonly/>
				</li>
				<li>
				</li>
			</ul>
			<div class="searchbtn">
				<a href="javascript:fn_M_init('m0102_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0102_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
			</div>
		</form>
   </div>
   <!-- searchArea //-->
	
	<!-- listArea -->
	<div id="listSheet" class="listArea mrt15 area-mousewheel" style="height: 500px; width: 100%"></div>
	<!-- listArea// -->
	
	<!-- report -->
	<form name="reportForm" method="post">
		<input type="hidden" id="reptNm" name="reptNm" value="" />
		<input type="hidden" id="xmlData" name="xmlData" value="" />
	</form>
	<!-- //report -->
	<!-- btnArea -->
	<div class="btnArea">
		<div class="r_btn">
			<!--  
			<a href="${pageContext.request.contextPath}/statics/sample/압수부 서식.xlsx" title="다운로드" class="btn_white"><span>서식 다운로드</span></a>
			<form id="editForm" name="editForm" method="post" action="" style="display: inline-block; visibility: hidden;">
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
			<form name="setFileList" method="post" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=delete" style="display: inline-block; visibility: hidden;">					
				<div class="addFile">
					<div class="filelist">
                        <ul id="uploadFileList">
                        </ul>
					</div>
				</div>
                <input type="hidden" name="semaphore" value="${semaphore}" />
                <input type="hidden" name="vaccum" />
                <input type="hidden" name="unDelList" />
                <input type="hidden" name="delList" />						
			</form>
			<form name="setUpload" method="post" enctype="multipart/form-data" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=upload&menuType=seiz" style="display: inline-block; visibility: hidden;">
	            <input type="hidden" name="viewsize" readonly value='총 파일 크기: 0KB' />
	            <input type="hidden" name="totalsize" value="0" />
	            <input type="hidden" name="mode" value="attach" />
	            <input type="file" name="filename"  maxlength="" size="26" class="file_input" id="selectFileName" accept=".xls,.xlsx" onchange="ekrFile.uploadFile();$(this).val('');" />
                <span id="uploading" style="display: none;" >
                   <img src="<%=request.getContextPath()%>/board/images/board/skin/lesNotice/imgLoading.gif" align="absmiddle"/>
                   <span id="uploadStatus"></span>
               	</span>
            </form>	
            	
			<a href="javascript:$('#selectFileName').click();" class="btn_blue" id="btnExcelUpload"><span>엑셀 업로드</span></a>
			-->
			<a href="javascript:fn_M0102_new();" class="btn_light_blue new2" id="btnNew" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0102_prtCheckReport();" class="btn_white print" id="btnPrtCheck"  data-view-type="mng"><span>대장 출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 압수부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>압수부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0102" name="M0102">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="seizBkSiNum" id="seizBkSiNum"/>
	       				<input type="hidden" name="regUserId" id="regUserId"/>
	       				
		       			<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="15%" />
			                    <col width="35%" />
			                    <col width="15%" />
			                    <col width="35%" />
							</colgroup>
							<tbody>
								<tr>
									<th class="C th_line">압수부번호</th>
									<td class="L td_line">
										<input type="text" id="seizBkNum" name="seizBkNum" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C th_line">압수물번호</th>
									<td class="L td_line">
										<input type="text" id="seizProdNum" name="seizProdNum" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C th_line">범죄사건부번호</th>
									<td class="L td_line">
										<span id="incNum" name="incNum"></span>
									</td>
									<th class="C th_line">압수연월일</th>
									<td class="L td_line">
										<input type="text" id="seizDt" name="seizDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C th_line">압수물건 품종</th>
									<td class="L td_line">
										<input type="text" id="seizProdKind" name="seizProdKind" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C th_line">압수물건 수량</th>
									<td class="L td_line">
										<input type="text" id="seizProdQnty" name="seizProdQnty" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">소유자 주거</th>
									<td class="L td_line">
										<input type="text" id="ownrAddr" name="ownrAddr" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C th_line">소유자 성명</th>
									<td class="L td_line">
										<input type="text" id="ownrNm" name="ownrNm" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C th_line">피압수자 주거</th>
									<td class="L td_line">
										<input type="text" id="revIpdrAddr" name="revIpdrAddr" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C th_line">피압수자 성명</th>
									<td class="L td_line">
										<input type="text" id="revIpdrNm" name="revIpdrNm" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C th_line">보관자확인</th>
									<td class="L td_line" >
										<input type="text" id="csdnNm" name="csdnNm" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C th_line">취급자확인</th>
									<td class="L td_line">
										<input type="text" id="trsrNm" name="trsrNm" class="w100per" disabled="disabled" maxlength="30"/>									
									</td>
								</tr>
								<tr>
									<th class="C th_line">처분연월일</th>
									<td class="L td_line">
										<input type="text" id="dipDt" name="dipDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C th_line">처분요지</th>
									<td class="L td_line">
										<input type="text" name="dipGist" id="dipGist" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C th_line">비고</th>
									<td class="L td_line" colspan="3">
										<input type="text" id="seizBkComn" name="seizBkComn" class="w100per" disabled="disabled" maxlength="300"/>								
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<!-- btnArea -->
					<div class="btnArea">
						<div class="r_btn" data-view-type="inc">
							<a href="javascript:fn_M0102_insert();" class="btn_light_blue save" style="display:none;" id="btnInsert" data-view-type="inc"><span>저장</span></a>
							<a href="javascript:fn_M0102_update();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdate" data-view-type="inc"><span>수정</span></a>
						</div>
					</div>
				</div>
			</li>
		</ul>
	</div>
</body>
<iframe name='invisible' frameborder="0" width="0" height="0"></iframe>
</html>
<script>
window.onload = ekrFile.edit_init;
</script>