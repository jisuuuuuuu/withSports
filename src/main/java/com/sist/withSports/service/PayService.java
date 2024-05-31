package com.sist.withSports.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.sist.withSports.controller.PayController;
import com.sist.withSports.model.KakaoPayApprove;
import com.sist.withSports.model.KakaoPayOrder;
import com.sist.withSports.model.KakaoPayReady;

@Service("payService")
public class PayService 
{
	private static Logger logger = LoggerFactory.getLogger(PayService.class);
	
	//카카오페이 호스트
	@Value("#{env['kakao.pay.host']}")
	private String KAKAO_PAY_HOST;
	
	//카카오페이 관리자 키
	@Value("#{env['kakao.pay.admin.key']}")
	private String KAKAO_PAY_ADMIN_KEY;
	
	//카카오페이 가맹점 코드, 10자
	@Value("#{env['kakao.pay.cid']}")
	private String KAKAO_PAY_CID;
	
	//카카오페이 결제 url
	@Value("#{env['kakao.pay.ready.url']}")
	private String KAKAO_PAY_READY_URL;
	
	//카카오페이 결제 요청 url
	@Value("#{env['kakao.pay.approve.url']}")
	private String KAKAO_PAY_APPROVE_URL;

	//카카오페이 결제 성공 url
	@Value("#{env['kakao.pay.success.url']}")
	private String KAKAO_PAY_SUCCESS_URL;

	//카카오페이 결제 취소 url
	@Value("#{env['kakao.pay.cancel.url']}")
	private String KAKAO_PAY_CANCEL_URL;

	//카카오페이 결제 실패 url
	@Value("#{env['kakao.pay.fail.url']}")
	private String KAKAO_PAY_FAIL_URL;
	
	public KakaoPayReady kakaoPayReady(KakaoPayOrder kakaoPayOrder)
	{
		KakaoPayReady kakaoPayReady = null;
		
		if(kakaoPayOrder != null)
		{
			RestTemplate restTemplate = new RestTemplate();
			
			//서버로 요청할 header
			HttpHeaders headers = new HttpHeaders();
			headers.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY);	
			headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
			
			//Content-type: application/x-www-form-urlencoded;charset=utf-8
	        //              application/x-www-form-urlencoded
			
			//서버로 요청할 body
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
			
			params.add("cid", KAKAO_PAY_CID);
			params.add("partner_order_id", kakaoPayOrder.getPartnerOrderId());
			params.add("partner_user_id", kakaoPayOrder.getPartnerUserId());
			params.add("item_name", kakaoPayOrder.getItemName());
			params.add("item_code", kakaoPayOrder.getItemCode());
			params.add("quantity", String.valueOf(kakaoPayOrder.getQuantity()));
			params.add("total_amount", String.valueOf(kakaoPayOrder.getTotalAmount()));
			params.add("tax_free_amount", String.valueOf(kakaoPayOrder.getTaxFreeAmount()));
			params.add("approval_url", KAKAO_PAY_SUCCESS_URL);		//결제 성공시
			params.add("cancel_url", KAKAO_PAY_CANCEL_URL);			//결제 취소시
			params.add("fail_url", KAKAO_PAY_FAIL_URL);				//결제 실패시
			
			//요청하기 위해 header와 body를 합치기
			//spring framework에서 제공해주는 HttpEntity클래스에 header와 body를 합치기
			HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
			
			try 
			{
				//postForObject메서드는 POST요청을 보내고 객체로 결과를 반환
				kakaoPayReady = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_READY_URL), body, KakaoPayReady.class);
				
				if(kakaoPayReady != null)
				{
					kakaoPayOrder.settId(kakaoPayReady.getTid());
					
					logger.debug("=================================");
					logger.debug("kakaoPayReady.getTid() : " + kakaoPayReady.getTid());
					logger.debug("[KakaoPayService] kakaoPayReady : " + kakaoPayReady);
					logger.debug("=================================");
				}
			}
			catch(URISyntaxException e) 
			{
				logger.error("[KakaoPayService] kakaoPayReady Exception", e);
			}
		}
		else
		{
			logger.error("[KakaoPayService] kakaoPayReady kakaoPayOrder is null");
		}
		
		return kakaoPayReady;
	}
	
	public KakaoPayApprove kakaoPayApprove(KakaoPayOrder kakaoPayOrder)
	{
		KakaoPayApprove kakaoPayApprove = null;
		
		if(kakaoPayOrder != null)
		{
			RestTemplate restTemplate = new RestTemplate();
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY);	
			headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
			
			//Content-type: application/x-www-form-urlencoded;charset=utf-8
	        //              application/x-www-form-urlencoded
			
			//서버로 요청할 body
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
			
			params.add("cid", KAKAO_PAY_CID);											    //가맹점 코드, 10자
			params.add("tid", kakaoPayOrder.gettId());									   //결제 고유번호, 결제 준비 API 응답에 포함
			params.add("partner_order_id", kakaoPayOrder.getPartnerOrderId());			  //가맹점 주문번호, 결제 준비 API 요청과 일치해야 함
			params.add("partner_user_id", kakaoPayOrder.getPartnerUserId());			 //가맹점 회원 id, 결제 준비 API 요청과 일치해야 함
			params.add("pg_token", kakaoPayOrder.getPgToken());							//결제승인 요청을 인증하는 토큰
																					   //사용자 결제 수단 선택 완료 시, approval_url로 redirection해줄 때 pg_token을 query string으로 전달
			
			HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
			
			try
			{
				kakaoPayApprove = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_APPROVE_URL), body, KakaoPayApprove.class);
				
				if(kakaoPayApprove != null)
				{
					logger.debug("=================================");
					logger.debug("[KakaoPayService] kakaoPayApprove : " + kakaoPayApprove);
					logger.debug("=================================");
				}
			}
			catch(URISyntaxException e) 
			{
				logger.error("[KakaoPayService] kakaoPayApprove Exception", e);
			}
		}
		else
		{
			logger.error("[KakaoPayService] kakaoPayApprove kakaoPayOrder is null");
		}
		
		return kakaoPayApprove;
	}
}
