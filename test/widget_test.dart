import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:show_me_card/main.dart';
import 'package:show_me_card/repository/test_repository.dart';

void main() {
  group('Card list page test', () {
    testWidgets('Main page is show up cards to you', (widgetTester) async {
      await widgetTester.pumpWidget(const MainApp());
      await widgetTester.pumpAndSettle();
      final testRepo = TestRepository();
      final allCardsLength = (await testRepo.getAllCards())?.length;
      expect(find.text('카드 목록'), findsOne);
      expect(find.byType(Card, skipOffstage: false),
          findsNWidgets(allCardsLength ?? 0));
    });
    testWidgets('Only Show up for allowing gift card', (widgetTester) async {
      await widgetTester.pumpWidget(const MainApp());
      await widgetTester.pumpAndSettle();
      final testRepo = TestRepository();
      final cardsLength = (await testRepo.getAllCards())
          ?.where((element) => element.isAbleGiftCard)
          .length;
      expect(find.byIcon(Icons.card_giftcard, skipOffstage: false),
          findsNWidgets(cardsLength ?? 0));
    });
  });
  group('Card detail page test', () {
    testWidgets('Show card information', (widgetTester) async {
      await widgetTester.pumpWidget(const MainApp());
      await widgetTester.pumpAndSettle();
      var finder = find.text('SC Zero Ed2 포인트형');
      expect(finder, findsOne);
      await widgetTester.tap(finder);
      await widgetTester.pumpAndSettle();
      expect(finder, findsAtLeast(1));
      expect(find.text('혜택 계산기'), findsOne);
    });
    testWidgets('Calculating point function test', (widgetTester) async {
      await widgetTester.pumpWidget(const MainApp());
      await widgetTester.pumpAndSettle();
      var finder = find.text('SC Zero Ed2 포인트형');
      expect(finder, findsOne);
      await widgetTester.tap(finder);
      await widgetTester.pumpAndSettle();
      var inputs = find.byType(TextField);
      for (var i = 0; i < inputs.evaluate().length; i++) {
        await widgetTester.enterText(inputs.at(i), '150000');
      }
      await widgetTester.tap(find.byType(FilledButton));
      await widgetTester.pumpAndSettle();
      expect(find.textContaining('750000'), findsOne);
      expect(find.textContaining('적립'), findsAtLeast(1));
      expect(find.textContaining('18750'), findsNothing);
      expect(find.textContaining('16500'), findsOne);
    });
  });
}
