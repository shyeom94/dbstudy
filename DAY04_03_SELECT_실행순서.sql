/*
    SELECT 문의 실행 순서
    
    1. FROM 
    2. WHERE
    3. GROUP BY
    4. HAVING
    5. SELECT
    6. ORDER BY 
*/
-- 수행 순서를 기반으로 이해 

-- 1. 부서번호를 기준으로 오름차순 정렬하시오. 
SELECT DEPART AS 부서번호       -- [실행순서 2] 
  FROM EMPLOYEE_T               -- [실행순서 1] 
 ORDER BY 부서번호;             -- [실행순서 3] 실행 순서 때문에 인식 가능 
 
-- 2. 부서별로 연봉 평균을 조회하시오. 
SELECT DEPART AS 부서번호       -- [실행순서 3] 
     , AVG(SALARY) AS 평균연봉
  FROM EMPLOYEE_T               -- [실행순서 1] 
 GROUP BY 부서번호;             -- [실행순서 2] 실행 순서가 늦기 때문에 인식 불가능 

-- 3. 부서별로 연봉 평균과 사원수를 조회하시오. 사원수가 2명 이상인 부서만 조회하시오. 평균 연봉의 내림차순 정렬
SELECT DEPART AS 부서번호       -- [실행순서 4] 
     , AVG(SALARY) 평균연봉
     , COUNT(*) AS 사원수
  FROM EMPLOYEE_T               -- [실행순서 1] 
 GROUP BY DEPART                -- [실행순서 2] 부서번호 인식 못함!
HAVING COUNT(*) >= 2            -- [실행순서 3] 사원수 인식 못함! 
 ORDER BY 평균연봉 DESC;        -- [실행순서 5] 순서상 인식 가능 

-- 