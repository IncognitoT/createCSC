Easy qsts (no relations needed)
1- Get all enrolled students for a specific period,program,year ?
select student_epita_email from students s 
where student_population_period_ref ilike 'FALL' and 
student_population_year_ref='2020' and 
student_population_code_ref='SE'
and student_enrollment_status='completed' 

2- Get number of enrolled students for a specific period,program,year
select count(student_epita_email) from students s 
where student_population_period_ref ilike 'FALL' and 
student_population_year_ref='2020' and 
student_population_code_ref='SE'
and student_enrollment_status='completed' 

3- Get All defined exams for a course from grades table
select distinct(grade_exam_type_ref) from grades g2 where grade_course_code_ref='SE_ADV_JAVA' 


4-Get all grades for a student
select grade_score from grades g where grade_student_epita_email_Ref='simona.morasca@epita.fr'

5-Get all grades for a specific Exam
select grade_score from grades g where grade_exam_type_ref='Project' 

6-Get students Ranks in an Exam for a course
select RANK() OVER (ORDER BY exam_weight DESC) as ranks
FROM
exams where exam_course_code='SE_ADV_JAVA' and exam_type='Practical' 

7-Get students Ranks in all exams for a course
select *,RANK() OVER (ORDER BY exam_weight DESC) as ranks
FROM
exams where exam_course_code='SE_ADV_JAVA'  

8-Get students Rank in all exams in all courses
select grade_exam_type_ref,grade_course_code_ref, grade_course_rev_ref,RANK() OVER (partition by grade_student_epita_email_ref order by grade_score desc ) FROM grades

9-Get all courses for one program
select * from programs p2 
select program_course_code_ref from programs p where program_assignment='SE'

10-Get courses in common between 2 programs
SELECT program_course_code_ref 
    FROM programs p2 
   where program_assignment in ('SE','ISM')
    GROUP BY program_course_code_ref
    HAVING COUNT(*) = 2

11-Get all programs following a certain course
select * from programs p where program_course_code_ref='DT_RDBMS' 

12- get course with the biggest duration
select course_code,rnk
from (
select course_code,RANK() OVER (ORDER BY duration DESC) as rnk
from courses c 
) as cc_rank
where rnk <= 1

13-get courses with the same duration
SELECT * FROM courses c WHERE duration IN
(SELECT duration FROM courses c2 GROUP BY duration HAVING COUNT(*) > 1) order by duration desc


14-Get all sessions for a specific course


15-Get all session for a certain period


16-Get one student attendance sheet


17- Get one student summary of attendance


18-Get student with most absences

select attendance_student_ref,count(attendance_presence) from attendance a where attendance_presence='0' 
--and attendance_student_ref='jamal.vanausdal@epita.fr' 
group by attendance_student_ref 
order by count(attendance_presence) desc limit 1



Hard questions (build the relations requiered)
1- Get all exams for a specific Course
2- Get all Grades for a specific Student
select distinct grade_score, student_epita_email,grade_course_code_ref
from grades inner join students
on grades.grade_student_epita_email_ref = students.student_epita_email where grade_student_epita_email_ref ='jamal.vanausdal@epita.fr'

3- Get the final grades for a student on a specifique course or all courses
select grade_student_epita_email_ref, SUM (grade_score) AS total from grades g GROUP by grade_student_epita_email_ref ORDER BY total;

4-Get the students with the top 5 scores for specific course
select grade_student_epita_email_ref,grade_score ,grade_course_code_ref
from grades where grade_course_code_ref ='SE_ADV_DB'
order by grade_score desc limit 5;

5-Get the students with the top 5 scores for specific course per rank
select grade_student_epita_email_ref , rank () over (partition by grade_course_rev_ref order by grade_score desc )
FROM grades where grade_course_code_ref = 'SE_ADV_JS' limit 5


6-Get the Class average for a course
select avg(grade_score) , grade_course_code_ref from grades group by grade_course_code_ref




--bonuses:
1-Get a student full report of grades and attendances
2- -- Get a student full report of grades ,ranks per course and attendances
Those questions are from easy to super hard
