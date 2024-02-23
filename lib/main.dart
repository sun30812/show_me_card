import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:show_me_card/model/card.dart';
import 'package:show_me_card/view/card_detail.dart';
import 'package:show_me_card/view/card_list.dart';

void main() => runApp(const MainApp());

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return CardList();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'cards/:cardId',
          builder: (BuildContext context, GoRouterState state) {
            return CardDetail(card: state.extra as PayCard);
          },
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Show me card',
      routerConfig: _router,
    );
  }
}
