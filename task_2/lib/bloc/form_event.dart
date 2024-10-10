class FormEvent {}

class TimeChanged extends FormEvent {
  final DateTime time;
  TimeChanged(this.time);
}

class QuantityChanged extends FormEvent {
  final int quantity;
  QuantityChanged(this.quantity);
}

class PumpChanged extends FormEvent {
  final String pump;
  PumpChanged(this.pump);
}

class RevenueChanged extends FormEvent {
  final double revenue;
  RevenueChanged(this.revenue);
}

class PriceChanged extends FormEvent {
  final double price;
  PriceChanged(this.price);
}
