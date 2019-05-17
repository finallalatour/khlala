package lala.com.a.meeting;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.swing.RepaintManager;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mysql.cj.jdbc.SuspendableXAConnection;

import lala.com.a.model.FestivalDto;
import lala.com.a.model.MeetingDto;
import lala.com.a.model.ReplyDto;
import lala.com.a.util.pagingBean;


@Controller
public class MeetingController {
	
	@Autowired
	MeetingService meetingService;
	
	private static final Logger logger 
	= LoggerFactory.getLogger(MeetingController.class);
	
	@RequestMapping(value="meeting.do" , method=RequestMethod.GET )
	public String meetList(Model model, HttpServletRequest req, pagingBean paging) {
		System.out.println("커뮤니티 컨트롤러");
		
		if(req.getParameter("nowPage") == null) {
			paging.setNowPage(1);
			
			logger.info("new Page");
			
		}else {
			paging.setNowPage(Integer.parseInt(req.getParameter("nowPage")));
			logger.info("old Page");
		}
		


		
		List<MeetingDto> meetlist =  meetingService.meetList(paging);
		
		for(int i =0; i<meetlist.size(); i++) {
		System.out.println(meetlist.get(i).toString());
		}
		
		model.addAttribute("paging", paging);
		model.addAttribute("meetlist", meetlist);
		return "meeting.tiles";
	}
	@RequestMapping(value="meetWrite.do" , method=RequestMethod.GET )
	public String meetWrite(Model model) {
		logger.info("글쓰기 페이지로 넘길게요");
		
		List<FestivalDto> meetwrite = meetingService.meetWrite();
		
		
		model.addAttribute("meetwrite", meetwrite);
		
		/*
		 * 축제이름 넘어오나 확인
		 * for(int i =0; i<meetwrite.size(); i++) {
		 * System.out.println(meetwrite.get(i).toString());
		 * 
		 * }
		 */
		
		return "meetWrite.tiles";
	}
	
	@RequestMapping(value="meetWriteAf.do" , method=RequestMethod.POST)
	public String meetWriteAf(MeetingDto dto) {
		System.out.println("meetWriteAf");
		//System.out.println(dto.toString());
		
		meetingService.meetWriteAf(dto);
		
		return "redirect:/meeting.do";
	}
	
	
	@RequestMapping(value="meetDetail.do" , method=RequestMethod.GET)
	public String meetDetail(int seq, Model model,String id) {
		System.out.println("meetDetail");
		
		System.out.println("seq:" + seq + "id : " + id);
		
		
        MeetingDto meetdetail = meetingService.meetDetail(seq);
        String joinID = meetingService.meetJoinID(new MeetingDto(seq,id));
        
        List<ReplyDto> reply = meetingService.meetReply(new ReplyDto(seq, id));
		
        System.out.println("joinid: " + joinID);
        System.out.println(meetdetail.toString());
        if(joinID == null) {
        	joinID = "testID";
        }
        
        System.out.println(joinID);
        model.addAttribute("meetdetail", meetdetail);
        model.addAttribute("reply",reply);
        model.addAttribute("joinID",joinID);
		return "meetDetail.tiles";
	}
	
	@RequestMapping(value="meetJoinAf.do" , method= {RequestMethod.GET,RequestMethod.POST})
	public String meetjoin(String id,int seq,Model model) {
		System.out.println("meetJoinAf");
		
		MeetingDto dto = new MeetingDto(seq, id);
		
		meetingService.meetJoinAf(dto);
		
		
		model.addAttribute("seq", seq);
		model.addAttribute("id",id);
		return "forward:/meetDetail.do";
	}
	@RequestMapping(value="meetJoinDel.do" , method= {RequestMethod.GET,RequestMethod.POST})
	public String meetJoinDel(String id,int seq,Model model) {
		
		System.out.println("meetJoinDel");
		
		MeetingDto dto = new MeetingDto(seq, id);
		
		meetingService.meetJoinDel(dto);
		
		model.addAttribute("seq", seq);
		model.addAttribute("id",id);
		
		return "forward:/meetDetail.do";
	}

	@RequestMapping(value="meetEnd.do" , method=RequestMethod.GET )
	public String meetEnd(int seq,String id, Model model) {
		
		meetingService.meetEnd(seq);
		
		model.addAttribute("seq", seq);
		model.addAttribute("id", id);
		return "redirect:/meetDetail.do";
	}
	
	
	  @RequestMapping(value="meetReply.do" , method={RequestMethod.GET,RequestMethod.POST})
	  public String meetComment( Model model,ReplyDto dto) {
	  
	  System.out.println("meetRely");
		/*
		 * System.out.println(id); System.out.println(pseq);
		 * System.out.println(content); System.out.println(lock_);
		 */
	  
	System.out.println(dto.toString());
	  meetingService.meetReplyWrite(dto);
	  
	  // 댓글의 부모글이 글의 seq 입니다 // 
	  int seq = dto.getPseq();
	  
	  model.addAttribute("seq", seq); 
	  model.addAttribute("id", dto.getId()); 
	  
	  return "redirect:/meetDetail.do"; 
	  }
	 
	  @RequestMapping(value="meetDelete.do" , method={RequestMethod.GET,RequestMethod.POST})
	  public String meetDelete(int seq) {
		  
		  
		  System.out.println("meetDelete");
		  
		  
		  meetingService.meetDelete(seq);
		  
		  return "redirect:/meeting.do";
	  }
	
	  @RequestMapping(value="answer.do" , method={RequestMethod.GET,RequestMethod.POST})
	  public String answer(ReplyDto dto, Model model) {
		  
		  System.out.println("answer");
		  
		  System.out.println(dto.toString());
		  meetingService.answer(dto);
		  
		  model.addAttribute("seq", dto.getSeq()); 
		  model.addAttribute("id", dto.getId()); 
		  
		  return "redirect:/meetDetail.do"; 
	  }
	  @RequestMapping(value="meetReplyUpdate.do" , method={RequestMethod.GET,RequestMethod.POST})
	  public String meetReplyUpdate( Model model,ReplyDto dto) {
		  System.out.println("meetReplyUpdate");
		  
		  meetingService.meetReplyUpdate(dto);
		  
		  
		  // 댓글의 부모글이 글의 seq 입니다 // 
		  int seq = dto.getPseq();
		  
		  model.addAttribute("seq", seq); 
		  model.addAttribute("id", dto.getId()); 
		  return "redirect:/meetDetail.do"; 
	  }
	 
	  
	  @RequestMapping(value="meetReplyDelete.do" , method={RequestMethod.GET,RequestMethod.POST})
	  public String meetReplyDelete( Model model,ReplyDto dto) {
		  System.out.println("meetReplyDelete");
		  
		  meetingService.meetReplyDelete(dto);
		  
		  
		  // 댓글의 부모글이 글의 seq 입니다 // 
		  int seq = dto.getPseq();
		  
		  model.addAttribute("seq", seq); 
		  model.addAttribute("id", dto.getId()); 
		  return "redirect:/meetDetail.do"; 
	  }
	  
	  
	  @RequestMapping(value="meetUpdate.do" , method={RequestMethod.GET,RequestMethod.POST})
	  public String meetUpdate(MeetingDto dto, Model model) {
		  System.out.println("meetUpdate");
		  
		  meetingService.meetUpdate(dto);
		  
		  model.addAttribute("seq", dto.getSeq()); 
		  model.addAttribute("id", dto.getId()); 
		  return "redirect:/meetDetail.do"; 
	  }
}
