<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="java.util.*,addrbook.*"%>
<!DOCTYPE HTML><html><head>
<link rel="stylesheet" href="addrbook.css" type="text/css" media="screen" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주소록:로그인 화면</title></head>
<jsp:useBean id="ab" class="addrbook.AddrBean"/> 
<jsp:useBean id="addrbook" class="addrbook.AddrBook"/>
<jsp:setProperty name="addrbook" property="*"/> 
<jsp:useBean id="addrbookmem" class="addrbook.AddrBookMem"/>
<jsp:setProperty name="addrbookmem" property="*"/> 
<jsp:useBean id="datas" scope="request" class="java.util.ArrayList" />
<jsp:useBean id="memDatas" scope="request" class="java.util.ArrayList" />
<body><div align="center"> 
<H2>주소록:로그인 화면</H2>
<HR>

<a href="addrbook_signin.jsp">회원 가입</a><P>


<form name=form3 method=post action=addrbook_control.jsp>
<input type=hidden name="action" value="login">
I D : 
<input type=text size=15 name=loginID>
<br><br>
PW :
<input type=password size=20 name=loginPW>

<br><br><input type=submit value="로그인">

</form>
<br>
<form name=form4 method=post action=addrbook_findLogInfo.jsp>
<input type=hidden name="action" value="lookforLogInfo">
<input type=submit value="ID/PW찾기">
</form>
</div></body></html>