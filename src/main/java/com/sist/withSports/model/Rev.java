package com.sist.withSports.model;

import java.io.Serializable;

public class Rev implements Serializable
{
	private static final long serialVersionUID = 1L;

	private long revSeq;
	private String revTitle;
	private String revContent;
	private String nmId;
	private long revReadCnt;
	private String revRegDate;
	
	private String nmName;
	private String nmNickname;
	
	private String coId;
	private String coName;
	
	private String searchType;
	private String searchValue;
	
	private long startRow;
	private long endRow;
	
	private RevFile revFile;
	
	public Rev()
	{
		revSeq = 0;
		revTitle = "";
		revContent = "";
		nmId = "";
		revReadCnt = 0;
		revRegDate = "";
		
		nmName = "";
		nmNickname = "";
		
		coId = "";
		coName = "";
		
		searchType = "";
		searchValue = "";
		
		startRow = 0;
		endRow = 0;
		
		revFile = null;
	}

	public long getRevSeq() {
		return revSeq;
	}

	public void setRevSeq(long revSeq) {
		this.revSeq = revSeq;
	}

	public String getRevTitle() {
		return revTitle;
	}

	public void setRevTitle(String revTitle) {
		this.revTitle = revTitle;
	}

	public String getRevContent() {
		return revContent;
	}

	public void setRevContent(String revContent) {
		this.revContent = revContent;
	}

	public String getNmId() {
		return nmId;
	}

	public void setNmId(String nmId) {
		this.nmId = nmId;
	}

	public long getRevReadCnt() {
		return revReadCnt;
	}

	public void setRevReadCnt(long revReadCnt) {
		this.revReadCnt = revReadCnt;
	}

	public String getRevRegDate() {
		return revRegDate;
	}

	public void setRevRegDate(String revRegDate) {
		this.revRegDate = revRegDate;
	}


	public String getNmName() {
		return nmName;
	}

	public void setNmName(String nmName) {
		this.nmName = nmName;
	}

	public String getNmNickname() {
		return nmNickname;
	}

	public void setNmNickname(String nmNickname) {
		this.nmNickname = nmNickname;
	}

	public String getCoId() {
		return coId;
	}

	public void setCoId(String coId) {
		this.coId = coId;
	}

	public String getCoName() {
		return coName;
	}

	public void setCoName(String coName) {
		this.coName = coName;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
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

	public RevFile getRevFile() {
		return revFile;
	}

	public void setRevFile(RevFile revFile) {
		this.revFile = revFile;
	}
}
