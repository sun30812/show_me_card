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
      required this.type,
      required this.description});

  int calculatePoint(
      int usageMoney, int prevUsageMoney, Map<String, int>? usageExtraMoney) {
    var result = usageMoney * (point / 100);
    if (usageExtraMoney != null) {
      for (var extra in usageExtraMoney.entries) {
        var extraResult = extra.value * (extraPoints![extra.key]!.$1 / 100);
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
