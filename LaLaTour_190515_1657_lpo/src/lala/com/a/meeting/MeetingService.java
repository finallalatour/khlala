package lala.com.a.meeting;

import java.util.List;

import lala.com.a.model.FestivalDto;
import lala.com.a.model.MeetingDto;
import lala.com.a.model.ReplyDto;
import lala.com.a.util.pagingBean;

public interface MeetingService {

	public List<MeetingDto> meetList(pagingBean paging);
	
	public List<FestivalDto> meetWrite();
	
	public boolean meetWriteAf(MeetingDto dto);
	
	public MeetingDto meetDetail(int seq);
	
	public String meetJoinID(MeetingDto dto);
	
	public void meetJoinAf(MeetingDto dto);
	
	public void meetJoinDel(MeetingDto dto);
	
	public void meetEnd(int seq);
	
	public void meetReplyWrite(ReplyDto dto); 
	
	public List<ReplyDto> meetReply(ReplyDto dto);
	
	 public void meetDelete(int seq);
	 
	 public void answer(ReplyDto dto);
	 
	 public void meetReplyUpdate(ReplyDto dto);
	 
	 
	 public void meetReplyDelete(ReplyDto dto);
	 
	 public void meetUpdate(MeetingDto dto);
}
