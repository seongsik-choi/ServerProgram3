/*
0405
5. enum 열거형을 이용한 코드의 처리
- 코드표가 항목이 가변적인 경우는 DBMS table에 저장
- 코드가 가변적이 아닌경우는 열거형을 사용 할 수 있음
- 열거형은 Elcipse에서 assist가 지원되어 오타등이 체크
 ▷ /sts_basic/src/dev.mvc.pay.Pay.java
 */
package dev.mvc.pay;
public enum Pay {
  주문,
  배송,
  결재,
  반품,
  환불,
  기타
}