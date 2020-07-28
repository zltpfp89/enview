<%@ include file="../../decorations/layout/initLayoutDecorators.jsp" %>

<%
	EnviewMenu siteMenu = site.getTopMenu("/admin");
	EnviewMenu subsiteMenu = site.getSubMenu("/admin", 2);
	String breadcrumbs = includeLinksNavigation( site.getNavigation(), langKnd );
	String pageActionBar = "&nbsp;";
	if( _layoutDecoration != null ) {
		pageActionBar = pageActionBar(_layoutDecoration, _cPath);
	}
	
	String currentPath = site.getPage().getPath();
	int tabordercnt = 0;   
	
	System.out.println("#### editing=" + editing + ", currentPath=" + currentPath);
%>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
<!-- top menu start-->  
		<td height="35" background="<%=themePath%>/images/menu_bg.gif" >
		  <table width="90%" border="0" cellspacing="0" cellpadding="0" height="20">
			<tr>
				<td style="FONT-FAMILY: Gulim; FONT-SIZE: 9pt; FONT-COLOR: #999999" width="10"><b></b></td>
				<td style="FONT-FAMILY: Gulim; FONT-SIZE: 9pt; FONT-COLOR: #999999" valign="bottom">
					<b><font color="#FFFFFF">
<%		
if( siteMenu.getElements() != null ) {
	Iterator it = siteMenu.getElements().iterator();
	for(int cnt=0; it.hasNext(); cnt++, tabordercnt++) {
		EnviewMenu element = (EnviewMenu)it.next();
		String linkDescription = element.getTitle(langKnd);
		String linkTitle = element.getShortTitle(langKnd);
		String linkUrl = element.getFullUrl();
		String linkTarget = element.getTarget();
		if(cnt > 0) {
%>
						&nbsp;&nbsp;<a href="<%=linkUrl%>" target="<%=linkTarget%>" id="products" tabindex="<%=tabordercnt%>" title="<%=linkDescription%>"><span><font color="#FFFFFF"><%=linkTitle%></font></span></a>
<%
						
		} else {
%>
						<a href="<%=linkUrl%>" target="<%=linkTarget%>" id="products" tabindex="<%=tabordercnt%>" title="<%=linkDescription%>"><span><font color="#FFFFFF"><%=linkTitle%></font></span></a>
<%
		}
	}
}		
%>
					</font></b>
				</td>
			</tr>
		  </table>
		</td>
<!-- top menu end-->
    </tr>
<!-- location start -->  
	<tr>
		<td height="29" background="<%=themePath%>/images/location_bg.gif" valign="bottom"> 
	      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="25">
	        <tr> 
	          <td  width="10" >&nbsp;</td>
	          <td style="FONT-FAMILY: Dotum; FONT-SIZE: 8pt; FONT-COLOR: #999999">
				<img src="<%=themePath%>/images/icon.gif" width="11" height="13" align="absmiddle"> <%= breadcrumbs %>
			  </td>
<% if( enpassSessionUserId != null ) { %>
			 <td align="right" style="padding:0px 5px 0px 0px;"><%=pageActionBar%></td>
<% } %>
	        </tr>
	      </table>
	    </td>
	</tr>
</table>