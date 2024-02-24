import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:show_me_card/viewModel/card_list_view_model.dart';

class CardList extends StatelessWidget {
  final CardListViewModel _viewModel = CardListViewModel();

  CardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카드 목록'),
      ),
      body: FutureBuilder(
        future: _viewModel.cards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          } else if (snapshot.data == null) {
            return const Center(
              child: Column(
                children: [
                  Icon(Icons.help_outline_outlined),
                  Text('카드가 없습니다.')
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => context.go('/cards/${snapshot.data![index].id}',
                      extra: snapshot.data![index]),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data![index].name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (snapshot.data![index].isAbleGiftCard) ...[
                                const Icon(Icons.card_giftcard)
                              ] else if (snapshot
                                  .data![index].isDiscountGiftCard) ...[
                                const Icon(
                                  Icons.card_giftcard,
                                  color: Colors.blueAccent,
                                )
                              ]
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
