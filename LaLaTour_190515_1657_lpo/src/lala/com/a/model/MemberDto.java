package lala.com.a.model;

import java.io.Serializable;

public class MemberDto implements Serializable {

	private String id;
	private String pwd;
	private String name; //자기이름
	private String email;
	private String phone;
	private String answer; //비번틀렸을때 답
	private String address;
	private int question; //비번틀렸을떄 질문 번호
	private int del; //0일반, 1탈퇴
	private int auth; //0일반, 1관리자
	
	public MemberDto() {}

	public MemberDto(String id, String pwd, String name, String email, String phone, String answer, String address,
			int question, int del, int auth) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.answer = answer;
		this.address = address;
		this.question = question;
		this.del = del;
		this.auth = auth;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getQuestion() {
		return question;
	}

	public void setQuestion(int question) {
		this.question = question;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", pwd=" + pwd + ", name=" + name + ", email=" + email + ", phone=" + phone
				+ ", answer=" + answer + ", address=" + address + ", question=" + question + ", del=" + del + ", auth="
				+ auth + "]";
	}
}
