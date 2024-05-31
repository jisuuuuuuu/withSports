package com.sist.withSports.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.withSports.model.Like;
import com.sist.withSports.model.Prom;
import com.sist.withSports.model.PromFile;

@Repository("promDao")
public interface PromDao
{
	public int promInsert(Prom prom);
	
	public int promFileInsert(PromFile promFile);
	
	public List<Prom> promList(Prom prom);
	
	public long promListCnt(Prom prom);
	
	public PromFile promFileSelect(long promSeq);
	
	public Prom promView(long promSeq);
	
	public int promUpdate(Prom prom);
	
	public int promFileDelete(long promSeq);
	
	public int promReadCntUp(long promSeq);
	
	public int promLikeInsert(Like like);
	
	public int promLikeCntUp(Prom prom);
	
	public Like promLikeSelect(Like like);
	
	public int promLikeDelete(Like like);
	
	public List<Prom> promLikeList(int prom);
	
	public List<Prom> promReadList(int prom);
	
	public List<Prom> promLeastList(int prom);
	
	public List<Prom> myCoPromList(Prom prom);
	
	public long myCoPromListCnt(String coId);
}