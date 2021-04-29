/*
0401(CREATE) + 0406(LIST) + 0407(READ, DELETE) + 0408(UPDATE)
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
 */
package dev.mvc.categrp;
import java.util.List;

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

  @Override
  public List<CategrpVO> list_categrpno_asc() {
    // TODO Auto-generated method stub
    List<CategrpVO> list = null;
    list = this.categrpDAO.list_categrpno_asc();
    return list;
  }
  
  @Override
  public List<CategrpVO> list_seqno_asc() {
    List<CategrpVO> list = null;
    list = this.categrpDAO.list_seqno_asc();
    return list;
  }
  
  @Override
  public CategrpVO read(int categrpno) {
    CategrpVO categrpVO = null;
    categrpVO = this.categrpDAO.read(categrpno);
    
    return categrpVO;
  }  

  @Override
  public int update(CategrpVO categrpVO) {
    int cnt = 0;
    cnt = this.categrpDAO.update(categrpVO);
    
    return cnt;
  }  
 
  @Override
  public int delete(int categrpno) {
    int cnt = 0;
    cnt = this.categrpDAO.delete(categrpno);
    
    return cnt;
  }
  
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
 
}
