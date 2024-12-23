--view for managing branches,tracks and intakes
create view vw_BranchTrackIntake
as
select 
    b.branchID, 
    b.branchName,
    t.trackID, 
    t.trackName,
    b.trainingManagerID as BranchTrainingManagerID,
    t.trainingManagerID as TrackTrainingManagerID
from 
    dbo.branch b
left join 
    dbo.track t on b.branchID = t.branchID;

--==================================================================
--View for Managing Students
create view vw_StudentDetails
as
select 
    s.studentID, 
    s.fullName, 
    s.intakeID, 
    i.intakeYear,
    t.trackID, 
    t.trackName,
    b.branchID, 
    b.branchName,
    b.trainingManagerID as BranchTrainingManagerID,
    t.trainingManagerID as TrackTrainingManagerID
from 
    dbo.student s
left join 
    dbo.intake i on s.intakeID = i.intakeID
left join 
    dbo.track t on i.intakeID = t.intakeID
left join 
    dbo.branch b on t.branchID = b.branchID;