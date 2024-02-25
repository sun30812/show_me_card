import 'package:show_me_card/model/card.dart';

abstract interface class CardRepository {
  /// 모든 카드의 목록을 가져오는 함수
  Future<List<PayCard>?> getAllCards();

  /// 모든 카드의 이름을 가져오는 함수
  Future<List<SimplePayCard>?> getAllCardsName();

  /// 특정 카드의 정보를 가져오는 함수
  ///
  /// [cardId]에 카드의 고유 ID 를 전달하면 카드 정보를 반환한다.
  Future<PayCard?> getCard(String cardId);
}
