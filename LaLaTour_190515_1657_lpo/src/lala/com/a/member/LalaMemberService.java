package lala.com.a.member;

import java.util.List;

import lala.com.a.model.MemberDto;
import lala.com.a.model.QuestionDto;

public interface LalaMemberService {

	//로그인
	public MemberDto loginaf(MemberDto dto);
	
	
	//회원가입 관련
	public List<QuestionDto> getQuestionList(); //비밀번호 질문리스트
	public int idSameCheck(String id); //아이디 중복체크
	public boolean addMember(MemberDto dto); //회원가입
	public String findId(MemberDto dto);//아이디찾기
	public String findPwd1(MemberDto dto);//비밀번호 찾기
	public boolean findPwd2(MemberDto dto);//비밀번호 이메일로찾기
}
