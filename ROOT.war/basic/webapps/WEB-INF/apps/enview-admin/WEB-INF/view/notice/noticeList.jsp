<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/noticeManager.js?version=201310285"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/noticeMetadataManager.js?version=201310285"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageManager.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/smarteditor/js/HuskyEZCreator.js"></script>

<script type="text/javascript">
function initNoticeManager() {
	if( aNoticeManager == null ) {
		aNoticeManager = new NoticeManager("<c:out value="${evSecurityCode}"/>");
		aNoticeManager.init();
		aNoticeManager.doDefaultSelect();
	}
}
function finishNoticeManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initNoticeManager );
	window.attachEvent ( "onunload", finishNoticeManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initNoticeManager, false );
	window.addEventListener ( "unload", finishNoticeManager, false );
}
else
{
    window.onload = initNoticeManager;
	window.onunload = finishNoticeManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div id="NoticeManager_NoticeTabPage" class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="NoticeManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="NoticeManager_SearchForm" name="NoticeManager_SearchForm" style="display:inline" action="javascript:aNoticeManager.doSearch('NoticeManager_SearchForm')" onkeydown="if(event.keyCode==13) aNoticeManager.doSearch('NoticeManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!-- <input type='hidden' name='pageSize' value='10'/> -->
						<input type='hidden' name='pageFunction' value='aNoticeManager.doPage'/>
						<input type='hidden' name='formName' value='NoticeManager_SearchForm'/>
						
						<div class="sel_100">
							<select id="NoticeManager_domainId_Search" name="domainId" class='txt_100'>
							    <c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }"><option value="-1">*<util:message key='ev.prop.domain.domain'/>*</option></c:if>
								<c:forEach items="${domainList}" var="domainInfo">
									<c:if test="${domainInfo.domainId != 0}">
										<option value="<c:out value="${domainInfo.domainId}"/>"><c:out value="${domainInfo.domainNm}"/></option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<input type="text" name="titleCond" size="" class="webtextfield" value="*<util:message key='ev.prop.notice.title'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.notice.title'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.notice.title'/>*');"/>
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aNoticeManager.doSearch('NoticeManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
					</form>				
				</fieldset>
			</div>
			<!-- searchArea//-->
			<form id="NoticeManager_ListForm" style="display:inline" name="NoticeManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="100px" />
						<col width="200px" />
						<col width="120px" />
						<col width="120px" />
						<col width="30px" />
					</colgroup>
					<thead>
						<tr>
							<th class="C">
								<input type="checkbox" id="delCheck" onclick="aNoticeManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
							<th class="C" ch="0" onclick="aNoticeManager.doSort(this, 'DOMAIN_ID');" >
								<span class="table_title"><util:message key='ev.prop.notice.domainNm'/></span>
							</th>	
							<th class="C" ch="0" onclick="aNoticeManager.doSort(this, 'TITLE');" >
								<span class="table_title"><util:message key='ev.prop.notice.title'/></span>
							</th>	
							<th class="C" ch="0" onclick="aNoticeManager.doSort(this, 'START_DATE');" >
								<span class="table_title"><util:message key='ev.prop.notice.startDate'/></span>
							</th>	
							<th class="C" ch="0" onclick="aNoticeManager.doSort(this, 'END_DATE');" >
								<span class="table_title"><util:message key='ev.prop.notice.endDate'/></span>
							</th>		
							<th class="C" ch="0">
								<span class="table_title"><util:message key='ev.prop.notice.curNoticeStatus'/></span>
							</th>
						</tr>			
					</thead>
					<tbody id="NoticeManager_ListBody">
						<c:forEach items="${results}" var="notice" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C">
									<input type="checkbox" id="NoticeManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
									<input type="hidden" id="NoticeManager[<c:out value="${status.index}"/>].noticeId" value="<c:out value='${notice.noticeId}'/>"/>
								</td>
								<td class="C">
									<span><c:out value="${status.index}"/></span>
								</td>						
								<td class="L" onclick="aNoticeManager.doSelect(this)">
									<span class="table_title" id="NoticeManager[<c:out value="${status.index}"/>].title.label">&nbsp;<c:out value="${notice.domainNm}"/></span>
								</td>
								<td class="L" onclick="aNoticeManager.doSelect(this)">
									<span class="table_title" id="NoticeManager[<c:out value="${status.index}"/>].title.label">&nbsp;<c:out value="${notice.title}"/></span>
								</td>
								<td class="C" onclick="aNoticeManager.doSelect(this)">
									<span class="table_title" id="NoticeManager[<c:out value="${status.index}"/>].startDate.label">&nbsp;<c:out value="${notice.startDateByFormat}"/></span>
								</td>
								<td class="C" onclick="aNoticeManager.doSelect(this)">
									<span class="table_title" id="NoticeManager[<c:out value="${status.index}"/>].endDate.label">&nbsp;<c:out value="${notice.endDateByFormat}"/></span>
								</td>
								<td class="C" onclick="aNoticeManager.doSelect(this)">
									<span class="table_title" id="NoticeManager[<c:out value="${status.index}"/>].endDate.label">&nbsp;<c:out value="${notice.curNoticeYn}"/></span>
								</td>							
							</tr>
						</c:forEach>
					</tbody>
			 	</table>
			</form>	
			<div class="tsearchArea">
				<p id="NoticeManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="NoticeManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aNoticeManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aNoticeManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</div>
		<!-- board first// -->
		<!-- NoticeManager_EditFormPanel -->
		<div id="NoticeManager_EditFormPanel" class="board" >
			<!-- NoticeManager_propertyTabs -->
			<div id="NoticeManager_propertyTabs">
				<ul>
					<li><a href="#NoticeManager_DetailTabPage"><util:message key='ev.title.notice.detailTab'/></a></li>   
					<li><a href="#NoticeManager_NoticeMetadataTabPage" onclick="aNoticeManager.onSelectPropertyTab(1);"><util:message key='ev.title.notice.noticeMetadataTab'/></a></li>   
				</ul>			
				<!-- NoticeManager_DetailTabPage -->
				<div id="NoticeManager_DetailTabPage">
					<div class="webformpanel" style="width:100%;">
						<form id="NoticeManager_EditForm" style="display:inline" action="" method="post">
							<input type="hidden" id="NoticeManager_isCreate">
							<input type="hidden" id="NoticeManager_isEmergency" name="isEmergency"> 
							<input type="hidden" id="NoticeManager_principalId" name="principalId">
							<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판</caption>
								<colgroup>
									<col width="120px"/>
									<col width="*"/>
									<col width="100px"/>
									<col width="*"/>
								</colgroup>							
								<tr>
									<th class="L"><util:message key='ev.prop.notice.noticeId'/></th>
									<td class="L">
										<input type="text" id="NoticeManager_noticeId" name="noticeId" maxLength="10" value="" label="<util:message key='ev.prop.notice.noticeId'/>" class="txt_100" readOnly="true"/>
									</td>
									<th class="L"><util:message key='ev.title.notice.method'/> <em>*</em></th>
									<td class="L">
										<input type="radio" id="NoticeManager_popup" name="noticeMethod" value="1" onclick="aNoticeManager.doDisplayTemplate(this)"><util:message key='ev.title.notice.method.popup'/> &nbsp;&nbsp;
										<input type="radio" id="NoticeManager_ticker" name="noticeMethod" value="0" onclick="aNoticeManager.doDisplayTemplate(this)"><util:message key='ev.title.notice.method.ticker'/> &nbsp;&nbsp;
									</td>
								</tr>
									<th class="L"><util:message key='ev.prop.notice.title'/> <em>*</em></th>
									<td colspan="3" class="L">
										<input type="text" id="NoticeManager_title" name="title" value="" maxLength="25" label="<util:message key='ev.prop.notice.title'/>" class="txt_100" />
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.prop.notice.startDate'/></td>
									<td class="L">
										<input type="text" id="NoticeManager_startDate" name="startDate" value="" maxLength="10" size="10" label="<util:message key='ev.prop.notice.startDate'/>" class="txt_100" />
										<div class="sel_100">
											<select id="NoticeManager_startHour" class='txt_100'> 
												<option value="00">00</option>
												<option value="01">01</option>
												<option value="02">02</option>
												<option value="03">03</option>
												<option value="04">04</option>
												<option value="05">05</option>
												<option value="06">06</option>
												<option value="07">07</option>
												<option value="08">08</option>
												<option value="09">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
											</select>
										</div>
										<div class="sel_100">
											<select id="NoticeManager_startMin" class='txt_100'> 
												<option value="00">00</option>
												<option value="05">05</option>
												<option value="10">10</option>
												<option value="15">15</option>
												<option value="20">20</option>
												<option value="25">25</option>
												<option value="30">30</option>
												<option value="35">35</option>
												<option value="40">40</option>
												<option value="45">45</option>
												<option value="50">50</option>
												<option value="55">55</option>
											</select>
										</div>
									</td>
									<th class="L"><util:message key='ev.prop.notice.endDate'/></th>
									<td class="L">
										<input type="text" id="NoticeManager_endDate" name="endDate" value="" maxLength="10" size="10" label="<util:message key='ev.prop.notice.endDate'/>" class="txt_100" />
										<div class="sel_100">
											<select id="NoticeManager_endHour" class='txt_100'> 
												<option value="00">00</option>
												<option value="01">01</option>
												<option value="02">02</option>
												<option value="03">03</option>
												<option value="04">04</option>
												<option value="05">05</option>
												<option value="06">06</option>
												<option value="07">07</option>
												<option value="08">08</option>
												<option value="09">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
											</select>
										</div>
										<div class="sel_100">
											<select id="NoticeManager_endMin" class='txt_100'> 
												<option value="00">00</option>
												<option value="05">05</option>
												<option value="10">10</option>
												<option value="15">15</option>
												<option value="20">20</option>
												<option value="25">25</option>
												<option value="30">30</option>
												<option value="35">35</option>
												<option value="40">40</option>
												<option value="45">45</option>
												<option value="50">50</option>
												<option value="55">55</option>
											</select>
										</div>
									</td>
								</tr>
								<tr id="NoticeManager_templatePane">
									<th class="L"><util:message key='ev.prop.notice.template'/></th>
									<td class="L">
										<div class="sel_100">
											<select id="NoticeManager_template" name="template" label="<util:message key='ev.prop.notice.template'/>" class='txt_200'>
												<option value=""></option>
												<c:forEach items="${noticeTemplates}" var="template">
													<option value="<c:out value="${template}"/>"><c:out value="${template}"/></option>
												</c:forEach>
											</select>
										</div>
									</td>
									<th class="L"><util:message key='ev.title.notice.domainNm'/></th>
									<td class="L">
										<div class="sel_100">
											<select id="NoticeManager_domainId" name="domainId_label" class='txt_100'>
												<c:forEach items="${domainList}" var="domainInfo">
													<c:if test="${domainInfo.domainId == 0}">
														<option value="<c:out value="${domainInfo.domainId}"/>"><c:out value="${domainInfo.domainNm}"/></option>
													</c:if>
													<c:if test="${domainInfo.domainId != 0}">
														<option value="<c:out value="${domainInfo.domainId}"/>"><c:out value="${domainInfo.domainNm}"/></option>
													</c:if>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr id="NoticeManager_positionPane">
									<th class="L"><util:message key='ev.title.notice.position'/>(px) <em>*</em></th>
									<td colspan="3" class="L">
										<span class="sel_txt">Left</span> <input type="text" id="NoticeManager_layoutX" name="layoutX" value="" maxLength="4" size="5" class="txt_100" />
										<span class="sel_txt">Top</span> <input type="text" id="NoticeManager_layoutY" name="layoutY" value="" maxLength="4" size="5" class="txt_100" />
										<span class="sel_txt">Width</span> <input type="text" id="NoticeManager_layoutWidth" name="layoutWidth" value="" maxLength="4" size="5" class="txt_100" />
										<span class="sel_txt">Height</span> <input type="text" id="NoticeManager_layoutHeight" name="layoutHeight" value="" maxLength="4" size="5" class="txt_100" />										
									</td>
								</tr>
								<tr>
									<th class="L">
										적용그룹
									</th>
									<td class="L">
										<input type="hidden" id="NoticeManager_groups" name="groups"> 
										<select id='NoticeManager_groups_list' size='5' multiple='true' class="selbox" style="width: 150px; height: 100px"></select>
										<a href="javascript:aNoticeManager.getGroupChooser().doShow(aNoticeManager.setGroupChooserCallback)"  class="btn_B">
											<span>그룹선택</span>
										</a>
										<a href="javascript:aNoticeManager.doRemoveGroup()" class="btn_B">
											<span>삭제</span>
										</a>
									</td>
									<th class="L">
										적용페이지
										
									</th>
									<td class="L">
										<input type="hidden" id="NoticeManager_pages" name="pages"> 
										<select id='NoticeManager_pages_list' size='5' multiple='true' class="selbox" style="width: 150px; height: 100px" ></select>
										<a href="javascript:aNoticeManager.getPageChooser().doShow(aNoticeManager.setPageChooserCallback)" class="btn_B">
											<span >페이지선택</span>
										</a>
										<a href="javascript:aNoticeManager.doRemovePage()" class="btn_B" >
											<span >삭제</span>
										</a>
										<br>
										<input type="checkbox" id="NoticeManager_systemCode" value="MY" />
										<label for="NoticeManager_systemCode">&nbsp;마이페이지&nbsp;&nbsp;</label>
									</td>
								</tr>
							</table>
							<!-- btnArea-->
							<div class="btnArea"> 
								<div class="rightArea">
									<a href="javascript:aNoticeManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
									<a href="javascript:aNoticeManager.doCopy()" class="btn_B"><span id="NoticeManager_copy">복사</span></a>
								</div>
							</div>
							<!-- btnArea//-->
						</form>
					</div>
				</div>
				<!-- NoticeManager_DetailTabPage// -->
				<div id="NoticeManager_NoticeMetadataTabPage">
					<%@include file="../notice/noticeMetadataList.jsp"%>
				</div>
			</div>
			<!-- NoticeManager_propertyTabs// -->
		</div>
		<!-- NoticeManager_EditFormPanel// -->			
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="PageManager_PageChooser">
	<div id="PageChooser_TreeTabPage" class="tree" style="border-right: 0px #ffffff;"></div>
</div>

<div id="GroupManager_GroupChooser"></div>