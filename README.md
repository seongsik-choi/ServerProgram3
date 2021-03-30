# 3) 서버 프로그래밍3 (구현) : Spring Boot
## STS4(Spring Tool Suite4) Tree Structure  
  **C:/dic/WS_FRAME/start, basic**    
  **package 명 : dev.boot.start**  
├─bin/main/dev/boot  
│               └─start,basic    <-- JAVA class 실행: 내장 톰캣이 실행되어 동일하게 작동  
├─build.gradle	 <--  gradle build 명세, 프로젝트에 필요한 라이브러리 정의, 빌드 및 배포 설정, 스프링 부트의 버전을 명시, 자바 버전 명시, Jar library 의존성 옵션  
│  
├─Project and External Dependencies	<-- gradle에 명시한 Spring project 의존 라이브러리 목록  
│  
├─src    <--  JSP등 리소스 디렉토리  
│  └─/main/java  <-- 자바 소스 폴더  
│  └─/main/java/dev.boot.start.StartApplication.java  <-- main 메소드가 존재하는 자바 class(구성과 최초 실행)  
│  └─/main/resources/static	<-- Image, CSS, Javascript등 정적 파일들 저장(=src/main/webapp/resources)  
│  └─/main/resources/application.properties  <-- 환경 설정에 사용할 properties 정의  
└─WebContent       <-- Web Service를 위한 dic  

* **0326 : [01] STS 4.5.1(Spring Tool Suite) 설치(STS 4.6.0 권장) -> 이미 설치**  
* **0326 : [02] Spring Boot 프로젝트 생성**  
**[01] Spring Boot 프로젝트 생성**    
  * a. FILE -> NEW -> 'Spring Starter Project' 실행
  * b. 보이지 않는 경우 : Windows -> perspective -> open perspective -> other -> Spring  
  * c. 프로젝트명: start, Package: dev.boot.start  
    * Service URL : https://start.spring.io 웹 상에서 프로젝트 기초 소스 생성  
    * Name : project name  
    * Type : library 관리 툴, Gradle  
    * Packaging : 배포 형태, War  
    * Group : dev.boot  
    * Artifact : start   
    * version : source version  
    * Package : project main source package  
  * d. 의존 library 추가 : Spring boot Version(2.3.9)  
    * 'Web -> Spring Web'을 체크 
    * [Finish] 버튼을 클릭 
---
* **0329 : [02]문자열 출력, 프로젝트 구조(project: start), 문자열 출력, 프로젝트 구조(project: start)**  
 * e. 프로젝트가 생성 : start/src/main/java/dev.boot.start.StartApplication.java  
**▶Spring Legacy와 차이 : Server와 App의 분리, JAVA와 Linux 설치 시 즉시 배포 가능**    
  ~~~
// StartApplication.java  
package dev.boot.start;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class StartApplication {
	public static void main(String[] args) {
		SpringApplication.run(StartApplication.class, args);  // Spring FrameWork의 기능을 갖게됨.
	}
}
  ~~~
 * **e. 8080 포트는 오라클이 사용중임, '/src/main/resources/application.properties'에 코드 추가**  
    * **server.port = 9091**  
**▶ Server실행 3가지 : Spring Boot App(내장톰캣) / Boot Dashboard(내장톰캣) / Run on Server(구형외부실행)**  
 * f. 프로젝트를 선택하고 'Spring Boot App'을 실행: 내장 톰캣 기반 실행  
    * Start 프로젝트 선택 -> Run As -> Spring Boot App  
    * Error : 프로젝트만 실행된 경우 STS 내부 브라우저는 404 에러.  
 * g. 웹에서 정상적으로 실행 확인 : STS 내부 브러우저 실행: http://localhost:9091  
    * 크롬 실행: http://localhost:9091 : Whitelabel Error Page  
 * h. Boot Dashboard 열기  
 * i. Boot Dashboard를 이용한 서버 실행  
 * j. 웹에서 정상적으로 실행 확인 :  크롬 실행: http://localhost:9091  
 * k. Boot Dashboard를 이용한 서버 중지  

**[02] 문자열 출력하기(jsp 페이지 없이 Rest 형식의 출력)**    
 ~~~
// HelloCont.java
package dev.boot.start;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController       // Controller 중 JSP 없이 단순 출력(ex.JSON 출력)
public class HelloCont {
  @RequestMapping("/")  
  public String hello() { // ModelAndView Return 타입이 아닌 일반 자료형 Return.
    return "안녕하세요. Spring Boot 입니다 :D";
  }
}
~~~
- 실행: DevTools가 설치되어 있지 않음으로 아직 자동 새로고침 안됨으로 서버를 재부팅  
▶ 크롬 실행: http://localhost:9091  
▶ **Legacy의 경우 port 번호 뒤 /패키지명 필요했지만 Boot는 필요No(배포를 위해)** 
~~~
Legacy 기반 프로그램의 경우 : 경로 설정이 반드시 필요
EX) 개발시에는 localhost:9090/패키지명을 포함시키지만
  -> 배포시에는 패키지명 대신 localhost:9090/로 표시
<% 
// String root = request.getContextPath(); // /resort 
// ${pageContext.request.contextPath}
%>
...
<A class='top_menu_link'  href='${pageContext.request.contextPath}' >
~~~
[참고] 고전적인 실행 방법(속도가 매우 늦고 JSP인식등의 문제로 권장하지 않음), 실행 주소에 Context Path 'start'가 출력됨.  
▶ **Spring Boot(내장 톰캣) 실행 : http://localhost:9091    // ContextPath 명시 No**   
▶ **Spring Legacy(구형 톰캣) 실행 :  http://localhost:9090/start/    // ContextPath가 항상 명시**     

---  
* **0329 :[03] spring-boot-devtools 설정, jsp 파일 실행 설정, HTML 및 이미지 출력, CSS 실행, Javascript 실행, JSP+JSTL 실행(project: start)**

**[01] 새로고침 인식을위한 spring-boot-devtools 설정**  
1. http://mvnrepository.com
2. spring-boot-devtools 검색(Spring version 2.3.9과 일치를 권장)  
// https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-devtools  
compile group: 'org.springframework.boot', name: 'spring-boot-devtools', version: '2.3.9.RELEASE'  
3. gradle dependency 편집 : Spring Boot 버전과 일치 권장

**[02] jsp 파일 실행 설정**  
1. jsp 사용을위한 의존성 추가 : dependencies에 추가!! 
   - maven web page에서 'JSTL', 'tomcat-embed-jasper' 검색하여 설치 가능하나  
   - tomcat-embed-jasper는 권장 버전 설치되도록 할것. version 속성 생략(하단의 2 Line)
   - JSTL 사용 선언/ Tomcat JSP compile library 추가  
 ~~~
 ▶ Spring Boot 2.3.9와 Tomcat 9.0.43의 맞는 의존성
 implementation 'javax.servlet:jstl'
 implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'
 
 // Default는 version 명시
 // https://mvnrepository.com/artifact/org.apache.tomcat.embed/tomcat-embed-jasper
implementation group: 'org.apache.tomcat.embed', name: 'tomcat-embed-jasper', version: '9.0.43'
 ~~~
 
~~~
▷ /src/main/resources/application.properties 변경 : 3line 추가
server.port=9091
# DEVTOOLS (DevToolsProperties)
spring.devtools.livereload.enabled=true  <- 추가

▷ build.gradle 편집 : 6 line 추가  
dependencies {  
	implementation 'org.springframework.boot:spring-boot-starter-web'  
	providedRuntime 'org.springframework.boot:spring-boot-starter-tomcat'  
	testImplementation('org.springframework.boot:spring-boot-starter-test') {  
		exclude group: 'org.junit.vintage', module: 'junit-vintage-engine'  
	}  
  // 해당 란에 2 line 추가(spring-boot-devtools)  
  // https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-devtools  
  implementation group: 'org.springframework.boot', name: 'spring-boot-devtools', version: '2.3.9.RELEASE'  
    
  // 해당 란에 2 line 추가(JSTL)  
  // https://mvnrepository.com/artifact/javax.servlet/jstl
  implementation 'javax.servlet:jstl'
    
  // 해당 란에 2 line 추가(tomcat-embed-jasper)  
  // https://mvnrepository.com/artifact/org.apache.tomcat.embed/tomcat-embed-jasper
  implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'
}  
 ~~~ 
5. Gradlere fresh  : build.gradle 선택 -> Gradle -> Refresh -> Gradle Project
6. 다운로드된 library 확인 : C:/Users(사용자)/.gradle/caches/modules-2/files-2.1/  

~~~
★ Spring Boot 경로 표현 ★
1)  /static/css/style.css  ->  /css/style.css
2)  /static/images/finemae -> /images/puppy06.jpg
3) /static/js/function.js -> /js/function.js

3. 폴더 생성: /webapp/WEB-INF/views 대소문자 일치시킬것 ★
[03] HTML 및 이미지 출력
1. 이미지 저장
2. HTML 실행
- http://localhost:9091/swiss/images.html  // src/main/resources/static/images dic 생성

▷ /src/main/webapp/swiss/images.html
<!-Spring Boot에서 이미지 접근을 위해서는 /static/images/finemae으로 접근! -!>

[04] CSS 실행
1. CSS
▷ /static/css/style.css
2. HTML
- http://localhost:9091/swiss/style.html
▷ /src/main/webapp/swiss/style.html

[05] Javascript 실행
1. Javascript
▷ /static/js/function.js
2. HTML
- http://localhost:9091/swiss/js.html
▷ /src/main/webapp/swiss/js.html

[06] JSP 실행
- Context Path의 값은 없음.
1. JSP
- http://localhost:9091/swiss/swiss.jsp
▷ /src/main/webapp/swiss/swiss.jsp
~~~

---
* **0329 :[04] basic 프로젝트 생성, 빈즈의 사용, 패키지 자동 import**
~~~
[01] basic 프로젝트 생성, 빈즈의 사용, 패키지 자동 import
- 패키지 자동 import: Ctrl + Shift + O

1. 'Spring Starter Project' 실행
2. 프로젝트명: basic, Package: dev.boot.basic
3. 의존 library 추가
1) Available: Spring Boot DevTools 입력하여 검색해서 추가
2) Web -> Spring Web을 체크하여 추가
   이후 누락된 library는 build.gradle에서 직접  추가 할 수 있음
3) [Finish] 버튼을 클릭

4. '/src/main/resources/application.properties' 변경
- 8080 포트는 오라클이 사용중임으로 아래의 코드를 추가함.
   server.port = 9091

- Controller 실행시 jsp 경로 설정 추가
# JSP View path
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

- 자동 새로고침
# DEVTOOLS (DevToolsProperties)
spring.devtools.livereload.enabled=true

5. jsp 사용을위한 의존성 추가
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    developmentOnly 'org.springframework.boot:spring-boot-devtools'
    providedRuntime 'org.springframework.boot:spring-boot-starter-tomcat'
    testImplementation('org.springframework.boot:spring-boot-starter-test') {
        exclude group: 'org.junit.vintage', module: 'junit-vintage-engine'
    }
  implementation 'javax.servlet:jstl'
  implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'
}
▷ build.gradle 편집 -> Gradle -> Refresh Gradle Project
~~~

~~~
6. jsp 폴더 생성
/src/main/webapp/WEB-INF/views

7. VO(DTO) 생성 : getter, Setterr
▷ /src/main/java/dev.boot.basic/EmployeeVO.java

8. VO(DTO) test class 제작 : getter, setter 사용 예제
▷ /src/main/java/dev.boot.basic/EmployeeVOUse.java

9. Controller class 제작 : view.jsp로 넘기기 위한 Controller(ModelAndView create())
▷ /src/main/java/dev.boot.basic/EmployeeCont.java 

  // Legacy 다르게 프로젝트명 사용 No, @RequestMapping에 명시한 대로 사용
  // http://localhost:9091/employee/employee.do
  @RequestMapping(value="/employee/employee.do", method=RequestMethod.GET )
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
  
    EmployeeVO employeeVO  = new EmployeeVO();  // 객체 생성
    // sungjukVO.name = "주지훈"; // The field SungjukVO.name is not visible
    
    employeeVO.setName("주지훈");	// EmployeeVO.java의 setter 호출
    employeeVO.setTot(300);
    employeeVO.setAvg(100);
    
    mav.addObject("employeeVO", employeeVO); // request.setAttritube("employeeVO", employeeVO);
    
    /* 
     /src/main/webapp/WEB-INF/views/employee/employee.jsp
    application.properties의
     spring.mvc.view.prefix=/WEB-INF/views/ 와
     mav.setViewName("/employee/employee"); 가 조합
     /WEB-INF/views/employee/employee의 경로완성
     */
    mav.setViewName("/employee/employee");
    
    return mav;
  }

10. JSP view 제작 : EL로 View 구현
▷ /src/main/webapp/WEB-INF/views/employee/employee.jsp
~~~

~~~
11. 실행 화면
1) Boot Dashboard -> 2) BasicApplication -> 3) http://localhost:9091/employee/employee.do 접속
[참고] Lombok eclipse plugin 설치, 버그 있음 ★★★★★
- VO(DTO) class의 setter, getter를 자동으로 생성함.
- 변수명이 대소문자가 혼합되면 정상적으로 getter, setter가 생성이 안되는 버그 있음★★★★★
- STS 재시작시 getter, setter가 자동으로 생성되나 다른 클래스에서 인식 안되는 버그 있음★★★★★

1. 공식 홈페이지: https://projectlombok.org
2. https://projectlombok.org/download 접속
3. 탐색기에서 lombok.jar 실행
4. Specify location...
5. STS가 설치된 폴더의 SpringToolSuite4.exe 실행 파일 지정
6. Install / Update
7. 설치 성공
8. SpringToolSuite4.ini 변경
▷ C:/ai6/sts-4.5.1\SpringToolSuite4.ini
9. STS restart
10. VO(DTO) class 제작
~~~
---
* **0330 :[05] MyBATIS framework 3.4.1 개론, Website 개발 절차, MyBATIS 기초 코드 ★**
**▶ 0329 복습**  
~~~
1) Spring Boot는 Legacy 다르게 프로젝트명 사용 No, @RequestMapping에 명시한 대로 사용

2) @RequestMapping(value="/employee/employee.do", method=RequestMethod.GET)
// http://localhost:9091/employee/employee.do
  
3) @RequestMapping("/")
// http://localhost:9091    /은 Root Dic

4) @RestController      
// Controller 중 JSP(/Webapp의 JSP)없이 단순 출력(ex.JSON 출력)

5) Spring Boot의 Static resource 경로 표현 : 이미지, css 등 리소스
// /static/css/style.css       ->  /css/style.css     
   /static/images/fname.jpg -> /images/fname.jpg

6) Getter, Setter : EmployeeCont.java로  ModelAndView create() 생성해 @RequestMapping
~~~

~~~
[01] MyBATIS framework 3.4.1 개론
EX) JSTL 오류 : https://mvnrepository.com/artifact/javax.servlet/jstl/1.2  -> 다운 : /WEB-INF/lib/다운받은 jar 넣기
    - http://www.mybatis.org
    - download: https://github.com/mybatis/mybatis-3/releases 
    - SQL과 비즈니스 로직(자바)이 분리되어 있어 개발 및 배포 및 관리가 뛰어남. 
     - 자바 개발시 SQL이 DAO class에 포함되어 있으면 SQL을 추출하여 테스트가 어려움.
     - SQL이 변경되는 경우 관련 자바 코드를 변경해야하는 단점이 있다.
     - DAO class에 SQL을 선언할경우 컬럼이 많아지면 JAVA 코드상에서 단순반복 작업이 크게 증가
     - MyBATIS를 이용하면 자바와 DBMS의 연결을 XML을 이용하여 선언하고 Connection open/close를
       자동으로 지원함으로 안정성이 높아짐
     - SQL을 JAVA와 분리함으로 독립적인 팀 개발이 가능하며 개발 시간을 단축 할 수 있음
     - SQL 실행과 관련된 많은 코드(Connection, PreparedStatement, ResultSet, ? Parameter 지정)를 코딩할 필요 no
     - VO(DTO)가 SELECT시 자동으로 생성
     - 일반 SQL뿐만 아니라 PL/SQL, 저장 프로시져까지 MyBATIS는 처리할 수 있음.
       . Stored procedure도 SQL을 JAVA에서 분리하나 데이터베이스 종속적으로
         DBMS를 변경하면 재사용할 수 없고 MySQL 용으로 다시 프로시저를 제작해야
     - 파라미터와 제어문을 이용하여 동적으로 실행 할 SQL을 지정할 수 있음
     - Spring은 MyBATIS가 선언한 SQL과 관련된 JAVA 코드를 자동으로 생성
     - MyBATIS는 SQL 튜닝 기법을 이용하여 우수한 성능을 갖는 웹페이지 제작이 가능

1. 실행 아키텍쳐                                                            
                          SqlMapConfig 
                                 ↓ 
                          SQL Map 파일 
                                 ↓ 
입력 ----------> SQL Mapping 구문 ----> MyBATIS 실행 ----> 출력 
Hashtable                   XML                      ↓                   Hashtable  
POJO                                                  DBMS                POJO(VO(DTO), ArrayList...) 
원시 타입                                            MySQL               원시 타입(int, double...)
                                                        MariaDB
                                                         Oracle
  
2. 다운 로드 및 설치(Spring을 사용하지 않는 경우, JSP Model 1 기반) 
    - iBATIS 2.0은 MyBATIS 2와 같음
    - iBATIS 3.0부터는 MyBATIS 3로 변경되고 Annotation 기반으로 문법이 일부 변경됨
    - 전자정부 프레임웍 및 대부분의 기업은 MyBATIS를 사용
 
3. Spring의 경우 다운로드가 필요 없습니다. Maven 설정으로 자동 다운
   - http://mvnrepository.com
    <!-- MyBATIS -->
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
    <dependency>
      <groupId>org.mybatis</groupId>
      <artifactId>mybatis</artifactId>
      <version>3.4.1</version>
    </dependency>
 
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
    <dependency>
      <groupId>org.mybatis</groupId>
      <artifactId>mybatis-spring</artifactId>
      <version>1.3.1</version>
    </dependency>
    
4. SQL Maps 설정 파일 
   - transactionManager type="JDBC" 
     . JDBC: 간단한 JDBC기반 트랜잭션 관리 기능을 제공(일반 적인 사용) 
     . JTA: 컨테이너 기반의 트랜잭션 기능을 제공.(분산 트랜잭션 지원) 
     . EXTERNAL: 트랜잭션 관리자를 제공하지 않고 iBATIS 대신 애플리케이션이 직접 트랜잭션을 관리

   - commitRequired="false" 
     . Connection을 닫기전에 commit할 것인지 지정. 

   - dataSource type="SIMPLE" 
     . SIMPLE: 간단한 커넥션 풀을 내장한 데이터 소스를 설정하고자 할때 사용 
     . DBCP: Jakarta Commons Database Connection Pool을 제공합니다. 
     . JNDI: JNDI를 통해 할당된 컨테이너 기반 데이터 소스를 공유하도록 제공
             
   - sqlMap resource="/src/main/java/dev/mvc/member/member.xml" 
     . java 소스상에 SQL Map 파일을 저장하고 참조할 경로를 지정
 
5. SQL Map 파일 
   - SQL 쿼리를 XML 파일로 매핑하여 저장한 후 호출하여 실행 
    
6. Project 개발 순서(Spring MVC 기준) 
   
1) 구현 기능 분석(업무 분석) 
2) DB 모델링(TABLE 생성) 
3) SQL 생성 및 테스트 
4) VO(DTO) 생성 
         | 
         |               MyBATIS/iBATIS 
         +---------------┐ 
         |       SQL을 MyBATIS XML로 변환.  
         |                    | 
         |       SQL XML Mapping File 생성 
         |                    | 
         |    Execute Class 생성 (Spring은 자동화)
         +<-------------┘ 
         | 
         | 
5) DAO Interface 생성
6) DAO Interface 구현(DBMS 관련 기능, MyBATIS 사용시는 자동 생성됨)
7) Process Interface 생성(Business Logic, Manager/Service class)
8) Process Interface 구현
9) Spring Controller MVC Action class 생성 
10) Controller, Beans(Tool(Utility 날짜 처리등 각종 메소드), Paging, Download)
11) JSP 제작, Controller, Beans와 연동
12) 테스트
13) Python을 이용한 데이터 분석(통계) 
14) Tensorflow를 이용한 기계 학습 적용
  
[02] MyBATIS 사용

1. 일반적인 SQL 사용
- DBMS 컬럼이 null 허용을 하더라도 VO변수의 값이 null이면 {file1} 부분에서 1111 에러발생

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
 
<mapper namespace="blog">
 
  <insert id="create" parameterType="BlogVO">
    INSERT INTO blog(blogno, blogcategoryno, title, content, good, file1, file2, size2, cnt, replycnt, rdate)  
    VALUES((SELECT NVL(MAX(blogno), 0) + 1 as blogno FROM blog),
      #{blogcategoryno}, #{title}, #{content}, 0, #{file1}, #{file2}, #{size2}, 0, 0, sysdate)
  </insert>
 
  <select id="list" resultType="BlogVO">
    SELECT blogno, blogcategoryno, title, content, good, file1, file2, size2, cnt, replycnt, rdate
    FROM blog
    ORDER BY blogno DESC
  </select>
 
  <select id="list2" resultType="BlogVO" parameterType="int">
    SELECT blogno, blogcategoryno, title, content, good, file1, file2, size2, cnt, replycnt, rdate
    FROM blog
    WHERE blogcategoryno=#{blogcategoryno}
    ORDER BY blogno DESC
  </select>
 
  <select id="read" resultType="BlogVO" parameterType="int">
    SELECT blogno, blogcategoryno, title, content, good, file1, file2, size2, cnt, replycnt, rdate
    FROM blog
    WHERE blogno=#{blogno}
  </select>
  
  <update id='update' parameterType="BlogVO">
    UPDATE blog
    SET title=#{title}, content=#{content}, file1=#{file1}, file2=#{file2}, size2=#{size2}
    WHERE blogno=#{blogno}
  </update>
 
  <delete id="delete" parameterType="int">
    DELETE FROM blog
    WHERE blogno=#{blogno}
  </delete>        
</mapper>  
   
2. 동적인 SQL 사용
1) if문(if ~ else는 지원 안함) - MySQL
   <if test="content == true">
     OR CONTENT LIKE concat('%', #{search}, '%') 
   </if> 
 
   <if test="writer == 'rik'">
     AND NAME LIKE concat('%', #{search}, '%') 
   </if> 
 
   <if test="pageSize > 0">
     limit #{startIndex}, #{pageSize}
   </if>
 
   <if test="firstName != null and firstName != ''">
     AND FIRST_NAME = #{firstName}
   </if>
 
   <select id="getAllEmployeeInfo"
     parameterType="EmployeesVO" resultType="EmployeesVO">
     SELECT employeeId, firstName
            <if test="firstName != null and firstName != ''">
              , lastName
            </if>
     FROM EMPLOYEES
     WHERE LAST_NAME = #{lastName}
     <if test="firstName != null and firstName != ''">
       AND FIRST_NAME = #{firstName}
     </if>
  </select>
 
2) WHER를 분리한 경우 - Oracle
.....
   // HashMap hashMap = new HashMap();
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("categoryno", 1);
    hashMap.put("col", "titlte");
    hashMap.put("word", "swiss");
.....
  <select id="list3" resultType="BlogVO" parameterType="HashMap" >
    SELECT blogno, categoryno, title, content, good, file1, file2, size2, cnt, replycnt, rdate
    FROM blog
    WHERE blogcategoryno=#{categoryno}
    
    <choose>
      <when test="col == 'title'">
         AND title LIKE '%' || #{word} || '%' 
      </when>
      <when test="col == 'content'">
         AND content LIKE '%' || #{word} || '%' 
      </when>
      <when test="col == 'title_content'">
         AND title LIKE '%' || #{word} || '%'  OR content LIKE '%' || #{word} || '%' 
      </when>      
    </choose>
    
    ORDER BY blogno DESC
  </select>    
 
 3) WHER를 분리한 경우 - MySQL
    SELECT pdsno, rname, email, title, content, passwd, cnt, rdate, url, file1, size1 
    FROM pds3
    WHERE title LIKE '%동그라미%'
    ORDER BY pdsno DESC;
 
 pdsno rname email title      content   passwd cnt rdate                 url                      file1       size1
 ----- ----- ----- ---------- --------- ------ --- --------------------- ------------------------ ----------- -----
    25 베짱이   mail1 하얀 동그라미 재판 코카서스의 백묵원 123      0 2017-06-22 17:38:06.0 http://art.incheon.go.kr welcome.jpg  1000
 
    SELECT pdsno, rname, email, title, content, passwd, cnt, rdate, url, file1, size1 
    FROM pds3
    WHERE title LIKE CONCAT('%', '동그라미', '%')
    ORDER BY pdsno DESC;
 
 pdsno rname email title      content   passwd cnt rdate                 url                      file1       size1
 ----- ----- ----- ---------- --------- ------ --- --------------------- ------------------------ ----------- -----
    25 베짱이   mail1 하얀 동그라미 재판 코카서스의 백묵원 123      0 2017-06-22 17:38:06.0 http://art.incheon.go.kr welcome.jpg  1000
.....
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    
    // 페이지에서 출력할 시작 레코드 번호 계산, nowPage는 1부터 시작
    int offset = (productVO.getNowPage() -1) * Product.RECORD_PER_PAGE;
    
    hashMap.put("scategoryno", productVO.getScategoryno());
    hashMap.put("word", productVO.getWord());
    
    hashMap.put("offset", offset);
    hashMap.put("count", Product.RECORD_PER_PAGE);
.....
  <select id="list" resultType="ProductVO" parameterType="HashMap">
    SELECT productno, scategoryno, profile, title, content, price, url, size1, thumb, word
    FROM product
 
    <choose>
      <when test="word == null or word == ''">
        WHERE scategoryno=#{scategoryno}
      </when>
      <otherwise>
        WHERE scategoryno=#{scategoryno} AND word LIKE CONCAT('%', #{word}, '%')
      </otherwise>
    </choose>
    
    ORDER BY productno DESC
    LIMIT #{offset}, #{count}
  </select>
 
3. 정렬의 구현
  <select id="list3" resultType="BlogVO" parameterType="HashMap" >
    SELECT blogno, categoryno, title, content, good, file1, file2, size2, cnt, replycnt, rdate
    FROM blog
    WHERE blogcategoryno=#{categoryno}
    
    <choose>
      <when test="vno == 1">
         ORDER BY title ASC
      </when>
      <when test="vno == 2">
         ORDER BY name ASC
      </when>
      <when test="vno == 3">
         ORDER BY email ASC
      </when>  
      <otherwise>
        ORDER BY rdate ASC
      </otherwise>      
    </choose>
  </select>    
 
4. IN 함수의 사용
- WHERE idno IN(1, 2, 3)

<select id="list" resultType="MemberVO">
  SELECT name, email
  FROM member
  WHERE ID in
    <foreach item="item" index="index" collection="list" open="(" separator="," close=")">
      #{item}
    </foreach>
</select>
  
5. 함수 호출
WHERE rdate BETWEEN TO_DATE(#{startdate}, 'YYYY-MM-DD') AND TO_DATE(#{enddate}, 'YYYY-MM-DD') 
 
WHERE rdate BETWEEN TO_DATE(#{startdate}, 'YYYY-MM-DD HH24:MI:SS') 
                                AND  TO_DATE(#{enddata}, 'YYYY-MM-DD HH24:MI:SS')

6. 등록된 PK를 리턴하는 스크립트
1) Oracle에서 NVL(MAX(wno), 0) + 1을 사용하는 경우
<!-- 등록, id: create, 입력: PK, 리턴: boardno -->
  <insert id="create" parameterType="WriteVO" useGeneratedKeys="true" keyProperty="wno">
     INSERT INTO write(wno, 
                         wtitle, wcontent, wrecom, 
                         wreplycnt, rdate, wword, boardno)
     VALUES(#{wno},
                #{wtitle}, #{wcontent}, 0,
                0, sysdate, #{wword}, #{boardno})
                
     <selectKey keyProperty="wno" resultType="int" order="BEFORE">
       SELECT NVL(MAX(wno), 0) + 1 as wno FROM write
     </selectKey>                
   </insert>

2) Oracle sequence 받기
  <insert id="create" parameterType="ContentsVO">
    <!-- 등록후 ContentsVO class의 contentsno 컬럼에 PK return  -->
    <selectKey keyProperty="contentsno" resultType="int" order="BEFORE">
      SELECT contents_seq.nextval FROM dual
    </selectKey>
    INSERT INTO contents(contentsno, memberno, cateno, title, content, web, ip,
                                     passwd, word, rdate)
    VALUES(#{contentsno}, #{memberno}, #{cateno}, #{title}, #{content}, #{web}, #{ip},
                #{passwd}, #{word}, sysdate)
  </insert>
 
3) MySQL에서 AUTO_INCREMENT를 사용하는 경우
<!-- 등록, id: create, 입력: PK, 리턴: boardno -->
  <insert id="create" parameterType="WriteVO" useGeneratedKeys="true" keyProperty="wno">
     INSERT INTO write(wtitle, wcontent, wrecom, 
                         wreplycnt, rdate, wword, boardno)
     VALUES(#{wtitle}, #{wcontent}, 0,
                0, sysdate, #{wword}, #{boardno})             
   </insert>

6. JOIN, resultMap 이용

1) resultMap이용
    - column : 데이터베이스 컬럼명
    - property : VO class의 필드명
    - association: 하나의 VO 객체
    - collection: VO class의 List 객체 
    - javaType : VO class type, java.util.ArrayList: 다른 MyBATIS 호출 후 결과를 List로 받는 경우
    - select: 다른 MyBATIS 호출 후 결과를 List로 받는 경우 다른 MyBATIS의 id명

2) 1:1 Join, Map 이용
  <resultMap type="Categrp_Cate_VO" id="Categrp_Cate_VO_Map">
    <association javaType="CategrpVO" property="categrpVO">
      <result column="r_categrpno" property="categrpno"/>
      <result column="r_name" property="name"/>
      <result column="r_seqno" property="seqno"/>
      <result column="r_visible" property="visible"/>
      <result column="r_date" property="rdate"/>  
    </association>
    <association javaType="CateVO" property="cateVO">
      <result column="c_cateno" property="cateno"/>
      <result column="c_categrpno" property="categrpno"/>
      <result column="c_name" property="name"/>
      <result column="c_seqno" property="seqno"/>
      <result column="c_visible" property="visible"/>  
      <result column="c_rdate" property="rdate"/>  
      <result column="c_cnt" property="cnt"/>  
    </association>
  </resultMap>
  
  <select id="read_categrp_cate" parameterType="int" resultMap="Categrp_Cate_VO_Map">
    SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno as r_seqno,
               r.visible as r_visible, r.rdate as r_date,
               c.cateno as c_cateno, c.categrpno as c_categrpno, c.name as c_name,
               c.seqno as c_seqno, c.visible as c_visible, c.rdate as c_rdate, c.cnt as c_cnt
    FROM categrp r, cate c
    WHERE r.categrpno = c.categrpno AND c.cateno=#{cateno}
    ORDER BY r.categrpno ASC, c.cateno ASC
  </select>  

3) 1) 1:다 Join, Map 이용
  <select id="list_categrp_cate_vo" resultMap="Categrp_Cate_VO_Map">
    SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno as r_seqno,
               r.visible as r_visible, r.rdate as r_date,
               c.cateno as c_cateno, c.categrpno as c_categrpno, c.name as c_name,
               c.seqno as c_seqno, c.visible as c_visible, c.rdate as c_rdate, c.cnt as c_cnt
    FROM categrp r, cate c
    WHERE r.categrpno = c.categrpno
    ORDER BY r.categrpno ASC, c.cateno ASC
  </select>    

4) 1:다 Join
  <resultMap type="Categrp_Cate_list" id="Categrp_Cate_list_Map">
    <result column="categrpno" property="categrpno"/>
    <result column="name" property="name"/>
    <result column="seqno" property="seqno"/>
    <result column="visible" property="visible"/>
    <result column="rdate" property="rdate"/>  
    <collection property="list" 
                    column="categrpno" javaType="java.util.ArrayList" 
                    select="list_categrp_cate_vo_collection_item"/>
  </resultMap> 

  <select id="list_categrp_cate_vo_collection" resultMap="Categrp_Cate_list_Map" parameterType="int">
    SELECT  categrpno, name, seqno, visible, rdate
    FROM categrp
    WHERE categrpno=#{categrpno}
  </select>  

  <select id="list_categrp_cate_vo_collection_item"  resultType="CateVO" parameterType="int">
    SELECT cateno, categrpno, name, seqno, visible, rdate, cnt
    FROM cate
    WHERE categrpno=#{categrpno}
  </select>  
~~~
