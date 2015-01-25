using System;
using System.Web.UI;
using System.Web.UI.WebControls;

using Empiria.Land.Registration;
using Empiria.Land.Registration.Transactions;
using Empiria.Land.UI;
using Empiria.Presentation;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.LRS {

  public partial class RecordingActEditorControl : RecordingActEditorControlBase {

    public override RecordingAct CreateRecordingAct() {
      Assertion.Assert(base.Transaction != null && !base.Transaction.IsEmptyInstance,
                       "Transaction cannot be null or an empty instance.");
      Assertion.Assert(base.Transaction.Document != null && !base.Transaction.Document.IsEmptyInstance,
                       "Document cannot be an empty instance.");

      RecordingTask task = this.ParseRecordingTask();

      return RecorderExpert.Execute(task);
    }

    private RecordingTask ParseRecordingTask() {
      Command command = base.GetCurrentCommand();

      return new RecordingTask(
         transactionId: command.GetParameter<int>("transactionId", -1),
         documentId: command.GetParameter<int>("documentId", -1),
         recordingActTypeCategoryId: command.GetParameter<int>("recordingActTypeCategoryId", -1),
         recordingActTypeId: command.GetParameter<int>("recordingActTypeId"),
         propertyType: (PropertyRecordingType) Enum.Parse(typeof(PropertyRecordingType),
                                                          command.GetParameter<string>("propertyType")),
         recorderOfficeId: command.GetParameter<int>("recorderOfficeId", -1),
         precedentRecordingBookId: command.GetParameter<int>("precedentRecordingBookId", -1),
         precedentRecordingId: command.GetParameter<int>("precedentRecordingId", -1),
         targetResourceId: command.GetParameter<int>("precedentPropertyId", -1),
         targetRecordingActId: command.GetParameter<int>("targetRecordingActId", -1),
         quickAddRecordingNumber: command.GetParameter<int>("quickAddRecordingNumber", -1),
         quickAddRecordingSubnumber: command.GetParameter<string>("quickAddRecordingSubNumber", String.Empty),
         quickAddRecordingSuffixTag: command.GetParameter<string>("quickAddRecordingSuffixTag", String.Empty),
         lotSubdivisionType: (LotSubdivisionType) Enum.Parse(typeof(LotSubdivisionType),
                                                             command.GetParameter<string>("lotSubdivisionType", "None")),
         lotNumber: command.GetParameter<int>("lotNumber", 0),
         totalLots: command.GetParameter<int>("totalLots", 0)
      );
    }

  } // class RecordingActEditorControl

} // namespace Empiria.Web.UI.LRS
