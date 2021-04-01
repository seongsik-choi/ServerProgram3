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
public class CategrpProc implements CategrpProcInter {

  @Override
  public int create(CategrpVO categrpVO) {
    // TODO Auto-generated method stub
    return 0;
  }

}
