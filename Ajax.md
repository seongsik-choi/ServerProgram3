# 3) 서버 프로그래밍3 (구현) : Spring Boot
## AJAX 이후 [51]~
* **jQuery, Ajax, JSON, Spring Boot + Animation을 연동한 추천 시스템 구현**
* ★프로젝트 구현시 자주 구현되는 이론★
~~~
- jQuery, Ajax, JSON, Spring Boot + Animation을 연동한 조회 화면(read.jsp)에서의 추천구현(contents 테이블)
- Contenst table의 추천수(recom)를 사용할 경우 -> 중복 추천의 문제 발생

-> 하나의 테이블 생성 : 
1) 컨텐츠추천(contentsrecom)과 pk contentsrecomnno(컨텐츠추천번호)
2) (FK)로 컨텐츠 번호, 회원번호 관계 설정
3) 추천날짜(rdate) 생성
4) M:N 관계 개선
-> 실제 프로젝트 시 생성되는 테이블

-> 수업은 추천수(recom) 컬럼만으로 추천 구현(Contents Table)에서의 조회

1. SQL
▷ /webapp/WEB-INF/doc/dbms/contents_c.sql
-------------------------------------------------------------------------------------
UPDATE contents
SET recom = recom + 1
WHERE contentsno = 131;
commit;
-------------------------------------------------------------------------------------

▷ /src/main/resources/contents.xml 
-------------------------------------------------------------------------------------
  <!-- recom(추천수) AJAX-->
  <update id="update_recom" parameterType="int">
    UPDATE contents
    SET recom = recom + 1
    WHERE contentsno = #{contentsno }
  </update>      
-------------------------------------------------------------------------------------

3. DAO interface 4. Process interface
-------------------------------------------------------------------------------------
  /**
   * recom(추천수) AJAX
   * @param contentsVO
   * @return
   */
  public int update_recom(int contentsno);  
-------------------------------------------------------------------------------------

5. Process class
-------------------------------------------------------------------------------------
    // recom(추천수) AJAX
    @Override
    public int update_recom(int contentsno) {
      int cnt = this.contentsDAO.update_recom(contentsno);
      return cnt;
    }    
-------------------------------------------------------------------------------------

6. Controller class
-------------------------------------------------------------------------------------
  /**
   * recom(추천수) AJAX, 처리(POST) 방식만으로 구현, FORM(GET)이 필요가 없음
   * http://localhost:9091/contents/update_recom_ajax.do?&contentsno=131
   * 중요) Chrom에서 url Test시 GET 방식으로 바꿔서 Test, POST 방식 TEST 원하면 Restful 환경 설치 필요
   * @return
   */
  @RequestMapping(value = "/contents/update_recom_ajax.do", method = RequestMethod.POST)
  @ResponseBody
  public String update_recom_ajax(int contentsno) { // 페이지 번호와 같은 매개변수 전달할 필요가 no
    try {  
      Thread.sleep(2000);  // 3초지연
    } catch (InterruptedException e) {
      e.printStackTrace();
    }    
    int cnt = this.contentsProc.update_recom(contentsno); // 업데이으 한 이후
    int recom = this.contentsProc.read(contentsno).getRecom(); // 다시 읽어오기(ex. 내가 추천 클릭의경우, 다른 사람도 추천 클릭시, 새로운 추천수 받아옴) 
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    json.put("recom", recom);

    return json.toString();
  }  
-------------------------------------------------------------------------------------

7. read.jsp 수정
-------------------------------------------------------------------------------------
<script type="text/javascript">
  $(function(){
    $('#btn_recom').on("click", function() {update_recom_ajax(${contentsno}); }); 
    // 클릭시 update_recom_ajax() 호출, contentsno를 전달
  });

  function update_recom_ajax(contentsno) {
    // console.log(" -> contentsno : " + contentsno);
    var params = "";
    params = 'contentsno= ' + contentsno; // 공백이 값으로 있으면 안됨!!! 중요 = 기호★★★★★★★
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    
    $.ajax({
      url: '/contents/update_recom_ajax.do',  // Spring Controller의 requestmapping 요청 url 
      type: 'post',  // 변경이기에 post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터

      success: function(rdata) { // 응답이 온경우
        // console.log(" -> rdata : " + rdata);
        var str = '';
        if(rdata.cnt == 1) {
          // input tag의 값은 가져오는경우  .val()
          // console.log('->btn_recom: ' + $('#btn_recom').val()); // 값을 받아옴

          // Button tag의 값을 가져오는 경우 .html()
          // console.log('->btn_recom: ' + $('#btn_recom').html()); // 값을 받아옴
          
          // 실제 버튼 태그에서 실시간으로 값 증가 시키기
          $('#btn_recom').html('♡추천♡('+rdata.recom+')');
          
          $('#span_animation').hide(); // 애니메이션 태그 숨김
        } else { // ERROR
          $('#span_animation').html("지금은 추천 할 수 없습니다."); 
        }
      },
      
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
     }
    ); // $.ajax end
    
    // $('#panel').html('조회 중입니다...');
    $('#span_animation').html("<img src='/contents/images/ani04.gif' style='width: 8%;'>");
    $('#span_animation').show(); // 숨겨진 태그의 출력
    
  } //update_recom_ajax() end
  
</script>

.....
            <button type='button' onclick="" class="btn btn-info">관심 상품</button>
            <button type='button' id='btn_recom' class="btn btn-primary">♡추천♡(${recom }) </button>
            <span id='span_animation'></span>
-------------------------------------------------------------------------------------
~~~

* *jQuery, Ajax, JSON, Spring Boot을 연동한 목록 화면에서의 추천 구현(contents 테이블)**
* ★프로젝트 구현시 자주 구현되는 이론★
~~~
- Controller class까지 변경 없음
- 변경해야할 부분
1) 추천 수 출력되는 곳의 태그가 고유하게 구분되어야함.
2) <span id='span_recom_1'>♥(0)</span>으로 id 지정시 -> 모든 행이 span_recom_1 id를 갖음.

추가) style.css의 링크 밑줄에 대한 클래스 추가 : .menu_link 4개의 css 복사하여 복붙
-------------------------------------------------------------------------------------
/* ver 1.9 */
....

  /* span에 대한 link 옵션 추가  */
  .recom_link:link{  /* 방문전 상태 */
    text-decoration: none; /* 밑줄 삭제 */
    color: #555555;
    font_size:0.8em;
  }

  .recom_link:visited{  /* 방문후 상태 */
    text-decoration: none; /* 밑줄 삭제 */
    color: #555555;
    font_size:0.8em;
  }

  .recom_link:hover{  /* A 태그에 마우스가 올라간 상태 */
    text-decoration: none; /* 밑줄 출력 none*/
    color: #7777FF;
    font_size:0.8em;
  }

  .recom_link:active{  /* A 태그를 클릭한 상태 */
    text-decoration: none; /* 밑줄 출력 none*/
    color: #7777FF;
    font_size:0.8em;
  }  
-------------------------------------------------------------------------------------

2) paing 부분 수정 및 추가
-------------------------------------------------------------------------------------
// 추가
<script type="text/javascript">
  function reocm_ajax(contentsno, status_count) { // tag에 contentsno와 id 값 이 들어옴
    // 핵심 태그를 찾는 방.
    console.log("-> recom_ " + status_count + ":"  + $('#recom_' + status_count).html()); // JQuery tag의 id 값을 받아 콘솔에 출력

    var params = "";
    params = 'contentsno= ' + contentsno; // 공백이 값으로 있으면 안됨!!! 중요 = 기호★★★★★★★
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    
    $.ajax({
      url: '/contents/update_recom_ajax.do',  // Spring Controller의 requestmapping 요청 url 
      type: 'post',  // 변경이기에 post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터

      success: function(rdata) { // 응답이 온경우
        // console.log(" -> rdata : " + rdata);
        var str = '';
        if (rdata.cnt == 1) {
          // $('#span_animation_' + status_count).hide();   // SPAN 태그에 animation 출력
          $('#recom_' + status_count).html('♥('+rdata.recom+')');     // A 태그에 animation 출력
        } else {
          // $('#span_animation_' + status_count).html("X");
          $('#recom_' + status_count).html('♥(X)');
        }
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    }
  );  //  $.ajax END

  $('#recom_' + status_count).html("<img src='/contents/images/ani04.gif' style='width: 10%;'>");
  // $('#span_animation_' + status_count).css('text-align', 'center');
  // $('#span_animation_' + status_count).html("<img src='/contents/images/ani04.gif' style='width: 10%;'>");
  // $('#span_animation_' + status_count).show(); // 숨겨진 태그의 출력
  }
</script>

수정) <c:forEach var="contentsVO" items="${list }" varStatus="status">

추가) 포인트 span과 </td> 사이
	    <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${point}" pattern="#,###" /></span>
            
            <span>
            <A id="recom_${status.count }" 
                  href="javascript:reocm_ajax(${contentsno }, ${status.count })" 
                  class="recom_link">♥(${recom })
            </A> </span>
            <!-- contentsno(숫자)와, recom(숫자) 값을 전달해줘야함
            status.count와 같이 여러개의 값을 전달할때는 숫자 값을 전달해줘야함. -->
            <!--  javascript send_recom으로 전달되는 태그의 값음 문자열''로 전달-->
            <%-- <span id="span_animation_${status.count }"></span> --%>
            
          </td>
-------------------------------------------------------------------------------------

3) gird 추가
-------------------------------------------------------------------------------------
      <c:set var="recom" value="${contentsVO.recom }" /> <%-- 추가 --%>

               <Strong><fmt:formatNumber value='${saleprice}' pattern="#,###" />원</Strong><BR>
               .....
               <span style='font-size: 0.9em;'>♥(${recom })</span> <%-- 추가 --%>
-------------------------------------------------------------------------------------

list_by_cateno xml
-------------------------------------------------------------------------------------
DESC 설정
-------------------------------------------------------------------------------------
~~~


* ** jQuery, Ajax, JSON, Spring Boot + Animation을 연동한 수정폼의 구현(categrp 테이블**
* ★프로젝트 구현시 자주 구현되는 이론★
~~~
- jQuery, Ajax, JSON, Spring Boot + Animation을 연동한 수정폼의 구현
[01] 주소(address, URL)의 변경

1. 주소의 변경 유형 1
1) 개발이 진행된 상태에서 주소 변경은 현실적으로 어려움
    http://localhost:9091/categrp/list.do -> http://localhost:9091/categrp/list_ajax.do

2) http://localhost:9091/categrp/list.do 주소를 유지하면서 변경
   - 개발이 진행된 상태에서 주소 변경은 현실적으로 어려움으로 함수명 변경
     public ModelAndView list() -> public ModelAndView list_ajax()
   - 개발이 진행된 상태에서 주소 변경은 현실적으로 어려움으로 view 변경
     /WEB-INF/views/categrp/list.jsp -> /WEB-INF/views/categrp/list_ajax.jsp

2. Interceptor(Filter)등을 이용하여 주소 이동 처리

1) 주소(address, URL) 테이블 존재
    번호  코드   URL
        1  C001   http://localhost:9091/categrp/create.do
        2  C002   http://localhost:9091/categrp/list_ajax.do  <- 변경
        3  C003   http://localhost:9091/categrp/read.do
        4  C004   http://localhost:9091/categrp/update.do
        5  C005   http://localhost:9091/categrp/delete.do
        6  M001  http://localhost:9091/member/create.do
        7  M002  http://localhost:9091/member/list.do

2) http://localhost:9091/C002 요청시 http://localhost:9091/categrp/list.do로 이동
3) 주소 변경 : http://localhost:9091/categrp/list_ajax.do
4) http://localhost:9091/C002 요청시 http://localhost:9091/categrp/list_ajax.do로 이동

1. SQL ▷ /webapp/WEB-INF/doc/dbms/categrp_c.sql
▷ /src/main/resources/categrp.xml 
3. DAO interface 4. Process interface
5. Process class
-------------------------------------------------------------------------------------
-- READ 조회, 한건 조회
변경사항 no
-------------------------------------------------------------------------------------

6. Controller class
read_update() 를 복사하여 -> read_update_ajax()로 변경
read_update()는 주석처리 NO
-------------------------------------------------------------------------------------
  // http://localhost:9091/categrp/read_update_ajax.do?categrpno=1
  /**
   * AJAX 기반 조회 + 수정폼 
   * {"categrpVO":"[categrpno=1, name=영화, seqno=1, visible=Y, rdate=2021-04-14 21:47:10]"}
   * @param categrpno 조회할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/categrp/read_update_ajax.do", method=RequestMethod.GET )
  @ResponseBody
  public String read_update_ajax(int categrpno) {
   
    CategrpVO categrpVO = this.categrpProc.read(categrpno);
    JSONObject json = new JSONObject();
    json.put("categrpVO", categrpVO); // categrpVO객체를 전부 저장
    
    return json.toString();
  }    
-------------------------------------------------------------------------------------

6. Controller class
Q) 주소 변경시 url이 전부 변경되어야 하기에 개발완료된 상태에서는 어려움.
list() 복사 -> list_ajax() 생성
list() 주석 처리 ctrl + /
-------------------------------------------------------------------------------------
  // http://localhost:9091/categrp/list.do
  /**
   * AJAX 활용, 목록
   * 함수명과 jsp 변경, url 변경은 no
   * @return
   */
  @RequestMapping(value="/categrp/list.do", method=RequestMethod.GET )
  public ModelAndView list_ajax() {
    ModelAndView mav = new ModelAndView();

    // 등록 순서별 출력    
    // List<CategrpVO> list = this.categrpProc.list_categrpno_asc();
    // 출력 순서별 출력
    List<CategrpVO> list = this.categrpProc.list_seqno_asc();

    mav.addObject("list", list); // request.setAttribute("list", list);

    mav.setViewName("/categrp/list_ajax"); // /webapp/WEB-INF/views/categrp/list_ajax.jsp
    return mav;
  }  
-------------------------------------------------------------------------------------

7. jsp 수정
-------------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> <!--  부트 스트랩에서 제공하는 javascript -->

<script type="text/javascript">
  $(function() { // 동적 JQuery 사용 
    $('#btn_update_cancel').on('click', cancel);
  });

  function cancel() {
    $('#panel_create').css("display",""); 
    $('#panel_update').css("display","none"); 
  }
    
  function read_update_ajax(categrpno) {
    // display=none; 속성의 panel_update FORM을 -> 출력
    $('#panel_update').css("display","");  // update form은 none -> show
    $('#panel_create').css("display","none"); // 기존 create 폼 -> hide
    
    // console.log('-> categrpno: ' +categrpno); // categrpno의 전달 확인.
    var params = "";
    params = 'categrpno= ' + categrpno; // 공백이 값으로 있으면 안됨!!! 중요 = 기호★★★★★★★
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    
    $.ajax({
      url: '/categrp/read_update_ajax.do',  // Spring Controller의 requestmapping 요청 url 
      type: 'get',  // 변경이 아니기에 get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터

      success: function(rdata) { // 응답이 온경우 Spring에서 하나의 전체를 전달한 경우 -> 통문자열
        // 현재 rata에 전달되는 값은 통문자열, index로 값 추출 시 [, c, a, t, ...
        // console.log(" -> rdata : " + rdata.categrpVO); // rdata : [categrpno=1, name=영화, seqno=1, visible=Y, rdate=2021-04-14 21:47:10]
        // console.log(" -> rdata : " + rdata.categrpVO.categrpno);  // -> rdata : undefined
        // console.log(" -> 0 rdata : " + rdata.categrpVO[0]); // -> 0 rdata : [
        // console.log(" -> 1 rdata : " + rdata.categrpVO[1]); // -> 1 rdata : c
        // console.log('-> ' + JSON.parse(rdata.categrpVO)); // X
        // console.log('-> ' + eval(rdata.categrpVO)); // eval : 순수문자 -> javascript 문자 ,  X
        
        // 해결) 문자열 중 [ ] substring 후 ,로 문자열 구분 필요
        var str = rdata.categrpVO;
        str =  str.substring(1, str.length-1); // [, ] 삭제
        // console.log(str); // categrpno=1, name=영화, seqno=1, visible=Y, rdate=2021-04-14 21:47:10
        strs = str.split(",");
        // console.log(strs[0]); // categrpno=1
        // console.log(strs[0].split("=")[0]); // categrpno
        // console.log(strs[0].split("=")[1]); // 1
      
        var categrpno = strs[0].split("=")[1];
        var name = strs[1].split("=")[1];
        var seqno = strs[2].split("=")[1];
        var visible = strs[3].split("=")[1];
        var rdate = strs[4].split("=")[1];

        var frm_update = $('#frm_update');
        $('#categrpno', frm_update).val(categrpno); // frm_update FROM을 찾아서 -> id가 categrpno인 INPUT tag 값 가져옴.
        $('#name', frm_update).val(name); 
        $('#seqno', frm_update).val(seqno); 
        $('#visible', frm_update).val(visible); 
        $('#rdate', frm_update).val(rdate); 
        
        // input tag의 값은 가져오는경우  .val()
        // console.log('->btn_recom: ' + $('#btn_recom').val()); // 값을 받아옴

        // Button tag의 값을 가져오는 경우 .html()
        // console.log('->btn_recom: ' + $('#btn_recom').html()); // 값을 받아옴
        
        // 실제 버튼 태그에서 실시간으로 값 증가 시키기
        // $('#btn_recom').html('♡추천♡('+rdata.recom+')');
     
        // $('#span_animation').hide(); // 애니메이션 태그 숨김
      },
      
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
     }
    ); // $.ajax end
    
    // $('#panel').html('조회 중입니다...');
    // $('#span_animation').html("<img src='/contents/images/ani04.gif' style='width: 8%;'>");
    // $('#span_animation').show(); // 숨겨진 태그의 출력
        
  }// read_update_ajax() end

</script>

.......

  <%-- 신규 등록 --%>
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
        
      <label>그룹 이름</label>
      <input type='text' name='name' id='name' value='' required="required" style='width: 25%;'
                 autofocus="autofocus">
  
      <label>순서</label>
      <input type='number' name='seqno' id='seqno' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label>형식</label>
      <select name='visible' id='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
       
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
      </FORM>
  </DIV>
  
  <%-- 수정 등록 --%>
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; 
           text-align: center; display: none;'>
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <!--  값전달을 위한 hidden type 필요 -->
      <input type="hidden" name='categrpno' id='categrpno' value=''>
      
      <label>그룹 이름</label>
      <input type='text' name='name' id='name' value='' required="required" style='width: 25%;'
                 autofocus="autofocus">
  
      <label>순서</label>
      <input type='number' name='seqno' id='seqno' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label>형식</label>
      <select name='visible' id='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
       
      <button type="submit" id='submit'>저장</button>
      <button type="button" id='btn_update_cancel'>취소</button>
      </FORM>
  </DIV>  

-------------------------------------------------------------------------------------

-변경 사항
read_update_ajax  주석처리하고 -> 복사하여 붙여넣기
----------------------------------------------------------------------------------------------
  /**
   * 조회 + 수정폼 + Ajax, , VO에서 각각의 필드를 JSON으로 변환하는경우
   * http://localhost:9091/categrp/read_update_ajax.do?categrpno=1
   * {"categrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
   * @param categrpno 조회할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/categrp/read_update_ajax.do", 
                              method=RequestMethod.GET )
  @ResponseBody
  public String read_update_ajax(int categrpno) {
    CategrpVO categrpVO = this.categrpProc.read(categrpno);
    
    JSONObject json = new JSONObject();
    json.put("categrpno", categrpVO.getCategrpno());
    json.put("name", categrpVO.getName());
    json.put("seqno", categrpVO.getSeqno());
    json.put("visible", categrpVO.getVisible());
    json.put("rdate", categrpVO.getRdate());
    
    return json.toString();

  }
----------------------------------------------------------------------------------------------

list_ajax.jsp
----------------------------------------------------------------------------------------------
      success: function(rdata) { // 응답이 온경우 Spring에서 하나의 전체를 전달한 경우 -> 통문자열   
       ... 까지 다지우고 해당 5라인 추가
	var categrpno = rdata.categrpno;  // JSON객체(rdata).VO변수명
        var name = rdata.name;  
        var seqno = rdata.seqno;  
        var visible = rdata.visible;  
        var rdate = rdata.rdate;  
  
        var frm_update = $('#frm_update');
----------------------------------------------------------------------------------------------
~~~

* **jQuery, Ajax, JSON, Spring Boot + Animation을 연동한 삭제폼의 구현(categrp 테이블)**
~~~
[01] 삭제
1. 자식 레코드가 없는 경우의 삭제(순수 AJAX)  - 현재 레코드를 삭제할 것인지만 물어보고 삭제 진행

-> Controller 부분
read_update_ajax 코드 mapping 이름 -> read_ajax로 수정
-> ajax 수정, 삭제에서 모두 사용하기 위해
-----------------------------------------------------------------------------------
  /**
   * 조회 + 수정폼 + Ajax, , VO에서 각각의 필드를 JSON으로 변환하는경우
   * http://localhost:9091/categrp/read_ajax.do?categrpno=1
   * {"categrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
   * @param categrpno 조회할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/categrp/read_ajax.do", 
                              method=RequestMethod.GET )
  @ResponseBody
  public String read_ajax(int categrpno) {
    CategrpVO categrpVO = this.categrpProc.read(categrpno);
    
    JSONObject json = new JSONObject();
    json.put("categrpno", categrpVO.getCategrpno());
    json.put("name", categrpVO.getName());
    json.put("seqno", categrpVO.getSeqno());
    json.put("visible", categrpVO.getVisible());
    json.put("rdate", categrpVO.getRdate());
    
    return json.toString();
  }
-----------------------------------------------------------------------------------

★ 1) panel 스크립트 추가
★ 2) read_delete_ajax() 추가
★ 3) list_ajax에 read_delete.jsp의 div frm_delete 부분 복사하여 수정 등록에 붙여넣기 후 ->수정
★ read_update_ajax에 delete 패널 none 추가해주기!!!!!!!!!!!!!!
★ 수정, 삭제 url mapping 부분 url: '/categrp/read_ajax.do', 로 둘다 해주기
★ 하단 삭제 버튼 클릭시 url 부분 추가
-----------------------------------------------------------------------------------
..... ★추가 부분......
<script type="text/javascript">
  $(function() { // 동적 JQuery 사용 
    $('#btn_update_cancel').on('click', cancel);
    $('#btn_delete_cancel').on('click', cancel);
  });

  function cancel() {
    $('#panel_create').css("display",""); 
    $('#panel_update').css("display","none"); 
    $('#panel_delete').css("display","none"); 
  }
..... ★추가 부분......      


..... ★추가 부분......     
  // 삭제 폼(자식 레코드가 없는 경우의 삭제)
  function read_delete_ajax(categrpno) {
    $('#panel_create').css("display","none"); // hide, 태그를 숨김
    $('#panel_update').css("display","none"); // hide, 태그를 숨김  
    $('#panel_delete').css("display",""); // show, 숨겨진 태그 출력 
    // return;
    
    // console.log('-> categrpno:' + categrpno);
    var params = "";
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params = 'categrpno=' + categrpno; // 공백이 값으로 있으면 안됨.
    $.ajax(
      {
        url: '/categrp/read_ajax.do',
        type: 'get',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
          // {"categrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
          var categrpno = rdata.categrpno;
          var name = rdata.name;
          var seqno = rdata.seqno;
          var visible = rdata.visible;
          // var rdate = rdata.rdate;

          var frm_delete = $('#frm_delete');
          $('#categrpno', frm_delete).val(categrpno);
          
          $('#frm_delete_name').html(name);
          $('#frm_delete_seqno').html(seqno);
          $('#frm_delete_visible').html(visible);
          
          // console.log('-> btn_recom: ' + $('#btn_recom').val());  // X
          // console.log('-> btn_recom: ' + $('#btn_recom').html());
          // $('#btn_recom').html('♥('+rdata.recom+')');
          // $('#span_animation').hide();
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

    // $('#span_animation').css('text-align', 'center');
    // $('#span_animation').html("<img src='/contents/images/ani04.gif' style='width: 8%;'>");
    // $('#span_animation').show(); // 숨겨진 태그의 출력
  } 
..... ★추가 부분......     


..... ★추가 부분......
  <%-- 삭제 등록 --%>
  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; 
            width: 100%; text-align: center; display: none;'>
    <div class="msg_warning">카테고리 그룹을 삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
      <input type='hidden' name='categrpno' id='categrpno' value=''> <%-- 어떤 데이터가 들어올지 모르니 value 값은 no --%>
        
       <%-- span, A, DIV는 form태그에 종속no, 독립적인 Tag, id를 지정 --%>
      <label>그룹 이름 : </label><SPAN id='frm_delete_name'></SPAN>
      <label>순서 : </label><SPAN id='frm_delete_seqno'></SPAN>
      <label>출력 형식 : </label><SPAN id='frm_delete_visible'></SPAN>
       
      <button type="submit" id='submit'>삭제</button>
      <button type="button" id='btn_delete_cancel'>취소</button>
    </FORM>
  </DIV>
..... ★추가 부분......


  <%-- 수정 등록 --%>
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; 
           text-align: center; display: none;'>

..... ★추가 부분......
        <%-- <A href="./read_delete.do?categrpno=${categrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A> --%>
        <%-- AJAX 기반 삭제 폼 --%>
        <A href="javascript: read_delete_ajax(${categrpno})" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
..... ★추가 부분......
-----------------------------------------------------------------------------------

★ 등록처리, 수정처리, 삭제처리 POST 3부분 redirect로 변경
-----------------------------------------------------------------------------------
    if (cnt == 1) {
      mav.setViewName("redirect:/categrp/list.do");
    } else {
       mav.addObject("code", "create"); // request에 저장, request.setAttribute("code", "create")  
       mav.setViewName("/categrp/error_msg"); // /webapp/WEB-INF/views/categrp/error_msg.jsp
    }
    return mav; // forward
-----------------------------------------------------------------------------------

★ 1) views에 categrp_nonajax 디렉토리 추가 -> 파일들 그대로 복사(백업용)
★ 2) categrp에서 : create, read_update, read_delete, update_seqno_down, up 5개 파일 삭제
-----------------------------------------------------------------------------------
소스 수정 no
-----------------------------------------------------------------------------------

★ msg 3가지 통합하기
create_msg -> error_msg로 변경 및 3가지 통합을 위해 수정
- update_msg, delete_msg는 삭제
-----------------------------------------------------------------------------------
<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <%-- 등록 실패 --%>
      <c:choose>
        <c:when test="${code  == 'create'}">  <!-- if 문 -->
          <LI class='li_none'>
            <span class="span_success">새로운 카테고리 그룹 [${categrpVO.name }]을 실패했습니다.</span>
          </LI>
        </c:when>
        
        <%-- 수정 실패 --%>
        <c:when test="${code  == 'update'}">  <!-- if 문 -->
          <LI class='li_none'>
           <span class="span_fail">카테고리 그룹 수정에 실패했습니다.</span>
          </LI>
        </c:when>
        
        <%-- 삭제 실패 --%>
        <c:when test="${code  == 'delete'}">  <!-- if 문 -->
          <LI class='li_none'>
             <span class="span_fail">카테고리 그룹 삭제에 실패했습니다.</span>
          </LI>
        </c:when>                
        
        <%-- 등록, 수정, 식제 에러가 아닌경우 --%>
        <c:otherwise>   <!-- else -->
          <LI class='li_none_left'>
            <span class="span_fail">알수 없는 에러로 작업에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      
      <LI class='li_none'>
        <br>
        <button type='button' onclick="history.back()" class="btn btn-primary">다시 시도</button>
        <button type='button' onclick="location.href='./list.do'" class="btn btn-default">목록</button>
      </LI>
    </UL>
  </fieldset>

</DIV> <%-- div msg end --%>
-----------------------------------------------------------------------------------

2. 자식 레코드가 있는 경우의 삭제
   1) Ajax로 자식 레코드가 있으면 카운트하여 알림
   2) 자식 레코드를 삭제할 것인지 선택
   3) Ajax로 자식 레코드를 삭제함.
   4) 현재 레코드 삭제 진행

[02] jQuery, Ajax, JSON, Spring Boot + Animation을 연동한 삭제폼의 구현(categrp 테이블)
1. SQL ▷ /webapp/WEB-INF/doc/dbms/categrp_c.sql
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
  
2. MyBATIS ▷ /src/main/resources/categrp.xml 
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
 
3. DAO interface ▷ CategrpDAOInter.java 
4. Process interface ▷ CategrpProcInter.java
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------

5. Process class ▷ CategrpProc.java
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
   
6. Aajx Controller class
- 수정폼에 조회 기능이 결합니다. ▷ CategrpCont.java
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
 
7. View: JSP
▷ /webapp/WEB-INF/views/categrp/list_ajax.jsp  
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
~~~

* ★★★★★★★Member(회원 테이블) 제작★★★★★★★
* **0428~9 : [51][Member] 회원 DBMS 설계(권한을 이용한 관리자 결합 모델), 논리적/물리적 모델링, SQL 제작, member.sql**
~~~
[01] 회원 DBMS 설계(권한을 이용한 관리자 결합 모델), 논리적/물리적 모델링, SQL 제작
- 웹사이트 접근 그룹: 관리자(등급별 분류), 회원(등급별 분류), 비회원
- 관리자(admin)을 DB상의 존재하는 테이블로만 지정, but contents 테이블과 연결돼있기에, 테이블은 존재해야함
- 회원 테이블과 관리자 테이블 둘다 만들기에는 오래걸림 -> 회원 테이블을 주로  개인 프로젝트에서 -> 등급 지정

ERD 수정) 댓글 테이블 -> reference -> 회원 테이블

-- ★테이블 구조
-- member 삭제전에 FK가 선언된 qna(질문답변), reply(댓글) 테이블 먼저 삭제
-- reply(댓글) -----> memeberno -->  member(회원) <-- memeberno  <------ qna(질문답변)
★ Q) 관리자 <- 질문답변 -> 회원 <- 댓글 : 같은 테이블 조인 시 구현해야 할 PK나 너무 많음
         DB 입장에서 Column 하나 뿐이지만 Web 설계시 복잡
★ A) 회원 테이블에 등급(grade)이 높은 회원 지정(일종의 관리자 : manme 지정)
    mname(질문답변 관리자) / grade(1)

/doc/회원/member.sql
-------------------------------------------------------------------------------------
-- 테이블 구조
-- member 삭제전에 FK가 선언된 qna(질문답변), reply(댓글) 테이블 먼저 삭제
DROP TABLE qna;
DROP TABLE reply;
DROP TABLE member;
-- 제약 조건과 함께 삭제(제약 조건이 있어도 삭제됨, 권장하지 않음.)
DROP TABLE member CASCADE CONSTRAINTS; 
 
CREATE TABLE member (
  memberno NUMBER(10) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  id            VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분, UNIQUE(PK 성질갖음 but PK는 아님) 
  passwd     VARCHAR(60)   NOT NULL, -- 패스워드, 영숫자 조합
  mname     VARCHAR(30)   NOT NULL, -- 성명, 한글 10자 저장 가능
  tel           VARCHAR(14)   NOT NULL, -- 전화번호
  zipcode    VARCHAR(5)        NULL, -- 우편번호, 12345
  address1   VARCHAR(80)       NULL, -- 주소 1
  address2   VARCHAR(50)       NULL, -- 주소 2
  mdate      DATE             NOT NULL, -- 가입일    
  grade       NUMBER(2)     NOT NULL, -- 등급(1 ~ 10: 관리자, 11~20: 회원, 비회원: 30~39, 정지 회원: 40~49, 탈퇴회원 : 99)
  PRIMARY KEY (memberno)                     -- 한번 등록된 값은 중복 안됨
);

COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MEMBERNO is '회원 번호';
COMMENT ON COLUMN MEMBER.ID is '아이디';
COMMENT ON COLUMN MEMBER.PASSWD is '패스워드';
COMMENT ON COLUMN MEMBER.MNAME is '성명';
COMMENT ON COLUMN MEMBER.TEL is '전화번호';
COMMENT ON COLUMN MEMBER.ZIPCODE is '우편번호';
COMMENT ON COLUMN MEMBER.ADDRESS1 is '주소1';
COMMENT ON COLUMN MEMBER.ADDRESS2 is '주소2';
COMMENT ON COLUMN MEMBER.MDATE is '가입일';
COMMENT ON COLUMN MEMBER.GRADE is '등급';

DROP SEQUENCE member_seq;
CREATE SEQUENCE member_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
 
-- 1. 등록
--1) id 중복 확인 : id가 null값을 갖고있으면 count에서 제외됨. 
SELECT COUNT(id) as cnt
FROM member
WHERE id='user1';
 
 cnt
 ---
   0   ← 중복 되지 않음.
   
-- 2) 등록
-- 회원 관리용 계정, Q/A 용 계정 : mname과 grade(1~10)
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
VALUES (member_seq.nextval, 'qnaadmin', '1234', '질문답변관리자', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 1);
 
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
VALUES (member_seq.nextval, 'crm', '1234', '댓글관리자', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 1);
 
-- 개인 회원 테스트 계정 : mname과 grade(11~20)
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
VALUES (member_seq.nextval, 'user1', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15);
 
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
VALUES (member_seq.nextval, 'user2', '1234', '아로미', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15);
 
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
VALUES (member_seq.nextval, 'user3', '1234', '투투투', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15);
 
-- 부서별(그룹별) 공유 회원 기준 : mname과 grade(11~20)
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
VALUES (member_seq.nextval, 'team1', '1234', '개발팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15);
 
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
VALUES (member_seq.nextval, 'team2', '1234', '웹퍼블리셔팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15);
 
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
VALUES (member_seq.nextval, 'team3', '1234', '디자인팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15);
COMMIT;

-- 2. 목록
-- 검색을 하지 않는 경우, 전체 목록 출력
SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
FROM member
ORDER BY memberno ASC;
 
 MEMBERNO ID       PASSWD MNAME  TEL           ZIPCODE ADDRESS1 ADDRESS2         MDATE         GRADE
 --- -------- ------ ------ ------------- ------- -------- -------- ---------------------                        --------------------
   1 qnaadmin 1234   QNA관리자 000-0000-0000 12345   서울시 종로구  관철동      2019-05-24 14:51:43.0    1
   2 crm      1234   고객관리자  000-0000-0000 12345   서울시 종로구  관철동      2019-05-24 14:51:44.0      1
  ....................		.....................		.....................		.....................		.....................		.....................	.....................
   8 team3    1234   디자인팀   000-0000-0000 12345   서울시 종로구  관철동      2019-05-24 14:51:55.0       15
 
--3. 조회
--1) user1 사원 정보 보기
SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
FROM member
WHERE memberno = 1;
 
SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
FROM member
WHERE id = 'user1';
 

-- 4. 수정
UPDATE member 
SET mname='아로미', tel='111-1111-1111', zipcode='00000',
      address1='경기도', address2='파주시', grdae=14
WHERE memberno=1;
COMMIT;

-- 5. 삭제
-- 1) 모두 삭제
DELETE FROM member;
 
-- 2) 특정 회원 삭제
DELETE FROM member
WHERE memberno=15;
COMMIT;

-- 6. 패스워드 변경
-- 1) 패스워드 검사
SELECT COUNT(memberno) as cnt
FROM member
WHERE memberno=1 AND passwd='1234';
 
-- 2) 패스워드 수정
UPDATE member
SET passwd='0000'
WHERE memberno=1;
COMMIT;
 
-- 7. 로그인
SELECT COUNT(memberno) as cnt
FROM member
WHERE id='user1' AND passwd='1234';

-------------------------------------------------------------------------------------

★ member.sql 테이블 생성 후 import 해주기 : import 하기전 erd에서 회원 테이블 삭제
구조) 질문답변(T) ☞ 회원번호=회원번호 ☞회원(MEBMER)(T) ☜ 회원번호=회원번호 ☜ 댓글(T)
- 질문답변, 댓글 테이블의 회원번호 중복된거 제거해주기!!!!
~~~

* **0429 : [52][Member] VO(DTO), package 설정**
~~~
1. DTO(VO) 생성

▷ dev.mvc.member.MemberVO.java
-------------------------------------------------------------------------------------
package dev.mvc.member;
public class MemberVO {
  /*
CREATE TABLE member (
  memberno NUMBER(10) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  id            VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분, UNIQUE(PK 성질갖음 but PK는 아님) 
  passwd     VARCHAR(60)   NOT NULL, -- 패스워드, 영숫자 조합
  mname     VARCHAR(30)   NOT NULL, -- 성명, 한글 10자 저장 가능
  tel           VARCHAR(14)   NOT NULL, -- 전화번호
  zipcode    VARCHAR(5)        NULL, -- 우편번호, 12345
  address1   VARCHAR(80)       NULL, -- 주소 1
  address2   VARCHAR(50)       NULL, -- 주소 2
  mdate      DATE             NOT NULL, -- 가입일    
  grade       NUMBER(2)     NOT NULL, -- 등급(1 ~ 10: 관리자, 11~20: 회원, 비회원: 30~39, 정지 회원: 40~49)
  PRIMARY KEY (memberno)                     -- 한번 등록된 값은 중복 안됨
);
  */
 
  /** 관리자 번호 */
  private int memberno;
  /** 아이디 */
  private String id = "";
  /** 패스워드 */
  private String passwd = "";
  /** 관리자 성명 */
  private String mname = "";
  /** 전화 번호 */
  private String tel = "";
  /** 우편 번호 */
  private String zipcode = "";
  /** 주소 1 */
  private String address1 = "";
  /** 주소 2 */
  private String address2 = "";
  /** 가입일 */
  private String mdate = "";
  /** 등급 */
  private int grade = 0;
  
  /** 등록된 패스워드 */
  private String old_passwd = "";
  /** id 저장 여부 */
  private String id_save = "";
  /** passwd 저장 여부 */
  private String passwd_save = "";
  /** 이동할 주소 저장 */
  private String url_address = "";
  
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public String getMname() {
    return mname;
  }
  public void setMname(String mname) {
    this.mname = mname;
  }
  public String getTel() {
    return tel;
  }
  public void setTel(String tel) {
    this.tel = tel;
  }
  public String getZipcode() {
    return zipcode;
  }
  public void setZipcode(String zipcode) {
    this.zipcode = zipcode;
  }
  public String getAddress1() {
    return address1;
  }
  public void setAddress1(String address1) {
    this.address1 = address1;
  }
  public String getAddress2() {
    return address2;
  }
  public void setAddress2(String address2) {
    this.address2 = address2;
  }
  public String getMdate() {
    return mdate;
  }
  public void setMdate(String mdate) {
    this.mdate = mdate;
  }
  public int getGrade() {
    return grade;
  }
  public void setGrade(int grade) {
    this.grade = grade;
  }
  public String getOld_passwd() {
    return old_passwd;
  }
  public void setOld_passwd(String old_passwd) {
    this.old_passwd = old_passwd;
  }
  public String getId_save() {
    return id_save;
  }
  public void setId_save(String id_save) {
    this.id_save = id_save;
  }
  public String getPasswd_save() {
    return passwd_save;
  }
  public void setPasswd_save(String passwd_save) {
    this.passwd_save = passwd_save;
  }
  public String getUrl_address() {
    return url_address;
  }
  public void setUrl_address(String url_address) {
    this.url_address = url_address;
  }
}
-------------------------------------------------------------------------------------

[02] package 설정 : 설정 : 
1. Application.java -> dev.mvc 상위 dic으로 항상 고정 됨
2. MyBATIS DAO package 폴더 등록 : DatabaseConfiguration 설정
@MapperScan(basePackages= {"dev.mvc.resort_v1sbm3a", "dev.mvc.categrp",
                                                  "dev.mvc.cate", "dev.mvc.contents", "dev.mvc.member"})  
~~~

* **0429 : [53][Member] 중복 ID 체크(DAO interface, DAO class, Processs interface, Process class)**
~~~
1. SQL▷ /webapp/WEB-INF/doc/dbms/member.sql(Oracle)
-------------------------------------------------------------------------------------
1) id 중복 확인
SELECT COUNT(id) as cnt
FROM member
WHERE id='user1';

 cnt
 ---
   0   ← 중복 되지 않음.
-------------------------------------------------------------------------------------
 
2. MyBATIS - SQL문 맨뒤의 ';'은 삭제
1) namespace의 정의
   - <mapper namespace = "dev.mvc.member.MemberDAOInter">: namespace는 DAO interface하고 일치
 2) SELECT SQL
   - <select id="checkId" resultType="int" parameterType="String">
   - #{id}: JDBC SQL 선언에서 ?에 해당합니다.
            VO(DTO, Data) 클래스의 값을 해당하는 변수에 자동으로 할당하는 기능
   ① id="checkId": DAO method의 이름과 일치
   ② resultType="int": DAO method의 리턴 타입
   ③ parameterType="String": DAO method의 수신 데이터 인수 타입
  
▷ /src/main/resources/mybatis/member.xml  / id: checkID
-------------------------------------------------------------------------------------
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
 
<mapper namespace = "dev.mvc.member.MemberDAOInter">
  
  <!-- [53][Member] 중복 ID 체크(DAO interface, DAO class, Processs interface, Process class) -->
  <select id="checkID" resultType="int" parameterType="String">
    SELECT COUNT(id) as cnt
    FROM member
    WHERE id=#{id}
  </select>

</mapper> 
-------------------------------------------------------------------------------------
 
3. DAO interface  create() 메소드명은 id="create"와 대응
- MemberVO vo 파라미터는 parameterType="MemberVO"과 대응
 ▷ /dev/mvc/member/MemberDAOInter.java 
 4. Proc Interface ▷ dev.mvc.member.MemberProcInter.java
-------------------------------------------------------------------------------------
package dev.mvc.member;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MemberDAOInter {
  /**
   * [53][Member] 중복 ID 체크(DAO interface, DAO class, Processs interface, Process class)
   * 중복 아이디 검사
   * @param id
   * @return 중복 아이디 갯수
   */
  public int checkID(String id);
  
}
-------------------------------------------------------------------------------------

5. Process Class ▷ MemberProc.java
-------------------------------------------------------------------------------------
package dev.mvc.member;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
 
@Component("dev.mvc.member.MemberProc")
public class MemberProc implements MemberProcInter {
  @Autowired
  private MemberDAOInter memberDAO;
  
  public MemberProc(){
    System.out.println("-> MemberProc created.");
  }

  // [53][Member] 중복 ID 체크(DAO interface, DAO class, Processs interface, Process class)
  @Override
  public int checkID(String id) {
    int cnt = this.memberDAO.checkID(id);
    return cnt;
  }

}
-------------------------------------------------------------------------------------

☆ 0513 JQuery 배우고 돌아옴.
★ Controller와 VIEW는 JavaScript로 기존 페이지에 구현
★ JavaScript/Ajax/JSON/jQuery 기술 배움.
★이동 : 서버 프로그램 Client 화면구현(Bootstrap/JavaScript/Ajax/JSON/jQuery)]
[01][JS] 테스트를 위한 기초 소스(Template), Data Type, Variable, Operator(연산자), 제어문, Tern Eclipse plugin  

6. View: JSP : AJAX 사용.
-------------------------------------------------------------------------------------
회원 가입 화면에 통합됨으로 독립 파일로 개발하지 않음.
-------------------------------------------------------------------------------------
~~~

* **0513 : [54][Member] 회원 가입 폼, 중복 ID 검사, Daum 우편번호 API 이용**
~~~
[01] 중복 ID 검사

0. build.gradle 추가 : JSON 의존성 추가
-------------------------------------------------------------------------------------
   // https://mvnrepository.com/artifact/org.json/json
   implementation group: 'org.json', name: 'json', version: '20180813'  
-------------------------------------------------------------------------------------

1. Controller class ▷ MemberCont.java 
- JSON은 FORM이 필요 없음 : DATA만 전달 가능(controller만 출력 가능)
-------------------------------------------------------------------------------------
package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
 
@Controller
public class MemberCont {
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  public MemberCont(){
    System.out.println("--> MemberCont created.");
  }
  
  // http://localhost:9091/member/checkID.do?id=user1
  /**
  * [54][Member] 회원 가입 폼, 중복 ID 검사, Daum 우편번호 API 이용
  * ID 중복 체크, JSON 출력
  * @return
  */
  @ResponseBody // Spring Controller - 출력이 단순 문자열인경우 사용(html, json)
  @RequestMapping(value="/member/checkID.do", method=RequestMethod.GET ,
                         produces = "text/plain;charset=UTF-8" )
  public String checkID(String id) {
    // System.out.println("아이디 확인 요청됨" + id);
    int cnt = this.memberProc.checkID(id);
   
    JSONObject json = new JSONObject(); // JSON 객체 생성
    json.put("cnt", cnt);
   
    return json.toString(); 
  }

  // http://localhost:9091/member/create.do
  /**
   * [54][Member] 회원 가입 폼, 중복 ID 검사, Daum 우편번호 API 이용
  * 등록 폼
  * @return
  */
  @RequestMapping(value="/member/create.do", method=RequestMethod.GET )
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/create"); // webapp/member/create.jsp
   
    return mav; // forward
  } 
}
-------------------------------------------------------------------------------------
 
2. View: JSP
1) Daum 우편번호 API 이용
- http://postcode.map.daum.net/guide -> iframe을 이용하여 페이지에 끼워 넣기
2. 중복 ID 검사 및 Daum 우편번호 API 이용하기 ▷ /webapp/WEB-INF/views/member/create.jsp
- Bootstrap event Handler :
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> <!--  부트 스트랩에서 제공하는 javascript -->

★ Contents/read.jsp 참고하여 수정
-------------------------------------------------------------------------------------
<%-- 
0513 - [54]회 JSON 방식 출력
- 태그의 ID를 JSON 이벤트 Handler로 처리하여 AJAX 방식으로 처리
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> <!--  모바일을 위함 --> 
<title>Resort world</title>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> <!--  부트 스트랩에서 제공하는 javascript -->
<script type="text/javascript">

  $(function() { // 자동 실행
    // id가 'btn_checkID'인 태그를 찾아 'click' 이벤트 처리자(핸들러)로 checkID 함수를 등록
    $('#btn_checkID').on('click', checkID);  
    
    // CoreJS(구형) document.getElementById('btn_checkID').addEventListener('click', checkID); 동일
    $('#btn_DaumPostcode').on('click', DaumPostcode); // 다음 우편 번호
    $('#btn_close').on('click', setFocus); // Dialog창을 닫은후의 focus 이동
    $('#btn_send').on('click', send); 
  });

  // jQuery ajax 요청
  function checkID() {
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
    
    var frm = $('#frm'); // id가 frm인 태그 검색
    var id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    var params = '';
    var msg = '';

    if ($.trim(id).length == 0) { // id를 입력받지 않은 경우
      msg = '· ID를 입력하세요.<br> · ID 입력은 필수 입니다.<br> · ID는 3자이상 권장합니다.';
      $('#btn_close').attr("data-focus", "id"); // data-focus에 id 적용 : id에서 아직 안넘어갔기에!
      
      $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
      $('#modal_title').html('ID 중복 확인'); // 제목 
      $('#modal_content').html(msg);        // 내용
      $('#modal_panel').modal();              // 다이얼로그 출력
      return false; // 진행 종료
      
    } else {  // when ID is entered(정상인 경우)
      params = 'id=' + id;
      // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
      // alert('params: ' + params);

      $.ajax({
        url: './checkID.do', // spring controller url
        type: 'get',  // post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터

        // cnt -> rdate로
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
          // alert(rdata);
          var msg = "";

          // 새로운 moodal, cnt>0 -> 아이디 중복시 모달
          if (rdata.cnt > 0) { 
            $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
            msg = "이미 사용중인 ID 입니다."; 
            $('#btn_close').attr("data-focus", "id"); // data-focus에 id 적용
          } else {
            $('#modal_content').attr('class', 'alert alert-success'); // Bootstrap CSS 변경
            msg = "사용 가능한 ID 입니다.";
            $('#btn_close').attr("data-focus", "passwd");
            // $.cookie('checkId', 'TRUE'); // Cookie 기록
          }
          
          $('#modal_title').html('ID 중복 확인'); // 제목 
          $('#modal_content').html(msg);        // 내용
          $('#modal_panel').modal();              // 다이얼로그 출력
        },
        
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(msg);
        }
      });
      
      // 처리중 출력
  /*     var gif = '';
      gif +="<div style='margin: 0px auto; text-align: center;'>";
      gif +="  <img src='/member/images/ani04.gif' style='width: 10%;'>";
      gif +="</div>";
      
      $('#panel2').html(gif);
      $('#panel2').show(); // 출력 */
    }
  }

  function setFocus() {  // focus 이동
    // console.log('btn_close'); // btn_close 클릭시 콘솔확인

    var tag = $('#btn_close').attr('data-focus'); // 포커스를 적용할 태그 id 가져오기
    console.log('tag: ' +tag); //
    
    $('#' + tag).focus(); // data-focus 속성에 선언된 태그를 찾아서 포커스 이동 
  }

  function send() { // 회원 가입 처리
    // 패스워드를 정상적으로 2번 입력했는지 확인
    if ($('#passwd').val() != $('#passwd2').val()) {
      msg = '입력된 패스워드가 일치하지 않습니다.<br>';
      msg += "패스워드를 다시 입력해주세요.<br>"; 
      
      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('패스워드 일치 여부  확인'); // 제목 
      $('#modal_content').html(msg);  // 내용
      $('#modal_panel').modal();         // 다이얼로그 출력
      
      $('#btn_send').attr('data-focus', 'passwd');
      
      return false; // submit 중지
    }

    $('#frm').submit();
  }
</script>
</head> 

<body>
<jsp:include page="../menu/top.jsp" flush='false' />

  <!-- ********** Modal 알림창 시작(중복확인 버튼 클릭시) ********** -->
  <div id="modal_panel" class="modal fade"  role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'></h4><!-- 제목 -->
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>  <!-- 내용 -->
        </div>
        <div class="modal-footer">
          <button type="button" id="btn_close" data-focus="" class="btn btn-default" 
                      data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
  <!-- ********** Modal 알림창 종료 ********** -->

  <DIV class='title_line'>
    회원 가입
  </DIV>

  <DIV class='content_body'>

  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>목록</A>
  </ASIDE> 

  <div class='menu_line'></div>
  
  <FORM name='frm' id='frm' method='POST' action='./create.do' class="form-horizontal">

    <div class="form-group">
      <label for="id" class="col-md-2 control-label" style='font-size: 0.9em;'>아이디*</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='id' id='id' value='' required="required" style='width: 30%;' placeholder="아이디" autofocus="autofocus">
        <button type='button' id="btn_checkID" class="btn btn-info btn-md">중복확인</button>
        <SPAN id='id_span'></SPAN> <!-- ID 중복 관련 메시지 -->        
      </div>
    </div>   
                
    <div class="form-group">
      <label for="passwd" class="col-md-2 control-label" style='font-size: 0.9em;'>패스워드*</label>    
      <div class="col-md-10">
        <input type='password' class="form-control" name='passwd' id='passwd' value='' required="required" style='width: 30%;' placeholder="패스워드">
      </div>
    </div>   

    <div class="form-group">
      <label for="passwd2" class="col-md-2 control-label" style='font-size: 0.9em;'>패스워드 확인*</label>    
      <div class="col-md-10">
        <input type='password' class="form-control" name='passwd2' id='passwd2' value='' required="required" style='width: 30%;' placeholder="패스워드">
      </div>
    </div>   
    
    <div class="form-group">
      <label for="mname" class="col-md-2 control-label" style='font-size: 0.9em;'>성명*</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='mname' id='mname' 
                   value='' required="required" style='width: 30%;' placeholder="성명">
      </div>
    </div>   

    <div class="form-group">
      <label for="tel" class="col-md-2 control-label" style='font-size: 0.9em;'>전화번호*</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='tel' id='tel' 
                   value='' required="required" style='width: 30%;' placeholder="전화번호"> 예) 010-0000-0000
      </div>
    </div>   

    <div class="form-group">
      <label for="zipcode" class="col-md-2 control-label" style='font-size: 0.9em;'>우편번호</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='zipcode' id='zipcode' 
                   value='' style='width: 30%;' placeholder="우편번호">
        <input type="button" id="btn_DaumPostcode" value="우편번호 찾기" class="btn btn-info btn-md">
      </div>
    </div>  

    <div class="form-group">
      <label for="address1" class="col-md-2 control-label" style='font-size: 0.9em;'>주소</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='address1' id='address1' 
                   value='' style='width: 80%;' placeholder="주소">
      </div>
    </div>   

    <div class="form-group">
      <label for="address2" class="col-md-2 control-label" style='font-size: 0.9em;'>상세 주소</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='address2' id='address2' 
                   value='' style='width: 80%;' placeholder="상세 주소">
      </div>
    </div>   

    <div class="form-group">
      <div class="col-md-12">

<!-- ---------- DAUM 우편번호 API 시작 ---------- -->
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('#zipcode').val(data.zonecode); //5자리 새우편번호 사용 ★
                $('#address1').val(fullAddr);  // 주소 ★

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#address2').focus(); //  ★
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<!-- ---------- DAUM 우편번호 API 종료 ---------- -->

      </div>
    </div>
    
    <div class="form-group">
      <div class="col-md-offset-2 col-md-10">
        <button type="button" id='btn_send' class="btn btn-primary btn-md">가입</button>
        <button type="button" onclick="location.href='../index.do'" class="btn btn-primary btn-md">취소</button>

      </div>
    </div>   
  </FORM>
  </DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>
-------------------------------------------------------------------------------------
~~~

* **0514 : [55][Member] 회원 가입 처리, create_msg.jsp, 메시지 처리 콘트롤러, msg.do 구현**
~~~
[01] 회원 가입 처리
- Daum 우편주소 API 사용
  http://postcode.map.daum.net/guide

- 회원 가입 폼
  http://localhost:9091/member/create.do

1. SQL - Sequence 객체로 제작 가능. ▷ /webapp/WEB-INF/doc/dbms/member.sql
-------------------------------------------------------------------------------------
-- 회원 관리용 계정, Q/A 용 계정 : mname과 grade(1~10)
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
VALUES (member_seq.nextval, 'qnaadmin', '1234', '질문답변관리자', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 1);

-- 개인 회원 테스트 계정 : mname과 grade(11~20)
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
VALUES (member_seq.nextval, 'user1', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 11);

-- 부서별(그룹별) 공유 회원 기준 : mname과 grade(11~20)
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
VALUES (member_seq.nextval, 'team1', '1234', '개발팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15);

COMMIT;
-------------------------------------------------------------------------------------
 
2. MyBATIS
   - <select>: SELECT SQL 실행
   - id='checkId': 메소드명과 동일
   - resultType='int': SELECT SQL 실행 결과와 대응
   - parameterType='String': SQL로 전달되는 값 설정

▷ /src/main/resources/mybatis/member.xml - id: create
-------------------------------------------------------------------------------------
  <!--  [55][Member] 회원 가입 처리, create_msg.jsp, 메시지 처리 콘트롤러, msg.do 구현-->
  <insert id="create" parameterType="dev.mvc.member.MemberVO">
    INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade)
    VALUES (member_seq.nextval, #{id}, #{passwd}, #{mname}, #{tel}, #{zipcode}, 
                 #{address1}, #{address2}, sysdate, #{grade})
  </insert>
------------------------------------------------------------------------------------

3. DAO interface▷ /dev/mvc/member/MemberDAOInter.java 
4. Proc Interface ▷ dev.mvc.member.MemberProcInter.java
-------------------------------------------------------------------------------------
  /**
   * [55][Member] 회원 가입 처리, create_msg.jsp, 메시지 처리 콘트롤러, msg.do 구현
   * 회원 가입
   * @param memberVO
   * @return
   */
  public int create(MemberVO memberVO);
 -------------------------------------------------------------------------------------

5. Process Class ▷ MemberProc.java
-------------------------------------------------------------------------------------

  // [55][Member] 회원 가입 처리, create_msg.jsp, 메시지 처리 콘트롤러, msg.do 구현
  @Override
  public int create(MemberVO memberVO) {
    int cnt = this.memberDAO.create(memberVO);
    return cnt;
  }
-------------------------------------------------------------------------------------
 
6. Controller class, 메시지 처리 콘트롤러
1) 메시지 처리 콘트롤러
- 메시지를 출력하는 전용 메소드를 제작하여 새로고침시 중복등록되는 문제의 해결
  mav.setViewName("redirect:/member/msg.do");  ▷ MemberCont.java
★★★ 등록폼은 54회꺼 그대로 사용
★★★ 등록 처리시 등급(grade) 기본값 지정 : memberVO.setGrade(11); // 기본 회원 가입 등록 11 지정
------------------------------------------------------------------------------------
   /**
   * 새로고침을 방지하는 메시지 출력
   * @param memberno
   * @return
   */
  @RequestMapping(value="/member/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();
    
    // 등록 처리 메시지: create_msg --> /member/create_msg.jsp
    // 수정 처리 메시지: update_msg --> /member/update_msg.jsp
    // 삭제 처리 메시지: delete_msg --> /member/delete_msg.jsp
    mav.setViewName("/member/" + url); // forward
    
    return mav; // forward
  }

  /**
   * [55][Member] 회원 가입 처리, create_msg.jsp, 메시지 처리 콘트롤러, msg.do 구현
   * 등록 처리
   * @param memberVO
   * @return
   */
  @RequestMapping(value="/member/create.do", method=RequestMethod.POST)
  public ModelAndView create(MemberVO memberVO){
    ModelAndView mav = new ModelAndView();
    
    // System.out.println("id: " + memberVO.getId());
    memberVO.setGrade(11); // 기본 회원 가입 등록 11 지정

    int cnt= memberProc.create(memberVO);
    mav.addObject("cnt", cnt); // redirect parameter 적용
    mav.addObject("url", "create_msg"); // create_msg.jsp, redirect parameter 적용
    
    mav.setViewName("redirect:/member/msg.do"); // 새로고침 방지
    
    return mav;
  }
-------------------------------------------------------------------------------------
 
7. View: JSP
1) 회원 가입 폼
▷ /webapp/WEB-INF/views/member/create.jsp
-------------------------------------------------------------------------------------
기존 소스 변경 없음.
-------------------------------------------------------------------------------------

2) 메시지 창(dialog) 닫는 경우 focus의 이동
    $('#btn_close').on('click', setFocus); // Dialog창을 닫은후의 focus 이동
    ......
    $('#btn_close').attr("data-focus", "id");
    ......
    function setFocus() {  // focus 이동
      var tag = $('#btn_close').attr('data-focus'); // 포커스를 적용할 태그 id 가져오기
      $('#' + tag).focus(); // 포커스 지정
    }
    ......
          <button type="button" id="btn_close" data-focus="" 
                      class="btn btn-default" data-dismiss="modal">Close</button>
▷ /webapp/WEB-INF/views/member/create_msg.jsp 
-------------------------------------------------------------------------------------
<%-- 
0514
[55][Member] 회원 가입 처리, create_msg.jsp, 메시지 처리 콘트롤러, msg.do 구현
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>
    회원
  </DIV>

  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>목록</A>
  </ASIDE> 

  <div class='menu_line'></div>
 
<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.cnt == 1 }">
          <LI class='li_none'>회원가입이 완료되었습니다.</LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none'>회원 가입에 실패했습니다.</LI>
          <LI class='li_none'>다시한번 시도해주세요.</LI>
          <LI class='li_none'>계속 실패시 ☏ 000-0000-0000 문의해주세요.</LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <button type='button' onclick="location.href='./login.do'" class="btn btn-primary">로그인</button>
        <button type='button' onclick="location.href='./create.do'" class="btn btn-primary">회원 등록</button>
        <button type='button' onclick="location.href='./list.do'" class="btn btn-primary">목록</button>
      </LI>
     </UL>
  </fieldset>
 
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
-------------------------------------------------------------------------------------
~~~

* **0514 : [56][Member] 회원 목록 출력 기능 제작**
~~~
★관리자 전용

[01] 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~)
1. SQL▷ /webapp/WEB-INF/doc/dbms/member_c.sql
-------------------------------------------------------------------------------------
-- 검색을 하지 않는 경우, 전체 목록 출력(56)
SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
FROM member
ORDER BY memberno ASC;
-------------------------------------------------------------------------------------
  
2. MyBATIS ▷ /src/main/resources/mybatis/member.xml - id: list
-------------------------------------------------------------------------------------
  <!-- [56][Member] 회원 목록 출력 기능 제작, passwd는 출력 no-->
  <select id="list" resultType="dev.mvc.member.MemberVO">
    SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
    FROM member
    ORDER BY memberno ASC
  </select>  
-------------------------------------------------------------------------------------
 
3. DAO interface▷ /dev/mvc/member/MemberDAOInter.java 
4. Proc Interface ▷ dev.mvc.member.MemberProcInter.java
-------------------------------------------------------------------------------------
  /**
   * [56]-회원 전체 목록
   * @return
   */
  public List<MemberVO> list();
-------------------------------------------------------------------------------------

5. Process Class ▷ MemberProc.java
-------------------------------------------------------------------------------------
  // [56][Member] 회원 목록 출력 기능 제작
  @Override
  public List<MemberVO> list() {
    List<MemberVO> list = this.memberDAO.list();
    return list;
  }
-------------------------------------------------------------------------------------
 
6. Controller class
  @RequestMapping(value="/member/list.do", method=RequestMethod.GET)
  public ModelAndView list(){
  .....
▷ MemberCont.java
-------------------------------------------------------------------------------------
  /**
  * [56][Member] 회원 목록 출력 기능 제작
  * 목록 출력 가능
  * @param session
  * @return
  */
  @RequestMapping(value="/member/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    List<MemberVO> list = memberProc.list();
    mav.addObject("list", list);

    mav.setViewName("/member/list"); // /webapp/WEB-INF/views/member/list.jsp
    
    return mav;
  }  
-------------------------------------------------------------------------------------
 
7. View: JSP 1) EL의 사용 ▷ /member/list.jsp 
-------------------------------------------------------------------------------------
<%-- 
0514
[56][Member] 회원 목록 출력 기능 제작 : 관리자 전용
--%>

<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>
    회원(관리자 전용)
  </DIV>

  <DIV class='content_body'>

    <ASIDE class="aside_right">
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>회원 가입</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>목록</A>
    </ASIDE> 
   
    <div class='menu_line'></div>
    
   
    <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style='width: 5%;'/>
      <col style='width: 10%;'/>
      <col style='width: 15%;'/>
      <col style='width: 15%;'/>
      <col style='width: 30%;'/>
      <col style='width: 15%;'/>
      <col style='width: 10%;'/>
    </colgroup>
    <TR>
      <TH class='th_bs'>번호</TH>
      <TH class='th_bs'>ID</TH>
      <TH class='th_bs'>성명</TH>
      <TH class='th_bs'>전화번호</TH>
      <TH class='th_bs'>주소</TH>
      <TH class='th_bs'>등록일</TH>
      <TH class='th_bs'>기타</TH>
    </TR>
   
    <c:forEach var="memberVO" items="${list }">
      <c:set var="memberno" value ="${memberVO.memberno}" />
      <c:set var="id" value ="${memberVO.id}" />
      <c:set var="mname" value ="${memberVO.mname}" />
      <c:set var="tel" value ="${memberVO.tel}" />
      <c:set var="address1" value ="${memberVO.address1}" />
      <c:set var="mdate" value ="${memberVO.mdate}" />
       
    <TR>
      <TD class=td_basic>${memberno}</TD>
      <TD class='td_left'><A href="./read.do?memberno=${memberno}">${id}</A></TD>
      <TD class='td_left'><A href="./read.do?memberno=${memberno}">${mname}</A></TD>
      <TD class='td_basic'>${tel}</TD>
      <TD class='td_left'>
        <c:choose>
          <c:when test="${address1.length() > 15 }"> <!-- 긴 주소 처리 -->
            ${address1.substring(0, 15) }...
          </c:when>
          <c:otherwise>
            ${address1}
          </c:otherwise>
        </c:choose>
      </TD>
      <TD class='td_basic'>${mdate.substring(0, 10)}</TD> <!-- 년월일 -->
      <TD class='td_basic'>
        <A href="./passwd_update.do?memberno=${memberno}"><IMG src='/member/images/passwd.png' title='패스워드 변경'></A>
        <A href="./read.do?memberno=${memberno}"><IMG src='/member/images/update.png' title='수정'></A>
        <A href="./delete.do?memberno=${memberno}"><IMG src='/member/images/delete.png' title='삭제'></A>
      </TD>
      
    </TR>
    </c:forEach>
    
  </TABLE>
   
  <DIV class='bottom_menu'>
    <button type='button' onclick="location.href='./create.do'" class="btn btn-primary">등록</button>
    <button type='button' onclick="location.reload();" class="btn btn-primary">새로 고침</button>
  </DIV>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
-------------------------------------------------------------------------------------

- css 변경
-------------------------------------------------------------------------------------
  .top_menu_sep { 
    background: url('/css/images/gray.jpg') center center no-repeat;
    background-size: 1px;
    width:1px;
    margin-left: 10px;
    margin-right: 5px;
  }

    .td_basic {
    border-top: none;
    border-right: none;
    border-bottom: solid 1px #DDDDDD;
    border-left: none;
    text-align: center;
  }
    .td_left {
    border-top: none;
    border-right: none;
    border-bottom: solid 1px #DDDDDD;
    border-left: none;
    text-align: left;
  }
-------------------------------------------------------------------------------------
~~~

* **0514 : [57][Member] 회원 조회(수정 폼) 기능 제작**
~~~
[01] 조회(수정 폼) 기능 제작(SELECT ~ FROM ~ WHERE ~) 
1. SQL▷ /webapp/WEB-INF/doc/dbms/member.sql
-------------------------------------------------------------------------------------
1) memberno PK로 user1 사원 정보 보기
SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
FROM member
WHERE memberno = 1;

2) id로 user1 사원 정보 보기
SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
FROM member
WHERE id = 'user1';
-------------------------------------------------------------------------------------
 
2. MyBATIS▷ /src/main/resources/mybatis/member.xml - id: read, readById
-------------------------------------------------------------------------------------
  <!-- [57][Member] 회원 조회(수정 폼) 기능 제작 - memberno로 회원 정보 조회 -->
  <select id="read" resultType="dev.mvc.member.MemberVO" parameterType="int">
    SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
    FROM member
    WHERE memberno = #{memberno}
  </select>  

  <!-- [57][Member] 회원 조회(수정 폼) 기능 제작-  id로 회원 정보 조회 -->
  <select id="readById" resultType="dev.mvc.member.MemberVO" parameterType="String">
    SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
    FROM member
    WHERE id = #{id}
  </select>
-------------------------------------------------------------------------------------

3. DAO interface▷ /dev/mvc/member/MemberDAOInter.java 
4. Proc Interface ▷ dev.mvc.member.MemberProcInter.java
-------------------------------------------------------------------------------------
  /**
   * [57][Member] 회원 조회(수정 폼) 기능 제작 -memberno로 회원 정보 조회
   * @param memberno
   * @return
   */
  public MemberVO read(int memberno);
  
  /**
   * [57][Member] 회원 조회(수정 폼) 기능 제작- id로 회원 정보 조회
   * @param id
   * @return
   */
  public MemberVO readById(String id);  
-------------------------------------------------------------------------------------

5. Process Class▷ MemberProc.java
-------------------------------------------------------------------------------------
  // [57][Member] 회원 조회(수정 폼) 기능 제작 -memberno로 회원 정보 조회
  @Override
  public MemberVO read(int memberno) {
    MemberVO memberVO = this.memberDAO.read(memberno);
    return memberVO;
  }

  // [57][Member] 회원 조회(수정 폼) 기능 제작- id로 회원 정보 조회
  @Override
  public MemberVO readById(String id) {
    MemberVO memberVO = this.memberDAO.readById(id);
    return memberVO;
  }
-------------------------------------------------------------------------------------
 
6. Controller class ▷ MemberCont.java
-------------------------------------------------------------------------------------
  /**
   * [57][Member] 회원 조회(수정 폼) 기능 제작
   * 회원 조회
   * @param memberno
   * @return
   */
  @RequestMapping(value="/member/read.do", method=RequestMethod.GET)
  public ModelAndView read(int memberno){
    ModelAndView mav = new ModelAndView();
    
    MemberVO memberVO = this.memberProc.read(memberno);
    mav.addObject("memberVO", memberVO);
    mav.setViewName("/member/read"); // webapp/WEB-INF/member/read.jsp
    
    return mav; // forward
  }  
-------------------------------------------------------------------------------------
 
7. View: JSP ▷ /webapp/member/read.jsp 
-------------------------------------------------------------------------------------
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
  <DIV class='title_line'>
    회원 정보 조회 및 수정
  </DIV>

<DIV class='content_body'>    
    <ASIDE class="aside_right">
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>회원 가입</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>목록</A>
    </ASIDE> 
   
    <div class='menu_line'></div>
    <DIV id='main_panel'></DIV>
   
    <!-- Modal  start-->
    <div class="modal fade" id="modal_panel" role="dialog">
      <div class="modal-dialog">
      
        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            <h4 class="modal-title" id='modal_title'></h4>
          </div>
          <div class="modal-body">
            <p id='modal_content'></p> <!--  내용 -->
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div> <!-- Modal END -->
      
    <FORM name='frm' id='frm' method='POST' action='./update.do' 
                onsubmit="return send();" class="form-horizontal">
      <input type='hidden' name='memberno' id='memberno' value='${memberVO.memberno }'>          
   
      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>아이디</label>    
        <div class="col-md-10">
          ${memberVO.id } (변경 불가능합니다.)
        </div>
      </div>   
                  
      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>성명</label>    
        <div class="col-md-10">
          <input type='text' class="form-control" name='mname' id='mname' 
                     value='${memberVO.mname }' required="required" style='width: 30%;' placeholder="성명" autofocus="autofocus">
        </div>
      </div>   
   
      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>전화번호</label>    
        <div class="col-md-10">
          <input type='text' class="form-control" name='tel' id='tel' 
                     value='${memberVO.tel }' required="required" style='width: 30%;' placeholder="전화번호"> 예) 010-0000-0000
        </div>
      </div>   
   
      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>우편번호</label>    
        <div class="col-md-10">
          <input type='text' class="form-control" name='zipcode' id='zipcode' 
                     value='${memberVO.zipcode }' required="required" style='width: 30%;' placeholder="우편번호">
          <input type="button" onclick="DaumPostcode()" value="우편번호 찾기" class="btn btn-info btn-md">
        </div>
      </div>  
   
      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>주소</label>    
        <div class="col-md-10">
          <input type='text' class="form-control" name='address1' id='address1' 
                     value='${memberVO.address1 }' required="required" style='width: 80%;' placeholder="주소">
        </div>
      </div>   
   
      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>상세 주소</label>    
        <div class="col-md-10">
          <input type='text' class="form-control" name='address2' id='address2' 
                     value='${memberVO.address2 }' required="required" style='width: 80%;' placeholder="상세 주소">
        </div>
      </div>   
   
      <div class="form-group">
        <div class="col-md-12">
   
  <!-- ----- DAUM 우편번호 API 시작 ----- -->
  <div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
    <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
  </div>
   
  <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
  <script>
      // 우편번호 찾기 화면을 넣을 element
      var element_wrap = document.getElementById('wrap');
   
      function foldDaumPostcode() {
          // iframe을 넣은 element를 안보이게 한다.
          element_wrap.style.display = 'none';
      }
   
      function DaumPostcode() {
          // 현재 scroll 위치를 저장해놓는다.
          var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
          new daum.Postcode({
              oncomplete: function(data) {
                  // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
   
                  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                  var fullAddr = data.address; // 최종 주소 변수
                  var extraAddr = ''; // 조합형 주소 변수
   
                  // 기본 주소가 도로명 타입일때 조합한다.
                  if(data.addressType === 'R'){
                      //법정동명이 있을 경우 추가한다.
                      if(data.bname !== ''){
                          extraAddr += data.bname;
                      }
                      // 건물명이 있을 경우 추가한다.
                      if(data.buildingName !== ''){
                          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                      }
                      // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                      fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                  }
   
                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
                  document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                  document.getElementById('address1').value = fullAddr;
   
                  // iframe을 넣은 element를 안보이게 한다.
                  // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                  element_wrap.style.display = 'none';
   
                  // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                  document.body.scrollTop = currentScroll;
                  
                  $('#address2').focus();
              },
              // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
              onresize : function(size) {
                  element_wrap.style.height = size.height+'px';
              },
              width : '100%',
              height : '100%'
          }).embed(element_wrap);
   
          // iframe을 넣은 element를 보이게 한다.
          element_wrap.style.display = 'block';
      }
  </script>
  <!-- ----- DAUM 우편번호 API 종료----- -->
   
        </div>
      </div>
      
      <div class="form-group">
        <div class="col-md-offset-2 col-md-10">
          <button type="submit" class="btn btn-primary btn-md">저장</button>
          <button type="button" onclick="history.go(-1);" class="btn btn-primary btn-md">취소</button>
   
        </div>
      </div>   
    </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
-------------------------------------------------------------------------------------
~~~

* **0517 : [58][Member] 회원 수정 처리**
~~~
★수정 : list.jsp와 read.jsp의 title_line 위쪽 목록 create.do -> list.do로 수정
★수정 : create.jsp의 하단 '취소' 버튼 링크 onclick="history.back()" 로 수정

[01] 수정 처리
1. SQL ▷ /webapp/WEB-INF/doc/dbms/member.sql
-------------------------------------------------------------------------------------
1) 변경
UPDATE member 
SET mname='아로미', tel='111-1111-1111', zipcode='00000',
      address1='경기도', address2='파주시'
WHERE memberno=7;
-------------------------------------------------------------------------------------

2. MyBATIS▷ /src/main/resources/mybatis/member.xml - id: update
-------------------------------------------------------------------------------------
  <!--  [58][Member] 회원 수정 처리 -->
  <update id="update" parameterType="dev.mvc.member.MemberVO">
    UPDATE member 
    SET mname=#{mname}, tel=#{tel}, zipcode=#{zipcode},
          address1=#{address1}, address2=#{address2}
    WHERE memberno=#{memberno}
  </update>   
-------------------------------------------------------------------------------------

3. DAO interface▷ /dev/mvc/member/MemberDAOInter.java 
4. Proc Interface ▷ dev.mvc.member.MemberProcInter.java
-------------------------------------------------------------------------------------
  /**
   * [58][Member] 회원 수정 처리
   * 수정 처리
   * @param memberVO
   * @return
   */
  public int update(MemberVO memberVO);
-------------------------------------------------------------------------------------

5. Process Class ▷ MemberProc.java
-------------------------------------------------------------------------------------
  // [58][Member] 회원 수정 처리
  @Override
  public int update(MemberVO memberVO) {
    int cnt = 0;
    cnt = this.memberDAO.update(memberVO);
    return cnt;
  }
-------------------------------------------------------------------------------------
 
6. Controller class ▷ MemberCon.java
-------------------------------------------------------------------------------------
  /**
   * [58][Member] 회원 수정 처리
   * 회원 정보 수정 처리
   * @param memberVO
   * @return
   */
  @RequestMapping(value="/member/update.do", method=RequestMethod.POST)
  public ModelAndView update(MemberVO memberVO){
    ModelAndView mav = new ModelAndView();
    
    // System.out.println("id: " + memberVO.getId());
    
    int cnt= memberProc.update(memberVO);
    mav.addObject("cnt", cnt); // redirect parameter 적용
    mav.addObject("memberno", memberVO.getMemberno()); // redirect parameter 적용
    mav.addObject("url", "update_msg"); // update_msg.jsp, redirect parameter 적용

    mav.setViewName("redirect:/member/msg.do");
    
    return mav;
  }
-------------------------------------------------------------------------------------
 
7. View: JSP▷ /member/update_msg.jsp 
-------------------------------------------------------------------------------------
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>가입 정보 수정</DIV>

  <DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 

  <div class='menu_line'></div>
 
<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.cnt == 1 }">
          <LI class='li_none'>
            <span class='span_success'>회원 정보를 수정했습니다.</span>
          </LI>
          <LI class='li_none'>
            <button type='button' 
                        onclick="location.href='./read.do?memberno=${param.memberno}'"
                        class="btn btn-info">변경 확인</button>
            <button type='button' 
                        onclick="location.href='./list.do'"
                        class="btn btn-info">목록</button>                        
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none'>
            <span class='span_fail'>회원정보 수정에 실패했습니다.</span>
          </LI>
          <LI class='li_none'>
            <button type='button' 
                        onclick="history.back();"
                        class="btn btn-info">재시도</button>
            <button type='button' 
                        onclick="location.href='./list.do'"
                        class="btn btn-info">목록</button>                        
          </LI>
        </c:otherwise>
      </c:choose>
     </UL>
  </fieldset>
 
</DIV>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
------------------------------------------------------------------------------------
[과제] 회원 등급을 변경하는 기능을 추가 할 것.
~~~

* **0517 : [59][Member] 회원 삭제 기능의 제작, Contents 테이블에서 참조되는 레코드는 삭제 안됨**
~~~
[01] 관리자측 회원 삭제 기능의 제작
- Contents 테이블에서 참조되는 레코드는 삭제 안됨.
 1. SQL
- 일반적으로 데이터 관리 문제로 회원 탈퇴가 발생해도 회원 레코드를 삭제no
  삭제회원으로 권한을 변경하거나 민감한 개인 정보만 삭제하며 일반적으로 5년 정도 
 2. MyBATIS- <delete>: DELETE SQL 실행 태그, 처리된 레코드의 갯수를 리턴
▷ /src/main/resources/mybatis/member.xml - id: delete
-------------------------------------------------------------------------------------
  <!--  [59][Member] 회원 삭제 기능의 제작 -->
  <delete id="delete" parameterType="int">
    DELETE FROM member
    WHERE memberno=#{memberno}
  </delete>
-------------------------------------------------------------------------------------
 
3. DAO interface ▷ /dev/mvc/member/MemberDAOInter.java 
4. Proc Interface ▷ dev.mvc.member.MemberProcInter.java
-------------------------------------------------------------------------------------
  /**
   * [59][Member] 회원 삭제 기능의 제작
   * @param memberno
   * @return
   */
  public int delete(int memberno);
------------------------------------------------------------------------------------- 

5. Process Class▷ dev.mvc.member.MemberProc.java
-------------------------------------------------------------------------------------
  // [59][Member] 회원 삭제 기능의 제작
  @Override
  public int delete(int memberno) {
    int cnt = this.memberDAO.delete(memberno);
    return cnt;
  }
-------------------------------------------------------------------------------------
 
6. Controller class▷ dev.mvc.member.MemberCont.java
------------------------------------------------------------------------------------
  /**
   * [59] 회원 삭제
   * @param memberno
   * @return
   */
  @RequestMapping(value="/member/delete.do", method=RequestMethod.GET)
  public ModelAndView delete(int memberno){
    ModelAndView mav = new ModelAndView();
    
    MemberVO memberVO = this.memberProc.read(memberno);
    mav.addObject("memberVO", memberVO);
    mav.setViewName("/member/delete"); // /member/delete.jsp
    
    return mav; // forward
  }
 
  /**
   * [59] 회원 삭제 처리
   * @param memberVO
   * @return
   */
  @RequestMapping(value="/member/delete.do", method=RequestMethod.POST)
  public ModelAndView delete_proc(int memberno){
    ModelAndView mav = new ModelAndView();
    
    // System.out.println("id: " + memberVO.getId());
    MemberVO memberVO = this.memberProc.read(memberno);
    
    int cnt= memberProc.delete(memberno);
    mav.addObject("cnt", cnt); // redirect parameter 적용
    mav.addObject("mname", memberVO.getMname()); // redirect parameter 적용
    mav.addObject("url", "delete_msg"); // delete_msg.jsp, redirect parameter 적용
    
    mav.setViewName("redirect:/member/msg.do");
    
    return mav;
  }
-------------------------------------------------------------------------------------
 
7. View:  JSP) 삭제 폼 ▷ /webapp/member/delete.jsp 
-------------------------------------------------------------------------------------
<%-- 
0517
[59] 삭제 폼
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>
    회원 삭제
  </DIV>
  
 <DIV class='content_body'>
  
    <ASIDE class="aside_right">
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>회원 가입</A>
      <span class='menu_divide' >│</span> 
      <A href='./list.do'>목록</A>
    </ASIDE> 
   
    <div class='menu_line'></div>
   
    <DIV class='message'>
      <FORM name='frm' method='POST' action='./delete.do'>
       <STRONG>'${memberVO.mname }(${memberVO.id })'</STRONG> 회원을 삭제하면 복구 할 수 없습니다.<br><br>
        정말로 삭제하시겠습니까?<br><br>         
        <input type='hidden' name='memberno' value='${memberVO.memberno}'>     
            
        <button type="submit" class="btn btn-primary btn-md">삭제</button>
        <button type="button" onclick="location.href='./list.do'" class="btn btn-primary btn-md">취소(목록)</button>
     
      </FORM>
    </DIV>
 </DIV> <%-- content_body end --%>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
-------------------------------------------------------------------------------------

2) 삭제 처리 메시지 출력 ▷ /webapp/member/delete_msg.jsp 
-------------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function(){ 
  
  });
</script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>
    회원 삭제
  </DIV>
 <DIV class='content_body'>
 
    <ASIDE class="aside_right">
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>회원 가입</A>
      <span class='menu_divide' >│</span> 
      <A href='./list.do'>목록</A>
    </ASIDE> 
   
    <div class='menu_line'></div>
   
    <DIV class='message'>
      <fieldset class='fieldset_basic'>
        <ul>
          <c:choose>
            <c:when test="${param.cnt == 0}">
              <li class='li_none'>[${param.mname}] 회원 정보 삭제에 실패했습니다.</li>
            </c:when>
            <c:otherwise>
              <li class='li_none'>[${param.mname}] 회원 정보 삭제에 성공했습니다.</li>
            </c:otherwise>
          </c:choose>
       
          <li class='li_none'>
            <button type='button'  onclick="location.href='./list.do'" class="btn btn-primary">목록</button>  
          </li>
          
        </ul>
      </fieldset>    
    </DIV>
  </DIV> <%-- content_body end --%>
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
-------------------------------------------------------------------------------------
~~~

* **0517 : [60][Member] 회원 패스워드 변경 기능의 제작, Layer, HashMap 전달**
~~~
[01] 패스워드 변경 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
 1. SQL ▷ /webapp/WEB-INF/doc/dbms/member_c.sql
-------------------------------------------------------------------------------------
1) 패스워드 검사
SELECT COUNT(memberno) as cnt
FROM member
WHERE memberno=1 AND passwd='1234';
 
2) 패스워드 수정
UPDATE member
SET passwd='0000'
WHERE memberno=1;
-------------------------------------------------------------------------------------
  
2. MyBATIS - <update>: UPDATE SQL 실행 태그, 처리된 레코드의 갯수를 리턴
 1) Map Interface 의 전달
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("memberno", memberno);
    map.put("passwd", passwd);
    return mybatis.selectOne("member.passwdCheck", map);
        ↑↓
    <select id="passwdCheck" resultType="int" parameterType="Map">
 
 2) HashMap class의 전달
    HashMap<String, Object>map = new HashMap<String, Object>();
    map.put("memberno", memberno);
    map.put("passwd", passwd);
    return mybatis.selectOne("member.passwdCheck", map);
        ↑↓
    <select id="passwdCheck" resultType="int" parameterType="HashMap">
 
▷ /src/main/resources/mybatis/member.xml  - id: passwd_check, passwd_update
-------------------------------------------------------------------------------------
  <!--  [60][Member] 회원 패스워드 변경 기능의 제작, Layer, HashMap 전달 
           현재 패스워드 검사 -->
  <select id="passwd_check" parameterType="HashMap" resultType="int">
    SELECT COUNT(memberno) as cnt
    FROM member
    WHERE memberno=#{memberno} AND passwd=#{passwd}
  </select>
  
  <!-- [60][Member] 회원 패스워드 변경 기능의 제작, Layer, HashMap 전달
         패스워드 변경 -->
  <update id="passwd_update" parameterType="HashMap">
    UPDATE member
    SET passwd=#{passwd}
    WHERE memberno=#{memberno}
  </update>  
-------------------------------------------------------------------------------------

3. DAO interface ▷ /dev/mvc/member/MemberDAOInter.java 
4. Proc Interface  ▷ dev.mvc.member.MemberProcInter.java
-------------------------------------------------------------------------------------
  /**
   * [60] 현재 패스워드 검사
   * @param map
   * @return 0: 일치하지 않음, 1: 일치함
   */
  public int passwd_check(HashMap<Object, Object> map);
  
  /**
   * [60] 패스워드 변경
   * @param map
   * @return 변경된 패스워드 갯수
   */
  public int passwd_update(HashMap<Object, Object> map);  
------------------------------------------------------------------------------------
 
5. Process Class ▷ MemberProc.java
-------------------------------------------------------------------------------------
  // [60] 현재 패스워드 검사
  @Override
  public int passwd_check(HashMap<Object, Object> map) {
    int cnt = this.memberDAO.passwd_check(map);
    return cnt;
  }

  // [60] 패스워드 변경
  @Override
  public int passwd_update(HashMap<Object, Object> map) {
    int cnt = this.memberDAO.passwd_update(map);
    return cnt;
  }  
-------------------------------------------------------------------------------------
 
6. Controller class▷ MemberCont.java
-------------------------------------------------------------------------------------
  /**
   * [60] 패스워드를 변경 검사
   * @param memberno
   * @return
   */
  @RequestMapping(value="/member/passwd_update.do", method=RequestMethod.GET)
  public ModelAndView passwd_update(int memberno){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/passwd_update");
    
    return mav;
  }
  
  /**
   * [60] 패스워드를 변경 처리
   * @param memberno 회원 번호
   * @param current_passwd 현재 패스워드
   * @param new_passwd 새로운 패스워드
   * @return
   */
  @RequestMapping(value="/member/passwd_update.do", method=RequestMethod.POST)
  public ModelAndView passwd_update(int memberno, String current_passwd, String new_passwd){
    ModelAndView mav = new ModelAndView();
    
    // 현재 패스워드 검사
    HashMap<Object, Object> map = new HashMap<Object, Object>();
    map.put("memberno", memberno);
    map.put("passwd", current_passwd);
    
    int cnt = memberProc.passwd_check(map);
    int update_cnt = 0; // 변경된 패스워드 수
    
    if (cnt == 1) { // 현재 패스워드가 일치하는 경우
      map.put("passwd", new_passwd); // 새로운 패스워드를 저장
      update_cnt = memberProc.passwd_update(map); // 패스워드 변경 처리
      mav.addObject("update_cnt", update_cnt);  // 변경된 패스워드의 갯수    
    }

    mav.addObject("cnt", cnt); // 패스워드 일치 여부
    mav.addObject("url", "passwd_update_msg");
    
    mav.setViewName("redirect:/member/msg.do");
    
    return mav;
  }    
-------------------------------------------------------------------------------------
 
7. View: JSP 1) 패스워드 변경 폼
▷ /webapp/WEB-INF/views/member/passwd_update.jsp 
-------------------------------------------------------------------------------------
<%-- 
0517_[60] : 패스워드 변경 폼 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
  $(function() { // 자동 실행
    $('#btn_send').on('click', send); 
    $('#btn_close').on('click', setFocus); // Dialog창을 닫은후의 focus 이동
  });

  function send() {
    if ($('#new_passwd').val() != $('#new_passwd2').val()) {
      msg = '입력된 패스워드가 일치하지 않습니다.<br>';
      msg += "패스워드를 다시 입력해주세요.<br>"; 
      
      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('패스워드 일치 여부  확인'); // 제목 
      $('#modal_content').html(msg);  // 내용
      $('#modal_panel').modal();         // 다이얼로그 출력
      
      $('#btn_close').attr("data-focus", "new_passwd");
      
      return false; // submit 중지
    }

    $('#frm').submit();
  }
  
  function setFocus() {  // focus 이동
    var tag = $('#btn_close').attr('data-focus'); // 포커스를 적용할 태그 id 가져오기
    $('#' + tag).focus(); // 포커스 지정
  }
  
</script>
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <!-- Modal -->
  <div class="modal fade" id="modal_panel" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'></h4>
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>
        </div>
        <div class="modal-footer">
          <button type="button" id="btn_close" data-focus=""
                     class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div> <!-- Modal END -->
 
  <DIV class='title_line'>
    회원 패스워드 변경
  </DIV>

  <DIV class='content_body'>
    <ASIDE class="aside_right">
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>회원 가입</A>
      <span class='menu_divide' >│</span> 
      <A href='./list.do'>목록</A>
    </ASIDE> 
   
    <div class='menu_line'></div>
      
    <FORM name='frm' id='frm' method='POST' action='./passwd_update.do' 
                class="form-horizontal">
      <input type='hidden' name='memberno' id='memberno' value='${param.memberno }'>       
  
      <div class="form-group">
        <label class="col-md-5 control-label" style="font-size: 0.9em;">현재 패스워드</label>    
        <div class="col-md-7">
          <input type='password' class="form-control" name='current_passwd' 
                    id='current_passwd' value='' required="required" 
                    style='width: 30%;' placeholder="패스워드">
        </div>
      </div>   
                      
      <div class="form-group">
        <label class="col-md-5 control-label" style="font-size: 0.9em;">새로운 패스워드</label>    
        <div class="col-md-7">
          <input type='password' class="form-control" name='new_passwd' 
                    id='new_passwd' value='' required="required" 
                    style='width: 30%;' placeholder="패스워드">
        </div>
      </div>   
   
      <div class="form-group">
        <label class="col-md-5 control-label" style="font-size: 0.9em;">새로운 패스워드 확인</label>    
        <div class="col-md-7">
          <input type='password' class="form-control" name='new_passwd2' 
                    id='new_passwd2' value='' required="required" 
                    style='width: 30%;' placeholder="패스워드">
        </div>
      </div>   
      
      <div class="form-group">
        <div class="col-md-offset-5 col-md-7">
          <button type="button" id='btn_send' class="btn btn-primary btn-md">변경</button>
          <button type="button" onclick="location.href='./list.do'" class="btn btn-primary btn-md">취소</button>
   
        </div>
      </div>   
  </FORM>
</DIV> <%--  <DIV class='content_body'> END --%>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
-------------------------------------------------------------------------------------
 
2) 처리 결과 출력 ▷ /webapp/WEB-INF/views/member/passwd_update_msg.jsp 
-------------------------------------------------------------------------------------
<%-- 
0517_[60] : 패스워드 처리 결과 출력
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>
    패스워드 수정
  </DIV>

 <DIV class='content_body'>
    <ASIDE class="aside_right">
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>회원 가입</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>목록</A>
    </ASIDE> 
  
    <div class='menu_line'></div>
   
  <DIV class='message'>
    <fieldset class='fieldset_basic'>
      <UL>
        <c:choose>
          <c:when test="${param.cnt == 0 }">
            <LI class='li_none'>
              <span class='span_fail'>입력된 패스워드가 일치하지 않습니다.</span>
            </LI>
            <LI class='li_none'>
              <button type='button' onclick="history.back();" class="btn btn-info">변경 재시도</button>
              <button type='button' onclick="location.href='./list.do'" class="btn btn-info">목록</button>                        
            </LI>
          </c:when>
          <c:otherwise>
            <LI class='li_none'>
              <span class='span_success'>패스워드를 변경했습니다.</span>
            </LI>
            <LI class='li_none'>
              <button type='button' onclick="location.href='/'" class="btn btn-primary">확인</button>
              <button type='button' onclick="location.href='./list.do'" class="btn btn-primary">목록</button>                        
            </LI>
          </c:otherwise>
        </c:choose>
       </UL>
    </fieldset>
   
  </DIV>
</DIV> <%--  <DIV class='content_body'> END --%>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
-------------------------------------------------------------------------------------
~~~

* **0520 : [61][Session] Session을 이용한 로그인 상태 유지 및 해제(session 내부 객체)**
~~~
★ Session : 클라이언트와 서버의 연결 상태, 톰캣 서버에 접속한 사용자에게 할당된 개별의 메모리
[01] Session 내부 객체
  - session: Tomcat(WAS: Web Application Server) 서버에서 접속한 사용자마다 고유하게 할당되는 메모리, 
    Tomcat 서버에서 관리하며 다른 사용자의 메모리는 보안상 접근을 할 수 없음, 기본적으로 서버 차원에서
    보안 설정을 함으로 해킹이 매우 어려움.
 1. session 내부 객체의 사용 
 1) javax.servlet.http.HttpSession Interface의 구현 객체, Server 제공자인 Apache Tomcat에서 기능을 구현함, 개발자는 이용만 함. 
 2) 서버의 메모리상에 저장되는 정보로 보안성이 높으며, 접속한 사용자 별로 세션 메모리가 할당되며, 모든 페이지에서 session 객체를 사용
      사용자가 서버에 접속하면 할당되고 브러우저를 닫거나 로그아웃하면 session 정보가 저장된 메모리가 자동으로 해제. 
 비교: request는 폼에서 보낸 데이터를 순간만 저장하는 메모리, 
         JSP 페이지 마다 삭제되고 새로 생성됨. <FORM> ---> request 객체 읽음.
 3) 사용자가 로그인하면 웹사이트 전체에서 계속적으로 유지되는 ID와 패스워드등은 
      session 메모리 변수로 처리
 4) 보안성이 높으나 서버의 메모리(RAM)를 사용함으로 비용이 많이 발생되어 필요한 곳에만 사용 해야함.  
 5) 서버상에서 세션의 유지시간(수명)은 초단위로 <% session.setMaxInactiveInterval(600); %>로 지정
      만약 사용자가 JSP페이지를 열어놓고 링크(<A>)를 클릭하지 않으면, 메모리 관리 차원에서 session 메모리는 삭제.  
      예) 톰캣 서버: 30분, 국민은행은 5분, 신한은행 10분후 자동 로그아웃, 세션 연장은 링크를 클릭하는 역활을 수행함. 
 6) 서버에 설정된 session timeout 시간(초단위) 출력: <%= session.getMaxInactiveInterval() %> 
 7) 서버상에 있는 사용자와 관련된 모든 세션 변수의 값을 삭제하려면 session.invalidate();를 이용하며 이는 로그아웃시 사용
 8) Session ID라는 특별한 세션변수는 개발자가 생성할 수 없고,  서블릿컨테이너(톰캣등)가 부여하는 것으로 접속자의 상태를 파악해서,
      일정 시간이 흐르면, session을 삭제하고 로그아웃 처리를 진행할 것인지를 결정
      개발자는 Session ID값을 만들어 낼 수 없고 서블릿 컨테이너(서버)가 생성
      브러우저에서 Tomcat 서버의 주소를 입력하고 접속하면 자동으로 Session ID가 생성됨. 
  예) 값의 확인 : <%= session.getId() %> ---> 1C500B233D44DD85ABA45D8F11290D78 
       서버의 session ID 값은 브러우저의 Cookie 영역에 저장되고 서버로 JSP 요청시 다시 전송하여 같은 사용자임을 증명하는데 사용.
 9) 시스템에서 자동 생성되는 Session ID 외에, 개발자는 필요한 만큼 Session 변수를 만들어 사용(★★★) 
예) session 변수를 생성하는 경우, 저장 기능 
      grade = "passed"; 
      session.setAttribute("grade", grade);  // 키, 값
  session 변수의 값을 가져오는 경우 :String s_grade = (String)session.getAttribute("grade"); 
  특정 s_grade session변수만 삭제 : session.removeAttribute("s_grade"); 
  모든 세션 변수 삭제, 로그아웃 : session.invalidate(); 

10) Controller or JSP 코드상에서의 Timeout 시간 지정(세션 변수가 메모리에서 삭제되는 시간, 초단위) 
    // 60초 * 10 = 10분, session의 유지 시간 
    // Session session = new Session(): session 객체는 자동으로 생성됨 
    session.setMaxInactiveInterval(600);  

 11) session 객체의 사용
      public ModelAndView login_cookie_proc(
              HttpServletRequest request,
              HttpServletResponse response,
              HttpSession session,
               String id, String passwd,
               @RequestParam(value="id_save", defaultValue="") String id_save,
               @RequestParam(value="passwd_save", defaultValue="") String passwd_save) {...
       
1. JSP 실습 - sb_basic 프로젝트 계속 사용 1) 시작 페이지 ▷ /webapp/session/session.jsp
-------------------------------------------------------------------------------------
<%-- 
0520
[61][Session] Session을 이용한 로그인 상태 유지 및 해제(session 내부 객체)
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%!
// NULL이 출력되지 않기 위한 함수
public String checkNull(Object str) { // Object는 모든 문자열을 변수로 받음
  if (str == null) {
    str = ""; // null이 아닌 문자열
  } 
  return (String)str; // 문자열로 바꿔서 return
}
%> 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>http://localhost:9091/session/session.jsp</title> 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body>
<DIV class='title'>SESSION 테스트</DIV>
 
  <ul>
    <li>
      Tomcat이 자동 생성한 session 변수<br>
      고유한 세션 ID: <%=session.getId() %><br>
      session의 수명: <%= session.getMaxInactiveInterval() %> 초
    </li>
    
    <li>
      <hr>
    </li>
    
    <li class='li_none'>
      <button type='button' onclick="location.href='./create.jsp'">세션 생성</button>
      <button type='button' onclick="location.href='./delete.jsp'">세션 삭제</button>
      <button type='button' onclick="location.href='./send.jsp'">send.jsp 갔다오기</button>
    </li>
    
    <li>
     개발자가 생성한 session 변수<br>
      ID: <%=checkNull(session.getAttribute("id")) %> <br> 
      PASSWORD: <%=checkNull(session.getAttribute("passwd")) %><br>
      로그인 날짜:
      <%
      Object obj = session.getAttribute("date");
      if (obj != null) {
        Date date = (Date)obj;
        out.println(date.toLocaleString());
      }
      %>
    </li>
  </ul>
</body>
</html>
-------------------------------------------------------------------------------------

2) 세션 생성 페이지 ▷ /webapp/session/create.jsp
-------------------------------------------------------------------------------------
<%-- 
0520_2) 세션 생성 페이지   
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>

<%
// session create
session.setAttribute("id", "user1@mail.com");
session.setAttribute("passwd", "123");
session.setAttribute("date", new Date());

response.sendRedirect("./session.jsp");
%>
-------------------------------------------------------------------------------------

3) 세션 삭제 페이지   ▷ /webapp/session/delete.jsp
-------------------------------------------------------------------------------------
<%-- 
0520_3) 세션 삭제 페이지   
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
// session.removeAttribute("id"); // id session 변수만 삭제
session.invalidate();
response.sendRedirect("./session.jsp");
%>
-------------------------------------------------------------------------------------

4) 페이지 이동 ▷ /webapp/session/send.jsp
-------------------------------------------------------------------------------------
<%-- 
0520_4) 페이지 이동 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%!
public String checkNull(Object str) {
  if (str == null) {
    str = "";
  } 
  return (String)str;
}
%>  
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>http://localhost:9091/session/send.jsp</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
  <br>
  다른 페이지로 이동해도 session은 살아있음.
  <br>
  request.getParameter("id") 같은 코드가 필요 없음.
  <br>
  특정 시간동안 메모리상에 계속 유지됨
 
  <ul>
    <li>
      ID: <%=checkNull(session.getAttribute("id")) %> <br> 
      PASSWORD: <%=checkNull(session.getAttribute("passwd")) %><br>
    </li>
  </ul> 
  <br>
  [<A href='./session.jsp'>session.jsp 페이지로 이동</A>]
  <br><br>
</body>
</html>
-------------------------------------------------------------------------------------
~~~

* **0520 : [62][Member] index.do, home.do 제작, 로그인/로그아웃 기능의 제작, session, EL session 접근**
~~~
[01] 시작 페이지의 제작
1) EL을 이용한 Session의 사용
   <c:choose>
     <c:when test="${sessionScope.id == null}">
       <A href='${root}/member/login.do' >Login</A>
     </c:when>
     <c:otherwise>
       ${sessionScope.id } <A href='${root}/member/logout.do' >Logout</A>
     </c:otherwise>
   </c:choose>

1. Controller class ▷ HomeCont.java : 그대로
------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
 
[02] 로그인/로그 아웃 기능의 제작, request, response, session, Cookie, redirect 사용 
1) DI(Depency Injection): 의존 주입, 필요한 클래스를 Spring Container가
   자동으로 생성하여 할당함.
    - DI는 다형성을 원활히 지원하기 위한 기술입니다.
    - 개발자는 코드상에서 객체를 생성할 필요가 없습니다.
 
  public ModelAndView login(MemberVO memberVO, 
                                       HttpSession session, 
                                       HttpServletRequest request,
                                       HttpServletResponse response) {

2) Map의 전달
   - 특정 조건의 변수의 값을 전달할 경우 Map을 사용하면 편리합니다.
     Map<String. Object> map = new HashMap<String. Object>();
     map.put("id", id);
     map.put("passwd", passwd);
     return mybatis.selectOne("member.passwdCheck", map);
        ↑↓
     <select id="passwdCheck" resultType="int" parameterType="Map">

1. SQL ▷ /webapp/WEB-INF/doc/dbms/member.sql
-------------------------------------------------------------------------------------
-- [61] 로그인
SELECT COUNT(*) as cnt
FROM member
WHERE id='user1' AND passwd='1234';
 cnt
 ---
   1
-- [61] id를 이용한 회원 정보 조회
SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
FROM member
WHERE id = 'user1';

★★★★★ readById는 57회에서 구현★★★★★★

2. MyBATIS ▷ /src/main/resources/mybatis/member.xml - id: login, readById
-------------------------------------------------------------------------------------
  <!--[62][Member] index.do, home.do 제작, 로그인/로그아웃 기능의 제작, session, EL session 접근  -->
  <select id="login" resultType="int" parameterType="Map">
    SELECT COUNT(memberno) as cnt
    FROM member
    WHERE id=#{id} AND passwd=#{passwd}
  </select>

  <!-- 57회에서 구현 -->
  <select id="readById" resultType="dev.mvc.member.MemberVO" parameterType="String">
    SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
    FROM member
    WHERE id = #{id}
  </select>   
-------------------------------------------------------------------------------------
 
3. DAO interface ▷ /dev/mvc/member/MemberDAOInter.java 
-------------------------------------------------------------------------------------
  /**
   * [62] 로그인 처리
   */
  public int login(Map<String, Object> map);
-------------------------------------------------------------------------------------

4. Proc Interface ▷ dev.mvc.member.MemberProcInter.java
-------------------------------------------------------------------------------------
  /**
   * [62] 로그인 처리
   */
  public int login(Map<String, Object> map);
-------------------------------------------------------------------------------------
 
5. Process Class ▷ MemberProc.java
-------------------------------------------------------------------------------------
   // [62] 로그인 처리
  @Override
  public int login(Map<String, Object> map) {
    int cnt = this.memberDAO.login(map);
    return cnt;
  }  
-------------------------------------------------------------------------------------

6. Controller class
  - Spring은 주소 이동시 기본적으로 forward 방식을 이용합니다.
    하지만 값을 전달하지 않는 단순 주소 이동이나 다른 도메인으로의 
    이동은 redirect 방법을 사용합니다.
    예) mav.setViewName("redirect:/index.do"); // 확장자 명시
         mav.setViewName("redirect:/index.jsp"); // 확장자 명시
▷ MemberCont.java
-------------------------------------------------------------------------------------
  /**
   * [62] 로그인 폼
   * @return
   */
  // http://localhost:9091/member/login.do 
  @RequestMapping(value = "/member/login.do", method = RequestMethod.GET)
  public ModelAndView login() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/login_form");
    return mav;
  }

  /**
   * [62] 로그인 처리
   * @return
   */
  // http://localhost:9091/member/login.do 
  @RequestMapping(value = "/member/login.do", method = RequestMethod.POST)
  public ModelAndView login_proc(HttpSession session, String id, String passwd) {
   
    ModelAndView mav = new ModelAndView();
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("id", id);
    map.put("passwd", passwd);
    
    int count = memberProc.login(map); // mybatis 까지 전달(id, passwd 일처 여부 확인)
    if (count == 1) { // 로그인 성공
      // System.out.println(id + " 로그인 성공");
      MemberVO memberVO = memberProc.readById(id); // id 기반 회원정보 받아옴.
      session.setAttribute("memberno", memberVO.getMemberno());
      session.setAttribute("id", id);
      session.setAttribute("mname", memberVO.getMname());
      
      mav.setViewName("redirect:/index.do"); // 시작 페이지로 이동  
    } else {
      mav.addObject("url", "login_fail_msg"); // login_fail_msg.jsp, redirect parameter 적용
      mav.setViewName("redirect:/member/msg.do"); // 새로고침 방지
    }
        
    return mav;
  }
  
  /**
   * [62]  로그아웃 처리
   * @param session
   * @return
   */
  @RequestMapping(value="/member/logout.do", method=RequestMethod.GET)
  public ModelAndView logout(HttpSession session){
    ModelAndView mav = new ModelAndView();
    session.invalidate(); // 모든 session 변수 삭제
    
    mav.addObject("url", "logout_msg"); // logout_msg.jsp, redirect parameter 적용
    mav.setViewName("redirect:/member/msg.do"); // 새로고침 방지
    
    return mav;
  }  
-------------------------------------------------------------------------------------
 
★★★★ 수정) create_msg :  <DIV class='content_body'> 추가해주기

7. View: JSP 1) 로그인 폼 ▷ /webapp/WEB-INF/views/member/login_form.jsp 
-------------------------------------------------------------------------------------
<%-- 
0520_1) 로그인 폼
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function() { // 자동 실행
    $('#btn_create').on('click', create);
    $('#btn_loadDefault').on('click', loadDefault);
  });
  
  function create() { // 회원가입
    location.href="./create.do";
  }

  function loadDefault() { // 테스트용 회원가입 기본값 로딩
    $('#id').val('user1');
    $('#passwd').val('1234');
  }    
</script> 

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
<DIV class='title_line'>로그인</DIV>
 
  <DIV class='content_body'> 
   
    <DIV style='width: 80%; margin: 0px auto;'>
      <FORM name='frm' method='POST' action='./login.do' class="form-horizontal">
      
        <div class="form-group">
          <label class="col-md-4 control-label" style='font-size: 0.8em;'>아이디</label>    
          <div class="col-md-8">
            <input type='text' class="form-control" name='id' id='id' 
                       value='' required="required" 
                       style='width: 30%;' placeholder="아이디" autofocus="autofocus">
          </div>
        </div>   
     
        <div class="form-group">
          <label class="col-md-4 control-label" style='font-size: 0.8em;'>패스워드</label>    
          <div class="col-md-8">
            <input type='password' class="form-control" name='passwd' id='passwd' 
                      value='' required="required" style='width: 30%;' placeholder="패스워드">
          </div>
        </div>   
     
        <div class="form-group">
          <div class="col-md-offset-4 col-md-8">
            <button type="submit" class="btn btn-primary btn-md">로그인</button>
            <button type='button' id='btn_create' class="btn btn-primary btn-md">회원가입</button>
            <button type='button' id='btn_loadDefault' class="btn btn-primary btn-md">테스트 계정</button>
          </div>
        </div>   
        
      </FORM>
    </DIV>
</DIV> <%-- content_body end --%>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
-------------------------------------------------------------------------------------
 
2) 로그인 실패 ▷ /webapp/WEB-INF/views/member/login_fail_msg.jsp 
-------------------------------------------------------------------------------------
<%-- 
0520_2) 로그인 실패
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function(){ 
    $('#btn_retry').on('click', function() { 
      location.href="./login.do"
    });

    $('#btn_home').on('click', function() { 
      location.href="/index.do"
    });    
  });
</script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>알림</DIV>

  <DIV class='content_body'> 
    <DIV class='message'>
      <fieldset class='fieldset_basic'>
        <ul>
          <li class='li_none'>。회원 로그인에 실패했습니다.</li>
          <li class='li_none'>。ID 또는 패스워드가 일치하지 않습니다.</li>
          <li class='li_none'>
            <button type="button" id="btn_retry" class="btn btn-primary btn-md">로그인 다시 시도</button>
            <button type="button" id="btn_home" class="btn btn-primary btn-md">확인</button>
          </li>
          
        </ul>
      </fieldset>    
    </DIV>
  </DIV>  <%-- content_body end --%> 
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
 
-------------------------------------------------------------------------------------

3) 로그 아웃 ▷ /webapp/WEB-INF/views/member/logout_msg.jsp 
-------------------------------------------------------------------------------------
<%-- 
0520_3) 로그 아웃
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function(){ 
    $('#btn_home').on('click', function() {
      location.href="/index.do";
    });
  });
</script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
  <DIV class='content_body'>  
    <DIV class='title_line'>알림</DIV>
      <DIV class='message'>
        <fieldset class='fieldset_basic'>
          <ul>
            <li class='li_none'>이용해 주셔서감사합니다.</li>
            <li class='li_none'>
              <button type="button" id="btn_home" class="btn btn-primary btn-md">확인</button>
            </li>
            
          </ul>
        </fieldset>    
      </DIV>
  </DIV><%-- content body end --%>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
-------------------------------------------------------------------------------------

4) 로그인 여부의 판별
    - id나 등급을 session 객체에 저장후 비교
    - 하나의 페이지를 사용자와 관리자 페이지로 분할하면 보안에 실수가 발생 할 수 있음으로
      사용자와 관리자 프로젝트를 분리하여 제작함 예) 사용자: resort, 관리자: resorta
      <c:if test="${sessionScope.id != null}">
          로그인한 경우의 코드
      </c:if>    

      <c:choose>
        <c:when test="${sessionScope.id == null}">
          로그인 하지 않은 경우의 코드
        </c:when>
        <c:otherwise>
          로그인한 경우의 코드
        </c:otherwise>
      </c:choose>    

5) 메뉴 변경 ▷ /webapp/WEB-INF/views/menu/top.jsp 
-------------------------------------------------------------------------------------
      <A class='top_menu_link'  href='${pageContext.request.contextPath}' >리조트</A><span class='top_menu_sep'> </span>
      
      <!-- 이부분 추가-->
      <c:choose>
        <c:when test="${sessionScope.id == null}">
          <A class='menu_link'  href='/member/login.do' >Login</A><span class='top_menu_sep'> </span>
        </c:when>
        <c:otherwise>
          ${sessionScope.id } <A class='menu_link'  href='/member/logout.do' >Logout</A><span class='top_menu_sep'> </span>
        </c:otherwise>
      </c:choose>         
      
      <A class='top_menu_link'  href='${pageContext.request.contextPath}/categrp/list.do'>카테고리 그룹</A><span class='top_menu_sep'> </span>
-------------------------------------------------------------------------------------
~~~

* **0521 : [63][Cookie] 쿠키(Cookie)의 사용**
~~~
[01] Cookie 객체의 사용 
1. Cookie 개요 
   - javax.servlet.http.Cookie 클래스를 이용
   - Tomcat 서버가 접속자의 컴퓨터에 저장하는 문자열로 된 정보. 
   - 쿠키는 브러우저 마다 다른 저장소를 가지고 있음. 
   - 보안성이 없음으로 계정과 패스워드를 동시에 쿠키에 저장하면, 쿠키의 내용을 전부 편집기로 열어 볼 수 있음으로 보안에 문제
     예) 최근에 쿠키는 브러우저 내부에 있는 DB에 저장되어 잠겨져 있어 볼 수 없음.
     예) 저장된 쿠기의 내용 : ★공개되어도 크게 영향이 없는 내용을 Cookie로 사용★
         c_count  <-- 변수명
         11        <-- 값
         localhost/jsp_test/cookie/ <-- 쿠키를 사용하는 주소 
         1536 
         30152127 
         *    <-- 쿠키 변수 구분자
         c_point 
         33 
         localhost/jsp_test/cookie/ 
         1536 
         30152127 

   - 4KB까지 저장할 수 있다. 일반적으로 5개 내외의 변수를 저장함. 
   - 쿠키는 웹페이지 접속시 서버로 자동으로 전송, 서버에 의해서 클라이언트에 쓰여지므로 쿠키를 사용하지 않는 옵션을 브러우저에서 지정가능. 
   - 사용예: 하루동안 이벤트창 오픈하기, 
               ID/PASSWORD 자동으로 저장기능, 
               로그인 상태 유지등 입력된 값의 자동 출력,
               사용자의 접속 통계 

2. 쿠키의 생성 
   - setMaxAge() : 쿠키의 생존 기간 초 단위 지정, 12시간의 경우 12*60*60,  
     브러우저는 시간이 지난 쿠키는 서버로 전송하지 않고 자동으로 삭제하며 사용자가 직접 삭제도 가능, 
     저장된 쿠키는 브러우저가 삭제가 가능한 데이터
    Cookie cookie = new Cookie("id", id); 
    cookie.setMaxAge(1200);     // 초단위, 20 분만 기록 유지 
    response.addCookie(cookie); // 쿠키 출력 --> 접속자의 컴퓨터에 기록됨. 

★3. 쿠키의 읽기 : ★★★request 객체로 부터 Cookie를 읽음.★★★
   Cookie[] cookies = request.getCookies(); // 쿠키를 배열로 추출, 순서값 0~
   String ck_id = "";        // 아이디 
   String ck_passwd = ""; // 패스워드 

   if (cookies != null){  // 쿠키가 존재한다면  
     for(int i=0; i<cookies.length; i++){                          // 쿠키의 갯수만큼 순환 
        Cookie item = cookies[i];                                  // 쿠키를 하나씩 추출  
        if (item.getName().equals("id") == true){               // 찾으려는 변수가 있는지 검사  
            ck_id = item.getValue();                                // 찾아진 쿠키의 값 추출      
        }else if (item.getName().equals("passwd") == true){ // 찾으려는 변수가 있는지 검사  
            ck_passwd = item.getValue();                         // 찾아진 쿠키의 값 추출      
        } 
     } 
   } 

★4. 쿠키의 삭제 : ★★★response 객체에 Cookie를 기록.★★★
   Cookie cookie = new Cookie("id", ""); 
   cookie.setMaxAge(0);     // 수명을 0초로 지정 
   response.addCookie(id);  // 쿠키 전송
   시간이 지난 쿠키는 브러우저에 의해 자동으로 삭제됨. 

5. <jsp:include> 태그가 사용되는 곳의 쿠키 기록 위치
   - 아래처럼 선언된경우 top.jsp에서 쿠키를 기록해도 index.jsp 파일이 있는 폴더 기준으로 쿠키가 저장. 최종 출력 파일이 있는 곳을 기준
     보안상 쿠키가 저장된, 같은 폴더안에 있는 JSP에서만 접근 가능 ★.

     아래와 같은 경우는 '/webapp/index.jsp'의 파일있는 폴더를 기준으로 '/webapp' 폴더에 쿠키가 기록됨
       <!-- ----------------------------------------------- -->
       <body leftmargin="0" topmargin="0">
       <jsp:include page="/menu/top.jsp" flush='false' />
       <!-- ----------------------------------------------- -->

 ★★- /webapp/product 폴에서 쿠키를 기록하면 /webapp/product 폴더에서만 접근 가능★★

[03] Cookie의 실습  - sb_basic 프로젝트 계속 사용
1. 쿠키 기록 ▷ /sb_basic/webapp/cookie/write.jsp, 시작 파일 
-------------------------------------------------------------------------------------
<%-- 
0521_[63][Cookie] 쿠키(Cookie)의 사용
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>http://localhost:9091/cookie/write.jsp</title> 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head> 

<body>
<DIV class='title_line'>쿠키 기록</DIV>
<%
Cookie ck_email = new Cookie("email", "user1@gmail.com");
ck_email.setMaxAge(30); // 30초
response.addCookie(ck_email); 
%>
쿠키를 기록 했습니다. <br><br>
【<A href='./read.jsp'>쿠키 읽기</A> 】
  
</body>
</html>
-------------------------------------------------------------------------------------

2. 쿠키 읽기 ▷ /sb_basic/webapp/cookie/read.jsp 
-------------------------------------------------------------------------------------
<%-- 
0521_[63][Cookie] 쿠키(Cookie)의 사용
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>

<body>
<DIV class='title_line'>쿠키 읽기</DIV>
<%
Cookie[] cookies = request.getCookies();
Cookie cookie = null;
String email = "";

if (cookies != null) { 
  for (int index=0; index < cookies.length; index++) {
    cookie = cookies[index];  // 쿠키 목록에서 쿠키 추출
    if (cookie.getName().equals("email")) { // 이름 비교
      email = cookie.getValue();  // 쿠키 값
    }
  }
}
out.println("Email: " + email);
%>
<br><br>
【<A href='./write.jsp'>쿠키 기록</A> 】
【<A href='./read.jsp'>쿠키 읽기</A> 】
【<A href='./delete.jsp'>쿠키 삭제</A> 】  

</body>
</html>
-------------------------------------------------------------------------------------

3. 쿠키 삭제 - 수명이 0초이고 값이 없는 Cookie 객체를 만들어 다시 기록함.
▷ /sb_basic/webapp/cookie/delete.jsp 
-------------------------------------------------------------------------------------
<%-- 
0521_[63][Cookie] 쿠키(Cookie)의 사용
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head> 

<body>
 <DIV class='title_line'>쿠키 삭제</DIV>
<%
Cookie ck_email = new Cookie("email", "");
ck_email.setMaxAge(0);   // 수명을 0초로 지정
response.addCookie(ck_email); // 쿠키 전송 
%>
<br><br>
【<A href='./write.jsp'>쿠키 기록</A> 】
【<A href='./read.jsp'>쿠키 읽기</A> 】
【<A href='./delete.jsp'>쿠키 삭제</A> 】  
</body>

</html>  
-------------------------------------------------------------------------------------
~~~

* **0521 : [64][Cookie] 쿠키를 이용한 window.open()**
~~~
[01] Cookie 지원 window.open() 사용
- sb_basic 프로젝트 계속 사용
1. JSP 1) 메인 페이지 ▷ /webapp/cookie/main.jsp
-------------------------------------------------------------------------------------
<%-- 
0521_[64][Cookie] 쿠키를 이용한 window.open()
1) 메인 페이지  
--%>
<%@ page contentType="text/html; charset=UTF-8" %> 
<%
String windowOpen = "open"; // 이벤트등 공지사항 출력 여부를 결정
Cookie[] cookies = request.getCookies(); // 브러우저에 저장된 Cookie를 가져옴
Cookie cookie = null;

if (cookies != null) { // 쿠키가 존재 한다면
  for (int index=0; index < cookies.length; index++) { // 쿠키 갯수만큼 순환
    cookie = cookies[index];  // 쿠키 목록에서 쿠키 추출
    if (cookie.getName().equals("windowOpen")) { // 이름 비교
      windowOpen = cookie.getValue();  // 쿠키 값
    }
  }
}
%>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/javascript">
window.onload = function() {
  if ('<%=windowOpen %>' == 'open') {
    openNotice();  // 창 열기 
  }  
}

function openNotice(){
  var url = './notice.jsp';
  var win = window.open(url, '공지 사항', 'width=380px, height=400px');
  
  var x = (screen.width - 380) / 2;
  var y = (screen.height - 400) / 2;
  
  win.moveTo(x, y); // 화면 중앙으로 이동
}

</script>
</head> 
 
 
<body>
 
  2021년 자격증 취득 안내<br><br>
  2021년 새해를 맞아 자격증 취득을 추천합니다.<br><br>
  【<A href='javascript: openNotice();'>자격증 정보 조회</A>】
 
</body>
</html>
-------------------------------------------------------------------------------------

2) 공지사항 페이지    ▷ /webapp/cookie/notice.jsp
-------------------------------------------------------------------------------------
<%-- 
0521_[64][Cookie] 쿠키를 이용한 window.open()
2) 공지사항 페이지
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body>
<DIV class='title' style='margin: 10px auto; width: 50%; font-weight: bold; text-decoration: underline;'>자격증 안내</DIV>
  <DIV style='margin: 0px auto; width: 80%;'> 
    <UL>
      <LI>빅데이터분석 기사</LI>       <!-- 2020 국가기술 예정 -->  
      <LI>정보처리 관련 자격</LI>      <!-- 국가기술 -->
      <LI>SQL 개발자</LI>                <!-- 국가공인 -->
      <LI>데이터분석 준전문가</LI>     <!-- 국가공인 -->
      <LI>리눅스 마스터</LI>             <!-- 국가공인 -->
    </UL>
  </DIV>
  <br>
  <DIV style='text-align: right; padding-right: 10px;'>
    <form name='frm' method='post' action='./notice_cookie.jsp'>
      <label>
        <input type='checkbox' name='windowOpenCheck' onclick="this.form.submit()">
        30초간 창 열지 않기
      </label>
    </form>
  </DIV>
</body>
 
</html>  
-------------------------------------------------------------------------------------

3) 공지사항 쿠키 저장 페이지    ▷ /webapp/cookie/notice_cookie.jsp
-------------------------------------------------------------------------------------
<%-- 
0521_[64][Cookie] 쿠키를 이용한 window.open()
3) 공지사항 쿠키 저장 페이지
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
Cookie cookie = new Cookie("windowOpen", "close"); // 이름, 값
cookie.setMaxAge(30); // 30초
response.addCookie(cookie);
%>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
</head> 
<body>

<script type="text/javascript">
  window.close(); // 현재 윈도우 닫기
</script>
 
</body>
 
</html>
-------------------------------------------------------------------------------------
~~~

* **0524 : [65][Member] Session, Cookie 기반 로그인, 로그아웃 기능의 제작**
~~~
[01] Session, Cookie 기반 로그인, 로그아웃 기능의 제작
1. SQL ▷ /webapp/WEB-INF/doc/dbms/member.sql
-------------------------------------------------------------------------------------
변경 없음
-------------------------------------------------------------------------------------
 
2. MyBATIS ▷ /src/main/resources/mybatis/member.xml - id: login
-------------------------------------------------------------------------------------
변경 없음
-------------------------------------------------------------------------------------
 
3. DAO interface ▷ /dev/mvc/member/MemberDAOInter.java 
-------------------------------------------------------------------------------------
변경 없음
-------------------------------------------------------------------------------------

4. Proc Interface ▷ dev.mvc.member.MemberProcInter.java
-------------------------------------------------------------------------------------
변경 없음
-------------------------------------------------------------------------------------
 
5. Process Class ▷ MemberProc.java
-------------------------------------------------------------------------------------
변경 없음
-------------------------------------------------------------------------------------
 
6. Controller class
  - Spring은 주소 이동시 기본적으로 forward 방식을 이용
    하지만 값을 전달하지 않는 단순 주소 이동이나 다른 도메인으로의 이동은 redirect 방법을 사용
    예) mav.setViewName("redirect:/index.do"); // 확장자 명시
         mav.setViewName("redirect:/index.jsp"); // 확장자 명시

1) Cookie의 기록
      // -------------------------------------------------------------------
      // id 관련 쿠기 저장
      // -------------------------------------------------------------------
      if (id_save.equals("Y")) { // id를 저장할 경우
        Cookie ck_id = new Cookie("ck_id", id);
        ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, 초단위
        response.addCookie(ck_id);
      } else { // N, id를 저장하지 않는 경우
        Cookie ck_id = new Cookie("ck_id", "");
        ck_id.setMaxAge(0);
        response.addCookie(ck_id);
      }
      // id를 저장할지 선택하는  CheckBox 체크 여부
      Cookie ck_id_save = new Cookie("ck_id_save", id_save);
      ck_id_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_id_save);
      // -------------------------------------------------------------------

      // -------------------------------------------------------------------
      // Password 관련 쿠기 저장
      // -------------------------------------------------------------------
      if (passwd_save.equals("Y")) { // 패스워드 저장할 경우
        Cookie ck_passwd = new Cookie("ck_passwd", passwd);
        ck_passwd.setMaxAge(60 * 60 * 72 * 10); // 30 day
        response.addCookie(ck_passwd);
      } else { // N, 패스워드를 저장하지 않을 경우
        Cookie ck_passwd = new Cookie("ck_passwd", "");
        ck_passwd.setMaxAge(0);
        response.addCookie(ck_passwd);
      }
      // passwd를 저장할지 선택하는  CheckBox 체크 여부
      Cookie ck_passwd_save = new Cookie("ck_passwd_save", passwd_save);
      ck_passwd_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_passwd_save);
      // -------------------------------------------------------------------

2) Cookie 읽기
    Cookie[] cookies = request.getCookies();
    Cookie cookie = null;

    String ck_id = ""; // id 저장 변수
    String ck_id_save = ""; // id 저장 여부를 체크하는 변수
    String ck_passwd = ""; // passwd 저장 변수
    String ck_passwd_save = ""; // passwd 저장 여부를 체크하는 변수

    if (cookies != null) {
      for (int i=0; i < cookies.length; i++){
        cookie = cookies[i]; // 쿠키 객체 추출
        
        if (cookie.getName().equals("ck_id")){
          ck_id = cookie.getValue(); 
        }else if(cookie.getName().equals("ck_id_save")){
          ck_id_save = cookie.getValue();  // Y, N
        }else if (cookie.getName().equals("ck_passwd")){
          ck_passwd = cookie.getValue();         // 1234
        }else if(cookie.getName().equals("ck_passwd_save")){
          ck_passwd_save = cookie.getValue();  // Y, N
        }
      }
    }
    
    mav.addObject("ck_id", ck_id);
    mav.addObject("ck_id_save", ck_id_save);
    mav.addObject("ck_passwd", ck_passwd);
    mav.addObject("ck_passwd_save", ck_passwd_save);

3) CheckBox등 null값의 처리
   @RequestParam(value="id_save", defaultValue="") String id_save
   - value: form input 태그의 name 속성 값
    
▷ MemberCont.java 
★ 로그 아웃처리는 [62] logout과 동일
★★★★ 로그인 폼 과 로그인 처리 함수는 주석 처리
-------------------------------------------------------------------------------------
  /**
   * [65][Member] Session, Cookie 기반 로그인, 로그아웃 기능의 제작
   * Cookie 기반의 로그인 폼
   * @return
   */
  // http://localhost:9091/member/login.do 
  @RequestMapping(value = "/member/login.do", method = RequestMethod.GET)
  public ModelAndView login_cookie(HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    
    Cookie[] cookies = request.getCookies(); // 쿠키 배열 생성
    Cookie cookie = null;

    String ck_id = "";          // id 저장
    String ck_id_save = ""; // id 저장 여부를 체크
    String ck_passwd = ""; // passwd 저장
    String ck_passwd_save = ""; // passwd 저장 여부를 체크

    if (cookies != null) {
      for (int i=0; i < cookies.length; i++){
        cookie = cookies[i]; // 쿠키 객체 추출
        
        if (cookie.getName().equals("ck_id")){
          ck_id = cookie.getValue();                          // Cookie에 저장된 id / ex) id input tag에 저장될 id 값
        } else if(cookie.getName().equals("ck_id_save")){
          ck_id_save = cookie.getValue();                 // Cookie에 id를 저장할것인지 여부(Y or N)   / ex) 아이디 저장 체크박스
        } else if (cookie.getName().equals("ck_passwd")){
          ck_passwd = cookie.getValue();                 // Cookie에 저장된 passwd / ex) passwd input tag에 저장될 id 값
        } else if(cookie.getName().equals("ck_passwd_save")){
          ck_passwd_save = cookie.getValue();         // ck_id_save와 같은 맥락
        }
      }
    }// if end
    
    mav.addObject("ck_id", ck_id);  // 객체로 저장
    mav.addObject("ck_id_save", ck_id_save);
    mav.addObject("ck_passwd", ck_passwd);
    mav.addObject("ck_passwd_save", ck_passwd_save);
    
    mav.setViewName("/member/login_ck_form");
    return mav;
  }
  
  /**
   * [65][Member] Session, Cookie 기반 로그인, 로그아웃 기능의 제작
   * 로그인 처리
   * @param request Cookie를 읽기위해 필요
   * @param response Cookie를 쓰기위해 필요
   * @param session 로그인 정보를 메모리에 기록
   * @param id  회원 아이디
   * @param passwd 회원 패스워드
   * @param id_save 회원 아이디 Cookie에 저장 여부
   * @param passwd_save 패스워드 Cookie에 저장 여부
   * @return
   */
  // http://localhost:9091/member/login.do 
  @RequestMapping(value = "/member/login.do", 
                             method = RequestMethod.POST)
  public ModelAndView login_cookie_proc(
                             HttpServletRequest request,
                             HttpServletResponse response,
                             HttpSession session,
                             String id, String passwd,
                             @RequestParam(value="id_save", defaultValue="") String id_save,
                             @RequestParam(value="passwd_save", defaultValue="") String passwd_save) {
    ModelAndView mav = new ModelAndView();
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("id", id);
    map.put("passwd", passwd);
    
    int count = memberProc.login(map);
    if (count == 1) { // 로그인 성공
      // System.out.println(id + " 로그인 성공");
      MemberVO memberVO = memberProc.readById(id);
      session.setAttribute("memberno", memberVO.getMemberno());
      session.setAttribute("id", id);
      session.setAttribute("mname", memberVO.getMname());
      
      // -------------------------------------------------------------------
      // id 관련 쿠기 저장
      // -------------------------------------------------------------------
      if (id_save.equals("Y")) { // id를 저장할 경우, Checkbox를 체크한 경우
        Cookie ck_id = new Cookie("ck_id", id);
        ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, 초단위
        response.addCookie(ck_id); // id 저장
      } else { // N, id를 저장하지 않는 경우, Checkbox를 체크 해제한 경우
        Cookie ck_id = new Cookie("ck_id", "");
        ck_id.setMaxAge(0);
        response.addCookie(ck_id); // id 저장
      }
      // id를 저장할지 선택하는  CheckBox 체크 여부
      Cookie ck_id_save = new Cookie("ck_id_save", id_save);
      ck_id_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_id_save);
      // -------------------------------------------------------------------

      // -------------------------------------------------------------------
      // Password 관련 쿠기 저장
      // -------------------------------------------------------------------
      if (passwd_save.equals("Y")) { // 패스워드 저장할 경우
        Cookie ck_passwd = new Cookie("ck_passwd", passwd);
        ck_passwd.setMaxAge(60 * 60 * 72 * 10); // 30 day
        response.addCookie(ck_passwd);
      } else { // N, 패스워드를 저장하지 않을 경우
        Cookie ck_passwd = new Cookie("ck_passwd", "");
        ck_passwd.setMaxAge(0);
        response.addCookie(ck_passwd);
      }
      // passwd를 저장할지 선택하는  CheckBox 체크 여부
      Cookie ck_passwd_save = new Cookie("ck_passwd_save", passwd_save);
      ck_passwd_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_passwd_save);
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/index.do");  
    } else {
      mav.addObject("url", "login_fail_msg");
      mav.setViewName("redirect:/member/msg.do"); 
    }
        
    return mav;
  }
-------------------------------------------------------------------------------------
 
 7. View: JSP 1) 로그인 폼 ▷ /member/login_ck_form.jsp 
-------------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  function loadDefault() {
    $('#id').val('user1');
    $('#passwd').val('1234');
  }  
</script> 

</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>로그인</DIV>
 
<DIV style='width: 80%; margin: 0px auto;'>
  <FORM name='frm' method='POST' action='./login.do' class="form-horizontal">
  
    <div class="form-group">
      <label class="col-md-4 control-label" style='font-size: 0.8em;'>아이디</label>    
      <div class="col-md-8">
        <input type='text' class="form-control" name='id' id='id' 
                   value='${ck_id }' required="required" 
                   style='width: 30%;' placeholder="아이디" autofocus="autofocus">
        <Label>   
          <input type='checkbox' name='id_save' value='Y' 
                    ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
        </Label>                   
      </div>
 
    </div>   
 
    <div class="form-group">
      <label class="col-md-4 control-label" style='font-size: 0.8em;'>패스워드</label>    
      <div class="col-md-8">
        <input type='password' class="form-control" name='passwd' id='passwd' 
                  value='${ck_passwd }' required="required" style='width: 30%;' placeholder="패스워드">
        <Label>
          <input type='checkbox' name='passwd_save' value='Y' 
                    ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
        </Label>
      </div>
    </div>   
 
    <div class="form-group">
      <div class="col-md-offset-4 col-md-8">
        <button type="submit" class="btn btn-primary btn-md">로그인</button>
        <button type='button' onclick="location.href='./create.do'" class="btn btn-primary btn-md">회원가입</button>
        <button type='button' onclick="loadDefault();" class="btn btn-primary btn-md">테스트 계정</button>
      </div>
    </div>   
    
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
-------------------------------------------------------------------------------------
 
2) 로그인 실패 ▷ /member/login_fail_msg.jsp
-------------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
    
<script type="text/javascript">
  $(function(){ 
    $('#btn_retry').on('click', function() { 
      location.href="./login.do"
    });

    $('#btn_home').on('click', function() { 
      location.href="${pageContext.request.contextPath}/index.do"
    });    
  });
</script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>알림</DIV>
  <DIV class='message'>
    <fieldset class='fieldset_basic'>
      <ul>
        <li class='li_none'>회원 로그인에 실패했습니다.</li>
        <li class='li_none'>ID 또는 패스워드가 일치하지 않습니다.</li>
        <li class='li_none'>
          <button type="button" id="btn_retry" class="btn btn-primary btn-md">로그인 다시 시도</button>
          <button type="button" id="btn_home" class="btn btn-primary btn-md">확인</button>
        </li>
        
      </ul>
    </fieldset>    
  </DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
-------------------------------------------------------------------------------------

 
2) top.jsp 변경
- 로그인의 구분 처리     
      <c:choose>
        <c:when test="${sessionScope.id == null}">
          <A class='menu_link'  href='${root}/member/login.do' >Login</A><span class='top_menu_sep'> </span>
        </c:when>
        <c:otherwise>
          ${sessionScope.id } <A class='menu_link'  href='${root}/member/logout.do' >Logout</A><span class='top_menu_sep'> </span>
        </c:otherwise>
      </c:choose>     
 
▷ /menu/top.jsp
-------------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<DIV class='container' style='width: 100%;'> 
  <!-- 화면 상단 메뉴 -->
  <DIV class='top_img'>
    <DIV class='top_menu_label'>Resort 0.1 영화와 여행이있는 리조트</DIV>
    <NAV class='top_menu'>
      <span style='padding-left: 0.5%;'></span>
      <A class='menu_link'  href='/' >힐링 리조트</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/categrp/list.do'>카테고리 그룹</A><span class='top_menu_sep'> </span>    
      <A class='menu_link'  href='/member/list.do'>회원 목록</A><span class='top_menu_sep'> </span>
      
      <c:choose>
        <c:when test="${sessionScope.id == null}">
          <A class='menu_link'  href='${root}/member/login.do' >Login</A><span class='top_menu_sep'> </span>
        </c:when>
        <c:otherwise>
          ${sessionScope.id } <A class='menu_link'  href='${root}/member/logout.do' >Logout</A><span class='top_menu_sep'> </span>
        </c:otherwise>
      </c:choose>      
    </NAV>
  </DIV>
  
  <!-- 화면을 2개로 분할하여 좌측은 메뉴, 우측은 내용으로 구성 -->  
  <DIV class="row" style='margin-top: 2px;'>
    <DIV class="col-sm-3 col-md-2"> <!-- 메뉴 출력 컬럼 -->
      <img src='/menu/images/myimage.png' style='width: 100%;'>
      <div style='margin-top: 5px;'>
        <img src='/menu/images/myface.png'>힐링 리조트
      </div>
      <!-- Spring 출력 카테고리 그룹 / 카테고리 -->
      <%-- <jsp:include page="/cate/list_index_left.do" flush='false' /> // ERROR --%>
      <c:import url="/cate/list_index_left.do" />  
    </div>
      
    <DIV class="col-sm-9 col-md-10 cont">  <!-- 내용 출력 컬럼 -->  
   
<DIV class='content'>
-------------------------------------------------------------------------------------
~~~

* **0524 : [66][Member] 로그인 정보의 활용, session, top.jsp 메뉴의 변경**
~~~
1. Controller class ▷ MemberCont.java
-------------------------------------------------------------------------------------
  /**
   * Session test
   * http://localhost:9091/member/session.do
   * @param session
   * @return
   */
  @RequestMapping(value="/member/session.do", 
                             method=RequestMethod.GET)
  public ModelAndView session(HttpSession session){
    ModelAndView mav = new ModelAndView();
    
    mav.addObject("url", "session");
    mav.setViewName("redirect:/member/msg.do"); 
    
    return mav;
  }
-------------------------------------------------------------------------------------
 
2. Session 객체의 접근▷ /webapp/member/session.jsp 
-------------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <c:forEach var="name" items="${pageContext.session.attributeNames}">
      변수: ${name}
      값: ${sessionScope[name]}
      <br>
  </c:forEach> 
  <br>  
  로그인된 ID: ${sessionScope.id}
  <br>
  <c:if test="${sessionScope.id ne null }">
    로그인된 사용자 메뉴 출력 영역
  </c:if><br>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
-------------------------------------------------------------------------------------
 
[02] 로그인 정보의 활용 - 로그인 인증 검사
 1. Process Interface  ▷ MemberProcInter.java
-------------------------------------------------------------------------------------
  /**
   * 로그인된 회원 계정인지 검사합니다.
   * @param session
   * @return true: 관리자
   */
  public boolean isMember(HttpSession session);   
-------------------------------------------------------------------------------------

2. Process Class - 콘트롤러의 메소드등에서 이용 가능 ▷ MemberProc.java
-------------------------------------------------------------------------------------
  @Override
  public boolean isMember(HttpSession session){
    boolean sw = false; // 로그인하지 않은 것으로 초기화
    
    String id = (String)session.getAttribute("id");
    
    if (id != null){
      sw = true;  // 로그인 한 경우
    }
    return sw;
  }  
-------------------------------------------------------------------------------------

3. /webapp/WEB-INF/views/member/login_need.jsp  - 로그인이 필요하다는 화면 출력시 이용 가능
-------------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
   
<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
 
  <DIV class='message'>
    <H3>로그인이 필요한 페이지입니다.</H3>
    <BR><BR>
    <button type='button' 
                 onclick="location.href='/member/login.do'" 
                 class="btn btn-info">로그인</button>       
    <button type='button' 
                 onclick="location.href='/member/create.do'" 
                 class="btn btn-info">회원 가입</button>       

  </DIV>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
-------------------------------------------------------------------------------------
~~~

* *0524 : [67][Security] Spring Security의 활용, SQL, application.properties 설정, 인증 관련 Controller 설정, 인증 환경 설정, 인증 실패 설정**
~~~
[01] Spring Security의 활용
1. SQL 구성
▷ /WEB-INF/doc/dbms/member.sql
-------------------------------------------------------------------------------------
MariaDB 10.3 기준

1. DDL
DROP TABLE member;

CREATE TABLE member(
  memberno  INT                       NOT NULL AUTO_INCREMENT COMMENT '회원 번호',
  id              VARCHAR(20)         NOT NULL COMMENT '회원 id, username으로 지정됨',
  name         VARCHAR(300)           NOT NULL COMMENT '성명',
  password    VARCHAR(100)            NOT NULL COMMENT '패스워드',
  authority     VARCHAR (20)          NOT NULL COMMENT '권한, ROLE_ADMIN, ROLE_USER 지정됨',
  enabled      INT                    NOT NULL COMMENT '사용 여부, 1: 활성, 0: 비활성 지정됨',
  rdate         DATETIME              NOT NULL COMMENT '등록일',
  PRIMARY KEY (memberno)  
);

2. 등록
-- 123 암호화: $2a$10$Yrmg68fBinTSAIAL2eFTZu2tr0WmVLR.plO5NARghZSlPwAr161Fa
-- 1234 암호화: $2a$10$AVq05lsMMJbO7jBJMUCjo.VAQlWRnSLt5VUhhR5.EHPoS5CvYNB5W
INSERT INTO member(id, name, password, authority, enabled, rdate)
VALUES('user1', '왕눈이', '$2a$10$Yrmg68fBinTSAIAL2eFTZu2tr0WmVLR.plO5NARghZSlPwAr161Fa', 'ROLE_USER', 1, NOW());
INSERT INTO member(id, name, password, authority, enabled, rdate)
VALUES('admin1', '아로미', '$2a$10$AVq05lsMMJbO7jBJMUCjo.VAQlWRnSLt5VUhhR5.EHPoS5CvYNB5W', 'ROLE_ADMIN', 1, NOW());

COMMIT;

3. 목록
SELECT memberno, id, name, password, authority, enabled, rdate
FROM member
ORDER BY memberno ASC;

4. 조회
SELECT memberno, id, name, password, authority, enabled, rdate
FROM member
WHERE memberno = 1;

-- Spring security는 기본적으로 사용자 이름을 username, 패스워드를 password 컬럼을 이용함
-- 로그인처리
SELECT id as userName, password, enabled
FROM member
WHERE id = 'user1';

-- 권한 로딩
SELECT id as userName, authority
FROM member
WHERE id = 'user1';

5. 삭제
DELETE FROM member;
COMMIT;
-------------------------------------------------------------------------------------

2. application.properties 설정
-------------------------------------------------------------------------------------
첨부 파일 참고
------------------------------------------------------------------------------------- 

3. 인증 관련 Controller 설정
-------------------------------------------------------------------------------------
package dev.mvc.security;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SecurityCont {

    @RequestMapping("/")
    public @ResponseBody String root() throws Exception{
        return "Spring Security 테스트";
    }

    @RequestMapping("/guest/guest.do")
    public String guest() {

        return "/guest/guest";  // /WEB-INF/views/guest/guest.jsp
    }
    
    @RequestMapping("/member/member.do")
    public String member() {

        return "/member/member";  // /WEB-INF/views/member/member.jsp
    }
    
    @RequestMapping("/admin/admin.do")
    public String admin() {
        
        return "/admin/admin";
    }

    @RequestMapping("/login_form.do")
    public String login_orm() {
        
        return "/security/login_form";
    }
    
    @RequestMapping("/login_error.do")
    public String login_error() {
        
        return "/security/login_error";
    }
    
    @RequestMapping("/logout.do")
    public String logout() {
        
        return "/security/logout";  // /WEB-INF/views/security/logout.jsp
    }
    
}
------------------------------------------------------------------------------------- 

4. 인증 환경 설정
-------------------------------------------------------------------------------------
package dev.mvc.security;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    public AuthenticationFailureHandler authenticationFailureHandler;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/", "/test/**").permitAll()
                .antMatchers("/css/**", "/js/**", "/images/**").permitAll()
                .antMatchers("/menu/**").permitAll()
                .antMatchers("/guest/**").permitAll()
                .antMatchers("/member/**").hasAnyRole("USER", "ADMIN")  // DBMS: ROLE_USER, ROLE_ADMIN이 선언되어 있어야함.
                .antMatchers("/admin/**").hasRole("ADMIN")                       // DBMS: ROLE_ADMIN이 선언되어 있어야함.
                .anyRequest().authenticated();
 
        http.formLogin()
                .loginPage("/login_form.do")            // 로그인 주소
                .loginProcessingUrl("/spring_security_check.do")
                //.failureUrl("/login_form.do?error")    // default : /login?error
                .failureHandler(authenticationFailureHandler)
                //.defaultSuccessUrl("/")
                .usernameParameter("id")               // default : username
                .passwordParameter("password")     // default : password
                .permitAll();
 
        http.logout()
                .logoutUrl("/logout.do")                // 로그아웃 주소
                .logoutSuccessUrl("/")
                .permitAll();
        
        // RESTful 또는 개발중에는 꺼 놓는다.
        // http.csrf().disable();

    }
 
    // 암호화 확인을위해 개발시에만 활성화
//    @Autowired
//    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//        auth.inMemoryAuthentication()
//            .withUser("user1").password(passwordEncoder().encode("1234")).roles("USER")
//            .and()
//            .withUser("admin1").password(passwordEncoder().encode("1234")).roles("ADMIN");
//    }
  
    @Autowired
    private DataSource dataSource;
  
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//        System.out.println("--> 123 암호화: " + passwordEncoder().encode("123"));
//        System.out.println("--> 1234 암호화: " + passwordEncoder().encode("1234"));

        auth.jdbcAuthentication()
            .dataSource(dataSource)
            .usersByUsernameQuery(" SELECT id as userName, password, enabled"
                                            + " FROM member"
                                            + " WHERE id = ?")
            .authoritiesByUsernameQuery(" SELECT  id as userName, authority"
                                                    + " FROM member"
                                                    + " WHERE id = ?")
            .passwordEncoder(new BCryptPasswordEncoder());
    }
  
    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
------------------------------------------------------------------------------------- 

5. 인증 실패 설정
-------------------------------------------------------------------------------------
package dev.mvc.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
public class SecurityFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException exception)
    throws IOException, ServletException
    {
        String loginid = request.getParameter("id");
        String errormsg = "";
        
        if (exception instanceof BadCredentialsException) {
            loginFailureCount(loginid);
            errormsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
        } else if (exception instanceof InternalAuthenticationServiceException) {
            loginFailureCount(loginid);
            errormsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
        } else if (exception instanceof DisabledException) {
            errormsg = "계정이 비활성화되었습니다. 관리자에게 문의하세요.";
        } else if (exception instanceof CredentialsExpiredException) {
            errormsg = "비밀번호 유효기간이 만료 되었습니다. 관리자에게 문의하세요.";
        }
    
        request.setAttribute("username",  loginid);
        request.setAttribute("error_message",  errormsg);
        
        request.getRequestDispatcher("/login_form.do?error").forward(request,  response);
    }

    // 비밀번호를 3번 이상 틀릴 시 계정 잠금 처리
    protected void loginFailureCount(String id) {
      System.out.println("6회이상 로그인 실패시 계정을 30분간 사용 못하게 됩니다.");
        /*
        // 틀린 횟수 업데이트
        userDao.countFailure(id);
        // 틀린 횟수 조회
        int cnt = userDao.checkFailureCount(id);
        if(cnt==3) {
            // 계정 잠금 처리
            userDao.disabledUsername(id);
        }
        */
    }
    
}
-------------------------------------------------------------------------------------
~~~

* **0524 : [68][Security] Spring Security의 활용, 로그인 폼, 로그아웃, View 제작, CSRF 처리**
~~~
[01] Spring Security의 활용, View 제작, CSRF 처리
-------------------------------------------------------------------------------------
1. 로그인/로그아웃 View
- CSRF 보안 처리: <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
▷ 로그인 폼
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<!-- /static 기준 -->
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
<br>
<h1>로그인(login_form.jsp)</h1>
<br>
<form name='frm' action="/spring_security_check.do" method="post">
    <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
    <c:if test="${param.error != null}">
      <p>
          Login Error! <br />
          ${error_message}
      </p>
    </c:if>
    <br>
    ID : <input type="text" name="id" value="${id}"> <br><br>
    PW : <input type="password" name="password"> <br><br>
    <input type="submit" value="LOGIN"> 
    <input type="button" value="사용자 테스트 계정" onclick="frm.id.value='user1'; frm.password.value='123'">
    <input type="button" value="관리자 테스트 계정" onclick="frm.id.value='admin1'; frm.password.value='1234'"> <br>
</form>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
-------------------------------------------------------------------------------------

▷ 로그아웃 처리
-------------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그아웃</title>
<!-- /static 기준 -->
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
<br>
<h1>로그아웃(login_form.jsp)</h1>
<br>
<form name='frm' action="/logout.do" method="post">
    <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
    <script type="text/javascript">
      document.frm.submit();
    </script>
</form>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
------------------------------------------------------------------------------------- 

2. 손님 테스트 View
-------------------------------------------------------------------------------------
첨부 파일 참고
------------------------------------------------------------------------------------- 

3. 회원 테스트 View
-------------------------------------------------------------------------------------
첨부 파일 참고
------------------------------------------------------------------------------------- 

4. 관리자 테스트 View
-------------------------------------------------------------------------------------
첨부 파일 참고
------------------------------------------------------------------------------------- 
~~~