package dev.mvc.categr;

import java.util.ArrayList;
import java.util.List;
import dev.mvc.categrp.CategrpVO;

public class TestCategrpDAO {
  public static void main(String[] args) {
    // 인터페이스 구현하는 방법
    // List<CategrpVO> list = new List<CategrpVo>(); // 객체 생성 불가능
    List<CategrpVO> list = new ArrayList<CategrpVO>(); // 객체 생성 가능
    
    // 객체 생성후 초기화까지만.
    CategrpVO categrpvo = null;
    
    // 객체 생성후 List에 추가하기
    categrpvo = new CategrpVO(1, "Spring", 1, "Y", "2021-04-06");
    list.add(categrpvo); 
    System.out.println(categrpvo.hashCode()); //1829164700
    
    // 이미 만들어진 객체에 두번째 List 추가.
    // 메모리에 categrpvo 객체가 덮어씌어지는게 아닌, 각기 다른 메모리 영역에 list 값 할당
    categrpvo = new CategrpVO(2, "Summer", 2, "N", "2021-04-07");
    list.add(categrpvo); 
    System.out.println(categrpvo.hashCode()); //2018699554
    categrpvo = new CategrpVO(3, "Fall", 3, "Y", "2021-04-08");
    list.add(categrpvo); 
    System.out.println(categrpvo.hashCode()); // 1311053135
    categrpvo = new CategrpVO(4, "Winter", 4, "N", "2021-04-09");
    list.add(categrpvo); 
    System.out.println(categrpvo.hashCode()); // 118352462
   
    System.out.println(list.size());
    
    // 값을 가져오기
    // VO클래스에서 toString() 선언, 호출만으로 출력가능.
    for(int i=0; i<list.size(); i++) {
      categrpvo = list.get(i); 
      System.out.println(categrpvo.toString());
    }// for end
    
    // 다른 유형의 for문 
    for(CategrpVO categrpvo2: list) {
      System.out.println(categrpvo2.toString());
    }
    
  }
}
