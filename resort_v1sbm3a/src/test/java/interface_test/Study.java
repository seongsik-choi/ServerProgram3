package interface_test;

public class Study implements InterfaceStudy{
 
  @Override
  public void studyRegister(String name, int age, String area) {        
      System.out.println("등록 중입니다...");
      System.out.println("이름 : "  +name);
      System.out.println("나이 : "  +age);
      System.out.println("거주지역 : "  +area);
  }
  
  @Override
  public void studyExercise() {        // Alt + Shift + enter로 생성된 메소드를 구현 필요
      System.out.println("--운동 모임방이 개설되어습니다.--");   
  }
  
  @Override
  public void studyToeic() {        
      System.out.println("-- 토익 모임방이 개설되었습니다.--");   
  }
  
  @Override
  public void studyCook() {        
      System.out.println("--요리 모임방이 개설되었습니다.--");   
  }
  
  @Override
  public void studyCertificate() {        
      System.out.println("--자격증 모임방이 개설되었습니다.--");   
  }
  
}
