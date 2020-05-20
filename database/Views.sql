USE [Land]
GO
/****** Object:  View [dbo].[vwLRSPaymentsByItem]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSPaymentsByItem]
AS
SELECT        dbo.LRSTransactions.TransactionId, SimpleObjects_1.ObjectName AS TransactionType, SimpleObjects_2.ObjectName AS DocumentType, dbo.LRSTransactionItems.TransactionItemTypeId, dbo.LRSTransactions.TransactionUID,
                         dbo.LRSTransactions.PresentationTime, dbo.LRSTransactions.RequestedBy, dbo.Types.DisplayName AS TransactionItemType, dbo.SimpleObjects.ObjectName AS FinancialLaw, dbo.LRSPayments.ReceiptNo,
                         dbo.LRSTransactionItems.OperationValue, dbo.LRSTransactionItems.RecordingRightsFee, dbo.LRSTransactionItems.SheetsRevisionFee, dbo.LRSTransactionItems.ForeignRecordingFee, dbo.LRSTransactionItems.Discount,
                         dbo.LRSTransactionItems.RecordingRightsFee + dbo.LRSTransactionItems.SheetsRevisionFee + dbo.LRSTransactionItems.ForeignRecordingFee - dbo.LRSTransactionItems.Discount AS Total
FROM            dbo.LRSTransactions INNER JOIN
                         dbo.LRSTransactionItems ON dbo.LRSTransactions.TransactionId = dbo.LRSTransactionItems.TransactionId INNER JOIN
                         dbo.Types ON dbo.LRSTransactionItems.TransactionItemTypeId = dbo.Types.TypeId INNER JOIN
                         dbo.SimpleObjects ON dbo.LRSTransactionItems.TreasuryCodeId = dbo.SimpleObjects.ObjectId INNER JOIN
                         dbo.LRSPayments ON dbo.LRSTransactions.TransactionId = dbo.LRSPayments.TransactionId INNER JOIN
                         dbo.SimpleObjects AS SimpleObjects_1 ON dbo.LRSTransactions.TransactionTypeId = SimpleObjects_1.ObjectId INNER JOIN
                         dbo.SimpleObjects AS SimpleObjects_2 ON dbo.LRSTransactions.DocumentTypeId = SimpleObjects_2.ObjectId
WHERE        (dbo.LRSTransactions.TransactionStatus NOT IN ('X', 'Y')) AND (dbo.LRSTransactionItems.TransactionItemStatus <> 'X')

GO
/****** Object:  View [dbo].[vwLRSPaymentsByItemPerYearTotals]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSPaymentsByItemPerYearTotals]
AS
SELECT        TOP (100) PERCENT YEAR(PresentationTime) AS Year, COUNT(TransactionId) AS Count, TransactionItemType AS Act, SUM(Total) AS Total
FROM            dbo.vwLRSPaymentsByItem
GROUP BY YEAR(PresentationTime), TransactionItemType
ORDER BY Year DESC, Act

GO
/****** Object:  View [dbo].[vwContacts]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwContacts]
WITH SCHEMABINDING
AS
SELECT        ContactId, ContactTypeId, ContactFullName, ShortName AS ContactShortName, Nickname, ContactKeywords, ContactStatus
FROM            dbo.Contacts


GO
/****** Object:  View [dbo].[vwLRSRecordingActs]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLRSRecordingActs]
AS
SELECT        TOP (100) PERCENT dbo.LRSRecordingActs.RecordingActId, dbo.LRSRecordingActs.RecordingActTypeId, dbo.LRSRecordingActs.DocumentId, dbo.LRSRecordingActs.RecordingActIndex,
                         dbo.LRSRecordingActs.RecordingActNotes, dbo.LRSRecordingActs.RecordingActExtData, dbo.LRSRecordingActs.RecordingActKeywords, dbo.LRSRecordingActs.AmendmentOfId,
                         dbo.LRSRecordingActs.AmendedById, dbo.LRSRecordingActs.RegisteredById, dbo.LRSRecordingActs.RegistrationTime, dbo.LRSRecordingActs.RecordingActStatus, dbo.LRSRecordingActs.RecordingActDIF,
                         dbo.Types.TypeName AS RecordingActTypeName, dbo.Types.DisplayName AS RecordingActTypeDisplayName, vwContacts_1.ContactShortName AS RecordingActRegisteredBy,
                         dbo.LRSPhysicalBooks.RecorderOfficeId, dbo.vwContacts.ContactShortName AS RecorderOffice, dbo.LRSPhysicalRecordings.PhysicalRecordingId, dbo.LRSPhysicalBooks.PhysicalBookId,
                         dbo.LRSPhysicalBooks.BookAsText, dbo.LRSPhysicalRecordings.RecordingNo, dbo.LRSDocuments.PresentationTime, dbo.LRSPhysicalRecordings.RecordingStatus, dbo.LRSPhysicalBooks.BookStatus
FROM            dbo.LRSDocuments INNER JOIN
                         dbo.LRSRecordingActs ON dbo.LRSDocuments.DocumentId = dbo.LRSRecordingActs.DocumentId INNER JOIN
                         dbo.LRSPhysicalBooks INNER JOIN
                         dbo.LRSPhysicalRecordings ON dbo.LRSPhysicalBooks.PhysicalBookId = dbo.LRSPhysicalRecordings.PhysicalBookId INNER JOIN
                         dbo.vwContacts ON dbo.LRSPhysicalBooks.RecorderOfficeId = dbo.vwContacts.ContactId ON dbo.LRSRecordingActs.PhysicalRecordingId = dbo.LRSPhysicalRecordings.PhysicalRecordingId INNER JOIN
                         dbo.vwContacts AS vwContacts_1 ON dbo.LRSRecordingActs.RegisteredById = vwContacts_1.ContactId INNER JOIN
                         dbo.Types ON dbo.LRSRecordingActs.RecordingActTypeId = dbo.Types.TypeId
WHERE        (dbo.LRSRecordingActs.RecordingActStatus <> 'X') AND (dbo.Types.TypeName <> 'ObjectType.RecordingAct.InformativeAct.Empty')
GO
/****** Object:  View [dbo].[vwLRSPaymentsAnalysis]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLRSPaymentsAnalysis]
AS
SELECT        TOP (100) PERCENT YEAR(PresentationTime) AS Year, MONTH(PresentationTime) AS Month, DATEPART(ww, PresentationTime) AS Week, COUNT(TransactionId) AS TransactionsCount, SUM(Total) AS Total,
                         SUM(Total) / COUNT(TransactionId) AS PerTransaction, SUM(CASE WHEN Total = 0 THEN 1 ELSE 0 END) AS CountZeros, SUM(CASE WHEN Total = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(TransactionId)
                         AS ZerosPercentage
FROM            dbo.vwLRSPaymentsByItem
GROUP BY YEAR(PresentationTime), MONTH(PresentationTime), DATEPART(ww, PresentationTime)
ORDER BY Year, Month, Week
GO
/****** Object:  View [dbo].[vwLRSPaymentsAnalysisProtected]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSPaymentsAnalysisProtected]
AS
SELECT        TOP (100) PERCENT YEAR(PresentationTime) AS Year, MONTH(PresentationTime) AS Month, DATEPART(ww, PresentationTime) AS Week, TransactionType, DocumentType, TransactionItemType,
                         COUNT(TransactionId) AS TransactionsCount, SUM(Total) AS Total, SUM(Total) / COUNT(TransactionId) AS PerTransaction, SUM(CASE WHEN Total = 0 THEN 1 ELSE 0 END) AS CountZeros,
                         SUM(CASE WHEN Total = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(TransactionId) AS ZerosPercentage
FROM            dbo.vwLRSPaymentsByItem
GROUP BY YEAR(PresentationTime), MONTH(PresentationTime), DATEPART(ww, PresentationTime), TransactionType, DocumentType, TransactionItemType
ORDER BY Year, Month, Week

GO
/****** Object:  View [dbo].[vwLRSQualificationTrack]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLRSQualificationTrack]
AS
SELECT     dbo.LRSTransactionTrack.TrackId, dbo.LRSTransactionTrack.TransactionId, dbo.LRSTransactionTrack.EventId, dbo.LRSTransactionTrack.Mode,
                      dbo.LRSTransactionTrack.AssignedById, dbo.LRSTransactionTrack.ResponsibleId, dbo.vwContacts.ContactShortName AS Responsible,
                      dbo.LRSTransactionTrack.NextContactId, dbo.LRSTransactionTrack.CurrentTransactionStatus, dbo.LRSTransactionTrack.NextTransactionStatus,
                      dbo.LRSTransactionTrack.CheckInTime, dbo.LRSTransactionTrack.EndProcessTime, dbo.LRSTransactionTrack.CheckOutTime, dbo.LRSTransactionTrack.TrackNotes,
                      dbo.LRSTransactionTrack.PreviousTrackId, dbo.LRSTransactionTrack.NextTrackId, dbo.LRSTransactionTrack.TrackStatus, dbo.LRSTransactionTrack.TrackDIF
FROM         dbo.LRSTransactionTrack INNER JOIN
                      dbo.vwContacts ON dbo.LRSTransactionTrack.ResponsibleId = dbo.vwContacts.ContactId
WHERE     (dbo.LRSTransactionTrack.CurrentTransactionStatus = 'Y')
GO
/****** Object:  View [dbo].[vwLRSPaymentsTotals]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSPaymentsTotals]

AS
SELECT        dbo.LRSTransactions.TransactionId, MAX(ISNULL(dbo.LRSPayments.ReceiptNo, 'Sin recibo')) AS ReceiptNo, COUNT(ISNULL(dbo.LRSPayments.PaymentId, 0)) AS PaymentsCount,
                         SUM(ISNULL(dbo.LRSPayments.ReceiptTotal, 0)) AS PaymentsTotal
FROM            dbo.LRSPayments RIGHT OUTER JOIN
                         dbo.LRSTransactions ON dbo.LRSPayments.TransactionId = dbo.LRSTransactions.TransactionId
GROUP BY dbo.LRSTransactions.TransactionId
GO
/****** Object:  View [dbo].[vwSimpleObjects]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwSimpleObjects]
WITH SCHEMABINDING
AS
SELECT ObjectId, ObjectTypeId,ObjectKey, ObjectName
FROM   dbo.SimpleObjects
WHERE  (ObjectStatus <> 'X')

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [vwSimpleObjects_ObjectId]    Script Date: 20/May/2020 5:00:36 PM ******/
CREATE UNIQUE CLUSTERED INDEX [vwSimpleObjects_ObjectId] ON [dbo].[vwSimpleObjects]
(
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwLRSTransactions]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLRSTransactions]
AS
SELECT        dbo.LRSTransactions.TransactionId, dbo.LRSTransactions.TransactionTypeId, dbo.LRSTransactions.TransactionUID, dbo.LRSTransactions.DocumentTypeId, dbo.LRSTransactions.DocumentDescriptor,
                         dbo.LRSTransactions.DocumentId, dbo.LRSTransactions.TransactionKeywords, dbo.LRSTransactions.RecorderOfficeId, dbo.vwContacts.ContactShortName AS RecorderOffice, dbo.LRSTransactions.RequestedBy,
                         dbo.LRSTransactions.AgencyId, CASE AgencyId WHEN - 1 THEN 'Particular' ELSE vwContacts_1.ContactFullName END AS Agency, dbo.LRSTransactions.ExternalTransactionNo,
                         dbo.LRSTransactions.PresentationTime, dbo.LRSTransactions.ExpectedDelivery, dbo.LRSTransactions.ComplexityIndex, dbo.LRSTransactions.LastReentryTime, dbo.LRSTransactions.ClosingTime,
                         dbo.LRSTransactions.LastDeliveryTime, dbo.LRSTransactions.NonWorkingTime, dbo.LRSTransactions.IsArchived, dbo.LRSTransactions.TransactionStatus, vwSimpleObjects_1.ObjectName AS TransactionType,
                         dbo.vwSimpleObjects.ObjectName AS DocumentType, tabEnumeration_1.DisplayName AS TransactionStatusName, dbo.vwLRSPaymentsTotals.ReceiptNo, dbo.vwLRSPaymentsTotals.PaymentsCount,
                         dbo.vwLRSPaymentsTotals.PaymentsTotal
FROM            dbo.LRSTransactions INNER JOIN
                         dbo.vwContacts ON dbo.LRSTransactions.RecorderOfficeId = dbo.vwContacts.ContactId INNER JOIN
                         dbo.tabEnumeration('ValueType.Enumeration.LRSTransactionStatus') AS tabEnumeration_1 ON dbo.LRSTransactions.TransactionStatus = tabEnumeration_1.Value INNER JOIN
                         dbo.vwContacts AS vwContacts_1 ON dbo.LRSTransactions.AgencyId = vwContacts_1.ContactId INNER JOIN
                         dbo.vwSimpleObjects ON dbo.LRSTransactions.DocumentTypeId = dbo.vwSimpleObjects.ObjectId INNER JOIN
                         dbo.vwSimpleObjects AS vwSimpleObjects_1 ON dbo.LRSTransactions.TransactionTypeId = vwSimpleObjects_1.ObjectId INNER JOIN
                         dbo.vwLRSPaymentsTotals ON dbo.LRSTransactions.TransactionId = dbo.vwLRSPaymentsTotals.TransactionId
GO
/****** Object:  View [dbo].[vwLRSDocuments]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwLRSDocuments]
WITH SCHEMABINDING
AS

SELECT        dbo.LRSDocuments.DocumentId, dbo.LRSDocuments.DocumentUID, dbo.LRSDocuments.DocumentTypeId, dbo.LRSDocuments.DocumentSubtypeId, dbo.vwSimpleObjects.ObjectName AS DocumentSubType,
                         dbo.LRSDocuments.AuthorizationTime, dbo.LRSDocuments.ImagingControlID, dbo.LRSDocuments.DocumentAsText
FROM            dbo.LRSDocuments INNER JOIN
                         dbo.vwSimpleObjects ON dbo.LRSDocuments.DocumentSubtypeId = dbo.vwSimpleObjects.ObjectId INNER JOIN
                         dbo.Types ON dbo.LRSDocuments.DocumentTypeId = dbo.Types.TypeId


GO
/****** Object:  View [dbo].[vwLRSLastTransactionTrack]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwLRSLastTransactionTrack]
WITH SCHEMABINDING
AS
SELECT [TrackId],[TransactionId],[EventId],[Mode],[AssignedById],[ResponsibleId],[NextContactId]
      ,[CurrentTransactionStatus],[NextTransactionStatus],[CheckInTime],[EndProcessTime],[CheckOutTime]
      ,[TrackNotes],[PreviousTrackId],[NextTrackId],[TrackStatus],[TrackDIF]
FROM            dbo.LRSTransactionTrack
WHERE        (TrackStatus <> 'X') AND (NextTrackId = - 1)



GO
/****** Object:  View [dbo].[vwLRSTransactionsAndCurrentTrack]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSTransactionsAndCurrentTrack]
AS
SELECT        dbo.vwLRSTransactions.TransactionId, dbo.vwLRSTransactions.TransactionTypeId, dbo.vwLRSTransactions.TransactionUID, dbo.vwLRSTransactions.ExternalTransactionNo, dbo.vwLRSTransactions.DocumentTypeId,
                         dbo.vwLRSTransactions.DocumentDescriptor, dbo.vwLRSDocuments.AuthorizationTime, dbo.vwLRSDocuments.DocumentId, dbo.vwLRSDocuments.DocumentUID, dbo.vwLRSDocuments.DocumentAsText,
                         dbo.vwLRSTransactions.TransactionKeywords, dbo.vwLRSTransactions.RecorderOfficeId, dbo.vwLRSTransactions.RecorderOffice, dbo.vwLRSTransactions.RequestedBy, dbo.vwLRSTransactions.AgencyId,
                         dbo.vwLRSTransactions.Agency, dbo.vwLRSTransactions.PresentationTime, dbo.vwLRSTransactions.ExpectedDelivery, dbo.vwLRSTransactions.ComplexityIndex, dbo.vwLRSTransactions.LastReentryTime,
                         dbo.vwLRSTransactions.ClosingTime, dbo.vwLRSTransactions.LastDeliveryTime, dbo.vwLRSTransactions.IsArchived, dbo.vwLRSTransactions.TransactionStatus, dbo.vwLRSTransactions.TransactionType,
                         dbo.vwLRSTransactions.DocumentType, dbo.vwLRSTransactions.TransactionStatusName, dbo.vwLRSLastTransactionTrack.CheckInTime, dbo.vwLRSLastTransactionTrack.EndProcessTime,
                         dbo.vwLRSLastTransactionTrack.CheckOutTime, dbo.vwLRSLastTransactionTrack.CurrentTransactionStatus, dbo.vwLRSLastTransactionTrack.NextTransactionStatus,
                         tabEnumeration_1.DisplayName AS CurrentTransactionStatusName, tabEnumeration_2.DisplayName AS NextTransactionStatusName, dbo.vwLRSLastTransactionTrack.AssignedById,
                         dbo.vwContacts.ContactShortName AS AssignedBy, dbo.vwLRSLastTransactionTrack.ResponsibleId, vwContacts_1.ContactShortName AS Responsible, dbo.vwLRSLastTransactionTrack.NextContactId,
                         vwContacts_2.ContactShortName AS NextContact, dbo.vwLRSLastTransactionTrack.TrackId, dbo.vwLRSLastTransactionTrack.EventId, dbo.vwLRSLastTransactionTrack.Mode, dbo.vwLRSLastTransactionTrack.PreviousTrackId,
                         dbo.vwLRSLastTransactionTrack.NextTrackId, dbo.vwLRSLastTransactionTrack.TrackNotes, dbo.vwLRSLastTransactionTrack.TrackStatus, CASE WHEN PresentationTime = '2078-12-31' THEN 0 ELSE DATEDIFF(second,
                         PresentationTime, CASE WHEN [TrackStatus] = 'C' THEN ClosingTime ELSE GETDATE() END) END AS WorkingTime, CASE WHEN PresentationTime = '2078-12-31' THEN 0 ELSE DATEDIFF(second, PresentationTime,
                         CASE WHEN [TrackStatus] = 'C' THEN CheckOutTime ELSE GETDATE() END) END AS TotalTime, dbo.vwLRSTransactions.PaymentsTotal, dbo.vwLRSTransactions.ReceiptNo, dbo.vwLRSDocuments.ImagingControlID
FROM            dbo.vwContacts AS vwContacts_1 INNER JOIN
                         dbo.vwLRSLastTransactionTrack INNER JOIN
                         dbo.vwLRSTransactions ON dbo.vwLRSLastTransactionTrack.TransactionId = dbo.vwLRSTransactions.TransactionId INNER JOIN
                         dbo.tabEnumeration('ValueType.Enumeration.LRSTransactionStatus') AS tabEnumeration_1 ON dbo.vwLRSLastTransactionTrack.CurrentTransactionStatus = tabEnumeration_1.Value ON
                         vwContacts_1.ContactId = dbo.vwLRSLastTransactionTrack.ResponsibleId INNER JOIN
                         dbo.vwContacts ON dbo.vwLRSLastTransactionTrack.AssignedById = dbo.vwContacts.ContactId INNER JOIN
                         dbo.vwContacts AS vwContacts_2 ON dbo.vwLRSLastTransactionTrack.NextContactId = vwContacts_2.ContactId INNER JOIN
                         dbo.tabEnumeration('ValueType.Enumeration.LRSTransactionStatus') AS tabEnumeration_2 ON dbo.vwLRSLastTransactionTrack.NextTransactionStatus = tabEnumeration_2.Value INNER JOIN
                         dbo.vwLRSDocuments ON dbo.vwLRSTransactions.DocumentId = dbo.vwLRSDocuments.DocumentId

GO
/****** Object:  View [dbo].[vwLRSTransactionsToBeCleaned]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSTransactionsToBeCleaned]
AS
SELECT DISTINCT TOP (100) PERCENT dbo.LRSTransactions.*
FROM            dbo.vwLRSTransactionsAndCurrentTrack INNER JOIN
                         dbo.LRSTransactions ON dbo.vwLRSTransactionsAndCurrentTrack.TransactionId = dbo.LRSTransactions.TransactionId
WHERE        (dbo.vwLRSTransactionsAndCurrentTrack.PresentationTime < '2018-07-01') AND (dbo.vwLRSTransactionsAndCurrentTrack.TransactionStatus NOT IN ('X', 'Y', 'C', 'Q', 'H'))

GO
/****** Object:  View [dbo].[vwLRSDocumentSign]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLRSDocumentSign]
AS
SELECT dbo.EOPSignableDocuments.SignInputData, dbo.EOPSignRequests.SignStatus, dbo.EOPSignRequests.SignTime, dbo.EOPSignRequests.DigitalSign, dbo.EOPSignableDocuments.DocumentNo, dbo.EOPSignableDocuments.TransactionNo,
                  dbo.EOPSignRequests.RequestedToId
FROM     dbo.EOPSignableDocuments INNER JOIN
                  dbo.EOPSignRequests ON dbo.EOPSignableDocuments.SignableDocumentId = dbo.EOPSignRequests.SignableDocumentId
GO
/****** Object:  View [dbo].[vwLRSSignedTransactionsInOnSignStatus]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSSignedTransactionsInOnSignStatus]
AS
SELECT DISTINCT
                         dbo.LRSTransactions.TransactionId, dbo.LRSTransactions.TransactionTypeId, dbo.LRSTransactions.TransactionUID, dbo.LRSTransactions.DocumentTypeId, dbo.LRSTransactions.DocumentDescriptor,
                         dbo.LRSTransactions.DocumentId, dbo.LRSTransactions.BaseResourceId, dbo.LRSTransactions.RecorderOfficeId, dbo.LRSTransactions.RequestedBy, dbo.LRSTransactions.AgencyId,
                         dbo.LRSTransactions.ExternalTransactionNo, dbo.LRSTransactions.TransactionExtData, dbo.LRSTransactions.TransactionKeywords, dbo.LRSTransactions.PresentationTime, dbo.LRSTransactions.ExpectedDelivery,
                         dbo.LRSTransactions.LastReentryTime, dbo.LRSTransactions.ClosingTime, dbo.LRSTransactions.LastDeliveryTime, dbo.LRSTransactions.NonWorkingTime, dbo.LRSTransactions.ComplexityIndex,
                         dbo.LRSTransactions.IsArchived, dbo.LRSTransactions.TransactionStatus, dbo.LRSTransactions.TransactionDIF
FROM            dbo.vwLRSDocumentSign INNER JOIN
                         dbo.LRSTransactions ON dbo.vwLRSDocumentSign.TransactionNo = dbo.LRSTransactions.TransactionUID
WHERE        (dbo.vwLRSDocumentSign.SignStatus = 'S') AND (dbo.LRSTransactions.TransactionStatus = 'S' OR
                         dbo.LRSTransactions.TransactionStatus = 'A')

GO
/****** Object:  View [dbo].[vwLRSTransactionsToBeDelivered]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwLRSTransactionsToBeDelivered]
AS
SELECT DISTINCT TOP (100) PERCENT dbo.LRSTransactions.*
FROM            dbo.vwLRSTransactionsAndCurrentTrack INNER JOIN
                         dbo.LRSTransactions ON dbo.vwLRSTransactionsAndCurrentTrack.TransactionId = dbo.LRSTransactions.TransactionId
WHERE        (dbo.vwLRSTransactionsAndCurrentTrack.PresentationTime < '2018-07-29') AND (dbo.vwLRSTransactionsAndCurrentTrack.CurrentTransactionStatus IN ('D', 'L'))


GO
/****** Object:  View [dbo].[vwUIComponentItems]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwUIComponentItems]
AS
SELECT        TOP (100) PERCENT dbo.UIComponentItems.UIComponentItemId, dbo.UIComponentItems.UIComponentId, dbo.vwSimpleObjects.ObjectKey AS UIComponentNamedKey, dbo.UIComponentItems.UIComponentType,
                         dbo.UIComponentItems.UITemplate, dbo.UIComponentItems.ParentUIComponentId, dbo.UIComponentItems.RowIndex, dbo.UIComponentItems.ColumnIndex, dbo.UIComponentItems.RowSpan,
                         dbo.UIComponentItems.ColumnSpan, dbo.UIComponentItems.DisplayName, dbo.UIComponentItems.ToolTip, dbo.UIComponentItems.Disabled, dbo.UIComponentItems.DisplayViewId,
                         dbo.UIComponentItems.Style, dbo.UIComponentItems.AttributesString, dbo.UIComponentItems.ValuesString, dbo.UIComponentItems.DataBoundMode, dbo.UIComponentItems.DataMember,
                         dbo.UIComponentItems.DataItem, dbo.UIComponentItems.UIControlID
FROM            dbo.UIComponentItems INNER JOIN
                         dbo.vwSimpleObjects ON dbo.UIComponentItems.UIComponentId = dbo.vwSimpleObjects.ObjectId
ORDER BY dbo.UIComponentItems.UIComponentId, dbo.UIComponentItems.ParentUIComponentId, dbo.UIComponentItems.RowIndex, dbo.UIComponentItems.ColumnIndex
GO
/****** Object:  View [dbo].[vwLRSBookRecordingsCount]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLRSBookRecordingsCount]
AS
SELECT        dbo.LRSPhysicalBooks.PhysicalBookId, SUM(CASE WHEN RecordingStatus IS NULL OR
                         RecordingStatus = 'X' THEN 0 ELSE 1 END) AS CapturedRecordingsCount, MIN(dbo.LRSPhysicalBooks.EndRecordingIndex - dbo.LRSPhysicalBooks.StartRecordingIndex + 1)
                         - SUM(CASE WHEN RecordingStatus IS NULL OR
                         RecordingStatus = 'X' THEN 0 ELSE 1 END) AS LeftCapturedRecordingsCount, CASE MIN(dbo.LRSPhysicalBooks.EndRecordingIndex - dbo.LRSPhysicalBooks.StartRecordingIndex + 1)
                         WHEN 0 THEN 0 ELSE CAST(SUM(CASE RecordingStatus WHEN 'S' THEN 1.0 WHEN 'R' THEN 1.0 WHEN 'P' THEN 1.0 WHEN 'I' THEN 0.5 ELSE 0.0 END) AS float)
                         / MIN(dbo.LRSPhysicalBooks.EndRecordingIndex - dbo.LRSPhysicalBooks.StartRecordingIndex + 1) END AS CapturedRecordingsPercentage, SUM(CASE RecordingStatus WHEN 'S' THEN 1 ELSE 0 END)
                         AS ObsoleteRecordingsCount, SUM(CASE RecordingStatus WHEN 'L' THEN 1 ELSE 0 END) AS NoLegibleRecordingsCount, SUM(CASE RecordingStatus WHEN 'P' THEN 1 ELSE 0 END)
                         AS PendingRecordingsCount, SUM(CASE RecordingStatus WHEN 'I' THEN 1 ELSE 0 END) AS IncompleteRecordingsCount, SUM(CASE RecordingStatus WHEN 'R' THEN 1 ELSE 0 END)
                         AS RegisteredRecordingsCount, SUM(CASE RecordingStatus WHEN 'C' THEN 1 ELSE 0 END) AS ClosedRecordingsCount, SUM(CASE WHEN RecordingStatus IN ('I', 'R', 'C') THEN 1 ELSE 0 END)
                         AS ActiveRecordingsCount
FROM            dbo.LRSPhysicalRecordings RIGHT OUTER JOIN
                         dbo.LRSPhysicalBooks ON dbo.LRSPhysicalRecordings.PhysicalBookId = dbo.LRSPhysicalBooks.PhysicalBookId
WHERE        (dbo.LRSPhysicalRecordings.RecordingStatus IS NULL) OR
                         (dbo.LRSPhysicalRecordings.RecordingStatus <> 'X')
GROUP BY dbo.LRSPhysicalBooks.PhysicalBookId
GO
/****** Object:  View [dbo].[vwLRSVolumes]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLRSVolumes]
AS
SELECT        dbo.LRSPhysicalBooks.PhysicalBookId, dbo.LRSPhysicalBooks.RecorderOfficeId, dbo.LRSPhysicalBooks.RecordingSectionId, dbo.LRSPhysicalBooks.BookNo, dbo.LRSPhysicalBooks.BookAsText,
                         dbo.LRSPhysicalBooks.BookExtData, dbo.LRSPhysicalBooks.BookKeywords, dbo.LRSPhysicalBooks.StartRecordingIndex, dbo.LRSPhysicalBooks.EndRecordingIndex, dbo.LRSPhysicalBooks.BookStatus,
                         dbo.LRSPhysicalBooks.BookDIF, dbo.vwSimpleObjects.ObjectName AS RecordingsClassName, dbo.vwLRSBookRecordingsCount.CapturedRecordingsCount,
                         dbo.vwLRSBookRecordingsCount.LeftCapturedRecordingsCount, dbo.vwLRSBookRecordingsCount.CapturedRecordingsPercentage, dbo.vwLRSBookRecordingsCount.ObsoleteRecordingsCount,
                         dbo.vwLRSBookRecordingsCount.NoLegibleRecordingsCount, dbo.vwLRSBookRecordingsCount.PendingRecordingsCount, dbo.vwLRSBookRecordingsCount.IncompleteRecordingsCount,
                         dbo.vwLRSBookRecordingsCount.RegisteredRecordingsCount, dbo.vwLRSBookRecordingsCount.ClosedRecordingsCount, dbo.vwLRSBookRecordingsCount.ActiveRecordingsCount,
                         dbo.vwContacts.ContactShortName AS RecorderOffice, dbo.vwContacts.ContactFullName AS RecorderOfficeFullName, tabEnumeration_1.DisplayName AS RecordingBookStatusName
FROM            dbo.LRSPhysicalBooks INNER JOIN
                         dbo.vwContacts ON dbo.LRSPhysicalBooks.RecorderOfficeId = dbo.vwContacts.ContactId INNER JOIN
                         dbo.tabEnumeration('ValueType.Enumeration.RecordingBookStatus') AS tabEnumeration_1 ON dbo.LRSPhysicalBooks.BookStatus = tabEnumeration_1.Value INNER JOIN
                         dbo.vwLRSBookRecordingsCount ON dbo.LRSPhysicalBooks.PhysicalBookId = dbo.vwLRSBookRecordingsCount.PhysicalBookId INNER JOIN
                         dbo.vwSimpleObjects ON dbo.LRSPhysicalBooks.RecordingSectionId = dbo.vwSimpleObjects.ObjectId
GO
/****** Object:  View [dbo].[vwLRSWorkflowActiveTasksTotals]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSWorkflowActiveTasksTotals]
AS
SELECT        TOP (100) PERCENT dbo.vwLRSLastTransactionTrack.ResponsibleId, dbo.vwContacts.ContactShortName AS Responsible, COUNT(*) AS TransactionCount
FROM            dbo.vwContacts INNER JOIN
                         dbo.vwLRSLastTransactionTrack ON dbo.vwContacts.ContactId = dbo.vwLRSLastTransactionTrack.ResponsibleId INNER JOIN
                         dbo.LRSTransactions ON dbo.vwLRSLastTransactionTrack.TransactionId = dbo.LRSTransactions.TransactionId
WHERE        (dbo.vwLRSLastTransactionTrack.TrackStatus <> 'C') AND (NOT (dbo.LRSTransactions.TransactionStatus IN ('X', 'Y', 'L', 'D', 'H', 'C')))
GROUP BY dbo.vwLRSLastTransactionTrack.ResponsibleId, dbo.vwContacts.ContactShortName

GO
/****** Object:  View [dbo].[vwLRSTransactionForWS]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLRSTransactionForWS]
AS
SELECT        dbo.vwLRSTransactions.TransactionId, dbo.vwLRSTransactions.TransactionUID AS TransactionKey, dbo.vwLRSTransactions.TransactionType, dbo.vwLRSTransactions.DocumentDescriptor AS DocumentNumber,
                         dbo.vwLRSTransactions.DocumentType, dbo.vwLRSTransactions.RecorderOfficeId, dbo.vwLRSTransactions.RecorderOffice, dbo.vwLRSTransactions.RequestedBy,
                         dbo.vwLRSQualificationTrack.CheckInTime AS PostingTime, dbo.vwLRSQualificationTrack.Responsible AS PostedBy, '' AS OfficeNotes, dbo.vwLRSTransactions.TransactionStatus,
                         dbo.vwLRSTransactions.TransactionStatusName
FROM            dbo.vwLRSTransactions INNER JOIN
                         dbo.vwLRSQualificationTrack ON dbo.vwLRSTransactions.TransactionId = dbo.vwLRSQualificationTrack.TransactionId
GO
/****** Object:  View [dbo].[vwLRSTransactionItemsForWS]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLRSTransactionItemsForWS]
AS
SELECT     dbo.LRSTransactionItems.TransactionItemId AS ItemId, dbo.LRSTransactionItems.TransactionId, dbo.Types.DisplayName AS RecordingActType,
                      vwSimpleObjects_1.ObjectKey AS FinancialConcept, vwSimpleObjects_1.ObjectName AS LawArticle, '' AS Notes, dbo.LRSTransactionItems.Quantity,
                      dbo.vwSimpleObjects.ObjectName AS Unit, dbo.LRSTransactionItems.OperationValue, dbo.LRSTransactionItems.RecordingRightsFee,
                      dbo.LRSTransactionItems.SheetsRevisionFee, 0 AS AclarationFee, 0 AS UsufructFee, 0 AS ServidumbreFee, 0 AS SignCertificationFee,
                      dbo.LRSTransactionItems.ForeignRecordingFee AS ForeignRecordFee, 0 AS OthersFee, dbo.LRSTransactionItems.Discount,
                      dbo.LRSTransactionItems.RecordingRightsFee + dbo.LRSTransactionItems.SheetsRevisionFee + dbo.LRSTransactionItems.ForeignRecordingFee - dbo.LRSTransactionItems.Discount
                       AS ItemTotal
FROM         dbo.LRSTransactionItems INNER JOIN
                      dbo.vwSimpleObjects ON dbo.LRSTransactionItems.UnitId = dbo.vwSimpleObjects.ObjectId INNER JOIN
                      dbo.vwSimpleObjects AS vwSimpleObjects_1 ON dbo.LRSTransactionItems.TreasuryCodeId = vwSimpleObjects_1.ObjectId INNER JOIN
                      dbo.Types ON dbo.LRSTransactionItems.TransactionItemTypeId = dbo.Types.TypeId
WHERE     (dbo.LRSTransactionItems.TransactionItemStatus <> 'X')
GO
/****** Object:  View [dbo].[vwLRSRecordings]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLRSRecordings]
AS
SELECT        TOP (100) PERCENT dbo.LRSPhysicalRecordings.PhysicalRecordingId, dbo.LRSPhysicalRecordings.PhysicalBookId, dbo.vwLRSVolumes.RecorderOffice, dbo.vwLRSVolumes.RecorderOfficeFullName,
                         dbo.LRSPhysicalRecordings.RecordingNo, dbo.LRSPhysicalRecordings.RecordingNotes, dbo.LRSPhysicalRecordings.RecordingKeywords, dbo.LRSPhysicalRecordings.RecordingAuthorizationTime,
                         dbo.LRSPhysicalRecordings.RecordingStatus, tabEnumeration_1.DisplayName AS RecordingStatusName
FROM            dbo.LRSPhysicalRecordings INNER JOIN
                         dbo.tabEnumeration('ValueType.Enumeration.RecordingStatus') AS tabEnumeration_1 ON dbo.LRSPhysicalRecordings.RecordingStatus = tabEnumeration_1.Value INNER JOIN
                         dbo.vwLRSVolumes ON dbo.LRSPhysicalRecordings.PhysicalBookId = dbo.vwLRSVolumes.PhysicalBookId
WHERE        (dbo.LRSPhysicalRecordings.RecordingStatus <> 'X')
GO
/****** Object:  View [dbo].[vwLRSCadastralWS]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSCadastralWS]
AS
SELECT        dbo.LRSProperties.PropertyUID, dbo.LRSProperties.CadastralKey, dbo.LRSTransactions.PresentationTime, dbo.LRSTransactions.RequestedBy, dbo.LRSDocuments.DocumentUID,
                         REPLACE(REPLACE(dbo.LRSDocuments.DocumentOverview, CHAR(13), ' '), CHAR(10), ' ') AS DocumentOverview, dbo.Types.DisplayName AS RecordingAct
FROM            dbo.LRSProperties INNER JOIN
                         dbo.LRSRecordingActs ON dbo.LRSProperties.PropertyId = dbo.LRSRecordingActs.ResourceId INNER JOIN
                         dbo.LRSDocuments ON dbo.LRSRecordingActs.DocumentId = dbo.LRSDocuments.DocumentId INNER JOIN
                         dbo.LRSTransactions ON dbo.LRSDocuments.DocumentId = dbo.LRSTransactions.DocumentId INNER JOIN
                         dbo.Types ON dbo.LRSRecordingActs.RecordingActTypeId = dbo.Types.TypeId INNER JOIN
                         dbo.LRSPhysicalRecordings ON dbo.LRSRecordingActs.PhysicalRecordingId = dbo.LRSPhysicalRecordings.PhysicalRecordingId
WHERE        (dbo.Types.ClassName = 'Empiria.Land.Registration.DomainAct')
GROUP BY dbo.LRSProperties.PropertyUID, dbo.LRSProperties.CadastralKey, dbo.LRSDocuments.DocumentUID, REPLACE(REPLACE(dbo.LRSDocuments.DocumentOverview, CHAR(13), ' '), CHAR(10), ' '),
                         dbo.LRSTransactions.PresentationTime, dbo.LRSTransactions.RequestedBy, dbo.Types.ClassName, dbo.Types.DisplayName, dbo.LRSRecordingActs.RecordingActStatus
HAVING        (dbo.LRSProperties.CadastralKey <> '') AND (dbo.LRSRecordingActs.RecordingActStatus <> 'X')

GO
/****** Object:  View [dbo].[vwLRSDirectoriesStats]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLRSDirectoriesStats]
AS
SELECT        dbo.Contacts.ContactId AS RecorderOfficeId, ISNULL(AVG(dbo.LRSPhysicalBooks.EndRecordingIndex - dbo.LRSPhysicalBooks.EndRecordingIndex + 1), 134) AS DomainRecordingsAvg
FROM            dbo.LRSPhysicalBooks RIGHT OUTER JOIN
                         dbo.Contacts ON dbo.LRSPhysicalBooks.RecorderOfficeId = dbo.Contacts.ContactId
WHERE        (dbo.Contacts.ContactTypeId = 2000) AND (dbo.LRSPhysicalBooks.RecordingSectionId = 1051 OR
                         dbo.LRSPhysicalBooks.RecordingSectionId = 1057 OR
                         dbo.LRSPhysicalBooks.RecordingSectionId IS NULL) AND (dbo.LRSPhysicalBooks.BookStatus <> 'X' OR
                         dbo.LRSPhysicalBooks.BookStatus IS NULL)
GROUP BY dbo.Contacts.ContactId
GO
/****** Object:  View [dbo].[vwLRSRecordingActParties]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSRecordingActParties]
AS
SELECT        dbo.LRSRecordingActParties.RecordingActPartyId, dbo.LRSRecordingActParties.RecordingActId, dbo.LRSRecordingActParties.PartyId, dbo.LRSRecordingActParties.PartyRoleId, dbo.LRSRecordingActParties.PartyOfId,
                         dbo.LRSRecordingActParties.OwnershipPartAmount, dbo.LRSRecordingActParties.OwnershipPartUnitId, dbo.LRSRecordingActParties.IsOwnershipStillActive, dbo.LRSRecordingActParties.RecActPartyNotes,
                         dbo.LRSRecordingActParties.RecActPartyAsText, dbo.LRSRecordingActParties.RecActPartyExtData, dbo.LRSRecordingActParties.PostedById, dbo.LRSRecordingActParties.RecActPartyStatus,
                         dbo.LRSRecordingActParties.RecActPartyDIF, dbo.LRSParties.PartyFullName, dbo.LRSParties.PartyKeywords, LRSPartyOf.PartyFullName AS PartyOfFullName, LRSPartyOf.PartyKeywords AS PartyOfKeywords,
                         dbo.LRSParties.PartyKeywords + ' ' + LRSPartyOf.PartyKeywords + ' ' + dbo.LRSRecordingActs.RecordingActKeywords AS FullSearchKeywords, dbo.LRSRecordingActs.RecordingActStatus, dbo.LRSProperties.PropertyUID,
                         dbo.Types.TypeName AS RecordingActTypeName, dbo.Types.DisplayName AS RecordingActName, dbo.LRSProperties.CadastralKey, dbo.LRSDocuments.DocumentUID, dbo.LRSDocuments.PresentationTime,
                         dbo.LRSDocuments.AuthorizationTime
FROM            dbo.LRSProperties INNER JOIN
                         dbo.LRSRecordingActParties INNER JOIN
                         dbo.LRSParties ON dbo.LRSRecordingActParties.PartyId = dbo.LRSParties.PartyId INNER JOIN
                         dbo.LRSParties AS LRSPartyOf ON dbo.LRSRecordingActParties.PartyOfId = LRSPartyOf.PartyId INNER JOIN
                         dbo.LRSRecordingActs ON dbo.LRSRecordingActParties.RecordingActId = dbo.LRSRecordingActs.RecordingActId ON dbo.LRSProperties.PropertyId = dbo.LRSRecordingActs.ResourceId INNER JOIN
                         dbo.Types ON dbo.LRSRecordingActs.RecordingActTypeId = dbo.Types.TypeId INNER JOIN
                         dbo.LRSDocuments ON dbo.LRSRecordingActs.DocumentId = dbo.LRSDocuments.DocumentId
WHERE        (dbo.LRSRecordingActParties.RecActPartyStatus <> 'X') AND (dbo.LRSRecordingActs.RecordingActStatus <> 'X')

GO
/****** Object:  View [dbo].[vwLRSResourcesFirstRecordingAct]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSResourcesFirstRecordingAct]
AS
SELECT        RecordingActId, RecordingActTypeId, DocumentId, RecordingActIndex, ResourceId, ResourceRole, RelatedResourceId, RecordingActPercentage, RecordingActNotes, RecordingActExtData,
                         RecordingActResourceExtData, RecordingActKeywords, AmendmentOfId, AmendedById, PhysicalRecordingId, RegisteredById, RegistrationTime, RecordingActStatus, RecordingActDIF
FROM            dbo.LRSRecordingActs AS RA
WHERE        (RecordingActId =
                             (SELECT        TOP (1) RA3.RecordingActId
                               FROM            dbo.LRSRecordingActs AS RA3 INNER JOIN
                                                         dbo.LRSDocuments ON RA3.DocumentId = dbo.LRSDocuments.DocumentId
                               WHERE        (RA3.ResourceId = RA.ResourceId) AND (RA3.RecordingActStatus <> 'X')
                               ORDER BY dbo.LRSDocuments.PresentationTime, RA3.RecordingActIndex, RA3.RecordingActId))

GO
/****** Object:  View [dbo].[vwLRSSearchMaster]    Script Date: 20/May/2020 5:00:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLRSSearchMaster]
AS
SELECT        dbo.LRSTransactions.TransactionId, dbo.LRSTransactions.TransactionUID, dbo.LRSTransactions.RequestedBy, dbo.LRSDocuments.DocumentUID, dbo.LRSDocuments.ImagingControlID,
                         dbo.LRSDocuments.DocumentAsText, dbo.LRSDocuments.DocumentOverview, dbo.LRSDocuments.DocumentKeywords, dbo.LRSDocuments.PresentationTime, dbo.LRSDocuments.AuthorizationTime,
                         dbo.LRSRecordingActs.RecordingActId, dbo.LRSRecordingActs.RecordingActNotes, dbo.LRSRecordingActs.RecordingActTypeId, dbo.Types.DisplayName AS RecordingActType,
                         dbo.LRSRecordingActs.RecordingActIndex, dbo.LRSRecordingActs.AmendmentOfId, dbo.LRSRecordingActs.AmendedById, dbo.LRSPhysicalRecordings.PhysicalRecordingId,
                         dbo.LRSPhysicalRecordings.RecordingAsText, dbo.LRSPhysicalRecordings.PhysicalBookId, dbo.LRSPhysicalRecordings.RecordingNo, dbo.LRSProperties.PropertyId, dbo.LRSProperties.PropertyUID,
                         dbo.LRSProperties.CadastralKey, dbo.LRSProperties.PartitionOfId, dbo.LRSProperties.PartitionNo, dbo.LRSProperties.MergedIntoId
FROM            dbo.Types RIGHT OUTER JOIN
                         dbo.LRSProperties INNER JOIN
                         dbo.LRSRecordingActs ON dbo.LRSProperties.PropertyId = dbo.LRSRecordingActs.ResourceId INNER JOIN
                         dbo.LRSPhysicalRecordings ON dbo.LRSRecordingActs.PhysicalRecordingId = dbo.LRSPhysicalRecordings.PhysicalRecordingId ON
                         dbo.Types.TypeId = dbo.LRSRecordingActs.RecordingActTypeId RIGHT OUTER JOIN
                         dbo.LRSTransactions INNER JOIN
                         dbo.LRSDocuments ON dbo.LRSTransactions.DocumentId = dbo.LRSDocuments.DocumentId ON dbo.LRSRecordingActs.DocumentId = dbo.LRSDocuments.DocumentId

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[32] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[41] 4[30] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "LRSPhysicalBooks"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSPhysicalRecordings"
            Begin Extent =
               Top = 12
               Left = 411
               Bottom = 207
               Right = 669
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 2175
         Width = 2385
         Width = 3510
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 12
         Column = 16860
         Alias = 3900
         Table = 1875
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 3150
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSBookRecordingsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSBookRecordingsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[44] 4[25] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "LRSProperties"
            Begin Extent =
               Top = 6
               Left = 21
               Bottom = 319
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSRecordingActs"
            Begin Extent =
               Top = 7
               Left = 483
               Bottom = 379
               Right = 695
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSDocuments"
            Begin Extent =
               Top = 79
               Left = 725
               Bottom = 401
               Right = 923
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "LRSTransactions"
            Begin Extent =
               Top = 75
               Left = 954
               Bottom = 370
               Right = 1156
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Types"
            Begin Extent =
               Top = 31
               Left = 1154
               Bottom = 346
               Right = 1349
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSPhysicalRecordings"
            Begin Extent =
               Top = 253
               Left = 214
               Bottom = 450
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "LRSTractIndex"
            Begin Extent =
               Top = 6
               Left = 244
               Bottom = 168
               Right = 447
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSCadastralWS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'          End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2340
         Width = 2010
         Width = 3510
         Width = 3660
         Width = 2745
         Width = 2880
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 12
         Column = 2730
         Alias = 3135
         Table = 3360
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSCadastralWS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSCadastralWS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "Contacts"
            Begin Extent =
               Top = 16
               Left = 520
               Bottom = 279
               Right = 817
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSPhysicalBooks"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 12
         Column = 3000
         Alias = 3075
         Table = 3315
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 3945
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSDirectoriesStats'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSDirectoriesStats'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[31] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "LRSDocuments"
            Begin Extent =
               Top = 28
               Left = 92
               Bottom = 323
               Right = 303
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwSimpleObjects"
            Begin Extent =
               Top = 61
               Left = 660
               Bottom = 310
               Right = 975
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Types"
            Begin Extent =
               Top = 3
               Left = 334
               Bottom = 221
               Right = 529
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1755
         Width = 1500
         Width = 1500
         Width = 3180
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 5145
         Alias = 2295
         Table = 3825
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSDocuments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSDocuments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "EOPSignableDocuments"
            Begin Extent =
               Top = 23
               Left = 48
               Bottom = 428
               Right = 292
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EOPSignRequests"
            Begin Extent =
               Top = 65
               Left = 322
               Bottom = 446
               Right = 636
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSDocumentSign'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSDocumentSign'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[15] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "vwLRSPaymentsByItem"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 246
               Right = 390
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3645
         Width = 2805
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2790
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 12
         Column = 5520
         Alias = 1860
         Table = 3690
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSPaymentsAnalysis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSPaymentsAnalysis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[14] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "LRSTransactions"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 152
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 14
         End
         Begin Table = "LRSTransactionItems"
            Begin Extent =
               Top = 13
               Left = 439
               Bottom = 159
               Right = 647
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "Types"
            Begin Extent =
               Top = 200
               Left = 17
               Bottom = 308
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SimpleObjects"
            Begin Extent =
               Top = 109
               Left = 723
               Bottom = 217
               Right = 882
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSPayments"
            Begin Extent =
               Top = 192
               Left = 370
               Bottom = 300
               Right = 546
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1755
         Width = 1500
         Width = 3420
         Width = 1500
         Width = 1500
         Width = 2070
         Width = 1650
         Width = 1800
         Width = 1500
         Width = 1500
         Width = 1500
      E' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSPaymentsByItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'nd
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 2370
         Alias = 2790
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2460
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSPaymentsByItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSPaymentsByItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[28] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "LRSTransactionTrack"
            Begin Extent =
               Top = 38
               Left = 23
               Bottom = 398
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwContacts"
            Begin Extent =
               Top = 116
               Left = 622
               Bottom = 336
               Right = 813
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 3120
         Alias = 2145
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSQualificationTrack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSQualificationTrack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[52] 4[8] 2[26] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = -10
      End
      Begin Tables =
         Begin Table = "LRSDocuments"
            Begin Extent =
               Top = 250
               Left = 794
               Bottom = 585
               Right = 998
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwContacts"
            Begin Extent =
               Top = 360
               Left = 1008
               Bottom = 598
               Right = 1188
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSRecordingActs"
            Begin Extent =
               Top = 13
               Left = 418
               Bottom = 363
               Right = 622
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwContacts_1"
            Begin Extent =
               Top = 316
               Left = 89
               Bottom = 544
               Right = 269
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Types"
            Begin Extent =
               Top = 21
               Left = 20
               Bottom = 288
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSPhysicalRecordings"
            Begin Extent =
               Top = 10
               Left = 770
               Bottom = 224
               Right = 1012
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSPhysicalBooks"
            Begin Extent =
               Top = 8
               Left = 1217
               Bottom = 275
               Right = 1412
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSRecordingActs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 26
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 5415
         Alias = 4065
         Table = 4050
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 4950
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSRecordingActs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSRecordingActs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[44] 4[20] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "tabEnumeration_1"
            Begin Extent =
               Top = 102
               Left = 338
               Bottom = 331
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSPhysicalRecordings"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 274
               Right = 280
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwLRSVolumes"
            Begin Extent =
               Top = 49
               Left = 710
               Bottom = 328
               Right = 966
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 25
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 5475
         Alias = 2475
         Table = 2835
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         Sor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSRecordings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'tOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSRecordings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSRecordings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[53] 4[21] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "Types"
            Begin Extent =
               Top = 340
               Left = 282
               Bottom = 502
               Right = 477
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "LRSProperties"
            Begin Extent =
               Top = 0
               Left = 58
               Bottom = 375
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSRecordingActs"
            Begin Extent =
               Top = 147
               Left = 506
               Bottom = 500
               Right = 711
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSPhysicalRecordings"
            Begin Extent =
               Top = 351
               Left = 741
               Bottom = 517
               Right = 939
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSTransactions"
            Begin Extent =
               Top = 10
               Left = 968
               Bottom = 482
               Right = 1170
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSDocuments"
            Begin Extent =
               Top = 4
               Left = 741
               Bottom = 344
               Right = 939
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSTractIndex"
            Begin Extent =
               Top = 8
               Left = 267
               Bottom = 277
               Right = 477
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSSearchMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'          End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 98
         Width = 284
         Width = 1500
         Width = 2445
         Width = 3090
         Width = 1500
         Width = 2640
         Width = 1500
         Width = 5475
         Width = 1500
         Width = 3120
         Width = 1500
         Width = 2415
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 3255
         Alias = 5460
         Table = 3975
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSSearchMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSSearchMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[26] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "vwLRSQualificationTrack"
            Begin Extent =
               Top = 29
               Left = 480
               Bottom = 295
               Right = 793
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwLRSTransactions"
            Begin Extent =
               Top = 27
               Left = 51
               Bottom = 272
               Right = 419
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1800
         Width = 1500
         Width = 2475
         Width = 2580
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 4500
         Alias = 2280
         Table = 3000
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSTransactionForWS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSTransactionForWS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[42] 2[2] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "LRSTransactionItems"
            Begin Extent =
               Top = 74
               Left = 265
               Bottom = 402
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwSimpleObjects"
            Begin Extent =
               Top = 243
               Left = 524
               Bottom = 421
               Right = 805
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwSimpleObjects_1"
            Begin Extent =
               Top = 14
               Left = 525
               Bottom = 187
               Right = 762
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Types"
            Begin Extent =
               Top = 19
               Left = 41
               Bottom = 366
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 21
         Width = 284
         Width = 1500
         Width = 1500
         Width = 2235
         Width = 1875
         Width = 2100
         Width = 1500
         Width = 1500
         Width = 2250
         Width = 1500
         Width = 1665
         Width = 1830
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Co' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSTransactionItemsForWS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'lumn = 14970
         Alias = 2610
         Table = 3600
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSTransactionItemsForWS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSTransactionItemsForWS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "LRSTransactions"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 254
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "vwContacts"
            Begin Extent =
               Top = 138
               Left = 38
               Bottom = 268
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tabEnumeration_1"
            Begin Extent =
               Top = 6
               Left = 292
               Bottom = 102
               Right = 462
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwContacts_1"
            Begin Extent =
               Top = 138
               Left = 267
               Bottom = 268
               Right = 458
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwSimpleObjects"
            Begin Extent =
               Top = 270
               Left = 38
               Bottom = 400
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwSimpleObjects_1"
            Begin Extent =
               Top = 270
               Left = 246
               Bottom = 400
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwLRSPaymentsTotals"
            Begin Extent =
               Top = 402
               Left = 38
               Bottom = 532
               Right ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSTransactions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSTransactions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSTransactions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[37] 4[23] 2[24] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "vwContacts"
            Begin Extent =
               Top = 134
               Left = 794
               Bottom = 392
               Right = 1029
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tabEnumeration_1"
            Begin Extent =
               Top = 8
               Left = 131
               Bottom = 114
               Right = 301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwLRSBookRecordingsCount"
            Begin Extent =
               Top = 135
               Left = 98
               Bottom = 344
               Right = 347
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwSimpleObjects"
            Begin Extent =
               Top = 40
               Left = 1068
               Bottom = 248
               Right = 1277
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRSPhysicalBooks"
            Begin Extent =
               Top = 6
               Left = 517
               Bottom = 246
               Right = 717
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 38
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3120
         Width = 3690
         Width = 1500
         Width = 1500
         Width = 1950
         Width = 1500
         Width = 1500
         Wi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSVolumes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'dth = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2205
         Width = 2490
         Width = 2595
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3465
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2145
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 3570
         Alias = 2880
         Table = 2670
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSVolumes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLRSVolumes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[33] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "vwSimpleObjects"
            Begin Extent =
               Top = 24
               Left = 373
               Bottom = 301
               Right = 682
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UIComponentItems"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 206
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 3585
         Alias = 3735
         Table = 3795
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwUIComponentItems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwUIComponentItems'
GO
