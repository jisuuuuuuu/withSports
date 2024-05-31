<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<script>
$(document).ready(function(){
	$("#btnList").on("click", function(){
		document.promForm.curPage.value = "1";
		document.promForm.action = "/board/promList";
		document.promForm.submit();
	});
	
	$("#btnUpdate").on("click", function(){
	document.promForm.action = "/board/promUpdate";
	document.promForm.submit();
	});
	
	$("#btnLike").on("click", function(){
		if(${like.getNmId() eq cookieNmId})
		{
			$.ajax({
				type:"POST",
				url:"/board/nmLike",
				data:{
					promSeq:${promSeq}
				},
				datatype:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response){
					if(response.code == 0)
					{
						document.promForm.action = "/board/promView";
						document.promForm.submit();
					}
					else if(response.code == 503)
					{
						alert("좋아요를 누른적 없는 게시물입니다.");
						document.promForm.action = "/board/promView";
						document.promForm.submit();
					}
					else
					{
						alert("오류가 발생했습니다.");
					}
				},
				error:function(xhr, status, error){
					icia.common.error(error);
				}
			}); 
		}
		else
		{
			$.ajax({
				type:"POST",
				url:"/board/nmDeleteLike",
				data:{
					promSeq:${promSeq}
				},
				datatype:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response){
					if(response.code == 0)
					{
						document.promForm.action = "/board/promView";
						document.promForm.submit();
					}
					else if(response.code == 503)
					{
						alert("이미 처리된 게시물입니다.");
						document.promForm.action = "/board/promView";
						document.promForm.submit();
					}
					else
					{
						alert("오류가 발생했습니다.");
					}
				},
				error:function(xhr, status, error){
					icia.common.error(error);
				}
			}); 
		}
	});
});

function fn_sinchoug(){
	if(confirm("신청하시겠습니까?") == true)
	{
		$.ajax({
			type:"POST",
			url:"/board/nmJoin",
			data:{
				promSeq:${promSeq}
			},
			datatype:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("신청이 완료되었습니다.");
					document.promForm.action = "/board/promView";
					document.promForm.submit();
				}
				else if(response.code == -1)
				{
					alert("이미 신청한 게시물입니다.");
				}
				else if(response.code == 800)
				{
					alert("모집이 마감되었습니다.");
				}
				else
				{
					alert("오류가 발생했습니다.");
				}
			},
			error:function(xhr, status, error){
				icia.common.error(error);
			}
		}); 
	}
}

function fn_view(promSeq)
{
	document.promForm.promSeq.value = promSeq;
	document.promForm.action = "/board/promView";
	document.promForm.submit();
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
  <main id="main">

    <section class="single-post-content">
      <div class="container">
        <div class="row">
          <div class="col-md-9 post-content" data-aos="fade-up">

          <!-- ======= Single Post Content ======= -->
          <div class="single-post">
            <div class="post-meta"><span class="date">${prom.getPromCate()}</span> <span class="mx-1">&bullet;</span> <span>${prom.getPromRegDate()}</span></div>
            <h1 class="mb-5">${prom.getPromTitle()}</h1>
            <div class="post-meta" style="text-align: right;">
              <p>조회수 : ${prom.getPromReadCnt()}    좋아요수 : ${prom.getPromLikeCnt()}</p>
            </div>
      
            <div class="row gy-4">

              <div class="col-md-4">
                <div class="info-item">
                  <i class="bi bi-buildings"></i>
                  <h3>주최단체</h3>
                  <p>${prom.getCoName()}</p>
                </div>
              </div>
    
              <div class="col-md-4">
                <div class="info-item info-item-borders">
                  <i class="bi bi-calendar"></i>
                  <h3>접수기간</h3>
                  <p>${prom.getPromMoSdate()} ~ ${prom.getPromMoEdate()}</p>
                </div>
              </div>
    
              <div class="col-md-4">
                <div class="info-item">
                  <i class="bi bi-calendar-check"></i>
                  <h3>대회일시</h3>
                  <p>${prom.getPromCoSdate()} ~ ${prom.getPromCoEdate()}</p>
                </div>
              </div>

              <div class="col-md-4">
                <div class="info-item">
                  <i class="bi bi-person-walking"></i>
                  <h3>대회종목</h3>
                  <p>${prom.getPromCate()}</p>
                </div>
              </div>
    
              <div class="col-md-4">
                <div class="info-item info-item-borders">
                  <i class="bi bi-envelope"></i>
                  <h3>Email</h3>
                  <p><a href="mailto:info@example.com">${prom.getCoEmail()}</a></p>
                </div>
              </div>
    
              <div class="col-md-4">
                <div class="info-item">
                  <i class="bi bi-phone"></i>
                  <h3>전화번호</h3>
                  <p><a href="tel:+155895548855">${prom.getCoTel()}</a></p>
                </div>
              </div>

              <div class="col-md-4">
                <div class="info-item">
                  <i class="bi bi-person-raised-hand"></i>
                  <h3>참가인원</h3>
                  <p>${prom.getPromJoinCnt()}/${prom.getPromLimitCnt()}</p>
                </div>
              </div>
    
              <div class="col-md-4">
                <div class="info-item info-item-borders">
                  <i class="bi bi-coin"></i>
                  <h3>참가비</h3>
                  <p>${prom.getPromPrice()}원</p>
                </div>
              </div>
    
            </div>

            <c:if test="${prom.getPromFile().getPromFileExt() eq 'jpg' or prom.getPromFile().getPromFileExt() eq 'png' or prom.getPromFile().getPromFileExt() eq 'jpeg'}">
            <img src="../resources/promUpload/${prom.getPromFile().getPromFileName()}" alt="" class="img-fluid">
            </c:if>

            <p>${prom.getPromContent()}</p>

<br /><br />
			 <div class="col-md-4">
                <div class="info-item info-item-borders">
                  <i class="bi bi-geo-fill"></i>
                  <h3>대회장소</h3>
                </div>
              </div>
<br />              
              <!-- 지도 API 위치 -->
              <div id="map" style="width:500px;height:400px;t"></div>
              <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c54322aa42766cc04dea6dc3a80e84bc&libraries=services,clusterer,drawing"></script>
			  <script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = {
				        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };  
				
				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption); 
				
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
				
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch('${prom.getPromAddr()}', function(result, status) {
				
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
				
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				
				        // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new kakao.maps.Marker({
				            map: map,
				            position: coords
				        });
				
				        // 인포윈도우로 장소에 대한 설명을 표시합니다
				        var infowindow = new kakao.maps.InfoWindow({
				            content: '<div style="width:150px;text-align:center;padding:6px 0;">행사장소</div>'
				        });
				        infowindow.open(map, marker);
				
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				    } 
				});    
				</script>
				
				 <br /><br />
<c:if test="${!empty prom.getPromFile()}" >
			  <div class="border-top border-bottom"><br />
              &nbsp;&nbsp;&nbsp;<a href="/board/downloadProm?promSeq=${prom.getPromSeq()}" style="color:#000;">[첨부파일 : <c:out value="${prom.getPromFile().getPromFileOrgName()}" />]</a>
              <br /><br />
              </div>
</c:if>  

              <br /><br />
              
              <div class="col-md-9 d-flex justify-content-sm-beetween" style="">
	              <div class="col-12" style="">
	                  <button class="btn btn-primary" id="btnList" value="Post comment">리스트</button>
	              </div>
	
	              <!--css적용 확인용 jquery-->
	              <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	              <div class="col-12" style="">
	              <c:choose>
	              	<c:when test="${!empty cookieNmId}">
	              	  <!-- 모두에게 보일때.. -->
	              	  <c:choose>
	              	  <c:when test="${like.getNmId() eq cookieNmId}">
	                  <button id="btnLike" class="btn btn-like after"><i class="bi bi-heart" aria-hidden="true"></i> Like</button>
	                  </c:when>
	                  <c:otherwise>
	                  <button id="btnLike" class="btn btn-like"><i class="bi bi-heart" aria-hidden="true"></i> Like</button>
	                  </c:otherwise>
	                  </c:choose>
	                  <script>
						date1 = '${prom.promMoEdate}';
						date3 = '${prom.promMoSdate}';
						
						today = new Date();   
					
						year = today.getFullYear(); // 년도
						month = today.getMonth() + 1;  // 월
						date = today.getDate();  // 날짜
						day = today.getDay();  // 요일
						
						month = ('0' + (today.getMonth() + 1)).slice(-2);
					
						date2 = year + '-' + month + '-' + date;
						
						if(date1 >= date2 && date3 <= date2)
						{
							document.write('<button onclick="fn_sinchoug()" class="btn btn-primary" value="Post comment">신청하기</button>');
						}
						else
						{
							document.write("<button class='btn btn-outline-secondary' disabled>신청불가</button>");
						}
					</script>
	                </c:when>
	                <c:when test="${cookieCoId eq prom.getCoId()}">
	                  <!-- 내게시글 일때만 보이게...-->
	                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  <button id="btnUpdate" class="btn btn-primary" value="Post comment" >수정</button>
					</c:when>
				  </c:choose>
	                  <!--좋아요 버튼 css-->
	                  <style>
	                    .btn-like {
	                      background-color: var(--color-white);
	                      color: var(--color-black);
	                      border-color: var(--color-gray);
	                    }
	
	                    .btn-like-after{
	                      background-color: var(--color-red);
	                      color: var(--color-white);
	                      border-color: var(--color-red);
	                    }
	                  </style>
	              </div>
	            </div>
<form name="promForm" id="promForm" method="post">
	<input type="hidden" name="promSeq" value="${promSeq}" />
	<input type="hidden" name="searchType" value="${searchType}" />
	<input type="hidden" name="searchValue" value="${searchValue}" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>
          </div><!-- End Single Post Content -->

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
      </div>
    </section>
  </main><!-- End #main -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>