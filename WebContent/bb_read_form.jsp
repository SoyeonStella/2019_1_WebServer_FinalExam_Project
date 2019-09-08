<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="addrbook.*"%>
<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" href="addrbook.css" type="text/css" media="screen" />

<script type="text/javascript">
	function delcheck(bb_id) {
		result = confirm("정말로 삭제하시겠습니까 ?");
	
		if(result == true){
			pwd = prompt('수정/삭제 하려면 비밀번호를 넣으세요');
		    document.location.href="bb_control.jsp?bbaction=bbdelete&bb_id="+bb_id+"&upasswd="+pwd;
		    //document.form1.bbaction.value="bbdelete";
			//document.form1.submit();
		}
		else
			return;
	}
	
	function editcheck(bb_id) {
		pwd = prompt('수정/삭제 하려면 비밀번호를 넣으세요');
		document.location.href="bb_control.jsp?bbaction=bbedit&bb_id="+bb_id+"&upasswd="+pwd;
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 보기</title>
</head>

<jsp:useBean id="bb" scope="request" class="addrbook.BlackBoard" />

<body>
<div align="center">
<H2> 게시글 보기 </H2>
<HR>
[<a href=bb_control.jsp?bbaction=bblist>게시판 목록으로</a>] <p>
<form name=form1 method=post action=bb_control.jsp>
<input type=hidden name="bb_id" value="<%=bb.getBb_id()%>">
<input type=hidden name="bbaction" value="bbupdate">

<table border="1">  
  <tr>
	<td style="width: 20%;"> 글 제목 </td>
    <td colspan="2"><%= bb.getBb_title() %></td>
</tr>
<tr>
	<td>작성자</td>	
	<td colspan="2"><%= bb.getBb_writer() %></td>
</tr>
<tr>
	<td>작성일</td>	
	<td colspan="2"><%=bb.getBb_editDate().substring(0, 10) + " " + bb.getBb_editDate().substring(11, 13) + "시"
						+ bb.getBb_editDate().substring(14, 16) + "분" %></td>
</tr>
<tr>
	<td>내용</td>	
	<td colspan="2" style="min-height: 200px; text-align: left;"><%=bb.getBb_Content() %></td>
</tr>
<tr>
    <td colspan=2 align=center>
    <input type="button" value="수정" onClick="editcheck(<%=bb.getBb_id()%>)">
    <input type="button" value="삭제" onClick="delcheck(<%=bb.getBb_id()%>)">
    </td>
</tr>
</table>
</form>

</div>
</body>
</html>