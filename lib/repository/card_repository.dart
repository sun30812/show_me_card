import 'package:show_me_card/model/card.dart';

abstract interface class CardRepository {
  /// 모든 카드의 목록을 가져오는 함수
  Future<List<PayCard>?> getAllCards();

  /// 모든 카드의 이름을 가져오는 함수
  Future<List<SimplePayCard>?> getAllCardsName();
}
