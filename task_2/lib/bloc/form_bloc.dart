import 'package:bloc/bloc.dart';
import 'form_state.dart';

class FormBloc extends Cubit<FormState> {
  FormBloc() : super(FormState());

  void updateSelectedTime(DateTime time) {
    emit(state.copyWith(selectedTime: time));
  }

  void updateQuantity(int quantity) {
    emit(state.copyWith(quantity: quantity));
  }

  void updatePump(String pump) {
    emit(state.copyWith(pump: pump));
  }

  void updateRevenue(double revenue) {
    emit(state.copyWith(revenue: revenue));
  }

  void updatePrice(double price) {
    emit(state.copyWith(price: price));
  }
}
