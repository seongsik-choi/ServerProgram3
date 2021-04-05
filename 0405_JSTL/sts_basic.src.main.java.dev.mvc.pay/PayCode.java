/*
0405_Pay.java 이어서
▷ /sts_basic/src/dev.mvc.pay.PayCode.java
- 값을 변경 할 수 없도록 setter를 만들지 않음
 */
package dev.mvc.pay;

public class PayCode {
  private Pay pay;
  private String value;
  
  public PayCode(Pay pay, String value) {
    this.pay = pay;
    this.value = value;
  }

  public Pay getPay() {
    return pay;
  }

  public String getValue() {
    return value;
  }
  
}