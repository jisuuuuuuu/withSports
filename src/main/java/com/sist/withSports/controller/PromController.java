package com.sist.withSports.controller;

import java.io.File;
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

import com.sist.common.model.FileData;
import com.sist.common.util.CookieUtil;
import com.sist.common.util.FileUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.JsonUtil;
import com.sist.common.util.StringUtil;
import com.sist.withSports.model.CoUser;
import com.sist.withSports.model.Join;
import com.sist.withSports.model.Like;
import com.sist.withSports.model.Paging;
import com.sist.withSports.model.Prom;
import com.sist.withSports.model.PromFile;
import com.sist.withSports.model.Response;
import com.sist.withSports.service.CoUserService;
import com.sist.withSports.service.NmUserService;
import com.sist.withSports.service.PromService;

@Controller("promController")
public class PromController
{
	private static Logger logger = LoggerFactory.getLogger(RevController.class);
	
	@Autowired
	private PromService promService;
	
	@Autowired
	private CoUserService coUserService;
	
	@Autowired
	private NmUserService nmUserService;
	
	@Value("#{env['auth.cookie.couser']}")
	private String AUTH_COOKIE_CONAME;
	
	@Value("#{env['auth.cookie.nmuser']}")
	private String AUTH_COOKIE_NMNAME;
	
	@Value("#{env['promUupload.save.dir']}")
	private String PROMUPLOAD_SAVE_DIR;
	
	private static final int LIST_COUNT = 5;		
	private static final int PAGE_COUNT = 5;
	
	@RequestMapping(value="/board/promList")
	public String promList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//조회항목(1:작성자 2:제목 3:내용)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회 값
		String searchValue =HttpUtil.get(request, "searchValue", "");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//게시물 리스트(메인)
		List<Prom> list = null;
		//좋아요 리스트
		List<Prom> likeList = null;
		//조회수 리스트
		List<Prom> readList = null;
		//최신순 리스트
		List<Prom> leastList = null;
		//조회 겍체
		Prom search = new Prom();
		//페이징 객체
		Paging paging = null;
		//총 게시물 수
		long totalCount = 0;
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		
		totalCount = promService.promListCnt(search);
		
		if(totalCount > 0 )
		{
			paging = new Paging("/board/promList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = promService.promList(search);
			
			likeList = promService.promLikeList(1);
			readList = promService.promReadList(1);
			leastList = promService.promLeastList(1);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("likeList", likeList);
		model.addAttribute("readList", readList);
		model.addAttribute("leastList", leastList);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("cookieCoId", cookieCoId);
		
		return "/board/promList";
	}
	
	@RequestMapping(value="/board/promWrite")
	public String promWrite(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		
		CoUser coUser = coUserService.coUserSelect(cookieCoId);
		
		model.addAttribute("cookieCoId", cookieCoId);
		model.addAttribute("coUser", coUser);
		
		return "/board/promWrite";
	}
	
	@RequestMapping(value="/board/promWriteProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> promWriteProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//쿠키값 받기
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//제목
		String promTitle = HttpUtil.get(request, "promTitle", "");
		//모집시작일
		String promMoSdate = HttpUtil.get(request, "promMoSdate", "");
		//모집마감일
		String promMoEdate = HttpUtil.get(request, "promMoEdate", "");
		//대회시작일
		String promCoSdate = HttpUtil.get(request, "promCoSdate", "");
		//대회마감일
		String promCoEdate = HttpUtil.get(request, "promCoEdate", "");
		//대회종목
		String promCate = HttpUtil.get(request, "promCate", "");
		//대회장소
		String promAddr = HttpUtil.get(request, "promAddr", "");
		//대회참가비용
		int promPrice = HttpUtil.get(request, "promPrice", 0);
		//모집인원
		int promLimitCnt = HttpUtil.get(request, "promLimitCnt", 0);
		//내용
		String promContent =HttpUtil.get(request, "promContent", "");
		//파일
		FileData fileData = HttpUtil.getFile(request, "promFile", PROMUPLOAD_SAVE_DIR);
		
		Prom prom = new Prom();
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		logger.debug("promAddr ; " + promAddr);
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		
		if(!StringUtil.isEmpty(promTitle) && !StringUtil.isEmpty(promMoSdate) && !StringUtil.isEmpty(promMoEdate) && !StringUtil.isEmpty(promCoSdate) && !StringUtil.isEmpty(promCoEdate)
				 && !StringUtil.isEmpty(promAddr) && promLimitCnt != 0 && !StringUtil.isEmpty(promContent) && !StringUtil.isEmpty(promCate))
		{	
			prom.setCoId(cookieCoId);
			prom.setPromTitle(promTitle);
			prom.setPromMoSdate(promMoSdate);
			prom.setPromMoEdate(promMoEdate);
			prom.setPromCoSdate(promCoSdate);
			prom.setPromCoEdate(promCoEdate);
			prom.setPromCate(promCate);
			prom.setPromStatus("Y");
			prom.setPromAddr(promAddr);
			prom.setPromLimitCnt(promLimitCnt);
			prom.setPromPrice(promPrice);
			prom.setPromContent(promContent);
			
			if(fileData != null && fileData.getFileSize() >0)
			{
				PromFile promFile = new PromFile();
				
				promFile.setPromFileName(fileData.getFileName());
				promFile.setPromFileOrgName(fileData.getFileOrgName());
				promFile.setPromFileExt(fileData.getFileExt());
				promFile.setPromFileSize(fileData.getFileSize());
				
				prom.setPromFile(promFile);
			}
			
			try
			{
				if(promService.promInsert(prom) > 0)
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
				logger.error("[PromController] promWriteProc Exception", e);
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
	
	@RequestMapping(value="/board/promUpdate")
	public String promUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값 받기
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		long promSeq = HttpUtil.get(request, "promSeq", (long)0);
		
		CoUser coUser = null;
		Prom prom = null;
		PromFile promFile = null;
		
		if(promSeq > 0)
		{
			prom = promService.promView(promSeq);
			promFile = promService.promFileSelect(promSeq);
			
			if(promSeq > 0)
			{
				prom.setPromFile(promFile);
			}
			
			coUser = coUserService.coUserSelect(cookieCoId);
			
//			if(!StringUtil.equals(cookieCoId, prom.getCoId()))
//			{
//				prom = null;
//			}
		}
		
		model.addAttribute("prom", prom);
		model.addAttribute("coUser", coUser);
		model.addAttribute("cookieCoId", cookieCoId);
		model.addAttribute("promSeq", promSeq);
		
		return "/board/promUpdate";
	}
	
	@RequestMapping(value="/board/promUpdateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> promUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//쿠키값 받기
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		//게시물 번호
		long promSeq = HttpUtil.get(request, "promSeq", (long)0);
		//제목
		String promTitle = HttpUtil.get(request, "promTitle", "");
		//모집시작일
		String promMoSdate = HttpUtil.get(request, "promMoSdate", "");
		//모집마감일
		String promMoEdate = HttpUtil.get(request, "promMoEdate", "");
		//대회시작일
		String promCoSdate = HttpUtil.get(request, "promCoSdate", "");
		//대회마감일
		String promCoEdate = HttpUtil.get(request, "promCoEdate", "");
		//대회종목
		String promCate = HttpUtil.get(request, "promCate", "");
		//대회장소
		String promAddr = HttpUtil.get(request, "promAddr", "");
		//모집인원
		int promLimitCnt = HttpUtil.get(request, "promLimitCnt", 0);
		//내용
		String promContent =HttpUtil.get(request, "promContent", "");
		//파일
		FileData fileData = HttpUtil.getFile(request, "promFile", PROMUPLOAD_SAVE_DIR);
		
		if(promSeq > 0 && !StringUtil.isEmpty(promTitle) && !StringUtil.isEmpty(promMoSdate) && !StringUtil.isEmpty(promMoEdate) 
				&& !StringUtil.isEmpty(promCoSdate) && !StringUtil.isEmpty(promCoEdate)
				 && !StringUtil.isEmpty(promAddr) && promLimitCnt != 0 && !StringUtil.isEmpty(promContent) && !StringUtil.isEmpty(promCate))
		{	
			Prom prom = promService.promView(promSeq);
			
			if(prom != null)
			{
				if(StringUtil.equals(cookieCoId, prom.getCoId()))
				{
					prom.setPromTitle(promTitle);
					prom.setPromMoSdate(promMoSdate);
					prom.setPromMoEdate(promMoEdate);
					prom.setPromCoSdate(promCoSdate);
					prom.setPromCoEdate(promCoEdate);
					prom.setPromCate(promCate);
					prom.setPromAddr(promAddr);
					prom.setPromLimitCnt(promLimitCnt);
					prom.setPromContent(promContent);
					
					if(fileData != null && fileData.getFileSize() >0)
					{
						PromFile promFile = new PromFile();
						
						promFile.setPromFileName(fileData.getFileName());
						promFile.setPromFileOrgName(fileData.getFileOrgName());
						promFile.setPromFileExt(fileData.getFileExt());
						promFile.setPromFileSize(fileData.getFileSize());
						
						prom.setPromFile(promFile);
					}
					
					try
					{
						if(promService.promUpdate(prom) > 0)
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
						logger.error("[PromController] promUpdateProc Exception", e);
						ajaxResponse.setResponse(500, "Internal Server Error2");
					}
				}
				else
				{
					ajaxResponse.setResponse(403, "Server Error");
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
			logger.debug("[UserController] /board/promUpdateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/board/promView")
	public String promView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		String cookieCoId = CookieUtil.getHexValue(request, AUTH_COOKIE_CONAME);
		long promSeq = HttpUtil.get(request, "promSeq", (long)0);
		//조회항목(1:작성자 2:제목 3:내용)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회 값
		String searchValue =HttpUtil.get(request, "searchValue", "");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//좋아요 리스트
		List<Prom> likeList = null;
		//조회수 리스트
		List<Prom> readList = null;
		//최신순 리스트
		List<Prom> leastList = null;
		
		Prom prom = null;
		PromFile promFile = null;
		CoUser coUser = null;
		Like like = null;
		
		if(promSeq > 0)
		{
			prom = promService.promView(promSeq);
			promFile = promService.promFileSelect(promSeq);
			
			promService.promReadCntUp(promSeq);
			
			Like ekil = new Like();
			
			ekil.setNmId(cookieNmId);
			ekil.setPromSeq(promSeq);
			
			like = promService.promLikeSelect(ekil);
			
			likeList = promService.promLikeList(1);
			readList = promService.promReadList(1);
			leastList = promService.promLeastList(1);
			
			if(promSeq > 0)
			{
				prom.setPromFile(promFile);
			}
		}
		
		model.addAttribute("prom", prom);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("cookieCoId", cookieCoId);
		model.addAttribute("cookieNmId", cookieNmId);
		model.addAttribute("promSeq", promSeq);
		model.addAttribute("like", like);
		model.addAttribute("likeList", likeList);
		model.addAttribute("readList", readList);
		model.addAttribute("leastList", leastList);
				
		return "/board/promView";
	}
	
	@RequestMapping(value="/board/nmDeleteLike", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> nmDeleteLike(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		//게시물 번호
		long promSeq = HttpUtil.get(request, "promSeq", (long)0);
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		logger.debug("cookieNmId ; " + cookieNmId);
		logger.debug("promSeq ; " + promSeq);
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		if(promSeq > 0)
		{
			if(promService.promView(promSeq) != null)
			{
				if(nmUserService.nmUserSelect(cookieNmId) != null)
				{
					Like like = new Like();
					
					like.setNmId(cookieNmId);
					like.setPromSeq(promSeq);
					
					if(promService.promLikeSelect(like) == null)
					{
						if(promService.promLikeInsert(like) > 0)
						{
							Prom prom =  new Prom();
							prom.setPromSeq(promSeq);
							promService.promLikeCntUp(prom);
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(500, "Internal Server Error");
						}
					}
					else
					{
						ajaxResponse.setResponse(503, "Twice");
					}
				}
				else
				{
					ajaxResponse.setResponse(403, "Server Error");
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
			logger.debug("[UserController] /board/promUpdateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/board/nmLike", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> nmLike(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		//게시물 번호
		long promSeq = HttpUtil.get(request, "promSeq", (long)0);
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		logger.debug("cookieNmId ; " + cookieNmId);
		logger.debug("promSeq ; " + promSeq);
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		if(promSeq > 0)
		{
			if(promService.promView(promSeq) != null)
			{
				if(nmUserService.nmUserSelect(cookieNmId) != null)
				{
					Like like = new Like();
					
					like.setNmId(cookieNmId);
					like.setPromSeq(promSeq);
					
					if(promService.promLikeSelect(like) != null)
					{
						if(promService.promLikeDelete(like) > 0)
						{
							Prom prom =  new Prom();
							prom.setPromSeq(promSeq);
							promService.promLikeCntUp(prom);
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(500, "Internal Server Error");
						}
					}
					else
					{
						ajaxResponse.setResponse(503, "No Data");
					}
				}
				else
				{
					ajaxResponse.setResponse(403, "Server Error");
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
			logger.debug("[UserController] /board/promUpdateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/board/nmJoin", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> nmJoin(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		//쿠키값 받기
		String cookieNmId = CookieUtil.getHexValue(request, AUTH_COOKIE_NMNAME);
		//게시물 번호
		long promSeq = HttpUtil.get(request, "promSeq", (long)0);
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		logger.debug("cookieNmId ; " + cookieNmId);
		logger.debug("promSeq ; " + promSeq);
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		if(promSeq > 0)
		{
			Prom rr = promService.promView(promSeq);
			
			if(rr != null)
			{
				if(rr.getPromJoinCnt() < rr.getPromLimitCnt())
				{
					if(nmUserService.nmUserSelect(cookieNmId) != null)
					{
						Join join = new Join();
						
						join.setNmId(cookieNmId);
						join.setPromSeq(promSeq);
						
						if(nmUserService.promJoinSelect(join) != null)
						{
							ajaxResponse.setResponse(-1, "Unable to apply");
						}
						else
						{
							if(nmUserService.promJoinInsert(join) > 0)
							{
								Prom prom = new Prom();
								prom.setPromSeq(promSeq);
								
								nmUserService.promJoinCntUp(prom);
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
						ajaxResponse.setResponse(403, "Server Error");
					}
				}
				else
				{
					ajaxResponse.setResponse(800, "Exceeding the limit");
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
			logger.debug("[UserController] /board/promUpdateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/board/downloadProm")
	public ModelAndView downloadProm(HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView mav = null;
		
		long promSeq = HttpUtil.get(request, "promSeq", (long)0);
		
		if(promSeq > 0)
		{
			PromFile promFile = promService.promFileSelect(promSeq);
			
			if(promFile != null)
			{
				File file = new File(PROMUPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + promFile.getPromFileName());
				
				if(FileUtil.isFile(file))
				{
					mav = new ModelAndView();
					
					mav.setViewName("fileDownloadView");
					mav.addObject("file", file);
					mav.addObject("fileName", promFile.getPromFileOrgName());
				}
			}
		}
		
		return mav;
	}
}
