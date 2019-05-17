package lala.com.a.model;

import java.io.Serializable;

public class ReserveDto implements Serializable {
	private int seq;
	private String merchant;
	private String id;
	private String sdate;
	private String edate;
	private int del;
	private int pseq;
	private int re_price;
	private String wdate;
	
	public ReserveDto() {
	}
	
	public ReserveDto(int seq, String merchant, String id, String sdate, String edate, int del, int pseq, int re_price,
			String wdate) {
		super();
		this.seq = seq;
		this.merchant = merchant;
		this.id = id;
		this.sdate = sdate;
		this.edate = edate;
		this.del = del;
		this.pseq = pseq;
		this.re_price = re_price;
		this.wdate = wdate;
	}


	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getMerchant() {
		return merchant;
	}


	public void setMerchant(String merchant) {
		this.merchant = merchant;
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getEdate() {
		return edate;
	}

	public void setEdate(String edate) {
		this.edate = edate;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getPseq() {
		return pseq;
	}

	public void setPseq(int pseq) {
		this.pseq = pseq;
	}
	
	public int getRe_price() {
		return re_price;
	}

	public void setRe_price(int re_price) {
		this.re_price = re_price;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	@Override
	public String toString() {
		return "ReserveDto [seq=" + seq + ", merchant=" + merchant + ", id=" + id + ", sdate=" + sdate + ", edate="
				+ edate + ", del=" + del + ", pseq=" + pseq + ", re_price=" + re_price + ", wdate=" + wdate + "]";
	}
}
