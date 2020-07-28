<!-- pro원본 -->

<%-- <%@page import="com.saltware.enview.Enview"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.*,java.util.*" %>
<html>
	<head>
		<script type="text/javascript">
			function complete(){
				alert("전송이 완료 되었습니다");
				history.back();
			}
		</script>
	</head>
	<body onload="complete()">
<%
DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
ArrayList alist = (ArrayList)application.getAttribute(session.getId());

String filegood = request.getParameter("directoryname"); 


String RealPath = Enview.getRealPath("");
RealPath = RealPath.replace("\\","/");

String savepath = RealPath + filegood;


/* String path = request.getContextPath();
  String savedir = path + filegood; */

makeDir(savepath);
if(alist != null){
	Object[][] objarr = (Object[][])alist.toArray(new Object[alist.size()][3]);
	for(int i=0;objarr!=null&&i<objarr.length;i++){
/* 		out.println(objarr[i][0]);//업로드 파일객체
		out.println(objarr[i][1]);//원래파일명
		out.println(objarr[i][2]);//저장된파일명 */
		File file = new File(savepath + objarr[i][1]);
		/* file = policy.rename(file); *///최종저장될 폴더에 이미 같은 이름이 있으면 자동으로 끝에 숫자를 붙임.
		if(request.getParameter("uploadOption").equals("overwrite")){
			//덮어쓰기 - 아무것도 안함.
			copyFileAbs((File)objarr[i][0],file);//최종으로 저장폴더에 파일을 복사함.
		}
		else { 
			if(request.getParameter("uploadOption").equals("pass")){
				if(!file.exists()){
					copyFileAbs((File)objarr[i][0],file);//최종으로 저장폴더에 파일을 복사함.
				}
		 	}else if(request.getParameter("uploadOption").equals("changeName")){
		 		file = policy.rename(file); //파일 이름 변경 - 파일명 뒤에  숫자를 하나씩 증가
		 		copyFileAbs((File)objarr[i][0],file);//최종으로 저장폴더에 파일을 복사함.
			}
		}
		((File)objarr[i][0]).delete();//임시폴더에서 업로드 파일을 삭제함.
	}	
	application.removeAttribute(session.getId());
}
//다른 폼변수들
%>

<%!
public void makeDir(String savepath) throws Exception{
	java.io.File dir=new java.io.File(savepath);
	if(!dir.exists()){	dir.mkdirs();	}
}
public static String ko(String s){
	if(s==null)return "";
	try{
		s = new String(s.getBytes("8859_1"),"euc-kr");
	}catch(Exception e){}
	return s;
}
public void copyFileAbs(java.io.File src, java.io.File dst) throws java.io.IOException {    	
	java.io.InputStream in = new java.io.FileInputStream(src);
	java.io.OutputStream out = new java.io.FileOutputStream(dst);
	
	System.out.println("src=" + src);
	
	byte[] buf = new byte[1024];
	int len;
	while ((len = in.read(buf)) > 0) {
		out.write(buf, 0, len);
	}
	in.close();
	out.close();
}
%>
	</body>
</html>
 --%>