<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"  errorPage="addrbook_error.jsp" import="addrbook.*, java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bb" class="addrbook.BbBean"/> 
<jsp:useBean id="blackboard" class="addrbook.BlackBoard"/>
<jsp:useBean id="addrbookmem" class="addrbook.AddrBookMem"/>
<jsp:setProperty name="blackboard" property="*"/> 
<jsp:useBean id="ab" class="addrbook.AddrBean"/> 
<jsp:useBean id="addrbook" class="addrbook.AddrBook"/>
<jsp:setProperty name="addrbook" property="*"/> 
<jsp:setProperty name="addrbookmem" property="*"/>
<% // 컨트롤러 요청 파라미터
	String action = request.getParameter("bbaction");	// 파라미터에 따른 요청 처리
	
	int pageNumber;
	if(request.getParameter("pageNumber")==null)
		pageNumber = 0;
	else
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	
	//numofPage.setPageNumber(0);
	// 게시글 목록 요청인 경우
	if(action.equals("bblist")) {
		
		ArrayList<BlackBoard> bbDatas = bb.getDBList(pageNumber);
		ArrayList<BlackBoard> bbDatalist = bb.getAllDBlist();
		//int maxPage = bb.countMaxPage();
		int Page = 3;
	
		request.setAttribute("bbDatas", bbDatas);	
		request.setAttribute("bbDatalist", bbDatalist);
		//request.setAttribute("maxPage", maxPage);
		//request.setAttribute("Page", Page);
         	pageContext.forward("bb_list.jsp");
        
	}
	
	//주소록 로그인 요청인 경우
	else if(action.equals("login")){
		String loginID = request.getParameter("loginID").toString();
		String loginPW = request.getParameter("loginPW").toString();
		int logSucc = 0;
		ArrayList<AddrBookMem> memDatas = ab.getMEMList();
		for(AddrBookMem  ab2 : (ArrayList<AddrBookMem>)memDatas) {
			if(ab2.getAb_logid().equals(loginID) && ab2.getAb_logpw().equals(loginPW)) {
				logSucc = 1;
			}
		}
		if(logSucc == 1) 
			pageContext.forward("select_Mode.jsp");
		else if (logSucc == 0)
			pageContext.forward("addrbook_loginFail.jsp");
	}
	//아이디 비밀번호 찾기 요청인 경우
	else if(action.equals("lookforLogInfo")){
		String infoMail = request.getParameter("infoMail");
		ArrayList<AddrBookMem> resultLogInfos = new ArrayList<AddrBookMem>();
		int findSucc = 0;
		ArrayList<AddrBookMem> memDatas = ab.getMEMList();
		for(AddrBookMem  ab2 : (ArrayList<AddrBookMem>)memDatas) {
			if(ab2.getAb_logemail().equals(infoMail)) {
				findSucc = 1;
				resultLogInfos.add(ab2);
			}
		}
		if(findSucc == 1) {
			request.setAttribute("resultLogInfos", resultLogInfos);
			pageContext.forward("addrbook_resultLogInfo.jsp");
		}
		else if (findSucc == 0)
			pageContext.forward("findLogInfoFail.jsp");
	}
	
	//게시글을 작성자로 검색 요청인 경우
	else if(action.equals("bbsearchAsWriter")){
		String searchBbData = request.getParameter("searchBbData");
		
		ArrayList<BlackBoard> bbDatalist = bb.getAllDBlist();
		
		ArrayList<BlackBoard> searchBbResults = new ArrayList<BlackBoard>();
		
		for(BlackBoard bb1 : (ArrayList<BlackBoard>) bbDatalist) {
			
			if(bb1.getBb_writer().equals(searchBbData)) {
				searchBbResults.add(bb1);
			}
		}
		request.setAttribute("searchBbResults", searchBbResults);	
     	pageContext.forward("bb_search_result.jsp");
		
	}
	
	//게시글을 제목으로 검색 요청인 경우
		else if(action.equals("bbsearchAsTitle")){
			String searchBbData = request.getParameter("searchBbData");
			
			ArrayList<BlackBoard> bbDatalist = bb.getAllDBlist();
			
			ArrayList<BlackBoard> searchBbResults = new ArrayList<BlackBoard>();
			
			for(BlackBoard bb1 : (ArrayList<BlackBoard>) bbDatalist) {
				if(bb1.getBb_title().contains(searchBbData)) {
					searchBbResults.add(bb1);
				}
			}
			request.setAttribute("searchBbResults", searchBbResults);	
	     	pageContext.forward("bb_search_result.jsp");
			
		}
	
	//게시글을 내용으로 검색 요청인 경우
			else if(action.equals("bbsearchAsContent")){
			String searchBbData = request.getParameter("searchBbData");
			
			ArrayList<BlackBoard> searchBbResults = bb.get_SearchDBList(searchBbData);
			
			//ArrayList<BlackBoard> searchBbResults = new ArrayList<BlackBoard>();
			
			//for(BlackBoard bb1 : (ArrayList<BlackBoard>) bbDatalist) {
			//	if(bb1.getBb_Content().contains(searchBbData)) {
			//		searchBbResults.add(bb1);
			//	}
			//}
			request.setAttribute("searchBbResults", searchBbResults);	
			
	     	pageContext.forward("bb_search_result.jsp");
			
		}
	//게시글을 제목+내용으로 검색 요청인 경우
			else if(action.equals("bbsearchAsTandC")){
				String searchBbData = request.getParameter("searchBbData");
				
				ArrayList<BlackBoard> bbDatalist = bb.getAllDBlist();
				
				ArrayList<BlackBoard> searchBbResults = new ArrayList<BlackBoard>();
				
				for(BlackBoard bb1 : (ArrayList<BlackBoard>) bbDatalist) {
					
					if(bb1.getBb_title().contains(searchBbData) || bb1.getBb_Content().contains("게")) {
						searchBbResults.add(bb1);
					}
				}
				request.setAttribute("searchBbResults", searchBbResults);	
		     	pageContext.forward("bb_search_result.jsp");
				
			}
	
	//회원가입 요청인 경우
	else if(action.equals("signin")) {		
		if(ab.insertMem(addrbookmem)) {
			response.sendRedirect("addrbook_control.jsp?action=list");
		}
		else
			throw new Exception("DB 입력오류");
	}
	// 게시글 등록 요청인 경우
	else if(action.equals("bbinsert")) {		
		if(bb.insertDB(blackboard)) {
			int initPage=0;
			response.sendRedirect("bb_control.jsp?bbaction=bblist");
		}
		else
			throw new Exception("DB 입력오류");
	}
	// 게시글 뷰 페이지 요청인 경우
		else if(action.equals("bbview")) {
			BlackBoard bboard = bb.getDB(blackboard.getBb_id());
			
			request.setAttribute("bb",bboard);
			pageContext.forward("bb_read_form.jsp");
		
		}
	// 게시글 수정 페이지 요청
	else if(action.equals("bbedit")) {
		BlackBoard bboard = bb.getDB(blackboard.getBb_id());
		if(!request.getParameter("upasswd").equals(bboard.getBb_pw().toString())) {
			out.println("<script>alert('비밀번호가 틀렸습니다.!!');history.go(-1);</script>");
		}
		else {
			request.setAttribute("bb",bboard);
			pageContext.forward("bb_edit_form.jsp");
		}
	}
	// 게시글 수정 등록 요청인 경우
	else if(action.equals("bbupdate")) {
			if(bb.updateDB(blackboard)) {
				response.sendRedirect("bb_control.jsp?bbaction=bblist");
			}
			else
				throw new Exception("DB 갱신오류");
	}
	// 게시글 삭제 요청인 경우
	else if(action.equals("bbdelete")) {
		BlackBoard bboard = bb.getDB(blackboard.getBb_id());
		if(!request.getParameter("upasswd").equals(bboard.getBb_pw().toString())) {
			out.println("<script>alert('비밀번호가 틀렸습니다.!!');history.go(-1);</script>");
		}
		else {
			if(bb.deleteDB(bboard.getBb_id())) {
				response.sendRedirect("bb_control.jsp?bbaction=bblist");
			}
			else
				throw new Exception("DB 삭제 오류");
		}
	}
	else {
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
	}
%>