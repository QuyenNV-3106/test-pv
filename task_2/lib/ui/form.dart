import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizing/sizing.dart';
import 'package:task_2/bloc/form_bloc.dart';
import 'package:task_2/bloc/form_state.dart' as fState;

class TransactionForm extends StatelessWidget {
  final List<DropdownMenuItem<String>> pumpDropList = const [
    DropdownMenuItem(value: 'Pump 1', child: Text('Pump 1')),
    DropdownMenuItem(value: 'Pump 2', child: Text('Pump 2')),
    DropdownMenuItem(value: 'Pump 3', child: Text('Pump 3')),
  ];

  const TransactionForm({super.key});

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thành công'),
          content: const Text('Dữ liệu đã được gửi thành công!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                overlayColor: WidgetStatePropertyAll(Colors.white),
                padding: WidgetStatePropertyAll(EdgeInsets.only(right: 10)),
                shape: WidgetStatePropertyAll(LinearBorder.none),
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                elevation: WidgetStatePropertyAll(0),
              ),
              onPressed: () {},
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 18,
                    color: Colors.black,
                  ),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    "Đóng",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.002.sh,
            ),
            const Text(
              "Nhập giao dịch",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(Colors.blue),
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                onPressed: () {
                  if (formKey.currentState?.saveAndValidate() ?? false) {
                    _showSuccessDialog(context);
                  }
                },
                child: const Text(
                  'Cập nhật',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 16))
            ],
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => FormBloc(),
        child: BlocBuilder<FormBloc, fState.FormState>(
          builder: (context, state) {
            final formBloc = context.read<FormBloc>();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  children: [
                    FormBuilderDateTimePicker(
                      name: 'Thời gian',
                      initialValue: state.selectedTime,
                      inputType: InputType.both,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month_outlined),
                        labelText: 'Thời gian',
                      ),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Vui lòng chọn thời gian'),
                      ]),
                      onChanged: (value) {
                        if (value != null) {
                          formBloc.updateSelectedTime(value);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      name: 'quantity',
                      initialValue: state.quantity?.toString(),
                      decoration: const InputDecoration(labelText: 'Số lượng'),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Vui lòng nhập số lượng'),
                        FormBuilderValidators.numeric(
                            errorText: 'Vui lòng nhập đúng định dạng là số'),
                        FormBuilderValidators.min(0,
                            errorText: 'Số lượng không được bé hơn 0')
                      ]),
                      onChanged: (value) {
                        if (value != null) {
                          formBloc.updateQuantity(int.parse(value));
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    FormBuilderDropdown<String>(
                      name: 'pump',
                      decoration: const InputDecoration(labelText: 'Trụ'),
                      initialValue: state.pump,
                      items: pumpDropList,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Vui lòng chọn trụ bơm'),
                      ]),
                      onChanged: (value) {
                        if (value != null) {
                          formBloc.updatePump(value);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      name: 'revenue',
                      initialValue: state.revenue?.toString(),
                      decoration: const InputDecoration(labelText: 'Doanh thu'),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Vui lòng nhập doanh thu'),
                        FormBuilderValidators.numeric(
                            errorText: 'Vui lòng nhập đúng định dạng là số'),
                        FormBuilderValidators.min(0,
                            errorText: 'Doanh thu không được bé hơn 0')
                      ]),
                      onChanged: (value) {
                        if (value != null) {
                          formBloc.updateRevenue(double.parse(value));
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      name: 'price',
                      initialValue: state.price?.toString(),
                      decoration: const InputDecoration(labelText: 'Đơn giá'),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Vui lòng nhập đơn giá'),
                        FormBuilderValidators.numeric(
                            errorText: 'Vui lòng nhập đúng định dạng là số'),
                        FormBuilderValidators.min(0,
                            errorText: 'Đơn giá không được bé hơn 0')
                      ]),
                      onChanged: (value) {
                        if (value != null) {
                          formBloc.updatePrice(double.parse(value));
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
