<%--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@ page session="false" %>                            
<%@ page import="javax.portlet.*"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.ResourceBundle"%>
<%@ taglib uri='/WEB-INF/tld/portlet.tld' prefix='portlet'%>
<portlet:defineObjects/>                            

<%
ResourceBundle myText = portletConfig.getResourceBundle(renderRequest.getLocale());         
%>
<br><B><%=myText.getString("available_bookmarks")%></B><br><br>       
<%
  PortletPreferences prefs = renderRequest.getPreferences();
  Enumeration e = prefs.getNames();                        
  if (!e.hasMoreElements()) // no bookmarks
    {
%>
      <%=myText.getString("no_bookmarks")%><BR>
<%
    }
  while (e.hasMoreElements())
    {
      String name = (String)e.nextElement();
      String value = prefs.getValue
                     (name,"<"+
                     myText.getString("undefined")+">");
%>
	<A target="_blank" HREF="<%=value%>" ><%=name%></A><BR> 
<%
    }
%>
<br>