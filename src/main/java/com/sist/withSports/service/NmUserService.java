package com.sist.withSports.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.withSports.dao.NmUserDao;
import com.sist.withSports.model.Join;
import com.sist.withSports.model.Like;
import com.sist.withSports.model.NmUser;
import com.sist.withSports.model.Prom;


@Service("nmUserService")
public class NmUserService 
{
	private static Logger logger = LoggerFactory.getLogger(RevService.class);
	
	@Autowired
	private NmUserDao nmUserDao;
	
	public NmUser nmUserSelect(String nmId)
	{
		NmUser nmUser = null;
		
		try
		{
			nmUser = nmUserDao.nmUserSelect(nmId);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] nmUserSelect Exception", e);
		}
		
		return nmUser;
	}
	
	public long nmSameCheck(NmUser nmUser)
	{
		long count = 0;
		
		try
		{
			count = nmUserDao.nmSameCheck(nmUser);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] nmSameCheck Exception", e);
		}
		
		return count;
	}
	
	public int nmInsert(NmUser nmUser)
	{
		int count = 0;
		
		try
		{
			count = nmUserDao.nmInsert(nmUser);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] nmInsert Exception", e);
		}
		
		return count;
	}
	
	public int nmUpdate(NmUser nmUser)
	{
		int count = 0;
		
		try
		{
			count = nmUserDao.nmUpdate(nmUser);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] nmUpdate Exception", e);
		}
		
		return count;
	}
	
	public int nmTaltuie(String nmId)
	{
		int count = 0;
		
		try
		{
			count = nmUserDao.nmTaltuie(nmId);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] nmTaltuie Exception", e);
		}
		
		return count;
	}
	
	public List<Like> myLikeList(Like like)
	{
		List<Like> list = null;
		
		try
		{
			list = nmUserDao.myLikeList(like);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] myLikeList Exception", e);
		}
		
		return list;
	}
	
	public long myLikeListcNT(String nmId)
	{
		long count = 0;
		
		try
		{
			count = nmUserDao.myLikeListcNT(nmId);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] myLikeListcNT Exception", e);
		}
		
		return count;
	}
	
	public int promJoinInsert(Join join)
	{
		int count = 0;
		
		try
		{
			count = nmUserDao.promJoinInsert(join);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] promJoinInsert Exception", e);
		}
		
		return count;
	}
	
	public Join promJoinSelect(Join join)
	{
		Join in = null;
		
		try
		{
			in = nmUserDao.promJoinSelect(join);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] promJoinSelect Exception", e);
		}
		
		return in;
	}
	
	public List<Join> myJoinList(Join join)
	{
		List<Join> list = null;
		
		try
		{
			list = nmUserDao.myJoinList(join);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] myJoinList Exception", e);
		}
		
		return list;
	}
	
	public long myJoinCnt(String nmId)
	{
		long count = 0;
		
		try
		{
			count = nmUserDao.myJoinCnt(nmId);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] myJoinCnt Exception", e);
		}
		
		return count;
	}
	
	public int promJoinCntUp(Prom prom)
	{
		int count = 0;
		
		try
		{
			count = nmUserDao.promJoinCntUp(prom);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] promJoinCntUp Exception", e);
		}
		
		return count;
	}
	
	public int joinDelete(Join join)
	{
		int count = 0;
		
		try
		{
			count = nmUserDao.joinDelete(join);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] joinDelete Exception", e);
		}
		
		return count;
	}
	
	public int joinPaySuccess(Join join)
	{
		int count = 0;
		
		try
		{
			count = nmUserDao.joinPaySuccess(join);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] joinPaySuccess Exception", e);
		}
		
		return count;
	}
	
	public NmUser nmFind(String nmEmail)
	{
		NmUser nmUser = null;
		
		try
		{
			nmUser = nmUserDao.nmFind(nmEmail);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] nmFind Exception", e);
		}
		
		return nmUser;
	}
	
	public int nmPwdFindIm(NmUser nmUser)
	{
		int count = 0;
		
		try
		{
			count = nmUserDao.nmPwdFindIm(nmUser);
		}
		catch(Exception e)
		{
			logger.error("[NmUserService] nmPwdFindIm Exception", e);
		}
		
		return count;
	}
}
