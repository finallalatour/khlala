package lala.com.a.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lala.com.a.member.LalaMemberDao;
import lala.com.a.model.MemberDto;
import lala.com.a.model.QuestionDto;

@Repository
public class LalaMemberDaoImpl implements LalaMemberDao {

	@Autowired
	SqlSession sqlSession;
	
	String ns = "Member.";

	//로그인
	@Override
	public MemberDto loginaf(MemberDto dto) {
		return sqlSession.selectOne(ns+"loginaf", dto);
	}

	@Override
	public List<QuestionDto> getQuestionList() {
		// 비밀번호 질문리스트
		return sqlSession.selectList(ns+"getQuestionList");
	}

	@Override
	public int idSameCheck(String id) {
		// 아이디 중복체크
		return sqlSession.selectOne(ns+"idsamecheck", id);
	}

	@Override
	public boolean addMember(MemberDto dto) {
		// 회원가입
		int n = sqlSession.insert(ns+"addmember", dto);
		return n>0? true:false;
	}

	@Override
	public String findId(MemberDto dto) {
		System.out.println("들어옴");
		String id =  "아이디를 찾을 수 없습니다";
		String selid =	sqlSession.selectOne(ns+"findId", dto);	
		if( selid != null) {
			System.out.println("들어옴2");
			id = selid;
		}
		System.out.println("들어옴3");
		
		return id;
	}

	@Override
	public String findPwd1(MemberDto dto) {

		String pwd = "비밀번호를 찾을 수 없습니다.";
		
		String selPwd = sqlSession.selectOne(ns+"findPwd1", dto);	
		
		if( selPwd != null) {
			System.out.println("들어옴2");
			pwd = selPwd;
		}
		
		return pwd;
	}

	@Override
	public boolean findPwd2(MemberDto dto) {

		int n = sqlSession.update(ns+"findPwd2", dto);
		
		return n>0?true:false;
	}
	
	
	
}
