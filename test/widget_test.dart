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
      var finder = find.text('현대카드 M Boost');
      expect(finder, findsOne);
      await widgetTester.tap(finder);
      await widgetTester.pumpAndSettle();
      expect(finder, findsAtLeast(1));
      expect(find.text('혜택 계산기'), findsOne);
    });
    testWidgets('Calculating point function test (현대카드 M Boost)',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MainApp());
      await widgetTester.pumpAndSettle();
      var finder = find.textContaining('현대카드 M Boost', skipOffstage: false);
      expect(finder, findsOne);
      await widgetTester.tap(finder);
      await widgetTester.pumpAndSettle();
      var inputs = find.byType(TextField);
      await widgetTester.enterText(inputs.at(0), '200000');
      await widgetTester.enterText(inputs.at(1), '142000');
      await widgetTester.enterText(inputs.at(2), '190000');
      await widgetTester.enterText(inputs.at(3), '45000');
      await widgetTester.enterText(inputs.at(4), '190000');
      await widgetTester.enterText(inputs.at(5), '87000');
      await widgetTester.enterText(inputs.at(6), '150000');
      await widgetTester.tap(find.byType(FilledButton));
      await widgetTester.pumpAndSettle();
      expect(find.textContaining('1004000'), findsOne);
      expect(find.textContaining('적립'), findsAtLeast(1));
      expect(find.textContaining('35412'), findsOne);
    });
  });
}
