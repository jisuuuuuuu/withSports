package com.sist.withSports.model;

import java.io.Serializable;

public class Prom implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long promSeq;
	private String promTitle;
	private String promContent;
	private String promRegDate;
	private String promStatus;
	private String coId;
	private String coName;
	private String coTel;
	private String coEmail;
	private String promMoSdate;
	private String promMoEdate;
	private String promCoSdate;
	private String promCoEdate;
	private String promCate;
	private String promAddr;
	private int promPrice;
	private long promJoinCnt;
	private long promLimitCnt;
	private long promReadCnt;
	private long promLikeCnt;
	
	private PromFile promFile;
	
	private String searchType;
	private String searchValue;
	
	private long startRow;
	private long endRow;
	
	private long promFileSeq;
	private String promFileOrgName;
	private String promFileName;
	private String promFileExt;
	private String promFileSize;
	
	public Prom()
	{
		promSeq = 0;
		promTitle = "";
		promContent = "";
		promRegDate = "";
		promStatus = "";
		coId = "";
		coName = "";
		coTel = "";
		coEmail = "";
		promMoSdate = "";
		promMoEdate = "";
		promCoSdate = "";
		promCoEdate = "";
		promCate = "";
		promAddr = "";
		promPrice = 0;
		promJoinCnt = 0;
		promLimitCnt = 0;
		promReadCnt = 0;
		promLikeCnt = 0;
		
		promFile = null;
		
		searchType = "";
		searchValue = "";
		
		startRow = 0;
		endRow = 0;
		
		promFileSeq = 0;
		promFileOrgName = "";
		promFileName = "";
		promFileExt = "";
		promFileSize = "";
	}

	public long getPromSeq() {
		return promSeq;
	}

	public void setPromSeq(long promSeq) {
		this.promSeq = promSeq;
	}

	public String getPromTitle() {
		return promTitle;
	}

	public void setPromTitle(String promTitle) {
		this.promTitle = promTitle;
	}

	public String getPromContent() {
		return promContent;
	}

	public void setPromContent(String promContent) {
		this.promContent = promContent;
	}

	public String getPromRegDate() {
		return promRegDate;
	}

	public void setPromRegDate(String promRegDate) {
		this.promRegDate = promRegDate;
	}

	public String getPromStatus() {
		return promStatus;
	}

	public void setPromStatus(String promStatus) {
		this.promStatus = promStatus;
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

	public String getCoTel() {
		return coTel;
	}

	public void setCoTel(String coTel) {
		this.coTel = coTel;
	}

	public String getCoEmail() {
		return coEmail;
	}

	public void setCoEmail(String coEmail) {
		this.coEmail = coEmail;
	}

	public String getPromMoSdate() {
		return promMoSdate;
	}

	public void setPromMoSdate(String promMoSdate) {
		this.promMoSdate = promMoSdate;
	}

	public String getPromMoEdate() {
		return promMoEdate;
	}

	public void setPromMoEdate(String promMoEdate) {
		this.promMoEdate = promMoEdate;
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

	public String getPromCate() {
		return promCate;
	}

	public void setPromCate(String promCate) {
		this.promCate = promCate;
	}

	public String getPromAddr() {
		return promAddr;
	}

	public void setPromAddr(String promAddr) {
		this.promAddr = promAddr;
	}

	public int getPromPrice() {
		return promPrice;
	}

	public void setPromPrice(int promPrice) {
		this.promPrice = promPrice;
	}

	public long getPromJoinCnt() {
		return promJoinCnt;
	}

	public void setPromJoinCnt(long promJoinCnt) {
		this.promJoinCnt = promJoinCnt;
	}

	public long getPromLimitCnt() {
		return promLimitCnt;
	}

	public void setPromLimitCnt(long promLimitCnt) {
		this.promLimitCnt = promLimitCnt;
	}

	public long getPromReadCnt() {
		return promReadCnt;
	}

	public void setPromReadCnt(long promReadCnt) {
		this.promReadCnt = promReadCnt;
	}

	public long getPromLikeCnt() {
		return promLikeCnt;
	}

	public void setPromLikeCnt(long promLikeCnt) {
		this.promLikeCnt = promLikeCnt;
	}

	public PromFile getPromFile() {
		return promFile;
	}

	public void setPromFile(PromFile promFile) {
		this.promFile = promFile;
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

	public long getPromFileSeq() {
		return promFileSeq;
	}

	public void setPromFileSeq(long promFileSeq) {
		this.promFileSeq = promFileSeq;
	}

	public String getPromFileOrgName() {
		return promFileOrgName;
	}

	public void setPromFileOrgName(String promFileOrgName) {
		this.promFileOrgName = promFileOrgName;
	}

	public String getPromFileName() {
		return promFileName;
	}

	public void setPromFileName(String promFileName) {
		this.promFileName = promFileName;
	}

	public String getPromFileExt() {
		return promFileExt;
	}

	public void setPromFileExt(String promFileExt) {
		this.promFileExt = promFileExt;
	}

	public String getPromFileSize() {
		return promFileSize;
	}

	public void setPromFileSize(String promFileSize) {
		this.promFileSize = promFileSize;
	}

}
