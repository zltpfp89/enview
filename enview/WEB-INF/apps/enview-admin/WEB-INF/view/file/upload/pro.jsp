<!-- pro���� -->

<%-- <%@page import="com.saltware.enview.Enview"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.*,java.util.*" %>
<html>
	<head>
		<script type="text/javascript">
			function complete(){
				alert("������ �Ϸ� �Ǿ����ϴ�");
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
/* 		out.println(objarr[i][0]);//���ε� ���ϰ�ü
		out.println(objarr[i][1]);//�������ϸ�
		out.println(objarr[i][2]);//��������ϸ� */
		File file = new File(savepath + objarr[i][1]);
		/* file = policy.rename(file); *///��������� ������ �̹� ���� �̸��� ������ �ڵ����� ���� ���ڸ� ����.
		if(request.getParameter("uploadOption").equals("overwrite")){
			//����� - �ƹ��͵� ����.
			copyFileAbs((File)objarr[i][0],file);//�������� ���������� ������ ������.
		}
		else { 
			if(request.getParameter("uploadOption").equals("pass")){
				if(!file.exists()){
					copyFileAbs((File)objarr[i][0],file);//�������� ���������� ������ ������.
				}
		 	}else if(request.getParameter("uploadOption").equals("changeName")){
		 		file = policy.rename(file); //���� �̸� ���� - ���ϸ� �ڿ�  ���ڸ� �ϳ��� ����
		 		copyFileAbs((File)objarr[i][0],file);//�������� ���������� ������ ������.
			}
		}
		((File)objarr[i][0]).delete();//�ӽ��������� ���ε� ������ ������.
	}	
	application.removeAttribute(session.getId());
}
//�ٸ� ��������
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