import 'package:flutter/material.dart';
import 'package:show_me_card/view/card_detail.dart';
import 'package:show_me_card/viewModel/card_loading_view_model.dart';

/// 카드 상세 정보를 띄어주기 위한 작업을 진행하는 화면
class CardLoading extends StatelessWidget {
  final String cardId;

  const CardLoading({super.key, required this.cardId});

  @override
  Widget build(BuildContext context) {
    final viewModel = CardLoadingViewModel();
    return FutureBuilder(
      future: viewModel.getCard(cardId),
      builder: (context, cardSnapshot) {
        if (cardSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (cardSnapshot.data == null) {
          return const Column(
            children: [
              Icon(Icons.help_outline_outlined),
              Text('카드에 대한 정보가 없습니다.')
            ],
          );
        } else {
          return CardDetail(
            card: cardSnapshot.data!,
          );
        }
      },
    );
  }
}
