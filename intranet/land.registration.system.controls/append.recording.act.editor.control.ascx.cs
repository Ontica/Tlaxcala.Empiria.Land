using System;

using Empiria.Land.Registration;
using Empiria.Land.UI;
using Empiria.Presentation.Web;

namespace Empiria.Land.WebApp {

  public partial class AppendRecordingActEditorControl : AppendRecordingActEditorControlBase {

    public override RecordingAct[] CreateRecordingActs() {
      RecordingTask task = this.ParseRecordingTask();

      return RecorderExpert.Execute(task);
    }

    private RecordingTask ParseRecordingTask() {
      Command command = base.GetCurrentCommand();

      RecordingActInfoDTO targetActInfo = null;


      RecordingTaskType taskType =
                (RecordingTaskType) Enum.Parse(typeof(RecordingTaskType),
                                               command.GetParameter<string>("recordingTaskType"));

      if (command.GetParameter<int>("targetRecordingActId", -1) != -1) {
        targetActInfo = new RecordingActInfoDTO(command.GetParameter<int>("targetRecordingActId"));
      } else {
        targetActInfo = new RecordingActInfoDTO(
          recordingActTypeId: command.GetParameter<int>("targetActTypeId", -1),
          physicalBookId: command.GetParameter<int>("targetActPhysicalBookId", -1),
          physicalRecordingId: command.GetParameter<int>("targetActRecordingId", -1),
          recordingNumber: command.GetParameter<string>("targetRecordingNumber", String.Empty)
        );
      }

      RealEstatePartitionDTO partitionInfo = null;
      if (taskType == RecordingTaskType.createPartition) {
        partitionInfo =
              new RealEstatePartitionDTO(command.GetParameter<string>("partitionType"),
                                      command.GetParameter<string>("partitionNo"),
                                      command.GetParameter<string>("partitionRepeatUntilNo", String.Empty));
      }

      return new RecordingTask(
         documentId: command.GetParameter<int>("documentId", -1),
         recordingActTypeId: command.GetParameter<int>("recordingActTypeId"),
         recordingTaskType: (RecordingTaskType) Enum.Parse(typeof(RecordingTaskType),
                                                      command.GetParameter<string>("recordingTaskType")),
         cadastralKey: command.GetParameter<string>("cadastralKey", String.Empty),
         resourceName: command.GetParameter<string>("resourceName", String.Empty),
         precedentRecordingBookId: command.GetParameter<int>("precedentRecordingBookId", -1),
         precedentRecordingId: command.GetParameter<int>("precedentRecordingId", -1),
         precedentResourceId: command.GetParameter<int>("precedentPropertyId", -1),
         quickAddRecordingNumber: command.GetParameter<string>("quickAddRecordingNumber", String.Empty),
         targetActInfo: targetActInfo,
         partition: partitionInfo
      );
    }

  } // class AppendRecordingActEditorControl

} // namespace Empiria.Land.WebApp
