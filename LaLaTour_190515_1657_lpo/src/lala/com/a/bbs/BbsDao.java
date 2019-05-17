package lala.com.a.bbs;

import java.util.List;

import lala.com.a.model.BbsDto;
import lala.com.a.util.pagingBean;

public interface BbsDao {
	
	public List<BbsDto> bbslist(pagingBean paging);	//리스트 가져오기

}
