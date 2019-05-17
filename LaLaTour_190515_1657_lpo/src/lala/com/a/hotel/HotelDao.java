package lala.com.a.hotel;

import java.util.List;

import lala.com.a.model.HotelDto;
import lala.com.a.model.ReplyDto;
import lala.com.a.model.ReserveDto;

public interface HotelDao {
//	호텔리스트
	public List<HotelDto> getHotelList();
//	글쓰기
	public int writeHotel(HotelDto hotel);
//	글쓰기 시 다중파일 업로드
	public boolean uploadHotelPds(PdsDto pds);
//	호텔 디테일
	public HotelDto getHotelDetail(int seq);
//	호텔 디테일시 불러올 다중파일
	public List<PdsDto> getHotelPds(int pseq);
//	호텔 디테일 시작/끝 날짜
	public List<ReserveDto> getReserveDate(int pseq);
//	예약하기
	public boolean addHotelReserve(ReserveDto reserve);
//	댓글리스트
	public List<ReplyDto> getReplyList(int pseq);
//	댓글 입력
	public boolean addReply(ReplyDto reply);
	
}
