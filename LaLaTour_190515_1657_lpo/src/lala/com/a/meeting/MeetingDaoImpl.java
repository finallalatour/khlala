package lala.com.a.meeting;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lala.com.a.model.FestivalDto;
import lala.com.a.model.MeetingDto;
import lala.com.a.model.ReplyDto;
import lala.com.a.util.pagingBean;
import lala.com.a.util.pagingUtil;

@Repository
public class MeetingDaoImpl implements MeetingDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	String ns = "meeting.";

	@Override
	public List<MeetingDto> meetList(pagingBean paging) {

		int totalCount = sqlSession.selectOne(ns + "totalCount", paging);
		System.out.println("여기까진되나여");
		paging.setTotalCount(totalCount);
		System.out.println("여기까진되나여2");
		paging = pagingUtil.setPagingInfo(paging);
		System.out.println("여기까진되나여3");

		sqlSession.update(ns + "meetProgress");
		List<MeetingDto> meetlist = sqlSession.selectList(ns + "meetList", paging);

		return meetlist;
	}

	@Override
	public List<FestivalDto> meetWrite() {

		List<FestivalDto> meetwrite = sqlSession.selectList(ns + "meetWrite");

		return meetwrite;
	}

	@Override
	public boolean meetWriteAf(MeetingDto dto) {

		int n = sqlSession.insert(ns + "meetWriteAf", dto);

		return n > 0 ? true : false;
	}

	@Override
	public MeetingDto meetDetail(int seq) {

		System.out.println("dao seq:" + seq);
		MeetingDto meetdetail = sqlSession.selectOne(ns + "meetDetail", seq);

		return meetdetail;
	}

	@Override
	public String meetJoinID(MeetingDto dto) {

		String joinID = sqlSession.selectOne(ns + "meetDetailJoin", dto);

		return joinID;
	}

	@Override
	public void meetJoinAf(MeetingDto dto) {

		sqlSession.insert(ns + "meetDetailJoinAf", dto);
	}

	@Override
	public void meetJoinDel(MeetingDto dto) {

		sqlSession.delete(ns + "meetDetailDelJoin", dto);
	}

	@Override
	public void joinCnt(MeetingDto dto) {

		sqlSession.update(ns + "joinCnt", dto.getSeq());
	}

	@Override
	public void joinDelCnt(MeetingDto dto) {

		sqlSession.update(ns + "joinDelCnt", dto.getSeq());
	}

	@Override
	public void meetEnd(int seq) {

		sqlSession.update(ns + "meetEnd", seq);

	}

	
	 public void meetReplyWrite(ReplyDto dto) {
	  System.out.println("체크하기 1");
	  sqlSession.insert(ns+"meetReplyWrite", dto);
	  System.out.println("체크하기 2");
	  }

	@Override
	public List<ReplyDto> meetReply(ReplyDto dto) {

		List<ReplyDto> reply = sqlSession.selectList(ns+"meetReply", dto);
		
		return reply;
	}

	@Override
	public void meetDelete(int seq) {

		sqlSession.update(ns+"meetDelete", seq);
	}

	@Override
	public void answer(ReplyDto dto) {

		
		sqlSession.insert(ns+"meetAnswer", dto);
	}

	@Override
	public void meetReplyUpdate(ReplyDto dto) {

		
		sqlSession.update(ns+"meetReplyUpdate", dto);
	}

	@Override
	public void meetReplyDelete(ReplyDto dto) {

		sqlSession.update(ns+"meetReplyDelete", dto);
	}

	@Override
	public void meetUpdate(MeetingDto dto) {

		sqlSession.update(ns+"meetUpdate", dto);
	}
	 
}
