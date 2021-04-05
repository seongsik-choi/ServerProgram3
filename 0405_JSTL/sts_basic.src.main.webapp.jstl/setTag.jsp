<%-- 
0405_[14] JSTL(JSP Standard TAG Library)의 사용, ★ include JSP간 jstl 중복 선언시 에러 발생할수도

[01] JSTL(JSP Standard TAG Library)의 사용
- https://tomcat.apache.org/taglibs/standard/
★ include JSP간 jstl 중복 선언시 에러 발생 있을 수 있음. 
   - 많이 사용되는 사용자(개발자) 정의 태그를 모아서 JSTL이라는 규약이 만듬
   - JSP 스크립틀릿을 사용하는 것보다 훨씬 간결한 문법 구조를 지원
   - EL은 제어문을 제공하지 않아서 분기 처리, 반복 처리가 불편한 것을 JSTL이지원(EL은 3항 연산자는 제공)
   - 처리 흐름
     JSP -----------------------> request, session 객체 접근(자바 코드 많이 발생)
     JSP --------------> EL ---> request, session 객체 접근(제어문등 사용 불편)
     JSP ---> JSTL ---> EL ---> request, session 객체 접근(제어문 지원, 소수의 자바 코드)
   
   - JSTL은 5가지의 태그를 지원
     라이브러리    기능                                      접두어(prefix)     
     ---------------------------------------------------------------------- 
       Core          변수지원, 흐름 제어, URL 처리           c          
       관련 URL: http://java.sun.com/jsp/jstl/core ★

       XML           XML 코어, 흐름 제어, XML 변환         x       
       관련 URL: http://java.sun.com/jsp/jstl/xml 

       국제화        지역, 메시지 형식, 숫자 및 날짜 형식          fmt         
       관련 URL: http://java.sun.com/jsp/jstl/fmt 

       데이터베이스  SQL                                         sql       
       관련 URL: http://java.sun.com/jsp/jstl/sql 

       함수          콜렉션 처리, String 처리                       fn         
       관련 URL: http://java.sun.com/jsp/jstl/functions
       ---------------------------------------------------------------------- 

1. STS Maven의 pom.xml 에 기본적으로 JSTL 관련 스크립트가 선언되어 있음으로 별다른 설정이 필요no
 1) maven의 경우(Legacy)
   <dependency>
     <groupId>javax.servlet</groupId>
     <artifactId>jstl</artifactId>
     <version>1.2</version>
   </dependency>

 2) Gradle 설정(보통 Boot에서 사용 -> build.gradle)
// https://mvnrepository.com/artifact/javax.servlet/jstl
implementation group: 'javax.servlet', name: 'jstl', version: '1.2'

-> 인식이 안되면 jstl.jar을 다운받아 /WEB-INF/lib 폴더 직접 저장하여 사용.
 
2. Core Tag 
기능         태그명     기능설명 
--------------------------------------------------------------------------- 
변수 지원   set          jsp에서 사용될 변수를 설정 
            remove    설정한 변수를 제거
--------------------------------------------------------------------------- 
흐름 제어      if            조건에 따라 내부 코드를 수행
               choose     다중 조건을 처리할 때 사용 else ~ if 기능을 대신함 
               forEach    Collection의 각 항목을 처리할 때 사용
               forTokens 구분자로 분리된 각각의 토큰을 처리  
--------------------------------------------------------------------------- 
URL 처리      import     URL을 사용하여 다른 자원의 결과를 삽입
               redirect   지정한 경로로 이동
               url          URL을 재 작성  
--------------------------------------------------------------------------- 
기타 태그       catch       예외 처리에 사용
               out         jspWriter에 내용을 알맞게 처리한 후 출력
--------------------------------------------------------------------------- 
  
pass. [참고] STS Maven을 사용하지 않는 경우의 설치 
 - Download: http://tomcat.apache.org/taglibs/index.html 
 - API DOC: http://tomcat.apache.org/taglibs/standard/apidocs/
 - http://archive.apache.org/dist/jakarta/taglibs/standard/binaries/ 
   'jakarta-taglibs-standard-1.1.2.zip ' 파일을 다운
 - 압축을 해제한 후 "/setup/jakarta-taglibs-standard-1.1.2/lib"폴더안에
   있는 'jstl.jar', 'standard.jar'파일을 '/WEB-INF/lib'폴더로 복사

[02] EL & JSTL의 사용
     - JSTL 선언
       <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
Eclipse project: sts_baisc 계속 사용

- sts_basic : legacy project에서 실습 진행
- JSTL로 코드 작성해도 -> source 보기 시 -> Tag로 바뀌어있음.
1. 변수지원 태그 
▷ /sts_basic/src/main/webapp/jstl/setTag.jsp 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 명시-->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- JSTL의 fmt 태그 -->
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>/webapp/jstl/setTag.jsp</title> 
<style type="text/css">
  * { font-size: 26px; }
</style>
</head> 
 
<body>
<DIV class='container_main'>
<DIV class='content'>
   <!-- JSTL -->
   <!-- Legacy 경로는 제일처음 프로젝트명(test) 명시 -->
   <c:set var="img" value="<IMG src='/test/resources/jstl/images/url4.png'>" />

   ${img } JAVA<BR>
   ${img } JSP<BR>
   ${img } SPRING<BR>
   ${img } MyBATIS<BR>
   ${img } R<BR>
   ${img } Python<BR>
   ${img } Crawling<BR>
   ${img } Analysis<BR>
   ${img } Machine Learning<BR> 
   
   <br>
   <!-- EL에 contextPath값 할당 : legacy만 가능 -->
   <c:set var="root" value="${pageContext.request.contextPath }" />
     절대 경로: ${root }
   <br><br>
   
   <!-- Scriptlet을 값으로 할당, EL로 출력 -->
   <c:set var="tot" value="<%=(2020+1) %>" />
    합계: ${tot }
   <br><br>
   
   <!-- 천단위 구분자 콤마 출력 -->
   <%
   int pay = 2500000;
   request.setAttribute("pay", pay);
   %>
   급여: <fmt:formatNumber value="${pay }" pattern="￦ #,###" /> <!-- fmt 태그 사용 -->
   
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
</html>