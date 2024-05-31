package com.sist.withSports.model;

import java.io.Serializable;

public class RevReply implements Serializable
{
	private static final long serialVersionUID = 1L;

	private long replySeq;
	private long revSeq;
	private String nmId;
	private String replyContent;
	private long replyGroup;
	private long replyOrder;;
	private long replyIndent;
	private String replyRegDate;
	private long replyParent;
	private String coId;
	
	private String nmNickname;
	private String coName;
	
	public RevReply()
	{
		replySeq = 0;
		revSeq = 0;
		nmId = "";
		replyContent = "";
		replyGroup = 0;
		replyOrder = 0;
		replyIndent = 0;
		replyRegDate = "";
		replyParent = 0;
		coId = "";
		
		nmNickname = "";
		coName = "";
	}

	public long getReplySeq() {
		return replySeq;
	}

	public void setReplySeq(long replySeq) {
		this.replySeq = replySeq;
	}

	public long getRevSeq() {
		return revSeq;
	}

	public void setRevSeq(long revSeq) {
		this.revSeq = revSeq;
	}

	public String getNmId() {
		return nmId;
	}

	public void setNmId(String nmId) {
		this.nmId = nmId;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public long getReplyGroup() {
		return replyGroup;
	}

	public void setReplyGroup(long replyGroup) {
		this.replyGroup = replyGroup;
	}

	public long getReplyOrder() {
		return replyOrder;
	}

	public void setReplyOrder(long replyOrder) {
		this.replyOrder = replyOrder;
	}

	public long getReplyIndent() {
		return replyIndent;
	}

	public void setReplyIndent(long replyIndent) {
		this.replyIndent = replyIndent;
	}

	public String getReplyRegDate() {
		return replyRegDate;
	}

	public void setReplyRegDate(String replyRegDate) {
		this.replyRegDate = replyRegDate;
	}

	public long getReplyParent() {
		return replyParent;
	}

	public void setReplyParent(long replyParent) {
		this.replyParent = replyParent;
	}

	public String getCoId() {
		return coId;
	}

	public void setCoId(String coId) {
		this.coId = coId;
	}

	public String getNmNickname() {
		return nmNickname;
	}

	public void setNmNickname(String nmNickname) {
		this.nmNickname = nmNickname;
	}

	public String getCoName() {
		return coName;
	}

	public void setCoName(String coName) {
		this.coName = coName;
	}
}
