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

6) Getter, Setter : 
    EmployeeCont.java로  ModelAndView create() 생성해 @RequestMapping
    -> boot가 동작 -> view.jsp 실행

7) FrameWork : 기초 소스 뿐만이 아닌 개발 방법론을 제공해, 원하는 패턴으로 개발이 가능하다
    Library : 단순 활용가능한 도구들의 집합으로, 클래스에서 호출해 사용한다.
~~~

~~~
[01] MyBATIS framework 3.4.1 개론
EX) JSTL 오류 : https://mvnrepository.com/artifact/javax.servlet/jstl/1.2  -> 다운 : /WEB-INF/lib/다운받은 jar 넣기
--------------------------------------------------------------------------------------------------------
★★정리) JAVA + DBMS 연동 기술 흐름★★
 1) Mybatis
  - Spring -> MyBatis -> DBMS 접근위해 SQL 사용 -> DBMS 
  -★ 대용량 DBMS에 대응하는 SQL 튜닝을 할수 있음★

 2) JPA
 - Spring -> JPA -> DBMS 접근위해 SQL 사용(자동화) -> DBMS 
 - ★ SQL를 생성하는 메소드가 지정되어, 대규모 DBMS의 SQL 최적화를 구현하기 어려움★

[01] 고전적인 패턴
- JAVA와 SQL은 성질이 다른 목적을 가지고 있음에도 강하게 결합되어 개발과 변경이 어려움
- 개발자가 DBMS Open/Close를 모두 수동 작업하며 Close를 누락하면 불규칙하게 서버 다운 발생
- 개발자의 고도의 집중력이 필요
- SQL과 JAVA VO class의 연동 설정을 개발자가 모두 수동으로 해야

- 아래의 코드를 MyBATIS 동적 SQL로 처리 할 수 있음.
 try {
      con = dbopen.getConnection();

      sql = new StringBuffer();
      sql.append(" SELECT pdsno, categoryno, rname, email, title, content, passwd, cnt,");
      sql.append("            SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1,");
      sql.append("            thumb, size1, map, youtube, mp3, mp4, ip, visible");
      sql.append(" FROM pds4");
      sql.append(" ORDER BY pdsno DESC");

      pstmt = con.prepareStatement(sql.toString());
      rs = pstmt.executeQuery(); // SELECT

      while (rs.next() == true) {
        Pds4VO pds4VO = new Pds4VO();
        pds4VO.setPdsno(rs.getInt("pdsno")); // DBMS -> JAVA 객체
        pds4VO.setCategoryno(rs.getInt("categoryno"));
        pds4VO.setRname(rs.getString("rname"));
        pds4VO.setEmail(rs.getString("email"));
        pds4VO.setTitle(rs.getString("title"));
        pds4VO.setContent(rs.getString("content"));
        pds4VO.setPasswd(rs.getString("passwd"));
        pds4VO.setCnt(rs.getInt("cnt"));
        pds4VO.setRdate(rs.getString("rdate"));
        pds4VO.setWeb(rs.getString("web"));
        pds4VO.setFile1(rs.getString("file1"));
        pds4VO.setFstor1(rs.getString("fstor1"));
        pds4VO.setThumb(rs.getString("thumb"));
        pds4VO.setSize1(rs.getLong("size1"));
        pds4VO.setMap(rs.getString("map"));
        pds4VO.setYoutube(rs.getString("youtube"));
        pds4VO.setMp3(rs.getString("mp3"));
        pds4VO.setMp3(rs.getString("mp4"));
        pds4VO.setIp(rs.getString("ip"));
        pds4VO.setVisible(rs.getString("visible"));

        list.add(pds4VO);
      }

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }

--------------------------------------
[02] MyBATIS framework 3.4.1 개론 
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
 - 간략 : JAVA -> MyBatis -> JAVA 
                       SqlMap Configuration 
                                 ↓ 
                          SQL Map 파일 
                                 ↓ 
입력(JAVA)----> SQL Mapping 구문 ----> MyBATIS 실행 ----> 출력(JAVA)
Hashtable                   XML                      ↓                   Hashtable  
POJO                                                   DBMS                POJO(VO(DTO), ArrayList...) 
원시 타입                                            MySQL               원시 타입(int, double...)
                                                          MariaDB
                                                          Oracle
  
2. 다운 로드 및 설치(Spring을 사용하지 않는 경우, JSP Model 1 기반) 
    - iBATIS 2.0은 MyBATIS 2와 같음
    - iBATIS 3.0부터는 MyBATIS 3로 변경되고 Annotation 기반으로 문법이 일부 변경됨
    - 전자정부 프레임웍 및 대부분의 기업은 MyBATIS를 사용
 
3. Spring의 경우 다운로드가 필요 no. Maven 설정으로 자동 다운
   - http://mvnrepository.com
   -> 해당 Code는 XML 기반 코드, 사용 No
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
    
6.★★★★Project 개발 순서(Spring MVC 기준) ★★★★
   
1) 구현 기능 분석(업무 분석) 
2) DB 모델링(TABLE 생성) 
3) SQL 생성 및 테스트 
4) VO(DTO) 생성 
         | 
         |               MyBATIS/iBATIS 
         +---------------┐ 
         |       SQL을 MyBATIS XML로 변환.  
         |                         | 
         |       SQL XML Mapping File 생성 
         |                         | 
         |    Execute Class 생성 (Spring은 자동화)
         +<--------------┘ 
         | 
         | 
5) DAO Interface 생성
6) DAO Interface 구현(클래스를 만듬, DBMS 관련 기능, MyBATIS 사용시는 자동 생성됨)
7) Process Interface 생성(Business Logic, Manager/Service class)
8) Process Interface 구현
9) Spring Controller MVC Action class 생성 
10) Controller, Beans(Tool(Utility 날짜 처리등 각종 메소드), Paging, Download)
11) JSP 제작, Controller, Beans와 연동
12) 테스트
 ~~~~

* **0330 :[06] MyBATIS  사용**
 ~~~
[02] MyBATIS 사용

1. 일반적인 SQL 사용
- DBMS 컬럼이 null 허용을 하더라도 VO변수의 값이 null이면 {file1} 부분에서 1111 에러발생

2. 동적인 SQL 사용
 1) if문(if ~ else는 지원 안함) - MySQL
 2) WHER를 분리한 경우 - Oracle
 3) WHER를 분리한 경우 - MySQL
 
3. 정렬의 구현
4. IN 함수의 사용
5. 함수 호출
6. 등록된 PK를 리턴하는 스크립트
 1) Oracle에서 NVL(MAX(wno), 0) + 1을 사용하는 경우 
 2) Oracle sequence 받기
 3) MySQL에서 AUTO_INCREMENT를 사용하는 경우

6. JOIN, resultMap 이용
 1) resultMap이용
 2) 1:1 Join, Map 이용
 3) 1) 1:다 Join, Map 이용
 4) 1:다 Join
~~~

* **0330 : [07][Resort] Oracle 기반 리조트 application 제작, Oracle 데이터베이스 연결, hikari Connection pool 설정, MyBATIS 설정, Oracle Driver 설정(project: resort_v1sbm3a)**
~~~
[01] Spring Boot 프로젝트 생성
1. 'Spring Starter Project' 실행
2. 프로젝트명: resort_v1sbm3a, Package: dev.boot.resort_v1sbm3a
- v1: version 1.0, sb: Spring Boot, m3: Mybatis 3.0
3. 의존 library 추가
- Oracle Driver 절대 설치하지 말것, 버그로 인해 드라이버 인식 불규칙하게됨 ★★★★★
-> Spring Boot DevTools, Spring Web, MyBatis Framework, JDBC API

4. /src/main/resources/application.properties : 프로젝트에서 사용되는 오라클 계정 설정 + 포트설정 + DEVTOOLS 설정
server.port = 9091
# JSP View path
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

# DEVTOOLS (DevToolsProperties)
spring.devtools.livereload.enabled=true

# MariaDB
# spring.datasource.hikari.driver-class-name=com.mysql.cj.jdbc.Driver
# spring.datasource.hikari.jdbc-url: jdbc:mysql://localhost:3306/resort?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC
# spring.datasource.hikari.username=root
# spring.datasource.hikari.password=1234
# spring.datasource.hikari.connection-test-query=SELECT 1

# Oracle
spring.datasource.hikari.driver-class-name=oracle.jdbc.driver.OracleDriver
spring.datasource.hikari.jdbc-url: jdbc:oracle:thin:@localhost:1521:XE  
# @localhost 부분에 IP주소 입력으로 다른 컴퓨터의 오라클 연결.
spring.datasource.hikari.username=ai7
spring.datasource.hikari.password=1234

# All DBMS
spring.datasource.hikari.maximum-pool-size=10		# 동시 접속자
spring.datasource.hikari.minimum-idle=5			# 접속자 증가시 -> 많은 접속자 처리 -> but 속도 down
spring.datasource.hikari.connection-timeout=5000       # 연결 지연 5초 이상시 -> Error.

5. jsp 사용을위한 의존성 추가
 - implementation 'javax.servlet:jstl': JSTL 사용 선언
 - implementation 'org.apache.tomcat.embed:tomcat-embed-jasper': Tomcat JSP compile library 추가
 - implementation 'org.springframework.boot:spring-boot-starter-validation': 폼 값 검증

▷ build.gradle 편집
plugins {
    id 'org.springframework.boot' version '2.4.3'
    id 'io.spring.dependency-management' version '1.0.11.RELEASE'
    id 'java'
    id 'war'
}

group = 'dev.mvc'
version = '0.0.1-SNAPSHOT'
sourceCompatibility = '1.8'

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-jdbc'
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.mybatis.spring.boot:mybatis-spring-boot-starter:2.1.4'
    developmentOnly 'org.springframework.boot:spring-boot-devtools'
    runtimeOnly 'com.oracle.database.jdbc:ojdbc8'
    providedRuntime 'org.springframework.boot:spring-boot-starter-tomcat'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    
    implementation 'javax.servlet:jstl'  <- 추가
    implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'  <- 추가
    implementation 'org.springframework.boot:spring-boot-starter-validation'  <- 추가
}

test {
    useJUnitPlatform()
}

6. Component scan "dev.mvc.resort_sbv2" 패키지 설정
- Controller, DAO, Process class 등을 자동으로 인식할 패키지 선언.
▷ dev.boot.resort_v1sbm3a.ResortV1sbm3aApplication.java
package dev.mvc.resort_v1sbm3a;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"dev.mvc.resort_v1sbm3a"
public class ResortV1sbm3aApplication {

    public static void main(String[] args) {
        SpringApplication.run(ResortV1sbm3aApplication.class, args);
    }
}
 
7. 관련 폴더 생성
1) JSP views: /src/main/webapp/WEB-INF/views
2) JSP views: /src/main/webapp/WEB-INF/lib : .jar이 들어감
3) CSS: /src/main/resources/static/css
4) images: /src/main/resources/static/images
5) Javascript: /src/main/resources/static/js

[02] MyBatis 설정
1. /src/main/resources/mybatis 패키지 생성
2. MyBatis 설정
- @MapperScan(basePackages= {"dev.mvc.bbs"}): DAO interface 검색 패키지 설정
★★중요한점 : application.properties 끌어다 쓰고, classpath:/mybatis 필요★★
▷ /src/main/java/dev.mvc.resort_v1sbm3a.DatabaseConfiguration.java 설정
package dev.mvc.resort_v1sbm3a;
import javax.sql.DataSource;
import org.mybatis.spring.annotation.MapperScan;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@PropertySource("classpath:/application.properties")  // 설정 파일 위치
@MapperScan(basePackages= {""})
public class DatabaseConfiguration {
    
    @Autowired
    private ApplicationContext applicationContext;
    
    @Bean
    @ConfigurationProperties(prefix="spring.datasource.hikari")  // 설정 파일의 접두사 선언 spring.datasource.hikari....
    public HikariConfig hikariConfig() {
        return new HikariConfig();
    }
    
    @Bean
    public DataSource dataSource() throws Exception{
        DataSource dataSource = new HikariDataSource(hikariConfig());
        System.out.println(dataSource.toString());  // 정상적으로 연결 되었는지 해시코드로 확인
        return dataSource;
    }
    
    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception{
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource);
        // "/src/main/resources/mybatis" 폴더의 파일명이 "xml"로 끝나는 파일 매핑
        sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:/mybatis/**/*.xml"));
        
        return sqlSessionFactoryBean.getObject();
    }
    
    @Bean
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory){
        return new SqlSessionTemplate(sqlSessionFactory);
    }
}


[03] Oracle Driver 설정 및 테스트
1. Oracle Driver 설정
★★build.gradle에서 Oracle Driver 절대 설치하지 말것, 버그로 인해 드라이버 인식 불규칙하게됨 ★★★★★
JSP views: /src/main/webapp/WEB-INF/lib/ojdbc8.jar
- Oracle 18C XE 버전의 경우 SQL Developer가 설치된 폴더의 F:/ai7/sqldeveloper/jdbc/lib/ojdbc8.jar을 복사하여 사용 할 것.

2. MyBatis 설정 JUnit 테스트(/src/test/java 폴더에 테스트 기초 파일이 생성되어 있음 ★)
▷ /src/test/java/dev.mvc.resort_v1sbm3a.ResortV1sbm3aApplicationTests.java 설정
 -> /src/main/java가 아닌 -> /src/test/java
package dev.mvc.resort_v1sbm3a;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
@SpringBootTest
class ResortV1sbm3aApplicationTests {
  @Autowired
  private SqlSessionTemplate sqlSession;  // Send -> receive로 Oracle과 Spring 연결 확인
  
  @Test
  public void contextLoads() {
  }
  @Test
  public void testSqlSession() throws Exception{
    System.out.println(sqlSession.toString());
  }
}

3. 테스트 실행: /src/test/java/dev.mvc.resort_v1sbm3a.ResortV1sbm3aApplicationTests.java 파일 선택 --> Debug as --> JUnit test
4. 프로젝트 실행 테스트 : 프로젝트 선택 -> Run As -> Spring Boot App 실행
▷ /src/test/java/dev.mvc.resort_v1sbm3a.ResortV1sbm3aApplication.java

package dev.mvc.resort_v1sbm3a;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"dev.mvc.resort_v1sbm3a"})
public class ResortV1sbm3aApplication {

    public static void main(String[] args) {
        SpringApplication.run(ResortV1sbm3aApplication.class, args);
    }
}
5. Web 접속 테스트 :  http://localhost:9091
~~~