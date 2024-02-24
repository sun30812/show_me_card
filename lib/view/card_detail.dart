import 'package:flutter/material.dart';
import 'package:show_me_card/model/card.dart';
import 'package:show_me_card/viewModel/card_view_model.dart';

class CardDetail extends StatelessWidget {
  final PayCard card;
  late final CardDetailViewModel _viewModel = CardDetailViewModel(card);

  CardDetail({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    var dataList = _viewModel.usageExtraMoney?.keys.toList() ?? [];
    var controllerList = _viewModel.usageExtraMoney;
    return Scaffold(
      appBar: AppBar(
        title: Text(_viewModel.cardName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '카드 정보',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(card.description),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '전 가맹점: ${_viewModel.cardPoint}% ${_viewModel.cardType}'),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      var extraPointsInfo =
                          _viewModel.getExtraPointsInfo(dataList[index]);
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${dataList[index]}: ${extraPointsInfo?.$1}% ${_viewModel.cardType} / ${extraPointsInfo?.$2 == 0 ? '무제한' : extraPointsInfo?.$2}'),
                        ),
                      );
                    },
                  ),
                  Text(
                    '혜택 계산기',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('${dataList[index]} 영역 사용 금액: '),
                            Flexible(
                                child: TextField(
                              controller: controllerList?[dataList[index]],
                              decoration: const InputDecoration(filled: true),
                            )),
                            const Text('원')
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('기타 가맹점 사용 금액: '),
                        Flexible(
                            child: TextField(
                          controller: _viewModel.usageMoneyController,
                          decoration: const InputDecoration(filled: true),
                        )),
                        const Text('원')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          PointReport(viewModel: _viewModel)
        ],
      ),
    );
  }
}

class PointReport extends StatefulWidget {
  const PointReport({
    super.key,
    required this.viewModel,
  });

  final CardDetailViewModel viewModel;

  @override
  State<PointReport> createState() => _PointReportState();
}

class _PointReportState extends State<PointReport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '실적 반영 금액: ${widget.viewModel.calculateUsageMoney() + widget.viewModel.calculateExtraUsageMoney()}원 이용',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '예상 혜택: ${widget.viewModel.calculateMyPoint()} ${widget.viewModel.cardType}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
                child: const Text('계산 하기'),
                onPressed: () {
                  setState(() {});
                }),
          )
        ],
      ),
    );
  }
}
