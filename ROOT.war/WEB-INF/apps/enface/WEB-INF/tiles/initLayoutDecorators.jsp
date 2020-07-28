<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="com.saltware.enview.util.IFrameUtil"%>
<%@page import="com.saltware.enview.domain.DomainInfo"%>
<%@page import="com.saltware.enview.security.EVSubject"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib uri='/WEB-INF/tld/portlet.tld' prefix='portlet'%>

<%@page import="org.apache.commons.logging.Log"%>
<%@page import="org.apache.commons.logging.LogFactory"%>
<%@page import="com.saltware.enview.Enview"%>
<%@page import="com.saltware.enview.PortalReservedParameters"%>
<%@page import="com.saltware.enview.decoration.DecorationFactory"%>
<%@page import="com.saltware.enview.decoration.Decoration"%>
<%@page import="com.saltware.enview.decoration.LayoutDecoration"%>
<%@page import="com.saltware.enview.decoration.DecoratorAction"%>
<%@page import="com.saltware.enview.decoration.LayoutInfo"%>
<%@page import="com.saltware.enview.decoration.Theme"%>
<%@page import="com.saltware.enview.layout.EnviewPowerTool"%>
<%@page import="com.saltware.enview.om.page.Page"%>
<%@page import="com.saltware.enview.om.page.Fragment"%>
<%@page import="com.saltware.enview.om.page.FragmentLayout"%>
<%@page import="com.saltware.enview.om.preference.FragmentPreference"%>
<%@page import="com.saltware.enview.om.preference.EnviewPreference"%>
<%@page import="com.saltware.enview.request.RequestContext"%>
<%@page import="com.saltware.enview.portalsite.PortalSiteRequestContext"%>
<%@page import="com.saltware.enview.security.EnviewSecurityManager"%>
<!--%@page import="com.saltware.enview.om.portlet.PortletDefinition"%-->
<%@page import="org.apache.pluto.container.om.portlet.PortletDefinition"%>
<%@page import="com.saltware.enview.aggregator.PortletContent"%>
<%@page import="com.saltware.enview.container.state.NavigationalState"%>
<%@page import="javax.portlet.WindowState"%>
<%@page import="com.saltware.enview.container.PortletWindow"%>

<%@page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@page import="com.saltware.enview.code.EnviewCodeManager"%>
<%@page import="com.saltware.enview.codebase.CodeBundle"%>
<%@page import="com.saltware.enview.security.UserInfo"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Locale"%>
<%@page import="java.lang.StringBuffer"%>
<%@page import="java.math.BigDecimal"%>

<%@page import="com.saltware.enview.security.EnviewMenu"%>


<!--portlet:defineObjects/-->

<%!
	Log log = LogFactory.getLog(getClass());
	
	private String getLayoutResource(LayoutDecoration _layoutDecoration,String _path)
	{
		String _resourcePath = _layoutDecoration.getResource(_path);
		return ((null == _resourcePath) ? _path : _resourcePath);
	}
	
	private String includePageInfo(Page page, RequestContext rc, Locale locale, LayoutDecoration layoutDecoration, String admContextPath)
	{
		//System.out.println("######### themeName=" + (String)rc.getRequest().getAttribute("themeName"));
		//System.out.println("######### page=" + page);
		StringBuffer buff = new StringBuffer();
		buff.append("{");
		buff.append("\"id\": \"").append(page.getId()).append("\", ");
		buff.append("\"path\": \"").append(page.getPath()).append("\", ");
		buff.append("\"title\": \"").append(page.getTitle(locale)).append("\", ");
		
		String contextPath = rc.getRequest().getContextPath();
		String targetUrl = (page.getTargetUrl() != null) ? page.getTargetUrl() : "";
		int pos = targetUrl.indexOf("/enview");
		if( contextPath.indexOf("/enview") == -1 ) {
			if( contextPath.equals("/") || contextPath.equals("") ) {
				if( pos > -1 ) {
					targetUrl = targetUrl.substring(pos+7);
				}
			}
			else {
				if( pos > -1 ) {
					targetUrl = contextPath + targetUrl.substring(pos+7);
				}
			}
		}
		//System.out.println("######### targetUrl=" + targetUrl);
       	Map paramMap = new HashMap();
//		paramMap.put("lang_knd", (String)rc.getUserDataValue("lang_knd"));
		paramMap.put("evSecurityCode", (String)rc.getAttribute("evSecurityCode"));
//		paramMap.put("userAgent", (String)rc.getAttribute("userAgent"));
//		paramMap.put("isMobile", (String)rc.getAttribute("isMobile"));
    	String newUrl = IFrameUtil.makeUrlWithParameter(rc.getRequest(), targetUrl, paramMap);
		
		
		
		buff.append("\"targetUrl\": \"").append( newUrl).append("\", ");
		buff.append("\"useIframe\": \"").append(page.getUseIFrame()).append("\", ");
		buff.append("\"contextPath\": \"").append(rc.getRequest().getContextPath()).append("\", ");
		buff.append("\"servletPath\": \"").append(rc.getRequest().getServletPath()).append("\", ");
		buff.append("\"theme\": \"").append( (String)rc.getRequest().getAttribute("themeName") ).append("\", ");
		buff.append("\"evalTheme\": \"").append( (String)rc.getRequest().getAttribute("evalTheme") ).append("\", ");
		buff.append("\"themePath\": \"").append(layoutDecoration.getImageResource("/")).append("\", ");
		buff.append("\"admContextPath\": \"").append(admContextPath).append("\", ");
		buff.append("\"layout\": \"").append( (page.getRootFragment() != null) ? page.getRootFragment().getName() : "" ).append("\" ");
		buff.append("}");
		
		//System.out.println("######### buff=" + buff.toString());
		
		return buff.toString();
	}
	
	private String includeFragmentNavigation(Fragment rootFragment, RequestContext rc, Locale locale, LayoutDecoration layoutDecoration, String admContextPath)
	{
		//System.out.println("######### themeName=" + (String)rc.getRequest().getAttribute("themeName"));
		StringBuffer buff = new StringBuffer();
		buff.append("{");
		
		
		if( rootFragment != null ) {
			
			//System.out.println("######### page=" + rootFragment.getPage());
			buff.append("\"pageAttribute\" : {");
			buff.append("\"id\": \"").append(rootFragment.getPage().getId()).append("\", ");
			buff.append("\"path\": \"").append(rootFragment.getPage().getPath()).append("\", ");
			buff.append("\"title\": \"").append(rootFragment.getPage().getTitle(locale)).append("\", ");
			buff.append("\"contextPath\": \"").append(rc.getRequest().getContextPath()).append("\", ");
			buff.append("\"servletPath\": \"").append(rc.getRequest().getServletPath()).append("\", ");
			buff.append("\"theme\": \"").append( (String)rc.getRequest().getAttribute("themeName") ).append("\", ");
			buff.append("\"themePath\": \"").append(layoutDecoration.getImageResource("/")).append("\", ");
			buff.append("\"admContextPath\": \"").append(admContextPath).append("\"}, ");
			
			buff.append("\"attribute\" : ");
			includeFragmentAttribute(buff, rootFragment);
			
			buff.append("\"fragments\" : [");
			Iterator it = rootFragment.getFragments().iterator();
			for(int i=0; it.hasNext(); i++) {
				Fragment child = (Fragment)it.next();
				includeChildFragmentNavigation(buff, child, i);
			}
			buff.append("]");
		}
		else {
			//buff.append("pageAttribute : {");
			//buff.append("id: \"").append("12").append("\", ");
			//buff.append("path: \"").append("zzz").append("\"}, ");
			
			buff.append("attribute : [], fragments : []");
		}
		
		buff.append("}");
		
		return buff.toString();
	}
	
	private void includeChildFragmentNavigation(StringBuffer buff, Fragment childFragment, int cnt)
	{
		if( cnt > 0 ) buff.append( "," );
		buff.append("{");
		buff.append("\"attribute\" : ");
		includeFragmentAttribute(buff, childFragment);
		buff.append("\"fragments\" : [");
		
		Iterator it = childFragment.getFragments().iterator();
		for(int i=0; it.hasNext(); i++) {
			Fragment child = (Fragment)it.next();
			includeChildFragmentNavigation(buff, child, i);
		}
		
		buff.append("]");
		buff.append("}");
	}
	
	private void includeFragmentAttribute(StringBuffer buff, Fragment fragment)
	{
		buff.append("{");
		buff.append("\"id\": \"").append(fragment.getId()).append("\", ");
		buff.append("\"name\": \"").append(fragment.getName()).append("\", ");
		buff.append("\"type\": \"").append(fragment.getType()).append("\", ");
		
		FragmentLayout fragmentLayout = fragment.getFragmentLayout();
		if( fragmentLayout != null ) {
			String columnIds = "";
			Iterator cit = fragmentLayout.getColumns().iterator();
			for(int cnt=0; cit.hasNext(); cnt++) {
				Collection column = (Collection)cit.next();
				columnIds += fragment.getId() + "_" + String.valueOf(cnt) + ",";
			}
			buff.append("\"columnIds\" : \"").append(columnIds).append("\", ");
		}
			
		buff.append("\"contentType\": \"").append(fragment.getContentType()).append("\", ");
		buff.append("\"decorator\": \"").append(fragment.getDecorator()).append("\", ");
		buff.append("\"align\": \"").append(fragment.getAlign()).append("\" ");
		
		for(Iterator it=fragment.getAllPreferences().iterator(); it.hasNext(); )
		{
			Object obj = it.next();
			if( obj instanceof EnviewPreference ) {
				EnviewPreference preference = (EnviewPreference)obj;
				buff.append(", \"").append(preference.getName()).append("\": \"").append(preference.getValue()).append("\" ");
			}
			else  {
				FragmentPreference preference = (FragmentPreference)obj;
				buff.append(", \"").append(preference.getName()).append("\": \"").append(preference.getValue()).append("\" ");
			}
		}
		buff.append("},");
	}

	private List getDecorations(RequestContext rc, DecorationFactory decorationFactory)
	{
		List results = new ArrayList();
		try {
			Iterator it=decorationFactory.getPageDecorations(rc).iterator();
			for(int i=0; it.hasNext(); i++)
			{
				results.add( (String)it.next() );
			}
			//System.out.println("############### reults=" + results);
		}
		catch(NullPointerException e) {
			log.error( e.getMessage(), e);; 
		}
		catch(Exception e) {
			log.error( e.getMessage(), e);; 
		}
		
		return results;
	}
	
	private String includeDecorations(RequestContext rc, DecorationFactory decorationFactory)
	{
		StringBuffer buff = new StringBuffer();
		try {
			buff.append("{");
			buff.append("\"layouts\": [");
			Iterator it=decorationFactory.getLayouts(rc).iterator();
			for(int i=0; it.hasNext(); i++)
			{
				LayoutInfo layout = (LayoutInfo)it.next();
				if( i > 0 ) buff.append(", ");
				buff.append("{\"name\" : \"").append(layout.getDisplayName()).append("\", ");
				buff.append("\"value\" : \"").append(layout.getName()).append("\"} ");
			}
			buff.append("],");
			
			buff.append("\"pages\": [");
			it=decorationFactory.getPageDecorations(rc).iterator();
			for(int i=0; it.hasNext(); i++)
			{
				String pd = (String)it.next();
				if( i > 0 ) buff.append(", ");
				buff.append("{\"name\" : \"").append(pd).append("\", ");
				buff.append("\"value\" : \"").append(pd).append("\"} ");
			}
			buff.append("],");
			
			buff.append("\"mypages\": [");
			it=decorationFactory.getMyPageDecorations(rc).iterator();
			for(int i=0; it.hasNext(); i++)
			{
				String pd = (String)it.next();
				if( i > 0 ) buff.append(", ");
				buff.append("{\"name\" : \"").append(pd).append("\", ");
				buff.append("\"value\" : \"").append(pd).append("\"} ");
			}
			buff.append("]");
			buff.append("}");
			//System.out.println("############ buff=" + buff.toString());
		}
		catch(NullPointerException e) {
			log.error( e.getMessage(), e);;
		}
		catch(Exception e) {
			log.error( e.getMessage(), e);;
		}
		
		return buff.toString();
	}
	
	private String includeLinksNavigation(List menus, String langKnd)
	{
		StringBuffer buff = new StringBuffer();
		String __delimiter = "&nbsp;&gt;";

		int menuSize = menus.size();
		Iterator it = menus.iterator();
		for(int cnt=1; it.hasNext(); cnt++) {
			EnviewMenu element = (EnviewMenu)it.next();
			String linkTitle = element.getTitle();
			String linkName = element.getShortTitle();
			String linkUrl = element.getFullUrl();
			if(cnt < menuSize) {
				buff.append("<span><a href=\"").append(linkUrl).append("\" class=\"LinkPage\" title=\"").append(linkTitle).append("\">").append(linkName).append("</a>").append(__delimiter).append("</span>");
			}
			else {
				buff.append("<span title=\"").append(linkTitle).append("\">").append(linkName).append("&nbsp;</span>");
			}
		}
		
		return buff.toString();
	}
	
	private String pageActionBar(LayoutDecoration layoutDecoration, String contextPath)
	{
		StringBuffer buff = new StringBuffer();
		buff.append("<span id=\"portal-page-actions\" >");
		Iterator it = layoutDecoration.getActions().iterator();
		boolean isEditMode = false;
		StringBuffer buffAction = new StringBuffer();
		for(int cnt=0; it.hasNext(); cnt++) {
			DecoratorAction action = (DecoratorAction)it.next();
			//System.out.println("########################################### pageActionBar action=" + action.getActionName());
			if(action.getActionName().equals("view")) {
				isEditMode = true;
			}
			buffAction.append("<a href=\"").append(action.getAction()).append("\" title=\"").append(action.getName()).append("\" class=\"action pageAction\" >");
			//buffAction.append("<img src=\"").append(contextPath).append("/").append(action.getLink()).append("\" align=\"absmiddle\" alt=\"").append(action.getAlt()).append("\" border=\"0\" style=\"cursor:hand\" /></a>");
			buffAction.append("<img src=\"").append(contextPath).append("/").append(action.getLink()).append("\" align=\"absmiddle\" alt=\"").append(action.getAlt()).append("\" border=\"0\" style=\"cursor:hand\" /></a>");
		}
		
		if( isEditMode == true ) {
			buff.append("<img src=\"").append(contextPath).append("/decorations/layout/images/minimize.gif\" hspace=\"2\" align=\"absmiddle\" border=\"0\" style=\"cursor:hand\" alt=\"Minimize EditMode\" onclick=\"javascript:portalPage.toggleDragMode()\">");
			buff.append("<img src=\"").append(contextPath).append("/decorations/layout/images/save.jpg\" hspace=\"2\" align=\"absmiddle\" border=\"0\" style=\"cursor:hand\" alt=\"Save Page\" onclick=\"javascript:portalPage.checkModified()\">");
		}
		
		buff.append( buffAction.toString() );
		buff.append("</span>");
		return buff.toString();
	}
	
	private String portletActionBar(PortletDefinition portlet, Decoration decoration, RequestContext context)
	{
		StringBuffer buff = new StringBuffer();
		String contextPath = context.getRequest().getContextPath();
    	String themeName = (String)context.getAttribute("themeName");
		
		if( "/".equals(contextPath) ) {
			contextPath = "";
		}
		
		buff.append("<span id=\"portal-page-actions\" class=\"portlet-title-action\">");
		Iterator it = decoration.getActions().iterator();
		for(int cnt=0; it.hasNext(); cnt++) {
			DecoratorAction action = (DecoratorAction)it.next();
			String actionUrl = action.getAction();
			System.out.println( portlet.getPortletName() + " - " + action.getActionName() + " - " + actionUrl);
			if( Enview.getConfiguration().getBoolean("portal.portletmode.isLinkPopup", true) ) {
				String appContextPath = portlet.getApplication().getContextPath();
				
				if( "edit".equals(action.getActionName()) == true ) {
					if( portlet.getInitParam("EditPage") != null ) {
						actionUrl = appContextPath + portlet.getInitParam("EditPage").getParamValue();
					}
					else actionUrl = "#";
				}
				else if( "help".equals(action.getActionName()) == true ) {
					if( portlet.getInitParam("HelpPage") != null ) {
						actionUrl = appContextPath + portlet.getInitParam("HelpPage").getParamValue();
					}
					else actionUrl = "#";
				}
				
				buff.append("<a href=\"").append(actionUrl).append("\" target=\"_EnviewExtraWindow\" title=\"").append(action.getName()).append("\" class=\"action portlet-action\" >");
			}
			else {
				buff.append("<a href=\"").append(action.getAction()).append("\" title=\"").append(action.getName()).append("\" class=\"action portlet-action\" >");
			}
			if( action.getTarget() != null ) {
				buff.append(" target=\"").append(action.getTarget()).append("\" ");
			}
			//buff.append("<img src=\"").append(contextPath).append("/").append(action.getLink()).append("\" alt=\"").append(action.getAlt()).append("\" border=\"0\" /></a>");
			buff.append("<img src=\"").append(contextPath).append("/decorations/layout/").append(themeName).append("/images/portlet/").append(action.getActionName()).append(".gif\" alt=\"").append(action.getAlt()).append("\" border=\"0\" /></a>");
		}
		buff.append("</span>");
		
		return buff.toString();
	}
	
	private String getEditLink(LayoutDecoration layoutDecoration, String contextPath)
	{
		StringBuffer buff = new StringBuffer();
		Iterator it = layoutDecoration.getActions().iterator();
		for(int cnt=0; it.hasNext(); cnt++) {
			DecoratorAction action = (DecoratorAction)it.next();
			if(action.getActionName().equals("edit") || action.getActionName().equals("view")){
				buff.append(action.getAction());
				
			}				
		}	
		return buff.toString();
	}%>

<%
	int DEFAULT_SCOPE = PageContext.PAGE_SCOPE;
	int REQ_SCOPE = PageContext.REQUEST_SCOPE;
	EnviewPowerTool _jpt = null;
	Page currentPage = null;
	Theme _theme = null;
	DecorationFactory _decorationFactory = null;
	LayoutDecoration _layoutDecoration = null;
	RequestContext _rc = null;
	PortalSiteRequestContext site = null;
	Fragment rootFragment = null;
	Map userInfo = null;
	String userId = null;
	String principalId = null;
	String groupPrincipalId = null;
	String groupId = null;
	List roles = null;
	String langKnd = "ko";
	String domainId = "1";
	String domainNm = "1";
	Locale locale = null;
	MultiResourceBundle msgs = null;
	CodeBundle codes = null;
	
	String _cPath = null;
	String themePath = null;
	String themeName = null;
	String admContextPath = null;
	Locale _preferedLocale = null;
	String _PageTitle = null;
	Boolean editMode = null;
	boolean editing = false;
	boolean hasAdminRole = false;
	String userDir = "";
	String groupDir = "";
	String fragmentRepository = null;
	String decorations = "";
	List decorationList = null;
	DecoratorAction action = null;
	String pageInfo = null;
	String rootSite = null;
	String loginUrl = null;
	boolean isMyPage = false;
	boolean isMobile = false;
	boolean isGroupPage = false;
	boolean isEditPage = false;
	String pageActionBar = "";
	String initEnviewScript = "";
	
	UserInfo user = EVSubject.getUserInfo();
	request.setAttribute("user", user);
	
	DomainInfo domainInfo = Enview.getUserDomain();
	try {
		_jpt = (EnviewPowerTool) request.getAttribute("jpt");
		_theme = (Theme) request.getAttribute("com.saltware.enview.theme");

		_decorationFactory = (DecorationFactory)request.getAttribute("decorationFactory");
		if( _theme != null ) {
			_layoutDecoration = _theme.getPageLayoutDecoration();
			pageContext.setAttribute("layoutDecoration", _layoutDecoration, DEFAULT_SCOPE);
			
			Iterator actionIt = _layoutDecoration.getActions().iterator();
			for(int cnt=0; actionIt.hasNext(); cnt++) {
				action = (DecoratorAction)actionIt.next();
				if( "edit".equals(action) || "view".equals(action) ) {
					break;
				}
			}
		}
		else {
			out.println("This content is now unableable. Please refresh now.");
			return;
		}

		_rc = (RequestContext) request.getAttribute(PortalReservedParameters.REQUEST_CONTEXT_ATTRIBUTE);
		_cPath = (String) request.getAttribute("cPath");
		currentPage = (Page)request.getAttribute("enview.portal.requestPage");
		request.setAttribute("currentPage", currentPage);
		themePath = (String)request.getAttribute("themePath"); 
		themeName = (String)request.getAttribute("themeName");
		userId = (String)_rc.getSessionAttribute("_enpass_id_");
		admContextPath = Enview.getConfiguration().getString("portal.admContextPath");

		pageContext.setAttribute("rc", _rc, DEFAULT_SCOPE);
		site = (PortalSiteRequestContext)request.getAttribute("com.saltware.enview.portalsite.PortalSiteRequestContext");
		request.setAttribute("site", site);
		rootFragment = currentPage.getRootFragment();

		UserInfo userInfomation = _rc.getUserInfomation();
		
		
		
		if( userInfomation != null ) {
			userInfo = userInfomation.getUserInfoMap();
			rootSite = userInfomation.getString("siteName", "/");
			principalId = userInfomation.getString("principalId", "0");
			groupPrincipalId = userInfomation.getString("groupPrincipalId", "0");
			groupId = userInfomation.getGroupId();
			roles = userInfomation.getRoleList();

			hasAdminRole = userInfomation.getHasAdminRole();
			request.setAttribute("hasAdminRole", hasAdminRole);
			
//			userDir = _cPath + "/portal/user/" + userId + ".page?isMyPage=true";
			userDir = _cPath + "/user/myPage.face";
			groupDir = _cPath + "/portal/group/" + groupId + ".page";
			request.setAttribute("userDir", userDir);
			request.setAttribute("groupDir", groupDir);
			
			
		
		}
		
		isMobile = EnviewSSOManager.isMobile(request);
		langKnd = EnviewSSOManager.getLangKnd(request);
		locale = new Locale(langKnd);
		_preferedLocale = new Locale( langKnd );
		pageContext.setAttribute("preferedLocale", _preferedLocale, REQ_SCOPE);
		
		// domain		
		domainId = Enview.getUserDomain().getDomainId();
		domainNm = Enview.getUserDomain().getDomainNm();
		request.setAttribute("domainId", domainId);
		request.setAttribute("domainNm", domainNm);
		
		
		msgs = EnviewMultiResourceManager.getInstance().getBundle(_rc.getRequest());
		codes = EnviewCodeManager.getInstance().getBundle(_rc.getRequest());

		_PageTitle = currentPage.getTitle(_preferedLocale);
		pageContext.setAttribute("PageTitle", _PageTitle, DEFAULT_SCOPE);
		editMode = (Boolean)request.getAttribute("editing");
		editing = false;
		if( editMode != null && editMode.booleanValue() == true ) {  
			editing = true;
		}
		fragmentRepository = includeFragmentNavigation(rootFragment, _rc, _preferedLocale, _layoutDecoration, admContextPath);
		pageInfo = includePageInfo(currentPage, _rc, _preferedLocale, _layoutDecoration, admContextPath);
				
		decorations = includeDecorations(_rc, _decorationFactory);
		if( decorations == null ) decorations = "";
		
		decorationList = getDecorations(_rc, _decorationFactory);
		request.setAttribute("decorationList", decorationList);
		
		isMyPage = (request.getRequestURI().indexOf("/user/") > 0) ? true : false;
		isGroupPage = (request.getRequestURI().indexOf("/group/") > 0) ? true : false;
		isEditPage = "/contentonly".equals( request.getServletPath());

		request.setAttribute("isMyPage", currentPage.getPath().contains("/user/"));
		request.setAttribute("isEditPage", isEditPage);
		
		List langKndList = (List)codes.getCodes("PT", "105", 1, true);
		request.setAttribute("langKndList", langKndList);
		request.setAttribute("langKnd", langKnd);
		
		loginUrl = (String)request.getAttribute("loginUrl");
		
		Boolean hasFragment = (Boolean)request.getAttribute("hasFragment");
		if( hasFragment == true ) {
			pageActionBar = pageActionBar(_layoutDecoration, _cPath);
		}
		StringBuffer sb = new StringBuffer();
		sb.append( "var pageInfo = eval(").append( pageInfo ).append(");\n");
		sb.append( "\t\t\t\t").append("var decorations = eval(").append( decorations ).append(");\n");
		sb.append( "\t\t\t\t").append( "portalPageInitialize(").append("\"").append( site.getVersion()).append("\", ").append( editing).append(", \"").append( userId).append("\", pageInfo, decorations, \"")
				.append( langKnd).append("\", \"").append( domainId).append("\");\n");
		sb.append( "\t\t\t\t").append( "tabInitialize();\n");
		if( isMyPage) {
			sb.append( "\t\t\t\t").append( "noticeInitialize(\"myPage\");\n");
		} else {
			sb.append( "\t\t\t\t").append( "noticeInitialize(\"").append( currentPage.getId()).append("\");\n");
		}
		initEnviewScript = sb.toString();
		request.setAttribute("initEnviewScript", initEnviewScript);
	}
	catch(NullPointerException e) {
		Log log = LogFactory.getLog(getClass());
		log.error( e.getMessage(), e);; 
	}
	catch(Exception e) {
		Log log = LogFactory.getLog(getClass());
		log.error( e.getMessage(), e);; 
	}
	
	//페이지 컴포넌트를 위한 리스트
	List componentAreas = (List)codes.getCodes("PT", "102", 1, true);
	
	/* password change */
	String pwdChgReq = "";
    if("true".equals(request.getParameter("pwdChgReq"))){
        pwdChgReq = "true";
        request.setAttribute("pwdChgReq",pwdChgReq);
    }
    /* end password change */
    
	//공용메뉴를 위한 리스트 추출 및 세션에 삽입
//	List publicMenuList = site.getTopMenu( request, "/public/menu" );
//	request.setAttribute("publicMenuList", publicMenuList);
	//System.out.println("############################# init layout");

	// ******************** admin2016 추가 START ******************** //
	request.setAttribute("currentPageTitle",currentPage.getTitle( _preferedLocale));
	request.setAttribute("currentPagePath",currentPage.getPath());
	request.setAttribute("parentPageTitle",currentPage.getParent().getTitle( _preferedLocale));
	request.setAttribute("parentPagePath",currentPage.getParent().getPath());
	// ******************** admin2016 추가 END ******************** //
%>
