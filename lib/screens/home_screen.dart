import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vpn_countries/controllers/server_controller.dart';
import 'package:vpn_countries/routes/router.gr.dart';
import 'package:vpn_countries/utils/countries_code.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final serversState = watch(serversControllerProvider.state).servers;
    final serversKeys = serversState.keys.toList();
    print('HomeScreen build');

    return Scaffold(
      appBar: AppBar(
        title: Text('VPN Countries'),
      ),
      body: Builder(
        builder: (context) {
          if (serversKeys.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () {
              return context.refresh(serversControllerProvider).getServers();
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
                final flagUrl =
                    'https://raw.githubusercontent.com/hjnilsson/country-flags/master/png250px/$flagCode.png';
                final totalOfServers = serversState[countryCode].length;

                return GestureDetector(
                  onTap: () {
                    ExtendedNavigator.root.push(
                      Routes.serverDetailScreen,
                      arguments: ServerDetailScreenArguments(code: countryCode),
                    );
                  },
                  child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      child: CachedNetworkImage(
                        imageUrl: flagUrl,
                        placeholder: (context, url) {
                          return Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
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
