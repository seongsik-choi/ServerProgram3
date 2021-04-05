<%-- 
0405
3. choose Tag 
   - when tag는 조건이 true이면 실행
   - if ~ else ~ 문과 같은 역할

[실행 화면]
- http://localhost:9090/test/jstl/chooseTag.jsp
개발 등급이 없습니다.
- http://localhost:9090/test/jstl/chooseTag.jsp?year=5
초급 개발자

▷ /sts_basic/src/main/webapp/jstl/chooseTag.jsp 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>/webapp/jstl/chooseTag.jsp</title> 
<style type="text/css">
  * { font-size: 26px; }
</style>
</head>
<body>
<DIV class='container_main'>
<DIV class='content'>
  <c:choose>
    <c:when test="${param.year >= 0 and param.year <= 5 }">
      초급 개발자<br><br>
    </c:when>
    <c:when test="${param.year >= 6 and param.year <= 8 }">
      중급 개발자<br><br>
    </c:when>
    <c:when test="${param.year >= 9 and param.year <= 11 }">
      고급 개발자<br><br>
    </c:when>
    <c:when test="${param.year >= 12 }">
      특급 개발자<br><br>
    </c:when>    
    <c:otherwise>
       개발 등급이 없습니다.
    </c:otherwise> 
  </c:choose>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->

</body>
</html>