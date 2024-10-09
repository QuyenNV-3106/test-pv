abstract class FileState {}

class FileInitial extends FileState {}

class FileLoading extends FileState {}

class FileLoaded extends FileState {
  final List<List<String>> data;

  FileLoaded(this.data);
}

class FileTotalCalculated extends FileState {
  final double totalSum;

  FileTotalCalculated(this.totalSum);
}

class FileError extends FileState {
  final String message;

  FileError(this.message);
}
