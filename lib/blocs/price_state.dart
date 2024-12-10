abstract class PriceState {}

class PriceInitial extends PriceState {}

class PriceListUpdated extends PriceState {
  final List<Map<String, dynamic>> paymentRecords;
  final int? selectedIndex;

  PriceListUpdated(this.paymentRecords, this.selectedIndex);
}

class PriceDelete extends PriceState {
  final int deletedUserId;
  final List<Map<String, dynamic>> updatedPaymentRecords; 
  
  PriceDelete(this.deletedUserId, this.updatedPaymentRecords);
}