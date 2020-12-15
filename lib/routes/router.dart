import 'package:auto_route/auto_route_annotations.dart';
import 'package:vpn_countries/screens/home_screen.dart';
import 'package:vpn_countries/screens/server_detail_screen.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: HomeScreen, initial: true),
  AutoRoute(page: ServerDetailScreen),
])
class $RouterApp {}
