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

      var partition = new PropertyPartition(command.GetParameter<String>("cadastralKey", String.Empty),
          partitionType: (PropertyPartitionType) Enum.Parse(typeof(PropertyPartitionType),
                                                            command.GetParameter<string>("partitionType", "None")),
          partitionSubtype: (PropertyPartitionSubtype) Enum.Parse(typeof(PropertyPartitionSubtype),
                                                            command.GetParameter<string>("partitionSubtype", "None")),
          partitionNo: command.GetParameter<int>("partitionNo", 0),
          totalPartitions: command.GetParameter<int>("totalPartitions", 0),
          partitionSize: command.GetParameter<Decimal>("partitionSize", 0m),
          partitionSizeUnitId: command.GetParameter<int>("partitionSizeUnitId", -1),
          availableSize: command.GetParameter<Decimal>("partitionAvailableSize", 0m),
          availableSizeUnitId: command.GetParameter<int>("partitionAvailableSizeUnitId", -1)
      );

      RecordingActInfo targetActInfo;

      if (command.GetParameter<int>("targetRecordingActId", -1) != -1) {
        targetActInfo = new RecordingActInfo(command.GetParameter<int>("targetRecordingActId"));
      } else {
        targetActInfo = new RecordingActInfo(
          recordingActTypeId: command.GetParameter<int>("targetActTypeId", -1),
          physicalBookId: command.GetParameter<int>("targetActPhysicalBookId", -1),
          recordingId: command.GetParameter<int>("targetActRecordingId", -1),
          recordingNo: command.GetParameter<int>("targetRecordingNumber", -1),
          recordingSubNo: command.GetParameter<string>("targetRecordingSubNumber", String.Empty),
          recordingSuffixTag: command.GetParameter<string>("targetRecordingSuffixTag", String.Empty)
        );
      }

      return new RecordingTask(
         transactionId: command.GetParameter<int>("transactionId", -1),
         documentId: command.GetParameter<int>("documentId", -1),
         recordingActTypeCategoryId: command.GetParameter<int>("recordingActTypeCategoryId", -1),
         recordingActTypeId: command.GetParameter<int>("recordingActTypeId"),
         propertyType: (PropertyRecordingType) Enum.Parse(typeof(PropertyRecordingType),
                                                          command.GetParameter<string>("propertyType")),
         cadastralKey: command.GetParameter<string>("cadastralKey", String.Empty),
         resourceName: command.GetParameter<string>("resourceName", String.Empty),
         precedentRecordingBookId: command.GetParameter<int>("precedentRecordingBookId", -1),
         precedentRecordingId: command.GetParameter<int>("precedentRecordingId", -1),
         precedentResourceId: command.GetParameter<int>("precedentPropertyId", -1),
         quickAddRecordingNumber: command.GetParameter<int>("quickAddRecordingNumber", -1),
         quickAddRecordingSubnumber: command.GetParameter<string>("quickAddRecordingSubNumber", String.Empty),
         quickAddRecordingSuffixTag: command.GetParameter<string>("quickAddRecordingSuffixTag", String.Empty),
         partition: partition,
         targetActInfo: targetActInfo
      );
    }

  } // class RecordingActEditorControl

} // namespace Empiria.Web.UI.LRS
