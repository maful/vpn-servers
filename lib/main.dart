import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vpn_countries/controllers/server_controller.dart';
import 'package:vpn_countries/utils/countries_code.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final serversState = watch(serversControllerProvider.state).servers;
    final serversKeys = serversState.keys.toList();
    print('MyHomePage build');

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
                var flagCode = serversKeys[index].toLowerCase();
                if (flagCode == 'uk') {
                  flagCode = 'gb';
                }
                final flagUrl =
                    'https://raw.githubusercontent.com/hjnilsson/country-flags/master/png250px/$flagCode.png';
                final totalOfServers = serversState[serversKeys[index]].length;

                return ListTile(
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

  Row percentageBar(int load) {
    Color color;
    if (load <= 30) {
      color = Colors.lightGreen;
    } else if (load > 30 && load <= 85) {
      color = Colors.yellow[700];
    } else {
      color = Colors.red[600];
    }

    return Row(
      children: [
        Text('Load $load% '),
        SizedBox(
          width: 70,
          child: LinearProgressIndicator(
            backgroundColor: Colors.black12,
            minHeight: 10,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            value: load / 100,
            semanticsValue: '100',
          ),
        ),
      ],
    );
  }
}
