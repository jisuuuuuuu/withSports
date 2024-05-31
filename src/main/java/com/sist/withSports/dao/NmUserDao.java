package com.sist.withSports.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.withSports.model.Join;
import com.sist.withSports.model.Like;
import com.sist.withSports.model.NmUser;
import com.sist.withSports.model.Prom;

@Repository("nmUserDao")
public interface NmUserDao 
{
	public NmUser nmUserSelect(String nmId);
	
	public long nmSameCheck(NmUser nmUser);
	
	public int nmInsert(NmUser nmUser);
	
	public int nmUpdate(NmUser nmUser);
	
	public int nmTaltuie(String nmId);
	
	public List<Like> myLikeList(Like like);
	
	public long myLikeListcNT(String nmId);
	
	public int promJoinInsert(Join join);
	
	public Join promJoinSelect(Join join);
	
	public List<Join> myJoinList(Join join);
	
	public long myJoinCnt(String nmId);
	
	public int promJoinCntUp(Prom prom);
	
	public int joinDelete(Join join);
	
	public int joinPaySuccess(Join join);
	
	public NmUser nmFind(String nmEmail);
	
	public int nmPwdFindIm(NmUser nmUser);
}
