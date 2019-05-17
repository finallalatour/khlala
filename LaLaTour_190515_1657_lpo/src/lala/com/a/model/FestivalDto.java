package lala.com.a.model;

import java.io.Serializable;

public class FestivalDto implements Serializable {

	private int seq;
	private String id;
	private String title;
	private String content;
	private String place;
	private String sDate;
	private String eDate;
	private int del;
	private int readcount;
	private String thumbnail;
	   
	public FestivalDto() {}

	public FestivalDto(int seq, String id, String title, String content, String place, String sDate, String eDate,
			int del, int readcount, String thumbnail) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.place = place;
		this.sDate = sDate;
		this.eDate = eDate;
		this.del = del;
		this.readcount = readcount;
		this.thumbnail = thumbnail;
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

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getsDate() {
		return sDate;
	}

	public void setsDate(String sDate) {
		this.sDate = sDate;
	}

	public String geteDate() {
		return eDate;
	}

	public void seteDate(String eDate) {
		this.eDate = eDate;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	@Override
	public String toString() {
		return "FestivalDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", place="
				+ place + ", sDate=" + sDate + ", eDate=" + eDate + ", del=" + del + ", readcount=" + readcount
				+ ", thumbnail=" + thumbnail + "]";
	}
}
