abstract class FileEvent {}

class FileUploadEvent extends FileEvent {}

class CalculateTotalInTimeRangeEvent extends FileEvent {
  final DateTime startTime;
  final DateTime endTime;

  CalculateTotalInTimeRangeEvent(this.startTime, this.endTime);
}
