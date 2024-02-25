import 'package:show_me_card/model/card.dart';
import 'package:show_me_card/repository/test_repository.dart';

/// 카드의 상세 정보 및 혜택 계산기 페이지에 대한 뷰모델
class CardLoadingViewModel {
  Future<PayCard?> getCard(String cardId) {
    var repo = TestRepository();
    return repo.getCard(cardId);
  }
}
