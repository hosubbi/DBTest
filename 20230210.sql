--대소문자 변환 문자 함수
SELECT UPPER('Oracle Database'),
       LOWER('Oracle DAtabase'),
       INITCAP('oracle database')
FROM dual;

SELECT employee_id, last_name, UPPER(last_name), job_id, INITCAP(job_id)
FROM employees;

SELECT employee_id, last_name, job_id
FROM employees
WHERE last_name = INITCAP('king');

--여러가지 문자 함수

--CONCAT
SELECT CONCAT('Hello', 'World')
FROM dual;

SELECT CONCAT(CONCAT('Hello', ' '), 'World')
FROM dual;

SELECT employee_id, CONCAT(CONCAT(first_name, ' '), last_name) full_name, job_id, email
FROM employees;

--SUBSTR
SELECT SUBSTR('HelloWorld', 1,5), SUBSTR('HelloWorld', 6), SUBSTR('HelloWorld', -5, 5) --끝에서 왼쪽방향으로 -1부터시작
FROM dual;

SELECT *
FROM employees
WHERE SUBSTR(last_name, -1,1) = 'n';

--위에꺼와 동일
SELECT *
FROM employees
WHERE last_name LIKE '%n';

--LENGTH (공백 포함 길이)
SELECT LENGTH('Oracle Database'), LENGTH('오라클 데이터베이스')
FROM dual;

SELECT *
FROM employees
WHERE LENGTH(last_name) > 6;

--INSTR (Java : indexOf와 비슷)
SELECT INSTR('HelloWorld', 'l') --(영문 l)
FROM dual;

SELECT INSTR(last_name, 'a'), last_name
FROM employees;

SELECT *
FROM employees
WHERE INSTR(last_name, 'a') = 0;

SELECT *
FROM employees
WHERE last_name NOT LIKE '%a%';

--몇번째 등장 위치
SELECT INSTR('HelloWorld', 'l', 4,2),INSTR('HelloWorld', 'l', 1,3)
FROM dual;

--LPAD
SELECT employee_id, RPAD(last_name, 15, '*') last_name, LPAD(salary, 10, '#') salary
FROM employees;

--REPLACE
SELECT REPLACE('Jack and Jue', 'J', 'BL')
FROM dual;

--REPLACE 응용

SELECT employee_id, last_name,
       REPLACE(last_name, SUBSTR(last_name,2,2), '**') AS RESULT
FROM employees;

--TRIM -> 1) 양쪽의 공백을 지우는 것, 2) 양쪽에 데이터 지울 때 사용
SELECT TRIM('HelloWorld             ')
FROM dual;

SELECT TRIM('H' FROM 'HelloWorld'), TRIM('d' FROM 'HelloWorld')
FROM dual;

SELECT TRIM('w' FROM 'window'), TRIM(LEADING 'w' FROM 'window'), TRIM(TRAILING 'w' FROM 'window')
FROM dual;

SELECT TRIM(0 FROM 00012345670), TRIM(LEADING 0 FROM 000012345670)
FROM dual;

--안되는 TRIM, 지우고자 하는 조건 문자가 2개 이상이면 안됨, 1개는 됨.
SELECT TRIM('xy' FROM 'xyxyxyxykkkkxy')
FROM dual;

--실습문제
--1번
SELECT CONCAT('yedam', 'Database')
FROM dual;

--2번
SELECT first_name, job_id
FROM employees
WHERE Lower(job_id) = 'it_prog';

--3번
SELECT SUBSTR('WelcomeToCodingWorld' ,INSTR('WelcomeToCodingWorld','T'),2), 
       SUBSTR('WelcomeToCodingWorld' ,16,5),
       TRIM(TRAILING 'd' FROM 'WelcomeToCodingWorld')
FROM dual;

--4번
SELECT employee_id, last_name, REPLACE(last_name, SUBSTR(last_name,LENGTH(last_name)/2,3), '***')
FROM employees
WHERE LENGTH(last_name) = 5;

--5번
SELECT LPAD(last_name, 10, '*') last_name, RPAD(first_name, 10, '#') first_name
FROM employees;

--6번
SELECT employee_id, CONCAT(first_name ,last_name) fullname , job_id, LENGTH(last_name), INSTR(last_name, 'a') AS searcha
FROM employees
WHERE INSTR(job_id, 'REP') <> 0;

--숫자 함수
--ROUND (반올림)
SELECT ROUND(45.923, 2), ROUND(45.923), ROUND(45.923, -1)
FROM dual;

--TRUNC(내림)
SELECT TRUNC(45.923, 2), TRUNC(45.923), TRUNC(45.923, -1)
FROM dual;

--MOD(나머지)
SELECT last_name, salary, MOD(salary,500)
FROM employees
WHERE job_id = 'SA_REP';

--FLOOR(내림) CEIL(올림) 자릿수 지정 안됨, 정수까지 표현
SELECT FLOOR(45.9999), CEIL(45.9999)
FROM dual;

--날짜 연산
--sysdate
SELECT sysdate
FROM dual;

--일수 더하기
SELECT sysdate + 10
FROM dual;

--근무 일수 구하기
SELECT employee_id, last_name, hire_date, sysdate-hire_date AS 근무일수
FROM employees;

SELECT employee_id, last_name, hire_date, TRUNC(sysdate-hire_date) AS 근무일수
FROM employees;

--근무한 주
SELECT last_name, ROUND((sysdate-hire_date)/7) AS WEEKS
FROM employees;

--날짜 함수
SELECT MONTHS_BETWEEN('22/12/01', '22/01/02')
FROM dual;

SELECT employee_id, last_name,
TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) AS 근무개월수
FROM employees;

SELECT ADD_MONTHS(sysdate, 3), LAST_DAY(sysdate), NEXT_DAY(sysdate,'금')
FROM dual;

SELECT NEXT_DAY(sysdate, '금요일'), NEXT_DAY(sysdate, '금'), NEXT_DAY(sysdate, 6)
FROM dual;

--날짜 기본 타입 변경
ALTER SESSION SET 
NLS_DATE_FORMAT = 'yy/mm/dd';

SELECT sysdate
FROM dual;

SELECT NEXT_DAY(sysdate, 'FRIDAY')
FROM dual;

--날짜 표기하는 언어 설정
ALTER SESSION SET
NLS_DATE_LANGUAGE = 'korean';

--day는 요일, dd는 오늘
SELECT ROUND(sysdate, 'year'), ROUND(sysdate, 'month'), ROUND(sysdate, 'dd'), ROUND(sysdate, 'day')
FROM dual;

SELECT TRUNC(sysdate, 'year'), TRUNC(sysdate, 'month'), TRUNC(sysdate, 'dd'), TRUNC(sysdate, 'day')
FROM dual;

--변환함수
--날짜 -> 문자로 변환
SELECT employee_id, last_name, hire_date
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd')
FROM employees;

SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+3/24, 'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss')
FROM dual;

--DDSPTH
SELECT TO_CHAR(hire_date, 'yyyy "년" Ddspth month hh:mi:ss pm'), hire_date
FROM employees;

--q(쿼터) : 분기
--w(주) : 해당 월의 몇주차
SELECT employee_id, last_name,
    TO_CHAR(hire_date, 'yyyy-mm-dd day') AS hire_date,
    TO_CHAR(hire_date, 'q') AS 분기,
    TO_CHAR(hire_date, 'w') || '주차' AS 주수
FROM employees;

SELECT TO_CHAR(sysdate, 'w') || '주차'
FROM dual;

--숫자를 문자로 변환
SELECT employee_id, last_name, salary, TO_CHAR(salary, '$999,999')
FROM employees;

SELECT employee_id, last_name, salary, TO_CHAR(salary, 'L999,999'), TO_CHAR(salary, '$099,999') || '원'
FROM employees;

ALTER SESSION SET
NLS_TERRITORY = korea;

SELECT employee_id, last_name, salary, TO_CHAR(salary, 'L999,999')
FROM employees;

--문자 -> 숫자 변환
SELECT TO_NUMBER('$3,400', '$99,999')
FROM dual;

SELECT TO_NUMBER('5000')
FROM dual;

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > TO_NUMBER('$8,000', '$9,999');

--문자 -> 날짜 변환
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > '1999/12/31';

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('1999/12/31', 'yyyy/mm/dd');

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('1999/12/31', 'yyyy/mm/dd');

--NVL
SELECT employee_id, last_name, salary, commission_pct, NVL(commission_PCT,0)
FROM employees;

SELECT employee_id, last_name, salary, (salary+salary*commission_pct) AS monthly_sal
FROM employees;

SELECT employee_id, last_name, salary, (salary+salary*NVL(commission_PCT,0)) AS monthly_sal
FROM employees;

--NVL2
SELECT employee_id, last_name, salary+salary*NVL(commission_pct,0) AS monthly_sal,
       NVL2(commission_pct, 'Y', 'N') AS comm_get
FROM employees;

SELECT last_name, salary, commission_pct,
       NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM employees
WHERE department_id IN (50, 80);

--NULLIF
SELECT employee_id, last_name, salary+salary*NVL(commission_pct,0) AS monthly_sal,
       NVL2(commission_pct, 'Y', 'N') AS comm_get,
       NULLIF(salary, salary+salary*NVL(commission_pct, 0)) AS result
FROM employees;

SELECT first_name, LENGTH(first_name) "expr1",
       last_name, LENGTH(last_name) "expr2",
       NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM employees;

--일반함수 COALESCE
SELECT employee_id, commission_pct, manager_id,
    COALESCE(commission_pct, manager_id, 1234) AS result
FROM employees;

SELECT last_name, employee_id,
    COALESCE(TO_CHAR(commission_pct), TO_CHAR(manager_id),
    'NO Commission and No Manager')
FROM employees;

--case when then
SELECT last_name, job_id, salary,
       CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
                   WHEN 'ST_CLERK' THEN 1.15*salary
                   WHEN 'SA_REP' THEN 1.20*salary
       ELSE        salary END AS REVISED_SALARY
FROM employees;

SELECT last_name, job_id, salary,
       CASE WHEN job_id = 'IT_PROG' THEN 1.10*salary
            WHEN job_id = 'ST_CLERK' THEN 1.15*salary
            WHEN job_id = 'SA_REP' THEN 1.20*salary
       ELSE salary END AS REVISED_SALARY
FROM employees;

SELECT employee_id, last_name, salary,
       CASE WHEN salary < 5000 THEN 'L'
            WHEN salary BETWEEN 5000 AND 9000 THEN 'M'
            ELSE 'H' END AS salary_grade
FROM employees;

--NVL2 -> CASE WHEN THEN
SELECT employee_id, last_name, salary+salary*NVL(commission_pct,0) AS monthly_sal,
       NVL2(commission_pct, 'Y', 'N') AS comm_get
FROM employees;

SELECT employee_id, last_name, salary+salary*NVL(commission_pct,0) AS monthly_sal,
       CASE WHEN commission_pct IS NOT NULL THEN 'Y'
       ELSE 'N' END AS comm_get
FROM employees;

--DECODE
SELECT last_name, job_id, salary,
       CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
                   WHEN 'ST_CLERK' THEN 1.15*salary
                   WHEN 'SA_REP' THEN 1.20*salary
       ELSE        salary END AS REVISED_SALARY
FROM employees;

SELECT last_name, job_id, salary,
       DECODE(job_id, 'IT_PROG', 1.10*salary,
                      'ST_CLERK', 1.15*salary,
                      'SA_REP', 1.20*salary,
                      salary) REVISED_SALARY
FROM employees;

--Java switch, 시험 성적 -> 99~90 / 9, 89~80/ 8
SELECT last_name, salary,
       DECODE(TRUNC(salary/2000, 0),
              0, 0.00,
              1, 0.09,
              2, 0.20,
              3, 0.30,
              4, 0.40,
              5, 0.42,
              6, 0.44,
                 0.45) TAX_RATE
FROM employees;











