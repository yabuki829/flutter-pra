import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webapp/main.dart';

import 'package:webapp/presentation/Details.dart';

final router = GoRouter(
    initialLocation: '/',
  routes: <RouteBase>[
    
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: "ホームページ");
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailPage(title: "詳細");
          },
        ),
      ],
    ),
  ],
);