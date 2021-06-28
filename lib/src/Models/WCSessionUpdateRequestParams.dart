
class WCSessionUpdateRequestParams {
  final bool approved;
  final int chainId;
  final int networkId;
  final List accounts;
  final String rpcUrl;

  WCSessionUpdateRequestParams({this.approved, this.chainId, this.accounts, this.networkId, this.rpcUrl});

  WCSessionUpdateRequestParams.fromJson(Map<String, dynamic> jsonData)
    :approved = jsonData['approved'],
    chainId = jsonData['chainId'],
    accounts = [jsonData['accounts']],
    networkId = jsonData['networkId'],
    rpcUrl = jsonData['rpcUrl'];

}