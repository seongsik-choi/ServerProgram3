/*
0401(CREATE) + 0406(LIST) + 0407(READ, DELETE) + 0408(UPDATE)
6. Controller class
- 실행 주소의 조합
  http://localhost:9090/blog/categrp/create.jsp 
  → http://localhost:9090/blog/categrp/create.do

-> 호출 규칙
 Controller -> Proc -> DAO(자동화) -> MyBatis -> SQL

▷ dev.mvc.categrp.CategrpCont.java
 */
package dev.mvc.categrp;
import java.util.List;

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
    
    List<CategrpVO> list = this.categrpProc.list_categrpno_asc(); // 목록을 다시 가져옴.
    mav.addObject("list", list);  // request 객체에 저장

    mav.setViewName("/categrp/read_update"); // /webapp/WEB-INF/views/categrp/read_update.jsp 
    return mav; // forward
  }  

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
  
  // http://localhost:9091/categrp/read_delete.do
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
    
    List<CategrpVO> list = this.categrpProc.list_categrpno_asc();
    mav.addObject("list", list);  // request 객체에 저장

    mav.setViewName("/categrp/read_delete"); // read_delete.jsp
    return mav;
  }  

  // http://localhost:9091/categrp/delete.do
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
  
  /**
   * 출력 모드의 변경[23]
   * @param categrpVO
   * @return
   */
  @RequestMapping(value="/categrp/update_visible.do", 
      method=RequestMethod.GET )
  public ModelAndView update_visible(CategrpVO categrpVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.categrpProc.update_visible(categrpVO);
    
    mav.setViewName("redirect:/categrp/list.do"); // request 객체 전달 안됨.(redirect)
    return mav;
  }    
 
   
}
