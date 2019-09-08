package addrbook;

/**
 * File : AddrBook.java
 * Desc : 주소록 프로그램 DO 클래스
 * @author 김진환(kimjh@hansung.ac.kr)
 */
public class AddrBookMem {
	// 멤버변수 선언
	private int ab_memid;
	private String ab_logid;
	private String ab_logpw;
	private String ab_logemail;
	
	
	public int getAb_memid() {
		return ab_memid;
	}
	public void setAb_memid(int ab_memid) {
		this.ab_memid = ab_memid;
	}
	public String getAb_logid() {
		return ab_logid;
	}
	public void setAb_logid(String ab_logid) {
		this.ab_logid = ab_logid;
	}
	public String getAb_logpw() {
		return ab_logpw;
	}
	public void setAb_logpw(String ab_logpw) {
		this.ab_logpw = ab_logpw;
	}
	public String getAb_logemail() {
		return ab_logemail;
	}
	public void setAb_logemail(String ab_logemail) {
		this.ab_logemail = ab_logemail;
	}
	
	
}

