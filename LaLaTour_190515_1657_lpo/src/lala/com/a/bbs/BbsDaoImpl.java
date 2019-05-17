package lala.com.a.bbs;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lala.com.a.model.BbsDto;
import lala.com.a.util.pagingBean;
import lala.com.a.util.pagingUtil;

@Repository
public class BbsDaoImpl implements BbsDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Bbs.";
	
	@Override
	public List<BbsDto> bbslist(pagingBean paging) {
	
		int totalCount = sqlSession.selectOne(ns+"totalCount");
		paging.setTotalCount(totalCount);
		pagingUtil.setPagingInfo(paging);
		
		List<BbsDto> bbslist = sqlSession.selectList(ns+"bbsList", paging);
		
		
		
		return bbslist;
	}

}
