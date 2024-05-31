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
import com.sist.withSports.dao.RevDao;
import com.sist.withSports.model.Rev;
import com.sist.withSports.model.RevFile;
import com.sist.withSports.model.RevReply;

@Service("revService")
public class RevService 
{
	private static Logger logger = LoggerFactory.getLogger(RevService.class);
	
	@Autowired
	private RevDao revDao;
	
	@Value("#{env['revUpload.save.dir']}")
	private String REVUPLOAD_SAVE_DIR;
	
	public List<Rev> revList(Rev rev)
	{
		List<Rev> list = null;
		
		try
		{
			list = revDao.revList(rev);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revList Exception", e);
		}
		
		return list;
	}
	
	public List<Rev> revCoList(Rev rev)
	{
		List<Rev> list = null;
		
		try
		{
			list = revDao.revCoList(rev);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revCoList Exception", e);
		}
		
		return list;
	}
	
	public long revListCnt(Rev rev)
	{
		long count = 0;
		
		try
		{
			count = revDao.revListCnt(rev);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revListCnt Exception", e);
		}
		
		return count;
	}
	
	public long revCoListCnt(String coId)
	{
		long count = 0;
		
		try
		{
			count = revDao.revCoListCnt(coId);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revListCnt Exception", e);
		}
		
		return count;
	}
	
	public Rev revView(long revSeq)
	{
		Rev rev = null;
		
		try
		{
			rev = revDao.revView(revSeq);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revView Exception", e);
		}
		
		return rev;
	}
	
	public int revReadCntUp(long revSeq)
	{
		int count = 0;
		
		try
		{
			count = revDao.revReadCntUp(revSeq);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revReadCntUp Exception", e);
		}
		
		return count;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int revInsert(Rev rev) throws Exception
	{
		int count = 0;
		
		count = revDao.revInsert(rev);
		
		if(count > 0 && rev.getRevFile() != null)
		{
			rev.getRevFile().setrevSeq(rev.getRevSeq());
			rev.getRevFile().setrevFileSeq(1);
			
			logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			logger.debug("rev.getRevSeq() : " + rev.getRevSeq());
			logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			
			revDao.revFileInsert(rev.getRevFile());
		}
		
		return count;
	}
	
	public RevFile revFileSelect(long revSeq)
	{
		RevFile revFile = null;
		
		try
		{
			revFile = revDao.revFileSelect(revSeq);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revFileSelect Exception", e);
		}
		
		return revFile;
	}
	
	//게시물 업데이트
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int revUpdate(Rev rev)throws Exception
	{
		int count = 0;
		
		count = revDao.revUpdate(rev);
		
		if(count > 0 && rev.getRevFile() != null)
		{
			RevFile revFile = revDao.revFileSelect(rev.getRevSeq());
			
			if(revFile != null)
			{
				if(revFileDelete(rev.getRevSeq()) > 0)
				{
					FileUtil.deleteFile(REVUPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + revFile.getrevFileName());
					
					revDao.revFileDelete(rev.getRevSeq());
				}
			}
			
			rev.getRevFile().setrevSeq(rev.getRevSeq());
			rev.getRevFile().setrevFileSeq(1);
			
			revDao.revFileInsert(rev.getRevFile());
		}
		
		return count;		
	}
	
	//게시물 첨부파일 삭제
	public int revFileDelete(long revSeq)
	{
		int count = 0;
		
		try
		{
			count = revDao.revFileDelete(revSeq);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revFileDelete Exception", e);
		}
		
		return count;
	}
	
	//게시물 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int revDelete(long revSeq)throws Exception
	{
		int count = 0;
		
		count =  revDao.revDelete(revSeq);
		
		RevFile revFile = revDao.revFileSelect(revSeq);
		
		if(revFile != null && count > 0)
		{
			if(revFileDelete(revSeq) > 0)
			{
				FileUtil.deleteFile(REVUPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + revFile.getrevFileName());
			}
		}
		
		return count;
	}
	
	//조회
	public Rev revSelect(long revSeq)
	{
		Rev rev = null;
		
		try
		{
			rev = revDao.revSelect(revSeq);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revSelect Exception", e);
		}
		
		return rev;
	}
	
	public List<Rev> myRevList(Rev rev)
	{
		List<Rev> list = null;
		
		try
		{
			list = revDao.myRevList(rev);
		}
		catch(Exception e)
		{
			logger.error("[RevService] myRevList Exception", e);
		}
		
		return list;
	}
	
	public long revNmListCnt(String nmId)
	{
		long count = 0;
		
		try
		{
			count = revDao.revNmListCnt(nmId);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revNmListCnt Exception", e);
		}
		
		return count;
	}
	
	public int revReplyInsert(RevReply reply)
	{
		int count = 0;
		
		try
		{
			count = revDao.revReplyInsert(reply);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revReplyInsert Exception", e);
		}
		
		return count;
	}
	
	public List<RevReply> revReplyList(long revSeq)
	{
		List<RevReply> list = null;
		
		try
		{
			list = revDao.revReplyList(revSeq);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revReplyList Exception", e);
		}
		
		return list;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int dereply(RevReply reply) throws Exception
	{
		int count = 0;
		
		revDao.boardGroupOrderUpdate(reply);
		count = revDao.revReplyInsert2(reply);
		
		return count;
	}
	
	public RevReply revReplySelect(long replySeq)
	{
		RevReply revReply = null;
		
		try
		{
			revReply = revDao.revReplySelect(replySeq);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revReplySelect Exception", e);
		}
		
		return revReply;
	}
	
	public int revReplyUpdate(RevReply reply)
	{
		int count = 0;
		
		try
		{
			count = revDao.revReplyUpdate(reply);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revReplyUpdate Exception", e);
		}
		
		return count;
	}
	
	public int revReplyDelete(long replySeq)
	{
		int count = 0;
		
		try
		{
			count = revDao.revReplyDelete(replySeq);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revReplyDelete Exception", e);
		}
		
		return count;
	}
	
	public long revReplyAnswersCount(long replyParent)
	{
		long count = 0;
		
		try
		{
			count = revDao.revReplyAnswersCount(replyParent);
		}
		catch(Exception e)
		{
			logger.error("[RevService] revReplyAnswersCount Exception", e);
		}
		
		return count;
	}
}
