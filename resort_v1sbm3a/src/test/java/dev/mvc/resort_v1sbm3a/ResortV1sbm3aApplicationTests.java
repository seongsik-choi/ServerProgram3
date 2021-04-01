package dev.mvc.resort_v1sbm3a;

import org.junit.jupiter.api.Test;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class ResortV1sbm3aApplicationTests {

  @Autowired
  private SqlSessionTemplate sqlSession;
  
  @Test
  public void contextLoads() {
  }

  @Test
  public void testSqlSession() throws Exception{
    System.out.println(sqlSession.toString());
  }

}
