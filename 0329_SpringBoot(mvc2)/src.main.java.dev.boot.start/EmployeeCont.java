/*
0329
9. Controller class 제작
▷ /src/main/java/dev.boot.basic/EmployeeCont.java
- http://localhost:9091/employee/employee.do
 */
package dev.boot.basic;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EmployeeCont {
  public EmployeeCont() {
    System.out.println("--> EmployeeCont created.");
  }
  
  // Legacy 다르게 프로젝트명 사용 No, @RequestMapping에 명시한 대로 사용
  // http://localhost:9091/employee/employee.do
  @RequestMapping(value="/employee/employee.do", method=RequestMethod.GET )
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    
    // 객체 생성
    EmployeeVO employeeVO  = new EmployeeVO();
    // sungjukVO.name = "주지훈"; // The field SungjukVO.name is not visible
    
    // EmployeeVO.java의 setter 호출
    employeeVO.setName("주지훈");
    employeeVO.setTot(300);
    employeeVO.setAvg(100);
    
    // request.setAttritube("employeeVO", employeeVO);
    mav.addObject("employeeVO", employeeVO);
    
    // /src/main/webapp/WEB-INF/views/employee/employee.jsp
    
    /* application.properties의
     spring.mvc.view.prefix=/WEB-INF/views/ 와
     mav.setViewName("/employee/employee"); 가 조합
     /WEB-INF/views/employee/employee의 경로완성
     */
    mav.setViewName("/employee/employee");
    
    return mav;
  }
}