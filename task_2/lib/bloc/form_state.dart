class FormState {
  final DateTime? selectedTime;
  final int? quantity;
  final String? pump;
  final double? revenue;
  final double? price;

  FormState({
    this.selectedTime,
    this.quantity,
    this.pump,
    this.revenue,
    this.price,
  });

  FormState copyWith({
    DateTime? selectedTime,
    int? quantity,
    String? pump,
    double? revenue,
    double? price,
  }) {
    return FormState(
      selectedTime: selectedTime ?? this.selectedTime,
      quantity: quantity ?? this.quantity,
      pump: pump ?? this.pump,
      revenue: revenue ?? this.revenue,
      price: price ?? this.price,
    );
  }
}
