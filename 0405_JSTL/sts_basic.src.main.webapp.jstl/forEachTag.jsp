<%-- 
0405_
4. forEach 태그 -> 우선 개념만 알기
   - Collection, Map에 저장되어 있는 값에 순차적으로 접근시에 사용
   - var="item": 객체나 배열의 값이 하나씩 추출되어 저장될 변수나 객체명
   - items="${datas }": mav.addObject("datas", ...)으로 저장된 객체, 배열, ArrayList등 저장
   - varStatus="stat": 순환문에서 변화하는 순서값등을 제공
   - info.index: 0 부터 시작 / - status.count: 1 부터 시작
 
1) JSTL을 이용한 고유한 ID의 생성과 JS 함수로의 전달
- 하나의 JSP 페이지에서 id값은 고유해야. 중복을 방지하기위하여 '${info.index }'등을 사용
<input type="number" id="cnt${info.index }" name="cnt">
→
<input type="number" id="cnt1" name="count">
<input type="number" id="cnt2" name="count">
<input type="number" id="cnt3" name="count">
              
<A href="javascript:proc(frm.cnt${status.index }.value)">
→
<A href="javascript:proc(frm.cnt1.value)">
<A href="javascript:proc(frm.cnt2.value)">
<A href="javascript:proc(frm.cnt3.value)">
    
2) 마지막 요소의 처리 
<c:forEach items="${fileList}" var="current" varStatus="stat">
   { id: 1001, data: [ "<c:out value="${current.fileName}" />", "<c:out value="${current.path}" />" ] }
   <c:if test="${!stat.last}">,</c:if>
</c:forEach>

3) 일련번호의 출력: 1 ~ 레코드수
<c:forEach items="${fileList}" var="current" varStatus="info">
   <TR>
     <TD>${info.count}</TD>
     <TD>${vo.title}</TD>
   </TR>
</c:forEach>

4) 실습
{ id: 1001, data: [ "암살", "전지현" ] }, { id: 1001, data: [ "골목식당", "백종원" ] }, 
{ id: 1001, data: [ "숨바꼭질", "이유리" ] } 

▷ /sts_basic/src/main/webapp/jstl/forEachTag.jsp
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sts.basic.test.ELDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>/webapp/jstl/forEachTag.jsp</title> 
<style type="text/css">
  * { font-size: 26px; }
</style>
</head>
<body>
<DIV class='container_main'>
<DIV class='content'>

  <!-- forEach 문 index는 1부터 5까지 1씩 증가-->
  <c:forEach var="index" begin="1" end="5" step="1">
    ${index }
  </c:forEach>
  <br><br>
  
  <!-- 배열 선언과 동시에 초기화 -->
  <%
  request.setAttribute("datas", new String[]{"JAVA", "JSP", "SPRING"});
  %>
  <!--forEach 문에서 자동으로 일련번호 생성 .count : 1.java 2.jsp 3.spring  -->
  <c:forEach var="item" items="${datas }" varStatus="info">
    ${info.count }. ${item }<br>
  </c:forEach>
  <br> 
  <!-- 위와 같지만 .index 번호로 출력 0.java 1.jsp.... -->
  <c:forEach var="item" items="${datas }" varStatus="info">
    ${info.index }. ${item }<br>
  </c:forEach>
  <br>
  
  <!-- ArrayList에 general 사용 ELDTO Type  -->
  <%
  ArrayList<ELDTO> list = new ArrayList<ELDTO>();
  ELDTO eldto = new ELDTO("암살", "전지현");   // ELDTO 클래스(private movie와 name)
  list.add(eldto);
  eldto = new ELDTO("골목식당", "백종원");
  list.add(eldto);
  eldto = new ELDTO("숨바꼭질", "이유리");
  list.add(eldto);
  
  request.setAttribute("list", list);
  %>
  <!-- scriptlet -->
  <%
  int size = list.size(); // 객체의 수
  for (int index = 0; index < size; index++) {
    ELDTO vo = list.get(index); // 객체 추출
    out.print((index+1) + ". " + vo.getMovie() + "(" + vo.getName() + ")<br>");
  }
  %>  
  <br>
  
  <!-- 위의 JSP를 jstl로 처리 -->
  <c:forEach var="vo" items="${list}" varStatus="info">
    ${info.count }. ${vo.movie } (${vo.name })<br>
  </c:forEach>

</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
</html>