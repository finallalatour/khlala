package lala.com.a.model;

import java.io.Serializable;

public class PdsDto implements Serializable {

	private int seq;
	private int pseq; //본문글 seq
	private String fileNameBf; //원본파일명
	private String fileNameAf; //수정된 파일명
	private String tname; //이거 해당테이블들의 이름이 입력돼야 함
	
	public PdsDto() {}

	public PdsDto(int seq, int pseq, String fileNameBf, String fileNameAf, String tname) {
		super();
		this.seq = seq;
		this.pseq = pseq;
		this.fileNameBf = fileNameBf;
		this.fileNameAf = fileNameAf;
		this.tname = tname;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getPseq() {
		return pseq;
	}

	public void setPseq(int pseq) {
		this.pseq = pseq;
	}

	public String getFileNameBf() {
		return fileNameBf;
	}

	public void setFileNameBf(String fileNameBf) {
		this.fileNameBf = fileNameBf;
	}

	public String getFileNameAf() {
		return fileNameAf;
	}

	public void setFileNameAf(String fileNameAf) {
		this.fileNameAf = fileNameAf;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	@Override
	public String toString() {
		return "PdsDto [seq=" + seq + ", pseq=" + pseq + ", fileNameBf=" + fileNameBf + ", fileNameAf=" + fileNameAf
				+ ", tname=" + tname + "]";
	}
}
