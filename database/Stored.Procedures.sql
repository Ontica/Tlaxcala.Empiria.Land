USE [Land]
GO
/****** Object:  StoredProcedure [dbo].[apdAuditTrail]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[apdAuditTrail] (
	@RequestGuid  [uniqueidentifier],
	@AuditTrailType  [char]  (1),
	@AuditTrailTime  [datetime],
	@SessionId  [int],
	@EventName  [varchar]  (128),
	@OperationName  [varchar]  (128),
	@OperationData  [varchar]  (2048),
	@AppliedToId  [int],
	@ResponseCode  [int],
	@ResponseItems  [int],
	@ResponseTime  decimal(9, 5),
	@ResponseData  varchar(MAX)
)
AS
	BEGIN

	INSERT INTO [dbo].[AuditTrail] (
		[RequestGuid], [AuditTrailType], [AuditTrailTime], [SessionId],
		[EventName], [OperationName], [OperationData], [AppliedToId],
		[ResponseCode], [ResponseItems], [ResponseTime], [ResponseData]
	) VALUES (
		@RequestGuid, @AuditTrailType, @AuditTrailTime, @SessionId,
		@EventName, @OperationName, @OperationData, @AppliedToId,
		@ResponseCode, @ResponseItems, @ResponseTime, @ResponseData
	)
		SELECT CAST(SCOPE_IDENTITY() AS bigint);
	END

GO
/****** Object:  StoredProcedure [dbo].[apdDataLog]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[apdDataLog] (
	@SessionId  [int],
	@LogTimestamp  [datetime],
	@DataSource  [varchar]  (32),
	@DataOperation  [varchar]  (64),
	@DataParameters  varchar (MAX),
	@ObjectId int
)
AS

	INSERT INTO [dbo].[DataLog] (
		[SessionId], [LogTimestamp], [DataSource],
		[DataOperation], [DataParameters], [ObjectId]
	) VALUES (
		@SessionId, @LogTimestamp, @DataSource,
		@DataOperation, @DataParameters, @ObjectId
	)
GO
/****** Object:  StoredProcedure [dbo].[apdEOPSignEvent]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[apdEOPSignEvent] (
	@SignEventId  [int],
	@UID  [varchar]  (36),
	@SignRequestId  [int],
	@EventType  [char]  (1),
	@DigitalSign  [varchar]  (255),
	@Timestamp  [datetime],
	@SignEventDIF  [varchar]  (65)
) AS

	INSERT INTO [dbo].[EOPSignEvents] (
		[SignEventId], [UID], [SignRequestId], [EventType],
		[DigitalSign], [Timestamp], [SignEventDIF]
    ) VALUES (
			@SignEventId, @UID, @SignRequestId, @EventType,
			@DigitalSign, @Timestamp, @SignEventDIF
	)


GO
/****** Object:  StoredProcedure [dbo].[apdLogEntry]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[apdLogEntry] (
	@ClientApplicationId  [int],
	@SessionToken varchar(128),
	@LogTimestamp  [datetime],
	@LogEntryType  [char]  (1),
	@TraceGuid  [uniqueidentifier],
	@LogData varchar(MAX)
)
AS

	INSERT INTO [dbo].[LogEntries] (
		[ClientApplicationId], [SessionToken], [LogTimestamp],
		[LogEntryType], [TraceGuid], [LogData]
	) VALUES (
		@ClientApplicationId, @SessionToken, @LogTimestamp,
		@LogEntryType, @TraceGuid, @LogData
	)
GO
/****** Object:  StoredProcedure [dbo].[apdLRSImageProcessingTrail]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[apdLRSImageProcessingTrail] (
	@ImageName  [varchar]  (128),
	@ImageType  [char]  (1),
	@TrailTimestamp  [smalldatetime],
	@TrailMsg  [varchar]  (255),
	@DocumentId  [int],
	@ImagingItemId  [int],
	@ImagePath  [varchar]  (512),
	@TrailStatus  [char]  (1),
	@ExceptionData  [varchar]  (8000)
) AS

INSERT INTO [dbo].[LRSImageProcessingTrail] (
	[ImageName], [ImageType], [TrailTimestamp], [TrailMsg],
	[DocumentId], [ImagingItemId], [ImagePath], [TrailStatus], [ExceptionData]
) VALUES (
	@ImageName, @ImageType, @TrailTimestamp, @TrailMsg,
	@DocumentId, @ImagingItemId, @ImagePath, @TrailStatus, @ExceptionData
)
GO
/****** Object:  StoredProcedure [dbo].[apdUserSession]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[apdUserSession] (
   @SessionToken varchar(128),
   @ServerId [int],
   @ClientAppId [int],
   @UserId [int],
   @ExpiresIn [int],
   @RefreshToken varchar(64),
   @SessionExtData varchar(2048),
   @StartTime [smalldatetime],
   @EndTime [smalldatetime]
)
AS
	BEGIN
		INSERT INTO [dbo].[UserSessions] (
			[SessionToken], [ServerId], [ClientAppId], [UserId], [ExpiresIn], [RefreshToken],
			[SessionExtData], [StartTime], [EndTime]
		) VALUES (
			@SessionToken, @ServerId, @ClientAppId, @UserId, @ExpiresIn, @RefreshToken,
			@SessionExtData, @StartTime, @EndTime
		)
		SELECT CAST(SCOPE_IDENTITY() AS int);
	END

GO
/****** Object:  StoredProcedure [dbo].[doCloseUserSession]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[doCloseUserSession] (
   @SessionToken varchar(128),
   @EndTime [smalldatetime]
)
AS
	UPDATE [dbo].[UserSessions]
	SET
       EndTime = @EndTime
	WHERE
	   (SessionToken = @SessionToken)
GO
/****** Object:  StoredProcedure [dbo].[doLRSUpdateESignJobs]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[doLRSUpdateESignJobs]
AS
BEGIN TRANSACTION


	INSERT INTO [EOPSignableDocuments]
			   (SignableDocumentId,
			   [UID]
			   ,[DocumentType]
			   ,[TransactionNo]
			   ,[DocumentNo]
			   ,[Description]
			   ,[RequestedBy]
			   ,[RequestedTime]
			   ,[SignInputData]
			   ,[ExtData]
			   ,[Keywords]
			   ,[PostingTime]
			   ,[PostedById]
			   ,[SignStatus]
			   ,[SignableDocumentDIF])
			   SELECT
				CertificateId,
				NEWID(),
				DisplayName,
				TransactionUID,
				CertificateUID,
				'',
				RequestedBy,
				PresentationTime,
				'||1.0|' + CertificateUID + '||',
				'',
				CertificateKeywords,
				PostingTime,
				PostedById,
				'P',
				''
	FROM Land.dbo.LRSCertificates INNER JOIN
		 Land.dbo.LRSTransactions ON Land.dbo.LRSCertificates.TransactionId = Land.dbo.LRSTransactions.TransactionId INNER JOIN
		 Land.dbo.Types ON Land.dbo.LRSCertificates.CertificateTypeId = Land.dbo.Types.TypeId
	WHERE LRSTransactions.TransactionStatus IN ('S', 'A') AND CertificateStatus = 'C' and IssueTime >= '2018-07-10'
		 AND Land.dbo.LRSCertificates.CertificateUID NOT IN (SELECT DocumentNo FROM [EOPSignableDocuments])


	INSERT INTO [EOPSignableDocuments]
			   (SignableDocumentId,
			   [UID]
			   ,[DocumentType]
			   ,[TransactionNo]
			   ,[DocumentNo]
			   ,[Description]
			   ,[RequestedBy]
			   ,[RequestedTime]
			   ,[SignInputData]
			   ,[ExtData]
			   ,[Keywords]
			   ,[PostingTime]
			   ,[PostedById]
			   ,[SignStatus]
			   ,[SignableDocumentDIF])
			   SELECT
				LRSDocuments.DocumentId + 1000000,
				NEWID(),
				ObjectName,
				TransactionUID,
				DocumentUID,
				'',
				RequestedBy,
				LRSDocuments.PresentationTime,
							'||1.0|' + DocumentUID + '||',
				'',
				DocumentKeywords,
				AuthorizationTime,
				PostedById,
				'P',
				''
	FROM  Land.dbo.LRSDocuments INNER JOIN
		  Land.dbo.LRSTransactions ON Land.dbo.LRSDocuments.DocumentId = Land.dbo.LRSTransactions.DocumentId INNER JOIN
		  Land.dbo.SimpleObjects ON Land.dbo.LRSDocuments.DocumentSubtypeId = Land.dbo.SimpleObjects.ObjectId
	WHERE LRSTransactions.TransactionStatus IN ('S', 'A') AND LRSDocuments.DocumentStatus = 'C' AND AuthorizationTime >= '2018-07-10' AND Land.dbo.LRSDocuments.DocumentId <> -1
		 AND Land.dbo.LRSDocuments.DocumentUID NOT IN (SELECT DocumentNo FROM [EOPSignableDocuments])


	INSERT INTO [EOPSignRequests]
			   ([SignRequestId]
			   ,[UID]
			   ,[RequestedById]
			   ,[RequestedTime]
			   ,[RequestedToId]
			   ,[SignableDocumentId]
			   ,[SignatureKind]
			   ,[ExtData]
			   ,[SignStatus]
			   ,[SignTime]
			   ,[DigitalSign]
			   ,[SignRequestDIF])
	select CertificateId, NEWID(), PostedById, IssueTime, 36, CertificateId, 'Autorizado por', '', 'P', '2078-12-31', '', ''
	FROM  Land.dbo.LRSCertificates INNER JOIN Land.dbo.LRSTransactions ON
	Land.dbo.LRSCertificates.TransactionId = Land.dbo.LRSTransactions.TransactionId
	WHERE LRSTransactions.TransactionStatus IN ('S', 'A') AND CertificateStatus = 'C' and IssueTime >= '2018-07-10'
		 AND Land.dbo.LRSCertificates.CertificateUID IN (SELECT DocumentNo FROM [EOPSignableDocuments])
	AND CertificateId NOT IN (SELECT SignableDocumentId FROM [EOPSignRequests])

	INSERT INTO [EOPSignRequests]
			   ([SignRequestId]
			   ,[UID]
			   ,[RequestedById]
			   ,[RequestedTime]
			   ,[RequestedToId]
			   ,[SignableDocumentId]
			   ,[SignatureKind]
			   ,[ExtData]
			   ,[SignStatus]
			   ,[SignTime]
			   ,[DigitalSign]
			   ,[SignRequestDIF])
	SELECT Land.dbo.LRSDocuments.DocumentId + 1000000,
	NEWID(),
	PostedById,
	AuthorizationTime,
	36,
	Land.dbo.LRSDocuments.DocumentId + 1000000,
	'Autorizado por', '', 'P', '2078-12-31', '', ''
	FROM  Land.dbo.LRSDocuments  INNER JOIN Land.dbo.LRSTransactions ON
	Land.dbo.LRSDocuments.DocumentId = Land.dbo.LRSTransactions.DocumentId
	WHERE LRSTransactions.TransactionStatus IN ('S', 'A') AND DocumentStatus = 'C' and AuthorizationTime >= '2018-07-10'
	AND Land.dbo.LRSDocuments.DocumentId <> -1
	AND Land.dbo.LRSDocuments.DocumentUID IN (SELECT DocumentNo FROM [EOPSignableDocuments])
	AND Land.dbo.LRSDocuments.DocumentId + 1000000 NOT IN (SELECT SignableDocumentId FROM [EOPSignRequests])


COMMIT
GO
/****** Object:  StoredProcedure [dbo].[doLRSUpdateRecordingActResourceExtData]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[doLRSUpdateRecordingActResourceExtData] (
  @RecordingActId [int],
  @RecordingActResourceExtData varchar (8000)
) AS

	UPDATE LRSRecordingActs
	SET  RecordingActResourceExtData = @RecordingActResourceExtData
	WHERE (RecordingActId = @RecordingActId)

GO
/****** Object:  StoredProcedure [dbo].[doLRSUpdateRecordingsImageIndexes]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create PROCEDURE [dbo].[doLRSUpdateRecordingsImageIndexes] (
  @RecordingBookId [int],
  @StartImageIndex [int],
  @IndexOffset [int]
) AS
BEGIN TRANSACTION

	UPDATE LRSRecordings
	SET  RecordingBookFirstImage = RecordingBookFirstImage + @IndexOffset
	WHERE ((RecordingBookId = @RecordingBookId) AND
	       (RecordingBookFirstImage >= @StartImageIndex))

	UPDATE LRSRecordings
	SET  RecordingBookLastImage = RecordingBookLastImage + @IndexOffset
	WHERE ((RecordingBookId = @RecordingBookId) AND
	       (RecordingBookLastImage >= @StartImageIndex))

COMMIT
GO
/****** Object:  StoredProcedure [dbo].[doOptimization]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[doOptimization]
AS
begin
	exec dbo.sp_updatestats;
end
GO
/****** Object:  StoredProcedure [dbo].[getBaseObjectTypeInfoWithTypeName]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getBaseObjectTypeInfoWithTypeName] (
	@ClassName [varchar](128)
) AS

	SELECT TOP 1 *
	FROM  [dbo].[Types]
	WHERE (ClassName = @ClassName) AND (TypeName NOT LIKE '%.Empty')
	ORDER BY TypeName
	-- Excludes types ending with Empty used as PowerTypes empty instances.
	-- Because many Empiria types can be associated to the same underlying type (ClassName),
	-- the ORDER BY clause should get the most general Empiria type in the inheritance path.
RETURN
GO
/****** Object:  StoredProcedure [dbo].[getContactWithUserName]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getContactWithUserName] (
   @UserName varchar(48)
)
AS
	SELECT Contacts.*
	FROM Contacts
	WHERE (Contacts.UserName = @UserName);
RETURN
GO
/****** Object:  StoredProcedure [dbo].[getLRSPropertyWithUID]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getLRSPropertyWithUID] (
   @PropertyUID [varchar](32)
)
AS
	SELECT LRSProperties.*
	FROM LRSProperties
	WHERE (PropertyUID = @PropertyUID);
RETURN

GO
/****** Object:  StoredProcedure [dbo].[getLRSRecordingMainDocument]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getLRSRecordingMainDocument] (
   @RecordingId [int]
)
AS
	SELECT LRSDocuments.*
	FROM LRSDocuments INNER JOIN LRSRecordings
	ON LRSDocuments.DocumentId = LRSRecordings.DocumentId
	WHERE (LRSRecordings.RecordingId = @RecordingId AND DocumentRecordingRole = 'M');
RETURN


GO
/****** Object:  StoredProcedure [dbo].[getLRSRecordingWithRecordingNumber]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getLRSRecordingWithRecordingNumber] (
   @RecordingBookId int,
   @RecordingNumber varchar(128)
)
AS
	SELECT TOP 1 *
	FROM LRSRecordings
	WHERE (RecordingBookId = @RecordingBookId) AND (RecordingStatus <> 'X') AND
		  ((RecordingNumber = @RecordingNumber) OR RecordingNumber = (@RecordingNumber + ' BIS'))
	ORDER BY RecordingNumber DESC
RETURN



GO
/****** Object:  StoredProcedure [dbo].[getLRSWorkflowLastTask]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getLRSWorkflowLastTask] (
   @TransactionId int
)
AS

	SELECT *
	FROM   dbo.vwLRSLastTransactionTrack
	WHERE  (TransactionId = @TransactionId) AND (TrackStatus <> 'X')

RETURN
GO
/****** Object:  StoredProcedure [dbo].[getUserSession]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getUserSession] (
   @SessionToken varchar(128)
) AS
    SELECT *
	FROM UserSessions
	WHERE (SessionToken = @SessionToken)
RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryDBIntegrationRules]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create PROCEDURE [dbo].[qryDBIntegrationRules]
(
	@ServerId [int]
) AS
	SELECT *
	FROM DBRules
	WHERE (ServerId = @ServerId) AND (TargetServerId <> @ServerId)
	ORDER BY DbRuleType, SourceName, DbRuleIndex, TargetServerId
RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryDbQueryParameters]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[qryDbQueryParameters]
(
	@QueryName 	[varchar] (64)
)
AS
	SELECT '@' + Parameters.ParameterName AS [Name], ParameterDbType,
		   ParameterDirection, ParameterSize, ParameterScale, ParameterPrecision,
	       ParameterDefaultValue, ParametersCounter.ParameterCount, ParameterIndex FROM

	(	SELECT QueryName, COUNT(ParameterIndex) AS ParameterCount
		FROM   DBQueryParameters
		WHERE (QueryName = @QueryName)
		GROUP BY QueryName
	)  ParametersCounter

	INNER JOIN

	(
		SELECT ParameterName, ParameterDbType, ParameterDirection,
			   ParameterSize, ParameterScale, ParameterPrecision,
			   ParameterDefaultValue, ParameterIndex, QueryName
		FROM DBQueryParameters
		WHERE (QueryName = @QueryName)
	) Parameters

	ON ParametersCounter.QueryName = Parameters.QueryName

RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryDBQueryString]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[qryDBQueryString] (
	@QueryName [varchar] (64)
) AS
	SELECT *
	FROM  DBQueryStrings
	WHERE (QueryName = @QueryName)

RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryDBRule]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[qryDBRule]  (
	@DbRuleType [char](1),
	@ServerId [int],
	@SourceName [varchar] (64),
	@TypeId [int]
) AS
	SELECT *
	FROM DBRules
	WHERE (DbRuleType = @DbRuleType) AND
		  (ServerId = @ServerId) AND (TargetServerId = @ServerId) AND
		  (SourceName = @SourceName) AND (TypeId = @TypeId)
RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryLRSCertificatesByTransaction]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[qryLRSCertificatesByTransaction] (
	@TransactionId int
)
AS

	SELECT LRSCertificates.*
	FROM  dbo.LRSCertificates
	WHERE (dbo.LRSCertificates.TransactionId = @TransactionId) AND
	      (dbo.LRSCertificates.CertificateStatus <> 'X')

RETURN

GO
/****** Object:  StoredProcedure [dbo].[qryLRSContactsWithWorkflowOutboxTasks]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[qryLRSContactsWithWorkflowOutboxTasks]
AS
	SELECT DISTINCT Contacts.*
	FROM  dbo.LRSTransactionTrack INNER JOIN dbo.Contacts
	ON dbo.LRSTransactionTrack.ResponsibleId = dbo.Contacts.ContactId
	WHERE (dbo.LRSTransactionTrack.TrackStatus =  'D')
	ORDER BY dbo.Contacts.ShortName
RETURN

GO
/****** Object:  StoredProcedure [dbo].[qryLRSPhysicalBookRecordings]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[qryLRSPhysicalBookRecordings] (
   @PhysicalBookId int
)
AS
	SELECT *
	FROM dbo.LRSPhysicalRecordings
	WHERE (PhysicalBookId = @PhysicalBookId) AND (RecordingStatus <> 'X')
	ORDER BY RecordingNo, PhysicalRecordingId
RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryLRSPhysicalRecordingRecordedActs]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[qryLRSPhysicalRecordingRecordedActs] (
   @PhysicalRecordingId int
)
AS
	SELECT *
	FROM LRSRecordingActs
	WHERE (PhysicalRecordingId = @PhysicalRecordingId) AND (RecordingActStatus <> 'X')
	ORDER BY RecordingActId;
RETURN

GO
/****** Object:  StoredProcedure [dbo].[qryLRSPhysicalRecordingResources]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[qryLRSPhysicalRecordingResources] (
   @PhysicalRecordingId int
)
AS
	SELECT DISTINCT dbo.LRSProperties.*
	FROM  dbo.LRSRecordingActs INNER JOIN dbo.LRSProperties
	ON dbo.LRSRecordingActs.ResourceId = dbo.LRSProperties.PropertyId
	WHERE (dbo.LRSRecordingActs.PhysicalRecordingId = @PhysicalRecordingId) AND
		  (dbo.LRSRecordingActs.RecordingActStatus <> 'X')
	ORDER BY dbo.LRSProperties.PropertyUID
RETURN


GO
/****** Object:  StoredProcedure [dbo].[qryLRSRealEstatePartitions]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[qryLRSRealEstatePartitions] (
   @PropertyId int
)
AS

   SELECT  *
   FROM  dbo.LRSProperties
   WHERE (PartitionOfId = @PropertyId) AND (PropertyStatus <> 'X')
   ORDER BY PartitionNo

RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryLRSRecordingPayments]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[qryLRSRecordingPayments] (
   @PhysicalRecordingId int
)
AS
	SELECT *
	FROM dbo.LRSPayments
	WHERE (PhysicalRecordingId = @PhysicalRecordingId) AND (PaymentStatus <> 'X')
	ORDER BY ReceiptIssuedTime;
RETURN


GO
/****** Object:  StoredProcedure [dbo].[qryLRSResourceActiveOwnershipRecordingActParties]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[qryLRSResourceActiveOwnershipRecordingActParties] (
	@ResourceId int
)
AS

	SELECT DISTINCT dbo.LRSRecordingActParties.*
	FROM dbo.LRSRecordingActParties INNER JOIN dbo.LRSRecordingActs
	ON dbo.LRSRecordingActParties.RecordingActId = dbo.LRSRecordingActs.RecordingActId
	WHERE (dbo.LRSRecordingActs.ResourceId = @ResourceId) AND
		  (dbo.LRSRecordingActs.ResourceRole IN ('P', 'C', 'E', 'I')) AND
		  (dbo.LRSRecordingActs.RecordingActStatus <> 'X') AND
	      (dbo.LRSRecordingActParties.IsOwnershipStillActive = 1) AND
		  (dbo.LRSRecordingActParties.RecActPartyStatus <> 'X')
RETURN

GO
/****** Object:  StoredProcedure [dbo].[qryLRSResourceEmittedCertificates]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[qryLRSResourceEmittedCertificates] (
   @ResourceId int
)
AS
   SELECT  LRSCertificates.*
   FROM  dbo.LRSCertificates INNER JOIN dbo.LRSTransactions
   ON dbo.LRSCertificates.TransactionId = dbo.LRSTransactions.TransactionId
   WHERE (PropertyId = @ResourceId) AND
		 (dbo.LRSCertificates.CertificateStatus <> 'X')
   ORDER BY dbo.LRSTransactions.PresentationTime, dbo.LRSCertificates.CertificateId
RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryLRSResourceFullTractIndex]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[qryLRSResourceFullTractIndex] (
   @ResourceId int
)
AS
   SELECT  LRSRecordingActs.*
   FROM  dbo.LRSRecordingActs INNER JOIN dbo.LRSDocuments
   ON dbo.LRSRecordingActs.DocumentId = dbo.LRSDocuments.DocumentId
   WHERE (dbo.LRSRecordingActs.ResourceId = @ResourceId OR
		  dbo.LRSRecordingActs.RelatedResourceId = @ResourceId) AND (dbo.LRSRecordingActs.RecordingActStatus <> 'X')
   ORDER BY dbo.LRSDocuments.PresentationTime, dbo.LRSRecordingActs.DocumentId, dbo.LRSRecordingActs.RecordingActIndex
RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryLRSResourceRecordingActs]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[qryLRSResourceRecordingActs] (
   @ResourceId int
)
AS
   SELECT  LRSRecordingActs.*
   FROM  dbo.LRSRecordingActs INNER JOIN dbo.LRSDocuments
   ON dbo.LRSRecordingActs.DocumentId = dbo.LRSDocuments.DocumentId
   WHERE (dbo.LRSRecordingActs.ResourceId = @ResourceId) AND
		 (dbo.LRSRecordingActs.RecordingActStatus <> 'X')
   ORDER BY dbo.LRSDocuments.PresentationTime, dbo.LRSRecordingActs.DocumentId, dbo.LRSRecordingActs.RecordingActIndex
RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryLRSRootRecordingBooks]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[qryLRSRootRecordingBooks] (
		@RecorderOfficeId int
)
AS
	SELECT *
	FROM LRSRecordingBooks
	WHERE ((RecorderOfficeId = @RecorderOfficeId) AND (ParentRecordingBookId = -1))
RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryLRSTransactionItems]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[qryLRSTransactionItems] (
   @TransactionId int
)
AS
	SELECT *
	FROM dbo.LRSTransactionItems
	WHERE (TransactionId = @TransactionId) AND (dbo.LRSTransactionItems.TransactionItemStatus <> 'X')
	ORDER BY TransactionItemId;
RETURN

GO
/****** Object:  StoredProcedure [dbo].[qryLRSTransactionPayments]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[qryLRSTransactionPayments] (
   @TransactionId int
)
AS
	SELECT *
	FROM dbo.LRSPayments
	WHERE (TransactionId = @TransactionId) AND (PaymentStatus <> 'X')
	ORDER BY ReceiptIssuedTime;
RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryLRSWorkflowTrack]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[qryLRSWorkflowTrack] (
   @TransactionId int
)
AS
	SELECT *
	FROM dbo.LRSTransactionTrack
	WHERE (TransactionId = @TransactionId) AND (TrackStatus <> 'X')
	ORDER BY TrackId;
RETURN

GO
/****** Object:  StoredProcedure [dbo].[qryResourceSecurityClaims]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[qryResourceSecurityClaims] (
   @SubjectToken varchar(64)
) AS
	SELECT  dbo.SecurityClaims.*
	FROM dbo.SecurityClaims
	WHERE (dbo.SecurityClaims.SubjectToken = @SubjectToken) AND
		  (dbo.SecurityClaims.ClaimStatus = 'A')
RETURN
GO
/****** Object:  StoredProcedure [dbo].[qrySimpleObjects]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[qrySimpleObjects] (
	@ObjectTypeId [int]
)
AS
	SELECT *
	FROM SimpleObjects
	WHERE (ObjectTypeId = @ObjectTypeId) AND (ObjectStatus <> 'X')
	ORDER BY ObjectName
RETURN
GO
/****** Object:  StoredProcedure [dbo].[qryTypeRelations]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[qryTypeRelations] (
	@TypeName [varchar](255)
) AS
SELECT *
FROM  dbo.tabTypeRelations(@TypeName)
RETURN
GO
/****** Object:  StoredProcedure [dbo].[rptLRSTransactions]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rptLRSTransactions] (
   @FromDate smalldatetime,
   @ToDate smalldatetime
)
AS
SELECT TOP (100) PERCENT TransactionType, RecorderOffice, TransactionUID,
RequestedBy, DocumentDescriptor, ReceiptNo, PaymentsTotal, PresentationTime,
CurrentTransactionStatusName AS CurrentStatusName, Responsible
FROM  dbo.vwLRSTransactionsAndCurrentTrack
WHERE (PresentationTime >= @FromDate AND  PresentationTime < @ToDate) AND
      (TransactionStatus NOT IN ('Y', 'X'))
ORDER BY TransactionType, RecorderOffice, PresentationTime
RETURN


GO
/****** Object:  StoredProcedure [dbo].[rptLRSTransactionsInProcess]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rptLRSTransactionsInProcess] (
   @FromDate smalldatetime,
   @ToDate smalldatetime
)
AS
	SELECT DISTINCT ResponsibleId, Responsible, CurrentTransactionStatus, CurrentTransactionStatusName,
	COUNT(*) AS TransactionsCount, MIN(CheckInTime) AS FirstTransaction, MAX(CheckInTime) AS LastTransaction,
	SUM(DATEDIFF(DAY, CheckInTime, GETDATE())) AS TotalDays
	FROM [vwLRSTransactionsAndCurrentTrack]
	WHERE @FromDate <= PresentationTime AND PresentationTime <= @ToDate
	and TransactionStatus NOT IN ('X', 'Y', 'C', 'Q', 'H')
	GROUP BY ResponsibleId, Responsible, CurrentTransactionStatus, CurrentTransactionStatusName
	ORDER BY COUNT(*) DESC
RETURN

GO
/****** Object:  StoredProcedure [dbo].[rptLRSTransactionsTotals]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rptLRSTransactionsTotals] (
   @FromDate smalldatetime,
   @ToDate smalldatetime
)
AS
	SELECT RecorderOffice, COUNT(*) AS TotalTransactions,
				 SUM(CASE WHEN TransactionTypeId = 700 THEN 1 ELSE 0 END) AS RecordingTransactions,
				 SUM(CASE WHEN TransactionTypeId = 702 THEN 1 ELSE 0 END) AS CertificateExpedition,
				 SUM(CASE WHEN TransactionTypeId = 704 THEN 1 ELSE 0 END) AS CommercialTransactions,
				 SUM(CASE WHEN TransactionTypeId = 707 THEN 1 ELSE 0 END) AS Procede
	FROM   dbo.vwLRSTransactionsAndCurrentTrack
	WHERE (PresentationTime >= @FromDate AND  PresentationTime < @ToDate) AND
	      (TransactionStatus NOT IN ('Y', 'X'))
	GROUP BY RecorderOffice
	ORDER BY TotalTransactions DESC, RecorderOffice
RETURN


GO
/****** Object:  StoredProcedure [dbo].[rptLRSVolumeBooks]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rptLRSVolumeBooks] (
   @RecorderOfficeId int,
   @BookStatus char(1)
) AS

IF (@RecorderOfficeId <> -1)
	SELECT *
	FROM vwLRSVolumes
	WHERE (RecorderOfficeId = @RecorderOfficeId) AND
	      (BookStatus = @BookStatus)
ELSE
	SELECT *
	FROM vwLRSVolumes
	WHERE  (BookStatus = @BookStatus)

RETURN
GO
/****** Object:  StoredProcedure [dbo].[setLRSDocumentImagingControlID]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[setLRSDocumentImagingControlID] (
  @DocumentId [int],
  @ImagingControlID varchar(32)
) AS
BEGIN TRANSACTION

	IF NOT EXISTS(SELECT * FROM [dbo].LRSDocuments WHERE (ImagingControlID = @ImagingControlID))
	BEGIN
		UPDATE LRSDocuments
		SET  ImagingControlID = @ImagingControlID
		WHERE (DocumentId = @DocumentId)
	END
	ELSE
	   THROW 51004, 'There is already a document with the same imaging control ID.', 1;

COMMIT
GO
/****** Object:  StoredProcedure [dbo].[writeContact]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[writeContact] (
	@ContactId  [int],
	@ContactTypeId  [int],
	@ContactFullName  [varchar]  (255),
	@FirstName  [varchar]  (64),
	@LastName  [varchar]  (64),
	@LastName2  [varchar]  (64),
	@ShortName  [varchar]  (128),
	@Nickname  [varchar]  (48),
	@ContactTags  [varchar]  (255),
	@ContactExtData  [varchar]  (8000),
	@ContactKeywords  [varchar]  (1024),
	@ContactEmail  [varchar]  (48),
	@ContactStatus  [char]  (1)
) AS
IF NOT EXISTS(SELECT * FROM [dbo].[Contacts] WHERE ([ContactId] = @ContactId))
   BEGIN
		INSERT INTO [dbo].[Contacts]  (
		 [ContactId], [ContactTypeId], [ContactFullName], [FirstName], [LastName], [LastName2],
		 [ShortName], [Nickname], [ContactTags], [ContactExtData], [ContactKeywords],
		 [UserName], [UserPassword], [ContactEmail], [ContactStatus]
		) VALUES (
		@ContactId, @ContactTypeId, @ContactFullName, @FirstName, @LastName, @LastName2,
		@ShortName, @Nickname, @ContactTags, @ContactExtData, @ContactKeywords,
		'', '', @ContactEmail, @ContactStatus)

   END
ELSE
   BEGIN
	UPDATE [dbo].[Contacts]
	SET
	 [ContactTypeId] = @ContactTypeId ,
	 [ContactFullName] = @ContactFullName ,
	 [FirstName] = @FirstName ,
	 [LastName] = @LastName ,
	 [LastName2] = @LastName2 ,
	 [ShortName] = @ShortName ,
	 [Nickname] = @Nickname ,
	 [ContactTags] = @ContactTags ,
	 [ContactExtData] = @ContactExtData ,
	 [ContactKeywords] = @ContactKeywords ,
	 [ContactEmail] = @ContactEmail ,
	 [ContactStatus] = @ContactStatus
WHERE ([ContactId] = @ContactId)
END
GO
/****** Object:  StoredProcedure [dbo].[writeEOPFilingRequest]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeEOPFilingRequest] (
	@FilingRequestId [int],
	@FilingRequestUID [varchar] (36),
	@ProcedureId [int],
	@RequestedBy [varchar] (512),
	@AgencyId [int],
	@AgentId [int],
	@RequestExtData varchar(MAX),
	@RequestKeywords [varchar] (4000),
	@LastUpdateTime [smalldatetime],
	@PostingTime [smalldatetime],
	@PostedById [int],
	@RequestStatus [char]  (1),
	@FilingRequestDIF [varchar] (65)
) AS
IF NOT EXISTS(SELECT 1 FROM [dbo].[EOPFilingRequests] WHERE ([FilingRequestId] = @FilingRequestId))
   BEGIN
		INSERT INTO [dbo].[EOPFilingRequests] (
			[FilingRequestId],[FilingRequestUID], [ProcedureId],
			[RequestedBy], [AgencyId], [AgentId], [RequestExtData], [RequestKeywords],
			[LastUpdateTime], [PostingTime], [PostedById], [RequestStatus], [FilingRequestDIF]
		) VALUES (
			@FilingRequestId, @FilingRequestUID, @ProcedureId,
			@RequestedBy, @AgencyId, @AgentId, @RequestExtData, @RequestKeywords,
			@LastUpdateTime, @PostingTime, @PostedById, @RequestStatus, @FilingRequestDIF
        )
   END
ELSE
   BEGIN
		UPDATE [dbo].[EOPFilingRequests]
		 SET
			 --[FilingRequestId] = @FilingRequestId ,
			 --[FilingRequestUID] = @FilingRequestUID ,
			 --[ProcedureId] = @ProcedureId ,
			 [RequestedBy] = @RequestedBy ,
			 [AgencyId] = @AgencyId ,
			 [AgentId] = @AgentId ,
			 [RequestExtData] = @RequestExtData ,
			 [RequestKeywords] = @RequestKeywords ,
			 [LastUpdateTime] = @LastUpdateTime ,
			 [PostingTime] = @PostingTime ,
			 [PostedById] = @PostedById ,
			 [RequestStatus] = @RequestStatus ,
			 [FilingRequestDIF] = @FilingRequestDIF
		WHERE
			([FilingRequestId] = @FilingRequestId) AND ([FilingRequestUID] = @FilingRequestUID)

END
GO
/****** Object:  StoredProcedure [dbo].[writeEOPSignableDocument]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeEOPSignableDocument] (
	@SignableDocumentId  [int],
	@UID  [varchar]  (36),
	@DocumentType  [varchar]  (128),
	@TransactionNo  [varchar]  (64),
	@DocumentNo  [varchar]  (64),
	@Description  [varchar]  (255),
	@RequestedBy  [varchar]  (512),
	@RequestedTime  [smalldatetime],
	@SignInputData  varchar(MAX),
	@ExtData  varchar(MAX),
	@Keywords  [varchar]  (2048),
	@PostingTime  [smalldatetime],
	@PostedById  [int],
	@SignStatus  [char]  (1),
	@SignableDocumentDIF  [varchar]  (65)
) AS
IF NOT EXISTS( SELECT 1 FROM [dbo].[EOPSignableDocuments] WHERE (@SignableDocumentId = @SignableDocumentId))
   BEGIN
	INSERT INTO [dbo].[EOPSignableDocuments] (
		[SignableDocumentId], [UID], [DocumentType], [TransactionNo],
		[DocumentNo], [Description], [RequestedBy], [RequestedTime],
		[SignInputData], [ExtData], [Keywords],
		[PostingTime], [PostedById], [SignStatus], [SignableDocumentDIF]
    )  VALUES (
		@SignableDocumentId, @UID, @DocumentType, @TransactionNo,
		@DocumentNo, @Description, @RequestedBy, @RequestedTime,
		@SignInputData, @ExtData, @Keywords,
		@PostingTime, @PostedById, @SignStatus, @SignableDocumentDIF
    )
   END
ELSE
   BEGIN
      UPDATE [dbo].[EOPSignableDocuments]
		SET
		 --[SignableDocumentId] = @SignableDocumentId ,
		 --[UID] = @UID ,
		 --[DocumentType] = @DocumentType ,
		 --[TransactionNo] = @TransactionNo ,
		 [DocumentNo] = @DocumentNo ,
		 [Description] = @Description ,
		 [RequestedBy] = @RequestedBy ,
		 [RequestedTime] = @RequestedTime ,
		 [SignInputData] = @SignInputData ,
		 [ExtData] = @ExtData ,
		 [Keywords] = @Keywords ,
		 [PostingTime] = @PostingTime ,
		 [PostedById] = @PostedById ,
		 [SignStatus] = @SignStatus ,
		 [SignableDocumentDIF] = @SignableDocumentDIF
	  WHERE ([SignableDocumentId] = @SignableDocumentId AND [UID] = @UID)
END

GO
/****** Object:  StoredProcedure [dbo].[writeEOPSignRequest]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeEOPSignRequest] (
	@SignRequestId  [int],
	@UID  [varchar]  (36),
	@RequestedById  [int],
	@RequestedTime  [smalldatetime],
	@RequestedToId  [int],
	@SignableDocumentId  [int],
	@SignatureKind  [varchar]  (32),
	@ExtData  [text],
	@SignStatus  [char]  (1),
	@SignTime  [datetime],
	@DigitalSign  [varchar]  (255),
	@SignRequestDIF  [varchar]  (65)
) AS
IF NOT EXISTS( SELECT 1 FROM [dbo].[EOPSignRequests] WHERE ([SignRequestId] = @SignRequestId))
   BEGIN
		INSERT INTO [dbo].[EOPSignRequests] (
			[SignRequestId], [UID], [RequestedById], [RequestedTime], [RequestedToId],
			[SignableDocumentId], [SignatureKind], [ExtData], [SignStatus],
			[SignTime], [DigitalSign], [SignRequestDIF]
		) VALUES (
			@SignRequestId, @UID, @RequestedById, @RequestedTime, @RequestedToId,
			@SignableDocumentId, @SignatureKind, @ExtData, @SignStatus,
			@SignTime, @DigitalSign,	@SignRequestDIF
	    )
   END
ELSE
   BEGIN
		UPDATE [dbo].[EOPSignRequests]
		 SET
			 --[SignRequestId] = @SignRequestId ,
			 --[UID] = @UID ,
			 --[RequestedById] = @RequestedById ,
			 --[RequestedTime] = @RequestedTime ,
			 --[RequestedToId] = @RequestedToId ,
			 --[SignableDocumentId] = @SignableDocumentId ,
			 --[SignatureKind] = @SignatureKind ,
			 -- [ExtData] = @ExtData ,
			 [SignStatus] = @SignStatus ,
			 [SignTime] = @SignTime ,
			 [DigitalSign] = @DigitalSign ,
			 [SignRequestDIF] = @SignRequestDIF
		WHERE
			([SignRequestId] = @SignRequestId) AND ([UID] = @UID)

   END

GO
/****** Object:  StoredProcedure [dbo].[writeGeoItem]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[writeGeoItem] (
	@GeoItemId  [int],
	@GeoItemTypeId  [int],
	@GeoItemName  [varchar]  (128),
	@GeoItemFullName  [varchar]  (512),
	@GeoItemExtData  [varchar]  (8000),
	@GeoItemKeywords  [varchar]  (512),
	@GeoItemParentId  [int],
	@GeoItemStatus  [char]  (1),
	@StartDate  [smalldatetime],
	@EndDate  [smalldatetime]
) AS
IF NOT EXISTS(SELECT 1 FROM [dbo].[GeoItems] WHERE ([GeoItemId] = @GeoItemId))
   BEGIN
		INSERT INTO [dbo].[GeoItems] (
			[GeoItemId], [GeoItemTypeId], [GeoItemName], [GeoItemFullName], [GeoItemExtData],
			[GeoItemKeywords], [GeoItemParentId], [GeoItemStatus], [StartDate], [EndDate]
		) VALUES (
			@GeoItemId, @GeoItemTypeId, @GeoItemName, @GeoItemFullName, @GeoItemExtData,
			@GeoItemKeywords, @GeoItemParentId, @GeoItemStatus, @StartDate, @EndDate
		)
   END
ELSE
   BEGIN
     UPDATE [dbo].[GeoItems]
	 SET
	 [GeoItemName] = @GeoItemName ,
	 [GeoItemFullName] = @GeoItemFullName ,
	 [GeoItemExtData] = @GeoItemExtData ,
	 [GeoItemKeywords] = @GeoItemKeywords ,
	 [GeoItemParentId] = @GeoItemParentId ,
	 [GeoItemStatus] = @GeoItemStatus ,
	 [StartDate] = @StartDate ,
	 [EndDate] = @EndDate
	WHERE ([GeoItemId] = @GeoItemId) AND ([GeoItemTypeId] = @GeoItemTypeId)
END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSCertificate]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[writeLRSCertificate] (
	@CertificateId  [int],
	@CertificateTypeId  [int],
	@CertificateUID  [varchar]  (32),
	@TransactionId  [int],
	@RecorderOfficeId  [int],
	@PropertyId  [int],
	@OwnerName  [varchar]  (512),
	@CertificateNotes  [varchar]  (1024),
	@CertificateExtData  [text],
	@CertificateAsText  [text],
	@CertificateKeywords  [varchar]  (2048),
	@IssueTime  [smalldatetime],
	@IssuedById  [int],
	@IssueMode  [char]  (1),
	@PostedById  [int],
	@PostingTime  [smalldatetime],
	@CertificateStatus  [char]  (1),
	@CertificateDIF  [varchar]  (65)
)
AS IF NOT EXISTS( SELECT 1 FROM [dbo].[LRSCertificates] WHERE (CertificateId = @CertificateId) )
   BEGIN
		INSERT INTO [dbo].[LRSCertificates] (
			[CertificateId], [CertificateTypeId], [CertificateUID], [TransactionId],
			[RecorderOfficeId], [PropertyId], [OwnerName],
			[CertificateNotes], [CertificateExtData], [CertificateAsText], [CertificateKeywords],
			[IssueTime], [IssuedById], [IssueMode], [PostedById], [PostingTime],
			[CertificateStatus], [CertificateDIF]
		) VALUES (
			@CertificateId, @CertificateTypeId, @CertificateUID, @TransactionId,
			@RecorderOfficeId, @PropertyId, @OwnerName,
			@CertificateNotes, @CertificateExtData, @CertificateAsText, @CertificateKeywords,
			@IssueTime, @IssuedById, @IssueMode, @PostedById, @PostingTime,
			@CertificateStatus, @CertificateDIF
		)

   END
ELSE
   BEGIN
		UPDATE [dbo].[LRSCertificates]
		 SET
			 --[CertificateId] = @CertificateId ,
			 --[CertificateUID] = @CertificateUID,
			 --[TransactionId] = @TransactionId,
			 [CertificateTypeId] = @CertificateTypeId ,
			 [RecorderOfficeId] = @RecorderOfficeId ,
			 [PropertyId] = @PropertyId ,
			 [OwnerName] = @OwnerName ,
			 [CertificateNotes] = @CertificateNotes ,
			 [CertificateExtData] = @CertificateExtData,
			 [CertificateAsText] = @CertificateAsText ,
			 [CertificateKeywords] = @CertificateKeywords ,
			 [IssueTime] = @IssueTime ,
			 [IssuedById] = @IssuedById ,
			 [IssueMode] = @IssueMode ,
			 --[PostedById] = @PostedById ,
			 --[PostingTime] = @PostingTime ,
			 [CertificateStatus] = @CertificateStatus ,
			 [CertificateDIF] = @CertificateDIF
		WHERE
			([CertificateId] = @CertificateId) AND
			(CertificateUID = @CertificateUID) AND (TransactionId = @TransactionId)
  END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSDocument]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeLRSDocument] (
	@DocumentId  [int],
	@DocumentTypeId  [int],
	@DocumentSubtypeId  [int],
	@DocumentUID  [varchar]  (32),
	@ImagingControlID  [varchar]  (32),
	@DocumentOverview  varchar(MAX),
	@DocumentAsText  [varchar]  (512),
	@DocumentExtData  [varchar]  (4000),
	@DocumentKeywords  [varchar]  (2048),
	@PresentationTime  [datetime],
	@AuthorizationTime  [smalldatetime],
	@IssuePlaceId  [int],
	@IssueOfficeId  [int],
	@IssuedById  [int],
	@IssueDate  [smalldatetime],
	@SheetsCount  [int],
	@DocumentStatus  [char]  (1),
	@PostedById  [int],
	@PostingTime  [smalldatetime],
	@DocumentDIF  [varchar]  (65)
) AS
IF NOT EXISTS( SELECT 1 FROM [dbo].[LRSDocuments] WHERE ([DocumentId] = @DocumentId))
   BEGIN
	  INSERT INTO [dbo].[LRSDocuments] (
		[DocumentId], [DocumentTypeId], [DocumentSubtypeId], [DocumentUID], [ImagingControlID],
		[DocumentOverview], [DocumentAsText], [DocumentExtData], [DocumentKeywords],
		[PresentationTime], [AuthorizationTime], [IssuePlaceId], [IssueOfficeId], [IssuedById], [IssueDate],
		[SheetsCount], [DocumentStatus], [PostedById], [PostingTime], [DocumentDIF]
	  ) VALUES (
		@DocumentId, @DocumentTypeId, @DocumentSubtypeId, @DocumentUID, @ImagingControlID,
		@DocumentOverview, @DocumentAsText, @DocumentExtData, @DocumentKeywords,
		@PresentationTime, @AuthorizationTime, @IssuePlaceId, @IssueOfficeId, @IssuedById, @IssueDate,
		@SheetsCount, @DocumentStatus, @PostedById, @PostingTime, @DocumentDIF
	  )
   END
ELSE
   BEGIN
      UPDATE [dbo].[LRSDocuments]
		SET
		 [DocumentTypeId] = @DocumentTypeId ,
		 [DocumentSubtypeId] = @DocumentSubtypeId ,
		 --[DocumentUID] = @DocumentUID ,
		 --[ImagingControlID] = @ImagingControlID ,
		 [DocumentOverview] = @DocumentOverview ,
		 [DocumentAsText] = @DocumentAsText ,
		 [DocumentExtData] = @DocumentExtData ,
		 [DocumentKeywords] = @DocumentKeywords ,
		 --[PresentationTime] = @PresentationTime,
		 [AuthorizationTime] = @AuthorizationTime ,
		 [IssuePlaceId] = @IssuePlaceId ,
		 [IssueOfficeId] = @IssueOfficeId ,
		 [IssuedById] = @IssuedById ,
		 [IssueDate] = @IssueDate ,
		 [SheetsCount] = @SheetsCount ,
		 [DocumentStatus] = @DocumentStatus ,
		 [PostedById] = @PostedById ,
		 [PostingTime] = @PostingTime ,
		 [DocumentDIF] = @DocumentDIF
	  WHERE ([DocumentId] = @DocumentId AND DocumentUID = @DocumentUID)
   END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSImagingItem]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[writeLRSImagingItem] (
	@ImagingItemId  [int],
	@ImagingItemTypeId  [int],
	@TransactionId [int],
	@DocumentId  [int],
	@PhysicalBookId  [int],
	@ImageType  [char]  (1),
	@BaseFolderId  [int],
	@ImagingItemPath  [varchar]  (255),
	@ImagingItemExtData  [varchar]  (8000),
	@FilesCount  [int],
	@DigitalizedById [int],
	@DigitalizationDate [smalldatetime],
	@ImagingItemStatus char (1),
	@ImagingItemDIF  [varchar]  (65)
) AS
IF NOT EXISTS(SELECT 1 FROM [dbo].[LRSImagingItems] WHERE (ImagingItemId = @ImagingItemId))
   BEGIN
	INSERT INTO [dbo].[LRSImagingItems] (
		[ImagingItemId], [ImagingItemTypeId], [TransactionId], [DocumentId], [PhysicalBookId],
	    [ImageType], [BaseFolderId], [ImagingItemPath], [ImagingItemExtData],
	    [FilesCount], [DigitalizedById], [DigitalizationDate], [ImagingItemStatus], [ImagingItemDIF]
	) VALUES (
		@ImagingItemId, @ImagingItemTypeId, @TransactionId, @DocumentId, @PhysicalBookId,
		@ImageType, @BaseFolderId, @ImagingItemPath, @ImagingItemExtData,
		@FilesCount,  @DigitalizedById, @DigitalizationDate, @ImagingItemStatus, @ImagingItemDIF
	)
   END
ELSE
   BEGIN
	UPDATE [dbo].[LRSImagingItems]
	 SET
  --   [ImagingItemTypeId] = @ImagingItemTypeId ,
	 [DocumentId] = @DocumentId,
	 --[PhysicalBookId] = @PhysicalBookId,
	 --[DocumentImageType] = @DocumentImageType ,
	 --[BaseFolderId] = @BaseFolderId ,
	 --[ImagingItemPath] = @ImagingItemPath,
	 [ImagingItemExtData] = @ImagingItemExtData ,
	 [FilesCount] = @FilesCount ,
	 [DigitalizedById] = @DigitalizedById,
	 [DigitalizationDate] = @DigitalizationDate,
	 [ImagingItemStatus] = @ImagingItemStatus,
	 [ImagingItemDIF] = @ImagingItemDIF
	WHERE
		([ImagingItemId] = @ImagingItemId)
END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSParty]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[writeLRSParty] (
    @PartyId  [int],
	@PartyTypeId  [int],
	@PartyFullName  [varchar]  (255),
	@PartyNotes  [varchar]  (512),
	@PartyExtData  [varchar]  (8000),
	@PartyKeywords  [varchar]  (1024),
	@PartyStatus  [char]  (1),
	@PartyDIF  [varchar]  (65)
) AS
IF NOT EXISTS(SELECT 1 FROM [dbo].[LRSParties] WHERE ([PartyId] = @PartyId))
   BEGIN
		INSERT INTO [dbo].[LRSParties] (
			[PartyId], [PartyTypeId], [PartyFullName], [PartyNotes],
			[PartyExtData], [PartyKeywords], [PartyStatus], [PartyDIF]
		) VALUES (
			@PartyId, @PartyTypeId, @PartyFullName, @PartyNotes,
			@PartyExtData, @PartyKeywords, @PartyStatus, @PartyDIF
		)
   END
ELSE
   BEGIN
		UPDATE [dbo].[LRSParties]
		 SET
			 --[PartyId] = @PartyId ,
			 --[PartyTypeId] = @PartyTypeId ,
			 [PartyFullName] = @PartyFullName ,
			 [PartyNotes] = @PartyNotes ,
			 [PartyExtData] = @PartyExtData ,
			 [PartyKeywords] = @PartyKeywords ,
			 [PartyStatus] = @PartyStatus ,
			 [PartyDIF] = @PartyDIF
		WHERE
			([PartyId] = @PartyId) AND ([PartyStatus] <> 'C')
END

GO
/****** Object:  StoredProcedure [dbo].[writeLRSPayment]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeLRSPayment] (
	@PaymentId  [int],
	@TransactionId  [int],
	@PaymentOfficeId  [int],
	@ReceiptNo  [varchar]  (48),
	@ReceiptTotal  [decimal],
	@ReceiptIssuedTime  [smalldatetime],
	@PaymentExtData  [varchar]  (1024),
	@PhysicalRecordingId  [int],
	@PostingTime  [smalldatetime],
	@PostedById  [int],
	@PaymentStatus  [char]  (1),
	@PaymentDIF  [varchar]  (65)
)
AS IF NOT EXISTS( SELECT 1 FROM [dbo].[LRSPayments] WHERE ([PaymentId] = @PaymentId))
   BEGIN
	INSERT INTO [dbo].[LRSPayments] (
			[PaymentId], [TransactionId], [PaymentOfficeId], [ReceiptNo], [ReceiptTotal],
			[ReceiptIssuedTime], [PaymentExtData], [PhysicalRecordingId], [PostingTime],
			[PostedById], [PaymentStatus], [PaymentDIF]
	) VALUES (
			@PaymentId, @TransactionId, @PaymentOfficeId, @ReceiptNo, @ReceiptTotal,
			@ReceiptIssuedTime, @PaymentExtData, @PhysicalRecordingId, @PostingTime,
			@PostedById, @PaymentStatus, @PaymentDIF
	)
   END
ELSE
   BEGIN
	UPDATE [dbo].[LRSPayments]
	 SET
	 --[TransactionId] = @TransactionId ,
	 [PaymentOfficeId] = @PaymentOfficeId ,
	 [ReceiptNo] = @ReceiptNo ,
	 [ReceiptTotal] = @ReceiptTotal ,
	 [ReceiptIssuedTime] = @ReceiptIssuedTime ,
	 [PaymentExtData] = @PaymentExtData ,
	 --[PhysicalRecordingId] = @PhysicalRecordingId ,
	 [PostingTime] = @PostingTime ,
	 [PostedById] = @PostedById ,
	 [PaymentStatus] = @PaymentStatus ,
	 [PaymentDIF] = @PaymentDIF
	WHERE
		([PaymentId] = @PaymentId AND [TransactionId] = @TransactionId AND
		 [PhysicalRecordingId] = @PhysicalRecordingId AND PaymentStatus <> 'C')
	END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSPhysicalBook]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeLRSPhysicalBook] (
	@PhysicalBookId  [int],
	@RecorderOfficeId  [int],
	@RecordingSectionId  [int],
	@BookNo  [varchar]  (64),
	@BookAsText  [varchar]  (512),
	@BookExtData  [varchar]  (2048),
	@BookKeywords  [varchar]  (1024),
	@StartRecordingIndex  [int],
	@EndRecordingIndex  [int],
	@BookStatus  [char]  (1),
	@BookDIF  [varchar]  (65)
) AS
IF NOT EXISTS(SELECT 1 FROM [dbo].[LRSPhysicalBooks] WHERE (PhysicalBookId = @PhysicalBookId))
   BEGIN
	  INSERT INTO [dbo].[LRSPhysicalBooks] (
		[PhysicalBookId], [RecorderOfficeId], [RecordingSectionId], [BookNo], [BookAsText],
		[BookExtData], [BookKeywords], [StartRecordingIndex], [EndRecordingIndex], [BookStatus], [BookDIF]
     ) VALUES (
		@PhysicalBookId, @RecorderOfficeId, @RecordingSectionId, @BookNo, @BookAsText,
		@BookExtData, @BookKeywords, @StartRecordingIndex, @EndRecordingIndex, @BookStatus, @BookDIF
)
   END
ELSE
   BEGIN
	UPDATE [dbo].[LRSPhysicalBooks]
	 SET
	 --[RecorderOfficeId] = @RecorderOfficeId ,
	 --[RecordingSectionId] = @RecordingSectionId ,
	 --[BookNo] = @BookNo ,
	 --[BookAsText] = @BookAsText ,
	 [BookExtData] = @BookExtData ,
	 [BookKeywords] = @BookKeywords ,
	 [StartRecordingIndex] = @StartRecordingIndex ,
	 [EndRecordingIndex] = @EndRecordingIndex ,
	 [BookStatus] = @BookStatus ,
	 [BookDIF] = @BookDIF
	WHERE ([PhysicalBookId] = @PhysicalBookId) AND (BookStatus <> 'C')
END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSPhysicalRecording]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[writeLRSPhysicalRecording] (
	@PhysicalRecordingId  [int],
	@PhysicalBookId  [int],
	@MainDocumentId [int],
	@RecordingNo  [varchar]  (24),
	@RecordingAsText  [varchar]  (512),
	@RecordingExtData  [varchar]  (8000),
	@RecordingKeywords  [varchar]  (2048),
	@RecordedById  [int],
	@RecordingTime  [smalldatetime],
	@RecordingStatus  [char]  (1),
	@RecordingDIF  [varchar]  (65)
) AS
IF NOT EXISTS(SELECT 1 FROM [dbo].[LRSPhysicalRecordings] WHERE (PhysicalRecordingId = @PhysicalRecordingId))
   BEGIN
	INSERT INTO [dbo].[LRSPhysicalRecordings] (
		[PhysicalRecordingId], [PhysicalBookId], [MainDocumentId], [RecordingNo], [RecordingAsText],
		[RecordingExtData], [RecordingKeywords], [RecordedById], [RecordingTime], [RecordingStatus], [RecordingDIF]
	) VALUES (
		@PhysicalRecordingId, @PhysicalBookId, @MainDocumentId, @RecordingNo, @RecordingAsText,
		@RecordingExtData, @RecordingKeywords, @RecordedById, @RecordingTime, @RecordingStatus, @RecordingDIF
    )
   END
ELSE
   BEGIN
     UPDATE [dbo].[LRSPhysicalRecordings]
	 SET
		 --[PhysicalRecordingId] = @PhysicalRecordingId ,
		 --[PhysicalBookId] = @PhysicalBookId ,
		 --[MainDocumentId] = @MainDocumentId ,
		 [RecordingNo] = @RecordingNo ,
		 [RecordingAsText] = @RecordingAsText ,
		 [RecordingExtData] = @RecordingExtData ,
		 [RecordingKeywords] = @RecordingKeywords ,
		 [RecordedById] = @RecordedById ,
		 [RecordingTime] = @RecordingTime ,
		 [RecordingStatus] = @RecordingStatus ,
		 [RecordingDIF] = @RecordingDIF
	WHERE (([PhysicalRecordingId] = @PhysicalRecordingId) AND ([PhysicalBookId] = @PhysicalBookId) AND ([RecordingStatus] <> 'C'))
END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSPosting]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeLRSPosting] (
	@PostingId  [int],
	@UID  [varchar]  (36),
	@PostingType  [varchar]  (64),
	@ReferenceUID  [varchar]  (64),
	@ExtData  varchar(MAX),
	@Keywords  [varchar]  (2048),
	@PostingTime  [smalldatetime],
	@PostedById  [int],
	@Status  [char]  (1)
) AS
IF NOT EXISTS(SELECT 1 FROM [dbo].[LRSPostings] WHERE ([PostingId] = @PostingId))
   BEGIN
	  INSERT INTO [dbo].[LRSPostings] (
	    [PostingId], [UID], [PostingType], [ReferenceUID], [ExtData], [Keywords],
		[PostingTime], [PostedById], [Status]
	  ) VALUES (
		@PostingId, @UID, @PostingType, @ReferenceUID, @ExtData, @Keywords,
		@PostingTime, @PostedById, @Status
	  )
	END
ELSE
   BEGIN
	UPDATE [dbo].[LRSPostings]
	 SET
   --   [PostingId] = @PostingId ,
	  --[UID] = @UID ,
	  --[PostingType] = @PostingType ,
	  -- [ReferenceUID] = @ReferenceUID ,
	  [ExtData] = @ExtData ,
	  [Keywords] = @Keywords ,
	  [PostingTime] = @PostingTime ,
	  [PostedById] = @PostedById ,
	  [Status] = @Status
	WHERE
	 ([PostingId] = @PostingId) AND ([UID] = @UID)
	END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSProperty]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeLRSProperty] (
	@PropertyId [int],
	@PropertyTypeId [int],
	@PropertyUID [varchar] (32),
	@CadastralKey [varchar] (64),
	@PropertyExtData [varchar] (8000),
	@PropertyKeywords [varchar] (2048),
	@PartitionOfId [int],
	@PartitionNo [varchar]  (72),
	@MergedIntoId [int],
	@PostingTime [smalldatetime],
	@PostedById [int],
	@PropertyStatus [char] (1),
	@PropertyDIF [varchar] (65)
) AS
IF NOT EXISTS( SELECT 1 FROM [dbo].[LRSProperties] WHERE ([PropertyId] = @PropertyId))
   BEGIN
	INSERT INTO [dbo].[LRSProperties] (
		[PropertyId], [PropertyTypeId], [PropertyUID], [CadastralKey], [PropertyExtData],
		[PropertyKeywords], [PartitionOfId], [PartitionNo], [MergedIntoId],
		[PostingTime], [PostedById], [PropertyStatus], [PropertyDIF]
    )  VALUES (
		@PropertyId, @PropertyTypeId, @PropertyUID, @CadastralKey, @PropertyExtData,
		@PropertyKeywords, @PartitionOfId, @PartitionNo, @MergedIntoId,
		@PostingTime, @PostedById, @PropertyStatus, @PropertyDIF
    )
   END
ELSE
   BEGIN
      UPDATE [dbo].[LRSProperties]
		SET
		--[PropertyId] = @PropertyId ,
		--[PropertyTypeId] = @PropertyTypeId ,
		--[PropertyUID] = @PropertyUID ,
		--[CadastralKey] = @CadastralKey ,
		 [PropertyExtData] = @PropertyExtData ,
		 [PropertyKeywords] = @PropertyKeywords ,
		 [PartitionOfId] = @PartitionOfId ,
		 [PartitionNo] = @PartitionNo ,
		 [MergedIntoId] = @MergedIntoId ,
		 [PostingTime] = @PostingTime ,
		 [PostedById] = @PostedById ,
		 [PropertyStatus] = @PropertyStatus ,
		 [PropertyDIF] = @PropertyDIF
	  WHERE ([PropertyId] = @PropertyId AND [PropertyUID] = @PropertyUID AND [PropertyStatus] <> 'C')
END

GO
/****** Object:  StoredProcedure [dbo].[writeLRSRecordingAct]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeLRSRecordingAct] (
	@RecordingActId  [int],
	@RecordingActTypeId  [int],
	@DocumentId  [int],
	@RecordingActIndex  [int],
	@ResourceId  [int],
	@ResourceRole  [char]  (1),
	@RelatedResourceId  [int],
	@RecordingActPercentage  decimal (6,5),
	@RecordingActNotes  [varchar]  (2048),
	@RecordingActExtData  [varchar]  (8000),
	@RecordingActKeywords  [varchar]  (2048),
	@AmendmentOfId  [int],
	@AmendedById  [int],
	@PhysicalRecordingId  [int],
	@RegisteredById  [int],
	@RegistrationTime  [smalldatetime],
	@RecordingActStatus  [char]  (1),
	@RecordingActDIF  [varchar]  (65)
) AS
IF NOT EXISTS(SELECT 1 FROM [dbo].[LRSRecordingActs] WHERE (RecordingActId = @RecordingActId))
   BEGIN
	INSERT INTO [dbo].[LRSRecordingActs]
	  ( [RecordingActId], [RecordingActTypeId], [DocumentId], [RecordingActIndex],
	    [ResourceId], [ResourceRole], [RelatedResourceId], [RecordingActPercentage],
	    [RecordingActNotes], [RecordingActExtData], [RecordingActResourceExtData],
		[RecordingActKeywords], [AmendmentOfId], [AmendedById], [PhysicalRecordingId],
		[RegisteredById], [RegistrationTime], [RecordingActStatus], [RecordingActDIF]
	  ) VALUES (
		@RecordingActId, @RecordingActTypeId, @DocumentId, @RecordingActIndex,
		@ResourceId, @ResourceRole, @RelatedResourceId, @RecordingActPercentage,
		@RecordingActNotes, @RecordingActExtData, '',
		@RecordingActKeywords, @AmendmentOfId, @AmendedById, @PhysicalRecordingId,
		@RegisteredById, @RegistrationTime, @RecordingActStatus, @RecordingActDIF
    )
   END
ELSE
   BEGIN
		UPDATE [dbo].[LRSRecordingActs]
			SET
			 --[RecordingActTypeId] = @RecordingActTypeId ,
			 --[DocumentId] = @DocumentId ,
			[RecordingActIndex] = @RecordingActIndex ,
			 --[ResourceId] = @ResourceId ,
			--[ResourceRole] = @ResourceRole ,
			--[RelatedResourceId] = @RelatedResourceId ,
			[RecordingActPercentage] = @RecordingActPercentage,
			[RecordingActNotes] = @RecordingActNotes ,
			[RecordingActExtData] = @RecordingActExtData ,
			--[RecordingActResourceExtData] = @RecordingActResourceExtData,
			[RecordingActKeywords] = @RecordingActKeywords ,
			[AmendmentOfId] = @AmendmentOfId ,
			[AmendedById] = @AmendedById ,
			--[PhysicalRecordingId] = @PhysicalRecordingId ,
			[RegisteredById] = @RegisteredById ,
			[RegistrationTime] = @RegistrationTime ,
			[RecordingActStatus] = @RecordingActStatus ,
			[RecordingActDIF] = @RecordingActDIF
		WHERE ([RecordingActId] = @RecordingActId AND [DocumentId] = @DocumentId AND [RecordingActStatus] <> 'C')
	END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSRecordingActParty]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeLRSRecordingActParty] (
	@RecordingActPartyId  [int],
	@RecordingActId  [int],
	@PartyId  [int],
	@PartyRoleId  [int],
	@PartyOfId  [int],
	@OwnershipPartAmount  decimal (15,7),
	@OwnershipPartUnitId  [int],
	@IsOwnershipStillActive  [bit],
	@RecActPartyNotes  [varchar]  (255),
	@RecActPartyAsText  [varchar]  (255),
	@RecActPartyExtData  [varchar]  (8000),
	@PostedById  [int],
	@RecActPartyStatus  [char]  (1),
	@RecActPartyDIF  [varchar]  (65)

) AS
IF NOT EXISTS(SELECT 1 FROM [dbo].[LRSRecordingActParties] WHERE ([RecordingActPartyId] = @RecordingActPartyId))
   BEGIN
		INSERT INTO [dbo].[LRSRecordingActParties] (
			[RecordingActPartyId], [RecordingActId], [PartyId], [PartyRoleId], [PartyOfId],
			[OwnershipPartAmount], [OwnershipPartUnitId], [IsOwnershipStillActive],
			[RecActPartyNotes], [RecActPartyAsText], [RecActPartyExtData],
			[PostedById], [RecActPartyStatus], [RecActPartyDIF]
		) VALUES (
			@RecordingActPartyId, @RecordingActId, @PartyId, @PartyRoleId, @PartyOfId,
			@OwnershipPartAmount, @OwnershipPartUnitId, @IsOwnershipStillActive,
			@RecActPartyNotes, @RecActPartyAsText, @RecActPartyExtData,
			@PostedById, @RecActPartyStatus, @RecActPartyDIF
		)
   END
ELSE
   BEGIN
		UPDATE [dbo].[LRSRecordingActParties]
		 SET
			 --[RecordingActPartyId] = @RecordingActPartyId ,
			 --[RecordingActId] = @RecordingActId ,
			 --[PartyId] = @PartyId ,
			 --[PartyRoleId] = @PartyRoleId ,
			 --[PartyOfId] = @PartyOfId ,
			 [OwnershipPartAmount] = @OwnershipPartAmount ,
			 [OwnershipPartUnitId] = @OwnershipPartUnitId ,
			 [IsOwnershipStillActive] = @IsOwnershipStillActive,
			 [RecActPartyNotes] = @RecActPartyNotes ,
			 [RecActPartyAsText] = @RecActPartyAsText ,
			 [RecActPartyExtData] = @RecActPartyExtData ,
			 [PostedById] = @PostedById ,
			 [RecActPartyStatus] = @RecActPartyStatus ,
			 [RecActPartyDIF] = @RecActPartyDIF
		WHERE (RecordingActPartyId = @RecordingActPartyId AND RecordingActId = @RecordingActId AND
			   PartyId = @PartyId AND [RecActPartyStatus] <> 'C')

END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSTransaction]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeLRSTransaction] (
	@TransactionId  [int],
	@TransactionTypeId  [int],
	@TransactionUID  [varchar]  (32),
	@DocumentTypeId  [int],
	@DocumentDescriptor  [varchar]  (128),
	@DocumentId  [int],
	@BaseResourceId  [int],
	@RecorderOfficeId  [int],
	@RequestedBy  [varchar]  (512),
	@AgencyId  [int],
	@ExternalTransactionNo varchar(48),
	@TransactionExtData  [varchar]  (8000),
	@TransactionKeywords  [varchar]  (2048),
	@PresentationTime  [datetime],
	@ExpectedDelivery  [smalldatetime],
	@LastReentryTime  [smalldatetime],
	@ClosingTime  [smalldatetime],
	@LastDeliveryTime  [smalldatetime],
	@NonWorkingTime  [int],
	@ComplexityIndex  decimal (4,1),
	@IsArchived  [bit],
	@TransactionStatus  [char]  (1),
	@TransactionDIF  [varchar]  (65)
) AS IF NOT EXISTS( SELECT 1 FROM [dbo].[LRSTransactions] WHERE ([TransactionId] = @TransactionId))
   BEGIN
	INSERT INTO [dbo].[LRSTransactions] (
		[TransactionId], [TransactionTypeId], [TransactionUID], [DocumentTypeId], [DocumentDescriptor],
		[DocumentId], [BaseResourceId], [RecorderOfficeId], [RequestedBy], [AgencyId],
		[ExternalTransactionNo], [TransactionExtData], [TransactionKeywords],
		[PresentationTime], [ExpectedDelivery], [LastReentryTime], [ClosingTime], [LastDeliveryTime], [NonWorkingTime],
		[ComplexityIndex], [IsArchived], [TransactionStatus], [TransactionDIF]
	) VALUES (
		@TransactionId, @TransactionTypeId, @TransactionUID, @DocumentTypeId, @DocumentDescriptor,
		@DocumentId, @BaseResourceId, @RecorderOfficeId, @RequestedBy, @AgencyId,
		@ExternalTransactionNo,@TransactionExtData, @TransactionKeywords,
		@PresentationTime, @ExpectedDelivery, @LastReentryTime, @ClosingTime, @LastDeliveryTime, @NonWorkingTime,
		@ComplexityIndex, @IsArchived, @TransactionStatus, @TransactionDIF
	)
   END
ELSE
   BEGIN
		UPDATE [dbo].[LRSTransactions]
		 SET
	-- [TransactionTypeId] = @TransactionTypeId ,
	 --[TransactionUID] = @TransactionUID ,
	 [DocumentTypeId] = @DocumentTypeId ,
	 [DocumentDescriptor] = @DocumentDescriptor ,
	 [DocumentId] = @DocumentId ,
	 [BaseResourceId] = @BaseResourceId,
	 [RecorderOfficeId] = @RecorderOfficeId ,
	 [RequestedBy] = @RequestedBy ,
	 [AgencyId] = @AgencyId ,
	 --[[ExternalTransactionNo] = @ExternalTransactionNo,
	 [TransactionExtData] = @TransactionExtData ,
	 [TransactionKeywords] = @TransactionKeywords ,
	 [PresentationTime] = @PresentationTime ,
	 [ExpectedDelivery] = @ExpectedDelivery ,
	 [LastReentryTime] = @LastReentryTime ,
	 [ClosingTime] = @ClosingTime ,
	 [LastDeliveryTime] = @LastDeliveryTime ,
	 [NonWorkingTime] = @NonWorkingTime ,
	 [ComplexityIndex] = @ComplexityIndex ,
	 [IsArchived] = @IsArchived ,
	 [TransactionStatus] = @TransactionStatus ,
	 [TransactionDIF] = @TransactionDIF
	WHERE
		([TransactionId] = @TransactionId AND [TransactionUID] = @TransactionUID)
	END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSTransactionItem]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeLRSTransactionItem] (
	@TransactionItemId  [int],
	@TransactionId  [int],
	@TransactionItemTypeId  [int],
	@TreasuryCodeId  [int],
	@PaymentId  [int],
	@Quantity  decimal(9, 2),
	@UnitId  [int],
	@OperationValue  decimal(18, 4),
	@OperationValueCurrencyId  [int],
	@RecordingRightsFee decimal(9, 2),
	@SheetsRevisionFee  decimal(9, 2),
	@ForeignRecordingFee  decimal(9, 2),
	@Discount  decimal(9, 2),
	@TransactionItemExtData [varchar] (1024),
	@TransactionItemStatus  [char]  (1),
	@TransactionItemDIF  [varchar]  (65)
)
AS
	IF NOT EXISTS( SELECT * FROM [dbo].[LRSTransactionItems] WHERE ([TransactionItemId] = @TransactionItemId))
		BEGIN
			INSERT INTO [dbo].[LRSTransactionItems] (
				[TransactionItemId], [TransactionId], [TransactionItemTypeId], [TreasuryCodeId], [PaymentId],
				[Quantity], [UnitId], [OperationValue], [OperationValueCurrencyId], [RecordingRightsFee], [SheetsRevisionFee],
				[ForeignRecordingFee], [Discount], [TransactionItemExtData], [TransactionItemStatus], [TransactionItemDIF]
			) VALUES (
				@TransactionItemId, @TransactionId, @TransactionItemTypeId, @TreasuryCodeId, @PaymentId,
				@Quantity, @UnitId, @OperationValue, @OperationValueCurrencyId, @RecordingRightsFee, @SheetsRevisionFee,
				@ForeignRecordingFee, @Discount, @TransactionItemExtData, @TransactionItemStatus, @TransactionItemDIF
		 )
   END
ELSE
   BEGIN
		UPDATE [dbo].[LRSTransactionItems]
		 SET
			 [TransactionItemTypeId] = @TransactionItemTypeId ,
			 [TreasuryCodeId] = @TreasuryCodeId,
			 [PaymentId] = @PaymentId ,
			 [Quantity] = @Quantity ,
			 [UnitId] = @UnitId ,
			 [OperationValue] = @OperationValue ,
			 [OperationValueCurrencyId] = @OperationValueCurrencyId ,
			 [RecordingRightsFee] = @RecordingRightsFee ,
			 [SheetsRevisionFee] = @SheetsRevisionFee ,
			 [ForeignRecordingFee] = @ForeignRecordingFee ,
			 [Discount] = @Discount ,
			 [TransactionItemExtData] = @TransactionItemExtData ,
			 [TransactionItemStatus] = @TransactionItemStatus ,
			 [TransactionItemDIF] = @TransactionItemDIF
		WHERE
			([TransactionItemId] = @TransactionItemId) AND (TransactionId = @TransactionId)

END
GO
/****** Object:  StoredProcedure [dbo].[writeLRSWorkflowTask]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeLRSWorkflowTask] (
	@TrackId  [int],
	@TransactionId  [int],
	@EventId  [int],
	@Mode  [char]  (1),
	@AssignedById  [int],
	@ResponsibleId  [int],
	@NextContactId  [int],
	@CurrentTransactionStatus  [char]  (1),
	@NextTransactionStatus  [char]  (1),
	@CheckInTime  [smalldatetime],
	@EndProcessTime  [smalldatetime],
	@CheckOutTime  [smalldatetime],
	@TrackNotes  [varchar]  (512),
	@PreviousTrackId  [int],
	@NextTrackId  [int],
	@TrackStatus  [char]  (1),
	@TrackDIF  [varchar]  (65)
)
AS IF NOT EXISTS( SELECT 1 FROM [dbo].[LRSTransactionTrack] WHERE ([TrackId] = @TrackId))
   BEGIN
	INSERT INTO [dbo].[LRSTransactionTrack]
		([TrackId], [TransactionId], [EventId], [Mode], [AssignedById], [ResponsibleId], [NextContactId],
		[CurrentTransactionStatus], [NextTransactionStatus], [CheckInTime], [EndProcessTime], [CheckOutTime],
		[TrackNotes], [PreviousTrackId], [NextTrackId], [TrackStatus], [TrackDIF]
	) VALUES (
		@TrackId, @TransactionId, @EventId, @Mode, @AssignedById, @ResponsibleId, @NextContactId,
		@CurrentTransactionStatus, @NextTransactionStatus, @CheckInTime, @EndProcessTime, @CheckOutTime,
		@TrackNotes, @PreviousTrackId, @NextTrackId, @TrackStatus, @TrackDIF
	)
   END
ELSE
   BEGIN
	UPDATE [dbo].[LRSTransactionTrack]
	 SET
		 [EventId] = @EventId ,
		 [Mode] = @Mode ,
		 [AssignedById] = @AssignedById ,
		 [ResponsibleId] = @ResponsibleId ,
		 [NextContactId] = @NextContactId ,
		 [CurrentTransactionStatus] = @CurrentTransactionStatus ,
		 [NextTransactionStatus] = @NextTransactionStatus ,
		 [CheckInTime] = @CheckInTime ,
		 [EndProcessTime] = @EndProcessTime ,
		 [CheckOutTime] = @CheckOutTime ,
		 [TrackNotes] = @TrackNotes ,
		 [PreviousTrackId] = @PreviousTrackId ,
		 [NextTrackId] = @NextTrackId ,
		 [TrackStatus] = @TrackStatus ,
		 [TrackDIF] = @TrackDIF
	WHERE
		([TrackId] = @TrackId) AND (TransactionId = @TransactionId)
END
GO
/****** Object:  StoredProcedure [dbo].[writeObjectLink]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[writeObjectLink] (
	@LinkId  [int],
	@TypeRelationId  [int],
	@SourceId  [int],
	@TargetId  [int],
	@LinkIndex  [int],
	@LinkExtData  [varchar]  (1024),
	@LinkStatus  [char]  (1),
	@StartDate  [smalldatetime],
	@EndDate  [smalldatetime]
) AS
IF NOT EXISTS(SELECT 1 FROM [dbo].[ObjectLinks] WHERE ([LinkId] = @LinkId))
   BEGIN
		INSERT INTO [dbo].[ObjectLinks] (
			[LinkId], [TypeRelationId],	[SourceId], [TargetId], [LinkIndex],
			[LinkExtData], [LinkStatus], [StartDate], [EndDate]
		) VALUES (
			@LinkId, @TypeRelationId, @SourceId, @TargetId, @LinkIndex,
			@LinkExtData, @LinkStatus, @StartDate, @EndDate
		)
	END
ELSE
   BEGIN
	UPDATE [dbo].[ObjectLinks]
	 SET
		 --[LinkId] = @LinkId ,
		 --[TypeRelationId] = @TypeRelationId ,
		 --[SourceId] = @SourceId ,
		 --[TargetId] = @TargetId ,
		 [LinkIndex] = @LinkIndex ,
		 [LinkExtData] = @LinkExtData ,
		 [LinkStatus] = @LinkStatus ,
		 [StartDate] = @StartDate ,
		 [EndDate] = @EndDate
	WHERE
		([LinkId] = @LinkId) AND (TypeRelationId = @TypeRelationId) AND
	    ([SourceId] = @SourceId) AND ([TargetId] = @TargetId)
END
GO
/****** Object:  StoredProcedure [dbo].[writeQueuedMessage]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[writeQueuedMessage] (
	@MessageId  [int],
	@MessageTypeId  [int],
	@QueueId  [int],
	@MessageUID  [varchar]  (36),
	@UnitOfWorkUID  [varchar]  (36),
	@PostingTime  [datetime],
	@MessageData  [varchar] (MAX),
	@ProcessingTime  [datetime],
	@ProcessingData  [varchar] (MAX),
	@ProcessingStatus  [char]  (1)
) AS IF NOT EXISTS( SELECT 1 FROM [dbo].[QueuedMessages] WHERE ([MessageId] = @MessageId))
   BEGIN
	INSERT INTO [dbo].[QueuedMessages]
	   ([MessageId], [MessageTypeId], [QueueId],
	    [MessageUID], [UnitOfWorkUID], [PostingTime],
	    [MessageData], [ProcessingTime], [ProcessingData], [ProcessingStatus]
	) VALUES (
		@MessageId, @MessageTypeId, @QueueId,
		@MessageUID, @UnitOfWorkUID, @PostingTime,
	    @MessageData, @ProcessingTime, @ProcessingData, @ProcessingStatus
	)
   END
ELSE
   BEGIN
		UPDATE [dbo].[QueuedMessages]
		 SET
			 --[MessageId] = @MessageId ,
			 --[MessageTypeId] = @MessageTypeId ,
			 --[QueueId] = @QueueId ,
			 --[MessageUID] = @MessageUID ,
			 --[UnitOfWorkUID] = @UnitOfWorkUID ,
			 --[PostingTime] = @PostingTime ,
			 --[MessageData] = @MessageData ,
			 [ProcessingTime] = @ProcessingTime ,
			 [ProcessingData] = @ProcessingData ,
			 [ProcessingStatus] = @ProcessingStatus
		WHERE
			([MessageId] = @MessageId AND [MessageUID] = @MessageUID)
	END

GO
/****** Object:  StoredProcedure [dbo].[writeSimpleObject]    Script Date: 20/May/2020 5:01:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[writeSimpleObject] (
	@ObjectId  [int],
	@ObjectTypeId  [int],
	@ObjectKey  [varchar]  (128),
	@ObjectName  [varchar]  (512),
	@ObjectExtData  [varchar](MAX),
	@ObjectKeywords  [varchar]  (2048),
	@ObjectStatus  [char]  (1)
)
AS IF NOT EXISTS( SELECT 1 FROM [dbo].[SimpleObjects] WHERE (ObjectId = @ObjectId) )
   BEGIN
		INSERT INTO [dbo].[SimpleObjects] (
			[ObjectId], [ObjectTypeId], [ObjectKey], [ObjectName], [ObjectExtData],
			[ObjectKeywords], [ObjectStatus]
		) VALUES (
			@ObjectId, @ObjectTypeId, @ObjectKey, @ObjectName, @ObjectExtData,
			@ObjectKeywords, @ObjectStatus
	    )
   END
ELSE
   BEGIN
	UPDATE [dbo].[SimpleObjects]
	 SET
		 --[ObjectId] = @ObjectId ,
		 [ObjectTypeId] = @ObjectTypeId ,
		 [ObjectKey] = @ObjectKey ,
		 [ObjectName] = @ObjectName ,
		 [ObjectExtData] = @ObjectExtData ,
		 [ObjectKeywords] = @ObjectKeywords ,
		 [ObjectStatus] = @ObjectStatus
	WHERE
		([ObjectId] = @ObjectId)
END

GO
