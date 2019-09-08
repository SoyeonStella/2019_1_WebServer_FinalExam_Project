<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="addrbook.*"%>
<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" href="addrbook.css" type="text/css" media="screen" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글:수정화면</title>
</head>

<jsp:useBean id="bb" scope="request" class="addrbook.BlackBoard" />

<body>
<div align="center">
<H2>게시글:수정화면 </H2>
<HR>
[<a href=bb_control.jsp?bbaction=bblist>주소록 목록으로</a>] <p>
<form name=form1 method=post action=bb_control.jsp>
<input type=hidden name="bb_id" value="<%=bb.getBb_id()%>">
<input type=hidden name="bbaction" value="bbupdate">

<table border="1">
  <tr>
    <th>글 제목</th>
    <td><input type="text" name="bb_title" value="<%=bb.getBb_title() %>"></td>
  </tr>
  <tr>
    <th>작성자</th>
    <td><input type="text" name="bb_writer" value="<%=bb.getBb_writer() %>"></td>
  </tr>
    <tr>
    <th>비밀번호</th>
    <td><input type="text" name="bb_pw" value="<%=bb.getBb_pw() %>"></td>
  </tr>
      <tr>
    <th>내 용</th>
    <td><input type="text" name="bb_Content" value="<%=bb.getBb_Content() %>"></td>
  </tr>
  
  <tr>
    <td colspan=2 align=center>
    <input type=submit value="저장"><input type=reset value="취소">
    </td>
</tr>
</table>
</form>

</div>
</body>
</html>