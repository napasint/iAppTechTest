import 'package:flutter_bloc/flutter_bloc.dart';
import 'price_event.dart';
import 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  final Map<String, Map<String, dynamic>> _paymentMap = {};
  int? _selectedIndex;

  PriceBloc() : super(PriceInitial()) {
    on<SelectPriceEvent>((event, emit) {
      String userId = event.userId.toString();
      _paymentMap[userId] = {
        'userId': userId,
        'userName': event.userName,
        'selectedPrice': event.selectedPrice,
      };

      _selectedIndex = event.index;

      emit(PriceListUpdated(_paymentMap.values.toList(), _selectedIndex));
    });

    on<DeletePriceEvent>((event, emit) {
      String userId = event.userId.toString();

      if (_paymentMap.containsKey(userId)) {
        _paymentMap.remove(userId);

        if (_selectedIndex != null && _paymentMap.length <= _selectedIndex!) {
          _selectedIndex = -1;
        }

        print("Deleted payment for userId: $userId");
      } else {
        print("UserId not found in payment records: $userId");
      }

      emit(PriceListUpdated(_paymentMap.values.toList(), _selectedIndex));
    });
  }
}
