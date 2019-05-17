package lala.com.a.model;

import java.io.Serializable;

public class QuestionDto implements Serializable {

	private int seq;
	private String title; //질문
	
	public QuestionDto() {}

	public QuestionDto(int seq, String title) {
		super();
		this.seq = seq;
		this.title = title;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String toString() {
		return "QuestionDto [seq=" + seq + ", title=" + title + "]";
	}
}
