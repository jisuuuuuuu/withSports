package com.sist.withSports.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.withSports.dao.CoUserDao;
import com.sist.withSports.model.CoUser;

@Service("coUserService")
public class CoUserService 
{
	private static Logger logger = LoggerFactory.getLogger(RevService.class);
	
	@Autowired
	private CoUserDao coUserDao;
	
	public CoUser coUserSelect(String coId)
	{
		CoUser coUser = null;
		
		try
		{
			coUser = coUserDao.coUserSelect(coId);
		}
		catch(Exception e)
		{
			logger.error("[CoUserService] coUserSelect Exception", e);
		}
		
		return coUser;
	}
	
	public long coSameCheck(CoUser coUser)
	{
		long count = 0;
		
		try
		{
			count = coUserDao.coSameCheck(coUser);
		}
		catch(Exception e)
		{
			logger.error("[CoUserService] coSameCheck Exception", e);
		}
		
		return count;
	}
	
	public int coInsert(CoUser coUser)
	{
		int count = 0;
		
		try
		{
			count = coUserDao.coInsert(coUser);
		}
		catch(Exception e)
		{
			logger.error("[CoUserService] coInsert Exception", e);
		}
		
		return count;
	}
}
