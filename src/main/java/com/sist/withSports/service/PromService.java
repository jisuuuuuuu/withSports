package com.sist.withSports.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.common.util.FileUtil;
import com.sist.withSports.dao.PromDao;
import com.sist.withSports.model.Like;
import com.sist.withSports.model.Prom;
import com.sist.withSports.model.PromFile;

@Service("promService")
public class PromService
{
	private static Logger logger = LoggerFactory.getLogger(RevService.class);
	
	@Autowired
	private PromDao promDao;
	
	@Value("#{env['promUpload.save.dir']}")
	private String PROMUPLOAD_SAVE_DIR;
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int promInsert(Prom prom) throws Exception
	{
		int count = 0;
		
		count = promDao.promInsert(prom);
		
		if(count > 0 && prom.getPromFile() != null)
		{
			prom.getPromFile().setPromSeq(prom.getPromSeq());
			prom.getPromFile().setPromFileSeq(1);
			
			promDao.promFileInsert(prom.getPromFile());
		}
		
		return count;
	}
	
	public List<Prom> promList(Prom prom)
	{
		List<Prom> list = null;
		
		try
		{
			list = promDao.promList(prom);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promList Exception", e);
		}
		
		return list;
	}
	
	public long promListCnt(Prom prom)
	{
		long count = 0;
		
		try
		{
			count = promDao.promListCnt(prom);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promListCnt Exception", e);
		}
		
		return count;
	}
	
	public PromFile promFileSelect(long promSeq)
	{
		PromFile promFile = null;
		
		try
		{
			promFile = promDao.promFileSelect(promSeq);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promFileSelect Exception", e);
		}
		
		return promFile;
	}
	
	public Prom promView(long promSeq)
	{
		Prom prom = null;
		
		try
		{
			prom = promDao.promView(promSeq);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promView Exception", e);
		}
		
		return prom;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int promUpdate(Prom prom) throws Exception
	{
		int count = 0;
		
		count = promDao.promUpdate(prom);
		
		if(count > 0 && prom.getPromFile() != null)
		{
			PromFile promFile = promDao.promFileSelect(prom.getPromSeq());
			
			if(promFile != null)
			{
				if(promFileDelete(prom.getPromSeq()) > 0)
				{
					FileUtil.deleteFile(PROMUPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + promFile.getPromFileName());
					
					promDao.promFileDelete(prom.getPromSeq());
				}
			}
			
			prom.getPromFile().setPromSeq(prom.getPromSeq());
			prom.getPromFile().setPromFileSeq(1);
			
			promDao.promFileInsert(prom.getPromFile());
		}
		
		return count;
	}
	
	public int promFileDelete(long promSeq)
	{
		int count = 0;
		
		try
		{
			count = promDao.promFileDelete(promSeq);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promFileDelete Exception", e);
		}
		
		return count;
	}
	
	public int promReadCntUp(long promSeq)
	{
		int count = 0;
		
		try
		{
			count = promDao.promReadCntUp(promSeq);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promReadCntUp Exception", e);
		}
		
		return count;
	}
	
	public int promLikeInsert(Like like)
	{
		int count = 0;
		
		try
		{
			count = promDao.promLikeInsert(like);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promLikeInsert Exception", e);
		}
		
		return count;
	}
	
	public int promLikeCntUp(Prom prom)
	{
		int count = 0;
		
		try
		{
			count = promDao.promLikeCntUp(prom);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promLikeCntUp Exception", e);
		}
		
		return count;
	}
	
	public Like promLikeSelect(Like like)
	{
		Like ekil = null;
		
		try
		{
			ekil = promDao.promLikeSelect(like);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promLikeSelect Exception", e);
		}
		
		return ekil;
	}
	
	public int promLikeDelete(Like like)
	{
		int count = 0;
		
		try
		{
			count = promDao.promLikeDelete(like);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promLikeInsert Exception", e);
		}
		
		return count;
	}
	
	public List<Prom> promLikeList(int prom)
	{
		List<Prom> list = null;
		
		try
		{
			list = promDao.promLikeList(prom);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promList Exception", e);
		}
		
		return list;
	}
	
	public List<Prom> promReadList(int prom)
	{
		List<Prom> list = null;
		
		try
		{
			list = promDao.promReadList(prom);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promList Exception", e);
		}
		
		return list;
	}
	
	public List<Prom> promLeastList(int prom)
	{
		List<Prom> list = null;
		
		try
		{
			list = promDao.promLeastList(prom);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promList Exception", e);
		}
		
		return list;
	}
	
	public List<Prom> myCoPromList(Prom prom)
	{
		List<Prom> list = null;
		
		try
		{
			list = promDao.myCoPromList(prom);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promList Exception", e);
		}
		
		return list;
	}
	
	public long myCoPromListCnt(String coId)
	{
		long count = 0;
		
		try
		{
			count = promDao.myCoPromListCnt(coId);
		}
		catch(Exception e)
		{
			logger.error("[PromService] promListCnt Exception", e);
		}
		
		return count;
	}
}
