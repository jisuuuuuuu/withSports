package com.sist.withSports.model;

import java.io.Serializable;

public class Like implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long promSeq;
	private String nmId;
	private String promTitle;
	private String promCate;
	private String promCoSdate;
	private String promCoEdate;
	
	private long startRow;
	private long endRow;
	
	public Like()
	{
		promSeq = 0;
		nmId = "";
		
		promTitle = "";
		promCate = "";
		promCoSdate = "";
		promCoEdate = "";
		
		startRow = 0;
		endRow = 0;
	}

	public long getPromSeq() {
		return promSeq;
	}

	public void setPromSeq(long promSeq) {
		this.promSeq = promSeq;
	}

	public String getNmId() {
		return nmId;
	}

	public void setNmId(String nmId) {
		this.nmId = nmId;
	}

	public String getPromTitle() {
		return promTitle;
	}

	public void setPromTitle(String promTitle) {
		this.promTitle = promTitle;
	}

	public String getPromCate() {
		return promCate;
	}

	public void setPromCate(String promCate) {
		this.promCate = promCate;
	}

	public String getPromCoSdate() {
		return promCoSdate;
	}

	public void setPromCoSdate(String promCoSdate) {
		this.promCoSdate = promCoSdate;
	}

	public String getPromCoEdate() {
		return promCoEdate;
	}

	public void setPromCoEdate(String promCoEdate) {
		this.promCoEdate = promCoEdate;
	}

	public long getStartRow() {
		return startRow;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}
}