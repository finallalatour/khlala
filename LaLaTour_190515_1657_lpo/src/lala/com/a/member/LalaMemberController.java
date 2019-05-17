package lala.com.a.member;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lala.com.a.model.MemberDto;
import lala.com.a.model.QuestionDto;
import lala.com.a.util.NewPwd;
import lala.com.a.util.SendEmail;

@Controller
public class LalaMemberController {

	private static final Logger logger = LoggerFactory.getLogger(LalaMemberController.class);
	
	@Autowired
	LalaMemberService lalaMemberService;
	
	@RequestMapping(value="mainpage.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String mainpage() {
		logger.info("LalaMemberController mainpage " + new Date());
		
		return "mainpage.tiles";
	}
	
	@RequestMapping(value="logout.do", method={ RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpServletRequest req) {
		logger.info("LalaMemberController logout " + new Date());
		
		//req.getSession().invalidate();
		HttpSession session = req.getSession(false);
		session.invalidate();
		
		return "redirect:/mainpage.do";
	}
	
	@RequestMapping(value="login.do", method=RequestMethod.GET)
	public String login() {
		logger.info("LalaMemberController login " + new Date());
		
		return "login.tiles";
	}
	
	@RequestMapping(value="loginaf.do", method=RequestMethod.POST)
	public String loginaf(MemberDto dto, HttpServletRequest req) {
		logger.info("LalaMemberController loginaf " + new Date());
		
		MemberDto login = lalaMemberService.loginaf(dto);
		System.out.println("login: " + login.toString());
		
		if(login!=null && !login.getId().equals("")) {
			//if(login!=null) {
			//session에 넣어주기
			req.getSession().setAttribute("login", login);
			
			//게시판으로 이동하기 위해 컨트롤러로 이동
			return "redirect:/mainpage.do"; //sendRedirect
			//return "forward:/bbslist.do"; //forward 데이터를 가져갈때
		}
		else {
			//다시 login으로 돌리기
			//return "redirect:/login.do";
			return "error.tiles";
		}
	}
	
	@RequestMapping(value="join.do", method=RequestMethod.GET)
	public String join(Model model) {
		logger.info("LalaMemberController join " + new Date());
		
		List<QuestionDto> qlist = lalaMemberService.getQuestionList();
		model.addAttribute("qlist", qlist);
		
		return "join.tiles";
	}
	
	@RequestMapping(value="joinaf.do", method=RequestMethod.POST)
	public String joinaf(MemberDto dto) {
		logger.info("LalaMemberController joinaf " + new Date());
		
		//System.out.println(dto.toString());
		boolean isS = lalaMemberService.addMember(dto);
		if(isS) {
			return "redirect:/mainpage.do";
		}
		else {
			return "redirect:/join.do";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="idsamecheck.do", method=RequestMethod.POST)
	public String idsamecheck(String id) {
		logger.info("LalaMemberController idsamecheck " + new Date());
		
		int n = lalaMemberService.idSameCheck(id);
		String msg = n==1? "no":"yes";
		
		return msg;
	}
	
	@RequestMapping(value="findId.do", method=RequestMethod.GET)
	public String findId() {
		
		System.out.println("findId");
		
		return "findId.tiles";
	}
	
	
	@RequestMapping(value="findIdAf.do", method=RequestMethod.GET)
	public String findIdAf(MemberDto dto,Model model) {
		System.out.println("findIdAf");
		String id = lalaMemberService.findId(dto);
		
		model.addAttribute("id", id);
		
		System.out.println("id:"+id);
		return "findIdAf.tiles";
	}
	
	@RequestMapping(value="findPwd.do", method=RequestMethod.GET)
	public String findPwd(Model model) {
		
		List<QuestionDto> qlist = lalaMemberService.getQuestionList();
		model.addAttribute("qlist", qlist);
		
		return "findPwd.tiles";
	}
	
	@RequestMapping(value="findPwdAf1.do", method={RequestMethod.GET,RequestMethod.POST})
	public String findPwdAf1(MemberDto dto, Model model) {
		
		String pwd = lalaMemberService.findPwd1(dto);
		
		
		model.addAttribute("pwd", pwd);
		return "findPwdAf.tiles";
	}
	
	@RequestMapping(value="findPwdAf2.do", method= {RequestMethod.GET,RequestMethod.POST})
	public String findPwdAf2(MemberDto dto, Model model) {
	
	System.out.println("findPwdAf2");
	
	String pwd = NewPwd.excuteGenerate();
	dto.setPwd(pwd);
	
	System.out.println(dto.toString());
	boolean suc = lalaMemberService.findPwd2(dto);
	if(suc) {
	System.out.println("성공");	
	SendEmail.SendId(dto.getEmail(), dto.getPwd());
	pwd="임시 비밀번호를 이메일로 전송했습니다.";
		
	}else {
		System.out.println("실패");
		pwd="비밀번호를 찾을 수 없습니다.";
	}
		
	model.addAttribute("pwd", pwd);
	return "findPwdAf.tiles";
	}
}






























