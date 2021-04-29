/*
Controller
  - @Autowired: 자동으로 구현빈을 연결
  - @Qualifier("dev.mvc.cagtegory.CagteProc"): 같은 이름의 클래스가 존재하면
        생성되는 클래스에 이름을 부여하고 구분해서 객체를 할당받음.
 */
package dev.mvc.cate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;

@Controller
public class CateCont {
  
  @Autowired // CategrpProcInter 인터페이스를 구현한 CategrpProc.java가 할당
  @Qualifier("dev.mvc.categrp.CategrpProc") // proc에게 전송
  private CategrpProcInter categrpProc; 
  
  @Autowired
  @Qualifier("dev.mvc.cate.CateProc")
  private CateProcInter cateProc;
  
  public CateCont() {
    System.out.println("-> CateCont created.");
  }
  
  /**
   * [26][Cate] Cate 등록 기능 제작(INSERT ~ INTO ~ VALUES ~)
   * 새로고침 방지
   * @return
   */
  @RequestMapping(value="/cate/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();
    mav.setViewName(url); // forward
    return mav; // forward
  }
  
  /**
   * [26][Cate] Cate 등록 기능 제작(INSERT ~ INTO ~ VALUES ~)
   * 등록폼 http://localhost:9091/cate/create.do?categrpno=1
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
   * [26][Cate] Cate 등록 기능 제작(INSERT ~ INTO ~ VALUES ~)
   * 등록처리
   * http://localhost:9091/cate/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/cate/create.do", method = RequestMethod.POST)
  public ModelAndView create(CateVO cateVO) {
    ModelAndView mav = new ModelAndView();

    System.out.println("-> categrpno: " + cateVO.getCategrpno());
    
    int cnt = this.cateProc.create(cateVO);
    mav.addObject("cnt", cnt);
    mav.addObject("categrpno", cateVO.getCategrpno());
    
    mav.addObject("name", cateVO.getName());  // 2) redirert 해도 name 객체를 출력하기 위한 방법, 추가해주기
    
    mav.addObject("url", "/cate/create_msg");  // /cate/create_msg -> /cate/create_msg.jsp
    
    mav.setViewName("redirect:/cate/msg.do"); // 1) redirect시 객체 사라짐, msg에서 param.name은 전달 못받음
    // response.sendRedirect("/cate/msg.do");
    
    return mav;
  }
  
  // http://localhost:9091/cate/list_all.do
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
  
  // http://localhost:9091/cate/list_by_categrpno.do?categrpno=1
  /**
   * [28][Cate] categrpno별 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~), 등록과 목록이 결합된 화면 제작 
   * 카테고리 그룹별 전체 목록
   * @return
   */
  @RequestMapping(value="/cate/list_by_categrpno.do", method=RequestMethod.GET )
  public ModelAndView list_by_categrpno(int categrpno) { // 파라미터 값 전달
    ModelAndView mav = new ModelAndView();
    
    List<CateVO> list = this.cateProc.list_by_categrpno(categrpno); // 객체 사용.
    mav.addObject("list", list); // request.setAttribute("list", list);
    
    // import + autowired하여 categrp proc 객체 사용.
    CategrpVO categrpVO = categrpProc.read(categrpno); // 카테고리 그룹 정보
    mav.addObject("categrpVO", categrpVO);
    
    mav.setViewName("/cate/list_by_categrpno"); // /cate/list_by_categrpno.jsp
    return mav;
  }
  
  // http://localhost:9091/cate/list_all_join.do
  /**
   * list.all 기반 수정
   * [29][Cate] Categrp + Cate join 목록 출력 기능 제작(SELECT ~ FROM ~ ORDER BY ~),  Categrp_CateVO.java 사용
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
  
  /**
   * [30][Cate] Cate 조회 + 수정폼, 수정 처리 기능의 제작(UPDATE ~ SET ~ WHERE ~ ) 
   * 조회 + 수정폼 http://localhost:9091/cate/read_update.do
   * @return
   */
  @RequestMapping(value = "/cate/read_update.do", method = RequestMethod.GET)
  public ModelAndView read_update(int cateno, int categrpno) { // 변수 2개 전달 -> 자동으로 requestgetParameter
    // int cateno = Integer.parseInt(request.getParameter("cateno")); //  자동으로 수행
    // int categrpno = Integer.parseInt(request.getParameter("categrpno")); //  자동으로 수행
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cate/read_update"); // read_update.jsp

    CategrpVO categrpVO =  this.categrpProc.read(categrpno);
    mav.addObject("categrpVO", categrpVO);  // request.setAttritube("categrpVO", categrpVO);
    
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
    mav.addObject("cateno", cateVO.getCateno()); // 0414 추가
    mav.addObject("categrpno", cateVO.getCategrpno());
    mav.addObject("name", cateVO.getName()); // 0414 추가
    mav.addObject("url", "/cate/update_msg");  // /cate/create_msg -> /cate/update_msg.jsp로 최종 실행됨.
    
    mav.setViewName("redirect:/cate/msg.do"); // 새로고침 문제해결, request 초기화
    
    return mav;
  }  
  
  /**
   * [31][Cate] Cate 삭제 기능의 제작(DELETE ~ WHERE)~
   * 조회 + 삭제폼(조회 + 수정폼 기반)
   * http://localhost:9091/cate/read_delete.do
   * @return
   */
  @RequestMapping(value = "/cate/read_delete.do", method = RequestMethod.GET)
  public ModelAndView read_delete(int cateno, int categrpno) { // 변수 2개 전달 -> 자동으로 requestgetParameter
    // int cateno = Integer.parseInt(request.getParameter("cateno")); //  자동으로 수행
    // int categrpno = Integer.parseInt(request.getParameter("categrpno")); //  자동으로 수행
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cate/read_delete"); // read_delete.jsp

    CategrpVO categrpVO =  this.categrpProc.read(categrpno);
    mav.addObject("categrpVO", categrpVO);  // request.setAttritube("categrpVO", categrpVO);
    
    CateVO cateVO = this.cateProc.read(cateno);
    mav.addObject("cateVO", cateVO);  // request.setAttritube("cateVO", cateVO);

    List<CateVO> list = this.cateProc.list_by_categrpno(categrpno); // FK(categrpno)를 가지고 CateProc에서 목록가져오기
    mav.addObject("list", list);

    return mav; // forward
  }  
  
  /**
   * 삭제처리(수정처리 기반)
   * [31][Cate] Cate 삭제 기능의 제작(DELETE ~ WHERE)~
   * @param cateVO
   * @return
   */
  @RequestMapping(value = "/cate/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int cateno, int categrpno) {
    ModelAndView mav = new ModelAndView();
    
 // 삭제될 레코드 정보를 삭제하기전에 읽음.
    CateVO cateVO = this.cateProc.read(cateno); 
    
    int cnt = this.cateProc.delete(cateno);
    
    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("cateno", cateVO.getCateno()); // 0414 추가
    mav.addObject("categrpno", cateVO.getCategrpno());
    mav.addObject("name", cateVO.getName()); // 0414 추가
    mav.addObject("url", "/cate/delete_msg");  // /cate/delete_msg.jsp로 최종 실행됨.
    
    mav.setViewName("redirect:/cate/msg.do"); // 새로고침 문제해결, request 초기화
    
    return mav;
  }    
  
   
}