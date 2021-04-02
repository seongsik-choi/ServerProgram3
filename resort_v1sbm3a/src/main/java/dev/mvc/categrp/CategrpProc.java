/*
0401
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
