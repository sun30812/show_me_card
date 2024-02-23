import 'package:show_me_card/model/card.dart';
import 'package:show_me_card/repository/card_repository.dart';
import 'package:show_me_card/repository/test_repository.dart';

class CardListViewModel {
  final CardRepository _cardRepository = TestRepository();

  Future<List<PayCard>?> get cards => _cardRepository.getAllCards();
}
