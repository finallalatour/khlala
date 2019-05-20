package lala.com.a.model;

import java.io.Serializable;

import lala.com.a.product.FilePdsDto;

public class GoodsDto extends FilePdsDto implements Serializable {

	private int goods_seq;
	private int gpseq; //해당제품 기본키 (product)
	private int gcseq; //해당구매내역 장바구니 기본키 (cart)
	private String gid; //작성자
	private String gcontent; //내용
	private int gpoint; //별점 (1~5)
	private String gdate; //작성일
	private String gtname; //이 테이블 이름으로 하자 GOODS
	private String pictures; //첨부파일명
	
	public GoodsDto() {}

	public GoodsDto(int goods_seq, int gpseq, int gcseq, String gid, String gcontent, int gpoint, String gdate,
			String gtname, String pictures) {
		super();
		this.goods_seq = goods_seq;
		this.gpseq = gpseq;
		this.gcseq = gcseq;
		this.gid = gid;
		this.gcontent = gcontent;
		this.gpoint = gpoint;
		this.gdate = gdate;
		this.gtname = gtname;
		this.pictures = pictures;
	}

	public int getGoods_seq() {
		return goods_seq;
	}

	public void setGoods_seq(int goods_seq) {
		this.goods_seq = goods_seq;
	}

	public int getGpseq() {
		return gpseq;
	}

	public void setGpseq(int gpseq) {
		this.gpseq = gpseq;
	}

	public int getGcseq() {
		return gcseq;
	}

	public void setGcseq(int gcseq) {
		this.gcseq = gcseq;
	}

	public String getGid() {
		return gid;
	}

	public void setGid(String gid) {
		this.gid = gid;
	}

	public String getGcontent() {
		return gcontent;
	}

	public void setGcontent(String gcontent) {
		this.gcontent = gcontent;
	}

	public int getGpoint() {
		return gpoint;
	}

	public void setGpoint(int gpoint) {
		this.gpoint = gpoint;
	}

	public String getGdate() {
		return gdate;
	}

	public void setGdate(String gdate) {
		this.gdate = gdate;
	}

	public String getGtname() {
		return gtname;
	}

	public void setGtname(String gtname) {
		this.gtname = gtname;
	}

	public String getPictures() {
		return pictures;
	}

	public void setPictures(String pictures) {
		this.pictures = pictures;
	}

	@Override
	public String toString() {
		return "GoodsDto [goods_seq=" + goods_seq + ", gpseq=" + gpseq + ", gcseq=" + gcseq + ", gid=" + gid
				+ ", gcontent=" + gcontent + ", gpoint=" + gpoint + ", gdate=" + gdate + ", gtname=" + gtname
				+ ", pictures=" + pictures + "]";
	}
}
