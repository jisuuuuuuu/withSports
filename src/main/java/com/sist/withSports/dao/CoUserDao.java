package com.sist.withSports.dao;

import org.springframework.stereotype.Repository;

import com.sist.withSports.model.CoUser;

@Repository("coUserDao")
public interface CoUserDao 
{
	public CoUser coUserSelect(String coId);
	
	public long coSameCheck(CoUser coUser);
	
	public int coInsert(CoUser coUser);
}
