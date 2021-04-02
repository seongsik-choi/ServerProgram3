/*
0401  + 0402
6. Controller class
- 실행 주소의 조합
  http://localhost:9090/blog/categrp/create.jsp 
  → http://localhost:9090/blog/categrp/create.do

-> 호출 규칙
 Controller -> Proc -> DAO(자동화) -> MyBatis -> SQL

▷ dev.mvc.categrp.CategrpCont.java
 */
package dev.mvc.categrp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CategrpCont {
 @Autowired // CategrpProcInter 인터페이스를 구현한 CategrpProc.java가 할당
 @Qualifier("dev.mvc.categrp.CategrpProc") // proc에게 전송
 private CategrpProcInter categrpProc; 
 
 public CategrpCont() {
   System.out.println(" -> CategrpCont created.");
 }
 
 
 // http://localhost:9091/categrp/create.do
 /**
  * 등록 폼
  * @return
  */
 @RequestMapping(value="/categrp/create.do", method=RequestMethod.GET)
 public ModelAndView create() {
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/categrp/create"); // webapp/WEB-INF/views/categrp/create.jsp
   
   return mav; // forward
 }
 
 
}
