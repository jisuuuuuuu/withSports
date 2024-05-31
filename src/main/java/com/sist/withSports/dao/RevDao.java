package com.sist.withSports.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.withSports.model.Rev;
import com.sist.withSports.model.RevFile;
import com.sist.withSports.model.RevReply;

@Repository("revDao")
public interface RevDao 
{
	public List<Rev> revList(Rev rev);
	
	public List<Rev> revCoList(Rev rev);
	
	public long revListCnt(Rev rev);
	
	public long revCoListCnt(String coId);
	
	public Rev revView(long revSeq);
	
	public int revInsert(Rev rev);
	
	public int revFileInsert(RevFile revFile);
	
	public RevFile revFileSelect(long revSeq);
	
	public int revReadCntUp(long revSeq);
	
	public int revFileDelete(long revSeq);
	
	public int revUpdate(Rev rev);
	
	public int revDelete(long revSeq);
	
	public Rev revSelect(long revSeq);
	
	public List<Rev> myRevList(Rev rev);
	
	public long revNmListCnt(String nmId);
	
	public int revReplyInsert(RevReply reply);
	
	public List<RevReply> revReplyList(long revSeq);
	
	public int boardGroupOrderUpdate(RevReply reply);
	
	public RevReply revReplySelect(long replySeq);
	
	public int revReplyInsert2(RevReply reply);
	
	public int revReplyUpdate(RevReply reply);
	
	public int revReplyDelete(long replySeq);
	
	public long revReplyAnswersCount(long replyParent);
}
