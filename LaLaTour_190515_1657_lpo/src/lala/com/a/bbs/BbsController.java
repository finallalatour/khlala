package lala.com.a.bbs;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lala.com.a.model.BbsDto;
import lala.com.a.util.pagingBean;

@Controller
public class BbsController {

	@Autowired
	BbsService bbsService;
	
	@RequestMapping(value="bbsList.do", method=RequestMethod.GET)
	public String bbsList(pagingBean paging, Model model,HttpServletRequest req) {
		
		if(req.getParameter("nowPage") == null) {
			paging.setNowPage(1);
			
		}else {
			
			paging.setNowPage(Integer.parseInt(req.getParameter("nowPage")) );
			
		}
		
		List<BbsDto> bbslist = bbsService.bbslist(paging);
		
		
		
		model.addAttribute("bbslist", bbslist);
		model.addAttribute("paging", paging);
		return "bbslist.tiles";
	}
	
}
