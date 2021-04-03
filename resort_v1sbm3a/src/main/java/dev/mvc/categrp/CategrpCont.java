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
 
 
  //http://localhost:9091/categrp/create.do
  /**
   * 등록 처리
   * @param categrpVO
   * @return
   */
 @RequestMapping(value="/categrp/create.do", method=RequestMethod.POST)
  public ModelAndView create(CategrpVO categrpVO) { // categrpVO 자동생성 Form -> VO 클래스로 자동저장
  // CategrpVO categrpVO <FORM> 태그의 값으로 자동 생성됨.
  // request.setAttribute("categrpVO", categrpVO); 자동 실행
    
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.categrpProc.create(categrpVO); // 등록 처리(인터페이스 호출, 클래스를 할당받았었음)
    mav.addObject("cnt", cnt); // request에 저장, request.setAttribute("cnt", cnt)  
    mav.setViewName("/categrp/create_msg"); // /webapp/WEB-INF/views/categrp/create_msg.jsp
    return mav; // forward
  }
 
}
