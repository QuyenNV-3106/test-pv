import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'file_event.dart';
import 'file_state.dart';
import 'package:intl/intl.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  List<List<String>> fileData = [];

  FileBloc() : super(FileInitial()) {
    on<FileUploadEvent>((event, emit) async {
      emit(FileLoading());
      try {
        fileData = [];

        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['xlsx'],
        );

        if (result != null) {
          File file = File(result.files.single.path!);

          await _processFile(file).then(
            (value) => fileData = value,
          );

          emit(FileLoaded(fileData));
        } else {
          emit(FileError('No file selected'));
        }
      } catch (e) {
        emit(FileError(e.toString()));
      }
    });

    on<CalculateTotalInTimeRangeEvent>((event, emit) async {
      emit(FileLoading());

      double totalSum = 0.0;

      final DateFormat timeFormat = DateFormat('HH:mm:ss');
      for (var row in fileData.skip(8)) {
        try {
          DateTime? rowTime = DateTime.parse(
              '2024-03-21 ${row[2].split('(')[1].split(',')[0]}');
          double value =
              double.tryParse(row[8].split('(')[1].split(',')[0]) ?? 0.0;

          if (event.startTime.isAfter(event.endTime)) {
            emit(FileError('Invalid value'));
            return;
          } else if (rowTime != null &&
              rowTime.isAfter(event.startTime) &&
              rowTime.isBefore(event.endTime)) {
            totalSum += value;
          }
        } catch (e) {
          print("err");
        }
      }

      emit(FileTotalCalculated(totalSum));
    });
  }

  Future<List<List<String>>> _processFile(File file) async {
    var bytes = await file.readAsBytes();
    var excel = Excel.decodeBytes(bytes);

    List<List<String>> fileData = [];

    for (var row in excel.tables[excel.tables.keys.first]!.rows) {
      fileData.add(row.map((cell) => cell?.toString() ?? '').toList());
    }

    return fileData;
  }
}
