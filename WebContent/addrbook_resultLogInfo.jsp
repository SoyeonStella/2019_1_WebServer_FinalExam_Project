<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="java.util.*,addrbook.*"%>
<!DOCTYPE HTML><html><head>
<link rel="stylesheet" href="addrbook.css" type="text/css" media="screen" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주소록:아이디/비밀번호 찾기 결과 화면</title></head>
<jsp:useBean id="resultLogInfos" scope="request" class="java.util.ArrayList" />
<body><div align="center"> 
<H2>주소록:아이디/비밀번호 찾기 결과 화면</H2>
<HR>
<form>
<a href="addrbook_login.jsp">로그인 하기</a><P>

<table border="1">
  <tr><th>번호</th><th>이 름</th><th>아이디</th><th>비밀번호</th></tr>
	<%
		for(AddrBookMem  ab : (ArrayList<AddrBookMem>)resultLogInfos) {
	%>
  <tr><td><%=ab.getAb_memid() %></td>
				<td><%=ab.getAb_logid() %></td>
				<td><%=ab.getAb_logpw() %></td>
				<td><%=ab.getAb_logemail() %></td>
			  </tr>
			 <%
				}
			 %>
</table>
</form>
</div></body></html>