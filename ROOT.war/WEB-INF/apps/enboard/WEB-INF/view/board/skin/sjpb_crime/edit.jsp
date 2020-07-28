<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,java.util.ArrayList" %>
<%@ page import="com.saltware.enview.Enview"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.saltware.enboard.vo.BoardVO,com.saltware.enboard.vo.BulletinVO,com.saltware.enboard.vo.BltnPollVO" %>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

	Map userInfoMap = EnviewSSOManager.getUserInfoMap(request);
	request.setAttribute("userInfoMap", userInfoMap);


%>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/common.js?r=<%=Math.random()%>"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/loading/js/HoldOn.js"></script>

<c:if test="${boardVO.extUseYn == 'Y'}">
  <c:set var="extnMapper" value="${boardVO.bltnExtnMapper}"/>
  <%--jsp:useBean id="extnMapper" type="com.saltware.enboard.integrate.DefaultBltnExtnMapper"/--%>
  <c:if test="${!empty bltnVO.bltnExtnVO}">
	<c:set var="extnVO" value="${bltnVO.bltnExtnVO}"/>
	<%--jsp:useBean id="extnVO" type="com.saltware.enboard.integrate.DefaultBltnExtnVO"/--%>
  </c:if>
</c:if>


<link  rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/js/Z/loading/css/HoldOn.css">

 <script type="text/javascript">
	$(document).ready(function () {
		fn_initFdCdSetting();
		
		$("#dvForm").off("change").on("change", function(){
			
			fn_changeSessionFdcd( $(this).val());
		});
	});
	
	
	function fn_initFdCdSetting() {
		var reqMap = {
				dvForm : "01"
			}
			
			goAjaxDefault("/sjpb/B/changeDvForm.face", reqMap, callBackChangeDvFormSuccess);
			
	}
	
	

	
	function fn_save(){
		if($("#dvForm").val() == ''){
			alert("수사분야를 선택하세요.");
			return false;
		}
		ebEdit.save();
	}
	
	
	function callBackChangeDvFormSuccess(data){
		var fdCodeHtml = new StringBuffer();
		
		fdCodeHtml.append('				   		<option value="" selected="selected">선택</option>							');
		var extStr1 = "${extnVO.ext_str1}";
		if(data.fdKndList != null){
			
			$.each(data.fdKndList, function(i, fd) {
				fdCodeHtml.append('						<option value="'+fd.code+'"  data-fdCode="'+fd.code+'" data-criTmNm="'+fd.criTmNm+'">'+fd.codeName+'</option>');
				 
			});
		}else fdCodeHtml.append('				   		<option value="" selected="selected">기본</option>	');
		
		$("#dvForm").html(fdCodeHtml.toString());
		$("#dvForm").val(extStr1);
	}
	
	
	function fn_changeSessionFdcd(obj){
		var reqMap = {
				fdcd : obj
			}
		goAjaxDefault("/statics/sjpbProcess/crimeSessionMngr.jsp", reqMap, fn_changeSessionFdcdSuccess);
		
		$("#ext_str0").val($("#dvForm option:selected").text());
		$("#ext_str1").val(obj);

	}
	
	function fn_changeSessionFdcdSuccess(){
		
	}
	

</script>
<c:set var="loginInfo" value="${secPmsnVO.loginInfo}"/>
<%--jsp:useBean id="loginInfo" type="java.util.Map"/--%>


<!-- board -->
<body class="iframe">
<div class="board">
	<table cellpadding="0" cellspacing="0" summary="게시판쓰기" class="list" >  
		<caption>게시판쓰기</caption>
		<colgroup>
		<col width="20%" />
		<col width="*%" />
		</colgroup>
        <tbody>
			<!-- editForm -->
	        <form name="editForm" onsubmit="return false">
	            <tr>
	                <th class="C first th_line" scope="col"><span class="table_title">제목</span></th>
					<td class="L td_line" ><label for="title"></label><input type="text" class="txt_100per" id="title" name="bltnSubj" value="<c:out value="${bltnVO.bltnSubj}"/>" maxlength="120"/></td>
	        	</tr>
	        	<tr>
	        		<th class="C first th_line" scope="col"><span class="table_title">작성자</span></th>
	        		<td class="L td_line" >
	        			<c:if test="${boardSttVO.cmd != 'MODIFY'}">${secPmsnVO.userNick}</c:if>
							<c:if test="${boardSttVO.cmd == 'MODIFY'}">${bltnVO.userNick}</c:if>
							<c:if test="${boardSttVO.cmd != 'MODIFY'}">${secPmsnVO.userNm}</c:if>
	        			<%--익명게시판이 아닌 경우--%>
						<c:if test="${boardVO.anonYn == 'N'}">
							<c:if test="${boardSttVO.cmd != 'MODIFY'}">${secPmsnVO.userNick}</c:if>
							<c:if test="${boardSttVO.cmd == 'MODIFY'}">${bltnVO.userNick}</c:if>
							<input type="hidden" name="userNick"
							<c:if test="${boardSttVO.cmd ne 'MODIFY'}">value="<c:out value="${secPmsnVO.userNm}"/>"</c:if>
							<c:if test="${boardSttVO.cmd eq 'MODIFY'}">value="<c:out value="${bltnVO.userNick}"/>"</c:if>
							/>
						 </c:if>
						 
					</td>
				</tr>
				<%-- Bulletin Category --%>
				
				<c:if test="${boardVO.extUseYn == 'Y'}">
					<c:if test="${extnMapper.ext_str0Yn == 'Y'}">
						<tr>
							<th class="C first th_line" scope="col"><span class="table_title">수사분야</span></th>
							 <td class="L td_line" >
								<select id="dvForm" name="dvForm">
								</select>
							</td>
							 <input type=hidden id="ext_str0" name="ext_str0" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str0}"/>"</c:if> maxlength="512" style="width:300px"/>
							 <c:if test="${extnMapper.ext_str1Yn == 'Y'}">
							 <input type=hidden id="ext_str1" name="ext_str1" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str1}"/>"</c:if> maxlength="512" style="width:300px"/>
							 </c:if>
						</tr>					
					</c:if>
					<c:if test="${extnMapper.ext_str2Yn == 'Y'}">
					<input type=hidden id="ext_str2" name="ext_str2" <c:if test="${empty bltnVO.bltnExtnVO}">value="<c:out value="${userInfoMap.orgName}"/>"</c:if><c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str2}"/>"</c:if> maxlength="512" style="width:300px"/>
					</c:if>
				</c:if>			
				<c:if test="${boardVO.cateYn == 'Y'}">
					<tr>
						<th class="C first th_line" scope="col"><span class="table_title">카테고리</span></th>
		                <td class="L td_line" >
		                	<div class="inputbox2 sel_150">
		                    	<p class="txt"></p>
		                        <select name=cateList>
			                        <c:forEach items="${bltnCateList}" var="cList">
			                        <option>일반</option>
				            			<c:if test="${!empty cList.bltnCateNm}">
			                            	<option value="<c:out value="${cList.bltnCateId}"/>" <c:if test="${bltnVO.cateId==cList.bltnCateId}">selected</c:if>><c:out value="${cList.bltnCateNm}"/></option>
			                            </c:if>
				          			</c:forEach>
		                        </select>
		                	</div>
		                </td>
		            </tr>
	          	</c:if>
				<%-- Notice --%>
				<c:if test="${boardVO.noticeYn == 'Y' && secPmsnVO.ableNotice == 'true'}">
					<tr>
						<th class="C first th_line" scope="col"><span class="table_title">공지여부</span></th>
						<td class="L td_line" >
							<label for="bltnTopTag"></label>
							<input type="checkbox" name=bltnTopTag id=bltnTopTag <c:if test="${bltnVO.bltnTopTag == 'Y'}">checked</c:if> value="Y" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'Y')"/>
							<span class="checktxt">공지글</span>
							<label for="bltnTopTag"></label>
							<input type="checkbox" name=bltnTopTag id=bltnTopTag <c:if test="${bltnVO.bltnTopTag == 'N'}">checked</c:if> value="N" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'N')"/>
							<span class="checktxt">공지글 아님</span>
							<label for="bltnTopTag"></label>
							<input type="checkbox" name=bltnTopTag id=bltnTopTag <c:if test="${bltnVO.bltnTopTag == 'T'}">checked</c:if> value="T" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'T')" />
							<span class="checktxt">최상위 공지글</span>
	                	</td>
					</tr>
				</c:if>
				<tr>
					<th class="C first th_line" scope="col" ><span class="table_title">내용</span></th>
	                <td class="L td_line" id="smarteditor" class="text_write_info">        
						<textarea id=editorCntt  name="conttxt" cols="" rows=""><c:out value="${bltnVO.bltnCntt}"/></textarea>
						<input type="hidden" name="bltnOrgCntt" />
					</td>
				</tr>
			</form>
			<!-- editForm //-->
			<!-- 첨부파일 -->
			<c:if test="${boardVO.maxFileCnt > '0'}">
				<tr>
	                <th class="C first th_line" scope="col" ><span class="table_title">첨부파일</span></th>
	                <td class="L td_line" >
	                	<p>파일은 <span id="limitCount" class="txt_point_01"></span>까지 첨부가 가능하며, 용량은 <span id="limitSize" class="txt_point_01"></span>를 넘을 수 없습니다.</p>
						<input type="hidden" id="badFileList" name="badFileList" value="${boardVO.badExtMask}">
						<input type="hidden" id="sendFlg" name="sendFlg" value="false">
						<div id="vault_upload">
							
						</div>
						<c:if test="${boardSttVO.cmd eq 'MODIFY'}">
							<c:set var="fileList" value="${bltnVO.fileList}"/>
							<ul id="vault_fileList" style="display: none;">
								<c:forEach items="${fileList}" var="file">
									<li data-name="<c:out value='${file.fileName}'/>" data-mask="<c:out value='${file.fileMask}'/>" data-size="<c:out value='${file.fileSize}'/>"><c:out value="${file.fileName}"/> (<c:out value="${file.sizeSF}"/>)</li>
								</c:forEach>	
							</ul>
						</c:if>
						<form name=setUpload method=post enctype="multipart/form-data" target=invisible action="${cPath }/board/fileMngr?cmd=upload">
							<input type="hidden" id="totalsize" name="totalsize" value="0" />
							<input type="hidden" name="viewsize" readonly="readonly" value='총 파일 크기: 0KB' />
							<input type="hidden" name="boardId" value="<c:out value="${boardVO.boardRid}"/>">
							<input type="hidden" name="totalsize" value=0>
							<input type="hidden" name="subId" value=sub01>
							<input type="hidden" name="mode" value=attach>
						</form>
						<form name="setFileList" method="post" target="invisible" action="${cPath }/board/fileMngr?cmd=delete">
							<input type=hidden name=semaphore value="<c:out value="${boardSttVO.semaphore}"/>">
							<input type=hidden name=vaccum>
							<%-- 게시판별 별도 디렉터리에 첨부파일 관리하는 것 때문에 추가 2009.02.25.KWShin. --%>
							<input type=hidden name=delBoardId value="<c:out value="${boardVO.boardRid}"/>">
							<input type=hidden name=unDelList>
							<input type=hidden name=delList>
							<input type=hidden name=subId value=sub01>
						</form>
					</td>
				</tr>
			</c:if>       
        </tbody>
    </table>
    <!-- table//-->
    <!-- btnArea-->
    <div class="btnArea">
        <div class="R">
        	<a class="btn_gray" href="javascript:void(0);" onclick="javascript:fn_save();"><span>등록</span></a>
        	<a class="btn_white" href="javascript:void(0);" onclick="javascript:ebEdit.list();"><span>목록</span></a>
        </div>
    </div>
    <!-- boardbtnArea//-->
</div>
</body>
<!-- board// -->

<script>
	
	//파일 제한 사이즈 세팅
	$(document).ready(function() {
		try{
			parent.autoresize_iframe_portlets();
		}catch(e){
		}
		//파일 제한 사이즈 세팅
		$("#limitCount").html(document.setTransfer.maxFileCnt.value+"개");	
		$("#limitSize").html((document.setTransfer.limitSize.value/(1024*1024)).toFixed(0)+"MB");	
		
		//datepicker setting 
		$("#bltnBgnYmd, #bltnEndYmd").datepicker({ dateFormat: 'yy-mm-dd' });
		
		if("${bltnVO.bltnBgnYmdF}".length == 0 && "${bltnVO.bltnEndYmdF}".length == 0 )
		{
			var new_date = new Date();
			$("#bltnBgnYmd, #bltnEndYmd").datepicker('setDate', new_date);
			$("#bltnEndYmd").datepicker("option", "minDate", new_date);
			$("#bltnBgnYmd").datepicker("option", "onClose", function(date) 
			{
				$("#bltnEndYmd").datepicker("option", "minDate", date);
			});
		}
		else
		{
			$("#bltnBgnYmd").datepicker('setDate', "${bltnVO.bltnBgnYmdF}");
			$("#bltnEndYmd").datepicker('setDate', "${bltnVO.bltnEndYmdF}");
			$("#bltnEndYmd").datepicker("option", "minDate", "${bltnVO.bltnBgnYmdF}");
			$("#bltnBgnYmd").datepicker("option", "onClose", function(date) 
			{
				$("#bltnEndYmd").datepicker("option", "minDate", date);
			});
		}
	});

</script>