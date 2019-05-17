package lala.com.a.hotel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lala.com.a.model.HotelDto;
import lala.com.a.model.ReplyDto;
import lala.com.a.model.ReserveDto;

@Service
public class HotelServiceImpl implements HotelService {

	@Autowired
	HotelDao hotelDao;

	@Override
	public List<HotelDto> getHotelList() {
		return hotelDao.getHotelList();
	}

	@Override
	public int writeHotel(HotelDto hotel) {
		return hotelDao.writeHotel(hotel);
	}

	@Override
	public boolean uploadHotelPds(PdsDto pds) {
		return hotelDao.uploadHotelPds(pds);
	}

	@Override
	public HotelDto getHotelDetail(int seq) {
		return hotelDao.getHotelDetail(seq);
	}

	@Override
	public List<PdsDto> getHotelPds(int pseq) {
		return hotelDao.getHotelPds(pseq);
	}

	@Override
	public boolean addHotelReserve(ReserveDto reserve) {
		return hotelDao.addHotelReserve(reserve);
	}

	@Override
	public List<ReserveDto> getReserveDate(int pseq) {
		return hotelDao.getReserveDate(pseq);
	}

	@Override
	public List<ReplyDto> getReplyList(int pseq) {
		return hotelDao.getReplyList(pseq);
	}

	@Override
	public boolean addReply(ReplyDto reply) {
		return hotelDao.addReply(reply);
	}
	
}
