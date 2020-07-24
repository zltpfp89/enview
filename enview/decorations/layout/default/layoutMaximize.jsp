<%@page language="java" pageEncoding="UTF-8"%>
<%@ include file="../initLayoutDecorators.jsp" %>
<%@page import="com.saltware.enview.aggregator.PortletRenderer"%>
<%@page import="com.saltware.enview.components.portletregistry.PortletRegistry"%>

<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%  
	try {
		PortletRenderer renderer = (PortletRenderer)request.getAttribute("renderer");
		PortletRegistry registry = (PortletRegistry)request.getAttribute("registry");
		PortletWindow window = (PortletWindow)request.getAttribute("window");
		
		Fragment maxedContentFragment = currentPage.getFragmentById(window.getId().toString());
        if (maxedContentFragment != null)
        {
            PortletDefinition portlet = maxedContentFragment.getPortlet();
			if( portlet == null ) {
				portlet = registry.getPortletDefinitionByUniqueName(maxedContentFragment.getName());
				maxedContentFragment.setPortlet(portlet);
			}
        	
			String _pTitle = maxedContentFragment.getPreferenceValue("TITLE");
			if( _pTitle == null ) {
				if( portlet != null ) {
					_pTitle = portlet.getDisplayName( _rc.getLocale() ).getDisplayName();
				}
				else {
					_pTitle = maxedContentFragment.getName();
				}
			}
			
			Map contentBuffer = new HashMap();
		    renderer.renderNow(maxedContentFragment, _rc, contentBuffer); // 20120224 Modified
		    String content = "";
			if( maxedContentFragment.getOverriddenContent() != null ) {
		    	content = maxedContentFragment.getOverriddenContent(); // 20120224 Modified
		    }
			else {
				PortletContent portletContent = (PortletContent)contentBuffer.get("content");
				if( portletContent != null ) {
					content=  portletContent.getContent(); // 20120224 Modified
				}
			}
		    
			if( content.length() > 0 ) { // 20120224 Modified
				String style = maxedContentFragment.getPreferenceValue("STYLE");
				if( style != null ) { %>
					<div id="Enview_Portlet_<%=maxedContentFragment.getId()%>" class="portlet" style="<%=style%>">
<%		    	}
				else { %>
					<div id="Enview_Portlet_<%=maxedContentFragment.getId()%>" class="portlet">
<%		     	} 
				
				String titleShow = maxedContentFragment.getPreferenceValue("TITLE-SHOW");
				if( titleShow != null && titleShow.equals("true") ) { %>
					<div id="Enview_PortletTitle_<%=maxedContentFragment.getId()%>" class="portlet-title"> <!-- portlet-title start -->
<%		    	}
				else { %>
					<div id="Enview_PortletTitle_<%=maxedContentFragment.getId()%>" class="portlet-title" style="display:none;"> <!-- portlet-title start -->
<%		    	}
				String portletActions = portletActionBar(maxedContentFragment.getPortlet(), maxedContentFragment.getDecoration(), _rc); %>	
					
					<span class="portlet-title-content"><%= _pTitle %></span> <%= portletActions %>
<%		    	if( maxedContentFragment.getPreferenceValue("MORE_SRC") != null ) { %>
					<span class="portlet-title-more">
						<a href="<%=maxedContentFragment.getPreferenceValue("MORE_SRC")%>" target="<%=maxedContentFragment.getPreferenceValue("MORE_SRC_TARGET")%>">
							<img src="<%=themePath%>/images/portlet/tabtitle_more.gif" alt="<%=_pTitle%>">
						</a>
					</span>
<%				} %>
					</div> <!-- portlet-title end -->
					<div class="portlet-content"><%= content %></div>
				</div> <!-- portlet end -->
<%			}
        }
        else
        {
            throw new Exception("Maximized fragment not found."); 
        }
	}
	catch(Exception e)
	{
		Log log = LogFactory.getLog(getClass());
		log.error( e.getMessage(), e);; 
	}
%>
