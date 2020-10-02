Rem Date : 2020년 10월 2일
Rem Author : 김준환
Rem Objective : 1차 프로젝트
Rem Environment : Windows 10, Oracle SQL Developer, Oracle Database 19c Enterprise Ed.

-- 1차 프로젝트 전용 계정 생성
CREATE USER HAPPY
IDENTIFIED BY HAPPY
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

-- 제한없는 테이블공간 부여
ALTER USER HAPPY DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- 접속 권한, 테이블 생성 권한 부여
GRANT CREATE SESSION, RESOURCE, CREATE TABLE TO HAPPY;

--회원 테이블 생성
CREATE TABLE GUEST(
    guest_id    VARCHAR2(20),                                             -- 회원 아이디, 영문입력 표준
    guest_pw    VARCHAR2(15) CONSTRAINT GUEST_GUEST_PW_NN NOT NULL,       -- 회원 비밀번호, 영문입력 표준
    guest_name  VARCHAR2(20) CONSTRAINT GUEST_GUEST_NAME_NN NOT NULL,     -- 회원 이름, 한글 최대 6글자
    CONSTRAINT GUEST_GUEST_ID_PK PRIMARY KEY(guest_id)
);

--약품 테이블 생성
CREATE TABLE MEDICINE(
    medi_number NUMBER(4),                                              --약품 번호, 정수 4자리
    medi_name   VARCHAR2(50) CONSTRAINT MEDICINE_MEDI_NAME_NN NOT NULL, --약품 이름, 한글최대 16자
    ex_date     Date         CONSTRAINT MEDICINE_EX_DATE_NN NOT NULL,   --약품 유효기간: 2020-05-23 -- 약품 유효기간은 구입일마다 다르므로 유통기간 몇달 이렇게 만드는게 나을듯, 약품테이블은 내가 수정하는게아님
    cautions    VARCHAR2(500),                                          --주의사항
    CONSTRAINT MEDICINE_MEDI_NUMBER_PK PRIMARY KEY(medi_number)
);

--회원 약품 테이블 생성
CREATE TABLE GUESTMEDI( 
   guestMedi_num        NUMBER(4),                                                  --회원 약품 번호, 정수 4자리
   guest_id             VARCHAR2(20) CONSTRAINT GUESTMEDI_GUEST_ID_NN NOT NULL,         --회원 아이디
   medi_number          NUMBER(4)    CONSTRAINT GUESTMEDI_MEDI_NUMBER_NN NOT NULL,     --약품 번호
   quantity             NUMBER(4),                                                  --약품 수량 -- 수량 빼기로 회의됐었음
   CONSTRAINT  GUESTMEDI_GUESTMEDI_NUM_PK PRIMARY KEY(guestMedi_num),    
   CONSTRAINT  GUESTMEDI_GUEST_ID_FK FOREIGN KEY(guest_id) REFERENCES guest(guest_id), 
   CONSTRAINT  GUESTMEDI_MEDI_NUMBER_FK FOREIGN KEY(medi_number) REFERENCES Medicine(medi_number)
);

INSERT INTO Medicine 
VALUES(0001, '게보린', '2021-05-28', '게보린은 커피랑 같이 먹으면 위험합니다.');

INSERT INTO Medicine 
VALUES(0002, '타이레놀', '2021-07-28', '타이레놀은 커피랑 같이 먹으면 위험합니다.');

INSERT INTO Medicine 
VALUES(0003, '타이레놀 어린이용', '2021-07-28', '11세 이하 어린이는 타이레놀이 아니라 테이레놀 어린이를 복용하세요.');

COMMIT;
