<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 : 글쓰기</title>
<link rel="stylesheet" href="addrbook.css" type="text/css" media="screen" />
</head>
<body>
<div align="center">
<H2>게시판 : 글쓰기</H2>
<HR>
[<a href=bb_control.jsp?bbaction=bblist&pageNumber=0>게시판 목록으로</a>] <P>
<form name=form1 method=post action=bb_control.jsp>
<input type=hidden name="bbaction" value="bbinsert">
<table border="1">
  <tr>
    <th>제 목</th>	
    <td><input type="text" name="bb_title" style="width: 350px;" maxlength="50"></td>
  </tr>
  <tr>
    <th>작성자</th>
    <td><input type="text" name="bb_writer" style="width: 350px;" maxlength="50"></td>
  </tr>
  <tr>
    <th>비밀번호</th>
    <td><input type="password" name="bb_pw" style="width: 350px;" maxlength="20"></td>
  </tr>
  <tr>
    <th>글 내용</th>
    <td><input type="text" placeholder="이곳에 글을 작성하세요." maxlength="2048" style="width: 350px; height: 350px;" name="bb_Content"></td>
  </tr>  
  <tr>
    <td colspan=2 align=center><input type=submit value="글등록"><input type=reset value="취소"></td>
</tr>
</table>
</form>

</div>
</body>
</html>