/**********************************/
/* Table Name: 관리자 */
/**********************************/
DROP TABLE admin;

CREATE TABLE admin(
    adminno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    id                                VARCHAR2(20)     NOT NULL
);
COMMENT ON TABLE admin is '관리자';
COMMENT ON COLUMN admin.adminno is '관리자 번호';
COMMENT ON COLUMN admin.id is '아이디';

-- admin의 SEQUENCE Table(ORACLE 기준)
DROP SEQUENCE admin_seq;

CREATE SEQUENCE admin_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

-- (부모)admin 레코드 삽입후 (자식)contents 레코드 생성 가능  
INSERT INTO admin(adminno, id)
VALUES(admin_seq.nextval, 'admin');

INSERT INTO admin(adminno, id)
VALUES(admin_seq.nextval, 'admin2');

INSERT INTO admin(adminno, id)
VALUES(admin_seq.nextval, 'admin3');

commit;

SELECT adminno, id FROM admin ORDER BY adminno ASC;  