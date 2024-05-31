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

function fn_list(curPage)
{
	document.promForm.curPage.value = curPage;
	document.promForm.action = "/board/promList";
	document.promForm.submit();
}
</script>
</head>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
  <main id="main">
    <section>
      <div class="container" data-aos="fade-up">
        <div class="row">
          <div class="col-lg-12 text-center mb-5">
            <h3 class="page-title">Company Page</h3>
          </div>
        </div>
    </section>    
    <div class="container">
        <div class="row">
          <div class="col-md-12"  data-aos="fade-up">
            <div class="logo mb-5 align-items-center">
                <h1 class="text-center">작성글 목록</h1>
                <p class="text-center mt-3">*대회 정보 삭제 요청은 관리자에게 문의바랍니다.</p>
            </div>
          </div>
        <!--대회 리스트 시작(게시물 5개씩 추천)-->

        <div class="row justify-content-center">
                    
            <table class="table table-ws w-75 p-3">
                <thead class="mb-5">

                </thead>

                <!--c:if-->
<c:if test="${!empty list}">      
 	<c:forEach var="prom" items="${list}" varStatus="status">
                <tbody>
                    <!--리스트 시작-->
                    <tr>
                        <div class="d-md-flex half my-5 justify-content-center">
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
                            <div class="justify-content-center">
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
                    </tr>
                    <!--리스트 끝-->
                    
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

        <div class="row mb-5 ">
    </div>
    <form name="promForm" id="promForm" method="post">
		<input type="hidden" name="promSeq" value="" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>
  </main><!-- End #main -->

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>

</html>