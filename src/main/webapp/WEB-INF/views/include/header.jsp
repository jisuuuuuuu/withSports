<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sist.common.util.CookieUtil"%>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!-- ======= Header ======= -->
  <header id="header" class="header d-flex align-items-center fixed-top">
    <div class="container-fluid container-xl d-flex align-items-center justify-content-between">

      <a href="/index" class="logo d-flex align-items-center">
        <!-- Uncomment the line below if you also wish to use an image logo -->
        <!-- <img src="/resources/assets/img/logo.png" alt=""> -->
        <h1>WithSports</h1>
      </a>

      <nav id="navbar" class="navbar">
        <ul>
          <li><a href="/board/promList">대회정보</a></li>
          <li><a href="/board/revList">자유게시판</a></li>
<%
if(CookieUtil.getCookie(request, "NM_ID") != null)
{
%>
          <li><a href="/user/nmMyPage">마이페이지</a></li> <!-- 쿠키 존재 여부에 따라 다르게 보이도록 -->
<%
}
else if(CookieUtil.getCookie(request, "CO_ID") != null)
{
%>
          <li><a href="/user/coMyPage">기업마이페이지</a></li> <!-- 쿠키 존재 여부에 따라 다르게 보이도록 -->
<%
}
%>
        </ul>
      </nav><!-- .navbar -->

      <div class="position-relative">
<%
if(CookieUtil.getCookie(request, "NM_ID") != null || CookieUtil.getCookie(request, "CO_ID") != null)
{
%>
       <a href="/user/logOut"><b>로그아웃</b></a>
<%
}
else
{
%>
		<a href="/user/login"><b>로그인</b></a>&nbsp;&nbsp;
       <a href="/user/signUp"><b>회원가입</b></a>
<%
}
%>
       
       <!-- 로그인 성공 시  -->
       <!-- 누구누구님 환영합니다! -->
       
       <!-- 문제있는애들 일단 보류-->
        <a href="#" class="mx-2 js-search-open"></a>
		<button class="btn js-search-close"></button>
		
      </div>
    </div>

  </header><!-- End Header -->