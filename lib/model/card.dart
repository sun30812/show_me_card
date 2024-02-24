enum CardType {
  /// 할인형 카드
  discount,

  /// 포인트 적립형 카드
  reward,

  /// 복합형 카드(포인트 적립 + 할인)
  multiple;

  @override
  String toString() => switch (this) {
        CardType.discount => '할인',
        CardType.reward => '적립',
        CardType.multiple => '할인 및 적립',
      };
}

class SimplePayCard {
  /// 카드 식별을 위한 ID
  final String id;

  /// 카드 이름
  final String name;

  SimplePayCard(this.id, this.name);
}

class PayCard {
  /// 카드 식별을 위한 ID
  final String id;

  /// 카드 이름
  final String name;

  /// 상품권 실적 인정 가능 여부
  final bool isAbleGiftCard;

  /// 상품권 할인 및 적립 대상 여부
  final bool isDiscountGiftCard;

  /// 모든 영역 통합 할인 및 적립 한도(0=무제한 혹은 없음)
  final int limit;

  /// 실적 필요 금액(0=무실적, 만원 단위)
  final int loyalty;

  /// 전 가맹점 적립 포인트 혹은 할인 비율
  final double point;

  /// 추가 적립 및 할인 혜택 모음
  final Map<String, (double, int)>? extraPoints;

  /// 보너스 리워드 (보너스 금액, 보너스 사용 실적) 튜플 형태
  final (int, int)? bonus;

  /// 실적 충족에 따른 보너스 적립률
  ///
  /// [Map] 형태로 `key`는 만원 단위의 필요 실적이고, `value`는 적립 및 할인율에 적용되는 배수이다.(각 특수 영역의 적립률의 3배 적립이면 3.0)
  /// ## 주의 사항
  /// 해당 필드에 값을 지정하려면 [isBoostApplyForAll]가 `null`이 아니여야 한다.
  /// [isBoostApplyForAll]가 `null`인 경우 해당 필드 지정 시 오류가 발생한다.
  final Map<int, double>? boost;

  /// 모든 가맹점에 [boost] 적용 여부
  ///
  /// 해당 필드가 `true`인 경우 적립이나 할인 혜택을 받는 모든 영역에서 실적에 따른 추가 혜택이 적용된다.
  /// `false`의 경우에는 특수 영역에만 추가 혜택이 제공된다.
  ///
  /// ## 주의 사항
  /// [boost]가 `null`이 아닌 경우에만 해당 필드에 값을 지정할 수 있다.
  /// [boost]가 `null`인 경우 해당 필드 지정 시 오류가 발생한다.
  final bool? isBoostApplyForAll;

  /// 카드 분류
  final CardType type;

  /// 카드 설명
  final String description;

  /// 카드 정보를 가진 객체
  PayCard(
      {required this.id,
      required this.name,
      required this.isAbleGiftCard,
      required this.isDiscountGiftCard,
      required this.limit,
      required this.loyalty,
      required this.point,
      this.extraPoints,
      this.bonus,
      this.boost,
      this.isBoostApplyForAll,
      required this.type,
      required this.description});

  int calculatePoint(
      int usageMoney, int prevUsageMoney, Map<String, int>? usageExtraMoney) {
    assert((boost == null) == (isBoostApplyForAll == null));
    List<int> boostList = boost != null ? boost!.keys.toList() : [];
    boostList.sort();
    var target =
        boostList.where((element) => element <= usageMoney / 10000).lastOrNull;
    var result = usageMoney *
        (point *
            ((target != null) && (isBoostApplyForAll == true)
                ? boost![target]!
                : 1) /
            100);
    if (usageExtraMoney != null) {
      for (var extra in usageExtraMoney.entries) {
        var extraResult = extra.value *
            (extraPoints![extra.key]!.$1 *
                (target != null ? boost![target]! : 1) /
                100);
        var extraLimit = extraPoints![extra.key]!.$2;
        if (extraLimit != 0) {
          result += extraResult > extraLimit ? extraLimit : extraResult;
        } else {
          result += extraResult;
        }
      }
    }
    if (limit == 0) {
      return result.toInt();
    }
    return result > limit ? limit : result.toInt();
  }
}
