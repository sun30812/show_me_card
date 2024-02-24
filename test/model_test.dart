import 'package:flutter_test/flutter_test.dart';
import 'package:show_me_card/model/card.dart';

void main() {
  test('Card point calculation test', () {
    const card = PayCard(
        id: 'test',
        name: 'Normal Card',
        isAbleGiftCard: true,
        isDiscountGiftCard: false,
        limit: 20000,
        loyalty: 0,
        point: 3,
        type: CardType.reward,
        description: 'Default Card');
    expect(card.calculatePoint(5300000, 0, 0, null), 20000);
    expect(card.calculatePoint(530000, 0, 0, null), 15900);
  });
}
