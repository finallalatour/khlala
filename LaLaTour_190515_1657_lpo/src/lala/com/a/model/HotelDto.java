package lala.com.a.model;

import java.io.Serializable;

public class HotelDto implements Serializable {
	private int seq;
	private String id;
	private String title;
	private String content;
	private String place;
	private int del;
	private String thumbnail;
	private int price;
	private int maxcount;
	
	public HotelDto() {
	}

	public HotelDto(int seq, String id, String title, String content, String place, int del, String thumbnail,
			int price, int maxcount) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.place = place;
		this.del = del;
		this.thumbnail = thumbnail;
		this.price = price;
		this.maxcount = maxcount;
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

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
	public int getMaxcount() {
		return maxcount;
	}

	public void setMaxcount(int maxcount) {
		this.maxcount = maxcount;
	}

	@Override
	public String toString() {
		return "HotelDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", place=" + place
				+ ", del=" + del + ", thumbnail=" + thumbnail + ", price=" + price + ", maxcount=" + maxcount + "]";
	}
}
