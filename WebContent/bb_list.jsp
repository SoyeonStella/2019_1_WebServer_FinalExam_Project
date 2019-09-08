<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="java.util.*,addrbook.*"%>
<!DOCTYPE HTML>

<jsp:useBean id="BbBean" class="addrbook.BbBean"/> 

<html><head>
<link rel="stylesheet" href="addrbook.css" type="text/css" media="screen" />
<script type="text/javascript">
	function check(bb_id) {
		document.location.href="bb_control.jsp?bbaction=bbview&bb_id="+bb_id;
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판:목록화면</title></head>


<jsp:useBean id="bbDatas" scope="request" class="java.util.ArrayList" />
<jsp:useBean id="bbDatalist" scope="request" class="java.util.ArrayList" />

<body>


<% 

	int pageNumber = 0; //기본 페이지 넘버
	int aa=0;
	//int MaxPage = Integer.parseInt(request.getParameter("maxPage").toString());
	//int ExPage = Integer.parseInt(request.getParameter("Page").toString());
	//System.out.println("후"+ExPage);

//페이지넘버값이 있을때
if (request.getParameter("pageNumber") != null) {
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}
	
	


%>

<div align="center"> 

<H2>게시판:목록화면</H2>
<HR>
<form name=form2 method=post action=bb_form.jsp>
<a href="select_Mode.jsp">메인으로</a><P>

<table border="1">
  <tr><th width=40>번호</th><th width=200>제 목</th><th width=70>작성자</th><th width=120>작성일자</th></tr>
	<%
		for(BlackBoard  bb : (ArrayList<BlackBoard>)bbDatas) {
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
	<tr>
	
	<%
		for(BlackBoard  bblist : (ArrayList<BlackBoard>)bbDatalist) {
			 	aa++;
				}
		int maxPage = (aa/10);
			 %>
	
	
	<td colspan=4 align="center">
	<%
					if (pageNumber != 0) {
				%>
   	[<a href=bb_control.jsp?bbaction=bblist&pageNumber=<%=pageNumber - 1%>>이전</a>] 
   	<%
					}
		for(int i=0; i<(maxPage+1); i++) {
	%>
	[<a href=bb_control.jsp?bbaction=bblist&pageNumber=<%=i%>><%=i+1%></a>]
	<%
		}
					if (pageNumber < maxPage) {
	%>
 
	[<a href=bb_control.jsp?bbaction=bblist&pageNumber=<%=pageNumber + 1%>>다음</a>] <p>
	<%
					}
	%>
    </td></tr>
    <tr>
    <td colspan=4 align=center>
    <input type=submit value="글쓰기">
    </td></tr>
</tr>
</table>
</form>

<br><br>

        <form name=form2 method=post action=bb_control.jsp>
            <select name="bbaction">
                <option value="bbsearchAsTitle">제목</option>
                <option value="bbsearchAsContent">내용</option>
            </select>
            <input type="text" size="20" name="searchBbData"/>&nbsp;
            <input type="submit" value="검색"/>
        </form>    
  
</div>

</body></html>