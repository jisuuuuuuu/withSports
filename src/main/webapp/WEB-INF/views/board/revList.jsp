<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<title>WithSports</title>
<script type="text/javascript">
$(document).ready(function(){
	
	$('#pills-popular').css('display', 'block');
	$('#pills-trending').css('display', 'none');
	
	$("#btnSearch").on("click", function(){
		document.revForm.searchType.value = $("#_searchType").val();
		document.revForm.searchValue.value = $("#_searchValue").val();
		document.revForm.curPage.value = "1";
		document.revForm.action = "/board/revList";
		document.revForm.submit();
	});
	
	$("#btnWrite").on("click", function(){
		document.revForm.action = "/board/revWrite";
		document.revForm.submit();
	});
	
	$("#pills-popular-tab").on("click", function(){
		$('#pills-popular').css('display', 'block');
		$('#pills-trending').css('display', 'none');
	});
	
	$("#pills-trending-tab").on("click", function(){
		$('#pills-trending').css('display', 'block');
		$('#pills-popular').css('display', 'none');
	});
	
});

function fn_list(curPage)
{
	document.revForm.curPage.value = curPage;
	document.revForm.action = "/board/revList";
	document.revForm.submit();
}

function fn_view(revSeq)
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

    <!-- ======= Search Results ======= -->
    <section id="search-result" class="search-result">
      <div class="container">
       
            <h3 class="category-title">자유게시판</h3>
<c:if test="${!empty cookieNmId or !empty cookieCoId}">
			<input type="button" name="btnWrite" id="btnWrite" class="btn btn-primary" value="글쓰기" style="float:right;">
</c:if>
            <!-- 게시글 정렬 -->
			<div class="aside-block">
              <ul class="nav nav-pills custom-tab-nav mb-4" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                	<!--  해당 버튼이 선택되면 aria-selected가 true -->
                  <button class="nav-link active" id="pills-popular-tab" data-bs-toggle="pill" data-bs-target="#pills-popular" type="button" role="tab" aria-selected="true">전체</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="pills-trending-tab" data-bs-toggle="pill" data-bs-target="#pills-trending" type="button" role="tab"aria-selected="false">기업게시물</button>
                </li>
               </ul>
              </div>

<div class="tab-pane fade show active" id="pills-popular">
 <c:if test="${!empty list}">      
 	<c:forEach var="rev" items="${list}" varStatus="status">
	       <div class="d-md-flex post-entry-2 small-img border-bottom">
              	<div>
	                <div class="post-meta"><span class="date">작성일 :
<script>
	var timeValue = new Date('${rev.revRegDate}');
	var today = new Date();
	
	var betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);
	var betweenTimeHour = Math.floor(betweenTime / 60);
	var betweenTimeDay = Math.floor(betweenTime / 60 / 24);
	
    if (betweenTime < 1){
    	document.write("방금전");
    }
    else if (betweenTime < 60) {
        document.write(betweenTime + "분전");
    }
    else if (betweenTimeHour < 24) {
        document.write(betweenTimeHour + "시간전");
    }
    else if (betweenTimeDay < 365) {
        document.write(betweenTimeDay + "일전");
    }
    else
    {
    	document.write(betweenTimeDay / 365 + "년전");
    }
</script>	        </span> <span class="mx-1">&bullet;</span> <span>조회수 : ${rev.revReadCnt}</span></div>
	                <h3><a onclick="fn_view(${rev.revSeq})">${rev.revTitle}</a></h3>
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
	  <!-- 검색 -->
	  <div class="row justify-content-center mt-5">
	       <select name="_searchType" id="_searchType" class="custom-select " style="width:auto;height:45px;">
	          <option value="">조회 항목</option>
	          <option value="1" <c:if test='${searchType eq "1"}'>selected</c:if>>작성자</option>
              <option value="2" <c:if test='${searchType eq "2"}'>selected</c:if>>제목</option>
              <option value="3" <c:if test='${searchType eq "3"}'>selected</c:if>>내용</option>
	       </select>
	       <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:auto;ime-mode:active;height:45px;" placeholder="조회값을 입력하세요." />
	       <button type="button" id="btnSearch" class="btn btn-secondary mb-3 mx-1" style="width:auto;height:43px;">조회</button>
	  </div>
	<!-- 이거 도대체 왜 가로 정렬이 안될까 -->
      <!-- 검색 끝 -->
      

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
       <!-- 페이징 끝 -->

		<form name="revForm" id="revForm" method="post">
			<input type="hidden" name="revSeq" value="" />
			<input type="hidden" name="searchType" value="${searchType}" />
			<input type="hidden" name="searchValue" value="${searchValue}" />
			<input type="hidden" name="curPage" value="${curPage}" />
		</form>
</div>

<div class="tab-pane fade" id="pills-trending" >
<c:if test="${!empty listCo}">      
 	<c:forEach var="revCo" items="${listCo}" varStatus="status">
	       <div class="d-md-flex post-entry-2 small-img border-bottom">
              	<div>
	                <div class="post-meta"><span class="date">작성일 : ${revCo.revRegDate} </span> <span class="mx-1">&bullet;</span> <span>조회수 : ${revCo.revReadCnt}</span></div>
	                <h3><a onclick="fn_view(${revCo.revSeq})">${revCo.revTitle}</a></h3>
	                <div class="d-flex align-items-center author">
	                  <div class="name">
	            <c:choose>
	              <c:when test='${revCo.nmNickname ne "1"}'>
	                  	<div><h3 class="m-0 p-0"><i class="bi bi-person-circle"></i>${revCo.nmNickname}</h3></div>
	              </c:when>
	              <c:when test='${revCo.nmId eq "co"}'>
	              		<div><h3 class="m-0 p-0"><i class="bi bi-buildings"></i>${revCo.coName}</h3></div>
	              </c:when>
	            </c:choose>
	                  </div>
	                </div>
	              </div>
	         </div>
	</c:forEach>
</c:if>  


</div>
	 </div> <!-- container 끝 -->
    </section> <!-- End Search Result -->
  </main><!-- End #main -->

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>