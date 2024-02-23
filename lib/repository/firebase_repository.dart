import 'package:show_me_card/model/card.dart';
import 'package:show_me_card/repository/card_repository.dart';

/// Firebase Realtime Database 혹은 Firestore 에서 카드 정보 불러오는 저장소
class FirebaseRepository implements CardRepository {
  @override
  Future<List<SimplePayCard>?> getAllCardsName() {
    throw UnimplementedError();
  }

  @override
  Future<List<PayCard>?> getAllCards() {
    throw UnimplementedError();
  }
}
