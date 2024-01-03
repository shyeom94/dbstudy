-- ORACLE JOIN 문법(INNER JOIN, OUTER JOIN, 3개 이상의 JOIN)

-- ANSI JOIN과 비교하여 잘 알아두기 

/*
    조인 
    1. 조회할 때 필요한 칼럼이 2개 이상의 테이블에 존재할 때 조인을 사용한다. 
    2. 조인 조건을 이용해서 각 테이블을 조인한다. 
    3. 조인 종류 
        1) 내부 조인 : 조회할 테이블에 모두 존재하는 데이터를 대상으로 조인하는 방식
        2) 외부 조인 : 어느 한 테이블에만 존재하는 데이터를 조회 대상에 포함하는 방식
*/

/* 
    내부 조인(INNER JOIN) 
*/ 

-- 1. 사원번호, 사원명, 부서번호, 부서명을 조회하시오. 
SELECT E.EMP_NO
     , E.NAME
     , E.DEPART
     , D.DEPT_NAME 
  FROM DEPARTMENT_T D, EMPLOYEE_T E 
 WHERE D.DEPT_NO = E.DEPART; -- JOIN 할 때 별명은 꼭 붙이자!

-- PK를 왼쪽에 두면 성능상 도움을 얻을 수 있다. INDEX 

-- 2. 부서별 평균 연봉을 조회하시오. 부서명과 평균연봉을 조회하시오.
SELECT D.DEPT_NAME
     , AVG(E.SALARY) 
  FROM DEPARTMENT_T D, EMPLOYEE_T E
 WHERE DEPT_NO = E.DEPART -- 좌측 : 검색 칼럼 DRIVE TABLE , 우측 : 값 DRIVEN TABLE
 GROUP BY D.DEPT_NAME;

/*
    외부 조인(OUTER JOIN)
*/ 

-- 1. 모든 사원들의 사원번호, 사원명, 부서명을 조회하시오.
SELECT E.EMP_NO
     , E.NAME
     , D.DEPT_NAME
  FROM DEPARTMENT_T D, EMPLOYEE_T E -- INNER JOIN 
 WHERE D.DEPT_NO = E.DEPART; -- 홍길동 X

SELECT E.EMP_NO
     , E.NAME
     , D.DEPT_NAME
  FROM DEPARTMENT_T D, EMPLOYEE_T E -- OUTER JOIN -> EMPLOYEE 테이블에만 있는 홍길동 조회
 WHERE D.DEPT_NO(+) = E.DEPART; -- 홍길동 O -> 오른쪽 조인은 왼쪽에 (+) 추가하기

-- 2. 부서별 사원수를 조회하시오. 부서명, 사원수를 조회하시오. 사원이 없으면 0으로 조회하시오. 
SELECT D.DEPT_NAME
     , E.EMP_NO
     , E.NAME
     , E.DEPART
     , E.POSITION
     , E.GENDER
  FROM DEPARTMENT_T D, EMPLOYEE_T E 
 WHERE D.DEPT_NO = E.DEPART(+); -- 그룹핑 전 단순 조회

SELECT D.DEPT_NAME
     , COUNT(*)
  FROM DEPARTMENT_T D, EMPLOYEE_T E 
 WHERE D.DEPT_NO = E.DEPART
 GROUP BY D.DEPT_NAME; -- 

SELECT D.DEPT_NAME
     , COUNT(*)
  FROM DEPARTMENT_T D, EMPLOYEE_T E 
 WHERE D.DEPT_NO = E.DEPART(+)
 GROUP BY D.DEPT_NAME; -- 문제 발생 -> (*) 때문에 발생

SELECT D.DEPT_NAME
     , COUNT(E.EMP_NO)
  FROM DEPARTMENT_T D, EMPLOYEE_T E 
 WHERE D.DEPT_NO = E.DEPART(+)
 GROUP BY D.DEPT_NAME; -- => 왼쪽 조인은 오른쪽에 (+) 추가하기

-- HR 계정으로 접속 
-- 내부 조인 연습
-- 1. 사원번호, 사원명, 부서명을 조회하시오. 

SELECT E.EMPLOYEE_ID
     , E.FIRST_NAME
     , E.LAST_NAME
     , D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E 
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID; 
  
-- 2. 부서번호, 부서명, 지역명을 조회하시오.
SELECT D.DEPARTMENT_ID
     , D.DEPARTMENT_NAME
     , L.STREET_ADDRESS
  FROM LOCATIONS L, DEPARTMENTS D
 WHERE L.LOCATION_ID = D.LOCATION_ID;
    
-- 3. 사원번호, 사원명, 직업, 직업별 최대연봉, 연봉을 조회하시오.
SELECT E.EMPLOYEE_ID
     , E.FIRST_NAME
     , E.LAST_NAME
     , E.JOB_ID
     , J.MAX_SALARY
     , E.SALARY
  FROM JOBS J, EMPLOYEES E
 WHERE J.JOB_ID = E.JOB_ID;

-- 외부 조인
  
-- 4. 사원번호, 사원명, 부서명을 조회하시오. 단, 부서가 없으면 '부서없음'으로 조회하시오.
SELECT E.EMPLOYEE_ID
     , E.FIRST_NAME
     , E.LAST_NAME
     , NVL(D.DEPARTMENT_NAME, '부서없음')
  FROM DEPARTMENTS D, EMPLOYEES E 
 WHERE D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID; 

-- 5. 부서별 평균 급여를 조회하시오. 부서명, 평균급여룰 조회하시오. 근무중인 사원이 없으면 평균급여를 0으로 조회하시오.
SELECT D.DEPARTMENT_NAME
     , AVG(E.SALARY)
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
 GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME;

SELECT D.DEPARTMENT_NAME
     , NVL(AVG(E.SALARY), 0)
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID(+)
 GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME;

-- 3개 이상 테이블 조인하기

-- 6. 사원번호, 사원명, 부서번호, 부서명, 지역번호, 지역명을 조회하시오.
SELECT E.EMPLOYEE_ID
     , E.LAST_NAME
     , D.DEPARTMENT_ID
     , D.DEPARTMENT_NAME
     , L.LOCATION_ID
     , L.STREET_ADDRESS
  FROM DEPARTMENTS D, EMPLOYEES E, LOCATIONS L 
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID 
   AND D.LOCATION_ID = L.LOCATION_ID; 

-- 조인 순서 바꾸기
SELECT E.EMPLOYEE_ID
     , E.LAST_NAME
     , D.DEPARTMENT_ID
     , D.DEPARTMENT_NAME
     , L.LOCATION_ID
     , L.STREET_ADDRESS
  FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E
 WHERE L.LOCATION_ID = D.LOCATION_ID 
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;
    
-- 조인 조건에서 PK가 왼쪽에 있는 쿼리가 성능이 빠르다. => 아래가 더 빠르다.   

-- 7. 국가명, 도시명, 부서명을 조회하시오. 
SELECT C.COUNTRY_NAME
     , L.CITY
     , D.DEPARTMENT_NAME
  FROM COUNTRIES C, LOCATIONS L, DEPARTMENTS D
 WHERE C.COUNTRY_ID = L.COUNTRY_ID
   AND L.LOCATION_ID = D.LOCATION_ID;

-- 셀프 조인 (하나의 테이블에 1:M 일대다 관계를 가지는 칼럼들이 존재하는 경우)

-- 8. 사원번호, 사원명, 매니저번호, 매니저명을 조회하시오.
-- => 사원 테이블과 매니저 테이블로 구분하기 
-- 관계 
-- 1명의 매니저가 N명의 사원을 관리한다. 

-- 1                               N
-- 매니저테이블 : EMPLOYEES M      사원테이블 : EMPLOYEES E      
-- PK           : EMPLOYEE_ID      FK         : MANAGER_ID

SELECT E.EMPLOYEE_ID   AS 사원번호
     , E.LAST_NAME     AS 사원명
     , E.MANAGER_ID    AS 매니저번호
     , M.LAST_NAME     AS 매니저명
  FROM EMPLOYEES M, EMPLOYEES E 
 WHERE M.EMPLOYEE_ID = E.MANAGER_ID;

-- 9. 같은 부서내에서 나보다 급여를 더 많이 받는 사원을 조회하시오.
-- 관계 
-- 나는 여러 사원과 관계를 맺는다. 

-- 나(EMPLOYEES ME)                너사원(EMPLOYEES YOU)
-- 같은 부서의 사원만 조인하기 위해서 부서 번호로 조인조건을 생성함
SELECT ME.EMPLOYEE_ID  AS 나사원번호
     , ME.LAST_NAME    AS 나사원명
     , ME.SALARY       AS 나급여
     , YOU.EMPLOYEE_ID AS 너사원번호
     , YOU.LAST_NAME   AS 너사원명
     , YOU.SALARY      AS 너급여
  FROM EMPLOYEES ME, EMPLOYEES YOU
 WHERE ME.DEPARTMENT_ID = YOU.DEPARTMENT_ID
   AND ME.SALARY < YOU.SALARY
   AND ME.DEPARTMENT_ID = 50; 


