<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="java.util.*,addrbook.*"%>
<!DOCTYPE HTML><html><head>
<link rel="stylesheet" href="addrbook.css" type="text/css" media="screen" />
<script type="text/javascript">
	function check(bb_id) {
		document.location.href="bb_control.jsp?bbaction=bbview&bb_id="+bb_id;	
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주소록:검색결과</title></head>
<jsp:useBean id="searchBbResults" scope="request" class="java.util.ArrayList" />

<body><div align="center"> 
<H2>주소록:검색결과</H2>
<HR>

[<a href=bb_control.jsp?bbaction=bblist>게시글 목록으로</a>] <P>
<form name=form2 method=post action=bb_control.jsp>
<table border="1">
   <tr><th width=40>번호</th><th width=200>제 목</th><th width=70>작성자</th><th width=120>작성일자</th></tr>
	<%
		for(BlackBoard  bb : (ArrayList<BlackBoard>) searchBbResults) {
	%>
  <tr><td><%=bb.getBb_id() %></td>
				<td><a href="javascript:check(<%=bb.getBb_id()%>)"><%=bb.getBb_title() %></a></td>
				<td><%=bb.getBb_writer() %></td>
				<td><%=bb.getBb_editDate().substring(0, 10) + " " + bb.getBb_editDate().substring(11, 13) + "시"
						+ bb.getBb_editDate().substring(14, 16) + "분" %></td>
 			   
			  </tr>
			 <%
			 
				}
			 %>

</table>
</form>


</div></body></html>