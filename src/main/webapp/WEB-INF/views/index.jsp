<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<title>WithSports</title>
<script>
function fn_view(promSeq)
{
	document.promForm.promSeq.value = promSeq;
	document.promForm.action = "/board/promView";
	document.promForm.submit();
}

function fn_view2(revSeq)
{
	document.revForm.revSeq.value = revSeq;
	document.revForm.action = "/board/revView";
	document.revForm.submit();
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
  <main id="main">

    <!-- ======= Hero Slider Section ======= -->
    <section id="hero-slider" class="hero-slider">
      <div class="container-md" data-aos="fade-in">
        <div class="row">
          <div class="col-12">
            <div class="swiper sliderFeaturedPosts">
              <div class="swiper-wrapper">
<c:if test="${!empty list}">      
 	<c:forEach var="prom" items="${list}" varStatus="status">
 		<div class="swiper-slide">
 			<c:choose>
	            <c:when test="${prom.promFileExt eq 'jpg' or prom.promFileExt eq 'png' or prom.promFileExt eq 'jpeg'}">
		            <a class="img-bg d-flex align-items-end" style="background-image: url('../resources/promUpload/${prom.promFileName}');">
		            <div class="img-bg-inner">
	               	<h2>${prom.promTitle}</h2>
	               	<p>${prom.promAddr} <br /> ${prom.coName}</p>
	             	</div>
	           		</a>
	          	</c:when>
	          	<c:otherwise>
	            	<a href="single-post.html" class="img-bg d-flex align-items-end" style="background-image: url('/resources/assets/img/main2.PNG');">
	            	<div class="img-bg-inner">
	               	<h2>${prom.promTitle}</h2>
	               	<p>${prom.promAddr} <br /> ${prom.coName}</p>
	             	</div>
	           		</a>
	            </c:otherwise>
            </c:choose>
        </div>
	</c:forEach>
</c:if>
                </div>
              </div>
              <div class="custom-swiper-button-next">
                <span class="bi-chevron-right"></span>
              </div>
              <div class="custom-swiper-button-prev">
                <span class="bi-chevron-left"></span>
              </div>

              <div class="swiper-pagination"></div>
            </div>
          </div>
        </div>
      </div>
    </section><!-- End Hero Slider Section -->
    
    <!-- ======= 대회정보 Section ======= -->
    <section class="category-section">
      <div class="container" data-aos="fade-up">

        <div class="section-header d-flex justify-content-between align-items-center mb-5">
          <h2>대회정보</h2>
          <div><a href="/board/promList" class="more">전체보기</a></div>
        </div>

        <div class="row g-5">
<c:if test="${!empty list}">      
 	<c:forEach var="prom" items="${list}" varStatus="status">
          <div class="col-lg-4"> <!-- 첫번째 블럭, 사진 크게 보여주고 싶은 내용 -->
            <div class="post-entry-1 lg">
            <c:choose>
                <c:when test="${prom.promFileExt eq 'jpg' or prom.promFileExt eq 'png' or prom.promFileExt eq 'jpeg'}">
              	<a onclick="fn_view(${prom.promSeq})"><img src="../resources/promUpload/${prom.promFileName}" alt="" class="img-fluid"></a>
              	</c:when>
              	<c:otherwise>
                 <a onclick="fn_view(${prom.promSeq})" ><img class="" src="/resources/assets/img/revImage.png" alt="대회포스터" class="img-fluid" style="width:300px; height:250px;"></a>
                </c:otherwise>
                </c:choose>
              <div class="post-meta"><span>${prom.promRegDate}</span></div>
              <h2><a onclick="fn_view(${prom.promSeq})">${prom.promTitle}</a></h2>
			  <ul class="mb-4 d-block">
			  <li>- 모집기간 : ${prom.promMoSdate} ~ ${prom.promMoEdate}</li>
          	  <li>- 행사일자 : ${prom.promCoSdate} ~ ${prom.promCoEdate}</li></ul>
            </div>
          </div>
	</c:forEach>
</c:if>

		<div class="section-header d-flex justify-content-between align-items-center mb-5">
          <h2>자유게시판</h2>
          <div><a href="/board/revList" class="more">전체보기</a></div>
        </div>
        <div class="aside-block">
<c:if test="${!empty list2}">      
 	<c:forEach var="rev" items="${list2}" varStatus="status">
	       <div class="d-md-flex post-entry-2 small-img border-bottom">
              	<div>
	                <div class="post-meta"><span class="date">작성일 : ${rev.revRegDate} </span> <span class="mx-1">&bullet;</span> <span>조회수 : ${rev.revReadCnt}</span></div>
	                <h3><a onclick="fn_view2(${rev.revSeq})">${rev.revTitle}</a></h3>
	                <div class="d-flex align-items-center author">
	                  <div class="name">
	            <c:choose>
	              <c:when test='${rev.nmNickname ne "1"}'>
	                  	<div><h3 class="m-0 p-0"><i class="bi bi-person-circle"></i>${rev.nmNickname}</h3></div>
	              </c:when>
	              <c:when test='${rev.nmId eq "co"}'>
	              		<div><h3 class="m-0 p-0"><i class="bi bi-buildings"></i>${rev.coName}</h3></div>
	              </c:when>
	            </c:choose>
	                  </div>
	                </div>
	              </div>
	         </div>
	</c:forEach>
</c:if>  
		</div>
        </div> <!-- End .row -->
      </div>
    </section><!-- End 대회정보 Section -->
   <form name="promForm" id="promForm" method="post">
		<input type="hidden" name="promSeq" value="" />
	</form>
	
	<form name="revForm" id="revForm" method="post">
			<input type="hidden" name="revSeq" value="" />
	</form>
  </main><!-- End #main -->

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>