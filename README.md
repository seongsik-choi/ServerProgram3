# 2) 서버 프로그래밍3 (구현) : Spring Boot
## STS4(Spring Tool Suite4) Tree Structure  
  C:/dic/WS_FRAME/start  
  **package 명 : dev.boot.start**  
├─bin/main/dev/boot  
│               └─start    <-- JAVA class 실행: 내장 톰캣이 실행되어 동일하게 작동  
├─build.gradle	 <--  gradle build 명세, 프로젝트에 필요한 라이브러리 정의, 빌드 및 배포 설정, 스프링 부트의 버전을 명시, 자바 버전 명시, 의존성 옵션  
│  
├─Project and External Dependencies	<-- gradle에 명시한 라이브러리 목록  
├─src    <--  JSP등 리소스 디렉토리  
│  └─/main/java  <-- 자바 소스 폴더  
│  └─/main/java/dev.boot.start.StartApplication.java  <-- main 메소드가 존재하는 자바 class(구성과 최초 실행)  
│  └─/main/resources/static	<-- Image, CSS, Javascript등 정적 파일들 저장  
│  └─/main/resources/application.properties  <-- 환경 설정에 사용할 properties 정의  
└─WebContent       <-- Web Service를 위한 dic  

* **0326 : [01] STS 4.5.1(Spring Tool Suite) 설치(STS 4.6.0 권장) -> 이미 설치**  
* **0326 : [02] Spring Boot 프로젝트 생성**  
  * ▶ [01] Spring Boot 프로젝트 생성  
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
  * e. 프로젝트가 생성 : start/src/main/java/dev.boot.start.StartApplication.java  
---
* **0329 : [02]문자열 출력, 프로젝트 구조(project: start)**  

