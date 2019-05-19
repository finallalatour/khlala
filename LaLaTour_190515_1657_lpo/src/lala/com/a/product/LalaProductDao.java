package lala.com.a.product;

import java.util.List;

import lala.com.a.model.CartDto;
import lala.com.a.model.FestivalDto;
import lala.com.a.model.GoodsDto;
import lala.com.a.model.OrderedDto;
import lala.com.a.model.ProductDto;
import lala.com.a.model.ReplyDto;

public interface LalaProductDao {

	//제품등록할때 축제검색
	public List<FestivalDto> getFestivalList(String s_keyword);
	public FestivalDto getFestivalName(int seq); //축제seq로 축제dto가져오기 (수정에 씀)
	
	//제품
	public boolean productWriteAf(ProductDto dto); //제품등록
	public boolean productUpdateAf(ProductDto dto); //제품수정
	public void uploadFile(FilePdsDto dto); //파일업로드
	public void deleteFile(int seq); //파일삭제
	
	public List<ProductDto> getProductList(PagingBean pagingBean); //제품전체목록
	public int getProductTotalCount(PagingBean pagingBean); //제품전체목록 수 (페이징 때문에 필요)
	
	//디테일
	public ProductDto productDetail(int product_seq); //제품디테일
	public List<FilePdsDto> getFileList(int product_seq); //파일리스트
	public List<GoodsDto> getGoodsList(int gpseq); //상품평목록
	
	//장바구니
	public CartDto getProductSeq(CartDto dto); //물건담을때 장바구니에 이미있는건지 확인
	public boolean updateMyCount(CartDto dto); //수량변경 (담는데 이미있을때)
	public boolean cartinsert(CartDto dto);
	public List<CartDto> getCartList(String id); //장바구니 목록
	public CartDto getCart(int cart_seq); //주문의 제품dto 하나씩 가져오기
	public boolean deleteCart(int cart_seq); //장바구니 선택물품 삭제
	
	//주문
	public int orderedInsert(OrderedDto dto); //주문결제시 주문자정보 저장
	public boolean updateCartOseq(CartDto dto); //주문결제 후 장바구니의 oseq에 주문내역 seq를 저장
	public boolean updateProductPCount(CartDto dto); //주문결제 후 주문된 물품수량만큼 원본물품의 재고를 수정
	
	//댓글
	public List<ReplyDto> getReplyList(); //댓글목록
	public boolean insertReply(ReplyDto dto); //댓글입력
	
	//과거 주문내역
	public List<OrderedDto> getSellList(String id); //내역리스트(상품평도 있음)
	public List<OrderedDto> getOrderSList(String omid); //내역리스트 - 특정주문번호
	
	//상품평
	public int insertGoodsAf(GoodsDto dto); //상품평 입력
	public boolean updateCartGseq(GoodsDto dto); //상품평 입력시 cart의 gseq변경
	public void updateProductPH(ProductDto pdto); //상품평 입력시 해당제품 총별점,사람수 변경
}














