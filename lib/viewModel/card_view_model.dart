import 'package:flutter/material.dart';
import 'package:show_me_card/model/card.dart';

/// 카드의 상세 정보 및 혜택 계산기 페이지에 대한 뷰모델
class CardDetailViewModel {
  final PayCard _card;
  late final TextEditingController usageMoneyController;
  late final Map<String, TextEditingController>? usageExtraMoney;

  get cardName => _card.name;

  get cardPoint => _card.point;

  get cardType => _card.type;

  CardDetailViewModel(this._card) {
    if (_card.extraPoints != null) {
      usageExtraMoney = _card.extraPoints!
          .map((key, _) => MapEntry(key, TextEditingController()));
    } else {
      usageExtraMoney = null;
    }
    usageMoneyController = TextEditingController();
  }

  /// 받을 혜택을 계산하는 메서드
  int calculateMyPoint() => _card.calculatePoint(
      int.tryParse(usageMoneyController.text) ?? 0,
      int.tryParse(usageMoneyController.text) ?? 0,
      usageExtraMoney
          ?.map((key, value) => MapEntry(key, int.tryParse(value.text) ?? 0)));

  /// 총 이용금액을 계산하는 메서드
  int calculateUsageMoney() {
    if (usageExtraMoney == null) {
      return int.tryParse(usageMoneyController.text) ?? 0;
    }
    return (int.tryParse(usageMoneyController.text) ?? 0) +
        usageExtraMoney!.values
            .map((e) => int.tryParse(e.text) ?? 0)
            .reduce((value, element) => value + element);
  }

  /// 추가 할인 및 적립 혜택률을 **(할인 및 적립률, 최대 할인 및 적립 포인트)** 형태의 튜플로 반환하는 메서드
  (double, int)? getExtraPointsInfo(String? extraZone) =>
      _card.extraPoints?[extraZone];
}
