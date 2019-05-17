package lala.com.a.model;

import java.io.Serializable;

public class BbsDto implements Serializable {
	/*
	 * SEQ NUMBER(1) PRIMARY KEY,
	 *  ID VARCHAR2(50) NOT NULL, 
	 *  TITLE VARCHAR2(200)NOt NULL, 
	 *  CONTENT VARCHAR2(4000)NOT NULL, 
	 *  REGDATE VARCHAR2(50) NOT NULL,
	 * READCOUNT NUMBER(10)NOT NULL,
	 *  DEL NUMBER(1) NOT NULL, 
	 *  TNAME VARCHAR2(50)NOTNULL
	 * 
	 */
	private int seq;
	private String id;
	private String title;
	private String content;
	private String wdate;
	private int readcount;
	private int del;
	private String tname;
	
	
	
	
	
	
	public BbsDto(int seq, String id, String title, String content, String wdate, int readcount, int del,
			String tname) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.readcount = readcount;
		this.del = del;
		this.tname = tname;
	}



	public BbsDto() {
	}



	public int getSeq() {
		return seq;
	}



	public void setSeq(int seq) {
		this.seq = seq;
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
	}



	public String getWdate() {
		return wdate;
	}



	public void setWdate(String wdate) {
		this.wdate = wdate;
	}



	public int getReadcount() {
		return readcount;
	}



	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}



	public int getDel() {
		return del;
	}



	public void setDel(int del) {
		this.del = del;
	}



	public String getTname() {
		return tname;
	}



	public void setTname(String tname) {
		this.tname = tname;
	}



	@Override
	public String toString() {
		return "BbsDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", wdate=" + wdate
				+ ", readcount=" + readcount + ", del=" + del + ", tname=" + tname + "]";
	}

	
	
	
}
