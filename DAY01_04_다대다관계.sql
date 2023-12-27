/*
    다대다 관계(M:N 관계)
    1. 2개의 테이블을 직접 관계짓는 것은 불가능하다.
    2. 다대다 관계를 가지는 2개의 테이블과 연결될 중간 테이블이 필요하다.
    3. 일대다 관계를 2개 만들면 다대다 관계가 된다. 
*/

-- 학생 테이블 
CREATE TABLE STUDENT_T (
    STUDENT_NO      NUMBER              NOT NULL PRIMARY KEY, -- 학번(PK)     
    STUDENT_NAME    VARCHAR2(100 BYTE)  NOT NULL, -- 성명         
    STUDENT_GRADE   NUMBER              NOT NULL, -- 학년         
    STUDENT_CLASS   NUMBER              NOT NULL, -- 반          
    STUDNET_NUMBER  NUMBER              NOT NULL -- 번호        
);

-- 과목 테이블 
CREATE TABLE SUBJECT_T (
    SUBJECT_NO      NUMBER              NOT NULL PRIMARY KEY, -- 과목번호(PK)  
    SUBJECT_NAME    VARCHAR2(100 BYTE)  NOT NULL -- 과목명        
);

-- 수강신청 테이블 
CREATE TABLE ENROLL_T (
    ENROLL_NO       NUMBER NOT NULL, 
    STUDENT_NO      NUMBER              REFERENCES STUDENT_T(STUDENT_NO) ON DELETE CASCADE,  -- 학번(FK)       
    SUBJECT_NO      NUMBER              REFERENCES SUBJECT_T(SUBJECT_NO) ON DELETE SET NULL -- 과목번호(FK)    
);

DROP TABLE ENROLL_T;

DROP TABLE STUDENT_T;

DROP TABLE SUBJECT_T;

