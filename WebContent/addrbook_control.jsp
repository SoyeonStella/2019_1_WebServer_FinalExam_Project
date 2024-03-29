﻿<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"  errorPage="addrbook_error.jsp" import="addrbook.*, java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="ab" class="addrbook.AddrBean"/> 
<jsp:useBean id="addrbook" class="addrbook.AddrBook"/>
<jsp:useBean id="addrbookmem" class="addrbook.AddrBookMem"/>
<jsp:setProperty name="addrbook" property="*"/> 
<jsp:setProperty name="addrbookmem" property="*"/>
<% // 컨트롤러 요청 파라미터
	String action = request.getParameter("action");	// 파라미터에 따른 요청 처리
	// 주소록 목록 요청인 경우
	if(action.equals("list")) {
		ArrayList<AddrBook> datas = ab.getDBList();
		request.setAttribute("datas", datas);	
         	pageContext.forward("addrbook_list.jsp");
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
	//주소록 검색 요청인 경우
	else if(action.equals("search")){
		String searchID = request.getParameter("searchID");
		ArrayList<AddrBook> datas = ab.getDBList();
		ArrayList<AddrBook> searchResults = new ArrayList<AddrBook>();
		for(AddrBook  ab1 : (ArrayList<AddrBook>)datas) {
			if(ab1.getAb_comdept().equals(searchID)) {
				searchResults.add(ab1);
			}
		}
		request.setAttribute("searchResults", searchResults);	
     	pageContext.forward("addrbook_search_result.jsp");
		
	}
	//회원가입 요청인 경우
	else if(action.equals("signin")) {		
		if(ab.insertMem(addrbookmem)) {
			response.sendRedirect("addrbook_control.jsp?action=list");
		}
		else
			throw new Exception("DB 입력오류");
	}
	// 주소록 등록 요청인 경우
	else if(action.equals("insert")) {		
		if(ab.insertDB(addrbook)) {
			response.sendRedirect("addrbook_control.jsp?action=list");
		}
		else
			throw new Exception("DB 입력오류");
	}	
	// 주소록 수정 페이지 요청인 경우
	else if(action.equals("edit")) {
		AddrBook abook = ab.getDB(addrbook.getAb_id());
		if(!request.getParameter("upasswd").equals("1234")) {
			out.println("<script>alert('비밀번호가 틀렸습니다.!!');history.go(-1);</script>");
		}
		else {
			request.setAttribute("ab",abook);
			pageContext.forward("addrbook_edit_form.jsp");
		}
	}
	// 주소록 수정 등록 요청인 경우
	else if(action.equals("update")) {
			if(ab.updateDB(addrbook)) {
				response.sendRedirect("addrbook_control.jsp?action=list");
			}
			else
				throw new Exception("DB 갱신오류");
	}	
	// 주소록 삭제 요청인 경우
	else if(action.equals("delete")) {
		if(ab.deleteDB(addrbook.getAb_id())) {
			response.sendRedirect("addrbook_control.jsp?action=list");
		}
		else
			throw new Exception("DB 삭제 오류");
	}
	else {
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
	}
%>