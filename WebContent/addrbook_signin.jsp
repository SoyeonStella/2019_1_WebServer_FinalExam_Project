<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주소록:가입화면</title>
<link rel="stylesheet" href="addrbook.css" type="text/css" media="screen" />
</head>
<body>
<div align="center">
<H2>주소록:가입화면 </H2>
<HR>
[<a href=addrbook_login.jsp>로그인 화면으로</a>] <P>
<form name=form1 method=post action=addrbook_control.jsp>
<input type=hidden name="action" value="signin">
<table border="1">
  <tr>
    <th>ID</th>	
    <td><input type="text" name="ab_logid" maxlength="15"></td>
  </tr>
  <tr>
    <th>비밀번호</th>	
    <td><input type="password" name="ab_logpw" maxlength="20"></td>
  </tr>
  <tr>
    <th>email</th>
    <td><input type="email" name="ab_logemail" maxlength="50"></td>
  </tr>
  <tr>
    <td colspan=2 align=center><input type=submit value="저장"><input type=reset value="취소"></td>
</tr>
</table>
</form>

</div>
</body>
</html>