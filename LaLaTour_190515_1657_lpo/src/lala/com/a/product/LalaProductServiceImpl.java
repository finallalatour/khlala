package lala.com.a.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lala.com.a.model.CartDto;
import lala.com.a.model.FestivalDto;
import lala.com.a.model.GoodsDto;
import lala.com.a.model.OrderedDto;
import lala.com.a.model.ProductDto;
import lala.com.a.model.ReplyDto;
import lala.com.a.product.LalaProductDao;
import lala.com.a.product.LalaProductService;

@Service
public class LalaProductServiceImpl implements LalaProductService {

	@Autowired
	LalaProductDao lalaProductDao;

	//제품등록할때 축제검색
	@Override
	public List<FestivalDto> getFestivalList(String s_keyword) {
		return lalaProductDao.getFestivalList(s_keyword);
	}

	//제품등록
	@Override
	public boolean productWriteAf(ProductDto dto) {
		return lalaProductDao.productWriteAf(dto);
	}

	//파일업로드
	@Override
	public void uploadFile(FilePdsDto dto) {
		lalaProductDao.uploadFile(dto);		
	}

	//제품전체목록
	@Override
	public List<ProductDto> getProductList(PagingBean pagingBean) {
		return lalaProductDao.getProductList(pagingBean);
	}

	//디테일
	@Override
	public ProductDto productDetail(int product_seq) {
		return lalaProductDao.productDetail(product_seq);
	}

	//파일리스트
	@Override
	public List<FilePdsDto> getFileList(int seq) {
		return lalaProductDao.getFileList(seq);
	}

	//장바구니에 넣기
	@Override
	public boolean cartinsert(CartDto dto) {
		return lalaProductDao.cartinsert(dto);
	}

	@Override
	public List<CartDto> getCartList(String id) {
		// 장바구니 목록
		return lalaProductDao.getCartList(id);
	}

	@Override
	public CartDto getProductSeq(CartDto dto) {
		// 물건담을때 장바구니에 이미있는건지 확인
		return lalaProductDao.getProductSeq(dto);
	}

	@Override
	public boolean updateMyCount(CartDto dto) {
		// 수량변경 (담는데 이미있을때)
		return lalaProductDao.updateMyCount(dto);
	}

	@Override
	public CartDto getCart(int seq) {
		// 주문의 제품dto 하나씩 가져오기
		return lalaProductDao.getCart(seq);
	}

	@Override
	public int orderedInsert(OrderedDto dto) {
		// 주문결제시 주문자정보 저장
		return lalaProductDao.orderedInsert(dto);
	}

	@Override
	public boolean updateCartOseq(CartDto dto) {
		//주문결제 후 장바구니의 oseq에 주문내역 seq를 저장
		return lalaProductDao.updateCartOseq(dto);
	}

	@Override
	public void deleteFile(int seq) {
		// 파일삭제
		lalaProductDao.deleteFile(seq);
	}

	@Override
	public FestivalDto getFestivalName(int seq) {
		// 축제seq로 축제dto가져오기 (수정에 씀)
		return lalaProductDao.getFestivalName(seq);
	}

	@Override
	public boolean productUpdateAf(ProductDto dto) {
		// 제품수정
		return lalaProductDao.productUpdateAf(dto);
	}

	@Override
	public boolean updateProductPCount(int product_seq) {
		// 주문결제 후 주문된 물품수량만큼 원본물품의 재고를 수정
		
		//1. seq로 dto 뽑기
		CartDto dto = lalaProductDao.getCart(product_seq);
		System.out.println("uppc ser: " + dto.toString());
		
		//2. cart에 담긴 원본물품seq, 장바구니의 수량myCount로 product의 수량을 수정
		lalaProductDao.updateProductPCount(dto);
		
		return false;
	}

	@Override
	public boolean deleteCart(int product_seq) {
		// 장바구니 선택물품 삭제
		return lalaProductDao.deleteCart(product_seq);
	}

	@Override
	public int getProductTotalCount(PagingBean pagingBean) {
		// 제품전체목록 수 (페이징 때문에 필요)
		return lalaProductDao.getProductTotalCount(pagingBean);
	}

	@Override
	public boolean insertReply(ReplyDto dto) {
		// 댓글입력
		return lalaProductDao.insertReply(dto);
	}

	@Override
	public List<ReplyDto> getReplyList() {
		// 댓글목록
		return lalaProductDao.getReplyList();
	}

	@Override
	public List<OrderedDto> getSellList(String id) {
		// 과거 주문내역
		return lalaProductDao.getSellList(id);
	}

	@Override
	public List<OrderedDto> getOrderSList(String omid) {
		// 내역리스트 - 특정주문번호
		return lalaProductDao.getOrderSList(omid);
	}

	@Override
	public int insertGoodsAf(GoodsDto dto) {
		// 상품평 입력
		return lalaProductDao.insertGoodsAf(dto);
	}

	@Override
	public List<GoodsDto> getGoodsList(int gpseq) {
		// 상품평목록
		return lalaProductDao.getGoodsList(gpseq);
	}

	@Override
	public boolean updateCartGseq(GoodsDto dto) {
		// 상품평 입력시 cart의 gseq변경
		return lalaProductDao.updateCartGseq(dto);
	}

	@Override
	public void updateProductPH(ProductDto pdto) {
		// TODO 상품평 입력시 해당제품 총별점,사람수 변경
		lalaProductDao.updateProductPH(pdto);
	}
}























