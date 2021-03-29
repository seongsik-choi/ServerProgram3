package dev.boot.start;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController       // Controller 중 JSP 없이 단순 출력(ex.JSON 출력)
public class HelloCont {
  @RequestMapping("/")  // 
  public String hello() { // ModelAndView Return 타입이 아닌 일반 자료형 Return.
    return "안녕 하세요. Spring Boot 입니다 :D ";
  }// hello() end
}// class end