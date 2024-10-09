import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_1/bloc/file_bloc.dart';
import 'package:task_1/bloc/file_event.dart';
import 'package:task_1/bloc/file_state.dart';

class FileScreen extends StatelessWidget {
  const FileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload XLSX File'),
      ),
      body: BlocProvider(
        create: (_) => FileBloc(),
        child: const FileBody(),
      ),
    );
  }
}

class FileBody extends StatefulWidget {
  const FileBody({super.key});

  @override
  _FileBodyState createState() => _FileBodyState();
}

class _FileBodyState extends State<FileBody> {
  DateTime? _startTime;
  DateTime? _endTime;

  final DateFormat _timeFormat = DateFormat('HH:mm:ss');

  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _startTime = DateTime(
          2024,
          03,
          21,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _endTime = DateTime(
          2024,
          03,
          21,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<FileBloc>(context).add(FileUploadEvent());
            },
            child: const Text('Upload and Read XLSX'),
          ),
          BlocBuilder<FileBloc, FileState>(
            builder: (context, state) {
              if (state is FileInitial) {
                return const Text('No file selected');
              } else if (state is FileLoaded) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectStartTime(context),
                      child: Text(_startTime == null
                          ? 'Select Start Time'
                          : 'Start Time: ${_timeFormat.format(_startTime!)}'),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectEndTime(context),
                      child: Text(_endTime == null
                          ? 'Select End Time'
                          : 'End Time: ${_timeFormat.format(_endTime!)}'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_startTime != null && _endTime != null) {
                          BlocProvider.of<FileBloc>(context).add(
                            CalculateTotalInTimeRangeEvent(
                                _startTime!, _endTime!),
                          );
                        }
                      },
                      child: const Text('Calculate Total in Time Range'),
                    ),
                  ],
                );
              } else if (state is FileTotalCalculated) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child:
                        Text('Total: ${currencyFormat.format(state.totalSum)}'),
                  ),
                );
              } else if (state is FileError) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text('Error: ${state.message}'),
                );
              } else if (state is FileLoading) {
                return const CircularProgressIndicator();
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
