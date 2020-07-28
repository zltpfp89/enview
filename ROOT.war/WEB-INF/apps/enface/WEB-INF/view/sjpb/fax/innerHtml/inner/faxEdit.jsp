<%@ page contentType="text/html; charset=UTF-8"%>

<script>
	window.onload = commonFile.edit_init();

	$(document).ready(function(){
		$("#receiver").off("focus").on("focus", function() {	
			openSearchBankPopup();
		});
		
		$("#sendFaxNo").off("focus").on("focus", function() {	
			openSearchBankPopup();
		});
		
		if("${cmd}" == "WRITE") {
	 		$("#sendNoSpan").html("신규");
	 		$("#sendDivSpan").html("작성중");
			
	 		$("#regUserSpan").html($("#userName").val());
	 		$("#regUserFaxSpan").html($("#userFax").val());
		} else {
			//
		}
	});
	
	//수신처 선택 팝업
	function openSearchBankPopup(){
		commonLayerPopup.openLayerPopup("/fax/searchBankPopup.face", "430px", "472px", callbackSelectBank);	
	}
	
	function callbackSelectBank(bank){
		$("#membNo").val(bank.membNo);
		$("#branchNo").val(bank.branchNo);
		$("#receiver").val(bank.branchNm);
		$("#sendFaxNo").val(bank.sendFaxNo);
	}
	
	//팩스내역을 저장한다.(실제 전송은 아니고 내용을 저장)
	function faxSave() {
		// vaildation
		if ($("#receiver").val() == null || $("#receiver").val() == "") {
			alert("수신처는 필수입니다.");
			return;
		}
		
		if ($("#sendFaxNo").val() == null || $("#sendFaxNo").val() == "") {
			alert("수신처 Fax 번호는 필수입니다.");
			return;
		}
		
		commonFile.setForm();
	}
	
	//팩스내역 저장 AJAX 
	function setFormSuccess(){
		if (commonFile.isCancel) {
			return;
		}
		
		$.ajax({
			type : 'post',
	        url : '/fax/faxSave.face',
	        dataType : 'json',
	        data : $("#editForm").serialize(),
	        success:function(json){
	        	if(json.status == "SUCCESS"){
	        		alert("저장 완료되었습니다.");
	        		selectList(); 
	        	} else {
	        		alert(json.msg);
	        	}
	        }, error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        } 
		});
	}
</script>

		<ul>
			<li class="m1"><a href="#" class="tabtitle"><span>FAX 송신정보</span></a>
				<div class="tab_mini_contents" id="faxDetailTab">
					<div class="list">
						<table class="list" cellpadding="0" cellspacing="0">
							<caption>게시판쓰기</caption>
							<colgroup>
								<col width="20%" />
								<col width="15%" />
								<col width="*" />
							</colgroup>
							<form id="editForm" name="editForm" method="post" action="">
					           	<input type="hidden" name="cmd"         id="cmd" 	value="${cmd}"/>       <%-- 작성 : WRITE, 수정 : MODIFY --%>
	           					<input type="hidden" name="maxFileCnt"  id="maxFileCnt" value="10"/>       <%-- 최대파일 갯수 --%>
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
					           	
							<tr>
								<th class="C th_line">송신 일련번호</th>
								<td class="L td_line" colspan="2">
									<input type="hidden" name="sendNo" id="sendNo" value="${fax.sendNo}" />
									<span id="sendNoSpan">${fax.sendNo}</span>
								</td>
							</tr>
							<tr>
								<th class="C th_line">상태</th>
								<td class="L td_line" colspan="2">
									<input type="hidden" name="sendDiv" id="sendDiv" value="${fax.sendDiv}" />
									<span id="sendDivSpan">${fax.sendDivNm}</span>
								</td>
							</tr>
							<tr>
								<th class="C th_line r_line" rowspan="2">발신정보</th>
								<th class="C th_line">담당자</th>
								<td class="L td_line">
									<input type="hidden" name="empNo" id="empNo" value="${fax.empNo}" />
									<input type="hidden" name="regUserNm" id="regUserNm" value="${fax.regUserNm}" />
									<span id="regUserSpan">${fax.regUserNm}</span>
								</td>
							</tr>
                            <tr>
								<th class="C th_line">FAX번호</th>
								<td class="L td_line">
									<input type="hidden" name="regUserFax" id="regUserFax" value="${fax.regUserFax}" />
									<span id="regUserFaxSpan">${fax.regUserFax}</span>
								</td>
                            </tr>
                            <tr>
								<th class="C th_line r_line" rowspan="2">수신정보</th>
								<th class="C">수신처<em class="red">*</em></th>
								<td class="L">
									<input type="hidden" name="membNo" id="membNo" value="${fax.membNo}" />
									<input type="hidden" name="branchNo" id="branchNo" value="${fax.branchNo}" />
                                	<label for="txt_01"><input type="text" class="w100per" id="receiver" name="receiver" value="${fax.receiver}" readonly="readonly" /></label>
								</td>
							</tr>
                            <tr>
                            	<th class="C th_line">FAX번호<em class="red">*</em></th>
								<td class="L">
                                	<label for="txt_02"><input type="text" class="w100per" id="sendFaxNo" name="sendFaxNo" value="${fax.sendFaxNo}" readonly="readonly" /></label>
                                </td>
                            </tr>
                            </form>
                            <tr>
                            	<th class="C th_line">첨부파일</th>
                                <td class="L td_line" colspan="2">
			                    	<div id="vault_upload">
									</div>
									<ul id="vault_fileList" style="display: none;">
										<c:forEach items="${faxSend.fileList}" var="fList">
											<li data="<c:out value="${fList.fileId}"/>^<c:out value="${fList.fileNm}"/>^<c:out value="${fList.fileSize}"/>^<c:out value="${fList.fileType}"/>^<c:out value="${fList.filePath}"/>^<c:out value="${fList.fileCtype}"/>">
												<a href="#"><c:out value="${fList.fileNm}"/>(<c:out value="${fList.fileSize}"/>)</a>
											</li>
										</c:forEach>
									</ul>
									<form name="setFileList" method="post" target="invisible" action="${cPath}/common/fileMngr?cmd=delete">
	                                    <input type="hidden" name="semaphore" value="<c:out value="${semaphore}"/>" />
	                                    <input type="hidden" name="vaccum" />
	                                    <input type="hidden" name="unDelList" />
	                                    <input type="hidden" name="delList" />
                                   </form>
                                </td>
                            </tr>
						</table>
					</div>
					<!-- btnArea -->
					<div class="btnArea">
						<div class="r_btn"><a href="javascript:faxSave();" class="btn_blue"><span>저장</span></a></div>
					</div>
					<!-- btnArea //-->
				</div>
			</li>
		</ul>
    	<iframe name='invisible' frameborder="0" width="0" height="0"></iframe>
