package addrbook;

/**
 * File : AddrBook.java
 * Desc : 주소록 프로그램 DO 클래스
 * @author 김진환(kimjh@hansung.ac.kr)
 */
public class BlackBoard {
	// 멤버변수 선언
	private int bb_id;
	private String bb_title;
	private String bb_writer; 
	private String bb_pw;
	private String bb_editDate;
	private String bb_Content;
	public int getBb_id() {
		return bb_id;
	}
	public void setBb_id(int bb_id) {
		this.bb_id = bb_id;
	}
	public String getBb_title() {
		return bb_title;
	}
	public void setBb_title(String bb_title) {
		this.bb_title = bb_title;
	}
	public String getBb_writer() {
		return bb_writer;
	}
	public void setBb_writer(String bb_writer) {
		this.bb_writer = bb_writer;
	}
	public String getBb_pw() {
		return bb_pw;
	}
	public void setBb_pw(String bb_pw) {
		this.bb_pw = bb_pw;
	}
	public String getBb_editDate() {
		return bb_editDate;
	}
	public void setBb_editDate(String bb_editDate) {
		this.bb_editDate = bb_editDate;
	}
	public String getBb_Content() {
		return bb_Content;
	}
	public void setBb_Content(String bb_Content) {
		this.bb_Content = bb_Content;
	}

	
}
