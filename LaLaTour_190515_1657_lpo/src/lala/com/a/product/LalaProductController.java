package lala.com.a.product;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lala.com.a.model.CartDto;
import lala.com.a.model.FestivalDto;
import lala.com.a.model.OrderedDto;
import lala.com.a.model.ProductDto;
import lala.com.a.util.FUpUtil;

@Controller
public class LalaProductController {

	Logger logger = LoggerFactory.getLogger(LalaProductController.class);
	
	@Autowired
	LalaProductService lalaProductService;
	
	@RequestMapping(value="productlist.do", method=RequestMethod.GET)
	public String productlist(Model model) {
		logger.info("LalaProductController productlist " + new Date());
		
		List<ProductDto> list = lalaProductService.getProductList();
		model.addAttribute("list", list);
		
		return "productlist.tiles";
	}
	
	@RequestMapping(value="productwrite.do", method=RequestMethod.GET)
	public String productwrite() {
		logger.info("LalaProductController productwrite " + new Date());
		
		return "productwrite.tiles";
	}
	
	@RequestMapping(value="productUpdate.do", method=RequestMethod.GET)
	public String productUpdate(int seq, Model model) {
		logger.info("LalaProductController productUpdate " + new Date());
		
		ProductDto dto = lalaProductService.productDetail(seq);
		model.addAttribute("product", dto);
		
		/*FestivalDto fesDto = new FestivalDto();
		if(dto.getFseq()!=0) {
			fesDto = lalaProductService.getFestivalName(dto.getFseq());			
		}*/
		
		/*if(!fesDto.getTitle().equals("") && fesDto.getTitle()!=null) {
			model.addAttribute("fName", dto.getFseq()==0? fesDto:"");
		}*/
		model.addAttribute("fName", dto.getFseq()==0? "":lalaProductService.getFestivalName(dto.getFseq()));

		List<FilePdsDto> flist = lalaProductService.getFileList(seq);
		model.addAttribute("fileList", flist);
		
		return "productupdate.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value="getFestivalList.do", method=RequestMethod.GET)
	public Map<String, Object> getFestivalList(String s_keyword) {
		logger.info("LalaProductController getFestivalList " + new Date());
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<FestivalDto> flist = lalaProductService.getFestivalList(s_keyword);
		
		map.put("list", flist);
		
		return map;
	}
	
	@RequestMapping(value="productwriteaf.do", method=RequestMethod.POST)
	public String productwriteaf(
			ProductDto pdto, FilePdsDto fdto,
			@RequestParam(value="filethumbnail",required=false)MultipartFile filethumbnail,
			@RequestParam(value="fileload",required=false)MultipartFile[] fileload,
			HttpServletRequest req) {
		logger.info("LalaProductController productwriteaf " + new Date());
		System.out.println("product dto: " + pdto.toString());
		System.out.println("fileload[0]: " + fileload[0].getOriginalFilename());
		
		//String[] filename = new String[fileload.length];
		
		//filename 취득
		/*for(int i=0; i<fileload.length; i++) {
			filename[i] = fileload[i].getOriginalFilename();
		}*/
		
		pdto.setThumbNail(filethumbnail.getOriginalFilename());
		lalaProductService.productWriteAf(pdto);
		
		//upload 경로 (톰캣)
		String fupload = req.getServletContext().getRealPath("/upload");
		File file = new File(fupload + "/" + filethumbnail.getOriginalFilename());
				
		try {
			FileUtils.writeByteArrayToFile(file, filethumbnail.getBytes());
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//나머지 다중파일들 업로드
		for (MultipartFile mf : fileload) {
			String filename = mf.getOriginalFilename();
			String newfilename = FUpUtil.getNewFile(filename);
			
			file = new File(fupload+"/"+newfilename);
			System.out.println("upload 파일경로: " + fupload+"/"+newfilename);
			
			//org.apache.commons.io.FileUtils
			//실질적으로 파일을 기입해주는 부분(물리적으로?)
			//FileUtils.writeByteArrayToFile(file, fileload.getBytes());
			try {
				FileUtils.writeByteArrayToFile(file, mf.getBytes());
				
				//db에 저장
				//khPdsService.uploadPds(pdsdto);
				FilePdsDto dto = new FilePdsDto();
				dto.setFileNameBf(filename);
				dto.setFileNameAf(newfilename);
				lalaProductService.uploadFile(dto);
				//khPdsService.uploadFileMulti(dto);
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		/*
		//파일시스템
		//String fupload = "d:\\tmp";
		
		//파일명.xxx -> 1223123.xxx
		//String f = pdsdto.getFilename();
		//String f = fileload[i].getOriginalFilename();
		String newfilename = FUpUtil.getNewFile(filename[i]);
		
		File file = new File(fupload + "/" + newfilename);
		System.out.println("upload 파일경로: " + fupload + "/" + newfilename);
	
		try {
			//org.apache.commons.io.FileUtils
			//실질적으로 파일을 기입해주는 부분(물리적으로?)
			//FileUtils.writeByteArrayToFile(file, fileload.getBytes());
			FileUtils.writeByteArrayToFile(file, fileload[i].getBytes());
			
			//db에 저장
			FilePdsDto dto = new FilePdsDto();
			dto.setFilenamebf(filename[i]);
			dto.setFilenameaf(newfilename);
			lalaProductService.uploadFile(dto);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		return "redirect:/productlist.do";
	}
	
	@RequestMapping(value="thumbNailDownload.do", method=RequestMethod.GET)
	public String thumbNailDownload(ProductDto dto, HttpServletRequest req, Model model) {
		logger.info("LalaProductController thumnNailDownload " + new Date());
		
		//download 경로 1,2
		//1.톰캣
		//D:\springSample\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\190428_SampleAll_homecalnono/upload
		String fupload = req.getServletContext().getRealPath("/upload");
		
		File downloadFile = new File(fupload + "/" + dto.getThumbNail());
		model.addAttribute("downloadFile", downloadFile);
		model.addAttribute("thumbNail", dto.getThumbNail());
		model.addAttribute("seq", dto.getSeq());
		
		return "downloadView";
	}
	
	@RequestMapping(value="productdetail.do", method=RequestMethod.GET)
	public String productdetail(int seq, Model model) {
		logger.info("LalaProductController productdetail " + new Date());
		
		ProductDto product = lalaProductService.productDetail(seq);
		List<FilePdsDto> fileList = lalaProductService.getFileList(seq);
		
		model.addAttribute("product", product);
		model.addAttribute("fileList", fileList);
		
		return "productdetail.tiles";
	}
	
	@RequestMapping(value="cartinsert.do", method=RequestMethod.POST)
	public String cartinsert(CartDto dto) {
		logger.info("LalaProductController cartinsert " + new Date());
		System.out.println(dto.toString());
		
		//장바구니에 있는지 확인
		CartDto cdto = lalaProductService.getProductSeq(dto);
		if(cdto==null) {
			System.out.println("있냐?: 널임");
		}
		else {
			System.out.println("있냐?: " + cdto.toString());
		}
		
		//없으면,
		if(cdto==null) {
			//장바구니에 담기
			boolean isS = lalaProductService.cartinsert(dto);
		}
		//있으면,
		else {
			//수량만 변경을 해줘야 한다. cdto에 기존정보가 담겨있다.
			//cdto에 mycount에 값을 수정해서 담고 변경하자. 귀찮다.
			cdto.setMyCount( cdto.getMyCount()+dto.getMyCount() );
			lalaProductService.updateMyCount(cdto);
		}
		
		return "redirect:/cartlist.do?id="+dto.getId();
	}
	
	@RequestMapping(value="cartlist.do", method=RequestMethod.GET)
	public String cartlist(CartDto dto, Model model) {
		logger.info("LalaProductController cartlist " + new Date());
		
		List<CartDto> clist = lalaProductService.getCartList(dto);
		model.addAttribute("clist", clist);
		
		return "cartlist.tiles";
	}
	
	@RequestMapping(value="orderedlist.do", method=RequestMethod.POST)
	//public String orderlist(CartDto[] dto) {
	public String orderedlist(int[] chk_order, int[] hcount, Model model) {
		logger.info("LalaProductController orderedlist " + new Date());
		
		System.out.println("length: " + chk_order.length);
		
		List<CartDto> olist = new ArrayList<>();
		
		for(int i=0; i<chk_order.length; i++) {
			System.out.println("seq: " + chk_order[i] + ", count: " + hcount[i]);
			CartDto dto = new CartDto();
			dto.setSeq(chk_order[i]);
			dto.setMyCount(hcount[i]);
			
			System.out.println(i + ": " + dto.toString());
			
			lalaProductService.updateMyCount(dto);
			CartDto newdto = lalaProductService.getCart(chk_order[i]);
			olist.add(newdto);
		}
		
		model.addAttribute("olist", olist);
		
		return "orderedlist.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value="orderedinsert.do", method=RequestMethod.POST)
	public int orderedinsert(OrderedDto dto) {
		logger.info("LalaProductController orderedinsert " + new Date());
		
		//주문내역 저장 후 해당 seq 받아옴
		int seq = lalaProductService.orderedInsert(dto);
		
		return seq;
	}
	
	@RequestMapping(value="changecart.do", method=RequestMethod.POST)
	public String changecart(int inseq, String[] seq) {
		logger.info("LalaProductController changecart " + new Date());
		
		System.out.println("inseq: " + inseq);
		for (String cc : seq) {
			CartDto dto = new CartDto();
			int sseq = Integer.parseInt(cc);
			dto.setSeq(sseq);
			dto.setOseq(inseq);
			lalaProductService.updateCartOseq(dto);
		}
		
		return "redirect:/productlist.do";
	}
	
	//제품수정
	@RequestMapping(value="productUpdateAf.do", method=RequestMethod.POST)
	public String productUpdateAf(
			ProductDto dto, int[] delseq,
			@RequestParam(value="filethumbnail",required=false)MultipartFile filethumbnail,
			@RequestParam(value="fileload",required=false)MultipartFile[] fileload,
			HttpServletRequest req) {
		logger.info("LalaProductController productUpdateAf " + new Date());
		
		System.out.println(dto.toString());
		for(int i=0; i<delseq.length; i++) {
			//System.out.println(i + ": " + delseq[i]);
			
			//1. 삭제한 파일들 지우기
			lalaProductService.deleteFile(delseq[i]);			
		}
		
		String fupload = req.getServletContext().getRealPath("/upload");
		//서버에 파일업로드
		//2. 썸네일(바꼈을때 재업로드), 디비에 파일명 변경은 다음부분에서...
		if(!filethumbnail.isEmpty() && !filethumbnail.getOriginalFilename().equals("")) {
			//dto.setThumbNail(filethumbnail.getOriginalFilename());
			
			//upload 경로 (톰캣)
			//String fupload = req.getServletContext().getRealPath("/upload");
			File file = new File(fupload + "/" + filethumbnail.getOriginalFilename());
					
			try {
				FileUtils.writeByteArrayToFile(file, filethumbnail.getBytes());
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//서버에 파일업로드
		//3. 다중파일(새로 추가된 파일들), fildpds 테이블에 입력하면서 같이업로드
		File file = null;
		for (MultipartFile mf : fileload) {
			String filename = mf.getOriginalFilename();
			String newfilename = FUpUtil.getNewFile(filename);
			
			file = new File(fupload+"/"+newfilename);
			System.out.println("upload 파일경로: " + fupload+"/"+newfilename);
			
			//org.apache.commons.io.FileUtils
			try {
				FileUtils.writeByteArrayToFile(file, mf.getBytes());
				
				//db에 저장
				FilePdsDto fpdto = new FilePdsDto();
				fpdto.setFileNameBf(filename);
				fpdto.setFileNameAf(newfilename);
				lalaProductService.uploadFile(fpdto);
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//4. 내용들 수정하기
		dto.setThumbNail(filethumbnail.getOriginalFilename());
		lalaProductService.productUpdateAf(dto);
		
		return "redirect:/productdetail.do?seq="+dto.getSeq();
	}
}
























