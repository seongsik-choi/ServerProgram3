# 3) 서버 프로그래밍3 (구현) : Spring Boot
## STS4(Spring Tool Suite4) Tree Structure  
  **C:/dic/WS_FRAME/start, basic,resort_v1sbm3a**    
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
1) /static/css/style.css  ->  /css/style.css
2) /static/images/finemae -> /images/puppy06.jpg
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
2. 프로젝트명: basic, / Package명: dev.boot.basic / Packaging : War / Language : JAVA
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
   - implementation 'javax.servlet:jstl': JSTL 사용 선언
   - implementation 'org.apache.tomcat.embed:tomcat-embed-jasper': Tomcat JSP compile library 추가
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

7. VO(DTO) 생성 : getter, Setterr로 private 멤버변수 접근 허용 클래스
▷ /src/main/java/dev.boot.basic/EmployeeVO.java

8. VO(DTO) test class 제작 : getter, setter 호출 예제
▷ /src/main/java/dev.boot.basic/EmployeeVOUse.java

9. Controller class 제작 : view.jsp로 넘기기 위한 함수 Controller(ModelAndView create())
▷ /src/main/java/dev.boot.basic/EmployeeCont.java 

  // Legacy 다르게 프로젝트명 사용 No, @RequestMapping에 명시한 대로 사용
  // 실행 주소 :  http://localhost:9091/employee/employee.do
  @RequestMapping(value="/employee/employee.do", method=RequestMethod.GET )
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
  
    EmployeeVO employeeVO  = new EmployeeVO();  // 객체 생성
    // sungjukVO.name = "주지훈"; // The field SungjukVO.name is not visible
    
    employeeVO.setName("주지훈");	// EmployeeVO.java의 setter 호출
    employeeVO.setTot(300);
    employeeVO.setAvg(100);
    
    mav.addObject("employeeVO", employeeVO); // == request.setAttritube("employeeVO", employeeVO);
    
    /* 
     /src/main/webapp/WEB-INF/views/employee/employee.jsp
    application.properties의
     spring.mvc.view.prefix=/WEB-INF/views/와
     mav.setViewName("/employee/employee"); 가 조합
     /WEB-INF/views/employee/employee의 경로완성
     */
    mav.setViewName("/employee/employee"); // view.jsp 호출
    
    return mav;
  }

10. JSP view 제작 : EL로 View 구현
▷ /src/main/webapp/WEB-INF/views/employee/employee.jsp
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
    Controller 중 JSP(/Webapp의 JSP)없이 단순 출력(ex.JSON 출력)

5) Spring Boot의 Static resource 경로 표현 : 이미지, css 등 리소스
    /static/css/style.css       ->  /css/style.css     
   /static/images/fname.jpg -> /images/fname.jpg

6) Getter, Setter : 
    EmployeeCont.java로  ModelAndView create() 생성해 @RequestMapping
    -> Spring Framework가 동작 -> view.jsp 실행

7) FrameWork : 기초 소스 뿐만이 아닌 개발 방법론을 제공해, 원하는 패턴으로 개발이 가능
    Library : 단순 활용가능한 도구들의 집합으로, 클래스에서 호출해 사용
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
~~~
1. 실행 아키텍쳐   
![image](https://user-images.githubusercontent.com/76051264/113471790-c7ec6e80-9499-11eb-8125-c182971c703a.png)  
~~~ 
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
~~~

6. Spring MVC 기반 Project 개발 순서  
![image](https://user-images.githubusercontent.com/76051264/113471877-49dc9780-949a-11eb-9ff5-ee199076a31c.png)  
---
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
1. Spring Boot 프로젝트 생성 
  * a. FILE -> NEW -> 'Spring Starter Project' 실행
  * b. 보이지 않는 경우 : Windows -> perspective -> open perspective -> other -> Spring  
2. 프로젝트명: resort_v1sbm3a, / Package: dev.mvc.resort_v1sbm3a
    * Service URL : https://start.spring.io 웹 상에서 프로젝트 기초 소스 생성  
    * Type : library 관리 툴, Gradle  
    * Packaging : 배포 형태, War  
    * Group : dev.boot  
    * Artifact : resort_v1sbm3a   
    * version : source version  
    * Package : project main source package  
    - v1: version 1.0, sb: Spring Boot, m3: Mybatis 3.0
3. 의존 library 추가 : Spring boot Version(2.4.3)  
    * Spring Boot Version : 2.4.3
    * Spring Boot DevTools, Spring Web, MyBatis Framework, JDBC API : 4가지 의존성 추가
    * [Finish] 버튼을 클릭 
    - Oracle Driver 절대 설치하지 말것, 버그로 인해 드라이버 인식 불규칙하게됨 ★★★★★

4. /src/main/resources/application.properties 
: 프로젝트에서 사용되는 오라클 계정 설정 + 포트설정 + DEVTOOLS 설정
-------------------------------------------------------------------------------------------
server.port = 9091
# JSP View path
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

# DEVTOOLS (DevToolsProperties)
spring.devtools.livereload.enabled=true

# MariaDB #개인 프로젝트 생성시 사용
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
-------------------------------------------------------------------------------------------

5. jsp 사용을위한 의존성 추가
 - implementation 'javax.servlet:jstl': JSTL 사용 선언
 - implementation 'org.apache.tomcat.embed:tomcat-embed-jasper': Tomcat JSP compile library 추가
 - implementation 'org.springframework.boot:spring-boot-starter-validation': 폼 값 검증
-------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------

6. Component scan "dev.mvc.resort_sbv2" 패키지 설정
- Controller, DAO, Process class 등을 자동으로 인식할 패키지 선언
★★ 프로젝트별 파일명 : 프로젝트명Application.java★★
▷ dev.boot.resort_v1sbm3a.ResortV1sbm3aApplication.java
-------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------

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
★★application.properties 끌어다 쓰고, classpath:/mybatis 필요★★

▷ /src/main/java/dev.mvc.resort_v1sbm3a.DatabaseConfiguration.java 설정
-------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------

[03] Oracle Driver 설정 및 테스트
1. Oracle JDBC Driver Download
   - https://www.oracle.com/kr/database/technologies/appdev/jdbc-downloads.html
   -> Oracle Database 18c (18.3) drivers -> ojdbc8.jar
   - 다운후 용량은 4,065 KB 이어야함.
★★build.gradle에서 Oracle Driver 절대 설치하지 말것, 버그로 인해 드라이버 인식 불규칙★★

- JSP views: /src/main/webapp/WEB-INF/lib/ojdbc8.jar
- Oracle 18C XE 버전의 경우 SQL Developer가 설치된 폴더의 F:/ai8/sqldeveloper/jdbc/lib/ojdbc8.jar을 복사하여 사용

2. MyBatis 설정 JUnit 테스트(/src/test/java 폴더에 테스트 기초 파일이 생성되어 있음 ★)
▷ /src/test/java/dev.mvc.resort_v1sbm3a.ResortV1sbm3aApplicationTests.java 설정
 -> /src/main/java가 아닌 -> /src/test/java
-------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------

3. 테스트 실행: /src/test/java/dev.mvc.resort_v1sbm3a.ResortV1sbm3aApplicationTests.java 파일 선택 
   -> build.gradle refresh 후
   -> Debug as -> JUnit test -> 성공시 HikariDataSource (HikariPool-1) 문구와 초록색 progress bar 보임

4. 프로젝트 실행 테스트 : 프로젝트 선택 -> Run As -> Spring Boot App 실행
▷ /src/main/java/dev.mvc.resort_v1sbm3a.ResortV1sbm3aApplication.java
-------------------------------------------------------------------------------------------
[실행 화면]
......
HikariDataSource (HikariPool-1)

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
-------------------------------------------------------------------------------------------

5. Web 접속 테스트 :  http://localhost:9091
 -> White Lable 출력시 성공
~~~

* **0330 : [08][Resort] CSS 제작**  
~~~
[01]  CSS 제작
1. CSS
- @CHARSET "UTF-8"; : CSS 인코딩 방식 지정
▷ /src/main/resources/static/css/style.css
첨부 파일 참고 : 상시 업데이트
~~~

* **0330: [09][Resort] index.do 페이지 제작 , 화면 상단, 하단 Menu 파일, index.jsp 제작**  
~~~
[01] 메뉴 구성
- http://localhost:9091
1. Controller
▷ dev.mvc.resort_v1sbm3a.HomeCont.java
-------------------------------------------------------------------------------------
package dev.mvc.resort_v1sbm3a;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeCont {
  public HomeCont() {
    System.out.println("--> HomeCont created.");
  }

  // http://localhost:9091
  @RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
  public ModelAndView home() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/index");  // /WEB-INF/views/index.jsp
    
    return mav;
  }
}
-------------------------------------------------------------------------------------

2. 화면 상단 메뉴
- 자주 사용되는 EL 값의 활용: <c:set var="root" value="${pageContext.request.contextPath}" />
						 ${root}
▷ /webapp/WEB-INF/views/menu/top.jsp
-------------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<DIV class='container_main'> 
  <%-- 화면 상단 메뉴 --%>
  <DIV class='top_img'>
    <DIV class='top_menu_label'>Resort 0.1 영화와 여행이있는 리조트</DIV>
    <NAV class='top_menu'>
      <span style='padding-left: 0.5%;'></span>
      <A class='menu_link'  href='/' >힐링 리조트</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/categrp/list.do'>카테고리 그룹</A><span class='top_menu_sep'> </span>    
            
    </NAV>
  </DIV>
  
  <%-- 내용 --%> 
  <DIV class='content'>


-------------------------------------------------------------------------------------

3. 화면 하단 메뉴
▷ /webapp/WEB-INF/views/menu/bottom.jsp
-------------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
 
  </DIV> <%-- content 내용 종료 --%>

  <%-- 화면 하단 메뉴 --%>
  <DIV class='copyright'>
    Copyright Spring Boot All rights reserved.
  </DIV>
  
</DIV> <%-- container_main 종료 --%>
   
------------------------------------------------------------------------------------- 

[02] index.jsp 시작 페이지
1. JSP
▷ /webapp/WEB-INF/views/index.jsp
-------------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
<!-- /static 기준 -->
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
</head>
<body>
<jsp:include page="./menu/top.jsp" flush='false' />
  
  <DIV style='width: 100%; margin: 30px auto; text-align: center;'>
    <IMG src='/images/resort01.jpg' style='width: 60%;'>
  </DIV>
  
  <DIV style='margin: 0px auto; width: 90%;'>
    <DIV style='float: left; width: 50%;'>
     </DIV>
     <DIV style='float: left; width: 50%;'>
    </DIV>  
  </DIV>
 
  <DIV style='width: 94.8%; margin: 0px auto;'>
  </DIV>  
 
<jsp:include page="./menu/bottom.jsp" flush='false' />
 
</body>
</html>
-------------------------------------------------------------------------------------
~~~

* **0330: [10][Resort] Amateras ERD/UML 설계툴, Resort 관리 시스템 제작 DBMS 모델링, Entity 산출, resort.erd 제작**  
▶ 프로젝트는 보통 3번까지 3개의 Table 이용★★
~~~
[01] ERD/UML 툴 설치  
1. STS(Eclipse) GEF plugin 설치
1) STS를 종료. 
2) http://www.eclipse.org/gef/downloads/index.php  
3) GEF4 Update Site ->'GEF3-Update-4.0.0.zip' 다운로드 
4) 'GEF3-Update-4.0.0.zip' 폴더에 압축을 해제
5) 'GEF3-Update-4.0.0' 폴더의 모든 내용을 '/sts-4.6.0' 폴더에 복사하여 덮어 씀
2015-08-18  오후 02:28    <DIR>          features
2015-08-18  오후 02:28    <DIR>          plugins
2015-07-09  오후 03:51             4,108 artifacts.jar
2015-07-09  오후 03:51            41,974 content.jar
2. Amateras UML 설치
   http://amateras.sourceforge.jp/cgi-bin/fswiki_en/wiki.cgi  
   -> Download -> AmaterasUML_1.3.4.zip 
   net.java.amateras.umleditor.java_1.3.4.jar 
   net.java.amateras.umleditor_1.3.4.jar 
   net.java.amateras.xstream_1.3.4.jar  
   위의 3개의 파일을 /sts-4.6.0/plugins 폴더에 복사
3. Amateras ERD 설치(Amateras UML을 먼저 설치해야) 
   http://amateras.sourceforge.jp/cgi-bin/fswiki_en/wiki.cgi  
   -> Download -> AmaterasERD 
   -> net.java.amateras.db_1.0.9.jar 다운로드 
   위의 1개의 파일을 /sts-4.6.0/plugins 폴더에 복사
4. STS를 다시 시작
5. 설치가 성공

[02] Amateras ERD 툴을 이용한 DBMS 모델링
1. 테이블 설계
① 업무 분석
② 테이블명 명사 도출
③ 테이블의 레코드를 고유하게 구분할 Primary Key 컬럼 산출
④ 테이블간 종속 관계 설정: 1 대 다
    종속: PK 컬럼(1) <---> 피 종속: FK 컬럼(*)
⑤ 일반 컬럼 추가
⑥ SQL 생성 및 테스트
  
2. 테이블 종류
   - 종류 1: 데이터를 나타내는 테이블  예) 상품
   - 종류 2: 데이터의 운영에의해서 발생하는 테이블 예) 쇼핑카트, 구입, 주문, 배송
   - 종류 3: 다른 시스템에서 상품을 가져오는 경우 예) 다음 쇼핑/네이버 쇼핑 --> Auction, 쿠팡

   1) categrp: 카테고리 그룹   2) category: 카테고리 그룹에 속한 카테고리
   3) contents: 블로그, 상품    4) reply    : 댓글, 상품평
   5) cart      : 쇼핑 카트   6) reservation: 예약
   7) resitem  : 예약 항목   8) point    : 포인트  
   9) member: 회원   10) admin  : 사원
   11) auth    : 권한(직책)   12) url      :접속 가능 주소 
   13) urlauth: 권한별 접근 URL   14) survey : 설문 조사
   15) surveyitem : 설문 조사 항목   16) surveyparti : 설문 참여
   17) log     : 로그   18) gallery: 갤러리   19) qna: 질문답변   

★★3. 그룹 : 그룹의 사용은 필연★★
★★EX) 소셜 미디어의 그룹사용★★
-> 전자기기(대분류) -> 노트북/PC(중분류) -> 노트북 -> LG 노트북(소분류) -> cpu, gpu...(내용)
3. 그룹의 사용: 영화
   1) 장르: genre
       - SF, 스릴러, 드라마, 유머, 가족...
   2) 장르에 속한 영화: movie
       - SF 속한 영화: 인터스텔라, AI
       - 드라마: 맘마미아, 월터의 상상은 현실이된다., 악마는 프라다를 입는다.

4. 그룹의 사용: 여행
   1) 여행 카테고리 그룹: tripcategrp
      - 국내, 해외, 화성...
   2) 여행 카테고리: tripcate
       - 국내에 속한 카테고리: 서울/인천, 경기도, 강원도, 충청북도, 충청남도...
   3) 여행 후기: trip
       - 강원도에 속한 여행: 카페산 카페, 대관령 삼양목장, 선돌관광지
      
★★5. 다양한 형태의 대응 구조★★
★★프로젝트는 보통 3번까지 3개의 Table 이용★★
1) 카테고리 그룹(categrp) : 영화, 여행, 이용후기, Q/A
2) 카테고리(cate) : 
 - 영화에 속한 장르 : SF, 스릴러, 드라마 등
 - 여행에 속한 구분 : 국내, 해외
 - 이용후기에 속한 구분 : 객실, 식당, 게임장, 마켓
3) 컨텐츠(contents) :
 - SF에 속한 여행 소개
 - 국내에 속한 여행지 안내
 - 식당에 속한 이용 후기

4) 첨부파일(attachfile) : 국내 여행지에 속한 첨부파일 200장
5) 댓글(reply) : 관광지에 속한 댓글
6) 회원(member) : 글을 쓸 수있는 권한
7) 관리자(admin) : 문제 컨텐츠의 관리

[03] Amateras ERD 툴을 이용한 DBMS 모델링
3. 테이블 생성
- Oracle JDBC Driver Download
   - https://www.oracle.com/kr/database/technologies/appdev/jdbc-downloads.html
     -> Oracle Database 18c (18.3) drivers -> ojdbc8.jar
   - 다운후 용량은 4,065 KB 이어야함.

1) '/WEB-INF/doc/카테고리그룹' 폴더를 생성한 후 선택하고 새로운 파일을 생성.
2) 데이터베이스 선택
   - File name: .    / - SQL Dialect: Oracle 선택  + MairaDB의 경우 MYSQL 선택!!!!
3) Oracle JDBC Driver Download
   - https://www.oracle.com/kr/database/technologies/appdev/jdbc-downloads.html
     -> Oracle Database 18c (18.3) drivers -> ojdbc8.jar
4) ERD 정보 입력
    - JAR File : ai8에 ojdbc8.jar로 설정 
      + /src/main/webapp/WEB-INF/lib에도 ojdbc8.jar Overwrite
    - JDBC Driver: oracle.jdbc.driver.OracleDriver
    - Oracle 설정(Database url): jdbc:oracle:thin:@localhost:1521:XE 

    + MairaDB의 경우 :  - MariaDB(MySQL)
      JDBC Driver: oracle.jdbc.driver.OracleDriver
      Oracle 설정(Database url): jdbc:mysql://localhost:3306/db이름

5) 테이블 생성
6) 논리적 모델링 : 실제 생성되는 테이블명이 아니라 저장되는 내용을 참고하여
                            이름 지정, 데이터베이스 결정되지 않아도 상관 없음.
    물리적 테이블: 실제 물리적으로 DBMS 디스크상에 생성해야할 테이블명
                           DBMS결정되어있어야함.
   - categrp 카테고리 그룹 테이블 생성
   - cate 테이블 생성
   - contents 테이블생성
   - member 테이블생성
     . 논리적 테이블 이름: 회원
     . 물리적 테이블 이름: member

4. 테이블이 추가된 형태(Ctrl+D: 논리적/물리적 view 전환)
  - 논리적 모델링 - 물리적 모델링
~~~
---

* **0331 : [11][Categrp] Categrp DBMS 설계, 논리적 모델링, 물리적 모델링, PK, FK 관계(Relationship) 설정**   
~~~
[01]  DBMS 설계, SQL

1. 컬럼명 설계의 규칙 결정
① ★★기본적인 컬럼명 명시(해당 방법 사용)★★
    - 간결해서 개발자에게 편리함을 제공
    - 일부 컬럼들이 Join시에 컬럼명 충돌이 발생할 수 있음으로
       as등의 키워드를 이용하여 컬럼명을 새로 지정함
   CREATE TABLE categrp(
       categrpno       NUMBER(7)       NOT NULL    PRIMARY KEY,
       name             VARCHAR2(50)  NOT NULL,
       seqno             NUMBER(7)       DEFAULT 0     NOT NULL
   );

② 테이블명을 결합한 컬럼명 명시 : 복잡, 충돌은 No
   - 고유한 테이블명이 결합됨으로 Join 시에 충돌이 발생하지 않음
   - 개발자가 코딩시에 코딩량이 많이 증가
   CREATE TABLE categrp(
       categrpno       NUMBER(7)       NOT NULL    PRIMARY KEY,
       cagegrpname   VARCHAR2(50)  NOT NULL,
       categrpseqno   NUMBER(7)       DEFAULT 0     NOT NULL
   );
 
③ 테이블명 + '_'를 결합한 컬럼명 명시
   - 고유한 테이블명이 결합됨으로 Join 시에 충돌이 발생하지 않슴
   - 개발자가 코딩시에 코딩량이 많이 증가.
   CREATE TABLE categrp(
       categrp_no       NUMBER(7)       NOT NULL    PRIMARY KEY,
       cagegrp_name   VARCHAR2(50)  NOT NULL,
       categrp_seqno   NUMBER(7)       DEFAULT 0     NOT NULL
   );
  
2. PK(Primary Key) 설계 
- PK 컬럼명은 프로젝트 전체에서 고유하게 해야함, 중복되면 join시 문제 발생
- 숫자일경우: 테이블명 + no  /문자일경우: 테이블명 + id

1) 카테고리 그룹 테이블 PK 추가 : 
 - 더블클릭(column -> add Coluumn)
 - 논리 컬럼명 : 카테고리 그룹 번호 / 물리 컬럼명, catefrpno / type : number/ pk, not nulll check
2) 카테고리 테이블 PK 추가  3) 컨텐츠 테이블 PK 추가  4) 회원 테이블 PK 추가
3. PK 적용된 ERD 형태
   -> 카테고리그룹(table) 
  1) 논리적 모델링 : 카테고리 그룹 번호(Numeric(10))
  2) 물리적 모델링 :  categrpno(Number(10))

4. FK 설계 : 다른 테이블의 PK를 지정
   FK가 존재하지 않는 경우 무조건 에러 발생, INSERT 불가.★★
- 관계형 데이터베이스(RDBMS)는 테이블간에 종속(부모/자식, 그룹/구성원) 관계가 FK로 선언됨
- Foreign Key(FK): 현재 레코드가 어느 그룹에 속하는지의 정보를 나타냄
- INSERT SQL 실행시 다른 테이블의 PK 값이 있어야함.
- 정상적인 관계(relationship) 설정이되어야 JAVA등의 application으로 구현이 원활
1) 논리적 모델링 : 우리가 알아보는 이름(한글) + Numeric
2) 물리적 모델링 : DMBS에 저장되는 이름(영어) + Number
~~~
![image](https://user-images.githubusercontent.com/76051264/113097565-113a8500-9232-11eb-85a7-2b2421731abd.png) 

* **0331 : [12][Categrp] Categrp 테이블 논리적 모델링, 물리적 모델링**   
~~~
[01] categrp 테이블 논리적/물리적 모델링
1. 카테고리 그룹 : Column 추가해주기
DROP TABLE categrp;
 
CREATE TABLE categrp(
    categrpno         NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                VARCHAR(50)    NOT NULL,			     -- 한글(/3)도 16도정도
    seqno               NUMBER(7)       DEFAULT 0     NOT NULL,
    visible               CHAR(1)           DEFAULT 'Y'     NOT NULL,
    rdate                 DATE              NOT NULL
);
 
COMMENT ON TABLE categrp is '카테고리 그룹';
COMMENT ON COLUMN categrp.categrpno is '카테고리 그룹 번호';
COMMENT ON COLUMN categrp.name is '이름';
COMMENT ON COLUMN categrp.seqno is '출력 순서';
COMMENT ON COLUMN categrp.visible is '출력 모드';
COMMENT ON COLUMN categrp.rdate is '그룹 생성일';
 
 - 논리적/물리적 모델링 결과 확인
  
2. SQL 생성
 1) '우마' -> Export -> DDL
  + UTF-8 Encoding 설정 필수
 2) ALTER TABLE을 이용한 제약 조건의 선언(no)
 3) 테이블 구조 생성시 제약 조건 선언  : Generates constraints as ALTER TABLE 체크 해제
 4) resort.ddl -> categrp_c.sql로 변경
 5) 파일 열기 : Open with -> Text Editor.

-> sqldeveloper -> 도구 -> 'environment -> 인코딩(UFT-8로) : 안하면 한글깨짐
-> sqldeveloper ->  파일 -> 열기 -> categrp_c.sql 파일 열기

-> SQL developer에서 테이블 만들어주기
-> categrp_c.sql에서 Create TABLE ~ COMMENT 마지막 부분까지 블록 지정해 -> 명령문 실행
-> 옆에 ai8 -> 테이블 열면 CATEGRP 있음

-> Sequence 함수 작성해주기(COMMENT 밑에 추가해주고, 명령문 실행)
DROP SEQUENCE categrp_seq;		

CREATE SEQUENCE categrp_seq
  START WITH 1           -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                  -- 2번은 메모리에서만 계산
  NOCYCLE;                 -- 다시 1부터 생성되는 것을 방지

-> Oracle 실습은 여기서 끝.
~~~
![image](https://user-images.githubusercontent.com/76051264/113117184-2a9afb80-9249-11eb-9ce7-0cba5d13e88b.png)  
---
![image](https://user-images.githubusercontent.com/76051264/113117263-3ab2db00-9249-11eb-8e1d-b9e38e45172d.png)  
---
* **0331 : mariaDB 설치 : DB/SQL 응용 페이지 -> DB/SQL2 README.md 참고**  
* **0331 : [MariaDB 01] MariaDB 10.3.27 다운로드 및 설정, 계정 생성, resort DB 생성**  
---

* **0401 : [13][Categrp] Categrp Categrp SQL 제작, categrp.sql, Categrp VO(DTO)**  
~~~
++ sql 한글 깨짐시 : EditPlus로 열어서 복붙
[01] SQL 제작
- 테이블 구조 생성후 최소 3건의 등록된 레코드, SQL Developer를 이용한 SQL 작업 진행

1. 카테고리 그룹
 ▷ /WEB-INF/doc/dbms/categrp_c.sql(ddl)
  -> sequence까지 추가된 테이블 형태(0331 부분 그대로) + 그 밑 테이블 생성 구문은 지우기.
 ▷ TABLE 명 : categrp / Column 5가지, PK(categrpno) / Sequence명 : categrp_seq

 ▷★★SQL의 기본 구현 6가지 : CRUD + List + Count★★
 --1) Create, 등록 : CREATE + INSERT
  INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
  VALUES(categrp_seq.nextval, '영화', 1, 'Y', sysdate);

 --2) List, 목록 : 여러 건의 레코드를 읽는 것
  SELECT categrpno, name, seqno, visible, rdate FROM categrp
  ORDER BY categrpno ASC;

 --3) Read, 조회 : 한 건의 레코드를 읽는 것
  SELECT categrpno, name, seqno, visible, rdate FROM categrp
  WHERE categrpno = 1;

 --4) Update, 수정 : PK는 update 불가능
 --UPDATE 테이블명 SET에 바꿀 조건, WHERE에 PK조건을 명시
  UPDATE categrp SET name='영화에서영화2로', seqno=5, visible='N'
  WHERE categrpno=1;

 -- 복구
  UPDATE categrp SET name='영화', seqno=1, visible='Y'
  WHERE categrpno=1;

 --5) Delete, 삭제
  DELETE FROM categrp WHERE categrpno=3;

 -- 복구 : categrpno는 3이 아닌 4 or 5 그 이상 nuum으로 : PK는 재생성 NO
  INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
  VALUES(categrp_seq.nextval, '음악', 3, 'Y', sysdate);

 --6) Count(갯수) : 그룹화 함수이자 Column명
 -- 컬럼에 null이 있는경우 갯수 산정에 제외됨.
  SELECT count(*) FROM categrp;

  -- count(*) 보완 : AS는 컬럼별명을 지정.
  SELECT COUNT(*) AS cnt FROM categrp;

 + commit;  // DB로 전송
 
[02] VO, MyBATIS 설정
1. VO
▷ dev.mvc.categrp 패지지 생성후 -> CategrpVO.java  : 컬럼 값들 기반 Getter Setter 생성 

3. MyBATIS DAO package 폴더 등록
▷ DatabaseConfiguration.java로 이동해 VO가 저장된 dev.mvc.categrp 패키지 등록.
 @MapperScan(basePackages= {"dev.mvc.resort_v1sbm3a", "dev.mvc.categrp"})  <-- "dev.mvc.categrp" 추가
~~~
---

* **0401 :[15][Categrp] Categrp 등록 기능 제작(INSERT~)**  
  * [01] Categrp 등록 기능 제작(INSERT~ )  
![image](https://user-images.githubusercontent.com/76051264/113473874-3f74ca80-94a7-11eb-9401-403f972faaa6.png)  
~~~
★★★Create, 등록 : CREATE + INSERT★★★
 1. SQL
▷ /webapp/WEB-INF/doc/dbms/categrp_c.sql
 -> 테이블 추가 후 commit;으로 DB로 값 전달
▷ /webapp/WEB-INF/doc/dbms/categrp_c.sql
-----------------------------------------------------------------------------------
1) INSERT
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '영화', 1, 'Y', sysdate);
 
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '여행', 2, 'Y', sysdate);
 
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '캠핑', 3, 'Y', sysdate);

commit; 
-----------------------------------------------------------------------------------

 2. MyBATIS
 1) MyBATIS가 지원하는 자동화 기능
 - 데이터베이스 연결/해제 자동 지원
 - JDBC 사용시 꼭 필요한 try ~ catch ~ 문 자동 지원
 - java.sql.PreparedStatement 객체 자동 생성
 - ?에 해당하는 컬럼의 값 자동 대입
 - executeUpdate() 자동 실행
▷ /src/main/resources/mybatis/categrp.xml 
-----------------------------------------------------------------------------------
<?xml version="1.0" encoding="UTF-8"?>
 
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
 
<!-- dev.mvc.categrp.CategrpDAOInter 패키지에 등록된 interface 명시,
      패키지명과 인터페이스명은 실제로 존재해야함,
      Spring이 내부적으로 자동으로 interface를 구현해줌. -->
<mapper namespace="dev.mvc.categrp.CategrpDAOInter"> 
  <!-- 
  insert: INSERT SQL 실행
  id: Spring에서 호출시 사용
  parameterType: 전달받는 데이터 객체
  return: 등록한 레코드 갯수 리턴
  SQL선언시 ';'은 삭제
  #{}: 컬럼의 값
  #{name}: public String getName(){...
  -->
  <insert id="create" parameterType="dev.mvc.categrp.CategrpVO">
    INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
    VALUES(categrp_seq.nextval, #{name}, #{seqno}, #{visible}, sysdate)
  </insert>
 
</mapper> 
-----------------------------------------------------------------------------------

 3. DAO interface 
 - DAO : data Access Object, DMBS 실행 객체
 - Spring은 MyBATIS에 선언된 <insert id="create" parameterType="CategrpVO"> 태그를
  참조하여 자동으로 DAO class 생성
 - 자동으로 생성된 DAO class는 MyBATIS를 호출하는 역할
 -> DB(Mybatis) 연결을 Spring에서 담당.
▷ dev.mvc.categrp.CategrpDAOInter.java 
-----------------------------------------------------------------------------------
package dev.mvc.categrp;
 
// MyBATIS의 <mapper namespace="dev.mvc.categrp.CategrpDAOInter">에 선언
// 스프링이 자동으로 구현
public interface CategrpDAOInter {
  /**
   * 등록
   * @param categrpVO
   * @return 등록된 레코드 갯수
   */

   // Method 이름 create -> categrp.xml과 mapping
   // XMl의 ID = DAD의 Method,    parameterType 값 = Method의 Types
   // <insert id="create" parameterType="dev.mvc.categrp.CategrpVO">
  public int create(CategrpVO categrpVO);
 
}
-----------------------------------------------------------------------------------

 4. Process interface
 - Process(Manager, Service) : DBMS 접속이 아닌 알고리즘 및 제어문 선언
 - 신규로 추가도 되지만 DAO Interface의 많은 메소드가 Process Interface에서 재사용
-------------------------------------------------------------------------------------
package dev.mvc.categrp;
 
public interface CategrpProcInter {
  /**
   * 등록
   * @param categrpVO
   * @return 등록된 레코드 갯수
   */
  public int create(CategrpVO categrpVO);
 
}
-------------------------------------------------------------------------------------

5. Process class
- @Component("dev.mvc.categrp.CategrpProc"): 자동으로 객체 생성이 필요한 Class에만 선언 가능 

1) DI(Dependency Injection: 의존 주입)의 구현
     - IoC(Inversion of Control, 제어의 역전): 개발자가 객체를 생성하는 것이 아니라,
       개발자가 객체를 사용하는 순간, Spring 콘트롤러가 객체를 생성하여 개발자에게 제공.
     - 필요한 객체를 개발자는 선언만하고 객체 생성은 Framework이 하도록하는 기법.

2) 스프링이 빈을 자동으로 생성 선언
   @Component("dev.mvc.categrp.CategrpProc")
   public class CategrpProc implements CategrpProcInter {

▷ dev.mvc.categrp.CategrpProc.java
-------------------------------------------------------------------------------------
package dev.mvc.categrp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

// Controller에서 AutoWired 기능에 의해 호출될때 사용되는 이름
@Component("dev.mvc.categrp.CategrpProc")   

public class CategrpProc implements CategrpProcInter {
  @Autowired  //  DI, Spring framework가 자동 구현한 DAO class 객체를 할당.
  private CategrpDAOInter categrpDAO;
  // private CategrpDAOInter categrpDAO = new categrpDAO();
  // interface는 객체 생성할 수 없기에 인터페이스 = new 구현클래스()
  
  @Override
  public int create(CategrpVO categrpVO) {
    int cnt = categrpDAO.create(categrpVO);
    return cnt;  // 등록한 레코드 갯수 리턴
  }

}
-------------------------------------------------------------------------------------

6. Controller class
- 실행 주소의 조합
  http://localhost:9090/blog/categrp/create.jsp 
  → http://localhost:9090/blog/categrp/create.do

-> ★호출 규칙★
 Controller -> Proc -> DAO(자동화) -> MyBatis -> SQL

-> 실행 디렉토리 설정 : Application.java
@ComponentScan(basePackages = {"dev.mvc"})  // 전체 디렉토리로 지정

▷ dev.mvc.categrp.CategrpCont.java
-------------------------------------------------------------------------------------
package dev.mvc.categrp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

@Controller
public class CategrpCont {
 @Autowired // CategrpProcInter 인터페이스를 구현한 CategrpProc.java가 할당
 @Qualifier("dev.mvc.categrp.CategrpProc") // proc에게 전송
 private CategrpProcInter categrpProc; 
 
 public CategrpCont() {
   System.out.println(" -> CategrpCont created.");
 }
 
}
~~~

**0402 : [15][Categrp] Categrp 등록 기능 제작(INSERT~) Controller class 이어서**  
~~~
6. Controller class
▷ dev.mvc.categrp.CategrpCont.java
-------------------------------------------------------------------------------------
// http://localhost:9090/categrp/create.do
  /**
   * 등록 폼
   * @return
   */
  @RequestMapping(value="/categrp/create.do", method=RequestMethod.GET )
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/categrp/create"); // webapp/WEB-INF/views/categrp/create.jsp
    
    return mav; // forward
  }
  
  // http://localhost:9090/categrp/create.do
  /**
   * 등록 처리
   * @param categrpVO
   * @return
   */
  @RequestMapping(value="/categrp/create.do", method=RequestMethod.POST )
  public ModelAndView create(CategrpVO categrpVO) {  // categrpVO 자동생성 Form - VO 클래스로 자동저장
    // CategrpVO categrpVO <FORM> 태그의 값으로 자동 생성됨.
    // request.setAttribute("categrpVO", categrpVO); 자동 실행
    
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.categrpProc.create(categrpVO); // 등록 처리(인터페이스 호출, 클래스를 할당받았었음)
    mav.addObject("cnt", cnt); // request에 저장, request.setAttribute("cnt", cnt)
    
    mav.setViewName("/categrp/create_msg"); // /webapp/WEB-INF/views/categrp/create_msg.jsp

    return mav; // forward
  }
}
-------------------------------------------------------------------------------------

7. View: JSP
1) 등록 화면
▷ /webapp/WEB-INF/views/categrp/create.jsp
-----------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
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
 
<DIV class='title_line'>카테고리 그룹  > 등록</DIV>
 
<FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
  <div class="form-group">
     <label class="control-label col-md-3">카테고리 그룹 이름</label>
     <div class="col-md-9">
       <input type='text' name='name' value='' required="required" 
                  autofocus="autofocus" class="form-control" style='width: 50%;'>
     </div>
  </div>
  <div class="form-group">
     <label class="control-label col-md-3">출력 순서</label>
     <div class="col-md-9">
       <input type='number' name='seqno' value='1' required="required" 
                 placeholder="${seqno }" min="1" max="1000" step="1" 
                 style='width: 30%;' class="form-control" >
     </div>
  </div>  
  <div class="form-group">
     <label class="control-label col-md-3">출력 형식</label>
     <div class="col-md-9">
        <select name='visible' class="form-control" style='width: 20%;'>
          <option value='Y' selected="selected">Y</option>
          <option value='N'>N</option>
        </select>
     </div>
  </div>   

  <div class="content_bottom_menu" style="padding-right: 20%;">
    <button type="submit" class="btn">등록</button>
    <button type="button" onclick="location.href='./list.do'" class="btn">목록</button>
  </div>

</FORM>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
-----------------------------------------------------------------------------------

 
2) 등록 처리 메시지 화면
▷ /webapp/WEB-INF/views/categrp/create_msg.jsp 
http://localhost:9091/categrp/create.do
-----------------------------------------------------------------------------------
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='title_line'>카테고리 그룹 > 알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${cnt == 1}">
          <LI class='li_none'>
            <span class="span_success">새로운 카테고리 그룹 [${categrpVO.name }]을 등록했습니다.</span>
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">새로운 카테고리 그룹 [${categrpVO.name }] 등록에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <button type='button' onclick="location.href='./list.do'">새로운 카테고리 그룹 등록</button>
        <button type='button' onclick="location.href='./list.do'">목록</button>
      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>
-----------------------------------------------------------------------------------

-> 실행 주소
http://localhost:9091/categrp/create.do
~~~

---
* **0405 : [14] JSTL(JSP Standard TAG Library)의 사용, ★ include JSP간 jstl 중복 선언시 에러 발생할수도** 
~~~
[01] JSTL(JSP Standard TAG Library)의 사용
1. 변수지원 태그 
2. if 흐름제어 태그의 사용 
3. choose Tag 
4. forEach 태그 
5. enum 열거형을 이용한 코드의 처리(ArrayList<Pay>)
~~~

* **0405~6 : [16][Categrp] Categrp 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), Bootstrap 적용, 등록 기능의 결합**  
~~~
★★★ List, 목록 : 여러 건의 레코드를 읽는 것★★★
create.do에서 3개의 테이블 추가(영화, 음악, 드라마)
★List는 interface(객체 생성 불가) -> ArrayList로 구현★
 ★레코드 갯수 만큼 CategrpVO 객체를 만들어 ArrayList에 저장하여 리턴★
 ★구현된 Type(ArrayList)은 Interfac Tpye(List)으로 변경★
★Sping Controller GET -> Process Interface -> Process class -> DAO interface -> DAO class
-> MyBATIS -> SQL -> DBMS★

1. SQL
▷ /webapp/WEB-INF/doc/dbms/categrp_c.sql
-- 출력 순서에따른 전체 목록(우선 참고만)
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY seqno ASC;
CATEGRPNO NAME SEQNO VISIBLE RDATE

2. MyBATIS
★★중요★ : 인터페이스 구현하는 방법 ★★
★ Interface는 객체 생성 불가, 구현하여 객체를 전단받은 경우 객체는 inferfactype이 됨 ★
★ 구현된 Type(ArrayList)은 Interfac Tpye(List)으로 변경 ★
★ JAVA Collection Framework 개념 ★
- Interface를 구현하는 class는 사용방법이 동일
    - 동일한 추상 메소드용 구현했기 때문 
- Interface를 여러개의 클래스가 구현하는 이유?
   - 목표로하는 기능은 같은데 데이터의 특징등이 다른경우
 예) ArrayList는 동시 접근에 대한 처리를 하지 않으면서 객체 저장 가능, 속도 빠름, Web에서 사용
      Vector는 Socket을 이용한 네트워크등에서의 동시 접속시,
      충돌을 방지하는 기능과 함께 객체 저장 가능, 속도 느림

★ 인터페이스 개념 연습(project와는 무관)
▷ /src/test/java/TestCategrpDAO.java 
-----------------------------------------------------------------------------------
public class TestCategrpDAO {
  public static void main(String[] args) {
    
    // 인터페이스 구현하는 방법
    // List<CategrpVO> list = new List<CategrpVo>(); // 객체 생성 불가능
    List<CategrpVO> list = new ArrayList<CategrpVO>(); // 객체 생성 가능
    
    // 객체 생성후 초기화까지만.
    CategrpVO categrpvo = null;
    
    // 객체 생성후 List에 추가하기
    categrpvo = new CategrpVO(1, "Spring", 1, "Y", "2021-04-06");
    list.add(categrpvo); 
    System.out.println(categrpvo.hashCode()); //1829164700
    
    // 이미 만들어진 객체에 두번째 List 추가.
    // 메모리에 categrpvo 객체가 덮어씌어지는게 아닌, 각기 다른 메모리 영역에 list 값 할당
    categrpvo = new CategrpVO(2, "Summer", 2, "N", "2021-04-07");
    list.add(categrpvo); 
    System.out.println(categrpvo.hashCode()); //2018699554
    System.out.println(list.size()); // 2

    // 값을 가져오기
    // VO클래스에서 toString() 선언, 호출만으로 출력가능.
    for(int i=0; i<list.size(); i++) {
      categrpvo = list.get(i); 
      System.out.println(categrpvo.toString());
    }// for end

     // 다른 유형의 for문 
    for(CategrpVO categrpvo2: list) {
      System.out.println(categrpvo2.toString());
    }// for end
  }
}
-----------------------------------------------------------------------------------

▷ /src/main/resources/categrp.xml 
-> categrp_c.sql의 List, 목록 : 여러 건의 레코드를 읽는 것 부분
1) SELECT 사용 시 LIST(결과 레코드 여러개)인 경우 DAO와 Proc에서 ArrayList Return
2) SELECT 사용 시 READ(결과 레코드 한개)인 경우 DAO와 Proc에서 VO가 Return
-----------------------------------------------------------------------------------
 <!-- 
  레코드 갯수 만큼 CategrpVO 객체를 만들어 ArrayList에 저장하여 리턴,
  List<CategrpVO> list = new ArrayList<CategrpVO>(); 
  LIST(결과 레코드가 여러개)이기 때문에 ArrayList가 return
  -->
 <select id="list_categrpno_asc" resultType="dev.mvc.categrp.CategrpVO">
    SELECT  categrpno, name, seqno, visible, rdate
    FROM categrp
    ORDER BY categrpno ASC
  </select>
-----------------------------------------------------------------------------------

3. DAO interface
- list_categrpno_asc 메소드 = mybatis의 xml id와 mapping
- List인 이유는 categrp.xml의 대응되는 구문이 SELECT이고, generic type은 VO class
▷ CategrpDAOInter.java 
-----------------------------------------------------------------------------------
  /**
   * 출력 순서별 목록
   * @return
   */
  // List(결과가 여러개)인 이유는 categrp.xml의 대응되는 구문이 SELECT이고, generic type은 VO class
  // 1) SELECT 사용 시 LIST(결과 레코드 여러개)인 경우 ArrayList Return
  public List<CategrpVO> list_categrpno_asc();
-----------------------------------------------------------------------------------
 
4. Process interface
▷ CategrpProcInter.java
-------------------------------------------------------------------------------------
  /**
   * 출력 순서별 목록
   * @return
   */
  public List<CategrpVO> list_categrpno_asc();
-------------------------------------------------------------------------------------
 
5. Process class
- @Component("dev.mvc.categrp.CategrpProc"): 자동으로 객체 생성이 필요한 Class에만 선언 가능 
▷ CategrpProc.java
-------------------------------------------------------------------------------------
  @Override
  public List<CategrpVO> list_categrpno_asc() {
    List<CategrpVO> list = null;
    list = this.categrpDAO.list_categrpno_asc();
    return list;
  }
------------------------------------------------------------------------------------
 
6. Controller class
▷ CategrpCont.java
-----------------------------------------------------------------------------------
  // http://localhost:9090/resort/categrp/list.do
  @RequestMapping(value="/categrp/list.do", method=RequestMethod.GET )
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    
    List<CategrpVO> list = this.categrpProc.list_categrpno_asc();
    mav.addObject("list", list); // request.setAttribute("list", list);

    mav.setViewName("/categrp/list"); // /webapp/categrp/list.jsp
    return mav;
  }
-----------------------------------------------------------------------------------

7. View: JSP, 등록과 목록의 결합
- <TABLE><TH><TD>는 Bootstrap에 기본 속성이 설정되어 있음
▷ /webapp/categrp/list.jsp 
★★★★★★ 홈페이지 소스에 추가 : content_body 부분
-----------------------------------------------------------------------------------
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
    
<script type="text/javascript">
 
</script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>카테고리 그룹</DIV>

<DIV class='content_body'>
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>

      <label>그룹 이름</label>
      <input type='text' name='name' value='' required="required" style='width: 25%;'
                 autofocus="autofocus">
  
      <label>순서</label>
      <input type='number' name='seqno' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label>형식</label>
      <select name='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
       
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
      </FORM>
  </DIV>
   
  <TABLE class='table table-striped'>
    <colgroup>
    <col style='width: 10%;'/>  <!-- /는 close 태그 == body 없이 태그의 속성만 사용 -->
    <col style='width: 40%;'/>
    <col style='width: 20%;'/>
    <col style='width: 10%;'/>    
    <col style='width: 20%;'/>
  </colgroup>
  
  <thead>  
  <TR>
    <TH class="th_bs">순서</TH>
    <TH class="th_bs">대분류명</TH>
    <TH class="th_bs">등록일</TH>
    <TH class="th_bs">출력</TH>
    <TH class="th_bs">기타</TH>
  </TR>
  </thead>
  
  <tbody>
  <c:forEach var="categrpVO" items="${list}">
    <c:set var="categrpno" value="${categrpVO.categrpno }" />
    <TR>
      <TD class="td_bs">${categrpVO.seqno }</TD>
      <TD class="td_bs_left">${categrpVO.name }</TD>
      <TD class="td_bs">${categrpVO.rdate.substring(0, 10) }</TD> <!-- subString으로 년, 월일만 잘라내기  -->
      <TD class="td_bs">${categrpVO.visible}</TD>   
      
      <TD class="td_bs">
        <A href="./read_update.do?categrpno=${categrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
        <A href="./read_delete.do?categrpno=${categrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        <A href="./update_seqno_up.do?categrpno=${categrpno }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
        <A href="./update_seqno_down.do?categrpno=${categrpno }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
      </TD>   
    </TR>   
  </c:forEach> 
  </tbody>
   
  </TABLE>

</DIV><!-- content body end -->

<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
-----------------------------------------------------------------------------------

-> top.jsp의 Content class를 수정해 main 부분 가로를 줄이기.
-> style.css 수정.
  .content{
    width: 90%;
    margin: 10px auto; /*위아래 10px 떨어지고, 센터 정렬 */
  }
  
  .content_body {
    width: 90%;
    margin: 10px auto;
  }
  
  .content_bottom {
    width: 90%;
    margin: 10px auto; 
  }

/* 화면 내용 하단 메뉴 우측 배치 */
  .content_body_bottom {
    clear: both;
    padding-top: 20px;
    padding-right: 20px;
    padding-bottom: 20px;
    text-align: right;
    width: 100%;
    background-color: white;
  }

-----------------------------------------------------------------------------------
-> create.jsp 수정(content_body 추가)

<DIV class='content_body'>
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
    <div class="form-group">
       <label class="control-label col-md-4">카테고리 그룹 이름</label>
       <div class="col-md-8">
         <input type='text' name='name' value='' required="required" 
                    placeholder="이름을 입력하세요." 
                    autofocus="autofocus" class="form-control" style='width: 50%;'>
       </div>
    </div>
    
    <div class="form-group">
       <label class="control-label col-md-4">출력 순서</label>
       <div class="col-md-8">
         <input type='number' name='seqno' required="required" 
                   placeholder="출력 순서를 숫자로 입력" min="1" max="1000" step="1" 
                   style='width: 30%;' class="form-control" >
       </div>
    </div>
      
    <div class="form-group">
       <label class="control-label col-md-4">출력 형식</label>
       <div class="col-md-8">
          <select name='visible' class="form-control" style='width: 20%;'>
            <option value='Y' selected="selected">Y</option>
            <option value='N'>N</option>
          </select>
       </div>
    </div>   
  
    <div class="content_body_bottom" style="padding-right: 20%;">
      <button type="submit" class="btn">등록</button> <!--  submit은 무조건 form 안쪽에 -->
      <button type="button" onclick="location.href='./list.do'" class="btn">목록</button>
    </div>
  
  </FORM>
</DIV><!-- content_body end -->
-----------------------------------------------------------------------------------
~~~

* **0407 : [17][Categrp] Categrp 조회, 수정폼 기능의 제작, JSP 수정과 목록의 결합**  
![image](https://user-images.githubusercontent.com/76051264/113799411-fc10a980-978f-11eb-98ca-7afeb5f24907.png)  
~~~
★★★ Read, 조회 : 한 건의 레코드를 읽는 것 ★★★★★
- READ(한건의 데이트 읽기, WHERE)의 경우 Return Type = VO
[01] 조회, 수정폼 기능의 제작(UPDATE ~ SET ~ WHERE ~ ), JSP 수정과 목록의 결합
1. SQL
▷ /webapp/WEB-INF/doc/dbms/categrp_c.sql
-----------------------------------------------------------------------------------
-- 조회, 수정폼
SELECT categrpno, name, seqno, visible, rdate 
FROM categrp
WHERE categrpno = 1;
 
 CATEGRPNO NAME  SEQNO VISIBLE RDATE
 --------- ----- ----- ------- ---------------------
         1 국내 여행     1 Y       2019-05-13 13:07:50.0
-----------------------------------------------------------------------------------
  
2. MyBATIS
▷ /src/main/resources/categrp.xml 
1) SELECT 사용 시 LIST(결과 레코드 여러개)인 경우 DAO와 Proc에서 ArrayList Return
2) SELECT 사용 시 READ(결과 레코드 한개)인 경우 DAO와 Proc에서 VO가 Return
★★★ CREATE(등록) -> LIST(목록) -> READ(조회) ★★★
-----------------------------------------------------------------------------------
  <!-- 조회, id: read, 입력: categrpno, 리턴: CategrpVO
    1) SELECT 사용 시 LIST(결과 레코드 여러개)인 경우 ArrayList Return
    2) SELECT 사용 시 READ(결과 레코드 한개)인 경우 VO가 Return
   -->
  <select id="read" resultType="dev.mvc.categrp.CategrpVO" parameterType="int">
    SELECT  categrpno, name, seqno, visible, rdate
    FROM categrp
    WHERE categrpno=#{categrpno}
  </select>
-----------------------------------------------------------------------------------
 
3. DAO interface
▷ CategrpDAOInter.java 
-----------------------------------------------------------------------------------
/**
   * 조회, 수정폼
   * @param categrpno 카테고리 그룹 번호, PK
   * @return
   */
  // 2) SELECT 사용 시 READ(결과 레코드 한개)인 경우 VO가 Return
  public CategrpVO read(int categrpno);
-----------------------------------------------------------------------------------
 
4. Process interface
▷ CategrpProcInter.java
-------------------------------------------------------------------------------------
  /**
   * 조회, 수정폼
   * @param categrpno 카테고리 그룹 번호, PK
   * @return
   */
  public CategrpVO read(int categrpno);
-------------------------------------------------------------------------------------
 
5. Process class
▷ CategrpProc.java
-------------------------------------------------------------------------------------
  @Override
  public CategrpVO read(int categrpno) {
    CategrpVO categrpVO = null;
    categrpVO = this.categrpDAO.read(categrpno);
    
    return categrpVO;
  }
-------------------------------------------------------------------------------------
   
6. Controller class : 수정폼에 조회 기능이 추가. GET방식
▷ CategrpCont.java
-----------------------------------------------------------------------------------
  // http://localhost:9090/categrp/read_update.do
  /**
   * 조회 + 수정폼
   * @param categrpno 조회할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/categrp/read_update.do", method=RequestMethod.GET )
  public ModelAndView read_update(int categrpno) {
    // request.setAttribute("categrpno", int categrpno) 작동 안됨.
    
    ModelAndView mav = new ModelAndView();
    
    CategrpVO categrpVO = this.categrpProc.read(categrpno);
    mav.addObject("categrpVO", categrpVO);  // request 객체에 저장
    
    List<CategrpVO> list = this.categrpProc.list_categrpno_asc();	// 목록을 다시 가져옴.
    mav.addObject("list", list);  // request 객체에 저장

    mav.setViewName("/categrp/read_update"); // /webapp/WEB-INF/views/categrp/read_update.jsp 
    return mav; // forward
  }
 -----------------------------------------------------------------------------------
 
7. View: JSP
▷ /webapp/WEB-INF/views/categrp/read_update.jsp  
-----------------------------------------------------------------------------------
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

<script type="text/javascript">
 
</script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>카테고리 그룹 > ${categrpVO.name } 조회(수정)</DIV>

<DIV class='content_body'>
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='categrpno' id='categrpno' value='${categrpVO.categrpno }'>
       <!-- hidden tag : 브라우저 상 출력no, 폼에는 구성요소로 데이터 전달 -->
       
      <label>그룹 이름</label>
      <input type='text' name='name' value="${categrpVO.name }" required="required" 
                 autofocus="autofocus" style='width: 25%;'>
      <!-- value :  출력  및 수정 가능 --> 
      
      <label>순서</label>
      <input type='number' name='seqno' value="${categrpVO.seqno }" required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label>형식</label>
      <select name='visible'>
        <option value='Y' ${categrpVO.visible == 'Y' ? "selected='selected'":"" }>Y</option>
        <option value='N' ${categrpVO.visible == 'N' ? "selected='selected'":""}>N</option>
      </select>
       
      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="location.href='./list.do'">취소</button>
    </FORM>
    </DIV>
   
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 40%;'/>
      <col style='width: 20%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">순서</TH>
      <TH class="th_bs">대분류명</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">출력</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="categrpVO" items="${list}">
      <c:set var="categrpno" value="${categrpVO.categrpno }" />
      <TR>
        <TD class="td_bs">${categrpVO.seqno }</TD>
        <TD class="td_bs_left">${categrpVO.name }</TD>
        <TD class="td_bs">${categrpVO.rdate.substring(0, 10) }</TD>
        <TD class="td_bs">${categrpVO.visible }</TD>
        <TD class="td_bs">
          <!-- read_update.do가 지정된경우 controller로 전달  -->
          <A href="./read_update.do?categrpno=${categrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?categrpno=${categrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
          <A href="./update_seqno_up.do?categrpno=${categrpno }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
          <A href="./update_seqno_down.do?categrpno=${categrpno }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
         </TD>   
  
      </TR>   
    </c:forEach> 
    </tbody>
  </TABLE>

</DIV> <!-- content_body end -->
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
-----------------------------------------------------------------------------------
~~~

* **0407 : [18][Categrp] Categrp 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )**
~~~
[01] 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ ), JSP 수정과 목록의 결합
- Update, 수정 : PK는 update 불가능, 컬럼의 특징을 파악후 변경 여부결정
- UPDATE 테이블명 SET에 바꿀 조건, WHERE에 PK조건을 명시.

★★UDATE 수정★★
UPDATE 테이블명 SET 컬럼값='영화에서영화2로', 컬럼값=5, 컬럼값='N'
WHERE 컬럼값(PK)=1;

1. SQL
 ▷ /webapp/WEB-INF/doc/dbms/categrp_c.sql
-----------------------------------------------------------------------------------
-- 수정
UPDATE categrp
SET name='업무 양식', seqno = 3, visible='Y'
WHERE categrpno = 3;
commit;
-----------------------------------------------------------------------------------
  
2. MyBATIS : - 조회 기능과 변경을 같이 제작
▷ /src/main/resources/categrp.xml 
-----------------------------------------------------------------------------------
  <!-- 수정, id: update, 입력: CategrpVO, 리턴: int 
	WHERE 조건에 PK -->
  <update id="update" parameterType="dev.mvc.categrp.CategrpVO">
    UPDATE categrp
    SET name=#{name}, seqno=#{seqno}, visible=#{visible}
    WHERE categrpno = #{categrpno}
  </update>
-----------------------------------------------------------------------------------
 
3. DAO interface
▷ CategrpDAOInter.java 
-----------------------------------------------------------------------------------
  /**
   * 수정 처리
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int update(CategrpVO categrpVO);
-----------------------------------------------------------------------------------
 
4. Process interface
▷ CategrpProcInter.java
-------------------------------------------------------------------------------------
  /**
   * 수정 처리
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int update(CategrpVO categrpVO);
 -------------------------------------------------------------------------------------
 
5. Process class : 구현 클래스
▷ CategrpProc.java
-------------------------------------------------------------------------------------
  @Override
  public int update(CategrpVO categrpVO) {
    int cnt = 0;
    cnt = this.categrpDAO.update(categrpVO);
    return cnt;
  }
 -------------------------------------------------------------------------------------
   
6. Controller class : POST 방식
▷ CategrpCont.java
-----------------------------------------------------------------------------------
  // http://localhost:9090/categrp/update.do
  /**
   * 수정 처리
   * @param categrpVO
   * @return
   */
  @RequestMapping(value="/categrp/update.do", method=RequestMethod.POST )
  public ModelAndView update(CategrpVO categrpVO) {
    // CategrpVO categrpVO <FORM> 태그의 값으로 자동 생성됨.
    // request.setAttribute("categrpVO", categrpVO); 자동 실행
    
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.categrpProc.update(categrpVO);
    mav.addObject("cnt", cnt); // request에 저장
    
    mav.setViewName("/categrp/update_msg"); // update_msg.jsp
    
    return mav;
  }
-----------------------------------------------------------------------------------
 
 7. View: JSP
- 처리 결과 출력
 ▷ /webapp/categrp/update_msg.jsp 
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
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${cnt == 1}">
          <LI class='li_none'>
            <span class="span_success">카테고리 그룹을 수정했습니다.</span>
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">카테고리 그룹 수정에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <c:if test="${cnt != 1 }">
	  <%-- History 객체.back() : JavaScript --%>
          <button type='button' onclick="history.back()" class="btn btn-primary">다시 시도</button>
        </c:if>
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

* **[19][Categrp] Categrp 삭제 폼 기능의 제작, JSP 삭제와 목록의 결합**
~~~
[01] 삭제 폼 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
1. SQL
▷ /webapp/WEB-INF/doc/dbms/categrp_c.sql
-----------------------------------------------------------------------------------
-- 조회 + 수정폼 + 삭제폼
SELECT categrpno, name, seqno, visible, rdate 
FROM categrp
WHERE categrpno = 1;
-----------------------------------------------------------------------------------
 
2. MyBATIS
▷ /src/main/resources/categrp.xml   = READ와 같은 조회 XML
-----------------------------------------------------------------------------------
  <!-- 삭제 처리, id=delete, 입력: PK, 리턴: 삭제된 갯수 int -->
  <delete id="delete" parameterType="int">
    DELETE FROM categrp
    WHERE categrpno=#{categrpno}
  </delete>
 -----------------------------------------------------------------------------------

3. DAO interface▷ CategrpDAOInter.java  = READ와 같은 조회 인터페이스
-----------------------------------------------------------------------------------
  /**
   * 삭제 처리
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int delete(int categrpno);
----------------------------------------------------------------------------------- 

4. Process interface
▷ CategrpProcInter.java = READ와 같은 조회 인터페이스
-----------------------------------------------------------------------------------
  /**
   * 삭제 처리
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int delete(int categrpno);
-----------------------------------------------------------------------------------

5. Process class
▷ CategrpProc.java = READ와 같은 구현
-----------------------------------------------------------------------------------
  @Override
  public int delete(int categrpno) {
    int cnt = 0;
    cnt = this.categrpDAO.delete(categrpno);
    
    return cnt;
  }
-----------------------------------------------------------------------------------

6. Controller class
▷ CategrpCont.java
-----------------------------------------------------------------------------------
  // http://localhost:9090/categrp/read_delete.do
  /**
   * 조회 + 삭제폼
   * @param categrpno 조회할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/categrp/read_delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int categrpno) {
    ModelAndView mav = new ModelAndView();
    
    CategrpVO categrpVO = this.categrpProc.read(categrpno); // 삭제할 자료 읽기
    mav.addObject("categrpVO", categrpVO);  // request 객체에 저장
    
    List<CategrpVO> list = this.categrpProc.list_seqno_asc();
    mav.addObject("list", list);  // request 객체에 저장

    mav.setViewName("/categrp/read_delete"); // read_delete.jsp
    return mav;
  }
-----------------------------------------------------------------------------------
 
7. View: JSP
▷ read_delete.jsp 
-----------------------------------------------------------------------------------
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
    
<script type="text/javascript">
 
  
</script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" />
 
  <DIV class='title_line'>카테고리 그룹 > ${categrpVO.name } 삭제</DIV>
 
  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <div class="msg_warning">카테고리 그룹을 삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
      <input type='hidden' name='categrpno' id='categrpno' value='${categrpVO.categrpno }'>
        
      <label>그룹 이름</label>: ${categrpVO.name }  
      <label>순서</label>: ${categrpVO.seqno }   
      <label>출력 형식</label>: ${categrpVO.visible }  
       
      <button type="submit" id='submit'>삭제</button>
      <button type="button" onclick="location.href='./list.do'">취소</button>
    </FORM>
  </DIV>
   
<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 40%;'/>
    <col style='width: 20%;'/>
    <col style='width: 10%;'/>    
    <col style='width: 20%;'/>
  </colgroup>
 
  <thead>  
  <TR>
    <TH class="th_bs">순서</TH>
    <TH class="th_bs">대분류명</TH>
    <TH class="th_bs">등록일</TH>
    <TH class="th_bs">출력</TH>
    <TH class="th_bs">기타</TH>
  </TR>
  </thead>
  
  <tbody>
  <c:forEach var="categrpVO" items="${list}">
    <c:set var="categrpno" value="${categrpVO.categrpno }" />
    <TR>
      <TD class="td_bs">${categrpVO.seqno }</TD>
      <TD class="td_bs_left">${categrpVO.name }</TD>
      <TD class="td_bs">${categrpVO.rdate.substring(0, 10) }</TD>
      <TD class="td_bs">${categrpVO.visible }</TD>
      <TD class="td_bs">
        <A href="./read_update.do?categrpno=${categrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
        <A href="./read_delete.do?categrpno=${categrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        <A href="./update_seqno_up.do?categrpno=${categrpno }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
        <A href="./update_seqno_down.do?categrpno=${categrpno }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
       </TD>   
    </TR>   
  </c:forEach> 
  </tbody>
 
</TABLE>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
-----------------------------------------------------------------------------------
~~~

* **[20][Categrp] Categrp 삭제 처리 기능의 제작(DELETE FROM ~ WHERE)**
~~~
[01] 삭제 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
6. Controller class
▷ CategrpCont.java : POST 방식
-----------------------------------------------------------------------------------
  // http://localhost:9090/categrp/delete.do
  /**
   * 삭제
   * @param categrpno 조회할 카테고리 번호
   * @return
   */
  @RequestMapping(value="/categrp/delete.do", method=RequestMethod.POST )
  public ModelAndView delete(int categrpno) {
    ModelAndView mav = new ModelAndView();
    
    CategrpVO categrpVO = this.categrpProc.read(categrpno); // 삭제 정보
    mav.addObject("categrpVO", categrpVO);  // request 객체에 저장
    
    int cnt = this.categrpProc.delete(categrpno); // 삭제 처리
    mav.addObject("cnt", cnt);  // request 객체에 저장
    
    mav.setViewName("/categrp/delete_msg"); // delete_msg.jsp

    return mav;
  }
-----------------------------------------------------------------------------------

7. View: JSP
- 처리 결과 출력
- 삭제 실패 테스트: http://localhost:9090/resort/categrp/delete_msg.jsp?cnt=0
▷ delete_msg.jsp 
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
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${cnt == 1}">
          <LI class='li_none'>
            <span class="span_success">카테고리 그룹을 삭제했습니다.</span>
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">카테고리 그룹 삭제에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <c:if test="${cnt != 1 }">
          <button type='button' onclick="history.back()" class="btn btn-primary">다시 시도</button>
        </c:if>
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

* **0408 : [21][Categrp] Categrp 출력 순서의 변경 제작(UPDATE ~ SET ~ WHERE ~ ), 링크의 이미지 처리(Glyphicon)**
~~~
-> seqno 컬럼을 이용한 순서 변경
[01] 출력 순서의 변경 제작(UPDATE ~ SET ~ WHERE ~)
1. SQL
▷ /webapp/WEB-INF/doc/dbms/categrp_c.sql
-----------------------------------------------------------------------------------
-- 출력 순서에따른 전체 목록(정렬)
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY seqno ASC;
 
-- 출력 순서 올림(상향), 10 ▷ 1
-- WHERE절은 PK조건
UPDATE categrp
SET seqno = seqno - 1
WHERE categrpno=1;
 
-- 출력순서 내림(하향), 1 ▷ 10
UPDATE categrp
SET seqno = seqno + 1
WHERE categrpno=1;

-- commit으로 삭제, 업데이트 등의 작업후 DB에 적용
commit;
-----------------------------------------------------------------------------------
 
2. MyBATIS
- 우선 순위에따른 목록 출력
  <select id="list_seqno_asc" resultType="CategrpVO" >
- 우선순위 상향 up 10 ▷ 1
  <update id="update_seqno_up" parameterType="int">
- 우선순위 하향 down 1 ▷ 10 
  <update id="update_seqno_down" parameterType="int">

▷ categrp.xml 
-----------------------------------------------------------------------------------
  <!-- 우선순위 상향 up 10 ▷ 1 -->
  <update id="update_seqno_up" parameterType="int">
    UPDATE categrp
    SET seqno = seqno - 1
    WHERE categrpno=#{categrpno}
  </update>

  <!-- 우선순위 하향 down 1 ▷ 10 --> 
  <update id="update_seqno_down" parameterType="int">
    UPDATE categrp
    SET seqno = seqno + 1
    WHERE categrpno=#{categrpno}
  </update>
-----------------------------------------------------------------------------------
 
3. DAO interface
▷ /dev/mvc/categrp/CategrpDAOInter.java 
-----------------------------------------------------------------------------------
  /**
   * 출력 순서 상향
   * @param categrpno
   * @return 처리된 레코드 갯수
   * UPDATE 패턴과 동일
   */
  public int update_seqno_up(int categrpno);
 
  /**
   * 출력 순서 하향
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_down(int categrpno); 
-----------------------------------------------------------------------------------
 
4. Process interface
▷ /dev/mvc/categrp/CategrpProcInter.java 
-----------------------------------------------------------------------------------
  /**
   * 출력 순서 상향
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_up(int categrpno);
 
  /**
   * 출력 순서 하향
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_down(int categrpno); 
-----------------------------------------------------------------------------------
 
5. Process class
▷ CategrpProcess.java
-----------------------------------------------------------------------------------
  @Override
  public int update_seqno_up(int categrpno) {
    int cnt = 0;
    cnt = this.categrpDAO.update_seqno_up(categrpno);
    
    return cnt;
  }

  @Override
  public int update_seqno_down(int categrpno) {
    int cnt = 0;
    cnt = this.categrpDAO.update_seqno_down(categrpno);    
    return cnt;
  }
-----------------------------------------------------------------------------------
 
6. Controller class : UPDATE Controller와 동일, but GET 방식(처리 페이지가 필요 no)
▷ CategrpCont.java
-----------------------------------------------------------------------------------
  // http://localhost:9091/categrp/update_seqno_up.do?categrpno=1
  // http://localhost:9091/categrp/update_seqno_up.do?categrpno=1000
  /**
   * 우선순위 상향 up 10 ▷ 1
   * @param categrpno 카테고리 번호
   * @return
   */
  @RequestMapping(value="/categrp/update_seqno_up.do", 
                              method=RequestMethod.GET )
  public ModelAndView update_seqno_up(int categrpno) {
    ModelAndView mav = new ModelAndView();
    
    CategrpVO categrpVO = this.categrpProc.read(categrpno); // 카테고리 그룹 정보
    mav.addObject("categrpVO", categrpVO);  // request 객체에 저장
    
    int cnt = this.categrpProc.update_seqno_up(categrpno);  // 우선 순위 상향 처리
    mav.addObject("cnt", cnt);  // request 객체에 저장

    mav.setViewName("/categrp/update_seqno_up_msg"); // update_seqno_up_msg.jsp
    return mav;
  }  
  
  // http://localhost:9090/categrp/update_seqno_down.do?categrpno=1
  // http://localhost:9090/categrp/update_seqno_down.do?categrpno=1000
  /**
   * 우선순위 하향 up 1 ▷ 10
   * @param categrpno 카테고리 번호
   * @return
   */
  @RequestMapping(value="/categrp/update_seqno_down.do", 
                              method=RequestMethod.GET )
  public ModelAndView update_seqno_down(int categrpno) {
    ModelAndView mav = new ModelAndView();
    
    CategrpVO categrpVO = this.categrpProc.read(categrpno); // 카테고리 그룹 정보
    mav.addObject("categrpVO", categrpVO);  // request 객체에 저장
    
    int cnt = this.categrpProc.update_seqno_down(categrpno);
    mav.addObject("cnt", cnt);  // request 객체에 저장

    mav.setViewName("/categrp/update_seqno_down_msg"); // update_seqno_down_msg.jsp

    return mav;
  }  
-----------------------------------------------------------------------------------
 
7. View: JSP, 변경과 목록의 결합
1) 목록 출력 순서를 seqno 컬럼의 오름차순으로 정렬
▷ /webapp/categrp/list.jsp : 기존 소스 사용
-(등록화면 윗쪽 + 등록된 그룹목록) 
-----------------------------------------------------------------------------------

2) 처리 결과 출력
- 삭제 실패 테스트: http://localhost:9090/resort/categrp/delete_msg.jsp?cnt=0
▷ /webapp/categrp/update_seqno_up_msg.jsp 
- 우선순위 상향.jsp
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
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${cnt == 1}">
          <LI class='li_none'>
            <span class="span_success">[${categrpVO.name }] 카테고리 그룹 우선순위 상향에 성공했습니다.</span>
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">
              [${categrpVO.name }] 카테고리 그룹 우선순위 상향에 실패했습니다.
            </span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <c:if test="${cnt != 1 }">
          <button type='button' onclick="history.back()" class="btn btn-info">다시 시도</button>
        </c:if>
        <button type='button' onclick="location.href='./list.do'" class="btn btn-info">목록</button>
      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
-------------------------------------------------------------------------------------
   
- 우선순위 하향.jsp
▷ /webapp/categrp/update_seqno_down_msg.jsp 
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
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${cnt == 1}">
          <LI class='li_none'>
            <span class="span_success">[${categrpVO.name }] 카테고리 그룹 우선순위 하향에 성공했습니다.</span>
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">
              [${categrpVO.name }] 카테고리 그룹 우선순위 하향에 실패했습니다.
            </span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <c:if test="${cnt != 1 }">
          <button type='button' onclick="history.back()" class="btn btn-info">다시 시도</button>
        </c:if>
        <button type='button' onclick="location.href='./list.do'" class="btn btn-info">목록</button>
      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>
-------------------------------------------------------------------------------------
~~~

* **0408 : [22][Categrp] 출력 순서별 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~)**
 + Redirect의 구현
~~~
[01] 출력 순서별 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~)
1. SQL
▷ /webapp/WEB-INF/doc/dbms/categrp_c.sql
-- seqno 정렬
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY seqno ASC;

 CATEGRPNO NAME SEQNO VISIBLE RDATE
 --------- ---- ----- ------- ---------------------
         1 영화       1 Y       2017-04-14 10:43:18.0
         2 여행       2 Y       2017-04-14 10:43:19.0
         3 캠핑       3 Y       2017-04-14 10:43:20.0
-----------------------------------------------------------------------------------

2. MyBATIS
- 레코드 갯수 만큼 CategrpVO 객체를 만들어 ArrayList에 저장하여 리턴,
-> categrpno SELECT와 유사 but ORDERBY가 sqeno
  List<CategrpVO> list = new ArrayList<CategrpVO>(); 
★★★★list_categrpno_asc 밑에다 작성해주기(동일한 작업은 모으기)★★★
▷ /src/main/resources/categrp.xml 
-----------------------------------------------------------------------------------
  <!-- 
  레코드 갯수 만큼 CategrpVO 객체를 만들어 ArrayList에 저장하여 리턴,
  List<CategrpVO> list = new ArrayList<CategrpVO>(); 
  -->
 <select id="list_seqno_asc" resultType="dev.mvc.categrp.CategrpVO">
    SELECT  categrpno, name, seqno, visible, rdate
    FROM categrp
    ORDER BY seqno ASC
  </select>
-----------------------------------------------------------------------------------

3. DAO interface : list_categrpno_asc 위에 작성(유사한 함수끼리 묶음)
★★★★list_categrpno_asc 밑에다 작성해주기(동일한 작업은 모으기)★★★
▷ CategrpDAOInter.java 
-----------------------------------------------------------------------------------
  /**
   * 등록 순서별 목록
   * @return
   */
  public List<CategrpVO> list_seqno_asc();
-----------------------------------------------------------------------------------

4. Process interface :  list_categrpno_asc 위에 작성(유사한 함수끼리 묶음)
★★★★list_categrpno_asc 밑에다 작성해주기(동일한 작업은 모으기)★★★
▷ CategrpProcInter.java
-------------------------------------------------------------------------------------
  /**
   * 등록 순서별 목록
   * @return
   */
  public List<CategrpVO> list_seqno_asc();
-------------------------------------------------------------------------------------
 
5. Process class
- @Component("dev.mvc.categrp.CategrpProc"): 자동으로 객체 생성이 필요한 Class에만 선언 가능 
★★★★list_categrpno_asc 밑에다 작성해주기(동일한 작업은 모으기)★★★
▷ CategrpProc.java
-------------------------------------------------------------------------------------
  @Override
  public List<CategrpVO> list_categrpno_asc() {
    List<CategrpVO> list = null;
    list = this.categrpDAO.list_seqno_asc();
    return list;
  }
-------------------------------------------------------------------------------------
 
6. Controller class : list() update로 구현
- 출력 순서별 목록 + 등록 순서별 목록([22])
▷ CategrpCont.java
-----------------------------------------------------------------------------------
// http://localhost:9091/categrp/list.do
  /**
   * 출력 순서별 목록 + 등록 순서별 목록([22])
   * @return
   */
  @RequestMapping(value="/categrp/list.do", method=RequestMethod.GET )
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();

    // 등록 순서별 출력    
    // List<CategrpVO> list = this.categrpProc.list_categrpno_asc();
    // 출력 순서별 출력
    List<CategrpVO> list = this.categrpProc.list_seqno_asc();

    mav.addObject("list", list); // request.setAttribute("list", list);

    mav.setViewName("/categrp/list"); // /webapp/WEB-INF/views/categrp/list.jsp
    return mav;
  }
-----------------------------------------------------------------------------------

7. View: JSP, 등록과 목록의 결합
- <TABLE><TH><TD>는 Bootstrap에 기본 속성이 설정되어 있음
▷ /webapp/categrp/list.jsp 
-----------------------------------------------------------------------------------
Reuse of existing code.
-----------------------------------------------------------------------------------

[02] redirect의 적용
- Controller 상에서 다른 Spring 주소로 자동이동

-> JSP로 이동하지않고(주석처리)
// mav.setViewName("/categrp/update_seqno_up_msg"); // update_seqno_up_msg.jsp
-> redirect를 사용해 Spring 주소로 자동이동
mav.setViewName("redirect:/categrp/list.do");

ex) update_seqno_up_msg.jsp로 가야하지만 -> 페이지 새로고침으로 -> list.do

1. Controller class
▷ CategrpCont.java
-----------------------------------------------------------------------------------
// http://localhost:9091/categrp/update_seqno_up.do?categrpno=1
  // http://localhost:9091/categrp/update_seqno_up.do?categrpno=1000
  /**
   * 우선순위 상향 up 10 ▷ 1
   * @param categrpno 카테고리 번호
   * @return
   */
  @RequestMapping(value="/categrp/update_seqno_up.do", 
                              method=RequestMethod.GET )
  public ModelAndView update_seqno_up(int categrpno) {
    ModelAndView mav = new ModelAndView();
    
    CategrpVO categrpVO = this.categrpProc.read(categrpno); // 카테고리 그룹 정보
    mav.addObject("categrpVO", categrpVO);  // request 객체에 저장
    
    int cnt = this.categrpProc.update_seqno_up(categrpno);  // 우선 순위 상향 처리
    mav.addObject("cnt", cnt);  // request 객체에 저장

    // mav.setViewName("/categrp/update_seqno_up_msg"); // update_seqno_up_msg.jsp
    mav.setViewName("redirect:/categrp/list.do");
    return mav;
  }  
-----------------------------------------------------------------------------------  
  // http://localhost:9091/categrp/update_seqno_down.do?categrpno=1
  // http://localhost:9091/categrp/update_seqno_down.do?categrpno=1000
  /**
   * 우선순위 하향 up 1 ▷ 10
   * @param categrpno 카테고리 번호
   * @return
   */
  @RequestMapping(value="/categrp/update_seqno_down.do", 
                              method=RequestMethod.GET )
  public ModelAndView update_seqno_down(int categrpno) {
    ModelAndView mav = new ModelAndView();
    
    CategrpVO categrpVO = this.categrpProc.read(categrpno); // 카테고리 그룹 정보
    mav.addObject("categrpVO", categrpVO);  // request 객체에 저장
    
    int cnt = this.categrpProc.update_seqno_down(categrpno);
    mav.addObject("cnt", cnt);  // request 객체에 저장

    // mav.setViewName("/categrp/update_seqno_down_msg"); // update_seqno_down_msg.jsp
    mav.setViewName("redirect:/categrp/list.do");

    return mav;
  }  
-----------------------------------------------------------------------------------
~~~

* **0408 : [23][Categrp] Categrp 출력 모드의 변경(UPDATE ~ SET ~ WHERE ~ )**
~~~
[01] 출력 모드의 변경(UPDATE ~ SET ~ WHERE ~ ) 
Y-> N : N->Y 출력 모드의 변경
-> 특정 column의 값을 UPDATE
1. SQL
▷ /webapp/WEB-INF/doc/dbms/categrp_c.sql
-----------------------------------------------------------------------------------
-- 출력 모드의 변경
UPDATE categrp
SET visible='Y'
WHERE categrpno=1;

UPDATE categrp
SET visible='N'
WHERE categrpno=1;

commit;
-----------------------------------------------------------------------------------
 
2. MyBATIS
<!-- 수정, id: update_visible, 입력: CategrpVO, 리턴: int -->
▷ /src/main/resources/categrp.xml 
-----------------------------------------------------------------------------------
  <!-- Visible 수정, id: update_visible, 입력: CategrpVO, 리턴: int -->
  <update id="update_visible" parameterType="dev.mvc.categrp.CategrpVO">
    UPDATE categrp
    SET visible=#{visible}
    WHERE categrpno = #{categrpno}
  </update>
-----------------------------------------------------------------------------------
  
3. DAO interface
▷ /dev/mvc/categrp/CategrpDAOInter.java 
-----------------------------------------------------------------------------------
  /**
   * visible 수정
   * @param categrpVO
   * @return
   */
  public int update_visible(CategrpVO categrpVO);
-----------------------------------------------------------------------------------
 
4. Process interface
▷ /dev/mvc/categrp/CategrpProcInter.java 
-----------------------------------------------------------------------------------
  /**
   * visible 수정
   * @param categrpVO
   * @return
   */
  public int update_visible(CategrpVO categrpVO);
-----------------------------------------------------------------------------------
 
5. Process class : Switching algorism
▷ CategrpProcess.java
-----------------------------------------------------------------------------------
  @Override
  public int update_visible(CategrpVO categrpVO) {
    int cnt = 0;
    if (categrpVO.getVisible().toUpperCase().equals("Y")) {
      categrpVO.setVisible("N");
    } else {
      categrpVO.setVisible("Y");
    }
    cnt = this.categrpDAO.update_visible(categrpVO);
    return cnt;
  }
-----------------------------------------------------------------------------------
 
6. Controller class
- mav.setViewName("redirect:/categrp/list.jsp"); // request 객체 전달 안됨
- mav.setViewName("redirect:/categrp/list.do"); // request 객체 전달 안됨. 
▷ CategrpCont.java
-----------------------------------------------------------------------------------
  /**
   * 출력 모드의 변경
   * @param categrpVO
   * @return
   */
  @RequestMapping(value="/categrp/update_visible.do", 
      method=RequestMethod.GET )
  public ModelAndView update_visible(CategrpVO categrpVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.categrpProc.update_visible(categrpVO);
    
    mav.setViewName("redirect:/categrp/list.do"); // request 객체 전달 안됨. 
    
    return mav;
  }  
-----------------------------------------------------------------------------------

7. View: JSP, 등록과 목록의 결합
1) Text link 
▷ /webapp/categrp/list.jsp : 수정필요
-----------------------------------------------------------------------------------
      <TD class="td_bs">${categrpVO.rdate.substring(0, 10) }</TD> <!-- subString으로 년, 월일만 잘라내기  -->
       
       <!-- 이부분 부터 수정 --!>
       <TD class="td_bs">
        <c:choose>
          <c:when test="${categrpVO.visible == 'Y'}">
            <A href="./update_visible.do?categrpno=${categrpno }&visible=${categrpVO.visible }">Y</A>
          </c:when>
          <c:otherwise>
            <A href="./update_visible.do?categrpno=${categrpno }&visible=${categrpVO.visible }">N</A>
          </c:otherwise>
        </c:choose>
       </TD>   
      
      <TD class="td_bs">
        <A href="./read_update.do?categrpno=${categrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
        <A href="./read_delete.do?categrpno=${categrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        <A href="./update_seqno_up.do?categrpno=${categrpno }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
        <A href="./update_seqno_down.do?categrpno=${categrpno }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
      </TD>   
    </TR>   
  </c:forEach> 
  </tbody>
   
  </TABLE>

</DIV><!-- content body end -->

<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
-----------------------------------------------------------------------------------

2) Image link 
-> Static에 /categrp/images 디렉토리 생성 -> png 넣어주기
- IMG 경로 /categrp/images/open.png
▷ /webapp/categrp/list.jsp 
-----------------------------------------------------------------------------------
      <TD class="td_bs">${categrpVO.rdate.substring(0, 10) }</TD> <!-- subString으로 년, 월일만 잘라내기  -->
      <!-- 아래부터 변경 --!>

        <TD class="td_bs">
          <c:choose>
            <c:when test="${categrpVO.visible == 'Y'}">
              <A href="./update_visible.do?categrpno=${categrpno }&visible=${categrpVO.visible }"><IMG src="/categrp/images/open.png" style='width: 18px;'></A>
            </c:when>
            <c:otherwise>
              <A href="./update_visible.do?categrpno=${categrpno }&visible=${categrpVO.visible }"><IMG src="/categrp/images/close.png" style='width: 18px;'></A>
            </c:otherwise>
          </c:choose>
        </TD>   
-----------------------------------------------------------------------------------
~~~

* **0408~9 : [24][Cate] Cate 카테고리 DBMS 설계, 논리적 모델링, 물리적 모델링, SQL 제작(cate_c.sql)**
~~~
[01] Cate 카테고리 DBMS 설계, 논리적 모델링, 물리적 모델링, SQL 제작(cate_c.sql)
- Oracle 설정(Database URI): jdbc:oracle:thin:@localhost:1521:XE
- 그룹과 구성 요소의 관계
테이블 1      
                  FK 테이블 2
태양계 --+-- 태양계 - 수성
PK         |  
            +-- 태양계 - 금성
             |                              FK 테이블 3
            +-- 태양계 - 지구 --+-- 지구 - 미국
                              PK     |
                                      +-- 지구 - 네덜란드
                                      |                            FK 테이블 4
                                      +-- 지구 - 한국 --+-- 한국 - 동해
                                                     PK      |
                                                              +-- 한국 - 수원
                                                              |
                                                              +-- 한국 - 서울
1. 카테고리 테이블 모델링
   - JDBC Driver: oracle.jdbc.driver.OracleDriver
   - Oracle 설정: jdbc:oracle:thin:@localhost:1521:XE
   - erd 파일간 diagram copy: Ctrl + 테이블 선택 -> 마우스 우클릭 -> Copy -> 파일 이동 -> Paste
     (Ctrl + C 작동 안함)
   - 테이블명 지정
   - 등록된 컬럼 목록 : 테이블간 FK  설정, 논리적 모델링 / 테이블간 FK  설정, 물리적 모델링

2. cate SQL( 카테고리)
1) 테이블 생성: 부모 -> 자식
  ① FK cate 생성시 에러 발생: ORA-00942: table or view does not exist
  ② 부모 테이블 먼저 생성: categrp
  ③ 자식 테이블 생성: cate
2) 테이블 삭제: 자식 -> 부모
  ① DROP TABLE categrp; : ORA-02449: unique/primary keys in table referenced by foreign keys
  ② 자식 테이블 삭제: DROP TABLE cate;
  ③ 부모 테이블 삭제: DROP TABLE categrp;
 
3) CASCADE option을 이용한 자식 테이블을 무시한 테이블 삭제
  DROP TABLE categrp CASCADE CONSTRAINTS;

4) 레코드 추가
  ① 부모 테이블 레코드 먼저 추가: categrp
  ② 자식 테이블 레코드 추가: cate

5) 레코드 삭제
  ① 자식 테이블 레코드 먼저 삭제: cate
  ② 부모 테이블 레코드 삭제: categrp  
~~~
---
![image](https://user-images.githubusercontent.com/76051264/113974160-6bfa5f00-9878-11eb-8929-d27fb7b1fa3c.png)  
---
~~~
▷ /WEB-INF/doc/dbms/cate_c.sql
-------------------------------------------------------------------------------------
1) 테이블 생성: 부모 -> 자식
① FK cate 생성시 에러 발생: ORA-00942: table or view does not exist
② 부모 테이블 먼저 생성: categrp
③ 자식 테이블 생성: cate

2) 테이블 삭제: 자식 -> 부모
① DROP TABLE categrp; : ORA-02449: unique/primary keys in table referenced by foreign keys
② 자식 테이블 삭제: DROP TABLE cate;
③ 부모 테이블 삭제: DROP TABLE categrp;
  
3) CASCADE option을 이용한 자식 테이블을 무시한 테이블 삭제, 제약 조건 삭제
DROP TABLE categrp CASCADE CONSTRAINTS;

4)★ PK는 Sequence, AUTO_INCREMENT, NL(MAX()) 등으로 자동 생성!!!
  ★  FK는 다른 테이블의 PK나 UNIQUE 속성이 적용된 컬럼에 연결하여 등록된 값만 사용 할 수 있음.

5) 레코드 추가 : 부모 -> 자식
① 부모 테이블 레코드 먼저 추가: categrp
② 자식 테이블 레코드 추가: cate

6) 레코드 삭제 : 자식 -> 부모
① 자식 테이블 레코드 먼저 삭제: cate
② 부모 테이블 레코드 삭제: categrp

/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE cate;

CREATE TABLE cate(
		cateno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categrpno                     		NUMBER(10)		 NULL ,
		name                          		VARCHAR2(50)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL,
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
);

COMMENT ON TABLE cate is '카테고리';
COMMENT ON COLUMN cate.cateno is '카테고리 번호';
COMMENT ON COLUMN cate.categrpno is '카테고리 그룹 번호';
COMMENT ON COLUMN cate.name is '카테고리 이름';
COMMENT ON COLUMN cate.rdate is '등록일';
COMMENT ON COLUMN cate.cnt is '관련 자료 수';

-- cate(자식 Table)도 SEQUENCE Table 필요(ORACLE 기준)
DROP SEQUENCE cate_seq;
CREATE SEQUENCE cate_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 등록
INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 1000, '가을', sysdate, 0);
-- 오류 보고 : ORA-02291: integrity constraint (AI7.SYS_C008048) violated - parent key not found
-- FK 컬럼의 값 1000은 categrp 테이블에 없어서 에러 발생
-- FK는 다른 테이블의 PK나 UNIQUE 속성이 적용된 컬럼에 연결하여 등록된 값만 사용 할 수 있음

-- 부모 테이블 체크(categrpno= 1000인 값이 없기에 cate 테이블에서는 사용 no)
SELECT * FROM categrp ORDER BY categrpno ASC;
CATEGRPNO NAME                                 SEQNO V    RDATE              
---------- --------------------------------------- ---------- - -------------------
         1 영화22                                            1 Y 2021-04-02 03:37:44
         2 음악                                               4 Y 2021-04-02 03:39:05
         3 드라마                                            2 N 2021-04-02 03:39:20

-- 등록(CREATE, INSERT) : categrpno가 부모테이블에 있는 레코드로만
INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 1, 'SF', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 1, '드라마', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 1, '로코', sysdate, 0);

COMMIT;

-- 목록(LIST)
SELECT cateno, categrpno, name, rdate, cnt
FROM cate ORDER BY cateno ASC;

-- 목록(LIST) 출력. -> but categrp 테이블의 1번 레코드는 변하지 않음.
     PK           FK 
   CATENO  CATEGRPNO NAME                                               RDATE                      CNT
---------- ---------- -------------------------------------------------- ------------------- ----------
         1          1         SF                                                 2021-04-09 10:47:14          0
         2          1        드라마                                             2021-04-09 10:47:14          0
         3          1        로코                                                2021-04-09 10:47:14          0
         
-- 조회(READ)
SELECT cateno, categrpno, name, rdate, cnt
FROM cate WHERE cateno=3;

-- 수정(UPDATE)
UPDATE cate SET categrpno=1, name='식당', cnt=0
WHERE cateno = 3;

COMMIT;

-- 삭제(DELETE)
DELETE cate
WHERE cateno = 3;

COMMIT;
SELECT * FROM cate;       

-- 갯수(Count) 가져오기.
SELECT COUNT(*) AS cnt
FROM cate;

-- cnt 컬럼(글 수 증가 or 감소 : cnt = cnt +1 or -1)
UPDATE cate SET cnt = cnt + 1 WHERE cateno=1;
COMMIT;

-- cnt 컬럼 2. 글수 초기화 : cnt = 0
UPDATE cate SET cnt = 0;
COMMIT;

2. MyBATIS DAO package 폴더 등록
-------------------------------------------------------------------------------------
- > DatabaseConfiguration 설정
@MapperScan(basePackages= {"dev.mvc.resort_v1sbm3a", "dev.mvc.categrp",
                                          "dev.mvc.cate"})  <-- "dev.mvc.cate" 추가
-------------------------------------------------------------------------------------
~~~


* **0409 : [25][Cate] Cate VO(DTO), categrp and cate Join에 사용할 VO**
~~~
[01] Spring4 + MyBATIS 3.4.1의 연동

- 세부 작업 절차
    ① /WEB-INF/doc/dbms/cate.sql
    ② dev.mvc.cate.CateVO.java
    ③ /src/main/resources/mybatis/cate.xml  ◁─+
    ④ dev.mvc.cate.CateDAOInter.java ─────┘◁─+
    ⑤ DAO class Spring (자동 구현됨)                        │
    ⑥ dev.mvc.cate.CateProcInter.java ────────┘◁─+
    ⑦ dev.mvc.cate.CateProc.java                                      │
    ⑧ dev.mvc.cate.CateCont.java   ────────────┘
    ⑨ JSP View
  
1. dev.mvc.cate.CateVO.java
-------------------------------------------------------------------------------------
package dev.mvc.cate;

/*
CREATE TABLE cate(
    cateno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    categrpno                       NUMBER(10)     NOT NULL,
    name                              VARCHAR2(100)    NOT NULL,
    rdate                              DATE     NOT NULL,
    cnt                                 NUMBER(10)     DEFAULT 0     NOT NULL,
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
); 
 */
public class CateVO {
  /** 카테고리 번호 */
  private int cateno;  
  /** 카테고리 그룹 번호 */
  private int categrpno;
  /** 카테고리 이름 */
  private String name;
  /** 등록일 */
  private String rdate;
  /** 등록된 글 수 */
  private int cnt;
  
  public int getCateno() {
    return cateno;
  }
  public void setCateno(int cateno) {
    this.cateno = cateno;
  }
  public int getCategrpno() {
    return categrpno;
  }
  public void setCategrpno(int categrpno) {
    this.categrpno = categrpno;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  
  
}
~~~

* **0409 : [26][Cate] Cate 등록 기능 제작(INSERT ~ INTO ~ VALUES ~)**
~~~
- 카테고리 등록 화면: http://localhost:9090/cate/create.do?categrpno=4  
<- 기존에 등록된 categrpno 번호 사용할 것. ★★★★★
1) DI(Depency Injection): 의존 주입, 필요한 클래스를 Spring Container가 자동으로 생성하여 할당함.

1. SQL:  /webapp/WEB-INF/doc/dbms/cagte_c.sql
-------------------------------------------------------------------------------------
-- ERROR가 발생하는 등록
INSERT INTO cate(cateno, categrpno, name, seqno, cnt)
VALUES(cate_seq.nextval, 1000, 'SF', sysdate, 0);

-- 정상적인 등록
INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 1, 'SF', sysdate, 0);

commit;
-------------------------------------------------------------------------------------
 
2. cate.xml 작성
   - SQL 마지막 부분에 ';'이 있으면 안됨.
▷ /src/main/resources/mybatis/cate.xml
-------------------------------------------------------------------------------------
<?xml version="1.0" encoding="UTF-8"?>
 
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
 
<!-- dev.mvc.cate.CateDAOInter 패키지에 등록된 interface 명시,
      패키지명과 인터페이스명은 실제로 존재해야함,
      Spring이 내부적으로 자동으로 interface를 구현해줌. -->
<mapper namespace="dev.mvc.cate.CateDAOInter">
  <!-- 
  insert: INSERT SQL 실행
  id: Spring에서 호출시 사용
  parameterType: 전달받는 데이터 객체의 타입
  return: 등록한 레코드 갯수 리턴
  SQL선언시 ';'은 삭제
  #{}: ? 동일
  #{name}: public String getName() 자동 호출
   --> 
  <insert id="create" parameterType="dev.mvc.cate.CateVO">
    INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
    VALUES(cate_seq.nextval, #{categrpno}, #{name}, sysdate, 0)
  </insert> 
  
</mapper>
-------------------------------------------------------------------------------------
 
3. DAO interface
▷ dev.mvc.cate.CateDAOInter.java
-------------------------------------------------------------------------------------
  /**
   * 등록
   * @param cateVO
   * @return 등록된 갯수
   */
  public int create(CateVO cateVO);
-------------------------------------------------------------------------------------
 
4. Process interface
▷ dev.mvc.cate.CateProcInter.java
-------------------------------------------------------------------------------------
  /**
   * 등록
   * @param cateVO
   * @return 등록된 갯수
   */
  public int create(CateVO cateVO);
-------------------------------------------------------------------------------------
  
5. Process class
▷ dev.mvc.cate.CateProc.java
-------------------------------------------------------------------------------------
package dev.mvc.cate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("dev.mvc.cate.CateProc")
public class CateProc implements CateProcInter {

  @Autowired
  private CateDAOInter cateDAO; // 인터페이스를 자동 구현 -> Mybatis로 호출
 
  public CateProc() {
    System.out.println("--> CateProc created");
  }
  
  @Override
  public int create(CateVO cateVO) {
    int cnt = this.cateDAO.create(cateVO);
    return cnt;
  }
}
------------------------------------------------------------------------------------
  
6. Controller
    - @Autowired: 자동으로 구현빈을 연결
    - @Qualifier("dev.mvc.cagtegory.CagteProc"): 같은 이름의 클래스가 존재하면
      생성되는 클래스에 이름을 부여하고 구분해서 객체를 할당받음.
+ 새로고침을 방지 추가
▷ dev.mvc.cate.CateCont.java 
-------------------------------------------------------------------------------------
package dev.mvc.cate;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;
//import dev.mvc.contents.ContentsProcInter;

@Controller
public class CateCont {
  @Autowired
  @Qualifier("dev.mvc.cate.CateProc")
  private CateProcInter cateProc;
  
//  @Autowired
//  @Qualifier("dev.mvc.contents.ContentsProc")
//  private ContentsProcInter contentsProc;

  public CateCont() {
    System.out.println("--> CateCont created.");
  }

 /**
   * [26][Cate] Cate 등록 기능 제작(INSERT ~ INTO ~ VALUES ~)
   * 새로고침을 방지
   * @return
   */
  @RequestMapping(value="/cate/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();
    mav.setViewName(url); // url을 받아서 url로 forward
    return mav; // forward
  }

  /**
   * 등록폼 http://localhost:9091/cate/create.do?categrpno=4
   * 
   * @return
   */
  @RequestMapping(value = "/cate/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cate/create"); // /webapp/WEB-INF/views/cate/create.jsp

    return mav;
  }

  /**
   * 등록처리
   * http://localhost:9091/cate/create.do?categrpno=4
   * 
   * @return
   */
  @RequestMapping(value = "/cate/create.do", method = RequestMethod.POST)
  public ModelAndView create(CateVO cateVO) {
    ModelAndView mav = new ModelAndView();

    // System.out.println("--> categrpno: " + cateVO.getCategrpno());
    
    int cnt = this.cateProc.create(cateVO);
    mav.addObject("cnt", cnt);
    mav.addObject("categrpno", cateVO.getCategrpno());
    mav.addObject("name", cateVO.getName());  // 2) redirert 해도 name 객체를 출력하기 위한 방법, 추가해주기
    
    mav.addObject("url", "/cate/create_msg");  // /cate/create_msg -> /cate/create_msg.jsp
    
    mav.setViewName("redirect:/cate/msg.do"); // 1) redirect시 객체 사라짐, msg에서 param.name은 전달 못받음
    // response.sendRedirect("/cate/msg.do");
    
    return mav;
  }
}
-------------------------------------------------------------------------------------
 
7. View: JSP
- 등록폼에서 FK 컬럼인 categrpno 컬럼의 값을 <input type='hidden' ...> 태그로 전달해야함
  예) <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
      <!-- categrp 테이블로부터 값을 전달받지 못한 경우는 값을 직접 지정하여 개발 -->
      <input type="hidden" name="categrpno" value="1">

1) 입력 화면
- http://localhost:9091/cate/create.do?categrpno=4
▷ /webapp/WEB-INF/views/cate/create.jsp 
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
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>카테고리 등록</DIV>
 
<DIV class='content_body'>
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
    <!-- 
    부모테이블 categrpno PK 컬럼 값 이용, hidden으로 FK 선언
    http://localhost:9090/cate/create.do?categrpno=1
     -->
    <input type="hidden" name="categrpno" value="${param.categrpno }"> 
    
    <div class="form-group">
       <label class="control-label col-md-3">카테고리 이름</label>
       <div class="col-md-9">
         <input type='text' name='name' value='' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 50%;'>
          (부모 카테고리 번호(categrpno): ${param.categrpno })    <BR>   
	  (부모 카테고리 번호(categrpno) 2에 해당하는 레코드 등록 시 : GET /url..?categrpno=2)  
       </div>
    </div>
    <div class="content_body_bottom" style="padding-right: 20%;">
      <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick="location.href='./list.do'" class="btn btn-primary">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
-------------------------------------------------------------------------------------
 
2. 메시지 출력
▷ /webapp/views/cate/create_msg.jsp 
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

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.cnt == 1}">
          <LI class='li_none'>
            <span class="span_success">새로운 카테고리『${param.name }』를 등록했습니다.</span>
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">새로운 카테고리『${param.name }』등록에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <button type='button' onclick="location.href='./list.do?categrpno=${param.categrpno}'" class="btn btn-primary">새로운 카테고리 등록</button>
        <button type='button' onclick="location.href='./list.do?categrpno=${param.categrpno}'" class="btn btn-primary">목록</button>
      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>
~~~
---

----
* join 절차(27,28,29)
* **0409: [27][Cate] Categrp 전체목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), 등록과 목록이 결합된 화면 제작**
* ★★★★join 사용하지않는 경우★★★★
* join은 최소 2개 이상 결합
~~~
▷ /src/main/resources/mybatis/cate.xml
-------------------------------------------------------------------------------------
  <select id="list_cateno_asc" resultType="dev.mvc.cate.CateVO">
    SELECT cateno, categrpno, name, rdate, cnt
    FROM cate 
    ORDER BY cateno ASC
  </select>
-------------------------------------------------------------------------------------

3. DAO interface	4. Process interface
▷ dev.mvc.cate.CateDAOInter.java	▷ dev.mvc.cate.CateProcInter.java
-------------------------------------------------------------------------------------
  /**
   * 전체목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~)
   *  목록
   * @return
   */
  public List<CateVO> list_all();  
  
-------------------------------------------------------------------------------------
  
5. Process class
▷ dev.mvc.cate.CateProc.java
-------------------------------------------------------------------------------------
  @Override
  public List<CateVO> list_all() {
   List<CateVO> list = this.cateDAO.list_all();
   return list;
  }
-------------------------------------------------------------------------------------
  
6. Controller
▷ dev.mvc.cate.CateCont.java 
-------------------------------------------------------------------------------------
  // http://localhost:9091/cate/list.do?categrpno=1 기존의 url 사용
  /**
   * [27][Cate] Categrp 전체목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~)
   * categrp + cate join 전체 목록
   * @return
   */
  @RequestMapping(value="/cate/list_all.do", method=RequestMethod.GET )
  public ModelAndView list_all() {
    ModelAndView mav = new ModelAndView();
    
    List<CateVO> list = this.cateProc.list_all();
    mav.addObject("list", list); // request.setAttribute("list", list);

    mav.setViewName("/cate/list_all"); // /cate/list_all.jsp
    return mav;
  }
-------------------------------------------------------------------------------------

7. View: JSP
1)목록 화면 ▷ /webapp/WEB-INF/views/cate/list_all.jsp 
-> /categrp/list.jsp 기반 수정
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
    
<script type="text/javascript">
 
</script>
 
</head> 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'><A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 전체 카테고리</DIV>

<DIV class='content_body'>
  <TABLE class='table table-striped'>
    <colgroup>
    <col style='width: 10%;'/>  <!-- /는 close 태그 == body 없이 태그의 속성만 사용 -->
    <col style='width: 10%;'/>
    <col style='width: 40%;'/>
    <col style='width: 20%;'/>
    <col style='width: 10%;'/>    
    <col style='width: 10%;'/>
  </colgroup>
  
  <thead>  
  <TR>
    <!-- erd 보고 값 지정 -->
    <TH class="th_bs">카테고리 번호</TH>
    <TH class="th_bs">카테고리 그룹 번호</TH>
    <TH class="th_bs">카테고리 이름</TH>
    <TH class="th_bs">등록일</TH>
    <TH class="th_bs">관련 자료수</TH>
    <TH class="th_bs">기타</TH>
  </TR>
  </thead>
  
  <tbody>
  <c:forEach var="cateVO" items="${list}">
    <c:set var="cateno" value="${cateVO.cateno }" />
    <TR>
      <TD class="td_bs">${cateVO.cateno }</TD>
      <TD class="td_bs">${cateVO.categrpno }</TD>   <%-- FK 설정 --%>
      <TD class="td_bs_left">${categrpVO.name }</TD>
      <TD class="td_bs">${cateVO.rdate.substring(0, 10) }</TD>
      <TD class="td_bs">${cateVO.cnt }</TD>
        
      <TD class="td_bs"> <!-- 기타  글리피콘-->
        <A href="./read_update.do?cateno=${categrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
        <A href="./read_delete.do?cateno=${categrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>     
      </TD>   
    </TR> <!-- 행 종료 -->  
  </c:forEach> 
  </tbody>
   
  </TABLE><!-- table end -->

</DIV><!-- content body end -->

<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
-------------------------------------------------------------------------------------
~~~

* **0412: [28][Cate] Categrp + Cate join 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), 등록과 목록이 결합된 화면 제작**  
* Field error in object 'cateVO' on field 'categrpno':   
* Categrpno(FK)는 RDB 설계로 인한 연결이 필요  
* FK는 분류를 위해서 사용.  
* cate Table에서 부모 테이블인 Categrp Table의 컬럼 사용하는 방법
~~~
  @Autowired // CategrpProcInter 인터페이스를 구현한 CategrpProc.java가 할당
  @Qualifier("dev.mvc.categrp.CategrpProc") // proc에게 전송
  private CategrpProcInter categrpProc; 
~~~

~~~
[01] Categrp + Cate join 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), 등록과 목록이 결합된 화면 제작
list_all.do에 list.do 처럼 목록추가 + 등록된 목록
1. SQL:  /webapp/WEB-INF/doc/dbms/cate_c.sql

-- categrpno 별 목록(WHER로 caregrpno = 1(여행) 인 레코드만 출력.
SELECT cateno, categrpno, name, rdate, cnt
FROM cate
WHERE categrpno = 1
ORDER BY cateno ASC;
------------------------------------------------------------------------------------
                      
2. cate.xml 작성 : ▷ /src/main/resources/mybatis/cate.xml
-------------------------------------------------------------------------------------
  <!--  카테고리 그룹별 목록
  정수를 전달받기에 result = int -> but VO를 return하기에 parameter 타입을 int로 설정
  categrpno는 입력받기에 #{값} -->
  <select id="list_by_categrpno" resultType="dev.mvc.cate.CateVO" parameterType="int">
    SELECT cateno, categrpno, name, rdate, cnt
    FROM cate
    WHERE categrpno = #{categrpno}
    ORDER BY cateno ASC
  </select>
  -------------------------------------------------------------------------------------
 
 3. DAO interface ▷ dev.mvc.cate.CateDAOInter.java
-------------------------------------------------------------------------------------
  /**
   * [28][Cate] categrpno별 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), 등록과 목록이 결합된 화면 제작 
   *  categrpno 별 목록
   * @return
   */
  public List<CateVO> list_by_categrpno(int categrpno);  
  ------------------------------------------------------------------------------------
 
 4. Process interface ▷ dev.mvc.cate.CateProcInter.java
-------------------------------------------------------------------------------------
  /**
   * [28][Cate] categrpno별 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), 등록과 목록이 결합된 화면 제작 
   *  categrpno 별 목록
   * @return
   */
  public List<CateVO> list_by_categrpno(int categrpno);  
-------------------------------------------------------------------------------------
  
5. Process class ▷ dev.mvc.cate.CateProc.java
-------------------------------------------------------------------------------------
  @Override
  public List<CateVO> list_by_categrpno(int categrpno) {
    List<CateVO> list = this.cateDAO.list_by_categrpno(categrpno);
    return list;
  }
-------------------------------------------------------------------------------------
  
6. Controller ▷ dev.mvc.cate.CateCont.java 
-------------------------------------------------------------------------------------
  // http://localhost:9091/cate/list_by_categrpno.do?categrpno=1
  /**
   * 카테고리 그룹별 전체 목록
   * @return
   */
  @RequestMapping(value="/cate/list_by_categrpno.do", method=RequestMethod.GET )
  public ModelAndView list_by_categrpno(int categrpno) { // 파라미터 값 전달
    ModelAndView mav = new ModelAndView();
    
    List<CateVO> list = this.cateProc.list_by_categrpno(categrpno); // 객체 사용.
    mav.addObject("list", list); // request.setAttribute("list", list);

    mav.setViewName("/cate/list_by_categrpno"); // /cate/list_by_categrpno.jsp
    return mav;
  }
 -------------------------------------------------------------------------------------
 
★★★★★6.1
1) CateCont에 CategrpCont의 @Autowired 부분 3줄 붙여주기
-> CateCont에서 테이블 2개 접근 가능

2) list_by_categrpno method에 추가해주기 : 카테고리그룹 정보 출력(jsp에서 categrp Name을 출력하기 위함)
-------------------------------------------------------------------------------------
  @Autowired // CategrpProcInter 인터페이스를 구현한 CategrpProc.java가 할당
  @Qualifier("dev.mvc.categrp.CategrpProc") // proc에게 전송
  private CategrpProcInter categrpProc; 
  
  @Autowired
  @Qualifier("dev.mvc.cate.CateProc")
  private CateProcInter cateProc;

....
    // import + autowired하여 categrp proc 객체 사용.
    CategrpVO categrpVO = categrpProc.read(categrpno); // 카테고리 그룹 정보
    mav.addObject("categrpVO", categrpVO);
-------------------------------------------------------------------------------------


★★★★★ 7. View: JSP
1) ★★★★★ categrp/list.jsp 수정
-> 목록에 link 걸어주기.
-> 다른 테이블로 넘어갈때닌 PK -> FK로 연결
 -------------------------------------------------------------------------------------
 <TD class="td_bs_left">
      <A href="../cate/list_by_categrpno.do?categrpno=${categrpno }">${categrpVO.name }</A></TD>
 -------------------------------------------------------------------------------------

2) 목록 화면
-> <A> 태그로 앵커시 글씨 크기가 작아지는 문제
-> css 확인 : title_line 밑에 추가해주기
-------------------------------------------------------------------------------------
  /* 4월 12일 추가 앵커 태그 변경 tile_line의 link 태그 수정 */
    .title_link:link{  /* 방문전 상태 */
    font-size: 20px;   
    text-decoration: none; /* 밑줄 삭제 */
  }

  .title_link:visited{  /* 방문후 상태 */
    font-size: 20px;   
    text-decoration: none; /* 밑줄 삭제 */
  }

  .title_link:hover{  /* A 태그에 마우스가 올라간 상태 */
    font-size: 20px;   
    text-decoration: none; /* 밑줄 출력 */
  }

  .title_link:active{  /* A 태그를 클릭한 상태 */
    font-size: 20px;   
    text-decoration: none; /* 밑줄 출력 */
  }
-------------------------------------------------------------------------------------

▷ /webapp/WEB-INF/views/cate/list_by_categrpno.jsp 
-------------------------------------------------------------------------------------
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'><A href="../categrp/list.do" class='title_link'>
          카테고리 그룹</A> > ${categrpVO.name }(${categrpVO.categrpno }) </DIV>

<DIV class='content_body'>
   <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      
      <!-- value에 param(GET으로 전달받은 값을 기본 값으로 사용. ex) 여행-> 1 자동 입력 -->
      <!-- disable를 설정하여 값 설정 변경을 못하게 설정이 가능하나
       가장 큰 문제 ) 값 전달을 못함 : 무결성 제약 조건 위배
       해결) hidden type을 사용해 사용자에게 보이지않게 설정 + 실제 값 보여주기만 -> 
      -->
      <label>카테고리 그룹 번호 : </label>
       <input type='hidden' name='categrpno' value='${param.categrpno }'> <!-- 출력 용도 -->
       ${param.categrpno }&nbsp; <!--  공백한칸  -->
        
      <label>카테고리 이름</label>
      <input type='text' name='name' value='' required="required" style='width: 25%;' autofocus="autofocus">
  
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
      </FORM>
  </DIV>
  

  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 40%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 10%;'/>
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">카테고리 번호</TH>
      <TH class="th_bs">카테고리 그룹 번호</TH>
      <TH class="th_bs">카테고리 이름</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">관련 자료수</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="cateVO" items="${list}">
      <c:set var="cateno" value="${cateVO.cateno }" />
      <TR>
        <TD class="td_bs">${cateVO.cateno }</TD>
        <TD class="td_bs">${cateVO.categrpno }</TD>
        <TD class="td_bs_left">${cateVO.name }</TD>
        <TD class="td_bs">${cateVO.rdate.substring(0, 10) }</TD>
        <TD class="td_bs">${cateVO.cnt }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?cateno=${categrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?cateno=${categrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
 -------------------------------------------------------------------------------------
~~~

* **0412 : [29][Cate] Categrp + Cate join 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), 등록과 목록이 결합된 화면 제작**  
~~~
★★★★/cate/create_msg 수정 :         
<button type='button' onclick="location.href='./create.do?categrpno=${param.categrpno}'" class="btn btn-primary">새로운 카테고리 등록</button>
 <button type='button' onclick="location.href='./list_by_categrpno.do?categrpno=${param.categrpno}'" class="btn btn-primary">목록</button>
~~~

~~~
-- [29] Categrp + Cate join, 연결 목록 : name 컬럼 이름이 겹침 이를 join
-- 1) FROM절의 r과 c는 TABLE에 대한 별명
-- 2) SLEECT 절에 컬럼은 별명.컬럼명 / 겹치는 컬럼명 반드시 명시 + 별명 선언(AS)
-- 3) AS로 컬럼명 선언시 실제 컬럼명은 사용 NO.
-- 4) 부모쪽에 AS로 별병 선언 시, 자식은 별명 선언 필요 NO.
-- 5) WHERE 조건에 부모 PK(Categrpno)와 자식 FK(categrpno) 비교해 같으면 Join하여 출력
-- 6) 결합시 자식 테이블의 레코드 갯수만큼 결합(Join)이 발생
SELECT r.categrpno AS r_categrpno, r.name AS r_name,
          c.cateno, c.categrpno, c.name, c.rdate, c.cnt
FROM categrp r, cate c
WHERE r.categrpno = c.categrpno
ORDER BY cateno ASC;

(부_PK)                         (자_PK)     (자_FK)
R_CATEGRPNO R_NAME    CATENO  CATEGRPNO NAME             RDATE                      CNT
---------------- ----------------------- ---------- ---------------------------------------- ------------------
         1      영화                1           1                 SF             2021-04-12 11:28:14          0
         1      영화                 2          1             드라마            2021-04-12 11:28:14          0
         1      영화                 3          1                 로코           2021-04-12 11:28:14          0
         1      영화                 14         1             스릴러           2021-04-12 01:13:45          0
         2      여행                  15        2              경기도           2021-04-12 01:16:23          0
         3      음악                  17        3              pop              2021-04-12 02:44:00          0
         3      음악                   18       3             발라드            2021-04-12 02:48:08          0
         3      음악                   19       3             클래식            2021-04-12 02:50:52          0

▷ /src/main/resources/mybatis/cate.xml
-------------------------------------------------------------------------------------
  <select id="list_all_join" resultType="dev.mvc.cate.Categrp_CateVO">
    SELECT r.categrpno AS r_categrpno, r.name AS r_name,
                c.cateno, c.categrpno, c.name, c.rdate, c.cnt
    FROM categrp r, cate c
    WHERE r.categrpno = c.categrpno
    ORDER BY categrpno ASC, cateno ASC;
  </select>
-------------------------------------------------------------------------------------

- joinVO 선언 필요
dev.mvc.cate.Categrp_CateVO.java
-------------------------------------------------------------------------------------
public class Categrp_CateVO {
  
  // -------------------------------------------------------------------
  // Categrp table
  // -------------------------------------------------------------------
  /** 부모 테이블 카테고리 그룹 번호 */
  private int r_categrpno;
  /** 부모 테이블 카테고리 그룹 이름 */
  private String r_name;
  
  // -------------------------------------------------------------------
  // Cate table
  // -------------------------------------------------------------------  
  /** 카테고리 번호 */
  private int cateno;  
  /** 카테고리 그룹 번호 */
  private int categrpno;
  /**  카테고리 이름 */
  private String name;
  /** 등록일 */
  private String rdate;
  /** 등록된 글 수 */
  private int cnt;
  
  // getter setter
  public int getR_categrpno() {
    return r_categrpno;
  }
  public void setR_categrpno(int r_categrpno) {
    this.r_categrpno = r_categrpno;
  }
  public String getR_name() {
    return r_name;
  }
  public void setR_name(String r_name) {
    this.r_name = r_name;
  }
  public int getCateno() {
    return cateno;
  }
  public void setCateno(int cateno) {
    this.cateno = cateno;
  }
  public int getCategrpno() {
    return categrpno;
  }
  public void setCategrpno(int categrpno) {
    this.categrpno = categrpno;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  
  // toString()
  @Override
  public String toString() {
    return "[r_categrpno=" + r_categrpno + ", r_name=" + r_name + ", cateno=" + cateno + ", categrpno="
        + categrpno + ", name=" + name + ", rdate=" + rdate + ", cnt=" + cnt + "]";
  }
-------------------------------------------------------------------------------------

▷ dev.mvc.cate.CateDAOInter.java ▷ dev.mvc.cate.CateProcInter.java
-------------------------------------------------------------------------------------
  /**
   * [29][Cate] Categrp + Cate join 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), 등록과 목록이 결합된 화면 제작
   * JOIN 목록
   * @return
   */
  public List<Categrp_CateVO> list_all_join();  
-------------------------------------------------------------------------------------

▷ dev.mvc.cate.CateProc.java
-------------------------------------------------------------------------------------
  @Override
  public List<Categrp_CateVO> list_all_join() {
    List<Categrp_CateVO> list = this.cateDAO.list_all_join();
    return list;
  }
-------------------------------------------------------------------------------------

▷ dev.mvc.cate.CateCont.java 
-------------------------------------------------------------------------------------
  // http://localhost:9091/cate/list_all_join.do
  /**
   * list.all 기반 수정
   * [29][Cate] Categrp + Cate join 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), 등록과 목록이 결합된 화면 제작
   * categrp + cate join JOIN 목록
   * @return
   */
  @RequestMapping(value="/cate/list_all_join.do", method=RequestMethod.GET )
  public ModelAndView list_all_join() {
    ModelAndView mav = new ModelAndView();
    
    List<Categrp_CateVO> list = this.cateProc.list_all_join();
    mav.addObject("list", list); // request.setAttribute("list", list);

    mav.setViewName("/cate/list_all_join"); // /cate/list_all_join.jsp
    return mav;
  } 
-------------------------------------------------------------------------------------

▷ /webapp/WEB-INF/views/cate/list_all_join.jsp 
-> list_all.jsp 기반 작업
-------------------------------------------------------------------------------------
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'><A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 전체 카테고리</DIV>

<DIV class='content_body'>
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 20%;'/>
      <col style='width: 10%;'/>
      <col style='width: 20%;'/>
      <col style='width: 15%;'/>    
      <col style='width: 10%;'/>
      <col style='width: 15%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">카테고리 <BR>그룹 번호</TH>    
      <TH class="th_bs">카테고리 <BR>그룹 이름</TH>
      <TH class="th_bs">카테고리 <BR>번호</TH> 
      <TH class="th_bs">카테고리 이름</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">관련 자료수</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
      <c:forEach var="categrp_CateVO" items="${list}">
        <c:set var="r_categrpno" value="${categrp_CateVO.r_categrpno }" />
        <c:set var="r_name" value="${categrp_CateVO.r_name }" />
        <c:set var="cateno" value="${categrp_CateVO.cateno }" />
        <c:set var="name" value="${categrp_CateVO.name }" />
        <c:set var="rdate" value="${categrp_CateVO.rdate.substring(0, 10) }" />
        <c:set var="cnt" value="${categrp_CateVO.cnt }" />
      
      <TR>
        <TD class="td_bs">${r_categrpno }</TD>
        <TD class="td_bs">${r_name }</TD>
        <TD class="td_bs">${cateno }</TD>
        <TD class="td_bs_left">${name }</TD>
        <TD class="td_bs">${rdate }</TD>
        <TD class="td_bs">${cnt }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?cateno=${cateno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?cateno=${cateno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
-------------------------------------------------------------------------------------

-> list_all.jsp 수정
-------------------------------------------------------------------------------------
<A href="./read_update.do?cateno=${cateno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
<A href="./read_delete.do?cateno=${cateno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
-------------------------------------------------------------------------------------
~~~

* **0413~14 : [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )**
~~~
▷ /src/main/resources/mybatis/cate.xml
-------------------------------------------------------------------------------------
  <!-- [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
  조회, id: read, 입력: cateno, 리턴: CateVO -->
  <select id="read" resultType="dev.mvc.cate.CateVO" parameterType="int">
    SELECT cateno, categrpno, name, rdate, cnt
    FROM cate
    WHERE cateno=#{cateno}
  </select>  
  
  <!-- [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
  조회, id: read, 입력: cateno, 리턴: CateVO -->
  <update id="update" parameterType="dev.mvc.cate.CateVO">
    UPDATE cate
    SET categrpno=#{categrpno}, name=#{name}, cnt=#{cnt}
    WHERE cateno = #{cateno}
  </update>  

3. DAO interface 4. Process interface
▷ dev.mvc.cate.CateDAOInter.java ▷ dev.mvc.cate.CateProcInter.java
-------------------------------------------------------------------------------------
  /**
   *  [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
   * 조회, 수정폼
   * @param cateno 카테고리 번호, PK
   * @return
   */
  public CateVO read(int cateno);
  
  /**
   *  [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
   * 수정 처리
   * @param cateVO
   * @return
   */
  public int update(CateVO cateVO);  
-------------------------------------------------------------------------------------

5. Process class ▷ dev.mvc.cate.CateProc.java
-------------------------------------------------------------------------------------
  // [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
  @Override
  public CateVO read(int cateno) {
    CateVO cateVO = this.cateDAO.read(cateno);
    return cateVO;
  }

  // [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ )
  @Override
  public int update(CateVO cateVO) {
    int cnt = this.cateDAO.update(cateVO);
    return cnt;
  }
-------------------------------------------------------------------------------------

▷ dev.mvc.cate.CateCont.java 
-------------------------------------------------------------------------------------
  /**
   * [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ ) 
   * 조회 + 수정폼 http://localhost:9091/cate/read_update.do
   * @return
   */
  @RequestMapping(value = "/cate/read_update.do", method = RequestMethod.GET)
  public ModelAndView read_update(int cateno, int categrpno) { // 변수 2개 전달 -> 자동으로 requestgetParameter
    // int cateno = Integer.parseInt(request.getParameter("cateno")); //  자동으로 수행
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cate/read_update"); // read_update.jsp

    CateVO cateVO = this.cateProc.read(cateno);
    mav.addObject("cateVO", cateVO);  // request.setAttritube("cateVO", cateVO);

    List<CateVO> list = this.cateProc.list_by_categrpno(categrpno); // FK(categrpno)를 가지고 CateProc에서 목록가져오기
    mav.addObject("list", list);

    return mav; // forward
  }
  
  /**
   * 수정 처리
   * [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ ) 
   * @param cateVO
   * @return
   */
  @RequestMapping(value = "/cate/update.do", method = RequestMethod.POST)
  public ModelAndView update(CateVO cateVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.cateProc.update(cateVO);
    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("categrpno", cateVO.getCategrpno());
    mav.addObject("url", "/cate/update_msg");  // /cate/create_msg -> /cate/update_msg.jsp로 최종 실행됨.
    
    mav.setViewName("redirect:/cate/msg.do");
    
    return mav;
  }  
-------------------------------------------------------------------------------------

 1) ★★★list_by_categrpno와 list_all와 수정★★★ -> 변경하고 수정버튼 눌러보기.
-------------------------------------------------------------------------------------
<c:set var="categrpno" value="${cateVO.categrpno }" /> // 추가
    <A href="./read_update.do?cateno=${cateno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
     <A href="./read_delete.do?cateno=${cateno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
-------------------------------------------------------------------------------------

2) ★★★list_all_join 수정★★★ -> 변경하고 join 목록 오류 없는지 확인
-------------------------------------------------------------------------------------
 <tbody>
      <c:forEach var="categrp_CateVO" items="${list}">
        <%-- <c:set var="r_categrpno" value="${categrp_CateVO.r_categrpno }" /> --%>
        <c:set var="r_name" value="${categrp_CateVO.r_name }" />
        <c:set var="cateno" value="${categrp_CateVO.cateno }" />
        <c:set var="name" value="${categrp_CateVO.name }" />
        <c:set var="rdate" value="${categrp_CateVO.rdate.substring(0, 10) }" />
        <c:set var="cnt" value="${categrp_CateVO.cnt }" />
        <c:set var="categrpno" value="${categrp_CateVO.categrpno }" />  // 추가해주기
      
      <TR>
        <TD class="td_bs">${categrpno }</TD> // 수정
        <TD class="td_bs">${r_name }</TD>
        <TD class="td_bs">${cateno }</TD>
        <TD class="td_bs_left">${name }</TD>
        <TD class="td_bs">${rdate }</TD>
        <TD class="td_bs">${cnt }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?cateno=${cateno }&categrpno=${categrpno} " title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?cateno=${cateno }&categrpno=${categrpno} " title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
-------------------------------------------------------------------------------------

3) CateCont.java에 추가
★read_update() 내부에 추가
-> categrpVO 객체 추가해주기
-------------------------------------------------------------------------------------
CategrpVO categrpVO =  this.categrpProc.read(categrpno);
mav.addObject("categrpVO", categrpVO);  // request.setAttritube("categrpVO", categrpVO);
-------------------------------------------------------------------------------------

4) CateCont.java에 추가
★update() 내부에 변경 0414부분
-------------------------------------------------------------------------------------
 /**
   * 수정 처리
   * [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ ) 
   * @param cateVO
   * @return
   */
  @RequestMapping(value = "/cate/update.do", method = RequestMethod.POST)
  public ModelAndView update(CateVO cateVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.cateProc.update(cateVO);
    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("cateno", cateVO.getCateno());			// 0414 추가
    mav.addObject("categrpno", cateVO.getCategrpno());
    mav.addObject("name", cateVO.getName());				// 0414 추가
    mav.addObject("url", "/cate/update_msg");  // /cate/create_msg -> /cate/update_msg.jsp로 최종 실행됨.
    
    mav.setViewName("redirect:/cate/msg.do"); // 새로고침 문제해결, request 초기화
    
    return mav;
  }  

▷ /webapp/cate/read_update.jsp   
등록폼에서 FK 컬럼인 categrpno 컬럼의 값을 <input type='hidden' ...> 태그로 전달
 ★★★★★list_by_categrpno를 복사하여 변경★★★★★
-------------------------------------------------------------------------------------
<%-- 
0414
7. View: JSP
- 등록폼에서 FK 컬럼인 categrpno 컬럼의 값을 <input type='hidden' ...> 태그로
  전달해야합니다.
1) 입력 화면
▷ /webapp/cate/read_update.jsp 
 ★★★★★list_by_categrpno를 복사★★★★★
--%>
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
    
<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>
  <A href="../categrp/list.do" class='title_link'> 카테고리 그룹</A> >
   <A href="./list_by_categrpno.do?categrpno=${param.categrpno }" class='title_link'>${categrpVO.name }</A> >
    (${cateVO.name }) 수정</DIV>

<DIV class='content_body'>
   <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./update.do'>   <!--  read_update 수정 필요!! -->
      
      <!-- value에 param(GET으로 전달받은 값을 기본 값으로 사용. ex) 여행-> 1 자동 입력 -->
      <!-- disable를 설정하여 값 설정 변경을 못하게 설정이 가능하나
       가장 큰 문제 ) 값 전달을 못함 : 무결성 제약 조건 위배
       해결) hidden type을 사용해 사용자에게 보이지않게 설정 + 실제 값 보여주기만 -> 
      -->
      <!-- 0414 PKKey 받아와야지 가능 -->
      <input type="hidden" name="cateno" value='${param.cateno }'>
      
      <label>카테고리 그룹 번호 : </label>
       <input type='number' name='categrpno' value='${param.categrpno }' required="required" 
                  min="1" max="100" step="1" autofocus="autofocus"><BR> 
        
      <label>카테고리 이름</label>
      <input type='text' name='name' value='${cateVO.name }' required="required" 
                  style='width: 25%;'><BR> 
      
      <label>등록 자료수</label>
      <input type='text' name='cnt' value='${cateVO.cnt }' required="required" 
                  min="0" max="10000000" step="1"><BR> 
  
      <button type="submit" id='submit'>수정</button>
      <button type="button" onclick="history.back();">취소</button> <!-- JAVAScript로 이전페이지로 -->
      </FORM>
  </DIV>
  

  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 40%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 10%;'/>
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">카테고리 번호</TH>
      <TH class="th_bs">카테고리 그룹 번호</TH>
      <TH class="th_bs">카테고리 이름</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">관련 자료수</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="cateVO" items="${list}">
      <c:set var="cateno" value="${cateVO.cateno }" />
      <TR>
        <TD class="td_bs">${cateVO.cateno }</TD>
        <TD class="td_bs">${cateVO.categrpno }</TD>
        <TD class="td_bs_left">${cateVO.name }</TD>
        <TD class="td_bs">${cateVO.rdate.substring(0, 10) }</TD>
        <TD class="td_bs">${cateVO.cnt }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?cateno=${categrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?cateno=${categrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>

</html>
-------------------------------------------------------------------------------------

2. 메시지 출력 ▷ /webapp/cate/update_msg.jsp 
 ★★★★★create_msg.jsp를 복사★★★★★
-------------------------------------------------------------------------------------
<%-- 
0413
2. 메시지 출력
▷ /webapp/views/cate/create_msg.jsp 기반 수정
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
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.cnt == 1}">
          <LI class='li_none'>
            <span class="span_success">카테고리『${param.name }』를 수정했습니다.</span>
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">카테고리『${param.name }』수정에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
       <button type='button' onclick="location.href='./read_update.do?cateno=${param.cateno}&categrpno=${param.categrpno}'" class="btn btn-primary"> 카테고리 재수정</button>
        <button type='button' onclick="location.href='./list_by_categrpno.do?categrpno=${param.categrpno}'" class="btn btn-primary">목록</button>
      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>

~~~