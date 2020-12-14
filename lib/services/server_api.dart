import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final serverApiProvider = Provider<ServerApi>((ref) {
  final client = http.Client();
  final baseUrl = 'https://api.protonvpn.ch';

  return ServerApi(
    url: baseUrl,
    client: client,
  );
});

class ServerApi {
  ServerApi({this.url, this.client});

  final String url;
  final http.Client client;

  Future<http.Response> fetchLogicalServers() async {
    return client.get('$url/vpn/logicals');
  }
}
