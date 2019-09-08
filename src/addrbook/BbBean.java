package addrbook;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;

/**
 * File : AddrBean.java
 * Desc : 주소록 프로그램 DAO 클래스
 * @author 김진환(kimjh@hansung.ac.kr)
 */
public class BbBean { 
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	/* Oracle 연결정보
	String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
	String jdbc_url = "jdbc:oracle:thin:@220.68.14.7:1521";
	192.168.168.101
	*/
	
	/* MySQL 연결정보 */
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://127.0.0.1:3306/jspdb?useSSL=false&serverTimezone=Asia/Seoul"; 
	
	// DB연결 메서드
	void connect() {
		try {
			Class.forName(jdbc_driver);

			conn = DriverManager.getConnection(jdbc_url,"root","Thdus0320");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 수정된 게시글 내용 갱신을 위한 메서드
	public boolean updateDB(BlackBoard blackboard) {
		connect();
		
		String sql ="update blackboard set bb_title=?, bb_writer=?, bb_pw=?, bb_editDate=? ,bb_Content=? where bb_id=?";		
		 
		LocalDateTime currentDateTime = LocalDateTime.now();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,blackboard.getBb_title());
			pstmt.setString(2,blackboard.getBb_writer());
			pstmt.setString(3,blackboard.getBb_pw());
			pstmt.setString(4,currentDateTime.toString());
			pstmt.setString(5,blackboard.getBb_Content());
			pstmt.setInt(6,blackboard.getBb_id());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
	// 특정 게시글 삭제 메서드
	public boolean deleteDB(int gb_id) {
		connect();
		
		String sql ="delete from blackboard where bb_id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,gb_id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
	// 신규 게시글 추가 메서드
	public boolean insertDB(BlackBoard blackboard) {
		connect();
		// sql 문자열 , gb_id 는 자동 등록 되므로 입력하지 않는다.
				
		String sql ="insert into blackboard(bb_title,bb_writer,bb_pw,bb_editDate,bb_Content) values(?,?,?,?,?)";
		LocalDateTime currentDateTime = LocalDateTime.now();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,blackboard.getBb_title());
			pstmt.setString(2,blackboard.getBb_writer());
			pstmt.setString(3, blackboard.getBb_pw());
			pstmt.setString(4, currentDateTime.toString());
			pstmt.setString(5,blackboard.getBb_Content());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}

	// 특정 게시글 가져오는 메서드
	public BlackBoard getDB(int gb_id) {
		connect();
		
		String sql = "select * from blackboard where bb_id=?";
		BlackBoard blackboard = new BlackBoard();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,gb_id);
			ResultSet rs = pstmt.executeQuery();
			
			// 데이터가 하나만 있으므로 rs.next()를 한번만 실행 한다.
			rs.next();
			blackboard.setBb_id(rs.getInt("bb_id"));
			blackboard.setBb_title(rs.getString("bb_title"));
			blackboard.setBb_writer(rs.getString("bb_writer"));
			blackboard.setBb_pw(rs.getString("bb_pw"));
			blackboard.setBb_editDate(rs.getString("bb_editDate"));
			blackboard.setBb_Content(rs.getString("bb_Content"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return blackboard;
	}
	
	// 전체 게시글 목록을 10개씩 가져오는 메서드
	public ArrayList<BlackBoard> getDBList(int pageNumber) {
		connect();
		ArrayList<BlackBoard> bbDatas = new ArrayList<BlackBoard>();
		
		String sql = "SELECT * FROM blackboard ORDER BY bb_id DESC LIMIT ?, 10";
	

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pageNumber * 10);
			//pstmt.setInt(2, (pageNumber + 1) * 10 + 1);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				BlackBoard blackboard = new BlackBoard();
				
				blackboard.setBb_id(rs.getInt("bb_id"));
				blackboard.setBb_title(rs.getString("bb_title"));
				blackboard.setBb_writer(rs.getString("bb_writer"));
				blackboard.setBb_pw(rs.getString("bb_pw"));
				blackboard.setBb_editDate(rs.getString("bb_editDate"));
				blackboard.setBb_Content(rs.getString("bb_Content"));
				bbDatas.add(blackboard);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return bbDatas;
	}
	//내용검색 게시글 불러오기 
	 public ArrayList<BlackBoard> get_SearchDBList(String search) {
	      connect();
	      ArrayList<BlackBoard> searchBbList = new ArrayList<BlackBoard>();

	      String sql = null;
	      
	      sql = "select * from blackboard where concat(bb_Content) like ? order by bb_id desc";
	     
	      
	      try {
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, "%" + search + "%");
	         ResultSet rs = pstmt.executeQuery();
	         while (rs.next()) {
	            BlackBoard blackboard = new BlackBoard();
	            blackboard.setBb_id(rs.getInt("bb_id"));
	            blackboard.setBb_title(rs.getString("bb_title"));
	            blackboard.setBb_writer(rs.getString("bb_writer"));
	            blackboard.setBb_editDate(rs.getString("bb_editDate"));
	            blackboard.setBb_Content(rs.getString("bb_Content"));
	            searchBbList.add(blackboard);
	         }
	         rs.close();

	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         disconnect();
	      }
	      return searchBbList;
	   }


	//게시글을 모두 한번에 읽어오기
	public ArrayList<BlackBoard> getAllDBlist() {
		connect();
		ArrayList<BlackBoard> bbDatalist = new ArrayList<BlackBoard>();
		
		String sql = "SELECT * FROM blackboard ORDER BY bb_id DESC";

		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BlackBoard blackboard = new BlackBoard();
				
				blackboard.setBb_id(rs.getInt("bb_id"));
				blackboard.setBb_title(rs.getString("bb_title"));
				blackboard.setBb_writer(rs.getString("bb_writer"));
				blackboard.setBb_pw(rs.getString("bb_pw"));
				blackboard.setBb_editDate(rs.getString("bb_editDate"));
				blackboard.setBb_Content(rs.getString("bb_Content"));
				bbDatalist.add(blackboard);
				
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return bbDatalist;		
	}
	//페이지번호 최대 값 구하는 메소드
	public int countMaxPage() {
		connect();
		//String sql = "SELECT COUNT(*) count FROM blackboard";
		String sql = "SELECT * FROM blackboard ORDER BY bb_id DESC";
		
		int maxPage=0;
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			rs.last();
			//int columnCount=rs.getInt("count");
			int columnCount=rs.getRow();
			rs.close();
			
			maxPage = (columnCount/10);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		System.out.println("페이지최대값"+maxPage);
		return maxPage;		
	}
	//인덱스 수 알아오기  
	public int getindexNum(ArrayList<BlackBoard> bbDatalist) {
		
		int indexNum=0;

			for(BlackBoard bb : bbDatalist) {
				indexNum=indexNum+1;
			}
			//System.out.println("인덱스수"+indexNum);
		return indexNum;		
	}
	
	//로그인정보 가져오는 메서드
	public ArrayList<AddrBookMem> getMEMList() {
		connect();
		ArrayList<AddrBookMem> memDatas = new ArrayList<AddrBookMem>();
		
		String sql = "select * from addrbook_mem order by ab_memid desc";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				AddrBookMem addrbookmem = new AddrBookMem();
				
				addrbookmem.setAb_memid(rs.getInt("ab_memid"));
			    addrbookmem.setAb_logid(rs.getString("ab_logid"));
				addrbookmem.setAb_logpw(rs.getString("ab_logpw"));
				addrbookmem.setAb_logemail(rs.getString("ab_logemail"));
				memDatas.add(addrbookmem);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return memDatas;
	}
	// 신규 회원 등록 메서드
		public boolean insertMem(AddrBookMem addrbookmem) {
			connect();
			// sql 문자열 , gb_id 는 자동 등록 되므로 입력하지 않는다.
					
			String sql ="insert into addrbook_mem(ab_logid,ab_logpw,ab_logemail) values(?,?,?)";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,addrbookmem.getAb_logid());
				pstmt.setString(2,addrbookmem.getAb_logpw());
				pstmt.setString(3,addrbookmem.getAb_logemail());
				
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
			finally {
				disconnect();
			}
			return true;
		}
}