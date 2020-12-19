import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vpn_countries/controllers/server_controller.dart';
import 'package:vpn_countries/routes/router.gr.dart';
import 'package:vpn_countries/utils/countries_code.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VPN Countries'),
      ),
      body: Consumer(
        builder: (context, watch, _) {
          final serversState = watch(serversControllerProvider.state).servers;
          final serversKeys = serversState.keys.toList();

          if (serversState.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () {
              if (context.read(serversControllerProvider).mounted) {
                return context.refresh(serversControllerProvider).getServers();
              }
              return null;
            },
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: serversKeys.length,
              itemBuilder: (context, index) {
                final countryCode = serversKeys[index];
                var flagCode = countryCode.toLowerCase();
                if (flagCode == 'uk') {
                  flagCode = 'gb';
                }
                final totalOfServers = serversState[countryCode].length;

                return GestureDetector(
                  key: Key('tap_country_$flagCode'),
                  onTap: () {
                    ExtendedNavigator.root.push(
                      Routes.serverDetailScreen,
                      arguments: ServerDetailScreenArguments(code: countryCode),
                    );
                  },
                  child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      child: Image.asset('assets/flags/$flagCode.png'),
                    ),
                    title: Text(
                      CountriesCode.value(serversKeys[index]),
                    ),
                    subtitle: Row(
                      children: [
                        Text('$totalOfServers servers'),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          );
        },
      ),
    );
  }
}
