// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/server_detail_screen.dart';

class Routes {
  static const String homeScreen = '/';
  static const String serverDetailScreen = '/server-detail-screen';
  static const all = <String>{
    homeScreen,
    serverDetailScreen,
  };
}

class RouterApp extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.serverDetailScreen, page: ServerDetailScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    ServerDetailScreen: (data) {
      final args = data.getArgs<ServerDetailScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ServerDetailScreen(
          key: args.key,
          code: args.code,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ServerDetailScreen arguments holder class
class ServerDetailScreenArguments {
  final Key key;
  final String code;
  ServerDetailScreenArguments({this.key, @required this.code});
}
