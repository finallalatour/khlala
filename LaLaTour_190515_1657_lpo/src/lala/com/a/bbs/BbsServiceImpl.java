package lala.com.a.bbs;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lala.com.a.model.BbsDto;
import lala.com.a.util.pagingBean;

@Service
public class BbsServiceImpl implements BbsService {

	@Autowired
	BbsDao bbsDao;

	@Override
	public List<BbsDto> bbslist(pagingBean paging) {

		return bbsDao.bbslist(paging);
	}
}
