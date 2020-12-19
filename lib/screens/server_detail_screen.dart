import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vpn_countries/controllers/server_controller.dart';
import 'package:vpn_countries/utils/countries_code.dart';

class ServerDetailScreen extends StatelessWidget {
  final String code;

  const ServerDetailScreen({Key key, @required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CountriesCode.value(code)),
      ),
      body: Consumer(
        builder: (context, watch, _) {
          final serversState = watch(serversControllerProvider.state).servers;
          final getServers = serversState[code];

          if (getServers == null) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            shrinkWrap: true,
            itemCount: getServers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(getServers[index].city),
                subtitle: Row(
                  children: [
                    Text(getServers[index].name),
                    Spacer(),
                    percentageBar(getServers[index].load),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
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
