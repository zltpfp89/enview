<!-- up원본 -->
<%-- <%@page import="com.saltware.enview.Enview"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>


<%
try{
	String browser_id = request.getParameter("browser_id");
	
	String RealPath = Enview.getRealPath("");
	RealPath = RealPath.replace("\\","/");

	if(browser_id==null || browser_id.trim().length()==0)
	{
		return;
	}
		
	makeDir(RealPath);
	MultipartRequest multi=new MultipartRequest(request, RealPath,1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());


	File file = multi.getFile("Filedata");
	if(file==null)return;
	String originFileName = multi.getOriginalFileName("Filedata");
	long filesize = file.length();
	ArrayList alist = (ArrayList)application.getAttribute(browser_id);
	if(alist==null){
		alist = new ArrayList();
	}
	application.setAttribute(browser_id,alist);

	Object[] objarr = new Object[3];
	objarr[0] = file;
	objarr[1] = originFileName;
	objarr[2] = new Long(filesize);

	alist.add(objarr);
}catch(Exception e){
	e.printStackTrace();
}
%>

<%!
public void makeDir(String RealPath) throws Exception{
	java.io.File dir=new java.io.File(RealPath);
	if(!dir.exists()){	dir.mkdirs();	}
}
%> --%>