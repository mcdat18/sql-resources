CREATE PROCEDURE dbo.LogPipelineStart (
  @PipelineRunId UNIQUEIDENTIFIER
, @RunStartDateTime DATETIME
, @Comments NVARCHAR(1024) = NULL
) AS
INSERT INTO dbo.PipelineExecution (
  PipelineRunId
, RunStartDateTime
, Comments
) VALUES (
  @PipelineRunId
, @RunStartDateTime
, @Comments
);
GO

SELECT SCOPE_IDENTITY() AS RunSeqNo;
GO

CREATE PROCEDURE dbo.LogPipelineEnd (
  @RunSeqNo INT
, @RunEndDateTime DATETIME
, @RunStatus VARCHAR(20)
, @FilesRead INT
, @RowsRead INT
, @RowsCopied INT
) AS
UPDATE dbo.PipelineExecution
SET RunEndDateTime = @RunEndDateTime
  , RunStatus = @RunStatus
  , FilesRead = @FilesRead
  , RowsRead = @RowsRead
  , RowsCopied = @RowsCopied
WHERE RunSeqNo = @RunSeqNo;
GO
