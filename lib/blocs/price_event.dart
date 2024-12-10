abstract class PriceEvent {}
class SelectPriceEvent extends PriceEvent {
  final String userId;
  final String userName;
  final int selectedPrice;
  final int index;

  SelectPriceEvent(this.userId, this.userName, this.selectedPrice, this.index);
}

class DeletePriceEvent extends PriceEvent {
  final int userId;

  DeletePriceEvent({required this.userId});
}

