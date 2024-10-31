USE [dbRATES]
GO

DECLARE @RC INT
DECLARE @DocId BIGINT
DECLARE @UserId INT
DECLARE @QuanOfAttached TINYINT
DECLARE @SelectResult BIT

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[usp_ACC_Save_FinishAndOKDoc] 
   @DocId
  ,@UserId
  ,@QuanOfAttached
  ,@SelectResult