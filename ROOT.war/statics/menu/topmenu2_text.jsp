<!--Top menu  start -->
<div style="width:100%;">
<ul id="topmenu" style="width:100%;">
<%				
if( siteTopMenu.getElements() != null ) {
	Iterator it = siteTopMenu.getElements().iterator();
	for(int cnt=0; it.hasNext(); cnt++, tabordercnt++) {
		EnviewMenu element = (EnviewMenu)it.next();
		//System.out.println("############## name=" + element.getName());
		if( element.isHidden() == false ) {
			String linkDescription = element.getTitle(langKnd);
			String linkTitle = element.getShortTitle(langKnd);
			String linkUrl = element.getFullUrl();
			String linkTarget = element.getTarget();
			String icon = themePath + "/images/top_1/" + element.getMenuIconName();
%>
	<li id="menu_<%=element.getId()%>" class="menu<%=cnt%>"><a href="<%=linkUrl%>"><%=linkTitle%></a>
<%		
			if( element.getElements() != null ) { %>
		<ul >
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
						String subicon = themePath + "/images/top_2/" + subelement.getMenuIconName(); %>
			<li id="menu_<%=subelement.getId()%>"><a href="<%=subLinkUrl%>"><%=subLinkTitle%></a></li>
<%					}
				} %>
		</ul>
<%			}
		} %>
	</li>
<%	}
} %>
</ul>
</div>
<!--Top menu  end -->