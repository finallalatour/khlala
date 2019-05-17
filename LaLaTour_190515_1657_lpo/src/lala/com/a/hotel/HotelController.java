package lala.com.a.hotel;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lala.com.a.model.HotelDto;
import lala.com.a.model.ReplyDto;
import lala.com.a.model.ReserveDto;
import lala.com.a.util.FUpUtil;
import lala.com.a.util.HotelUtil;
import lala.com.a.util.Singleton;


@Controller
public class HotelController {
	
	@Autowired
	HotelService hotelService;
	
	private static final Logger logger = LoggerFactory.getLogger(HotelController.class);
	
	@RequestMapping(value="hotellist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String hotellist(Model model) {
		logger.info("HotelController hotellist " + new Date() );
		
		List<HotelDto> hotelList = hotelService.getHotelList();
		
		model.addAttribute("hotelList",hotelList);
		
		System.out.println("호텔");
		
		return "hotellist.tiles";
	}
	
	@RequestMapping(value="hotelwrite.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String hotelWrite() {
		
		
		return "hotelwrite.tiles";
	}
	
	@RequestMapping(value="hotelwriteAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String hotelwriteAf(HotelDto hotel, 
			/*폼필드가 아닌애*/	@RequestParam(value="pFiles[]", required = false)MultipartFile pFiles[],
							@RequestParam(value="fileThumb", required = false)MultipartFile fileThumb,
							HttpServletRequest req) {
		
		logger.info("HotelController hotelwriteAf " + new Date());
		System.out.println("hotel : " + hotel.toString());
		for(int i = 0 ; i < pFiles.length; i++) {
			System.out.println("file : " + pFiles[i]);
		}
		System.out.println("썸네일 : " + fileThumb);
//		HotelDto 셋팅
		//톰캣 경로
		String fupload = req.getServletContext().getRealPath("/upload");
		
		String originalFileName = "";
		File file = null;
		
		originalFileName = fileThumb.getOriginalFilename();
		
		hotel.setThumbnail(originalFileName);
		file = new File(fupload +"/" + originalFileName);
		//pseq 초기화
		int pseq = 0;
		try {
//		썸네일 파일 업로드
			FileUtils.writeByteArrayToFile(file, fileThumb.getBytes());
			//db업데이트 // pds에들어갈 pseq 를 뽑아줌
			pseq = hotelService.writeHotel(hotel);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		System.out.println("경로 : " + fupload);
		
		
		PdsDto pds = new PdsDto();
		for(MultipartFile mf : pFiles) {
//			원본 파일명
			originalFileName = mf.getOriginalFilename();
			pds.setfileName_Bf(originalFileName);
//			새 파일명
			String newFileName = FUpUtil.getNewFile(originalFileName);
			pds.setfileName_Af(newFileName);
			file = new File(fupload +"/" + newFileName);
			pds.setPseq(pseq);
			System.out.println("pdsToString" + pds.toString());
			try {
				//다중파일 올림
				FileUtils.writeByteArrayToFile(file, mf.getBytes());
				
				//db 업데이트
				hotelService.uploadHotelPds(pds);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return "redirect:/hotellist.do";
	}
	
	@RequestMapping(value="hoteldetail.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String hoteldetail(Model model, int seq, String year, String month) {
		Singleton s = Singleton.getInstance();
		s.rDate.clear();
		
		System.out.println("seq : " + seq);
		
		
//		호텔정보
		HotelDto hotel = hotelService.getHotelDetail(seq);
//		사진들
		List<PdsDto> pdsList = hotelService.getHotelPds(seq);
//		sdate,edate
		List<ReserveDto> reDate = hotelService.getReserveDate(seq);
		
		System.out.println("reDate : " + reDate.size());
		
		for(ReserveDto re : reDate) {
			HotelUtil.reserveDate(re.getSdate(), re.getEdate());
		}
		
//		댓글
		List<ReplyDto> reply = hotelService.getReplyList(seq);
		
		model.addAttribute("hotel",hotel);
		model.addAttribute("pdsList",pdsList);
		
		model.addAttribute("year",year);
		model.addAttribute("month",month);

		model.addAttribute("reply",reply);
		
		return "hoteldetail.tiles";
	}
	
	@RequestMapping(value="reserve.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reserve(ReserveDto reserve,Model model) {
		System.out.println("reserve : " + reserve.toString());
		
		model.addAttribute("reserve",reserve);
		
		return "reserve.tiles";
	}
	@RequestMapping(value="reserveAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String reserveAf(ReserveDto reserve , Model model) {
		System.out.println("reserveAf.do");
		
		System.out.println("reserveAf : " + reserve.toString());
		
		boolean isS = hotelService.addHotelReserve(reserve);
		if(isS) {
			System.out.println("예약성공");
		}else {
			System.out.println("예약실패");
		}
		
		return "redirect:/hoteldetail.do?seq=" + reserve.getPseq();
	}
	@RequestMapping(value="addReply.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String addReply(ReplyDto reply) {
		
		System.out.println("reply : " + reply.toString());
		
		boolean isS = hotelService.addReply(reply);
		
		if(isS) {
			System.out.println("댓글 입력 성공");
		}else {
			System.out.println("댓글 입력 실패");
		}
		
		return "redirect:/hoteldetail.do?seq=" + reply.getPseq();
	}
	@RequestMapping(value="addRereply.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String addRereply(ReplyDto reply) {
		System.out.println("replydto : " + reply);
		
		return "";
	}
}
