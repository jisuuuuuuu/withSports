<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<title>WithSports</title>
</head>
<script type="text/javascript">
$(document).ready(function(){
	$("#btnUpload").on("click", function(){
		if($.trim($("#promTitle").val()).length <= 0)
		{
			$("#promTitle").val("");
			$("#promTitle").focus();
			return;
		}
		
		if(!fn_date($("#promMoSdate").val()))
		{
			$("#promMoSdate").val("");
			$("#promMoSdate").focus();
			return;
		}
		
		if(!fn_date($("#promMoEdate").val()))
		{
			$("#promMoEdate").val("");
			$("#promMoEdate").focus();
			return;
		}
		
		dateMoS = new Date($("#promMoSdate").val());
		dateMoE = new Date($("#promMoEdate").val());
		
		if(dateMoS > dateMoE)
		{
			alert("날짜를 확인해주세요.")
			$("#promMoEdate").val("");
			$("#promMoEdate").focus();
			return;
		}
		
		if(!fn_date($("#promCoSdate").val()))
		{
			$("#promCoSdate").val("");
			$("#promCoSdate").focus();
			return;
		}
		
		if(!fn_date($("#promCoEdate").val()))
		{
			$("#promCoEdate").val("");
			$("#promCoEdate").focus();
			return;
		}
		
		dateCoS = new Date($("#promCoSdate").val());
		dateCoE = new Date($("#promCoEdate").val());
		
		todate = new Date();   

		year = todate.getFullYear(); // 년도
		month = todate.getMonth() + 1;  // 월
		date = todate.getDate();  // 날짜
		day = todate.getDay();  // 요일
		
		month = ('0' + (todate.getMonth() + 1)).slice(-2);

		date2 = year + '-' + month + '-' + date;
		
		today = new Date(date2);
		
		if(today > dateCoS)
		{
			alert("대회시작일은 오늘 이전으로 지정할 수 없습니다.")
			$("#promCoSdate").val("");
			$("#promCoSdate").focus();
			return;
		}
		
		if(dateMoE > dateCoE)
		{
			alert("모집마감일보다 대회마감일이 이후 일 수 없습니다.")
			$("#promCoEdate").val("");
			$("#promCoEdate").focus();
			return;
		}
		
		if(dateCoS > dateCoE)
		{
			alert("날짜를 확인해주세요.")
			$("#promCoEdate").val("");
			$("#promCoEdate").focus();
			return;
		}
		
		if($.trim($("#promCate").val()).length <= 0)
		{
			$("#promCate").val("");
			$("#promCate").focus();
			return;
		}
		
		if($.trim($("#sample6_postcode").val()).length <= 0)
		{
			$("#sample6_postcode").val("");
			$("#sample6_postcode").focus();
			return;
		}
		
		if(fn_emptCheck($("#sample6_postcode").val()))
		{
			alert("공백을 포함할 수 없습니다.");
			$("#sample6_postcode").val("");
			$("#sample6_postcode").focus();
			return;
		}
		
		if(!fn_upwon($("#sample6_postcode").val()))
		{
			alert("우편번호는 5자리로 입력하세요.");
			$("#sample6_postcode").val("");
			$("#sample6_postcode").focus();
			return;
		}
		
		if($.trim($("#sample6_address").val()).length <= 0)
		{
			$("#sample6_address").val("");
			$("#sample6_address").focus();
			return;
		}
		
		$("#promAddr").val($("#sample6_address").val() + " " + $("#sample6_detailAddress").val() + "" + $("#sample6_extraAddress").val());
		
		if(!fn_number($("#promPrice").val()))
		{
			alert("슷자만 입력하세요.");
			$("#promPrice").val("");
			$("#promPrice").focus();
			return;
		}
		
		if(!fn_number($("#promLimitCnt").val()))
		{
			alert("슷자만 입력하세요.");
			$("#promLimitCnt").val("");
			$("#promLimitCnt").focus();
			return;
		}
		
		if($.trim($("#promContent").val()).length <= 0)
		{
			$("#promContent").val("");
			$("#promContent").focus();
			return;
		}
		
		var form = $("#promForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			type:"POST",
			url:"/board/promWriteProc",
			enctype:"multipart/form-data",
			data:formData,
		    processData:false,							//formData를 string으로 변환하지 않음
		    contentType:false,							//content-type헤더가 multipart/form-data로 전송
		    cache:false,
		    timeout:600000,
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					location.href = "/board/promList";
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 잘못 되었습니다.");
					$("#promTitle").focus();
				}
				else
				{
					alert("오류가 발생했습니다.");
					$("#promTitle").focus();
				}
			},
			error:function(xhr, status, error){
				icia.common.error(error);
			}
		});
	});
});

function fn_date(value)
{
	var date = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
	
	return date.test(value);
}

function fn_emptCheck(value)
{
	//공백체크
	var emptCheck = /\s/g;
	
	return emptCheck.test(value);
}

function fn_upwon(value)
{
	var num = /[0-9\-]{5}/;
	
	return num.test(value);
}

function fn_number(value)
{
	var num = /^[0-9]+$/;
	
	return num.test(value)
}
</script>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
  <main id="main">
    <section id="contact" class="contact mb-5">
      <div class="container" data-aos="fade-up">

        <div class="row">
          <div class="col-lg-12 text-center mb-5">
            <h1 class="page-title">글 쓰기</h1>
          </div>
        </div>
<form id="promForm" enctype="multipart/form-data">
        <div class="form mt-5">
          <div class="php-email-form">
            <table width="100%">
              <tr>
                <td width="10%">
                  게시물 제목 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <input type="text" class="form-control" name="promTitle" id="promTitle" placeholder="제목" required/>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  주최자 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <input type="text" class="form-control" name="coId" id="coId" value="${coUser.getCoName()}" placeholder="주최자" readonly/>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  모집 기간 : 
                </td>
                <td >
                  <div class="form-group">
                    <input type="date" class="form-control" name="promMoSdate" id="promMoSdate" required/>
                  </div>
                </td>
                <td width="10%">
                  <div class="form-group" style="text-align: center;">
                    ~
                  </div>
                </td>
                <td>
                  <div class="form-group">
                    <input type="date" class="form-control" name="promMoEdate" id="promMoEdate" required/>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  대회 일자 : 
                </td>
                <td >
                  <div class="form-group">
                    <input type="date" class="form-control" name="promCoSdate" id="promCoSdate" required/>
                  </div>
                </td>
                <td width="10%">
                  <div class="form-group" style="text-align: center;">
                    ~
                  </div>
                </td>
                <td>
                  <div class="form-group">
                    <input type="date" class="form-control" name="promCoEdate" id="promCoEdate" required/>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  대회 종목 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <input type="text" class="form-control" name="promCate" id="promCate" placeholder="대회 종목" required/>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  대회 장소 : 
                </td>
                <td colspan="3">
                  <div class="form-group" style="line-height:50%;">
                      <table>
                      	<tr>
                        	<td>
                        		<input class="form-control" type="text" id="sample6_postcode" placeholder="우편번호" required/>
                        	</td>
                            <td>
                            <input class="form-control" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"  style="background-color: lightgray;" />
                            </td>
                        </tr>
                      </table>
					  <input class="form-control" type="text" id="sample6_address" placeholder="주소" required />
				      <input class="form-control" type="text" id="sample6_detailAddress" placeholder="상세주소" />
				      <input class="form-control" type="text" id="sample6_extraAddress" placeholder="참고항목">
					  <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
					  <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
					  <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
					</div>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  대회 참가 비용 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <input type="text" class="form-control" name="promPrice" id="promPrice" placeholder="참가비용" style="width:300px;" required/>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  모집 인원 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <input type="text" class="form-control" name="promLimitCnt" id="promLimitCnt" placeholder="모집인원" style="width:300px;" required/>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  행사 내용 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <textarea class="form-control" name="promContent" id="promContent" style="height:300px; resize: none;"></textarea>
                  </div>
                </td>
              </tr>
              <tr>
                <td width="10%">
                  첨부 파일 : 
                </td>
                <td colspan="3">
                  <div class="form-group">
                    <input type="file" class="form-control" name="promFile" id="promFile" placeholder="Subject" />
                  </div>
                </td>
              </tr>
            </table>
            <div class="text-center"><button id="btnUpload" type="button">등록</button></div>
          </div>
        </div>
        <input type="hidden" name="promAddr" id="promAddr" value="" />
</form>
      </div>
    </section>

  </main><!-- End #main -->
  
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</html>