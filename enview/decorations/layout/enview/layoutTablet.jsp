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
		FragmentLayout fragmentLayout = layoutFragment.getFragmentLayout();
		if( fragmentLayout != null ) {
			Iterator it = fragmentLayout.getColumns().iterator();
			for(int columnIndex=0; it.hasNext(); columnIndex++) {
				Collection column = (Collection)it.next();
				String columnFloat = fragmentLayout.getColumnFloat(columnIndex);
				String columnWidth = fragmentLayout.getColumnWidth(columnIndex);
	
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
						if( content.length() > 0 ) { // 20120224 Modified %>
							<div id="Enview_Portlet_<%=f.getId()%>" class="portlet">
								<div id="Enview_Portlet_Content_<%=f.getId()%>" class="portlet-content"><%= content %></div>
							</div>
<%		    			}
					} 
					else {
						request.setAttribute("isRoot", new Boolean(false));
						request.setAttribute("currentFragment", f);  %>
						<jsp:include page="./layoutTablet.jsp" />
<%					}
				} 
			}

			if( fragmentLayout != null ) {
				if( fragmentLayout.getColumns().size() > 1 ) { %>
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
