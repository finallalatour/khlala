package lala.com.a.meeting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lala.com.a.model.FestivalDto;
import lala.com.a.model.MeetingDto;
import lala.com.a.model.ReplyDto;
import lala.com.a.util.pagingBean;

@Service
public class MeetingServiceImpl implements MeetingService {

	@Autowired
	MeetingDao meetingDao;

	@Override
	public List<MeetingDto> meetList( pagingBean paging) {

		return meetingDao.meetList(paging);
	}

	@Override
	public List<FestivalDto> meetWrite() {

		return meetingDao.meetWrite();
	}

	@Override
	public boolean meetWriteAf(MeetingDto dto) {
		
		return meetingDao.meetWriteAf(dto);
	}

	@Override
	public MeetingDto meetDetail(int seq) {

		System.out.println("service seq:" + seq);
		return meetingDao.meetDetail(seq);
	}

	@Override
	public String meetJoinID(MeetingDto dto) {

		return meetingDao.meetJoinID(dto);
	}

	@Override
	public void meetJoinAf(MeetingDto dto) {
		
		meetingDao.meetJoinAf(dto);
		meetingDao.joinCnt(dto);
	}

	@Override
	public void meetJoinDel(MeetingDto dto) {

		meetingDao.meetJoinDel(dto);
		meetingDao.joinDelCnt(dto);
	}

	@Override
	public void meetEnd(int seq) {

		
		meetingDao.meetEnd(seq);
	}

	
	 public void meetReplyWrite(ReplyDto dto) {
	  
	  
	  meetingDao.meetReplyWrite(dto);
	  }

	@Override
	public List<ReplyDto> meetReply(ReplyDto dto) {

		List<ReplyDto> reply = meetingDao.meetReply(dto);
		
		return reply;
	}

	@Override
	public void meetDelete(int seq) {

		meetingDao.meetDelete(seq);
	}

	@Override
	public void answer(ReplyDto dto) {

		meetingDao.answer(dto);
	}

	@Override
	public void meetReplyUpdate(ReplyDto dto) {

		meetingDao.meetReplyUpdate(dto);
	}

	@Override
	public void meetReplyDelete(ReplyDto dto) {

		meetingDao.meetReplyDelete(dto);
	}

	@Override
	public void meetUpdate(MeetingDto dto) {

		meetingDao.meetUpdate(dto);
	}
	 

	
	
	
}
