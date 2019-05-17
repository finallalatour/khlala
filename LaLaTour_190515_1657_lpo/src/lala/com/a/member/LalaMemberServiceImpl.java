package lala.com.a.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lala.com.a.member.LalaMemberDao;
import lala.com.a.member.LalaMemberService;
import lala.com.a.model.MemberDto;
import lala.com.a.model.QuestionDto;

@Service
public class LalaMemberServiceImpl implements LalaMemberService {

	@Autowired
	LalaMemberDao lalaMemberDao;

	@Override
	public MemberDto loginaf(MemberDto dto) {
		// 로그인
		return lalaMemberDao.loginaf(dto);
	}

	@Override
	public List<QuestionDto> getQuestionList() {
		// 비밀번호 질문리스트
		return lalaMemberDao.getQuestionList();
	}

	@Override
	public int idSameCheck(String id) {
		// 아이디 중복체크
		return lalaMemberDao.idSameCheck(id);
	}

	@Override
	public boolean addMember(MemberDto dto) {
		// 회원가입
		return lalaMemberDao.addMember(dto);
	}

	@Override
	public String findId(MemberDto dto) {

		
		String id = lalaMemberDao.findId(dto);
		
		System.out.println("service 리턴직전");
		return id;
	}

	@Override
	public String findPwd1(MemberDto dto) {

		return lalaMemberDao.findPwd1(dto);
	}

	@Override
	public boolean findPwd2(MemberDto dto) {

		return lalaMemberDao.findPwd2(dto);
	}
}
