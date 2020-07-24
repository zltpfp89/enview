<%@page import="com.saltware.enview.domain.impl.DomainInfoImpl"%>
<%@page import="com.saltware.enview.domain.DomainInfo"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.Serializable"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="com.saltware.enhancer.util.Base64Coder"%>
<%@page import="java.io.IOException"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.saltware.enview.login.LoginConstants" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.security.UserManager" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%!

/** Read the object from Base64 string. */
private Object deserialize( String s ) throws IOException , ClassNotFoundException {
     byte [] data = Base64Coder.decode( s );
     ObjectInputStream ois = new ObjectInputStream( new ByteArrayInputStream(  data ) );
     Object o  = ois.readObject();
     ois.close();
     return o;
}

 /** Write the object to a Base64 string. */
 private String serialize( Serializable o ) throws IOException {
     ByteArrayOutputStream baos = new ByteArrayOutputStream();
     ObjectOutputStream oos = new ObjectOutputStream( baos );
     oos.writeObject( o );
     oos.close();
     return new String( Base64Coder.encode( baos.toByteArray() ) );
 }

%>
<pre>
<%
	DomainInfo domainInfo = EnviewSSOManager.getDomainInfo(request);
	out.println("domainInfo=[" + domainInfo + "]");
	String s = serialize( (DomainInfoImpl)domainInfo);
	out.println("seiralized=[" + s + "]");
	DomainInfo domainInfo2 = (DomainInfo)deserialize(s) ;
	out.println("deserialized domainInfo=[" + domainInfo2 + "]");
%>
</pre>