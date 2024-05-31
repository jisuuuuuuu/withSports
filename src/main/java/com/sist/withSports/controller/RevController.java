package com.sist.withSports.controller;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sist.withSports.model.CoUser;
import com.sist.withSports.model.NmUser;
import com.sist.withSports.model.Paging;
import com.sist.withSports.model.PromFile;
import com.sist.withSports.model.Response;
import com.sist.common.model.FileData;
import com.sist.common.util.CookieUtil;
import com.sist.common.util.FileUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.JsonUtil;
import com.sist.common.util.StringUtil;
import com.sist.withSports.model.Rev;
import com.sist.withSports.model.RevFile;
import com.sist.withSports.model.RevReply;
import com.sist.withSports.service.CoUserService;
import com.sist.withSports.service.NmUserService;
import com.sist.withSports.service.RevService;

@Controller("revController")
public class RevController 
{
	private static Logger logger = LoggerFactory.getLogger(RevController.class);
	
	@Autowired
	private RevService revService;
	
	@Autowired
	private NmUserService nmUserService;
	
	@Autowired
	private CoUserService coUserService;
	
	@Value("#{env['auth.cookie.nmuser']}")
	private String AUTH_COOKIE_NMNAME;
	
	@Value("#{env['auth.cookie.couser']}")
	private String AUTH_COOKIE_CONAME;
	
	@Value("#{env['revUpload.save.dir']}")
	private String REVUPLOAD_SAVE_DIR;
	
	private static final int LIST_COUNT = 5;		
	private static final int PAGE_COUNT = 5;
	
	@RequestMapping(value="/board/revList")
	public String revList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//조회항목(1:작성자 2:제목 3:내용)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회 값
		String searchValue =HttpUtil.get(request, "searchValue", "");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		long curPageCo = HttpUtil.get(request, "curPageCo", (long)1);
		//게시물 리스트
		List<Rev> list = null;
		//게시물 기업 리스트
		List<Rev> listCo = null;
		//조회 겍체
		Rev search = new Rev();
		Rev searchCo = new Rev();
		//페이징 객체
		Paging paging = null;
		Paging pagingCo = null;
		//총 게시물 수
		long totalCount = 0;
		long totalCountCo = 0; 
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		
		totalCount = revService.revListCnt(search);
		
		if(totalCount > 0 )
		{
			paging = new Paging("/board/revList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = revService.revList(search);
		}
		
		totalCountCo = revService.revCoListCnt(cookieCoId);
		
		if(totalCount > 0 )
		{	
			listCo = revService.revCoList(searchCo);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("cookieNmId", cookieNmId);
		model.addAttribute("cookieCoId", cookieCoId);
		model.addAttribute("listCo", listCo);
		
		return "/board/revList";
	}
	@RequestMapping(value="/board/revView")
	public String revView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		long revSeq = HttpUtil.get(request, "revSeq", (long)0);
		//조회항목(1:작성자 2:제목 3:내용)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회 값
		String searchValue =HttpUtil.get(request, "searchValue", "");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		Rev rev = null;
		RevFile revFile = null;
		List<RevReply> listRe = null;
		
		if(revSeq > 0)
		{
			rev = revService.revView(revSeq);
			revFile = revService.revFileSelect(revSeq);
			
			revService.revReadCntUp(revSeq);
			
			listRe = revService.revReplyList(revSeq);
			
			if(revFile != null)
			{
				rev.setRevFile(revFile);
			}
		}
		
		model.addAttribute("rev", rev);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("cookieNmId", cookieNmId);
		model.addAttribute("cookieCoId", cookieCoId);
		model.addAttribute("revSeq", revSeq);
		model.addAttribute("listRe", listRe);
		
		return "/board/revView";
	}
	
	@RequestMapping(value="/board/revWrite")
	public String revWrite(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//조회항목(1:작성자 2:제목 3:내용)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회 값
		String searchValue =HttpUtil.get(request, "searchValue", "");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		NmUser nmUser = null;
		CoUser coUser = null;
		
		if(CookieUtil.getCookie(request, "NM_ID") != null)
		{
			nmUser = nmUserService.nmUserSelect(cookieNmId);
		}
		else if(CookieUtil.getCookie(request, "CO_ID") != null)
		{
			coUser = coUserService.coUserSelect(cookieCoId);
		}
		
		model.addAttribute("nmUser", nmUser);
		model.addAttribute("coUser", coUser);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("cookieNmId", cookieNmId);
		model.addAttribute("cookieCoId", cookieCoId);
		
		return "/board/revWrite";
	}
	
	@RequestMapping(value="/board/revWriteProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> revWriteProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//제목
		String revTitle = HttpUtil.get(request, "title", "");
		//내용
		String revContent =HttpUtil.get(request, "content", "");
		//파일
		FileData fileData = HttpUtil.getFile(request, "revFile", REVUPLOAD_SAVE_DIR);
		
		Rev rev = new Rev();
		
		if(!StringUtil.isEmpty(revTitle) && !StringUtil.isEmpty(revContent))
		{
			if(CookieUtil.getCookie(request, "NM_ID") != null)
			{
				rev.setNmId(cookieNmId);
				rev.setCoId("nm");
			}
			else if(CookieUtil.getCookie(request, "CO_ID") != null)
			{
				rev.setNmId("co");
				rev.setCoId(cookieCoId);
			}
			
			rev.setRevTitle(revTitle);
			rev.setRevContent(revContent);
			
			if(fileData != null && fileData.getFileSize() >0)
			{
				RevFile revFile = new RevFile();
				
				revFile.setrevFileName(fileData.getFileName());
				revFile.setrevFileOrgName(fileData.getFileOrgName());
				revFile.setrevFileExt(fileData.getFileExt());
				revFile.setrevFileSize(fileData.getFileSize());
				
				rev.setRevFile(revFile);
			}
			
			try
			{
				if(revService.revInsert(rev) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
			}
			catch(Exception e)
			{
				logger.error("[RevController] revWriteProc Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error2");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /board/revWriteProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/board/revUpdate")
	public String revUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//게시물 번호
		long revSeq = HttpUtil.get(request, "revSeq", (long)0);
		
		NmUser nmUser = null;
		CoUser coUser = null;
		Rev rev = null;
		RevFile revFile = null;
		
		logger.debug("####################################################");
		logger.debug("revSeq : " + revSeq);
		logger.debug("####################################################");
		
		if(revSeq > 0)
		{
			rev = revService.revView(revSeq);
			revFile = revService.revFileSelect(revSeq);
			
			if(revFile != null)
			{
				rev.setRevFile(revFile);
			}
			
			if(CookieUtil.getCookie(request, "NM_ID") != null)
			{
				nmUser = nmUserService.nmUserSelect(cookieNmId);
			}
			else if(CookieUtil.getCookie(request, "CO_ID") != null)
			{
				coUser = coUserService.coUserSelect(cookieCoId);
			}
		}
		
		model.addAttribute("rev", rev);
		model.addAttribute("nmUser", nmUser);
		model.addAttribute("coUser", coUser);
		model.addAttribute("cookieNmId", cookieNmId);
		model.addAttribute("cookieCoId", cookieCoId);
		model.addAttribute("revSeq", revSeq);
		
		return "/board/revUpdate";
	}
	
	@RequestMapping(value="/board/revUpdateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> revUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> aja = new Response<Object>();
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//제목
		String revTitle = HttpUtil.get(request, "title", "");
		//내용
		String revContent =HttpUtil.get(request, "content", "");
		//파일
		FileData fileData = HttpUtil.getFile(request, "revFile", REVUPLOAD_SAVE_DIR);
		//게시물 번호
		long revSeq = HttpUtil.get(request, "revSeq", (long)0);
		//첨부파일 삭제
		String btnFileDeleteClick = HttpUtil.get(request, "btnFileDeleteClick");
		
		if(StringUtil.equals(btnFileDeleteClick, "Y"))
		{
			if(revService.revFileDelete(revSeq) > 0)
			{
				logger.debug("#######################################");
				logger.debug("file delete success");
				logger.debug("#######################################");
			}
			else
			{
				aja.setResponse(700, "file delete error");
			}
		}
		
		if(revSeq > 0 && !StringUtil.isEmpty(revTitle) && !StringUtil.isEmpty(revContent))
		{
			Rev rev = revService.revSelect(revSeq);
			
			if(rev != null)
			{
				if(cookieNmId != null && cookieNmId != "" && !StringUtil.equals(cookieNmId, rev.getNmId()))
				{
					rev = null;
					aja.setResponse(403, "Server Error1");
				}
				else if(cookieCoId != null && cookieCoId != "" && !StringUtil.equals(cookieCoId, rev.getCoId()))
				{
					rev = null;
					aja.setResponse(403, "Server Error2");
				}
				else
				{
					rev.setRevTitle(revTitle);
					rev.setRevContent(revContent);
					
					if(fileData != null && fileData.getFileSize() > 0)
					{
						RevFile revFile = new RevFile();
						
						revFile.setrevFileName(fileData.getFileName());
						revFile.setrevFileOrgName(fileData.getFileOrgName());
						revFile.setrevFileExt(fileData.getFileExt());
						revFile.setrevFileSize(fileData.getFileSize());
						
						rev.setRevFile(revFile);
					}
					
					try
					{
						if(revService.revUpdate(rev) > 0)
						{
							aja.setResponse(0, "Success");
						}
						else
						{
							aja.setResponse(500, "Internal Server Error");
						}
					}
					catch(Exception e)
					{
						logger.error("[RevController] revUpdateProc Exception", e);
						aja.setResponse(500, "Internal Server Error2");
					}
				}
			}
			else
			{
				aja.setResponse(404, "Not Found");
			}
		}
		else
		{
			aja.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /board/revUpdateProc response\n" + JsonUtil.toJsonPretty(aja));
		}
		
		return aja;
	}
	
	@RequestMapping(value="/board/revDelete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> revDelete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//게시물 번호
		long revSeq = HttpUtil.get(request, "revSeq", (long)0);
		
		logger.debug("#######################################");
		logger.debug("seq : " + revSeq);
		logger.debug("#######################################");
		
		if(revSeq > 0)
		{
			Rev rev = revService.revSelect(revSeq);
			
			if(rev != null)
			{
				if(cookieNmId != null && cookieNmId != "" && !StringUtil.equals(cookieNmId, rev.getNmId()))
				{
					rev = null;
					ajaxResponse.setResponse(403, "Server Error1");
				}
				else if(cookieCoId != null && cookieCoId != "" && !StringUtil.equals(cookieCoId, rev.getCoId()))
				{
					rev = null;
					ajaxResponse.setResponse(403, "Server Error2");
				}
				else
				{
					
					try
					{
						if(revService.revDelete(revSeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(500, "Internal Server Error");
						}
					}
					catch(Exception e)
					{
						logger.error("[RevController] revUpdateProc Exception", e);
						ajaxResponse.setResponse(500, "Internal Server Error2");
					}
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "BadRequest");
		}
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /board/revUpdateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/board/replyProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> replyProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//게시물 번호
		long revSeq = HttpUtil.get(request, "revSeq", (long)0);
		//내용
		String replyContent = HttpUtil.get(request, "replyContent", "");
		
		RevReply reply = new RevReply();
		
		if(revSeq > 0 && !StringUtil.isEmpty(replyContent))
		{
			Rev rev = revService.revSelect(revSeq);
			
			if(rev != null)
			{
				if(CookieUtil.getCookie(request, "NM_ID") != null)
				{
					reply.setNmId(cookieNmId);
					reply.setCoId("nm");
				}
				else if(CookieUtil.getCookie(request, "CO_ID") != null)
				{
					reply.setNmId("co");
					reply.setCoId(cookieCoId);
				}
				
				reply.setReplyContent(replyContent);
				reply.setRevSeq(revSeq);
				
				if(revService.revReplyInsert(reply) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /board/replypProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/board/rereplyProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> rereplyProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//게시물 번호
		long revSeq = HttpUtil.get(request, "revSeq", (long)0);
		//댓글 번호
		long replySeq = HttpUtil.get(request, "replySeq", (long)0);
		//내용
		String replyContent = HttpUtil.get(request, "replyContent", "");
		
		RevReply reply = new RevReply();
		
		logger.debug("#######################################");
		logger.debug("revSeq : " + revSeq);
		logger.debug("replySeq : " + replySeq);
		logger.debug("replyContent : " + replyContent);
		logger.debug("#######################################");
		
		if(revSeq > 0 && !StringUtil.isEmpty(replyContent))
		{
			Rev rev = revService.revSelect(revSeq);
			
			if(rev != null)
			{
				RevReply parentReply = revService.revReplySelect(replySeq);
				
				if(parentReply != null)
				{
					if(CookieUtil.getCookie(request, "NM_ID") != null)
					{
						reply.setNmId(cookieNmId);
						reply.setCoId("nm");
					}
					else if(CookieUtil.getCookie(request, "CO_ID") != null)
					{
						reply.setNmId("co");
						reply.setCoId(cookieCoId);
					}
					
					reply.setReplyContent(replyContent);
					reply.setRevSeq(revSeq);
					reply.setReplyGroup(parentReply.getReplyGroup());
					reply.setReplyOrder(parentReply.getReplyOrder() + 1);
					reply.setReplyIndent(parentReply.getReplyIndent() + 1);
					reply.setReplyParent(replySeq);
					
					try
					{
						if(revService.dereply(reply) > 0)
						{
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(500, "Internal Server Error");
						}
					}
					catch(Exception e)
					{
						logger.error("[RevController] rereplypProc Exception", e);
						ajaxResponse.setResponse(500, "Internal Server Error2");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Reply Not Found");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /board/rereplypProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/board/revReplyUpdate", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> revReplyUpdate(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//댓글 번호
		long replySeq = HttpUtil.get(request, "replySeq", (long)0);
		//내용
		String replyContent = HttpUtil.get(request, "replyContent", "");
		
		RevReply reply = new RevReply();
		
		logger.debug("#######################################");
		logger.debug("replySeq : " + replySeq);
		logger.debug("replyContent : " + replyContent);
		logger.debug("#######################################");
		
		if(replySeq > 0 && !StringUtil.isEmpty(replyContent))
		{
			RevReply rep = revService.revReplySelect(replySeq);
			
			if(rep != null)
			{
				if(cookieCoId != null && cookieCoId != "" && !StringUtil.equals(cookieCoId, rep.getCoId()))
				{
					ajaxResponse.setResponse(403, "Server Error1");
				}
				else if(cookieNmId != null && cookieNmId != "" && !StringUtil.equals(cookieNmId, rep.getNmId()))
				{
					ajaxResponse.setResponse(403, "Server Error1");
				}
				else
				{
					reply.setReplySeq(replySeq);
					reply.setReplyContent(replyContent);
					
					if(revService.revReplyUpdate(reply) > 0)
					{
						ajaxResponse.setResponse(0, "Success");
					}
					else
					{
						ajaxResponse.setResponse(500, "Internal Server Error");
					}
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /board/revReplyUpdate response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/board/revReplyDelete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> revReplyDelete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//댓글 번호
		long replySeq = HttpUtil.get(request, "replySeq", (long)0);
		
		logger.debug("#######################################");
		logger.debug("replySeq : " + replySeq);
		logger.debug("#######################################");
		
		if(replySeq > 0)
		{
			RevReply rep = revService.revReplySelect(replySeq);
			
			if(rep != null)
			{
				if(cookieCoId != null && cookieCoId != "" && !StringUtil.equals(cookieCoId, rep.getCoId()))
				{
					ajaxResponse.setResponse(403, "Server Error1");
				}
				else if(cookieNmId != null && cookieNmId != "" && !StringUtil.equals(cookieNmId, rep.getNmId()))
				{
					ajaxResponse.setResponse(403, "Server Error1");
				}
				else
				{
					if(revService.revReplyAnswersCount(replySeq) > 0)
					{
						ajaxResponse.setResponse(-5, "Unable to delete");
					}
					else
					{
						if(revService.revReplyDelete(replySeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(500, "Internal Server Error");
						}
					}
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled()) 
		{
			logger.debug("[UserController] /board/revReplyDelete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/board/downloadRev")
	public ModelAndView downloadProm(HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView mav = null;
		
		long revSeq = HttpUtil.get(request, "revSeq", (long)0);
		
		if(revSeq > 0)
		{
			RevFile revFile = revService.revFileSelect(revSeq);
			
			if(revFile != null)
			{
				File file = new File(REVUPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + revFile.getrevFileName());
				
				if(FileUtil.isFile(file))
				{
					mav = new ModelAndView();
					
					mav.setViewName("fileDownloadView");
					mav.addObject("file", file);
					mav.addObject("fileName", revFile.getrevFileOrgName());
				}
			}
		}
		
		return mav;
	}
}
