
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<link href=<%=request.getContextPath()+"/board/fckeditor/_samples/sample.css"%> rel="stylesheet" type="text/css" />
<script type="text/javascript" src=<%=request.getContextPath()+"/fckeditor/fckeditor.js"%>></script>
<script type="text/javascript" src=<%=request.getContextPath()+"/admin/javascript/attachFileManager.js"%>></script>
  <style>
	 #uploadFileList {margin-left: 0px;margin-right:4px; width: 344px; height: 92px; overflow-x:none; overflow-y:auto; padding: 2px; ;border: 1px solid #b9bdc5;position:relative;float:left}
	 #uploadFileList .ui-selecting { background: gray; color: silver;}
	 #uploadFileList .ui-selected { background: gray; color: white; }
	 #uploadFileList li { cursor: pointer;}
  </style>
  
<!-- board first -->
<div id="NoticeMetadataManager_NoticeMetadataTabPage" class="board first">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="NoticeMetadataManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="NoticeMetadataManager_SearchForm" name="NoticeMetadataManager_SearchForm" style="display:inline" action="javascript:aNoticeMetadataManager.doSearch('NoticeMetadataManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aNoticeMetadataManager.doPage'/>
				<input type='hidden' name='formName' value='NoticeMetadataManager_SearchForm'/>
				 
				<input type='hidden' id='NoticeMetadataManager_Master_noticeId' name='noticeId' value=''/>
				<div class="sel_70">
					<select name='pageSize' class="txt_70">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="20" >20</option>
						<option value="50">50</option>
						<option value="100">100</option>
					</select>
				</div>				
					<a href="javascript:aNoticeMetadataManager.doSearch('NoticeMetadataManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>					
			</form>		
		</fieldset>
	</div>
	<!-- searchArea// -->
	<form id="NoticeMetadataManager_ListForm" style="display:inline" name="NoticeMetadataManager_ListForm" action="" method="post">
		<table id="grid-table" cellpadding="0" cellspacing="0" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="30px" />
				<col width="30px" />
				<col width="100px" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th class="C">
						<input type="checkbox" id="delCheck" onclick="aNoticeMetadataManager.m_checkBox.chkAll(this)"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
				
					<th class="C" ch="0" onclick="aNoticeMetadataManager.doSort(this, 'LANG_KND');" >
						<span class="table_title"><util:message key='ev.prop.noticeMetadata.langKnd'/></span>
					</th>	
					<th class="C" ch="0" onclick="aNoticeMetadataManager.doSort(this, 'TITLE');" >
						<span class="table_title"><util:message key='ev.prop.noticeMetadata.title'/></span>
					</th>		
				</tr>
			</thead>
			<tbody id="NoticeMetadataManager_ListBody">
		
			</tbody>				
		</table>		
	</form>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="NoticeMetadataManager_PAGE_ITERATOR" class="paging">
			<c:out escapeXml='false' value='${pageIterator}'/>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aNoticeMetadataManager.doCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
			<a href="javascript:aNoticeMetadataManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
</div>
<!-- board first// -->
<!-- NoticeMetadataManager_EditFormPanel -->
<div id="NoticeMetadataManager_EditFormPanel" class="board" >
	<!-- NoticeMetadataManager_propertyTabs -->
	<div id="NoticeMetadataManager_propertyTabs">
		<ul>
			<li><a href="#NoticeMetadataManager_DetailTabPage"><span><util:message key='ev.title.notice.detailTab'/></span></a></li>   
		</ul>
		<!-- NoticeMetadataManager_DetailTabPage -->
		<div id="NoticeMetadataManager_DetailTabPage">
			<form id="NoticeMetadataManager_EditForm" style="display:inline" action="" method="post">
				<input type="hidden" id="NoticeMetadataManager_isCreate">
				<input type="hidden" id="NoticeMetadataManager_id" name="id"> 
				<input type="hidden" id="NoticeMetadataManager_noticeId" name="noticeId">					
				<table id="grid-table" cellpadding="0" cellspacing="0" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="140px"/>
						<col width="*"/>
						<col width="140px"/>
						<col width="*"/>
					</colgroup>							
					<tr>
						<th class="C"><util:message key='ev.prop.noticeMetadata.langKnd'/></th>
						<td class="C">
							<div class="sel_100">
								<select id="NoticeMetadataManager_langKnd" name="langKnd" label="<util:message key='ev.prop.noticeMetadata.langKnd'/>" class='txt_100'>
									<c:forEach items="${langKndList}" var="langKnd">
										<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
									</c:forEach>
								</select>
							</div>
						</td>
						<th class="C"><util:message key='ev.prop.noticeMetadata.title'/> <em>*</em></th>
						<td class="C">
							<input type="text" id="NoticeMetadataManager_title" name="title" value="" maxLength="50" label="<util:message key='pt.ev.property.title'/>" class="txt_100" />
						</td>
					</tr>
					<tr>
						<th class="C"><util:message key='ev.prop.noticeMetadata.content'/> <em>*</em></th>
						<td colspan="3" class="C" id="smarteditor">
							<textarea id="NoticeMetadataManager_content" name="content" style="width:100%;min-height:350px;display:none;" cols="80" rows="10" value="" maxLength="" label="<util:message key='ev.prop.noticeMetadata.content'/>" class="txtbox"> </textarea>
							<script type="text/javascript">
							</script>
						</td>
					</tr>							 						
				</table>
			</form>
			<table id="grid-table" cellpadding="0" cellspacing="0" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="140px"/>
					<col width="*"/>
					<col width="140px"/>
					<col width="*"/>
				</colgroup>					
				<tr>
					<th rowspan="2" class="L"><util:message key='ev.prop.attachFile'/></th>							
					<td colspan="3" class="C">
						<table>
						<tr>
						<td style="border:0px;padding:0px">
						<form name=setUpload method=post enctype="multipart/form-data" target=download action="/notice/fileMngr?cmd=upload">
			            	<input type=file name=attachFile style="width:345px;height:auto" OnMouseOver=this.style.backgroundColor='#efebef' OnMouseOut=this.style.backgroundColor='' OnKeyDown="this.blur()">
							<img id="btnUploadFile" src='${pageContext.request.contextPath}/board/images/board/skin/default/imgUpload.gif' onclick="attachFileManager.uploadFile()" style=cursor:pointer alt=파일올리기 width="65" height="24" align="absmiddle">&nbsp;
							<img id="btnDeleteFile" src='${pageContext.request.contextPath}/board/images/board/skin/default/imgUpoff.gif' onclick="attachFileManager.deleteFile()" style=cursor:pointer alt=파일내리기 width="65" height="24" align="absmiddle">
							<input type=hidden name=viewsize readonly style=background-color:#eeeeee;width:100%;text-align:center;border:none value='총 파일 크기: 0KB'>
						  	<input type=hidden name=totalsize value=0>
						  	<input type=hidden name=atchType value=A>
						  	<input type=hidden name=systemId value=notice>
						</form>
						</td>
						</tr>
						<tr>
						<td style="border:0px;padding:0px">
						<form name=setFileList method=post target=download action="/attachFile/fileMngr.do?cmd=delete">
							<ol id="uploadFileList" class="L">
								<c:set var="file" value="${bltnVO.fileList}"/>
								<c:forEach items="${file}" var="fList">
									<li data="<c:out value="${fList.fileMask}"/>-<c:out value="${fList.fileSize}"/>"><c:out value="${fList.fileName}"/>&nbsp;(<c:out value="${fList.sizeSF}"/>)</li>
								</c:forEach>
							</ol>
							<input type=hidden name=semaphore value="<%=System.currentTimeMillis()%>">
							<input type=hidden name=vaccum>
							<input type=hidden name=unDelList>
							<input type=hidden name=delList>
							<input type=hidden name=subId value=sub01>
						</form>
						</td>
						</tr>
						
						
						</table>
						<span id=uploading style=display:none>
							<span id=uploadStatus></span>
						</span>																						
					</td>
				</tr>										
			</table>
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aNoticeMetadataManager.doPreview()" class="btn_B"><span><util:message key='ev.title.preview'/></span></a>
					<a href="javascript:aNoticeMetadataManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->					
		</div>
		<!-- NoticeMetadataManager_DetailTabPage// -->			
	</div>
	<!-- NoticeMetadataManager_propertyTabs// -->
</div>
<!-- NoticeMetadataManager_EditFormPanel// -->	

<iframe name='download' frameborder=0 width=0 height=0></iframe>