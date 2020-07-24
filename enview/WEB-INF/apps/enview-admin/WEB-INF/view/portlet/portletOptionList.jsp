
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletOptionManager.js"></script>


<!-- board -->
<div class="sub_contents">
	<div class="detail">
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="PortletOptionManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="PortletOptionManager_SearchForm" name="PortletOptionManager_SearchForm" style="display:inline" action="javascript:aPortletOptionManager.doSearch('PortletOptionManager_SearchForm')" method="post">
					  
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aPortletOptionManager.doPage'/>
						<input type='hidden' name='formName' value='PortletOptionManager_SearchForm'/>
					 
						<input type='hidden' id='PortletOptionManager_applicationName' name='applicationName' value=''/>
						<input type='hidden' id='PortletOptionManager_portletName' name='portletName' value=''/>
					  
					  	<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aPortletOptionManager.doSearch('PortletOptionManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
					</form>
				</fieldset>						    
				</div>
				<!-- searchArea//-->
				<!-- table-->
				<form id="PortletOptionManager_ListForm" style="display:inline" name="PortletOptionManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판리스트" class="table_board list">
				<caption>게시판리스트</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="100px" />
						<col width="*" />
					</colgroup>				
					<thead>
						<tr>
							<th class="first C">
								<input type="checkbox" id="delCheck" onclick="aPortletOptionManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
						
							<th class="C" ch="0" onclick="aPortletOptionManager.doSort(this, 'OPTION_NAME');" >
								<span class="table_title"><util:message key='ev.prop.portletDefinition.optionName'/></span>
							</th>	
							<th class="C" ch="0" onclick="aPortletOptionManager.doSort(this, 'OPTION_VALUE');" >
								<span class="table_title"><util:message key='ev.prop.portletDefinition.optionValue'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="PortletOptionManager_ListBody">
						<c:forEach items="${results}" var="portletoption" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C fixed">
									<input type="checkbox" id="PortletOptionManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
								
									<input type="hidden" id="PortletOptionManager[<c:out value="${status.index}"/>].id" value="<c:out value='${portletoption.id}'/>"/>
								</td>
								<td class="C fixed"><c:out value="${status.index}"/></td>
								
								<td class="L" onclick="aPortletOptionManager.doSelect(this)">
									<span id="PortletOptionManager[<c:out value="${status.index}"/>].name.label">&nbsp;<c:out value="${portletoption.name}"/></span>
								</td>
								<td class="L" onclick="aPortletOptionManager.doSelect(this)">
									<span id="PortletOptionManager[<c:out value="${status.index}"/>].value.label">&nbsp;<c:out value="${portletoption.value}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				  </table>
				  </form>
				  <!-- table//-->	
				  <div class="tsearchArea">
				  	<p id="PortletOptionManager_ListMessage"><c:out value='${resultMessage}'/></p>
				  </div>
				  <!-- tcontrol-->
				  <div class="tcontrol">
				  	<!-- paging -->
				  	<div id="PortletOptionManager_PAGE_ITERATOR" class="paging">
						<c:out escapeXml='false' value='${pageIterator}'/>
				    </div>
				    <!-- paging//-->
				  </div>
				  <!-- tcontrol//-->
				  <!-- btnArea-->
				  <div class="btnArea">
				  	<div class="rightArea">
						<a href="javascript:aPortletOptionManager.doCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
						<a href="javascript:aPortletOptionManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
					</div>
				  </div>
				  <!-- btnArea//-->	
				  <div id="PortletOptionManager_EditFormPanel">
				  	<div id="PortletOptionManager_propertyTabs">
						<ul>
							<li><a href="#PortletOptionManager_DetailTabPage"><util:message key='ev.title.portlet.detailTab'/></a></li>   
							
						</ul>
						<div id="PortletOptionManager_DetailTabPage">
							<div class="webformpanel">
								<form id="PortletOptionManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding='0' cellspacing='0' border='0' class="table_board">
									<input type="hidden" id="PortletOptionManager_isCreate">
									
									<input type="hidden" id="PortletOptionManager_id" name="id"> 
									<input type="hidden" id="PortletOptionManager_portletId" name="portletId"> 
									<caption>게시판리스트</caption>
									<colgroup>
										<col width="140px" />
										<col width="*" />
									</colgroup> 
									<tr class="first">
										<th class="L"><util:message key='ev.prop.portletDefinition.optionName'/> <em>*</em></th>
										<td class="L">
											<input type="text" id="PortletOptionManager_optionName" name="optionName" value="" maxLength="100" label="<util:message key='ev.prop.portletDefinition.optionName'/>" class="txt_600" style="width:75%;"/>
											<div class="sel_100">
												<select id="PortletOptionManager_name_select" class="txt_100" onchange="aPortletOptionManager.changeSelectItem(this)">
													<!--option value=""></option-->
													<option value="AUTO-RESIZE">Auto Resize</option>
													<option value="WIDTH">Width</option>
													<option value="MAX-WIDTH">Max Width</option>
													<option value="HEIGHT">Height</option>
													<option value="MAX-HEIGHT">Max Height</option>
													<option value="SCROLLING">Scrolling</option>
													<!--option value="url">Url</option-->
													<option value="SRC">SRC</option>
													<option value="MORE_SRC">MORE_SRC</option>
													<option value="MORE_SRC_TARGET">MORE_SRC_TARGET</option>
													<option value="CSS">CSS</option>
													<option value="JAVASCRIPT">JAVASCRIPT</option>
													<option value="TITLE-SHOW">TITLE-SHOW</option>
												</select>
											</div>	
										</td>
									</tr>
									<tr >
										<th class="L"><util:message key='ev.prop.portletDefinition.optionValue'/> <em>*</em></th>
										<td class="L">
											<input type="text" id="PortletOptionManager_optionValue" name="optionValue" value="" cols="80" rows="3" maxLength="1024" label="<util:message key='ev.prop.portletDefinition.optionValue'/>" class="txt_400" />
										</td>
									</tr>
								</table>
								<!-- btnArea-->
								<div class="btnArea">
									<div id="PortletOptionManager_Child_EditButtons" class="rightArea">
										<a href="javascript:aPortletOptionManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
									</div>
								</div>
								<!-- btnArea//-->
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					</div>
				</div> <!-- End PortletOptionManager_EditFormPanel -->
			</div>
		</div>
	</div>
		
<div id="PortletOptionManager_PortletOptionChooser"></div>