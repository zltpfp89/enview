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
		<title>금융자료분석대장</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/N/N0101.js?r=<%=Math.random()%>"></script>
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
			   <li><span class="title">계좌은행</span>
				   <div class="inputbox w65per">
					   <p class="txt"></p>
					   <select id="fincCdSc" name="fincCdSc">
						   <option value="">전체</option>
							<c:forEach items="${bankCodeList}" var="bank" varStatus="status">
								<option value="${bank.code}">${bank.codeName}(${bank.code})</option>
							</c:forEach>
					   </select>
				   </div>
			   </li>		   
			   <li><span class="title">제목</span>
				   <label for="fincDtaSbjtSc"></label><input type="text" class="w65per" id="fincDtaSbjtSc" name="fincDtaSbjtSc" />
			   </li>
			   <li><span class="title">영장 대상계좌번호</span>
				   <label for="wrntTrgtAcctNumSc"></label><input type="text" class="w65per" id="wrntTrgtAcctNumSc" name="wrntTrgtAcctNumSc" />
			   </li>
		   </ul>
		<div class="searchbtn"><a href="javascript:initSearchData();" class="btn_white"><span>초기화</span></a><a href="javascript:doSearch();" class="btn_blue"><span>검색</span></a></div>
	   </div>
	   <!-- searchArea //-->
	   <!-- listArea -->
	   <div id="sheet" class="listArea area-mousewheel mrt15" style="height: 300px; width: 100%">
		
	   </div>
	   
	   <!-- btnArea -->
	   <div class="btnArea">
		   <div class="r_btn"><a href="javascript:insertFincDtaViewBtn();" id="insertFincDtaViewBtn" class="btn_blue"><span>신규</span></a><a href="javascript:deleteFincDta();" id="deleteFincDtaBtn" class="btn_white"><span>삭제</span></a></div>
	   </div>
	   <!-- btnArea //-->
	   
	   
        <div class="list" id="contentsArea">
        	<input type="hidden" id="fincDtaBkNum" name="fincDtaBkNum" value="" />
	   		<h4 id="subTitle" >신규</h4>
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
                     <input type="hidden" name="fileSize"    id="fileSize" />
                     <input type="hidden" name="fileType"    id="fileType" />
                     <input type="hidden" name="filePath"    id="filePath" />
                     <input type="hidden" name="fileCtype"   id="fileCtype" />
                     <input type="hidden" name="fileCnt"     id="fileCnt" value="0" />
                     <input type="hidden" name="delFileIds"  id="delFileIds" />             	 
             	 <tr>
                	<th class="C th_line">제목 <em class="red">*</em></th>
                	<td class="L td_line" colspan="3"><label for="fincDtaSbjt"></label><input type="text" class="w100per" id="txt_01" name="fincDtaSbjt" id="fincDtaSbjt" title="제목" data-type="required"/></td>
                </tr>
                
                <tr>
                	<th class="C th_line ">계좌은행 <em class="red">*</em></th>
                	<td class="L td_line ">
						<div class="inputbox w100per">
							<p class="txt"></p>
							<select id="fincCd" name="fincCd" data-type="select" title ="계좌은행은">
								<option value="-1">선택</option>
							<c:forEach items="${bankCodeList}" var="bank" varStatus="status">
								<option value="${bank.code}">${bank.codeName}(${bank.code})</option>
							</c:forEach>
							</select>
						</div>
					</td>
                	<th class="C th_line ">영장대상계좌번호 <em class="red">*</em></th>
                	<td class="L td_line "><label for="wrntTrgtAcctNum"></label><input type="text" class="w80per" id="wrntTrgtAcctNum" name="wrntTrgtAcctNum" title="영장대상계좌번호"  data-type="required"/></td>
                </tr>
                	 <input type="hidden" name="fileNm"id="fileNm" data-type="required" title="첨부파일" />     
                </form>
                <tr id ="insertTDiv">
                	<th class="C th_line ">은행별 엑셀 업로드템플릿</th>
                	<td class="L td_line ">
						<div class="inputbox w100per">
							<p class="txt"></p>
							<select id="fincCd" name="fincCd" onchange="fn_bankTemplateDown(this.value);">
								<option value="-1">선택</option>
							<c:forEach items="${bankTemplateCodeList}" var="bankT" varStatus="status">
								<option value="${bankT.remark}">${bankT.codeName}</option>
							</c:forEach>
							</select>
						</div>
					</td>
                </tr>
				<tr id ="insertDiv">
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
							</div>
                         </form>						
					</td>
				</tr>  
				<!-- 
				<tr id ="viewDiv">
					<th class="C first th_line" scope="col" ><span class="table_title">첨부파일</span></th>
					<td class="L td_line"  colspan="3">
						<ul id="fileList">
						</ul>
					</td>
				</tr>  
				 -->            
             </tbody>
       		</table>
       		
       	
        <div class="btnArea">
        	<div class="r_btn" id="btnAreaDiv">
        		<%-- 그리는 영역 --%>
            	<a href="javascript:insertFincDta();" class="btn_blue"><span>저장</span></a>
            </div>
        </div>
		
		
	</body>
	 <iframe id="invisible" name='invisible' frameborder="0" width="0" height="0"></iframe>
</html>
<script type="text/javascript">
     window.onload = ekrFile.edit_init;
</script>