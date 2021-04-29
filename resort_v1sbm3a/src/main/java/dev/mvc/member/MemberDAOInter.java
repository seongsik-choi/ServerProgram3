package dev.mvc.member;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MemberDAOInter {
  /**
   * [53][Member] 중복 ID 체크(DAO interface, DAO class, Processs interface, Process class)
   * 중복 아이디 검사
   * @param id
   * @return 중복 아이디 갯수
   */
  public int checkID(String id);
  
}
  