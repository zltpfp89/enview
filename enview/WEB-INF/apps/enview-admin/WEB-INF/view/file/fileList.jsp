<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.saltware.enview.Enview"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="robots" content="noindex, nofollow" />


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/vault/dhtmlxvault.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/dhtmlx/vault/dhtmlxvault.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/fileManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/smarteditor/js/HuskyEZCreator.js"></script>

<script type="text/javascript">
	function initFileManager(){
		if( aFileManager == null ) {
			aFileManager = new FileManager("<c:out value="${evSecurityCode}"/>");
			aFileManager.init();
			aFileManager.doDefaultSelect();
		}
	}
	
	function finishFileManager(){
		
	}
	
	// Attach to the onload event
	if (window.attachEvent){
	    window.attachEvent ( "onload", initFileManager );
		window.attachEvent ( "onunload", finishFileManager );
	}
	else if (window.addEventListener ){
	    window.addEventListener ( "load", initFileManager, false );
		window.addEventListener ( "unload", finishFileManager, false );
	}
	else{
	    window.onload = initFileManager;
		window.onunload = finishFileManager;
	}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- tree2 -->
	<div id="cateTabs" class="tree">
		<!-- treewrap -->
		<div class="treewrap resizable">
			<div class="tree_title"><util:message key='ev.title.file.fileTree'/></div>
			<!-- 트리 영역 border로 구분. 지우고 사용해주세요 -->
			<div id="FileManager_TreeTabPage" class="category" style="overflow:auto; padding:2px;"></div>
		</div>
		<!-- treewrap// -->
	</div>
	<!-- tree2// -->
	<!-- detail -->
	<div class="detail">
		<!-- board -->
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="FileManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="FileManager_SearchForm" name="FileManager_SearchForm" style="display:inline" action="javascript:aFileManager.doSearch('FileManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<input type='hidden' name='id'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aFileManager.doPage'/>
						<input type='hidden' name='formName' value='FileManager_SearchForm'/>
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aFileManager.doSearch('FileManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>    
					</form>
				</fieldset>	
			</div>
			<!-- searchArea//-->
			<form id="FileManager_ListForm" style="display:inline" name="FileManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="30px" />
					<col width="30px" />
					<col width="*" />
					<col width="*" />
				</colgroup>				
					<thead>
						<tr>
							<th class="first">
								<input type="checkbox" id="delCheck" onclick="aFileManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
							<th class="C" ch="0" onclick="aFileManager.doSort(this, 'FILE_NAME');" >
								<span class="table_title"><util:message key='ev.title.file.name'/></span>
							</th>	
							<th class="C" ch="0" onclick="aFileManager.doSort(this, 'FILE_SIZE');" >
								<span class="table_title"><util:message key='ev.title.file.size'/></span>
							</th>	
							<th class="C" ch="0" onclick="aFileManager.doSort(this, 'MODIFIED_DATE');" >
								<span class="table_title"><util:message key='ev.title.file.modifiedDate'/></span>
							</th>			
						</tr>
					</thead>
					<tbody id="FileManager_ListBody">
					</tbody>
				</table>
			</form>
			<div class="tsearchArea">
				<p id="FileManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="FileManager_PAGE_ITERATOR" class="paging">
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
			    	<a href="javascript:aFileManager.getFileUploader().doShow()" class="btn_W"><span><util:message key='ev.title.upload'/></span></a>
			    	<a href="javascript:aFileManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->												
		</div>
		<!-- board first// -->
		<!-- board -->
		<div id="FileManager_EditFormPanel" class="board" >  
			<div id="FileManager_propertyTabs">
				<ul>
					<li><a href="#FileManager_DetailTabPage" onclick="aFileManager.onSelectPropertyTab(0);"><util:message key='ev.title.file.detailTab'/></a></li>   
					<li><a href="#FileManager_DetailTabPage2" onclick="aFileManager.onSelectPropertyTab(1);"><util:message key='ev.title.file.sourceEdit'/></a></li>
					<li><a href="#FileManager_DetailTabPage3" onclick="aFileManager.onSelectPropertyTab(2);"><util:message key='ev.title.file.Preview'/></a></li>
				</ul>
				<div id="FileManager_DetailTabPage">
					<%@include file="fileDetail.jsp"%>		
				</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
				
				<div id="FileManager_DetailTabPage2" style="width:100%;">  <!-- editor모드 입니다 -->
                	<%@include file="editor.jsp"%>		
				</div>
				
				<div id="FileManager_DetailTabPage3" style="width:100%;">  <!-- editor모드 입니다 -->
				    <%@include file="previeweditor.jsp"%>		
				</div>
			</div>
		</div>
		<!-- board// -->		
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<input type="hidden" id="uploadDir" value="/"/>
<div id="FileManager_FileUploader" title="File Uploader" ></div>
<div id="dhtmlx_context_data">
	<div id="onRefresh" text="<util:message key="ev.info.menu.refresh" />" img="${cPath }/admin/images/Service.gif"></div>
	<div id="onCreate" text="<util:message key="ev.info.menu.addPage" />" img="${cPath }/admin/images/ic_make_page.gif"></div>
	<div id="onMoveUp" text="<util:message key="ev.info.menu.moveUp" />" img="${cPath }/admin/images/ic_up.gif"></div>
	<div id="onMoveDown" text="<util:message key="ev.info.menu.moveDown" />" img="${cPath }/admin/images/ic_down.gif"></div>
	<div id="onUpload" text="<util:message key="ev.info.menu.upload" />" img="${cPath }/admin/images/createsmall.gif"></div>
</div>