package lala.com.a.model;

import java.io.Serializable;

public class ProductDto implements Serializable {

	private int product_seq;
	private String id;
	private String title;
	private String subtitle;
	private String content;
	
	private int pcount; //제품수량
	private int price; //제품가격
	
	private String place; //원산지
	private String thumbNail; //썸네일
	private int fseq; //축제글 seq (null 허용임)
	
	private String wdate; //등록일
	private int del; //0일반, 1삭제
	private String tname; //PRODUCT로 고정
	
	public ProductDto() {}

	public ProductDto(int product_seq, String id, String title, String subtitle, String content, int pcount, int price,
			String place, String thumbNail, int fseq, String wdate, int del, String tname) {
		super();
		this.product_seq = product_seq;
		this.id = id;
		this.title = title;
		this.subtitle = subtitle;
		this.content = content;
		this.pcount = pcount;
		this.price = price;
		this.place = place;
		this.thumbNail = thumbNail;
		this.fseq = fseq;
		this.wdate = wdate;
		this.del = del;
		this.tname = tname;
	}

	public int getProduct_seq() {
		return product_seq;
	}

	public void setProduct_seq(int product_seq) {
		this.product_seq = product_seq;
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

	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getPcount() {
		return pcount;
	}

	public void setPcount(int pcount) {
		this.pcount = pcount;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getThumbNail() {
		return thumbNail;
	}

	public void setThumbNail(String thumbNail) {
		this.thumbNail = thumbNail;
	}

	public int getFseq() {
		return fseq;
	}

	public void setFseq(int fseq) {
		this.fseq = fseq;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
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
		return "ProductDto [product_seq=" + product_seq + ", id=" + id + ", title=" + title + ", subtitle=" + subtitle
				+ ", content=" + content + ", pcount=" + pcount + ", price=" + price + ", place=" + place
				+ ", thumbNail=" + thumbNail + ", fseq=" + fseq + ", wdate=" + wdate + ", del=" + del + ", tname="
				+ tname + "]";
	}
}
