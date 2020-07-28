<%@page import="com.saltware.enview.util.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="com.saltware.enview.exception.BaseException"%>
<%@page import="com.saltware.enface.user.service.SiteUserManager"%>
<%@page import="com.saltware.enview.security.UserManager"%>
<%@page import="java.util.Map"%>
<%@page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@page import="com.saltware.enview.Enview"%>
<%@page import="org.apache.commons.net.ftp.FTP" %>
<%@page import="org.apache.commons.net.ftp.FTPClient" %>
<%@page import="org.apache.commons.net.ftp.FTPReply" %>


<%@page import="java.io.BufferedWriter" %>
<%@page import="java.io.File" %>
<%@page import="java.io.FileInputStream" %>
<%@page import="java.io.FileWriter" %>
<%@page import="java.io.IOException" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>

<%



FTPClient ftpClient = null;
FileInputStream fis = null;
String host = "10.100.10.45";
String user = "isis02";
String pass = "adm456";
try {

    ftpClient = new FTPClient();
    ftpClient.setControlEncoding("euc-kr");  // 한글파일명 때문에 디폴트 인코딩을 euc-kr로 합니다
    ftpClient.connect("10.100.10.45");  // 천리안 FTP에 접속합니다    
    boolean loginSuccess = ftpClient.login("isis02", "adm456"); // 로그인 유저명과 비밀번호를 입력 합니다
    ftpClient.enterLocalActiveMode();
    ftpClient.changeWorkingDirectory("");  //리모트 파일패스
    ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
    out.println(" loginSuccess === "+loginSuccess);
    
    try{
        fis = new FileInputStream("");//업로드할 파일
        
        boolean isSuccess = ftpClient.storeFile("파일이름", fis);
        out.println(" isSuccess === "+isSuccess);
        if( isSuccess ){
            out.println("파일 업로드를 성공.");
        }   else{
            out.println("파일 업로드를 할 수 없습니다.");
        }
    } catch(NullPointerException ex){
        System.out.println("IO 00 Exception : " + ex.getMessage());
    } catch(Exception ex){
        System.out.println("IO 00 Exception : " + ex.getMessage());
   }finally{
          if (fis != null){
              try{
                  fis.close(); // Stream 닫기
                   
              }
              catch (NullPointerException ex){
                  System.out.println("IO1 Exception : " + ex.getMessage());
              }
              catch(Exception ex){
                  System.out.println("IO1 Exception : " + ex.getMessage());
              }
          }
    }
	ftpClient.logout(); // FTP Log Out
}catch(NullPointerException e){
    System.out.println("IO2:"+e.getMessage());
}catch(Exception e){
    System.out.println("IO2:"+e.getMessage());
}finally{
      if (ftpClient != null && ftpClient.isConnected()){
          try{
              ftpClient.disconnect(); // 접속 끊기
          }
          catch (NullPointerException e){
              System.out.println("IO3 Exception : " + e.getMessage());
          }
          catch (Exception e){
              System.out.println("IO3 Exception : " + e.getMessage());
          }
      }
 }





%>