/*
0405_PayCode.java의 ArrayList 구현
▷ /sts_basic/src/dev.mvc.pay.CodeTable.java 테스트
// 객체 생성없이 사용가능(static) / synchronized(다중접속)
 */
package dev.mvc.pay;
import java.util.ArrayList;

public class CodeTable {
  public static synchronized ArrayList<PayCode> getPayCode(){ 
    ArrayList<PayCode> list = new ArrayList<PayCode>();
    list.add(new PayCode(Pay.주문, "A01"));
    list.add(new PayCode(Pay.배송, "A02"));
    list.add(new PayCode(Pay.결재, "A03"));
    list.add(new PayCode(Pay.반품, "A04"));
    list.add(new PayCode(Pay.환불, "A05"));
    list.add(new PayCode(Pay.기타, "A99"));
    
    return list;
  }
  
  public static void main(String args[]) {
    Pay pay = Pay.결재; // 객체 생성없이 사용가능(static)
    System.out.println(pay);    // 결재
    System.out.println(pay.ordinal()); // 값 index 출력
    System.out.println(Pay.주문.ordinal()); // 0
    
    pay = Pay.주문;
    if (pay == Pay.주문) {
      System.out.println("주문이 접수되었습니다.");
    }
  }
  
}