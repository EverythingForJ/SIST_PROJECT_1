Rem Date : 2020�� 10�� 2��
Rem Author : ����ȯ
Rem Objective : 1�� ������Ʈ
Rem Environment : Windows 10, Oracle SQL Developer, Oracle Database 19c Enterprise Ed.

-- 1�� ������Ʈ ���� ���� ����
CREATE USER HAPPY
IDENTIFIED BY HAPPY
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

-- ���Ѿ��� ���̺���� �ο�
ALTER USER HAPPY DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- ���� ����, ���̺� ���� ���� �ο�
GRANT CREATE SESSION, RESOURCE, CREATE TABLE TO HAPPY;

--ȸ�� ���̺� ����
CREATE TABLE GUEST(
    guest_id    VARCHAR2(20),                                             -- ȸ�� ���̵�, �����Է� ǥ��
    guest_pw    VARCHAR2(15) CONSTRAINT GUEST_GUEST_PW_NN NOT NULL,       -- ȸ�� ��й�ȣ, �����Է� ǥ��
    guest_name  VARCHAR2(20) CONSTRAINT GUEST_GUEST_NAME_NN NOT NULL,     -- ȸ�� �̸�, �ѱ� �ִ� 6����
    CONSTRAINT GUEST_GUEST_ID_PK PRIMARY KEY(guest_id)
);

--��ǰ ���̺� ����
CREATE TABLE MEDICINE(
    medi_number NUMBER(4),                                              --��ǰ ��ȣ, ���� 4�ڸ�
    medi_name   VARCHAR2(50) CONSTRAINT MEDICINE_MEDI_NAME_NN NOT NULL, --��ǰ �̸�, �ѱ��ִ� 16��
    ex_date     Date         CONSTRAINT MEDICINE_EX_DATE_NN NOT NULL,   --��ǰ ��ȿ�Ⱓ: 2020-05-23 -- ��ǰ ��ȿ�Ⱓ�� �����ϸ��� �ٸ��Ƿ� ����Ⱓ ��� �̷��� ����°� ������, ��ǰ���̺��� ���� �����ϴ°Ծƴ�
    cautions    VARCHAR2(500),                                          --���ǻ���
    CONSTRAINT MEDICINE_MEDI_NUMBER_PK PRIMARY KEY(medi_number)
);

--ȸ�� ��ǰ ���̺� ����
CREATE TABLE GUESTMEDI( 
   guestMedi_num        NUMBER(4),                                                  --ȸ�� ��ǰ ��ȣ, ���� 4�ڸ�
   guest_id             VARCHAR2(20) CONSTRAINT GUESTMEDI_GUEST_ID_NN NOT NULL,         --ȸ�� ���̵�
   medi_number          NUMBER(4)    CONSTRAINT GUESTMEDI_MEDI_NUMBER_NN NOT NULL,     --��ǰ ��ȣ
   quantity             NUMBER(4),                                                  --��ǰ ���� -- ���� ����� ȸ�ǵƾ���
   CONSTRAINT  GUESTMEDI_GUESTMEDI_NUM_PK PRIMARY KEY(guestMedi_num),    
   CONSTRAINT  GUESTMEDI_GUEST_ID_FK FOREIGN KEY(guest_id) REFERENCES guest(guest_id), 
   CONSTRAINT  GUESTMEDI_MEDI_NUMBER_FK FOREIGN KEY(medi_number) REFERENCES Medicine(medi_number)
);

INSERT INTO Medicine 
VALUES(0001, '�Ժ���', '2021-05-28', '�Ժ����� Ŀ�Ƕ� ���� ������ �����մϴ�.');

INSERT INTO Medicine 
VALUES(0002, 'Ÿ�̷���', '2021-07-28', 'Ÿ�̷����� Ŀ�Ƕ� ���� ������ �����մϴ�.');

INSERT INTO Medicine 
VALUES(0003, 'Ÿ�̷��� ��̿�', '2021-07-28', '11�� ���� ��̴� Ÿ�̷����� �ƴ϶� ���̷��� ��̸� �����ϼ���.');

COMMIT;
