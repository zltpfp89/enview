<%@page language="java" pageEncoding="UTF-8"%>
<%@ include file="../initLayoutDecorators.jsp" %>
<%@page import="com.saltware.enview.aggregator.PortletRenderer"%>
<%@page import="com.saltware.enview.components.portletregistry.PortletRegistry"%>

<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%  
	try {
		PortletRenderer renderer = (PortletRenderer)request.getAttribute("renderer");
		PortletRegistry registry = (PortletRegistry)request.getAttribute("registry");
		boolean isRoot = (Boolean)request.getAttribute("isRoot");
		Fragment layoutFragment = (Fragment)request.getAttribute("currentFragment");
		String layoutClass = "portal-layout";
		if( isRoot ) {
			layoutClass = "portal-nested-layout";
		}
%>    		
		<div id="Enview_Layout_<%=layoutFragment.getId()%>" class="portal-layout">
<%
	if( "tab".equals(layoutFragment.getAlign()) == true ) {

	FragmentLayout fragmentLayout = layoutFragment.getFragmentLayout();
	if( fragmentLayout != null ) {
		Iterator it = fragmentLayout.getColumns().iterator();
		for(int columnIndex=0; it.hasNext(); columnIndex++) {
	Collection column = (Collection)it.next();
	String columnFloat = fragmentLayout.getColumnFloat(columnIndex);
	String columnWidth = fragmentLayout.getColumnWidth(columnIndex);
%>				    		
					<div id="Enview_Column_<%=layoutFragment.getId()%>_<%=columnIndex%>" class="tab-main" style="float:<%=columnFloat%>; width:<%=columnWidth%>;">
<%
	int colSize = column.size() - 1;
	Iterator it2 = column.iterator();
	for(int trow_id=0; it2.hasNext(); trow_id++) {
		Fragment f = (Fragment)it2.next();
		
		int col = f.getLayoutRow();
		int row = f.getLayoutColumn();
%>							
						<div class="tab-header" id="TabHeader-<%=f.getId()%>"> <!-- tab-header start-->
						<ul>
<%
	Iterator it3 = column.iterator();
		for(int tcol_id=0; it3.hasNext(); tcol_id++) {
			Fragment f2 = (Fragment)it3.next();
			
			String tabTitle = f2.getPreferenceValue("TITLE");
			if( tabTitle == null ) {
				PortletDefinition portlet = f2.getPortlet();
				if( portlet != null ) {
					tabTitle = portlet.getDisplayName( _rc.getLocale() ).getDisplayName();
				}
				else {
					tabTitle = f2.getName();
				}
			}
%>	
							<li>
<%
	if( trow_id == tcol_id ) {
%>
								<span class="tabActiveLeft">&nbsp;</span>
								<span id="Enview_TabHeader_<%=f2.getId()%>" class="tabActive"><a href="#"><%=tabTitle%></a></span>
								<span class="tabActiveRight">&nbsp;</span>
<%
	} else { 
				if(tcol_id == 0) {
%>
									<span id="Enview_TabHeader_<%=f2.getId()%>" class="tabInactive"><a href="#"><%=tabTitle%></a></span>
									<span class="tabInactiveRight">&nbsp;</span>
<%
	} 
				else if(tcol_id == colSize) {
%>
									<span id="Enview_TabHeader_<%=f2.getId()%>" class="tabInactive"><a href="#"><%=tabTitle%></a></span>
<%
	} 
				else {
%>
									<span id="Enview_TabHeader_<%=f2.getId()%>" class="tabInactive"><a href="#"><%=tabTitle%></a></span>
									<span class="tabInactiveRight">&nbsp;</span>
<%
	}
			}
%>
							</li>
<%
	}
		
		if( f.getPreferenceValue("MORE_SRC") != null ) {
%>
							<span class="tabMore">
								<a href="<%=f.getPreferenceValue("MORE_SRC")%>" target="<%=f.getPreferenceValue("MORE_SRC_TARGET")%>">
									<img src="/enview/decorations/layout/images/tabtitle_more.gif" alt="<%=f.getTitle()%>">
								</a>
							</span>
<%
	}
%>
						</ul>
						</div><!-- tab-header end-->
						<div class="tab-content" id="TabContent-<%=f.getId()%>">
<%
	if( "portlet".equals(f.getType()) ) {
			Map contentBuffer = new HashMap();
			renderer.renderNow(f, _rc, contentBuffer); // 20120224 Modified
			String content = "";
			if( f.getOverriddenContent() != null && f.getOverriddenContent().length() > 0) {
				content = f.getOverriddenContent(); // 20120224 Modified
			} else {
				PortletContent portletContent = (PortletContent)contentBuffer.get("content");
				if( portletContent != null ) {
					content=  portletContent.getContent(); // 20120224 Modified
				}
			}
%>								
							<div id="Enview_Portlet_<%=f.getId()%>" class="portlet"> <%=content%> </div>
<%
	} 
		else {
%>
							Layout is not allow in this tab area.
<%
	}
%>
						</div> <!--tab-content -->
<%
	}
%>
					</div> <!-- tab-main -->
<%
	}
	}
%>
			<br style="clear:both;"/>
<%
	}
		else {

	FragmentLayout fragmentLayout = layoutFragment.getFragmentLayout();
	if( fragmentLayout != null ) {
		Iterator it = fragmentLayout.getColumns().iterator();
		for(int columnIndex=0; it.hasNext(); columnIndex++) {
	Collection column = (Collection)it.next();
	String columnFloat = fragmentLayout.getColumnFloat(columnIndex);
	String columnWidth = fragmentLayout.getColumnWidth(columnIndex);
	String marginLeft = "";
	if(columnIndex == 1) marginLeft = "margin-left: 7px;";
	String columnStyle = "float:" + columnFloat + "; width: " + columnWidth + "; min-height:1px; " + marginLeft;
%>	    		    				
					<div id="Enview_Column_<%=layoutFragment.getId()%>_<%=columnIndex%>" class="column" style="<%=columnStyle%>">
<%
	Iterator it2 = column.iterator();
	for(int rowIndex=0; it2.hasNext(); rowIndex++) {
		Fragment f = (Fragment)it2.next();
		
		int col = f.getLayoutRow();
		int row = f.getLayoutColumn();
		
		if( "portlet".equals(f.getType()) ) {
			NavigationalState nav = _rc.getPortalURL().getNavigationalState();
			WindowState _ws = nav.getMappedState(f.getId());

			PortletDefinition portlet = f.getPortlet();
			if( portlet == null ) {
				portlet = registry.getPortletDefinitionByUniqueName(f.getName());
				f.setPortlet(portlet);
			}

			String _pTitle = f.getPreferenceValue("TITLE");
			if( _pTitle == null ) {
				portlet = f.getPortlet();
				if( portlet != null ) {
					_pTitle = portlet.getDisplayName( _rc.getLocale() ).getDisplayName();
				}
				else {
					_pTitle = f.getName();
				}
			}
			
			Map contentBuffer = new HashMap();
			renderer.renderNow(f, _rc, contentBuffer); // 20120224 Modified
			
			String content = "";
			if( f.getOverriddenContent() != null && f.getOverriddenContent().length() > 0) {
				content = f.getOverriddenContent(); // 20120224 Modified
			} else {
				PortletContent portletContent = (PortletContent)contentBuffer.get("content");
				if( portletContent != null ) {
					content=  portletContent.getContent(); // 20120224 Modified
				}
			}
			if( content.length() > 0 ) { // 20120224 Modified
				
				String style = f.getPreferenceValue("STYLE");
				if( style != null ) {
%>
									<div id="Enview_Portlet_<%=f.getId()%>" class="portlet" style="<%=style%>"> <!-- portlet start -->
<%
	}
				else {
%>
									<div id="Enview_Portlet_<%=f.getId()%>" class="portlet"> <!-- portlet start -->
<%
	}
				
				String titleShow = f.getPreferenceValue("TITLE-SHOW");
				if( titleShow != null && titleShow.equals("true") ) {
%>
									<div class="portlet-title"> <!-- portlet-title start -->
<%
	}
				else {
%>
									<div class="portlet-title" style="display:none;"> <!-- portlet-title start -->
<%
	}
				String portletActions = portletActionBar(f.getPortlet(), f.getDecoration(), _rc);
%>	
									
									<span class="portlet-title-content"><%=_pTitle%></span> <%=portletActions%>
<%
	if( f.getPreferenceValue("MORE_SRC") != null ) {
%>
									<span class="portlet-title-more">
										<a href="<%=f.getPreferenceValue("MORE_SRC")%>" target="<%=f.getPreferenceValue("MORE_SRC_TARGET")%>">
											<img src="<%=themePath%>/images/portlet/tabtitle_more.gif" alt="<%=_pTitle%>">
										</a>
									</span>
<%
	}
%>
									</div> <!-- portlet-title end -->
<%
	if( "minimized".equals(_ws.toString()) == false ) {
%>
									<div id="Enview_Portlet_Content_<%=f.getId()%>" class="portlet-content"><%=content%></div>
<%
	}
%>
								</div> <!-- portlet end -->
<%
	}
		} 
		else {
			request.setAttribute("isRoot", new Boolean(false));
			request.setAttribute("currentFragment", f);
%>
							<jsp:include page="./layout.jsp" />
<%
	}
	}
%>
					</div> <!-- portal-layout-column -->
<%
	}
	}
	if( fragmentLayout != null ) {
		if( fragmentLayout.getColumns().size() > 1 ) {
%>
					<br style="clear:both;"/>
<%	        	}
			}
		} %>
		</div> <!--portal-layout-->
<%	}
	catch(Exception e)
	{
		Log log = LogFactory.getLog(getClass());
		log.error( e.getMessage(), e);; 
	}
%>
