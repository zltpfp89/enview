<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,java.util.ArrayList" %>
<%@ page import="com.saltware.enview.Enview"%>
<%@ page import="com.saltware.enboard.vo.BoardVO,com.saltware.enboard.vo.BulletinVO,com.saltware.enboard.vo.BltnPollVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html lang="ko-KR">
<head>
	<meta charset="UTF-8">
	<title>K-ICT 빅데이터 센터</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
	<!-- kbig 관련 소스 파일 -->
	<link rel="stylesheet" href="${cPath}/kbig/css/reset.css" />
	<link rel="stylesheet" href="${cPath}/kbig/css/nav.css" />
	<link rel="stylesheet" href="${cPath}/kbig/css/sub.css" />
	<%-- <script type="text/javascript" src="${cPath}/kbig/js/jquery-1.9.1.js"></script> --%>
	<script type="text/javascript" src="${cPath}/kbig/js/run.js"></script>
	<script type="text/javascript" src="${cPath}/kbig/js/kbig_common.js"></script>	
</head>
<body>
<c:set var="loginInfo" value="${secPmsnVO.loginInfo}"/>
<%--jsp:useBean id="loginInfo" type="java.util.Map"/--%>

<c:if test="${boardVO.extUseYn == 'Y'}">
  <c:set var="extnMapper" value="${boardVO.bltnExtnMapper}"/>
  <%--jsp:useBean id="extnMapper" type="com.saltware.enboard.integrate.DefaultBltnExtnMapper"/--%>
  <c:if test="${!empty bltnVO.bltnExtnVO}">
	<c:set var="extnVO" value="${bltnVO.bltnExtnVO}"/>
	<%--jsp:useBean id="extnVO" type="com.saltware.enboard.integrate.DefaultBltnExtnVO"/--%>
  </c:if>
</c:if>

<div id="content_body">
	<div class="article">
		<table summary="게시판 쓰기" class="table_write">
			<caption>게시판 쓰기</caption>
			<colgroup class="pc">
				<col width="130px">
				<col width="*">
				<col width="130px">
				<col width="*">
			</colgroup>
			<%-- <colgroup class="mobile">
				<col width="*"/>
			</colgroup> --%>
			<tbody>
				<form name="editForm" id="editForm" onsubmit="return false">
				<tr 
		        	<c:if test="${boardVO.anonYn == 'N'}">
		        		style="display: none;"
		        	</c:if>
		        >
					<th>작성자</th>
					<td colspan="3">
						<%--익명게시판이 아닌 경우--%>
						<c:if test="${boardVO.anonYn == 'N'}">
							<input type="text" maxlength="30" name="userNick" readonly="readonly"
							<c:if test="${boardSttVO.cmd != 'MODIFY'}">value="<c:out value="${secPmsnVO.userNick}"/>"</c:if>
						  	<c:if test="${boardSttVO.cmd == 'MODIFY'}">value="<c:out value="${bltnVO.userNick}"/>"</c:if>
						/>
						</c:if>
						<%--익명게시판인 경우--%>
						<c:if test="${boardVO.anonYn == 'Y'}">
							<input type="text" maxlength="30" name="userNick"/>
						</c:if>
						<%--실명인증 게시판인 경우--%>
						<c:if test="${boardVO.anonYn == 'R' || boardVO.anonYn == 'P'}">
							<input type="text" maxlength="30" name="userNick" readonly="readonly" value='<%=(String)session.getAttribute(Enview.getConfiguration().getString("session.realManNm.attr.name"))%>'/>
						</c:if>
					</td>
		        </tr>
				<%-- Bulletin Category --%>
			    <c:if test="${boardVO.cateYn == 'Y'}">
					<tr>
						<th>카테고리</th>
						<td colspan="3">
							<div class="select_box">
								<select name="cateList">
						    		<c:forEach items="${bltnCateList}" var="cList">
										<c:if test="${!empty cList.bltnCateNm}">
											<option value="<c:out value="${cList.bltnCateId}"/>" <c:if test="${bltnVO.cateId==cList.bltnCateId}">selected</c:if>><c:out value="${cList.bltnCateNm}"/></option>
										</c:if>
									</c:forEach>
						  		</select>
					  		</div>
					  	</td>
					</tr>
		        </c:if>
				<tr>
					<th>제목</th>
					<td colspan="3">
						<input type="text" id="title" name="bltnSubj" value="<c:out value="${bltnVO.bltnSubj}"/>"  />
					</td>
				</tr>
				 <c:if test="${boardVO.noticeYn == 'Y' && secPmsnVO.ableNotice == 'true'}">
			        <tr>
			            <th>구분</th>
						<td colspan="3" >
							<ul class="ul_list">
								<li>
									<label class="radio-wrap">
									<input type="radio" name="bltnTopTag" id="notice" <c:if test="${bltnVO.bltnTopTag == 'Y'}">checked="checked"</c:if> value="Y" onclick="javascript:ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'Y');" />
									<i class="check-icon"></i>공지글</label>											
								</li>
								<li>
									<label class="radio-wrap">
									<input type="radio" name="bltnTopTag" id="no_notice" <c:if test="${bltnVO.bltnTopTag == 'N'}">checked="checked"</c:if> value="N" onclick="javascript:ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'N');"/>
									<i class="check-icon"></i>공지글아님</label>											
								</li>
							</ul>
						</td>
			        </tr>
		        </c:if>
		        
		        <%-- 확장필드 사용예 --%>
			    <c:if test="${boardVO.extUseYn == 'Y'}">
			      <c:if test="${extnMapper.ext_str0Yn == 'Y'}">
			      	<c:choose>
			      	<c:when test="${boardVO.boardId=='popup_zone'}">
			          <tr>
			          	 <th><c:out value="${extnMapper.ext_str0Ttl}"/></th>
			             <td colspan="3">
			             	<input type="radio" name="ext_str0" value="_top" ${extnVO.ext_str0 != '_blank' ? 'checked' : ''}> 현재창 &nbsp; &nbsp;
			             	<input type="radio" name="ext_str0" value="_blank" ${extnVO.ext_str0 == '_blank' ? 'checked' : ''}> 새창
			            </td> 
				      </tr>
			      	</c:when>
			      	<c:when test="${boardVO.boardId=='education'}">
			          <tr>
			          	 <th><c:out value="${extnMapper.ext_str0Ttl}"/></th>
			             <td colspan="3">
			             	<select name="ext_str0">
			             	<option value="PDF" ${extnVO.ext_str0 == 'PDF' ? 'selected' : ''}>PDF</option>
			             	<option value="DATA" ${extnVO.ext_str0 == 'DATA' ? 'selected' : ''}>DATA</option>
			             	<option value="CODE" ${extnVO.ext_str0 == 'CODE' ? 'selected' : ''}>CODE</option>
			             	</select>
			            </td> 
				      </tr>
			      	</c:when>
			      	<c:otherwise>
			          <tr>
			          	 <th><c:out value="${extnMapper.ext_str0Ttl}"/></th>
			             <td colspan="3">
			             	<input type="text" name="ext_str0" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str0}"/>"</c:if> />
			            </td> 
				      </tr>
					</c:otherwise>				      
			      	</c:choose>		
		          </c:if>
			      <c:if test="${extnMapper.ext_str1Yn == 'Y'}">
			          <tr>
			          	 <th><c:out value="${extnMapper.ext_str1Ttl}"/></th>
			             <td colspan="3">
			              	<input type="text" name="ext_str1" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str1}"/>"</c:if> />
			             </td> 
				      </tr>
		          </c:if>
		          <c:if test="${extnMapper.ext_str2Yn == 'Y'}">
			          <tr>
			          	 <th><c:out value="${extnMapper.ext_str2Ttl}"/></th>
			             <td colspan="3">
			              <input type="text"  name="ext_str2" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str2}"/>"</c:if> />
			            </td> 
				      </tr>
		          </c:if>
			      <c:if test="${extnMapper.ext_str3Yn == 'Y'}">
			          <tr>
			          	 <th ><c:out value="${extnMapper.ext_str3Ttl}"/></th>
			             <td colspan="3" >
			              	<input type="text"   name="ext_str3" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str3}"/>"</c:if> />
			             </td> 
				      </tr>
		          </c:if>
		          <c:if test="${extnMapper.ext_str4Yn == 'Y'}">
			          <tr>
			          	 <th ><c:out value="${extnMapper.ext_str4Ttl}"/></th>
			             <td colspan="3" >
			              <input type="text"  name="ext_str4" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str4}"/>"</c:if> />
			            </td> 
				      </tr>
		          </c:if>
			      <c:if test="${extnMapper.ext_str5Yn == 'Y'}">
			          <tr>
			          	 <th ><c:out value="${extnMapper.ext_str5Ttl}"/></th>
			             <td colspan="3" >
			              	<input type="text"   name="ext_str5" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str5}"/>"</c:if> />
			             </td> 
				      </tr>
		          </c:if>
		          <c:if test="${extnMapper.ext_str6Yn == 'Y'}">
			          <tr>
			          	 <th ><c:out value="${extnMapper.ext_str6Ttl}"/></th>
			             <td colspan="3" >
			              <input type="text"  name="ext_str6" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str6}"/>"</c:if> />
			            </td> 
				      </tr>
		          </c:if>
			      <c:if test="${extnMapper.ext_str7Yn == 'Y'}">
			          <tr>
			          	 <th ><c:out value="${extnMapper.ext_str7Ttl}"/></th>
			             <td colspan="3" >
			              	<input type="text"   name="ext_str7" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str7}"/>"</c:if> />
			             </td> 
				      </tr>
		          </c:if>
		          <c:if test="${extnMapper.ext_str8Yn == 'Y'}">
			          <tr>
			          	 <th ><c:out value="${extnMapper.ext_str8Ttl}"/></th>
			             <td colspan="3" >
			              <input type="text"  name="ext_str8" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str8}"/>"</c:if> />
			            </td> 
				      </tr>
		          </c:if>
		          <c:if test="${extnMapper.ext_str9Yn == 'Y'}">
			          <tr>
			          	 <th ><c:out value="${extnMapper.ext_str9Ttl}"/></th>
			             <td colspan="3" >
			              <input type="text"  name="ext_str9" <c:if test="${!empty bltnVO.bltnExtnVO}">value="<c:out value="${extnVO.ext_str9}"/>"</c:if> />
			            </td> 
				      </tr>
		          </c:if>
			    </c:if>
		        <%-- Term of boarding --%>
		    	<c:if test="${boardVO.termYn == 'Y'}">
					<tr>
						<th>게시기간</th>
				        <td colspan="3">
				        	<fieldset>
								<ul class="calendar_wrap">
									<li class="calendar">
										<input type="text" name="bltnBgnYmd" id="bltnBgnYmd" readonly="readonly"><label for="bltnBgnYmd">달력</label>
									</li>
									<li class="wave">~</li>
									<li class="calendar">
										<input type="text" name="bltnEndYmd" id="bltnEndYmd" readonly="readonly"><label for="bltnEndYmd">달력</label>
									</li>
								</ul>
							</fieldset>
				        </td>
					</tr>
				</c:if>
				<%-- Able Anonymous --%>
				<c:if test="${boardVO.ableAnonYn == 'Y'}">
					<c:if test="${secPmsnVO.isLogin == 'true'}">
						<tr>
							<th>익명글 여부</th>
							<td colspan="3">
								<c:if test="${boardSttVO.cmd == 'MODIFY'}">
									<c:if test="${empty bltnVO.userId}">
										<label class="checkbox-wrap">
											<input type="checkbox" name="anonFlag" checked="checked" onclick="javascript:ebEdit.checkAbleAnon(this)" />
											<i class="check-icon"></i>Y / N
										</label>
									</c:if>
									<c:if test="${!empty bltnVO.userId}">
										<label class="checkbox-wrap">
											<input type="checkbox" name="anonFlag" onclick="javascript:ebEdit.checkAbleAnon(this)" />
											<i class="check-icon"></i>Y / N
										</label>
									</c:if>
								</c:if>
							    <c:if test="${boardSttVO.cmd != 'MODIFY'}">
							    	<label class="checkbox-wrap">
										<input type="checkbox" name="anonFlag" onclick="javascript:ebEdit.checkAbleAnon(this);" />
										<i class="check-icon"></i>Y / N
									</label>
								</c:if>
						        <c:if test="${boardVO.anonYn == 'N'}">
									&nbsp;&nbsp;&nbsp;&nbsp;비밀번호&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="password" name="userPass" value="<c:out value="${bltnVO.userPass}"/>"/>				
					            </c:if>
					 		</td>
						</tr>
					</c:if>
				</c:if>
				<%-- Password.--%>
			    <c:if test="${boardVO.anonYn != 'N'}"><%--익명/실명인증 게시판의 경우 항상 비번을 받는다--%>
			        <tr>
						<th>게시물 비밀번호</th>
						<td colspan="3"	>
						  <input type="password" name="userPass" value="<c:out value="${bltnVO.userPass}"/>"/>
						</td>
			        </tr>
			    </c:if>
			  	<!-- Secret -->
		        <c:if test="${boardVO.secretYn == 'Y' && secPmsnVO.isLogin == 'true'}">
			        <tr>
			            <th>비밀글 여부</th>
						<td colspan="3">
							<fieldset>
								<label class="checkbox-wrap">
									<input type="checkbox" name="bltnSecretYn" id="yes" <c:if test="${bltnVO.bltnSecretYn == 'Y'}">checked</c:if> />
									<i class="check-icon"></i>비밀글 설정
								</label>
							</fieldset>
						</td>
			        </tr>
		        </c:if>
		        <tr>
					<th>등록일</th>
					<td colspan="3">
						<!-- 현재년도 -->
						<c:set var="now" value="<%=new java.util.Date()%>" />
						<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy.MM.dd" /></c:set> 
						${sysYear}
					</td>								
				</tr>
		        <tr>
		           	<td colspan="4" class="text_write_info" id="smarteditor" style="height:275px;">
			            <textarea id="editorCntt" class="writeArea" style="width:99%;height:100px;" rows="10"><c:out value="${bltnVO.bltnCntt}"/></textarea>
			            <input type="hidden" name="bltnOrgCntt" />
			        </td>
		        </tr>
				</form><%--editForm--%>
				<%-- Attach File --%>
				  <c:if test="${boardVO.maxFileCnt > '0'}">
			        <tr style="height:217px">
			         <th>파일첨부</th>
			          <td class="txt_left last" colspan="3">
			          <%--
			          	<div class="file_wrap">
			          		<div class="file_txt">
				          		<form name="setFileList" method="post" target="invisible" action="fileMngr?cmd=delete">
				          			<p>파일은 <span id="limitCount" class="txt_point_01"></span>까지 첨부가 가능하며, 용량은 <span id="limitSize" class="txt_point_01"></span>를 넘을 수 없습니다.</p>
						            <select id="uploadFileList" name="list" id="list" multiple="multiple" >
							            <c:if test="${boardSttVO.cmd == 'MODIFY'}">
										  <c:set var="file" value="${bltnVO.fileList}"/>
							              <c:forEach items="${file}" var="fList">
							                <option value="<c:out value="${fList.fileMask}"/>-<c:out value="${fList.fileSize}"/>"><c:out value="${fList.fileName}"/>&nbsp;(<c:out value="${fList.sizeSF}"/>)</option>
							              </c:forEach>
							            </c:if>
						            </select>
						            
									<input type="hidden" name="semaphore" value="<c:out value="${boardSttVO.semaphore}"/>" />
									<input type="hidden" name="vaccum" />
									<input type="hidden" name="delBoardId" value="<c:out value="${boardVO.boardRid}"/>" />
									<input type="hidden" name="unDelList" />
									<input type="hidden" name="delList" />
									<input type="hidden" name="subId" value="sub01" />
						   	  </form>
						    </div>
					        <div class="file_attach">
					            <form name="setUpload" method="post" enctype="multipart/form-data" target="invisible" action="fileMngr?cmd=upload">
						            <div class="box_left">
						            	<input type="file" name="filename" title="파일첨부" id="in_file_01" /> <!-- id="fileField" -->
						            </div>
						            <div class="box_right">
							            <a href="javascript:void(0);" class="btn btn_line" onclick="javascript:ebEdit.uploadFile(); $('input[name=filename]').val('');">
							            	<span>파일추가 +</span>
							            </a>
							            <a href="javascript:void(0);" class="btn btn_line" onclick="javascript:ebEdit.deleteFile();">
							            	<span>파일삭제 -</span>
							            </a>
						            </div>
						            <span id="uploading" style="display:none;">
									  <span id="uploadStatus"></span>
									</span>
						            <input type="hidden" name="viewsize" readonly="readonly" value='총 파일 크기: 0KB' />
						            <input type="hidden" name="boardId" value="<c:out value="${boardVO.boardRid}"/>" />
						            <input type="hidden" name="totalsize" value="0" id="totalsize" />
						            <input type="hidden" name="subId" value="sub01" />
						            <input type="hidden" name="mode" value="attach" />
				            	</form>
				            </div>
			     		</div>
 --%>
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
		<div class="btn_wrap">
			<div class="box_left">
				<a href="javascript:void(0);" onclick="javascript:ebEdit.list();" class="btn btn_basic"><util:message key="ev.prop.list"/></a>
			</div>
			<div class="box_right">
				<a href="javascript:void(0);" onclick="javascript:fn_save();" class="btn btn_point"><util:message key="ev.title.save"/></a>
			</div>
		</div>
	</div>
</div>
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
	
	function fn_save(){
		ebEdit.save();
	}
</script>
	</body>
</html>