
<!--Left menu  start -->
<div>
<ul id="submenu">
<%				
if( siteLeftMenu.getElements() != null ) {
	Iterator it = siteLeftMenu.getElements().iterator();
	for(int cnt=0; it.hasNext(); cnt++, tabordercnt++) {
		EnviewMenu element = (EnviewMenu)it.next();
		if( element.isHidden() == false ) {
			String linkDescription = element.getTitle(langKnd);
			String linkTitle = element.getShortTitle(langKnd);
			String linkUrl = element.getFullUrl();
			String linkTarget = element.getTarget();
%>
	<li id="submenu_<%=element.getId()%>"><a href="<%=linkUrl%>" target="<%=linkTarget%>"><%=linkTitle%></a>
<%		
			if( element.getElements() != null ) { %>
		<ul>
<%				int subcnt = 1;
				int totalCnt = element.getElements().size();
				Iterator it2 = element.getElements().iterator();
				for(; it2.hasNext(); tabordercnt++, subcnt++) {
					EnviewMenu subelement = (EnviewMenu)it2.next();
					if( subelement.isHidden() == false ) {
						String subLinkDescription = subelement.getTitle(langKnd);
						String subLinkTitle = subelement.getShortTitle(langKnd);
						String subLinkUrl = subelement.getFullUrl();
						String subLinkTarget = subelement.getTarget();
%>
			<li id="submenu_<%=subelement.getId()%>"><a href="<%=subLinkUrl%>" target="<%=subLinkTarget%>"><%=subLinkTitle%></a></li>
<%					}
				} %>
		</ul>
<%			} %>
	</li>
<%		}
	}
} %>
</ul>
</div>
<!--Left menu  end -->

