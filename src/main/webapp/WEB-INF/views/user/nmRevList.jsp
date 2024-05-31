<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<title>WithSports</title>
<script type="text/javascript">
function fn_list(curPage)
{
	document.revForm.curPage.value = curPage;
	document.revForm.action = "/board/nmRevList";
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
        <section>
            <div class="container" data-aos="fade-up">
                <div class="row">
                    <div class="col-lg-12 text-center mb-5">
                        <h1 class="page-title">My Page</h1>
                    </div>
                </div>

                <!--sub 네비게이션 시작-->
                <nav class="navbar navbar-expand-lg justify-content-center mb-3">
                    <div class="align-items-center">
                    <div class="collapse navbar-collapse align-items-center" id="navbarNavDropdown">
                        <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link nav" href="/user/nmMyPage">회원정보</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/user/nmJoinList">참여기록</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" disabled>작성글</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/user/nmLikeList">관심글</a>
                        </li>
                        </ul>
                    </div>
                    </div>
                </nav>
                <!--sub 네비게이션 끝-->
                <div class="mb-5 mt-5">
                    <h2 class="text-center">작성글</h2>
                </div>

                <div class="row justify-content-center">
                    
                    <table class="table table-ws w-75 p-3">
                        <thead class="mb-5">
                            <tr>
                                <th scope="col" class="text-center" style="width:10%">번호</th>
                                <th scope="col" class="text-center" style="width:47%">제목</th>
                                <th scope="col" class="text-center" style="width:13%">작성자</th>
                                <th scope="col" class="text-center" style="width:20%">날짜</th>
                                <th scope="col" class="text-center" style="width:10%">조회수</th>
                            </tr>
                        </thead>

                        <!--c:if-->
<c:if test="${!empty list}">      
 	<c:forEach var="rev" items="${list}" varStatus="status">
 		<c:set var="i" value="${i + 1}" />
 		<tbody>
          <tr class="justify-content-center ws-list-hove">
              <td class="text-center"><p>${i}</p></td>
              <td class="ps-5">
                  <p><a href="javascript:void(0)" onclick="fn_view(${rev.revSeq})">${rev.revTitle}</a></p>
                  <!--첨부파일 있을 경우-->
                  <!--<img class="ws-list-img" src="/resources/assets/img/revImage.png">-->
                  <!--첨부파일 있을 경우 끝-->
              </td>
              <td class="text-center">${rev.nmNickname}</td>
              <td class="text-center">${rev.revRegDate}</td>
              <td class="text-center">
                  <fmt:formatNumber type="number" maxFractionDigits="3" value="" />${rev.revReadCnt}
              </td>
          </tr>
      </tbody>
	</c:forEach>
</c:if>  

                        <tfoot>
                            <tr>
                                <td colspan="5"></td>
                            </tr>
                        </tfoot>
                    </table>
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
                  <a class="active" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a>
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
			</div>
        </section>
<form name="revForm" id="revForm" method="post">
	<input type="hidden" name="revSeq" value="" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>
    </main><!-- End #main -->

   <%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>