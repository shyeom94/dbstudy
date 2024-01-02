-- HR 계정으로 접속 

-- 1. LOCATION_ID가 1700인 부서에 근무하는 사원들의 EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME을 조회하시오.
SELECT E.EMPLOYEE_ID                  AS 사원번호
     , E.FIRST_NAME                   AS 사원명
     , D.DEPARTMENT_NAME              AS 부서명
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E  
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 WHERE D.LOCATION_ID = 1700;

-- 2. DEPARTMENT_NAME이 'Executive'인 부서에 근무하는 사원들의 EMPLOYEE_ID, FIRST_NAME을 조회하시오.
SELECT E.EMPLOYEE_ID                  AS 사원번호 
     , E.FIRST_NAME                   AS 사원명
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E 
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 WHERE D.DEPARTMENT_NAME = 'Executive';
 
-- 3. 모든 사원들의 EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME, STREET_ADDRESS, CITY를 조회하시오.
SELECT EMPLOYEE_ID                    AS 사원번호
     , FIRST_NAME                     AS 사원명
     , DEPARTMENT_NAME                AS 부서명
     , STREET_ADDRESS                 AS 주소
     , CITY                           AS 도시
  FROM LOCATIONS L INNER JOIN DEPARTMENTS D 
    ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E 
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 4. 사원이 근무 중인 부서를 대상으로 DEPARTMENT_NAME과 근무 중인 사원 수와 평균 연봉을 조회하시오.
SELECT D.DEPARTMENT_NAME              AS 부서명
     , COUNT(*)                       AS 사원수
     , AVG(E.SALARY)                  AS 평균연봉
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME;

-- 5. JOB_HISTORY 테이블에 존재하는 사원들을 대상으로 사원번호, 현재 JOB_ID, 예전 JOB_ID를 조회하시오.
SELECT E.EMPLOYEE_ID                  AS 사원번호
     , E.JOB_ID                       AS 현재직책
     , H.JOB_ID                       AS 예전직책
  FROM EMPLOYEES E INNER JOIN JOB_HISTORY H 
    ON E.EMPLOYEE_ID = H.EMPLOYEE_ID
 WHERE E.JOB_ID != H.JOB_ID;

-- 6. 모든 사원들의 EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME을 조회하시오. 부서가 없는 사원의 부서명은 'None'으로 조회되도록 처리하시오.
SELECT E.EMPLOYEE_ID                  AS 사원번호
     , E.FIRST_NAME                   AS 사원명
     , NVL(D.DEPARTMENT_NAME, 'None') AS 부서명
  FROM DEPARTMENTS D RIGHT OUTER JOIN EMPLOYEES E 
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 7. 모든 부서의 DEPARTMENT_NAME과 근무 중인 사원 수를 조회하시오. 근무하는 사원이 없으면 0으로 조회하시오.
SELECT D.DEPARTMENT_NAME              AS 부서명
     , COUNT(E.EMPLOYEE_ID)           AS 사원수
  FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME
 ORDER BY D.DEPARTMENT_ID;

-- 8. 모든 부서의 DEPARTMENT_ID, DEPARTMENT_NAME, STATE_PROVINCE, COUNTRY_NAME, REGION_NAME을 조회하시오.
SELECT D.DEPARTMENT_ID               AS 부서번호
     , D.DEPARTMENT_NAME             AS 부서명
     , L.STATE_PROVINCE              AS 주
     , C.COUNTRY_NAME                AS 국가
     , R.REGION_NAME                 AS 대륙
  FROM REGIONS R INNER JOIN COUNTRIES C
    ON R.REGION_ID = C.REGION_ID INNER JOIN LOCATIONS L 
    ON C.COUNTRY_ID = L.COUNTRY_ID INNER JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID;


