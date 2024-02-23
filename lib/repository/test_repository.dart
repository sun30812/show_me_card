import 'package:show_me_card/model/card.dart';
import 'package:show_me_card/repository/card_repository.dart';

/// 기능 확인을 위해 제작된 로컬 저장소
class TestRepository implements CardRepository {
  @override
  Future<List<PayCard>?> getAllCards() => Future.value([
        PayCard(
            id: 'dkfmk32-343',
            name: '현대카드 M Boost',
            isAbleGiftCard: true,
            isDiscountGiftCard: false,
            limit: 0,
            loyalty: 0,
            point: 0.5,
            extraPoints: {
              '온라인 간편결제': (5.0, 10000),
              '커피(이디야, 폴바셋, 스타벅스)': (3.0, 0),
              '대중교통, 베이커리': (2.0, 0),
              '편의점, 학원': (1.0, 0),
              '외식, 통신': (0.7, 0)
            },
            type: CardType.reward,
            description:
                '어디서나 한도 없는 최대 3% X 1.5배 적립\n페이·해외결제 5% 적립\n당월 이용금액 100만원 이상 시 1만 M포인트 추가 적립'),
        PayCard(
            id: 'dkfmk32-100',
            name: 'SC Zero Ed2 포인트형',
            isAbleGiftCard: false,
            isDiscountGiftCard: false,
            limit: 0,
            loyalty: 0,
            point: 1.0,
            extraPoints: {
              '온라인 간편결제': (2.5, 0),
              '커피(이디야, 폴바셋, 스타벅스)': (2.5, 0),
              '음식점': (2.5, 0),
              '대형마트 할인점': (2.5, 0),
            },
            type: CardType.reward,
            description: '실적, 한도 제한 없는 카드'),
        PayCard(
            id: 'dkfmk32-112',
            name: '현대 Zero Ed3 포인트형',
            isAbleGiftCard: false,
            isDiscountGiftCard: false,
            limit: 0,
            loyalty: 0,
            point: 1.2,
            type: CardType.reward,
            description: '실적, 한도제한 없는 카드'),
        PayCard(
            id: 'dkfmk32-113',
            name: '현대 Zero Ed3 할인형',
            isAbleGiftCard: false,
            isDiscountGiftCard: false,
            limit: 0,
            loyalty: 0,
            point: 0.8,
            type: CardType.discount,
            description: '실적, 한도 제한 없는 카드'),
        PayCard(
            id: 'dkfmk32-8182',
            name: '현대카드 Z Work',
            isAbleGiftCard: false,
            isDiscountGiftCard: false,
            limit: 0,
            loyalty: 0,
            point: 0.0,
            extraPoints: {
              '온라인 간편결제': (10.0, 5000),
              '커피전문점(스타벅스, 투썸플레이스, 커피빈, 폴 바셋)': (50.0, 10000),
              '편의점(GS25, CU, 세븐일레븐, 이마트24)': (10.0, 5000),
              '대중교통(택시는 1일 1회)': (10.0, 5000),
              '이동통신 정기결제(SKT, KT, LG U+)': (7.0, 5000),
            },
            type: CardType.discount,
            description: '직장인이 즐겨쓰는 5개 영역 청구 할인'),
        PayCard(
            id: 'dkfmk32-p005',
            name: 'the Green Edition2',
            isAbleGiftCard: true,
            isDiscountGiftCard: false,
            limit: 0,
            loyalty: 500000,
            point: 1.0,
            extraPoints: {
              '여행': (5.0, 50000),
              '고메': (5.0, 5000),
              '해외': (7.0, 70000),
            },
            type: CardType.reward,
            description:
                '자유와 모험을 즐기는 나의 첫 럭셔리 카드\n10만 M포인트당 the Green 바우처 10만원권 교환'),
        PayCard(
            id: 'dkfmk32-p003',
            name: 'the Pink',
            isAbleGiftCard: true,
            isDiscountGiftCard: false,
            limit: 0,
            loyalty: 500000,
            point: 1.0,
            extraPoints: {
              '백화점 온라인 몰(SSG.COM, 롯데ON, 현대Hmall)': (5.0, 50000),
              '프리미엄 쇼핑(모든 오프라인 백화점 및 아울렛)': (5.0, 50000),
              '고메': (5.0, 5000),
            },
            type: CardType.reward,
            description:
                '프로 쇼퍼들의 필수 럭셔리 카드\nM포인트로 상품권 교환, 면세점에서 사용 가능한 the Pink 바우처 교환,the Pink 최초 발급 시 웰컴 바우처 제공'),
        PayCard(
            id: 'dkfmk32-n002',
            name: '넥슨 현대카드',
            isAbleGiftCard: false,
            isDiscountGiftCard: false,
            limit: 0,
            loyalty: 0,
            point: 0.5,
            extraPoints: {
              '이용금액 30만원 이상 시 1.5% 추가 적립': (2.0, 200000),
            },
            type: CardType.reward,
            description:
                '최대 2% 넥슨 현대카드 포인트 적립\n이용할 때마다 쌓이는 포인트 혜택\n전월 실적이 30만원 이상인 경우 적립 포인트는 전 가맹점에 기입하지 마세요'),
        PayCard(
            id: 'shaimw-0p1',
            name: '신한카드 Deep Dream',
            isAbleGiftCard: false,
            isDiscountGiftCard: false,
            limit: 10000,
            loyalty: 0,
            point: 0.7,
            extraPoints: {
              '전국 이마트, 홈플러스, 롯데마트, 농협 하나로마트·클럽': (2.1, 0),
              'CU, GS25, 세븐일레븐, 올리브영, 다이소': (2.1, 0),
              'CGV, 롯데시네마, 커피': (2.1, 0),
              '해외': (2.1, 0),
              '이동통신요금': (2.1, 0),
            },
            type: CardType.reward,
            description: '속 깊은 디지털 라이프')
      ]);

  @override
  Future<List<SimplePayCard>?> getAllCardsName() => Future.value([
        SimplePayCard('dkfmk32-343', 'M Boost'),
        SimplePayCard('dkfmk32-100', 'SC Zero Ed2 포인트형'),
      ]);
}
