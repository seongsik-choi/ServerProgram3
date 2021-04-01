package interface_test;
public class Test {

  public static void main(String[] args) {
    InterfaceStudy is = new Study();  // 인터페이스name 객체 = new implementname(); 
 
   is.studyRegister("최성식", 26, "경기도 일산"); // 등록
   is.studyExercise(); // implement에서 재정의된 메소드 
   is.studyToeic();
   is.studyCook(); 
   is.studyCertificate();
  }
}
