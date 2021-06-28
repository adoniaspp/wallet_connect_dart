import 'package:wallet_connect_dart/src/Models/ClientMeta.dart';
import 'package:wallet_connect_dart/wallet_connect_dart.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    WalletConnect walletConnect;

    setUp(() {
      walletConnect = WalletConnect(ClientMeta(
        description: 'This is a test of the WalletConnect feature',
        icons: 'https://app.warriders.com/favicon.ico',
        name: 'WalletConnect Test',
        url: 'https://app.warriders.com',
      ));
    });

    test('First Test', () {
      expect(walletConnect.sessionRequest(), isTrue);
    });
  });
}
