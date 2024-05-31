<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<title>WithSports</title>
<script>
$(document).ready(function(){
	$("#btnWrite").on("click", function(){
		location.href = "/board/promWrite";
	});
	
	$("#btnSearch").on("click", function(){
		document.promForm.searchType.value = $("#_searchType").val();
		document.promForm.searchValue.value = $("#_searchValue").val();
		document.promForm.curPage.value = "1";
		document.promForm.action = "/board/promList";
		document.promForm.submit();
	});
});

function fn_view(promSeq)
{
	document.promForm.promSeq.value = promSeq;
	document.promForm.action = "/board/promView";
	document.promForm.submit();
}

function fn_list(curPage)
{
	document.promForm.curPage.value = curPage;
	document.promForm.action = "/board/promList";
	document.promForm.submit();
}
</script>
</head>
<body>
  <%@ include file="/WEB-INF/views/include/header.jsp" %>
  <main id="main">
    <section>
      <div class="container">
        <div class="row">
          <div class="col-md-9"  data-aos="fade-up">
            <div class="logo mb-5 align-items-center">
                <h1 class="text-center">대회 정보</h1>
            </div>

            <div class="col-12 float-sm-end">
              <div class="search-form d-md-flex float-end">
                <select name="_searchType" id="_searchType" class="form-select me-1" style="width:110px; height:40px;"aria-label="Default select example">
                    <option value="">조회항목</option>
                    <option value="1" <c:if test='${searchType eq "1"}'>selected</c:if>>작성자</option>
                    <option value="2" <c:if test='${searchType eq "2"}'>selected</c:if>>행사종목</option>
                    <option value="3" <c:if test='${searchType eq "3"}'>selected</c:if>>행사명</option>
                </select>
                <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control w-50 me-1" placeholder="Search" aria-label="Recipient's username" aria-describedby="basic-addon2">
                <button type="button" id="btnSearch" class="btn btn-primary">Search</button>
              </div>
            </div><br/><br/>

            <!--대회 리스트 시작(게시물 5개씩 추천)-->
<c:if test="${!empty list}">      
 	<c:forEach var="prom" items="${list}" varStatus="status">
            <div class="d-md-flex post-entry-2 half my-5">
                <div class="me-4 ratio ratio-16x9 p-3" style="width:400px; height:250px;">
                <c:choose>
                <c:when test="${prom.promFileExt eq 'jpg' or prom.promFileExt eq 'png' or prom.promFileExt eq 'jpeg'}">
              	<img src="../resources/promUpload/${prom.promFileName}" alt="" class="img-fluid" onclick="fn_view(${prom.promSeq})"><br />
              	</c:when>
              	<c:otherwise>
                    <img class="" src="/resources/assets/img/revImage.png" alt="대회포스터" onclick="fn_view(${prom.promSeq})">
                </c:otherwise>
                </c:choose>
                </div>
                <div>
                    <div class="post-meta w-200" style="width: 500px;">
                        <span class="mx-1"></span><span class="date">${prom.promRegDate}</span><span class="mx-1">&bullet;</span>
                        <span class="mx-1 float-end">
                            <img src="/resources/assets/img/pm-like.png" class="me-1" style="width:15px;height:15px;">${prom.promLikeCnt}&nbsp;
                            <img src="/resources/assets/img/pm-view.png" class="me-1" style="width:22px;height:20px;">${prom.promReadCnt}
                        </span>
                    </div>
                    <h3><a onclick="fn_view(${prom.promSeq})">${prom.promTitle}</a></h3>
                    <ul class="list-unstyled">
                        <li>- 모집기간 : ${prom.promMoSdate} ~ ${prom.promMoEdate}</li>
                        <li>- 행사일자 : ${prom.promCoSdate} ~ ${prom.promCoEdate}</li>
                        <li>- 행사장소 : ${prom.promAddr}</li>
                        <li>- 모집인원 : ${prom.promJoinCnt}/${prom.promLimitCnt} (명)</li>
                        <li>- 주최자 : ${prom.coName}</li>
                    </ul>
                    
                     <div style="width:500px">
<script>
	date1 = '${prom.promMoEdate}';
	date3 = '${prom.promMoSdate}';
	
	today = new Date();   

	year = today.getFullYear(); // 년도
	month = today.getMonth() + 1;  // 월
	date = today.getDate();  // 날짜
	day = today.getDay();  // 요일
	
	month = ('0' + (today.getMonth() + 1)).slice(-2);

	date2 = year + '.' + month + '.' + date;
	
	if(date1 >= date2 && date3 <= date2)
	{
		document.write("<button id='mozip' class='btn btn-primary float-end' disabled>모집중</button>");
	}
	else if(date3 > date2)
	{
		document.write("<button id='magam' class='btn btn-outline-secondary float-end' disabled>모집전</button>");
	}
	else
	{
		document.write("<button id='magam' class='btn btn-outline-secondary float-end' disabled>모집마감</button>");
	}
</script>                        
                    </div>    
                </div>
            </div>
	</c:forEach>
</c:if>  
            <!--대회 리스트 끝-->
            
            <div style="border-top:solid 1px gray"></div>
            <div class="col-12 float-sm-end mt-3">
<c:if test="${!empty cookieCoId}">
              <button id="btnWrite" class="btn btn-primary float-end">글쓰기</button>
</c:if>
            </div>
            
            <!-- 페이징 -->
            <div class="text-center py-4">
                <div class="custom-pagination">
                    <c:if test="${!empty paging}">
	<c:if test="${paging.prevBlockPage gt 0}" >
                  <a class="prev" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">Previous</a>
    </c:if>
    <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
    	<c:choose>
    		<c:when test="${i eq curPage}" >
                  <!--선택된 페이지-->
                  <a  class="active" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a>
            </c:when>
            <c:otherwise>
                  <!--선택되지 않은 페이지-->
                  <a href="javascript:void(0)" onclick="fn_list(${i})">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>            
	<c:if test="${paging.nextBlockPage gt 0}" >
                  <a class="next" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">Next</a>
    </c:if>
</c:if>
                </div>
            </div>
            <!-- 페이징 -->
        </div>

        <div class="col-md-3">    
            <!-- ======= Sidebar ======= -->
                <div class="aside-block">
    
                <ul class="nav nav-pills custom-tab-nav mb-4" id="pills-tab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="pills-popular-tab" data-bs-toggle="pill" data-bs-target="#pills-popular" type="button" role="tab" aria-controls="pills-popular" aria-selected="true">Popular</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="pills-trending-tab" data-bs-toggle="pill" data-bs-target="#pills-trending" type="button" role="tab" aria-controls="pills-trending" aria-selected="false">Trending</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="pills-latest-tab" data-bs-toggle="pill" data-bs-target="#pills-latest" type="button" role="tab" aria-controls="pills-latest" aria-selected="false">Latest</button>
                    </li>
                </ul>
    
                <div class="tab-content" id="pills-tabContent">
    
                    <!-- 좋아요순-->
                    <div class="tab-pane fade show active" id="pills-popular" role="tabpanel" aria-labelledby="pills-popular-tab">
                        <!--리스트 시작(8개추천)-->
                        <div class="post-entry-1 border-bottom">
                          <div class="post-meta" style="width:300px">
                            <span class="date">대회종목</span> <span>&bullet;</span>
                            <span class="float-end">
                              <img src="/resources/assets/img/pm-like.png" class="me-1" style="width:22px;height:20px;margin-bottom:0px;">
                              <span>추천수</span>
                            </span>
                          </div>
<c:if test="${!empty likeList}">      
 	<c:forEach var="promk" items="${likeList}" varStatus="status">
                          <div class="post-meta">
                            <h2 class="my-3 d-flex" style="width:300px"><a onclick="fn_view(${promk.promSeq})">${promk.promTitle}</a></h2>
                            <span class="d-block mb-1 me-2">좋아요 : ${promk.promLikeCnt}</span>
                            <span class="d-block mb-1 me-2">행사일자 : ${promk.promCoSdate} ~ ${promk.promCoEdate}</span>
                            <span class="mb-3 me-2 d-block">${promk.coName}</span>
                          </div>
    </c:forEach>
</c:if>
                        </div>

                        <!--리스트 끝-->
                    </div>
                    <!-- 좋아요순 끝 -->
    
                    <!-- 조회수 시작 -->
                    <div class="tab-pane fade" id="pills-trending" role="tabpanel" aria-labelledby="pills-trending-tab">
                        <!--리스트 시작-->
                        <div class="post-entry-1 border-bottom">
                          <div class="post-meta" style="width:300px">
                            <span class="date">대회종목</span> <span>&bullet;</span>
                            <span class="float-end">
                              <img src="/resources/assets/img/pm-view.png" class="me-1" style="width:22px;height:20px;margin-bottom:0px;">
                              <span>조회수</span>
                            </span>
                          </div>
<c:if test="${!empty readList}">      
 	<c:forEach var="promt" items="${readList}" varStatus="status">
                          <div class="post-meta">
                            <h2 class="my-3 d-flex" style="width:300px"><a onclick="fn_view(${promt.promSeq})">${promt.promTitle}</a></h2>
                            <span class="d-block mb-1 me-2">조회수 : ${promt.promReadCnt}</span>
                            <span class="d-block mb-1 me-2">행사일자 : ${promt.promCoSdate} ~ ${promt.promCoEdate}</span>
                            <span class="mb-3 me-2 d-block">${promt.coName}</span>
                          </div>
    </c:forEach>
</c:if>
                        </div>
                        <!--리스트 끝-->
                    </div>
                    <!-- 조회수 끝 -->
    
                    <!-- 최신순 -->
                    <div class="tab-pane fade" id="pills-latest" role="tabpanel" aria-labelledby="pills-latest-tab">
                        <!--리스트 시작-->
                        <div class="post-entry-1 border-bottom">
                          <div class="post-meta" style="width:300px">
                            <span class="date">대회종목</span> <span class="mx-1">&bullet;</span>
                            <span class="float-end">NEW!
                              <!-- <img src="../img/pm-latest.png" class="me-1" style="width:22px;height:20px;margin-bottom:0px;"> -->
                            </span>
                          </div>
<c:if test="${!empty leastList}">      
 	<c:forEach var="proms" items="${leastList}" varStatus="status">
                          <div class="post-meta">
                            <h2 class="my-3 d-flex" style="width:300px"><a onclick="fn_view(${proms.promSeq})">${proms.promTitle}</a></h2>
                            <span class="d-block mb-1 me-2">등록일 : ${proms.promRegDate}</span>
                            <span class="d-block mb-1 me-2">행사일자 : ${proms.promCoSdate} ~ ${proms.promCoEdate}</span>
                            <span class="mb-3 me-2 d-block">${proms.coName}</span>
                          </div>
    </c:forEach>
</c:if>
                        </div>
                        <!--리스트 끝-->
                    </div>
                    <!-- 최신순 끝 -->
    
                </div>
            </div>
    
            </div>
        </div>
    </section>
    <form name="promForm" id="promForm" method="post">
		<input type="hidden" name="promSeq" value="" />
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>
</main><!-- End #main -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>