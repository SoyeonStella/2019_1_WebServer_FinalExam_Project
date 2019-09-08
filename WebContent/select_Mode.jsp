<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<br><br><br><br>
<center>
<table border="0" cellpadding=5 cellspacing=0 width=300>
<td><center>
<a href="addrbook_list.jsp"><h2>주소록</h2></a><P>
</center></td>
<td><center>
<a href="bb_list.jsp"><h2>게시판</h2></a><P>
</center></td>
</table></center>
<form name=form2 method=post action=addrbook_login.jsp>
<input type=hidden name="action" value="login">
<center>
<br><br><br><br><br>
<input type=submit value="로그아웃">
</center>
</form>
</body>
</html>