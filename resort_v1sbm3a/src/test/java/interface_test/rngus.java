package interface_test;

class Parent { 
  String className = "Parent Class"; 
  
  public Parent() {
    System.out.println("부모 생성자");
  }
  
  public Parent(String name) {
    System.out.println("부모 이름은 : " + name );
  }
  
  public int info() { 
      System.out.println( className );   
      return 0;
  } 
}


 class Child extends Parent { 
  String className = "Child Class"; 
  
  public Child() {
    System.out.println("자식 생성자");
  }
  
  public Child(String name) {
    System.out.println("자식 이름은 : " + name );
  }
  
  public int info() {      
      System.out.println( className );   
      return 0;
}
 }
public class rngus {
  public static void main(String[] args) {
    
    Child cccc = new Child("최성식");
    
    System.out.println();
    
    Child c = new Child();        
    c.info();            System.out.println();           
    
    Parent cc = new Child(); System.out.println();
    Parent ccc = new Child("최성식");       
    System.out.println();
    
    cc.info();
  }
  
}
