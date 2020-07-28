<%@ include file="../initLayoutDecorators.jsp" %>
<%	if( isGroupPage == true ) { %>						
				</div>
			<c:forEach items="${afterGroupPage}" var="groupPage">
				<div id="GroupTabPage_<c:out value="${groupPage.id}"/>" style="width:100%;"></div>
			</c:forEach>
<%	} %>	
		</div>
	</div>
<br style="line-height:10px;" />
<table width="910" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="10"></td>
	<td align="left" background="">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="200"></td>
		</tr>
		</table>
	</td>
	<td width="10"></td>
</tr>
</table>
</body>
</html>
<script>
		initEnview();
</script>