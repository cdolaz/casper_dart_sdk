## SDK Usage

### Constructing a CasperClient

[CasperClient](../lib/src/casper_client.dart) is the main class of the SDK. It is used to interact with the Casper API.

The client object to interact with the Casper API is created by providing a URL pointing to the RPC endpoint of a Casper node.

```dart
// Sample URL
final serverUrl = 'http://localhost:7777/rpc';
final casper = CasperClient(serverUrl);
```

### Interacting with the Casper API

#### Get State Root Hash

The state root hash of a block is retrieved by calling the `getStateRootHash` method. If no `BlockId` is provided, state root hash of the latest block is retrieved.

`BlockId` can be constructed either by the block hash, or the block height.

```dart
final GetStateRootHashResult result = await casper.getStateRootHash(blockId);
final String stateRootHash = result.stateRootHash;
```

#### Get Peer List

The list of peers connected to the Casper node is retrieved by calling the `getPeers` method.

```dart
final GetPeersResult result = await casper.getPeers();
final List<Peer> peers = result.peers;
```

#### Get Deploy

The information of a specific deploy is retrieved via the `getDeploy` method by specifying the deploy hash.

```dart
final GetDeployResult result = await casper.getDeploy(deployHash);
final Deploy deploy = result.deploy;
```

#### Get Status

Status of the Casper node is retrieved by calling the `getStatus` method.

```dart
final GetStatusResult status = await casper.getStatus();
```

#### Get Block Transfers

The list of transfers of a block is retrieved via the `getBlockTransfers` method by specifying a `blockId`.

```dart
final GetBlockTransfersResult result = await casper.getBlockTransfers(blockId);
final List<Transfer> transfers = result.transfers;
```

#### Get Block

Retrieving the information of a block is via the `getBlock` method by specifying a `blockId`.

```dart
final GetBlockResult result = await casper.getBlock(blockId);
final Block block = result.block;
```

#### Get Era Info By Switch Block

The information of an era is retrieved via the `getEraInfoBySwitchBlock` method by specifying the `blockId`. If no `blockId` is provided, the era information of the latest block is retrieved.

```dart
final GetEraInfoBySwitchBlockResult result = await casper.getEraInfoBySwitchBlock(blockId);
final EraSummary? summary = result.eraSummary;
```

#### Get Item

To query a state item, the `getItem` method is used via providing the key of the state item, the state root hash of the block and a path.

```dart
final GetItemResult result = await casper.getItem(key, stateRootHash, path);
final dynamic item = result.storedValue;
```

#### Query Global State

Same as the `getItem` method, the `queryGlobalState` method is used to query the global state of the Casper node. It is called by providing the key of the item, the state identifier and the path.

```dart
final QueryGlobalStateResult result = await casper.queryGlobalState(key, stateId, isBlockHash);
final dynamic item = result.storedValue;
```

#### Get Balance

The balance of a specific account is retrieved via the `getBalance` method by specifying the account address and the state root hash of the block.

The address can be constructed with 'unforgeable reference', `Uref` (a `GlobalStateKey`).

```dart
final uref = Uref(value); // value: 32 byte hex with an access rights suffix.
final GetBalanceResult result = await casper.getBalance(uref, stateRootHash);
final BigInt balance = result.balance;
```

#### Get Auction Info

To retrieve the auction information of a specific block, the `getAuctionInfo` method is used by specifying the `blockId`. If no `blockId` is provided, the auction information of the latest block is retrieved.

```dart
final GetAuctionInfoResult result = await casper.getAuctionInfo(blockId);
final AuctionState? auctionState = result.auctionState;
```
