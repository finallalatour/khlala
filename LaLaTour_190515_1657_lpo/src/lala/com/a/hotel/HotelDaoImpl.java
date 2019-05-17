package lala.com.a.hotel;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lala.com.a.model.HotelDto;
import lala.com.a.model.ReplyDto;
import lala.com.a.model.ReserveDto;

@Repository
public class HotelDaoImpl implements HotelDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Hotel.";

	@Override
	public List<HotelDto> getHotelList() {
		return sqlSession.selectList(ns+"getHotelList");
	}

	@Override
	public int writeHotel(HotelDto hotel) {
		sqlSession.insert(ns+"writeHotel",hotel);
		int pseq = hotel.getSeq();
		System.out.println("다오 seq : " + pseq);
		return pseq;
	}

	@Override
	public boolean uploadHotelPds(PdsDto pds) {
		int n = sqlSession.insert(ns+"uploadHotelPds",pds);
		return n>0?true:false;
	}

	@Override
	public HotelDto getHotelDetail(int seq) {
		return sqlSession.selectOne(ns+"getHotelDetail",seq);
	}

	@Override
	public List<PdsDto> getHotelPds(int pseq) {
		return sqlSession.selectList(ns+"getHotelPds",pseq);
	}

	@Override
	public boolean addHotelReserve(ReserveDto reserve) {
		int n = sqlSession.insert(ns+"addHotelReserve",reserve);
		return n>0?true:false;
	}

	@Override
	public List<ReserveDto> getReserveDate(int pseq) {
		return sqlSession.selectList(ns+"getReserveDate",pseq);
	}

	@Override
	public List<ReplyDto> getReplyList(int pseq) {
		return sqlSession.selectList(ns+"getReplyList",pseq);
	}

	@Override
	public boolean addReply(ReplyDto reply) {
		int n = sqlSession.insert(ns+"addReply",reply);
		return n > 0?true:false;
	}
	
	
}
