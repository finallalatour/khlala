package lala.com.a.model;

import java.io.Serializable;

public class CartDto extends ProductDto implements Serializable {

	private int cart_seq;
	private int pseq; //제품글 seq
	private String id; //누구 장바구니냐
	private int myCount; //몇개 선택했나
	private int oseq; //0:장바구니, 그외:주문내역seq로 대체
	
	public CartDto() {}

	public CartDto(int cart_seq, int pseq, String id, int myCount, int oseq) {
		super();
		this.cart_seq = cart_seq;
		this.pseq = pseq;
		this.id = id;
		this.myCount = myCount;
		this.oseq = oseq;
	}

	public int getCart_seq() {
		return cart_seq;
	}

	public void setCart_seq(int cart_seq) {
		this.cart_seq = cart_seq;
	}

	public int getPseq() {
		return pseq;
	}

	public void setPseq(int pseq) {
		this.pseq = pseq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getMyCount() {
		return myCount;
	}

	public void setMyCount(int myCount) {
		this.myCount = myCount;
	}

	public int getOseq() {
		return oseq;
	}

	public void setOseq(int oseq) {
		this.oseq = oseq;
	}

	@Override
	public String toString() {
		return "CartDto [cart_seq=" + cart_seq + ", pseq=" + pseq + ", id=" + id + ", myCount=" + myCount + ", oseq="
				+ oseq + "]";
	}
}
