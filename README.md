# 3) 서버 프로그래밍3 (구현) : Spring Boot
## STS4(Spring Tool Suite4) Tree Structure  
  **C:/dic/WS_FRAME/start**    
  **package 명 : dev.boot.start**  
├─bin/main/dev/boot  
│               └─start    <-- JAVA class 실행: 내장 톰캣이 실행되어 동일하게 작동  
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