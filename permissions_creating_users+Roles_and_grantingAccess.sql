-- roles creation
CREATE ROLE AdminRole;
CREATE ROLE TrainingManagerRole;
CREATE ROLE InstructorRole;
CREATE ROLE StudentRole;


-- Create Training Managers and assign role
create user [John Doe] for login [John Doe];
alter role TrainingManagerRole add member [John Doe];

create user [Emma Watson] for login [Emma Watson];
alter role TrainingManagerRole add member [Emma Watson];

-- Create Instructors and assign role
create user [Michael Smith] for login [Michael Smith];
alter role InstructorRole add member [Michael Smith];

create user [Sophia Johnson] for login [Sophia Johnson];
alter role InstructorRole add member [Sophia Johnson];

create user [James Williams] for login [James Williams];
alter role InstructorRole add member [James Williams];

create user [Olivia Brown] for login [Olivia Brown];
alter role InstructorRole add member [Olivia Brown];

create user [Liam Jones] for login [Liam Jones];
alter role InstructorRole add member [Liam Jones];

create user [Ava Miller] for login [Ava Miller];
alter role InstructorRole add member [Ava Miller];

create user [Lucas Davis] for login [Lucas Davis];
alter role InstructorRole add member [Lucas Davis];

create user [Isabella Garcia] for login [Isabella Garcia];
alter role InstructorRole add member [Isabella Garcia];

create user [Ethan Martinez] for login [Ethan Martinez];
alter role InstructorRole add member [Ethan Martinez];

create user [Mia Rodriguez] for login [Mia Rodriguez];
alter role InstructorRole add member [Mia Rodriguez];

-- Create Students and assign role
create user [Liam Anderson] for login [Liam Anderson];
alter role StudentRole add member [Liam Anderson];

create user [Olivia Taylor] for login [Olivia Taylor];
alter role StudentRole add member [Olivia Taylor];

create user [Noah Wilson] for login [Noah Wilson];
alter role StudentRole add member [Noah Wilson];

create user [Emma Clark] for login [Emma Clark];
alter role StudentRole add member [Emma Clark];

create user [James Lewis] for login [James Lewis];
alter role StudentRole add member [James Lewis];

create user [Sophia Walker] for login [Sophia Walker];
alter role StudentRole add member [Sophia Walker];

create user [Benjamin Hall] for login [Benjamin Hall];
alter role StudentRole add member [Benjamin Hall];

create user [Isabella Allen] for login [Isabella Allen];
alter role StudentRole add member [Isabella Allen];

create user [Mason Young] for login [Mason Young];
alter role StudentRole add member [Mason Young];

create user [Charlotte King] for login [Charlotte King];
alter role StudentRole add member [Charlotte King];

create user [Elijah Scott] for login [Elijah Scott];
alter role StudentRole add member [Elijah Scott];

create user [Amelia Adams] for login [Amelia Adams];
alter role StudentRole add member [Amelia Adams];

create user [William Nelson] for login [William Nelson];
alter role StudentRole add member [William Nelson];

create user [Lucas Carter] for login [Lucas Carter];
alter role StudentRole add member [Lucas Carter];

create user [Harper Mitchell] for login [Harper Mitchell];
alter role StudentRole add member [Harper Mitchell];

create user [Alexander Perez] for login [Alexander Perez];
alter role StudentRole add member [Alexander Perez];

create user [Mia Roberts] for login [Mia Roberts];
alter role StudentRole add member [Mia Roberts];

create user [Jackson Evans] for login [Jackson Evans];
alter role StudentRole add member [Jackson Evans];

create user [Avery Green] for login [Avery Green];
alter role StudentRole add member [Avery Green];

create user [Ella Baker] for login [Ella Baker];
alter role StudentRole add member [Ella Baker];

create user [Sebastian Murphy] for login [Sebastian Murphy];
alter role StudentRole add member [Sebastian Murphy];

create user [Jack Harris] for login [Jack Harris];
alter role StudentRole add member [Jack Harris];

create user [Zoe Foster] for login [Zoe Foster];
alter role StudentRole add member [Zoe Foster];

create user [Grace Ross] for login [Grace Ross];
alter role StudentRole add member [Grace Ross];

create user [Oliver Morgan] for login [Oliver Morgan];
alter role StudentRole add member [Oliver Morgan];

create user [Chloe Cox] for login [Chloe Cox];
alter role StudentRole add member [Chloe Cox];

create user [Jackson Bell] for login [Jackson Bell];
alter role StudentRole add member [Jackson Bell];

create user [Maya Ward] for login [Maya Ward];
alter role StudentRole add member [Maya Ward];

create user [Jacob Cooper] for login [Jacob Cooper];
alter role StudentRole add member [Jacob Cooper];

create user [Emily Flores] for login [Emily Flores];
alter role StudentRole add member [Emily Flores];

create user [Levi Gonzalez] for login [Levi Gonzalez];
alter role StudentRole add member [Levi Gonzalez];

create user [Aiden Perez] for login [Aiden Perez];
alter role StudentRole add member [Aiden Perez];

create user [Lily Morris] for login [Lily Morris];
alter role StudentRole add member [Lily Morris];

create user [Carter Price] for login [Carter Price];
alter role StudentRole add member [Carter Price];

create user [Zachary Hughes] for login [Zachary Hughes];
alter role StudentRole add member [Zachary Hughes];

create user [Eleanor Powell] for login [Eleanor Powell];
alter role StudentRole add member [Eleanor Powell];

create user [Amos Ward] for login [Amos Ward];
alter role StudentRole add member [Amos Ward];

create user [Nina Sanders] for login [Nina Sanders];
alter role StudentRole add member [Nina Sanders];

create user [Samuel Clark] for login [Samuel Clark];
alter role StudentRole add member [Samuel Clark];

create user [Sophie Russell] for login [Sophie Russell];
alter role StudentRole add member [Sophie Russell];

create user [Daniel Peterson] for login [Daniel Peterson];
alter role StudentRole add member [Daniel Peterson];

create user [Charlotte Carter] for login [Charlotte Carter];
alter role StudentRole add member [Charlotte Carter];

create user [Henry James] for login [Henry James];
alter role StudentRole add member [Henry James];

create user [Natalie Rodriguez] for login [Natalie Rodriguez];
alter role StudentRole add member [Natalie Rodriguez];

create user [Mason Garcia] for login [Mason Garcia];
alter role StudentRole add member [Mason Garcia];

create user [Samantha Collins] for login [Samantha Collins];
alter role StudentRole add member [Samantha Collins];

create user [Ethan Scott] for login [Ethan Scott];
alter role StudentRole add member [Ethan Scott];

create user [Megan Mitchell] for login [Megan Mitchell];
alter role StudentRole add member [Megan Mitchell];

create user [Andrew Taylor] for login [Andrew Taylor];
alter role StudentRole add member [Andrew Taylor];

create user [Nora Young] for login [Nora Young];
alter role StudentRole add member [Nora Young];

create user [Seth Wright] for login [Seth Wright];
alter role StudentRole add member [Seth Wright];

create user [Anna Bell] for login [Anna Bell];
alter role StudentRole add member [Anna Bell];

create user [Benjamin Davis] for login [Benjamin Davis];
alter role StudentRole add member [Benjamin Davis];

create user [Eva Thompson] for login [Eva Thompson];
alter role StudentRole add member [Eva Thompson];

create user [Ryan Lopez] for login [Ryan Lopez];
alter role StudentRole add member [Ryan Lopez];

create user [Ava Walker] for login [Ava Walker];
alter role StudentRole add member [Ava Walker];

create user [Oscar Harris] for login [Oscar Harris];
alter role StudentRole add member [Oscar Harris];

create user [Nathan Turner] for login [Nathan Turner];
alter role StudentRole add member [Nathan Turner];

create user [Maya Clark] for login [Maya Clark];
alter role StudentRole add member [Maya Clark];

create user [Grace Mitchell] for login [Grace Mitchell];
alter role StudentRole add member [Grace Mitchell];

create user [Jackie Lopez] for login [Jackie Lopez];
alter role StudentRole add member [Jackie Lopez];


--authorization --> permissions for training managers
grant execute on sp_add_or_edit_branch to TrainingManagerRole;
grant execute on sp_add_or_edit_track to TrainingManagerRole;
grant execute on sp_add_or_edit_intake to TrainingManagerRole;
grant execute on sp_add_or_edit_student to TrainingManagerRole;
grant execute on add_ins to TrainingManagerRole;
grant execute on update_ins to TrainingManagerRole;
grant execute on delete_ins to TrainingManagerRole;
grant execute on get_ins to TrainingManagerRole;
grant execute on get_instructor_by_id to TrainingManagerRole;
grant execute on assign_instructor_to_course to TrainingManagerRole;
grant execute on remove_instructor_from_course to TrainingManagerRole;


--authorization --> permissions for instructors
grant execute on [dbo].[ViewExamDetails] to InstructorRole;
grant execute on AddExam to InstructorRole;
grant execute on AddRandomQuestionsToExam to InstructorRole;
grant execute on AddManualQuestion to InstructorRole;
grant execute on AddOrSelectQuestionsToExam to InstructorRole;
grant execute on AssignValidStudentsToExam to InstructorRole;
grant execute on SetExamSchedule to InstructorRole;
grant execute on AssignStudentsAndScheduleExam to InstructorRole;
grant execute on ValidateExamSubmission to InstructorRole;
grant execute on CalculateMCQResult to InstructorRole;
grant execute on View_And_Compare_TextAnswers_Of_Students to InstructorRole;
grant execute on GradeTextQuestionsForExam to InstructorRole;
grant execute on CalculateFinalResult to InstructorRole;
grant execute on ProcessExamResults to InstructorRole;
grant execute on ViewExamResults to InstructorRole;
grant execute on ViewExamResultsForStudent to InstructorRole;
grant execute on AddQuestionToPool to InstructorRole;
grant execute on UpdateQuestionInPool to InstructorRole;


-- Grant EXECUTE permission for StudentRole on the stored procedures
grant execute on [dbo].[StartExam] to StudentRole;
grant execute on [dbo].[GetExamQuestions] to StudentRole;
grant execute on [dbo].[InsertStudentAnswer] to StudentRole;





