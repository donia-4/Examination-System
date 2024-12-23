-- Auto-Award Marks
create trigger AutoAwardMarks
on StudentAnswer
after insert
as
begin
    set nocount on;

    -- Automatically calculate marks for MCQ and True/False answers
    update sa
    set sa.marksAwarded = case
        when q.QuestionType = 'MCQ' and mcq.CorrectOption = sa.Answer then q.Degree
		when q.QuestionType = 'True/False' and cast(tf.CorrectAnswer as nvarchar(max)) = sa.Answer then q.Degree

        else 0
    end
    from StudentAnswer sa
    join Question q on sa.QuestionId = q.QuestionId
    left join MCQQuestion mcq on q.QuestionId = mcq.QuestionId
    left join TrueFalseQuestion tf on q.QuestionId = tf.QuestionId
    where sa.AnswerId in (select AnswerId from inserted);

    print 'Marks awarded successfully for MCQ and True/False answers.';
end;

--======================================================================
-- Log Text Answers for Manual Grading
create trigger LogTextAnswers
on StudentAnswer
after insert
as
begin
    set nocount on;

    -- Log text-based answers for manual grading
    if exists (
        select 1
        from inserted i
        join Question q on i.QuestionId = q.QuestionId
        where q.QuestionType = 'Text'
    )
    begin
        print 'Text answer logged for manual grading.';
    end;
end;

--===================================================================
-- Calculate MCQ Result
create proc CalculateMCQResult
    @ExamId int,
    @StudentId int
as
begin
    SET NOCOUNT ON;
    declare @Score decimal(5,2) = 0;

    -- Calculate score based on degree for MCQ and True/False questions
    select @Score = sum(
        case 
            when A.IsCorrect = 1 then Q.degree -- Use question degree instead of 1
            else 0
        end
    )
    from dbo.studentAnswer SA
    join Question Q ON SA.QuestionId = Q.QuestionId
    join dbo.studentAnswer A ON SA.AnswerId = A.AnswerId
    where SA.ExamId = @ExamId
    and SA.StudentId = @StudentId
    and Q.QuestionType in ('Multiple Choice', 'True/False');

    -- Update the result with the calculated score
    update dbo.studentExam
    set studentResult = @Score
    where ExamId = @ExamId AND StudentId = @StudentId;

    select 'MCQ results calculated and stored successfully.';
end;

--===============================================================
-- View and Compare Text Answers of Students
create proc View_And_Compare_TextAnswers_Of_Students
    @ExamId int
as
begin
    set nocount on;

    -- Select all Text questions with student answers and best answers
    select 
        Q.QuestionId,
		SA.StudentId,
        Q.QuestionText as Question,
        TQ.BestAnswer as ModelAnswer,
        SA.answer as StudentAnswer,
		Q.degree as [question degree]
    from Question Q
    join TextQuestion TQ 
        on Q.QuestionId = TQ.QuestionId
    join StudentAnswers SA
        on Q.QuestionId = SA.QuestionId
    where Q.QuestionType = 'Text'
      and SA.ExamId = @ExamId;

    -- Inform the instructor that all text-based answers are displayed
    select 'Text-based questions and answers displayed successfully for comparison.';
end;
--=====================================================

--===================================================================
-- Grade Text Questions for Exam
create proc GradeTextQuestionsForExam
    @ExamId int,
    @StudentId int,
    @Grades nvarchar(max) -- Comma-separated grades in the format: QuestionId:Grade, e.g., '101:4.5,102:3.0'
as
begin
    set nocount on;

    -- Create a temporary table to hold the grades
    declare @GradeTable table (
        QuestionId int,
        MarksAwarded decimal(5, 2)
    );

    -- Parse the input grades and insert them into the temporary table
    insert into @GradeTable (QuestionId, MarksAwarded)
    select 
        cast(left(value, charindex(':', value) - 1) as int), 
        cast(substring(value, charindex(':', value) + 1, len(value)) as decimal(5, 2))
    from string_split(@Grades, ',')
    where charindex(':', value) > 0;

    -- Update the marksAwarded column in the StudentAnswers table
    update SA
    set SA.marksAwarded = GT.MarksAwarded
    from StudentAnswers SA
    join @GradeTable GT on SA.QuestionId = GT.QuestionId
    where SA.ExamId = @ExamId
      and SA.StudentId = @StudentId
      and SA.QuestionId in (select QuestionId from Question where QuestionType = 'Text');

    -- Confirmation message
    select 'Text-based questions graded successfully for the specified exam and student.';
end;

--========================================================
-- Calculate Final Result
create proc CalculateFinalResult
    @ExamId int,
    @StudentId int
as
begin
    set nocount on;

    -- Calculate the total marks awarded for all questions answered by the student
    declare @TotalScore decimal(10, 2);

    select @TotalScore = sum(SA.marksAwarded)
    from StudentAnswers SA
    join Question Q on SA.QuestionId = Q.QuestionId
    where SA.ExamId = @ExamId
      and SA.StudentId = @StudentId;

    -- Update the StudentExam table with the calculated total score
    update StudentExam
    set StudentResult = @TotalScore
    where ExamId = @ExamId
      and StudentId = @StudentId;

    -- Return a confirmation message
    select 'Final result calculated and stored successfully.';
end;

--=====================================================
-- Process Exam Results
create proc ProcessExamResults
    @ExamId int,
    @StudentId int
as
    SET NOCOUNT ON;

    exec ValidateExamSubmission @ExamId, @StudentId;

    exec CalculateMCQResult @ExamId, @StudentId;

    exec CalculateFinalResult @ExamId, @StudentId;
  
    select 'Exam results processed and stored successfully.';

--====================================================================
-- View Exam Results
create proc ViewExamResults
    @ExamId int
as
begin
    set nocount on;
    select 
        se.StudentId,
        s.FullName,
        se.StudentResult as FinalScore  -- Final degree from the StudentExam table
    from 
        StudentExam se
    join 
        Student s on se.StudentId = s.StudentId
    where 
        se.ExamId = @ExamId
    order by 
        se.StudentResult desc  -- Sort by final score in descending order
end;

--====================================================================
-- View Exam Results for a Student
create proc ViewExamResultsForStudent
    @ExamId int,
    @StudentId int  -- Adding parameter for specific student
as
begin
    set nocount on;

    -- Select relevant data for the specific student's answers in the specified exam
    select 
        s.StudentId,
        s.FullName,
        q.QuestionText,
        sa.Answer as StudentAnswer,         -- Get the student's answer from StudentAnswer table
        sa.marksAwarded as MarksAwarded     -- Marks awarded for each question from StudentAnswer
    from 
        StudentExam se
    join 
        Student s on se.StudentId = s.StudentId
    join 
        questionExam eq on se.ExamId = eq.ExamId
    join 
        question q on eq.QuestionId = q.QuestionId
    left join 
        StudentAnswer sa on sa.QuestionId = q.QuestionId 
        and sa.StudentId = s.StudentId
    where 
        se.ExamId = @ExamId
        and se.StudentId = @StudentId  -- Filter by specific student
    order by 
        q.QuestionId;   -- Order by question ID for clarity
end;

--==================================================