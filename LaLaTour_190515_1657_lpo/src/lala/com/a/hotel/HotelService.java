package lala.com.a.hotel;

import java.util.List;

import lala.com.a.model.HotelDto;
import lala.com.a.model.ReplyDto;
import lala.com.a.model.ReserveDto;

public interface HotelService {
	public List<HotelDto> getHotelList();
	public int writeHotel(HotelDto hotel);
	public boolean uploadHotelPds(PdsDto pds);
	public HotelDto getHotelDetail(int seq);
	public List<PdsDto> getHotelPds(int pseq);
	public boolean addHotelReserve(ReserveDto reserve);
	public List<ReserveDto> getReserveDate(int pseq);
	public List<ReplyDto> getReplyList(int pseq);
	public boolean addReply(ReplyDto reply);
}
