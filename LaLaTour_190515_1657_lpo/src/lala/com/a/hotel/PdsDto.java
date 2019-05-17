package lala.com.a.hotel;

import java.io.Serializable;

public class PdsDto implements Serializable {
	private int seq;
	private String fileName_Bf;
	private String fileName_Af;
	private int pseq;
	private String tname;
	
	public PdsDto() {
	}
	
	public PdsDto(int seq, String fileName_Bf, String fileName_Af, int pseq, String tname) {
		super();
		this.seq = seq;
		this.fileName_Bf = fileName_Bf;
		this.fileName_Af = fileName_Af;
		this.pseq = pseq;
		this.tname = tname;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getfileName_Bf() {
		return fileName_Bf;
	}

	public void setfileName_Bf(String fileName_Bf) {
		this.fileName_Bf = fileName_Bf;
	}

	public String getfileName_Af() {
		return fileName_Af;
	}

	public void setfileName_Af(String fileName_Af) {
		this.fileName_Af = fileName_Af;
	}

	public int getPseq() {
		return pseq;
	}

	public void setPseq(int pseq) {
		this.pseq = pseq;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	@Override
	public String toString() {
		return "PdsDto [seq=" + seq + ", fileName_Bf=" + fileName_Bf + ", fileName_Af=" + fileName_Af + ", pseq=" + pseq
				+ ", tname=" + tname + "]";
	}
	
	
}
