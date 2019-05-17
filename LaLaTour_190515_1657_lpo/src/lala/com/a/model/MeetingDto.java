package lala.com.a.model;

import java.io.Serializable;

public class MeetingDto implements Serializable {

	private int seq;
	private String id;
	private String ftitle;
	private String title;
	private String content;
	private int meet_loc;
	
	private int usercnt;
	private int maxcnt;
	
	private int del;
	private String edate;
	private String wdate;
	private int progress;
	private String tname;
	
	public MeetingDto() {

	}
	
	

	public MeetingDto(int seq, String id) {
		super();
		this.seq = seq;
		this.id = id;
	}

	public MeetingDto(String id) {
		super();
		this.id = id;
	}
	public MeetingDto(int seq, String id, String ftitle, String title, String content, int meet_loc, int usercnt,
			int maxcnt, int del, String edate, String wdate, int progress, String tname) {
		super();
		this.seq = seq;
		this.id = id;
		this.ftitle = ftitle;
		this.title = title;
		this.content = content;
		this.meet_loc = meet_loc;
		this.usercnt = usercnt;
		this.maxcnt = maxcnt;
		this.del = del;
		this.edate = edate;
		this.wdate = wdate;
		this.progress = progress;
		this.tname = tname;
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

	public String getFtitle() {
		return ftitle;
	}

	public void setFtitle(String ftitle) {
		this.ftitle = ftitle;
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

	public int getMeet_loc() {
		return meet_loc;
	}

	public void setMeet_loc(int meet_loc) {
		this.meet_loc = meet_loc;
	}

	public int getUsercnt() {
		return usercnt;
	}

	public void setUsercnt(int usercnt) {
		this.usercnt = usercnt;
	}

	public int getMaxcnt() {
		return maxcnt;
	}

	public void setMaxcnt(int maxcnt) {
		this.maxcnt = maxcnt;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public String getEdate() {
		return edate;
	}

	public void setEdate(String edate) {
		this.edate = edate;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getProgress() {
		return progress;
	}

	public void setProgress(int progress) {
		this.progress = progress;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	@Override
	public String toString() {
		return "MeetingDto [seq=" + seq + ", id=" + id + ", ftitle=" + ftitle + ", title=" + title + ", content="
				+ content + ", meet_loc=" + meet_loc + ", usercnt=" + usercnt + ", maxcnt=" + maxcnt + ", del=" + del
				+ ", edate=" + edate + ", wdate=" + wdate + ", progress=" + progress + ", tname=" + tname + "]";
	}
	
	
	
	
}
