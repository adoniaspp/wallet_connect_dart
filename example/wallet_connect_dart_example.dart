import 'package:wallet_connect_dart/src/HandlersResponsesWC/ResponseHandler.dart';
import 'package:wallet_connect_dart/wallet_connect_dart.dart';

Future<void> main() async {
  var walletConnect = WalletConnect(ClientMeta(
    description: 'This is a test of the WalletConnect feature',
    icons: 'https://app.warriders.com/favicon.ico',
    name: 'WalletConnect Test',
    url: 'https://app.warriders.com',
  ));
  ResponseHandler.controllerResponse.stream.listen((event) async {
    print("Resposta");
    print(event);
    await walletConnect.eth_signTransaction();
  });
  await walletConnect.sessionRequest();


}
