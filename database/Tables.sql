USE [Land]
GO
/****** Object:  Table [dbo].[AuditTrail]    Script Date: 20/May/2020 5:00:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditTrail](
	[AuditTrailId] [bigint] IDENTITY(1,1) NOT NULL,
	[RequestGuid] [uniqueidentifier] NOT NULL,
	[AuditTrailType] [char](1) NOT NULL,
	[AuditTrailTime] [datetime] NOT NULL,
	[SessionId] [int] NOT NULL,
	[EventName] [varchar](128) NOT NULL,
	[OperationName] [varchar](128) NOT NULL,
	[OperationData] [varchar](2048) NOT NULL,
	[AppliedToId] [int] NOT NULL,
	[ResponseCode] [int] NOT NULL,
	[ResponseItems] [int] NOT NULL,
	[ResponseTime] [decimal](9, 5) NOT NULL,
	[ResponseData] [varchar](max) NOT NULL,
 CONSTRAINT [PK_AuditTrails] PRIMARY KEY CLUSTERED
(
	[AuditTrailId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[ContactId] [int] NOT NULL,
	[ContactTypeId] [int] NOT NULL,
	[ContactUID] [varchar](36) NOT NULL,
	[ContactFullName] [varchar](255) NOT NULL,
	[FirstName] [varchar](64) NOT NULL,
	[LastName] [varchar](64) NOT NULL,
	[LastName2] [varchar](64) NOT NULL,
	[ShortName] [varchar](128) NOT NULL,
	[Nickname] [varchar](48) NOT NULL,
	[ContactTags] [varchar](255) NOT NULL,
	[ContactExtData] [varchar](8000) NOT NULL,
	[ContactKeywords] [varchar](1024) NOT NULL,
	[UserName] [varchar](48) NOT NULL,
	[UserPassword] [varchar](255) NOT NULL,
	[ContactEmail] [varchar](48) NOT NULL,
	[ContactStatus] [char](1) NOT NULL,
 CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataLog]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataLog](
	[DataLogEntryId] [bigint] IDENTITY(1,1) NOT NULL,
	[SessionId] [int] NOT NULL,
	[LogTimestamp] [datetime] NOT NULL,
	[DataSource] [varchar](32) NOT NULL,
	[DataOperation] [varchar](64) NOT NULL,
	[DataParameters] [varchar](max) NOT NULL,
	[ObjectId] [int] NOT NULL,
 CONSTRAINT [PK_DataLog] PRIMARY KEY CLUSTERED
(
	[DataLogEntryId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbItems]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbItems](
	[DbItemId] [int] NOT NULL,
	[DbItemType] [varchar](32) NOT NULL,
	[DbParentItem] [varchar](64) NOT NULL,
	[DbItemIndex] [int] NOT NULL,
	[DbItemName] [varchar](64) NOT NULL,
	[DbItemStringValue] [varchar](6000) NOT NULL,
	[DbItemDataType] [int] NOT NULL,
	[DbItemDirection] [int] NOT NULL,
	[DbItemSize] [int] NOT NULL,
	[DbItemScale] [int] NOT NULL,
	[DbItemPrecision] [int] NOT NULL,
	[DbItemCacheMode] [varchar](16) NOT NULL,
	[DbItemCacheRefresh] [int] NOT NULL,
	[DbServerId] [int] NOT NULL,
	[DbTargetServerId] [int] NOT NULL,
	[DbIdFieldName] [varchar](64) NOT NULL,
	[DbTypeFieldName] [varchar](64) NOT NULL,
	[DbKeyFieldName] [varchar](64) NOT NULL,
	[LowerIdValue] [int] NOT NULL,
	[UpperIdValue] [int] NOT NULL,
	[DbItemExtData] [varchar](8000) NOT NULL,
 CONSTRAINT [PK_DbItems] PRIMARY KEY CLUSTERED
(
	[DbItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbQueryParameters]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbQueryParameters](
	[QueryName] [varchar](64) NOT NULL,
	[ParameterIndex] [int] NOT NULL,
	[ParameterName] [varchar](64) NOT NULL,
	[ParameterDbType] [int] NOT NULL,
	[ParameterDirection] [int] NOT NULL,
	[ParameterSize] [int] NOT NULL,
	[ParameterScale] [int] NOT NULL,
	[ParameterPrecision] [int] NOT NULL,
	[ParameterDefaultValue] [varchar](255) NOT NULL,
 CONSTRAINT [PK_DBQueryParameters] PRIMARY KEY CLUSTERED
(
	[QueryName] ASC,
	[ParameterIndex] ASC,
	[ParameterName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbQueryStrings]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbQueryStrings](
	[QueryName] [varchar](64) NOT NULL,
	[SqlQueryString] [varchar](2048) NOT NULL,
	[MySqlQueryString] [varchar](2048) NOT NULL,
	[OleDbQueryString] [varchar](2048) NOT NULL,
	[OracleQueryString] [varchar](2048) NOT NULL,
	[Documentation] [varchar](255) NOT NULL,
 CONSTRAINT [PK_DBDataSources] PRIMARY KEY CLUSTERED
(
	[QueryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DbRules]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DbRules](
	[DbRuleId] [int] NOT NULL,
	[DbRuleType] [char](1) NOT NULL,
	[ServerId] [int] NOT NULL,
	[TargetServerId] [int] NOT NULL,
	[SourceName] [varchar](64) NOT NULL,
	[TypeId] [int] NOT NULL,
	[DbRuleIndex] [int] NOT NULL,
	[DbRulePriority] [smallint] NOT NULL,
	[DbRuleCondition] [varchar](1024) NOT NULL,
	[StorageName] [varchar](64) NOT NULL,
	[SecureParameters] [bit] NOT NULL,
	[IdFieldName] [varchar](64) NOT NULL,
	[IdTypeFieldName] [varchar](64) NOT NULL,
	[LowerIdValue] [int] NOT NULL,
	[UpperIdValue] [int] NOT NULL,
 CONSTRAINT [PK_DbRules] PRIMARY KEY CLUSTERED
(
	[DbRuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOPFilingRequests]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOPFilingRequests](
	[FilingRequestId] [int] NOT NULL,
	[FilingRequestUID] [varchar](36) NOT NULL,
	[ProcedureId] [int] NOT NULL,
	[RequestedBy] [varchar](512) NOT NULL,
	[AgencyId] [int] NOT NULL,
	[AgentId] [int] NOT NULL,
	[RequestExtData] [varchar](max) NOT NULL,
	[RequestKeywords] [varchar](4000) NOT NULL,
	[LastUpdateTime] [smalldatetime] NOT NULL,
	[PostingTime] [smalldatetime] NOT NULL,
	[PostedById] [int] NOT NULL,
	[RequestStatus] [char](1) NOT NULL,
	[FilingRequestDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_EOPFilingRequests] PRIMARY KEY CLUSTERED
(
	[FilingRequestId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOPSignableDocuments]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOPSignableDocuments](
	[SignableDocumentId] [int] NOT NULL,
	[UID] [varchar](36) NOT NULL,
	[DocumentType] [varchar](128) NOT NULL,
	[TransactionNo] [varchar](64) NOT NULL,
	[DocumentNo] [varchar](64) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[RequestedBy] [varchar](512) NOT NULL,
	[RequestedTime] [smalldatetime] NOT NULL,
	[SignInputData] [varchar](max) NOT NULL,
	[ExtData] [varchar](max) NOT NULL,
	[Keywords] [varchar](2048) NOT NULL,
	[PostingTime] [smalldatetime] NOT NULL,
	[PostedById] [int] NOT NULL,
	[SignStatus] [char](1) NOT NULL,
	[SignableDocumentDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_EOPESignDocuments] PRIMARY KEY CLUSTERED
(
	[SignableDocumentId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOPSignEvents]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOPSignEvents](
	[SignEventId] [int] NOT NULL,
	[UID] [varchar](36) NOT NULL,
	[SignRequestId] [int] NOT NULL,
	[EventType] [char](1) NOT NULL,
	[DigitalSign] [varchar](255) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[SignEventDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_EOPSignEvents] PRIMARY KEY CLUSTERED
(
	[SignEventId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOPSignRequests]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOPSignRequests](
	[SignRequestId] [int] NOT NULL,
	[UID] [varchar](36) NOT NULL,
	[RequestedById] [int] NOT NULL,
	[RequestedTime] [smalldatetime] NOT NULL,
	[RequestedToId] [int] NOT NULL,
	[SignableDocumentId] [int] NOT NULL,
	[SignatureKind] [varchar](32) NOT NULL,
	[ExtData] [varchar](max) NOT NULL,
	[SignStatus] [char](1) NOT NULL,
	[SignTime] [datetime] NOT NULL,
	[DigitalSign] [varchar](255) NOT NULL,
	[SignRequestDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_EOPESigns] PRIMARY KEY CLUSTERED
(
	[SignRequestId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GeoItems]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeoItems](
	[GeoItemId] [int] NOT NULL,
	[GeoItemTypeId] [int] NOT NULL,
	[GeoItemName] [varchar](128) NOT NULL,
	[GeoItemFullName] [varchar](512) NOT NULL,
	[GeoItemExtData] [varchar](8000) NOT NULL,
	[GeoItemKeywords] [varchar](512) NOT NULL,
	[GeoItemParentId] [int] NOT NULL,
	[GeoItemStatus] [char](1) NOT NULL,
	[StartDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_GeoItems] PRIMARY KEY CLUSTERED
(
	[GeoItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogEntries]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogEntries](
	[LogEntryId] [bigint] IDENTITY(1,1) NOT NULL,
	[ClientApplicationId] [int] NOT NULL,
	[SessionToken] [varchar](128) NOT NULL,
	[LogTimestamp] [datetime] NOT NULL,
	[LogEntryType] [char](1) NOT NULL,
	[TraceGuid] [uniqueidentifier] NOT NULL,
	[LogData] [varchar](max) NOT NULL,
 CONSTRAINT [LogEntries_LogEntryId] PRIMARY KEY CLUSTERED
(
	[LogEntryId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSCertificates]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSCertificates](
	[CertificateId] [int] NOT NULL,
	[CertificateTypeId] [int] NOT NULL,
	[CertificateUID] [varchar](32) NOT NULL,
	[TransactionId] [int] NOT NULL,
	[RecorderOfficeId] [int] NOT NULL,
	[PropertyId] [int] NOT NULL,
	[OwnerName] [varchar](512) NOT NULL,
	[CertificateNotes] [varchar](1024) NOT NULL,
	[CertificateExtData] [varchar](max) NOT NULL,
	[CertificateAsText] [varchar](max) NOT NULL,
	[CertificateKeywords] [varchar](2048) NOT NULL,
	[IssueTime] [smalldatetime] NOT NULL,
	[IssuedById] [int] NOT NULL,
	[IssueMode] [char](1) NOT NULL,
	[PostedById] [int] NOT NULL,
	[PostingTime] [smalldatetime] NOT NULL,
	[CertificateStatus] [char](1) NOT NULL,
	[CertificateDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSCertificates] PRIMARY KEY CLUSTERED
(
	[CertificateId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSDocuments]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSDocuments](
	[DocumentId] [int] NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[DocumentSubtypeId] [int] NOT NULL,
	[DocumentUID] [varchar](32) NOT NULL,
	[ImagingControlID] [varchar](32) NOT NULL,
	[DocumentOverview] [varchar](max) NOT NULL,
	[DocumentAsText] [varchar](512) NOT NULL,
	[DocumentExtData] [varchar](4000) NOT NULL,
	[DocumentKeywords] [varchar](2048) NOT NULL,
	[PresentationTime] [datetime] NOT NULL,
	[AuthorizationTime] [smalldatetime] NOT NULL,
	[IssuePlaceId] [int] NOT NULL,
	[IssueOfficeId] [int] NOT NULL,
	[IssuedById] [int] NOT NULL,
	[IssueDate] [smalldatetime] NOT NULL,
	[SheetsCount] [int] NOT NULL,
	[DocumentStatus] [char](1) NOT NULL,
	[PostedById] [int] NOT NULL,
	[PostingTime] [smalldatetime] NOT NULL,
	[DocumentDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSRegisterActs] PRIMARY KEY CLUSTERED
(
	[DocumentId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSHistoricData]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSHistoricData](
	[ID] [int] NOT NULL,
	[TRAMITE] [varchar](60) NOT NULL,
	[DOCUMENTO_ELECTRONICO] [varchar](80) NOT NULL,
	[PARTIDA_SISTEMA_COMPLETA] [varchar](500) NOT NULL,
	[DISTRITO_SISTEMA] [varchar](90) NOT NULL,
	[SECCION_SISTEMA] [varchar](90) NOT NULL,
	[VOLUMEN_SISTEMA] [varchar](90) NOT NULL,
	[PARTIDA_SISTEMA] [varchar](90) NOT NULL,
	[ANTECEDENTE_COMPLETO] [varchar](8000) NOT NULL,
	[DISTRITO_ANTECEDENTE] [varchar](90) NOT NULL,
	[SECCCION_ANTECEDENTE] [varchar](90) NOT NULL,
	[VOLUMEN_ANTECEDENTE] [varchar](90) NOT NULL,
	[PARTIDA_ANTECEDENTE] [varchar](90) NOT NULL,
	[ANOTACION_MARGINAL] [varchar](8000) NOT NULL,
	[NOMBRE] [varchar](1800) NOT NULL,
	[USUARIO] [varchar](400) NOT NULL,
	[PALABRAS_CLAVE] [varchar](400) NOT NULL,
	[ORIGEN] [varchar](400) NOT NULL,
 CONSTRAINT [PK_IDN] PRIMARY KEY CLUSTERED
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSImageProcessingTrail]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSImageProcessingTrail](
	[TrailId] [int] IDENTITY(1,1) NOT NULL,
	[ImageName] [varchar](128) NOT NULL,
	[ImageType] [char](1) NOT NULL,
	[TrailTimestamp] [smalldatetime] NOT NULL,
	[TrailMsg] [varchar](255) NOT NULL,
	[DocumentId] [int] NOT NULL,
	[ImagingItemId] [int] NOT NULL,
	[ImagePath] [varchar](512) NOT NULL,
	[TrailStatus] [char](1) NOT NULL,
	[ExceptionData] [varchar](8000) NOT NULL,
 CONSTRAINT [PK_ImageProcessingTrail] PRIMARY KEY CLUSTERED
(
	[TrailId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSImagingItems]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSImagingItems](
	[ImagingItemId] [int] NOT NULL,
	[ImagingItemTypeId] [int] NOT NULL,
	[TransactionId] [int] NOT NULL,
	[DocumentId] [int] NOT NULL,
	[PhysicalBookId] [int] NOT NULL,
	[ImageType] [char](1) NOT NULL,
	[BaseFolderId] [int] NOT NULL,
	[ImagingItemPath] [varchar](255) NOT NULL,
	[ImagingItemExtData] [varchar](8000) NOT NULL,
	[FilesCount] [int] NOT NULL,
	[DigitalizedById] [int] NOT NULL,
	[DigitalizationDate] [smalldatetime] NOT NULL,
	[ImagingItemStatus] [char](1) NOT NULL,
	[ImagingItemDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSImagingItems] PRIMARY KEY CLUSTERED
(
	[ImagingItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSParties]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSParties](
	[PartyId] [int] NOT NULL,
	[PartyTypeId] [int] NOT NULL,
	[PartyFullName] [varchar](255) NOT NULL,
	[PartyNotes] [varchar](512) NOT NULL,
	[PartyExtData] [varchar](8000) NOT NULL,
	[PartyKeywords] [varchar](1024) NOT NULL,
	[PartyStatus] [char](1) NOT NULL,
	[PartyDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSParties] PRIMARY KEY CLUSTERED
(
	[PartyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSPayments]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSPayments](
	[PaymentId] [int] NOT NULL,
	[TransactionId] [int] NOT NULL,
	[PaymentOfficeId] [int] NOT NULL,
	[ReceiptNo] [varchar](48) NOT NULL,
	[ReceiptTotal] [decimal](9, 2) NOT NULL,
	[ReceiptIssuedTime] [smalldatetime] NOT NULL,
	[PaymentExtData] [varchar](1024) NOT NULL,
	[PhysicalRecordingId] [int] NOT NULL,
	[PostingTime] [smalldatetime] NOT NULL,
	[PostedById] [int] NOT NULL,
	[PaymentStatus] [char](1) NOT NULL,
	[PaymentDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSPayments] PRIMARY KEY CLUSTERED
(
	[PaymentId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSPhysicalBooks]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSPhysicalBooks](
	[PhysicalBookId] [int] NOT NULL,
	[RecorderOfficeId] [int] NOT NULL,
	[RecordingSectionId] [int] NOT NULL,
	[BookNo] [varchar](64) NOT NULL,
	[BookAsText] [varchar](512) NOT NULL,
	[BookExtData] [varchar](2048) NOT NULL,
	[BookKeywords] [varchar](1024) NOT NULL,
	[StartRecordingIndex] [int] NOT NULL,
	[EndRecordingIndex] [int] NOT NULL,
	[BookStatus] [char](1) NOT NULL,
	[BookDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSPhysicalBooks] PRIMARY KEY CLUSTERED
(
	[PhysicalBookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSPhysicalRecordings]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSPhysicalRecordings](
	[PhysicalRecordingId] [int] NOT NULL,
	[PhysicalBookId] [int] NOT NULL,
	[MainDocumentId] [int] NOT NULL,
	[RecordingNo] [varchar](24) NOT NULL,
	[RecordingAsText] [varchar](512) NOT NULL,
	[RecordingExtData] [varchar](8000) NOT NULL,
	[RecordingKeywords] [varchar](2048) NOT NULL,
	[RecordedById] [int] NOT NULL,
	[RecordingTime] [smalldatetime] NOT NULL,
	[RecordingStatus] [char](1) NOT NULL,
	[RecordingDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSPhysicalRecordings] PRIMARY KEY CLUSTERED
(
	[PhysicalRecordingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSProperties]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSProperties](
	[PropertyId] [int] NOT NULL,
	[PropertyTypeId] [int] NOT NULL,
	[PropertyUID] [varchar](32) NOT NULL,
	[CadastralKey] [varchar](64) NOT NULL,
	[PropertyExtData] [varchar](8000) NOT NULL,
	[PropertyKeywords] [varchar](2048) NOT NULL,
	[PartitionOfId] [int] NOT NULL,
	[PartitionNo] [varchar](72) NOT NULL,
	[MergedIntoId] [int] NOT NULL,
	[PostingTime] [smalldatetime] NOT NULL,
	[PostedById] [int] NOT NULL,
	[PropertyStatus] [char](1) NOT NULL,
	[PropertyDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSProperties_1] PRIMARY KEY CLUSTERED
(
	[PropertyId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSRecordingActParties]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSRecordingActParties](
	[RecordingActPartyId] [int] NOT NULL,
	[RecordingActId] [int] NOT NULL,
	[PartyId] [int] NOT NULL,
	[PartyRoleId] [int] NOT NULL,
	[PartyOfId] [int] NOT NULL,
	[OwnershipPartAmount] [decimal](15, 7) NOT NULL,
	[OwnershipPartUnitId] [int] NOT NULL,
	[IsOwnershipStillActive] [bit] NOT NULL,
	[RecActPartyNotes] [varchar](255) NOT NULL,
	[RecActPartyAsText] [varchar](255) NOT NULL,
	[RecActPartyExtData] [varchar](8000) NOT NULL,
	[PostedById] [int] NOT NULL,
	[RecActPartyStatus] [char](1) NOT NULL,
	[RecActPartyDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSRecordingActParties] PRIMARY KEY NONCLUSTERED
(
	[RecordingActPartyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSRecordingActs]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSRecordingActs](
	[RecordingActId] [int] NOT NULL,
	[RecordingActTypeId] [int] NOT NULL,
	[DocumentId] [int] NOT NULL,
	[RecordingActIndex] [int] NOT NULL,
	[ResourceId] [int] NOT NULL,
	[ResourceRole] [char](1) NOT NULL,
	[RelatedResourceId] [int] NOT NULL,
	[RecordingActPercentage] [decimal](6, 5) NOT NULL,
	[RecordingActNotes] [varchar](2048) NOT NULL,
	[RecordingActExtData] [varchar](8000) NOT NULL,
	[RecordingActResourceExtData] [varchar](8000) NOT NULL,
	[RecordingActKeywords] [varchar](2048) NOT NULL,
	[AmendmentOfId] [int] NOT NULL,
	[AmendedById] [int] NOT NULL,
	[PhysicalRecordingId] [int] NOT NULL,
	[RegisteredById] [int] NOT NULL,
	[RegistrationTime] [smalldatetime] NOT NULL,
	[RecordingActStatus] [char](1) NOT NULL,
	[RecordingActDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSRecordingActs] PRIMARY KEY CLUSTERED
(
	[RecordingActId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSTransactionItems]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSTransactionItems](
	[TransactionItemId] [int] NOT NULL,
	[TransactionId] [int] NOT NULL,
	[TransactionItemTypeId] [int] NOT NULL,
	[TreasuryCodeId] [int] NOT NULL,
	[PaymentId] [int] NOT NULL,
	[Quantity] [decimal](9, 2) NOT NULL,
	[UnitId] [int] NOT NULL,
	[OperationValue] [decimal](18, 4) NOT NULL,
	[OperationValueCurrencyId] [int] NOT NULL,
	[RecordingRightsFee] [decimal](9, 2) NOT NULL,
	[SheetsRevisionFee] [decimal](9, 2) NOT NULL,
	[ForeignRecordingFee] [decimal](9, 2) NOT NULL,
	[Discount] [decimal](9, 2) NOT NULL,
	[TransactionItemExtData] [varchar](1024) NOT NULL,
	[TransactionItemStatus] [char](1) NOT NULL,
	[TransactionItemDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_Table_1_4] PRIMARY KEY CLUSTERED
(
	[TransactionItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSTransactions]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSTransactions](
	[TransactionId] [int] NOT NULL,
	[TransactionTypeId] [int] NOT NULL,
	[TransactionUID] [varchar](32) NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[DocumentDescriptor] [varchar](128) NOT NULL,
	[DocumentId] [int] NOT NULL,
	[BaseResourceId] [int] NOT NULL,
	[RecorderOfficeId] [int] NOT NULL,
	[RequestedBy] [varchar](512) NOT NULL,
	[AgencyId] [int] NOT NULL,
	[ExternalTransactionNo] [varchar](48) NOT NULL,
	[TransactionExtData] [varchar](8000) NOT NULL,
	[TransactionKeywords] [varchar](2048) NOT NULL,
	[PresentationTime] [datetime] NOT NULL,
	[ExpectedDelivery] [smalldatetime] NOT NULL,
	[LastReentryTime] [smalldatetime] NOT NULL,
	[ClosingTime] [smalldatetime] NOT NULL,
	[LastDeliveryTime] [smalldatetime] NOT NULL,
	[NonWorkingTime] [int] NOT NULL,
	[ComplexityIndex] [decimal](4, 1) NOT NULL,
	[IsArchived] [bit] NOT NULL,
	[TransactionStatus] [char](1) NOT NULL,
	[TransactionDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSTransactions] PRIMARY KEY CLUSTERED
(
	[TransactionId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LRSTransactionTrack]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LRSTransactionTrack](
	[TrackId] [int] NOT NULL,
	[TransactionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Mode] [char](1) NOT NULL,
	[AssignedById] [int] NOT NULL,
	[ResponsibleId] [int] NOT NULL,
	[NextContactId] [int] NOT NULL,
	[CurrentTransactionStatus] [char](1) NOT NULL,
	[NextTransactionStatus] [char](1) NOT NULL,
	[CheckInTime] [smalldatetime] NOT NULL,
	[EndProcessTime] [smalldatetime] NOT NULL,
	[CheckOutTime] [smalldatetime] NOT NULL,
	[TrackNotes] [varchar](512) NOT NULL,
	[PreviousTrackId] [int] NOT NULL,
	[NextTrackId] [int] NOT NULL,
	[TrackStatus] [char](1) NOT NULL,
	[TrackDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_LRSTransactionTrack] PRIMARY KEY CLUSTERED
(
	[TrackId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ObjectLinks]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ObjectLinks](
	[LinkId] [int] NOT NULL,
	[TypeRelationId] [int] NOT NULL,
	[SourceId] [int] NOT NULL,
	[TargetId] [int] NOT NULL,
	[LinkIndex] [int] NOT NULL,
	[LinkExtData] [varchar](1024) NOT NULL,
	[LinkStatus] [char](1) NOT NULL,
	[StartDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_ObjectLinks_1] PRIMARY KEY CLUSTERED
(
	[LinkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OldLegacyParties]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OldLegacyParties](
	[LegacyPartyId] [int] NOT NULL,
	[FullName] [varchar](512) NOT NULL,
	[Volumen] [varchar](32) NOT NULL,
	[Partida] [varchar](32) NOT NULL,
	[Fecha] [varchar](64) NOT NULL,
	[Seccion] [varchar](64) NOT NULL,
	[Distrito] [varchar](64) NOT NULL,
	[Keywords] [varchar](512) NOT NULL,
 CONSTRAINT [PK_OldLegacyParties] PRIMARY KEY CLUSTERED
(
	[LegacyPartyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OldRecordingModelData]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OldRecordingModelData](
	[RecorderOfficeId] [int] NOT NULL,
	[RecorderOffice] [varchar](128) NOT NULL,
	[SectionNo] [varchar](64) NOT NULL,
	[PhysicalBookNo] [varchar](64) NOT NULL,
	[PhysicalBookFullName] [varchar](512) NOT NULL,
	[PhysicalBookId] [int] NOT NULL,
	[PhysicalRecordingNo] [varchar](128) NOT NULL,
	[DocumentId] [int] NOT NULL,
	[DocumentUID] [varchar](32) NOT NULL,
	[RecordingActTypeId] [int] NOT NULL,
	[RecordingActType] [varchar](128) NOT NULL,
	[OldRecordingId] [int] NOT NULL,
	[OldRecordingActId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QueuedMessages]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QueuedMessages](
	[MessageId] [int] NOT NULL,
	[MessageTypeId] [int] NOT NULL,
	[QueueId] [int] NOT NULL,
	[MessageUID] [varchar](36) NOT NULL,
	[UnitOfWorkUID] [varchar](36) NOT NULL,
	[PostingTime] [datetime] NOT NULL,
	[MessageData] [varchar](max) NOT NULL,
	[ProcessingTime] [datetime] NOT NULL,
	[ProcessingData] [varchar](max) NOT NULL,
	[ProcessingStatus] [char](1) NOT NULL,
 CONSTRAINT [PK_MessageQueue] PRIMARY KEY CLUSTERED
(
	[MessageId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SecurityClaims]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SecurityClaims](
	[SecurityClaimId] [int] NOT NULL,
	[SecurityClaimTypeId] [int] NOT NULL,
	[UID] [varchar](36) NOT NULL,
	[SubjectToken] [varchar](64) NOT NULL,
	[ClaimValue] [varchar](max) NOT NULL,
	[LastUpdated] [smalldatetime] NOT NULL,
	[ClaimStatus] [char](1) NOT NULL,
	[ClaimDIF] [varchar](65) NOT NULL,
 CONSTRAINT [PK_Claims] PRIMARY KEY CLUSTERED
(
	[SecurityClaimId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SimpleObjects]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SimpleObjects](
	[ObjectId] [int] NOT NULL,
	[ObjectTypeId] [int] NOT NULL,
	[ObjectKey] [varchar](128) NOT NULL,
	[ObjectName] [varchar](512) NOT NULL,
	[ObjectExtData] [varchar](max) NOT NULL,
	[ObjectKeywords] [varchar](2048) NOT NULL,
	[ObjectStatus] [char](1) NOT NULL,
 CONSTRAINT [PK_SimpleObjects] PRIMARY KEY CLUSTERED
(
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeRelations]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeRelations](
	[TypeRelationId] [int] NOT NULL,
	[SourceTypeId] [int] NOT NULL,
	[TargetTypeId] [int] NOT NULL,
	[AssociationTypeId] [int] NOT NULL,
	[RelationTypeFamily] [varchar](24) NOT NULL,
	[RelationName] [varchar](64) NOT NULL,
	[DisplayName] [varchar](64) NOT NULL,
	[DisplayPluralName] [varchar](64) NOT NULL,
	[Documentation] [varchar](128) NOT NULL,
	[Cardinality] [varchar](64) NOT NULL,
	[TypeRelationExtData] [varchar](8000) NOT NULL,
	[TypeRelationKeywords] [varchar](512) NOT NULL,
	[TypeRelationDataSource] [varchar](64) NOT NULL,
	[SourceIdFieldName] [varchar](48) NOT NULL,
	[TargetIdFieldName] [varchar](48) NOT NULL,
	[TypeRelationIdFieldName] [varchar](48) NOT NULL,
	[TypeRelationStatus] [char](1) NOT NULL,
 CONSTRAINT [PK_TypeRelations] PRIMARY KEY CLUSTERED
(
	[TypeRelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Types]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Types](
	[TypeId] [int] NOT NULL,
	[TypeName] [varchar](128) NOT NULL,
	[BaseTypeId] [int] NOT NULL,
	[TypeFamily] [varchar](24) NOT NULL,
	[AssemblyName] [varchar](64) NOT NULL,
	[ClassName] [varchar](128) NOT NULL,
	[DisplayName] [varchar](128) NOT NULL,
	[DisplayPluralName] [varchar](128) NOT NULL,
	[FemaleGenre] [bit] NOT NULL,
	[Documentation] [varchar](1024) NOT NULL,
	[TypeExtData] [varchar](8000) NOT NULL,
	[TypeKeywords] [varchar](512) NOT NULL,
	[SolutionName] [varchar](64) NOT NULL,
	[SystemName] [varchar](64) NOT NULL,
	[Version] [varchar](24) NOT NULL,
	[LastUpdate] [smalldatetime] NOT NULL,
	[TypeDataSource] [varchar](128) NOT NULL,
	[IdFieldName] [varchar](48) NOT NULL,
	[NamedIdFieldName] [varchar](48) NOT NULL,
	[TypeIdFieldName] [varchar](48) NOT NULL,
	[IsAbstract] [bit] NOT NULL,
	[IsSealed] [bit] NOT NULL,
	[IsHistorizable] [bit] NOT NULL,
	[TypeStatus] [char](1) NOT NULL,
 CONSTRAINT [PK_Types] PRIMARY KEY CLUSTERED
(
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UIComponentItems]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UIComponentItems](
	[UIComponentItemId] [int] NOT NULL,
	[UIComponentId] [int] NOT NULL,
	[UIComponentType] [varchar](32) NOT NULL,
	[UITemplate] [varchar](255) NOT NULL,
	[ParentUIComponentId] [int] NOT NULL,
	[RowIndex] [int] NOT NULL,
	[ColumnIndex] [int] NOT NULL,
	[RowSpan] [int] NOT NULL,
	[ColumnSpan] [int] NOT NULL,
	[DisplayName] [varchar](208) NOT NULL,
	[ToolTip] [varchar](128) NOT NULL,
	[Disabled] [bit] NOT NULL,
	[DisplayViewId] [int] NOT NULL,
	[Style] [varchar](128) NOT NULL,
	[AttributesString] [varchar](255) NOT NULL,
	[ValuesString] [varchar](512) NOT NULL,
	[DataBoundMode] [varchar](12) NOT NULL,
	[DataMember] [varchar](128) NOT NULL,
	[DataItem] [varchar](128) NOT NULL,
	[UIControlID] [varchar](48) NOT NULL,
 CONSTRAINT [PK_UIComponents] PRIMARY KEY CLUSTERED
(
	[UIComponentItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSessions]    Script Date: 20/May/2020 5:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSessions](
	[SessionId] [int] IDENTITY(1,1) NOT NULL,
	[SessionToken] [varchar](128) NOT NULL,
	[ServerId] [int] NOT NULL,
	[ClientAppId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[ExpiresIn] [int] NOT NULL,
	[RefreshToken] [varchar](64) NOT NULL,
	[SessionExtData] [varchar](2048) NOT NULL,
	[StartTime] [smalldatetime] NOT NULL,
	[EndTime] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_UserSessions] PRIMARY KEY CLUSTERED
(
	[SessionId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Contacts_UID]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Contacts_UID] ON [dbo].[Contacts]
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DataLogObjectId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_DataLogObjectId] ON [dbo].[DataLog]
(
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_EOPSignRequestsSignableDocumentId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_EOPSignRequestsSignableDocumentId] ON [dbo].[EOPSignRequests]
(
	[SignableDocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSCertificatesPropertyId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSCertificatesPropertyId] ON [dbo].[LRSCertificates]
(
	[PropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSCertificatesTransactionId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSCertificatesTransactionId] ON [dbo].[LRSCertificates]
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_LRSDocumentUID]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_LRSDocumentUID] ON [dbo].[LRSDocuments]
(
	[DocumentUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSPayments_TransactionId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSPayments_TransactionId] ON [dbo].[LRSPayments]
(
	[TransactionId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSRecordingActPartiesPartyId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSRecordingActPartiesPartyId] ON [dbo].[LRSRecordingActParties]
(
	[PartyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSRecordingActPartiesPartyOfId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSRecordingActPartiesPartyOfId] ON [dbo].[LRSRecordingActParties]
(
	[PartyOfId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSRecordingActPartiesRecordingActId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSRecordingActPartiesRecordingActId] ON [dbo].[LRSRecordingActParties]
(
	[RecordingActId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSRecordingActsDocumentId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSRecordingActsDocumentId] ON [dbo].[LRSRecordingActs]
(
	[DocumentId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSRecordingActsRecordingActTypeId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSRecordingActsRecordingActTypeId] ON [dbo].[LRSRecordingActs]
(
	[RecordingActTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSRecordingActsRecordingId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSRecordingActsRecordingId] ON [dbo].[LRSRecordingActs]
(
	[PhysicalRecordingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSRecordingActsRelatedResourceId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSRecordingActsRelatedResourceId] ON [dbo].[LRSRecordingActs]
(
	[RelatedResourceId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSRecordingActsResourceId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSRecordingActsResourceId] ON [dbo].[LRSRecordingActs]
(
	[ResourceId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSTransactionActsLawArticleId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionActsLawArticleId] ON [dbo].[LRSTransactionItems]
(
	[TreasuryCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSTransactionActsTransactionId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionActsTransactionId] ON [dbo].[LRSTransactionItems]
(
	[TransactionId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSTransactionsDocumentId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionsDocumentId] ON [dbo].[LRSTransactions]
(
	[DocumentId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_LRSTransactionsExternalTransactionNo]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionsExternalTransactionNo] ON [dbo].[LRSTransactions]
(
	[ExternalTransactionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSTransactionsPresentationTime]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionsPresentationTime] ON [dbo].[LRSTransactions]
(
	[PresentationTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSTransactionsTransactionTypeId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionsTransactionTypeId] ON [dbo].[LRSTransactions]
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_LRSTransactionUID]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_LRSTransactionUID] ON [dbo].[LRSTransactions]
(
	[TransactionUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSTransactionTrack_AssignedById]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionTrack_AssignedById] ON [dbo].[LRSTransactionTrack]
(
	[AssignedById] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_LRSTransactionTrack_For_vwLRSTransactionsAndCurrentTrack]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionTrack_For_vwLRSTransactionsAndCurrentTrack] ON [dbo].[LRSTransactionTrack]
(
	[NextTrackId] ASC,
	[TrackStatus] ASC,
	[ResponsibleId] ASC,
	[NextTransactionStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSTransactionTrack_NextContactId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionTrack_NextContactId] ON [dbo].[LRSTransactionTrack]
(
	[NextContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSTransactionTrack_ResponsibleId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionTrack_ResponsibleId] ON [dbo].[LRSTransactionTrack]
(
	[ResponsibleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSTransactionTrack_TransactionId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionTrack_TransactionId] ON [dbo].[LRSTransactionTrack]
(
	[TransactionId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LRSTransactionTrackNextTrackId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_LRSTransactionTrackNextTrackId] ON [dbo].[LRSTransactionTrack]
(
	[NextTrackId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ObjectLinksTypeRelationIdSourceId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_ObjectLinksTypeRelationIdSourceId] ON [dbo].[ObjectLinks]
(
	[TypeRelationId] ASC,
	[SourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ObjectLinksTypeRelationIdTargetId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_ObjectLinksTypeRelationIdTargetId] ON [dbo].[ObjectLinks]
(
	[TypeRelationId] ASC,
	[TargetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_SimpleObjects_ObjectKey]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_SimpleObjects_ObjectKey] ON [dbo].[SimpleObjects]
(
	[ObjectKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SimpleObjects_ObjectTypeId]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_SimpleObjects_ObjectTypeId] ON [dbo].[SimpleObjects]
(
	[ObjectTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Types_TypeName]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Types_TypeName] ON [dbo].[Types]
(
	[TypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserSessions_SessionToken]    Script Date: 20/May/2020 5:00:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserSessions_SessionToken] ON [dbo].[UserSessions]
(
	[SessionToken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Contacts] ADD  CONSTRAINT [DF_Contacts_ContactUID]  DEFAULT ('') FOR [ContactUID]
GO
ALTER TABLE [dbo].[DbRules] ADD  CONSTRAINT [DF_DbRules_DbRuleId]  DEFAULT ((0)) FOR [DbRuleId]
GO
ALTER TABLE [dbo].[DbRules] ADD  CONSTRAINT [DF_DbRules_StorageName]  DEFAULT (char((0))) FOR [StorageName]
GO
ALTER TABLE [dbo].[LRSDocuments] ADD  CONSTRAINT [DF_LRSDocuments_ImagingControlCode]  DEFAULT ('') FOR [ImagingControlID]
GO
ALTER TABLE [dbo].[LRSDocuments] ADD  CONSTRAINT [DF_LRSDocuments_DocumentExtData]  DEFAULT ('') FOR [DocumentExtData]
GO
ALTER TABLE [dbo].[LRSDocuments] ADD  CONSTRAINT [DF_LRSDocuments_SheetsCount]  DEFAULT ((0)) FOR [SheetsCount]
GO
ALTER TABLE [dbo].[LRSImagingItems] ADD  CONSTRAINT [DF_LRSImagingItems_TransactionId]  DEFAULT ((-1)) FOR [TransactionId]
GO
ALTER TABLE [dbo].[LRSImagingItems] ADD  CONSTRAINT [DF_LRSImagingItems_DigitalizedById]  DEFAULT ((-1)) FOR [DigitalizedById]
GO
ALTER TABLE [dbo].[LRSImagingItems] ADD  CONSTRAINT [DF_LRSImagingItems_DigitalizationDate]  DEFAULT ('1900-01-01') FOR [DigitalizationDate]
GO
ALTER TABLE [dbo].[LRSImagingItems] ADD  CONSTRAINT [DF_LRSImagingItems_ImagingItemStatus]  DEFAULT ('A') FOR [ImagingItemStatus]
GO
ALTER TABLE [dbo].[LRSPhysicalRecordings] ADD  CONSTRAINT [DF_LRSPhysicalRecordings_MainDocumentId]  DEFAULT ((-1)) FOR [MainDocumentId]
GO
ALTER TABLE [dbo].[LRSTransactionItems] ADD  CONSTRAINT [DF_LRSTransactionActs_ReceiptId]  DEFAULT ((-1)) FOR [PaymentId]
GO
ALTER TABLE [dbo].[LRSTransactionItems] ADD  CONSTRAINT [DF_LRSTransactionActs_OperationValueCurrencyId]  DEFAULT ((-1)) FOR [OperationValueCurrencyId]
GO
ALTER TABLE [dbo].[LRSTransactionItems] ADD  CONSTRAINT [DF_LRSTransactionItems_TransactionItemExtData]  DEFAULT ('') FOR [TransactionItemExtData]
GO
ALTER TABLE [dbo].[LRSTransactions] ADD  CONSTRAINT [DF_LRSTransactions_DocumentId]  DEFAULT ((-1)) FOR [DocumentId]
GO
ALTER TABLE [dbo].[LRSTransactions] ADD  CONSTRAINT [DF_LRSTransactions_ExpectedDelivery]  DEFAULT ('2078-12-31') FOR [ExpectedDelivery]
GO
ALTER TABLE [dbo].[LRSTransactions] ADD  CONSTRAINT [DF_LRSTransactions_LastReentryTime]  DEFAULT ('2078-12-31') FOR [LastReentryTime]
GO
ALTER TABLE [dbo].[LRSTransactions] ADD  CONSTRAINT [DF_LRSTransactions_LastDeliveryTime]  DEFAULT ('2078-12-31') FOR [LastDeliveryTime]
GO
ALTER TABLE [dbo].[LRSTransactions] ADD  CONSTRAINT [DF_LRSTransactions_NonWorkingTime]  DEFAULT ((0)) FOR [NonWorkingTime]
GO
ALTER TABLE [dbo].[LRSTransactions] ADD  CONSTRAINT [DF_LRSTransactions_ComplexityIndex]  DEFAULT ((0)) FOR [ComplexityIndex]
GO
ALTER TABLE [dbo].[LRSTransactions] ADD  CONSTRAINT [DF_LRSTransactions_IsArchived]  DEFAULT ((0)) FOR [IsArchived]
GO
ALTER TABLE [dbo].[OldLegacyParties] ADD  CONSTRAINT [DF_OldLegacyParties_Keywords]  DEFAULT ('') FOR [Keywords]
GO
ALTER TABLE [dbo].[UIComponentItems] ADD  CONSTRAINT [DF_EUIItems_ToolTip]  DEFAULT (char((0))) FOR [ToolTip]
GO
ALTER TABLE [dbo].[UIComponentItems] ADD  CONSTRAINT [DF_EUIItems_DataItemDirection]  DEFAULT ('ReadWrite') FOR [DataBoundMode]
GO
