<%-- 
0405_
2. if 흐름제어 태그의 사용 
   - test: 조건을 명시하며, 'test'란 속성명은 변경 할 수 없습니다.  
   - else문은 현재 지원하지 않습니다. 
   - JSTL상에서의 제어문은 태그를 오히려 식별하기 어렵게 할 수 있음으로 
     최소로 사용해야 합니다. 
   - param.name: request.getParameter("name");와 동일
   - param.age : Integer.parseInt(request.getParameter("age"));와 동일, 자동 형변환
   - IE는 주소 표시줄에 한글 직접 입력시 깨짐으로 크롬을 이용하세요.
     <FORM>태그에서의 데이터 입출력은 정상적으로 이루어짐.  
   - 사용예
     <c:if test="${vo.name == 'kim' && vo.nickname == 'kim'}">...</c:if> 
     <c:if test="${vo.name == 'kim' || vo.nickname == 'kim'}">...</c:if>

[실행 화면]
- http://localhost:9090/test/jstl/ifTag.jsp
  http://localhost:9090/test/jstl/ifTag.jsp?code=A01
  http://localhost:9090/test/jstl/ifTag.jsp?code=a01&kor=자바     <-- Chrome
  http://localhost:9090/test/jstl/ifTag.jsp?code=a01&kor=%EC%9E%90%EB%B0%94  <-- Chrome, IE
  http://localhost:9090/test/jstl/ifTag.jsp?code=a01&kor=%EC%9E%90%EB%B0%94&cpu=intel&calc=6.0
  
무조건 수행
a01는 서울이 아닙니다.
a01는 서울입니다.(대문자 변환)
개발 분야: 자바
개발 경력: 5 중급 개발자
AI 개발 Device: intel CUDA 3.0
GPU 기반 개발 가능

▷ /sts_basic/src/main/webapp/jstl/ifTag.jsp
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>/webapp/jstl/ifTag.jsp</title> 
<style type="text/css">
  * { font-size: 26px; }
</style>
</head>
<body>
<DIV class='container_main'>
<DIV class='content'>

  <c:if test="true"> <%-- if(true) {... --%>  
    무조건 실행<br>
  </c:if>
  
  <c:set var="score" value="85" />
  <c:if test="${score >= 60 }">
    ${score } 점 합격<br>
  </c:if>
  
  <%-- if(request.getParameter("code").equals("A01") {... --%>  
  <c:if test="${param.code == 'A01' }"> 
    ${param.code }는 서울을 나타냅니다.<br>
  </c:if>
 
  <c:if test="${param.code != 'A01' }">
    ${param.code }는 서울이 아닙니다.<br>
  </c:if>

  <c:if test="${param.code.toUpperCase() == 'A01' }">
    ${param.code }는 서울을 나타냅니다.<br>
  </c:if>
  
  <!-- IE 11은 URL에 직접 한글 입력시 에러 발생,
         아래처럼 변환 코드 사용, <FROM>에서는 자동으로 변경됨. 
  IE: IE를 이제 사용하지않음.
  http://localhost:9090/test/jstl/ifTag.jsp?code=a01&kor=%EC%9E%90%EB%B0%94
  Chrome:
  http://localhost:9090/test/jstl/ifTag.jsp?code=a01&kor=자바
  http://localhost:9090/test/jstl/ifTag.jsp?code=a01&kor=%EC%9E%90%EB%B0%94&cpu=intel&calc=6.0
  -->
  <c:if test="${param.kor == '자바'}">
    개발 분야: ${param.kor }<br>
  </c:if>
  
  <c:if test="${param.year >= 6 }">
    중급 개발자<br>
  </c:if>

  AI 개발 Device: ${param.cpu } CUDA ${param.calc }<br>
  <c:if test="${param.cpu == 'intel' and param.calc >= 6.0 }">
    GPU 기반 개발 가능<br>
  </c:if> 
  <br>
      
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
</html>
