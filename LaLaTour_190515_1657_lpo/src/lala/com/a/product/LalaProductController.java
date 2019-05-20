package lala.com.a.product;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import lala.com.a.model.GoodsDto;
import lala.com.a.model.MemberDto;
import lala.com.a.model.OrderedDto;
import lala.com.a.model.ProductDto;
import lala.com.a.model.ReplyDto;
import lala.com.a.util.FUpUtil;

@Controller
public class LalaProductController {

	Logger logger = LoggerFactory.getLogger(LalaProductController.class);
	
	@Autowired
	LalaProductService lalaProductService;
	
	/*@RequestMapping(value="productlist.do", method=RequestMethod.GET)
	public String productlist(Model model) {
		logger.info("LalaProductController productlist " + new Date());
		
		List<ProductDto> list = lalaProductService.getProductList();
		model.addAttribute("list", list);
		
		return "productlist.tiles";
	}*/
	
	@RequestMapping(value="productlist.do", method=RequestMethod.GET)
	public String productlist(PagingBean pagingBean, Model model) {
		logger.info("LalaProductController productlist " + new Date());
		
		System.out.println("dto: " + pagingBean.toString());
		//현재페이지가 노세팅이면 1로 세팅
		if(pagingBean.getNowPage()==0) {
			pagingBean.setNowPage(1);
		}
		
		//totalCount 세팅 (총갯수)
		pagingBean.setTotalCount( lalaProductService.getProductTotalCount(pagingBean) );
		pagingBean = PagingUtil.setPagingInfo(pagingBean);		
		
		List<ProductDto> list = lalaProductService.getProductList(pagingBean);
		model.addAttribute("list", list);
		model.addAttribute("paging", pagingBean);
		
		return "productlist.tiles";
	}
	
	@RequestMapping(value="productwrite.do", method=RequestMethod.GET)
	public String productwrite() {
		logger.info("LalaProductController productwrite " + new Date());
		
		return "productwrite.tiles";
	}
	
	@RequestMapping(value="productUpdate.do", method=RequestMethod.GET)
	public String productUpdate(int product_seq, Model model) {
		logger.info("LalaProductController productUpdate " + new Date());
		
		ProductDto dto = lalaProductService.productDetail(product_seq);
		model.addAttribute("product", dto);
		System.out.println("dto: " + dto.toString());
		
		/*FestivalDto fesDto = new FestivalDto();
		if(dto.getFseq()!=0) {
			fesDto = lalaProductService.getFestivalName(dto.getFseq());			
		}*/
		
		/*if(!fesDto.getTitle().equals("") && fesDto.getTitle()!=null) {
			model.addAttribute("fName", dto.getFseq()==0? fesDto:"");
		}*/
		model.addAttribute("fName", dto.getFseq()==0? new FestivalDto():lalaProductService.getFestivalName(dto.getFseq()));

		List<FilePdsDto> flist = lalaProductService.getFileList(product_seq);
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
			ProductDto pdto, 
			FilePdsDto fdto,
			@RequestParam(value="filethumbnail",required=false)MultipartFile filethumbnail,
			@RequestParam(value="fileload",required=false)MultipartFile[] fileload,
			HttpServletRequest req) {
		logger.info("LalaProductController productwriteaf " + new Date());
		System.out.println("product dto: " + pdto.toString());
		
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
		int i=0;
		for (MultipartFile mf : fileload) {
			System.out.println((++i) + "번째 파일 업로드");
			if(mf==null || mf.isEmpty()) {
				continue;
			}
			
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
				dto.setTname("PRODUCT");
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
	
	//이거 안쓰는거 같음. 에러안나면 안쓰는거겠지..
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
		model.addAttribute("seq", dto.getProduct_seq());
		
		return "downloadView";
	}
	
	@RequestMapping(value="productdetail.do", method=RequestMethod.GET)
	public String productdetail(int product_seq, Model model) {
		logger.info("LalaProductController productdetail " + new Date());
		
		System.out.println("con productdetail start: " + product_seq);
		
		ProductDto product = lalaProductService.productDetail(product_seq);
		List<FilePdsDto> fileList = lalaProductService.getFileList(product_seq);
		//List<ReplyDto> replyList = lalaProductService.getReplyList();
		List<GoodsDto> goodsList = lalaProductService.getGoodsList(product_seq);
		
		model.addAttribute("product", product);
		model.addAttribute("fileList", fileList);
		//model.addAttribute("replyList", replyList);
		model.addAttribute("goodsList", goodsList);
		
		return "productdetail.tiles";
	}
	
	//장바구니 담기
	@RequestMapping(value="cartinsert.do", method=RequestMethod.POST)
	public String cartinsert(CartDto dto) {
		logger.info("LalaProductController cartinsert " + new Date());
		
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
	
	//장바구니 리스트
	@RequestMapping(value="cartlist.do", method=RequestMethod.GET)
	public String cartlist(CartDto dto, Model model, HttpServletRequest req) {
		logger.info("LalaProductController cartlist " + new Date());
		
		HttpSession session = req.getSession(false);
		MemberDto member = (MemberDto)session.getAttribute("login");
		
		//1. 일단 리스트들 받아온다.
		List<CartDto> clist = lalaProductService.getCartList(member.getId());
		
		//2. 하나씩 보면서 재고와 장바구니 수량을 보고 장바구니가 많으면 재고로 맞춰서 수정해준다.
		for (CartDto cart : clist) {
			//장바구니수량이 재고수량보다 많으면
			if(cart.getMyCount() > cart.getPcount()) {
				//장바구니수량을 재고수량으로 놓고 수정하기
				cart.setMyCount( cart.getPcount() );
				lalaProductService.updateMyCount(dto);
				//이러면 아마 디비에는 수정이 되고, 모델에는 여기서 바뀐대로 들어가지 않을까?
			}
		}
		
		model.addAttribute("clist", clist);
		
		return "cartlist.tiles";
	}
	
	//주문물품 리스트
	@RequestMapping(value="orderedlist.do", method=RequestMethod.POST)
	//public String orderlist(CartDto[] dto) {
	public String orderedlist(int[] chk_order, int[] hcount, Model model) {
		logger.info("LalaProductController orderedlist " + new Date());
		
		System.out.println("length: " + chk_order.length);
		
		List<CartDto> olist = new ArrayList<>();
		
		for(int i=0; i<chk_order.length; i++) {
			System.out.println("seq: " + chk_order[i] + ", count: " + hcount[i]);
			CartDto dto = new CartDto();
			dto.setCart_seq(chk_order[i]);
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
		
		System.out.println("after dto: " + dto.toString());
		
		//주문내역 저장 후 해당 seq 받아옴
		int ordered_seq = lalaProductService.orderedInsert(dto);
		
		return ordered_seq;
	}
	
	//주문결제히면 물품을 장바구니에서 주문내역으로 변경 (oseq 변경) seq장바구니물품의 oseq를 inseq로 변경?? 맞나?
	@RequestMapping(value="changecart.do", method=RequestMethod.POST)
	public String changecart(int inseq , String merchant_uid, String[] seq) {
		logger.info("LalaProductController changecart " + new Date());
		
		System.out.println("inseq: " + inseq);
		System.out.println("merchant_uid: " + merchant_uid);
		for (String cc : seq) {
			CartDto dto = new CartDto();
			int sseq = Integer.parseInt(cc);
			dto.setCart_seq(sseq);
			dto.setOseq(inseq);
			lalaProductService.updateCartOseq(dto);
			
			//////////////////////////////////////
			lalaProductService.updateProductPCount(sseq);
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
		System.out.println("controller: " + filethumbnail.getOriginalFilename());
		
		System.out.println(dto.toString());
		if(delseq!=null) {
			for(int i=0; i<delseq.length; i++) {
				//System.out.println(i + ": " + delseq[i]);
				
				//1. 삭제한 파일들 지우기
				lalaProductService.deleteFile(delseq[i]);			
			}
		}
		
		String fupload = req.getServletContext().getRealPath("/upload");
		//서버에 파일업로드
		//2. 썸네일(바꼈을때 재업로드), 디비에 파일명 변경은 다음부분에서...
		if(!filethumbnail.isEmpty() && !filethumbnail.getOriginalFilename().equals("")) {
			dto.setThumbNail(filethumbnail.getOriginalFilename());
			System.out.println("inininininininin");
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
			
			if(mf==null || mf.isEmpty()) {
				continue;
			}
			
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
		//dto.setThumbNail(filethumbnail.getOriginalFilename());
		lalaProductService.productUpdateAf(dto);
		
		return "redirect:/productdetail.do?product_seq="+dto.getProduct_seq();
	}
	
	@RequestMapping(value="cartDelete.do", method=RequestMethod.GET)
	public String cartDelete(int cart_seq, String id, HttpServletRequest req) {
		logger.info("LalaProductController productUpdateAf " + new Date());
		
		//String id = ((MemberDto)req.getSession(false).getAttribute("login")).getId();
		
		//System.out.println("id: " + id);
		HttpSession session = req.getSession(false);
		MemberDto dto = (MemberDto)session.getAttribute("login");
		lalaProductService.deleteCart(cart_seq);
		
		return "redirect:/cartlist.do?id="+dto.getId();
	}
	
	@RequestMapping(value="insertReply.do", method=RequestMethod.POST)
	public String insertReply(ReplyDto dto) {
		logger.info("LalaProductController replyInsert " + new Date());
		
		System.out.println("c rdto: " + dto.toString());
		boolean isS = lalaProductService.insertReply(dto);
		
		return "redirect:/productdetail.do?product_seq="+dto.getPseq();
	}
	
	//과거주문내역 (상품평도 있음)
	@RequestMapping(value="sellList.do", method=RequestMethod.GET)
	public String sellList(HttpServletRequest req, Model model ) {
		logger.info("LalaProductController replyInsert " + new Date());
		
		HttpSession session = req.getSession(false);
		MemberDto login = (MemberDto)session.getAttribute("login");
		//System.out.println("con login: " + login.toString());
		
		List<OrderedDto> selllist = lalaProductService.getSellList(login.getId());
		System.out.println("selllist dto[0]: " + selllist.get(0).toString());
		model.addAttribute("selllist", selllist);
		
		return "selllist.tiles";
	}
	
	//과거주문내역 - 특정주문번호
	@RequestMapping(value="getOrderSList.do", method=RequestMethod.GET)
	public String getOrderSList(String omid, Model model) {
		logger.info("LalaProductController getOrderSList " + new Date());
		
		List<OrderedDto> oslist = lalaProductService.getOrderSList(omid);
		model.addAttribute("oslist", oslist);
		
		return "oslist.tiles";
	}
	
	@RequestMapping(value="deleteCart.do", method=RequestMethod.POST)
	public String deleteCart(int[] chk_order, HttpServletRequest req) {
		logger.info("LalaProductController deleteCart " + new Date());
		
		String id = ((MemberDto)req.getSession(false).getAttribute("login")).getId();
		
		for (int cart_seq : chk_order) {
			lalaProductService.deleteCart(cart_seq);
		}
		
		return "redirect:/cartlist.do";
	}
	
	//상품평 입력창으로 이동
	@RequestMapping(value="insertGoods.do", method=RequestMethod.GET)
	public String insertGoods(int cart_seq, int product_seq, Model model) {
		logger.info("LalaProductController insertGoods " + new Date());
		
		ProductDto dto = lalaProductService.productDetail(product_seq);
		model.addAttribute("product", dto);
		model.addAttribute("cart_seq", cart_seq);
		System.out.println("con insertgoods cartseq: " + cart_seq);
		return "insertgoods.tiles";
	}
	
	//상품평 입력작업 후 해당 제품페이지로 이동
	@RequestMapping(value="insertGoodsAf.do", method=RequestMethod.POST)
	public String insertGoodsAf(
			GoodsDto dto,
			@RequestParam(value="fileload",required=false)MultipartFile fileload,
			HttpServletRequest req) {
		logger.info("LalaProductController insertGoodsAf " + new Date());
		
		//System.out.println("con iga dto: " + dto.toString());
		//상품평 입력하고 dto에 해당 seq를 등록
		dto.setPictures(fileload.getOriginalFilename());
		int goods_seq = lalaProductService.insertGoodsAf(dto);
		dto.setGoods_seq(goods_seq);
		
		System.out.println("업데잍트cartgseq전: " + dto.toString());
		lalaProductService.updateCartGseq(dto);
		
		//해당 상품평의 제품디테일을 불러와서 총점과 사람수 반영해서 제품정보 수정
		ProductDto pdto = lalaProductService.productDetail(dto.getGpseq());
		pdto.setPpoint( pdto.getPpoint() + dto.getGpoint() );
		pdto.setHcount( pdto.getHcount()+1 );
		
		lalaProductService.updateProductPH(pdto);
		
		//파일 시작
		//upload 경로 (톰캣)
		String fupload = req.getServletContext().getRealPath("/upload");
		
		File file = new File(fupload+"/"+fileload.getOriginalFilename());
		
		try {
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/productdetail.do?product_seq="+dto.getGpseq();
	}
}























