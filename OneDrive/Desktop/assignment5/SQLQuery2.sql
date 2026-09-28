-- Database Assignment 5

USE Hospital;
GO


-- Question 1
SELECT P.Name AS PatientName, W.Name AS WardName
FROM Patients P
INNER JOIN Wards W ON P.WardId = W.Id;

-- Question 2
SELECT P.Name AS PatientName, DA.DrugCode
FROM DrugAdministrations DA
INNER JOIN Patients P ON DA.PatientId = P.Id;

-- Question 3
SELECT P.Name AS PatientName, C.Name AS ConsultantName
FROM Patients P
INNER JOIN PatientExaminations PE ON P.Id = PE.PatientId
INNER JOIN Consultants C ON PE.ConsultantId = C.Id;

-- Question 4
SELECT P.Name AS PatientName, W.Name AS WardName
FROM Patients P
LEFT JOIN Wards W ON P.WardId = W.Id;

-- Question 5
SELECT W.Name AS WardName, P.Name AS PatientName
FROM Wards W
LEFT JOIN Patients P ON W.Id = P.WardId;

-- Question 6
SELECT C.Name AS ConsultantName, P.Name AS PatientName
FROM Consultants C
LEFT JOIN PatientExaminations PE ON C.Id = PE.ConsultantId
LEFT JOIN Patients P ON PE.PatientId = P.Id;

-- Question 7
SELECT W.Name AS WardName, P.Name AS PatientName
FROM Wards W
LEFT JOIN Patients P ON W.Id = P.WardId;

-- Question 8
SELECT C.Name AS ConsultantName, PE.PatientId
FROM Consultants C
LEFT JOIN PatientExaminations PE ON C.Id = PE.ConsultantId;

-- Question 9
SELECT P.Name AS PatientName, W.Name AS WardName
FROM Patients P
FULL OUTER JOIN Wards W ON P.WardId = W.Id;

-- Question 10
SELECT C.Name AS ConsultantName, PE.PatientId
FROM Consultants C
FULL OUTER JOIN PatientExaminations PE ON C.Id = PE.ConsultantId;

-- Question 11
-- ملاحظة: العلاقة الذاتية في جدول Nurses تعتمد على ربط الممرض برئيسه
SELECT N.Name AS NurseName, M.Name AS ManagerName
FROM Nurses N
LEFT JOIN Nurses M ON N.ServesInWardId = M.SupervisedWardId;

-- Question 12
SELECT N.Name AS NurseName, M.Name AS ManagerName
FROM Nurses N
INNER JOIN Nurses M ON N.ServesInWardId = M.SupervisedWardId;

-- Question 13
SELECT M.Name AS ManagerName, N.Name AS SubordinateNurse
FROM Nurses M
INNER JOIN Nurses N ON M.SupervisedWardId = N.ServesInWardId;

-- Question 14
SELECT P.Name AS PatientName, C.Name AS ConsultantName
FROM Patients P
CROSS JOIN Consultants C;

-- Question 15
SELECT W.Name AS WardName, C.Name AS ConsultantName
FROM Wards W
CROSS JOIN Consultants C;



-- Question 16
SELECT P.Name AS PatientName, W.Name AS WardName, C.Name AS ConsultantName
FROM Patients P
LEFT JOIN Wards W ON P.WardId = W.Id
LEFT JOIN PatientExaminations PE ON P.Id = PE.PatientId
LEFT JOIN Consultants C ON PE.ConsultantId = C.Id;

-- Question 17
SELECT P.Name AS PatientName, N.Name AS NurseName, DA.DrugCode
FROM DrugAdministrations DA
INNER JOIN Patients P ON DA.PatientId = P.Id
INNER JOIN Nurses N ON DA.NurseId = N.Number;

-- Question 18
SELECT P.Name AS PatientName, W.Name AS WardName, N.Name AS NurseName, DA.Dosage
FROM DrugAdministrations DA
INNER JOIN Patients P ON DA.PatientId = P.Id
LEFT JOIN Wards W ON P.WardId = W.Id
INNER JOIN Nurses N ON DA.NurseId = N.Number;

-- Question 19
SELECT P.Name AS PatientName, C.Name AS ConsultantName, W.Name AS WardName
FROM Patients P
INNER JOIN PatientExaminations PE ON P.Id = PE.PatientId
INNER JOIN Consultants C ON PE.ConsultantId = C.Id
INNER JOIN Wards W ON P.WardId = W.Id;

-- Question 20
SELECT P.Name AS PatientName, N.Name AS NurseName, DA.DrugCode, DA.Dosage, DA.DATE, DA.Time
FROM DrugAdministrations DA
INNER JOIN Patients P ON DA.PatientId = P.Id
INNER JOIN Nurses N ON DA.NurseId = N.Number;



-- Question 21
SELECT Id, Name, Salary,
       ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
FROM Consultants;

-- Question 22
SELECT Id, Name, Salary,
       ROW_NUMBER() OVER (ORDER BY Salary ASC) AS RowNum
FROM Consultants;

-- Question 23
SELECT Id, Name, Salary,
       ROW_NUMBER() OVER (ORDER BY Salary DESC, Name ASC) AS RowNum
FROM Consultants;

-- Question 24
SELECT Id, Name, Salary,
       RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Consultants;

-- Question 25
SELECT Id, Name, Salary,
       RANK() OVER (ORDER BY Salary ASC) AS SalaryRank
FROM Consultants;

-- Question 26
SELECT Id, Name, Salary,
       RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Consultants
ORDER BY Salary DESC;

-- Question 27
SELECT Id, Name, Salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseSalaryRank
FROM Consultants;

-- Question 28
SELECT Id, Name, Salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseSalaryRank
FROM Consultants
ORDER BY Salary DESC;

-- Question 29
SELECT Name, Salary,
       RANK() OVER (ORDER BY Salary DESC) AS Rank_Val,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank_Val
FROM Consultants;

-- Question 30
SELECT Id, Name, Salary,
       NTILE(2) OVER (ORDER BY Salary DESC) AS SalaryGroup
FROM Consultants;

-- Question 31
SELECT Id, Name, Salary,
       NTILE(3) OVER (ORDER BY Salary DESC) AS SalaryGroup
FROM Consultants;

-- Question 32
SELECT Id, Name, Salary,
       NTILE(4) OVER (ORDER BY Salary DESC) AS SalaryGroup
FROM Consultants
ORDER BY SalaryGroup ASC;



-- Question 33
-- يفترض وجود عمود Salary في جدول Nurses لتنفيذ الدوال النافذية
SELECT Number, Name, ServesInWardId,
       RANK() OVER (PARTITION BY ServesInWardId ORDER BY Number DESC) AS WardSalaryRank
FROM Nurses;

-- Question 34
SELECT Number, Name, ServesInWardId,
       ROW_NUMBER() OVER (PARTITION BY ServesInWardId ORDER BY Number DESC) AS RowNum
FROM Nurses;

-- Question 35
SELECT Number, Name, ServesInWardId,
       DENSE_RANK() OVER (PARTITION BY ServesInWardId ORDER BY Number DESC) AS DenseWardSalaryRank
FROM Nurses;

-- Question 36
SELECT Number, Name, ServesInWardId,
       NTILE(2) OVER (PARTITION BY ServesInWardId ORDER BY Number DESC) AS WardSalaryGroup
FROM Nurses;

-- Question 37
SELECT N.Name AS NurseName, W.Name AS WardName,
       RANK() OVER (PARTITION BY N.ServesInWardId ORDER BY N.Number DESC) AS SalaryRank
FROM Nurses N
INNER JOIN Wards W ON N.ServesInWardId = W.Id;

-- Question 38
WITH ConsultantRank AS (
    SELECT Id,
           RANK() OVER (ORDER BY Salary DESC) AS C_Rank
    FROM Consultants
)
SELECT P.Name AS PatientName, W.Name AS WardName, CR.C_Rank AS ConsultantSalaryRank
FROM Patients P
LEFT JOIN Wards W ON P.WardId = W.Id
LEFT JOIN PatientExaminations PE ON P.Id = PE.PatientId
LEFT JOIN ConsultantRank CR ON PE.ConsultantId = CR.Id;

-- Question 39
WITH NurseRank AS (
    SELECT Number, ServesInWardId,
           RANK() OVER (PARTITION BY ServesInWardId ORDER BY Number DESC) AS N_Rank
    FROM Nurses
)
SELECT P.Name AS PatientName, N.Name AS NurseName, DA.Dosage, NR.N_Rank AS NurseWardSalaryRank
FROM DrugAdministrations DA
INNER JOIN Patients P ON DA.PatientId = P.Id
INNER JOIN Nurses N ON DA.NurseId = N.Number
INNER JOIN NurseRank NR ON N.Number = NR.Number;