# Decentralized Star Notary Service DApp

This is the fifth project of the Udacity Blockchain Nanodegree. It is a decenteralized smart contract app that provides a web front end to create and lookup stars. 
The DAPP implements the ERC-721 non-fungible token standard utilising openzeppelin and is deployed to the public Rinkeby Ethereum test network at the contract address:  
https://rinkeby.etherscan.io/address/0x4fd533775Fe1523d783835a7c30Ee23BfB17C72c

1. ERC-721 Token Name: Star Notary Token
2. ERC-721 Token Symbol: SNT
3. Versions: Truffle v5.4.3 (core: 5.4.3), Solidity - ^0.8.0 (solc-js), Node v14.16.0, Web3.js v1.5.0


## Smart Contract Functions

The function `lookUptokenIdToStarInfo` in StarNotary.sol is implemented to look up stars using the token id. The function returns the name of the star.

```
function lookUptokenIdToStarInfo (uint _tokenId) public view returns (string memory) {}
```

A function called `exchangeStars` is added so two users can exchange their star tokens regardless of potential price differences.

```
function exchangeStars(uint256 _tokenId1, uint256 _tokenId2) public {} 
```

`transferStar` is used to transfer a star. The function transfers a star from the address of the caller (msg.sender) and accepts two arguments. The first is the address of the recipient, the second argument is the token id of the star.

```
function transferStar(address _to1, uint256 _tokenId) public {} 
```


## Supporting Unit Tests

Tests for the smart contract functions are written in the StarNotaryTest.js file in the tests folder.
The following tests exist: 

1. The creation of a new star to the contract.
2. An owner of a star can render their star for sale
3. Initialised a sale and buy between users and confirmed that funds are transfered accordingly
4. Confirming the transfer of ownership post star purchase.
5. Affirming that ETH balances change respectively after a transaction.
6. The token name and token symbol are added properly.
7. Users can exchange their stars.
8. Stars Tokens can be transferred from one address to another.

## Contract deployed to Rinkeby test network

The truffle-config.js file is setup to deploy the contract to the Rinkeby Test Network.
Infura is used in the truffle-config.js file for deployment to Rinkeby.

## Front end of the DAPP

When you click on the button "Look Up a Star" the application shows in the status the Star information.
A user may create a star and information regarding ownership and ID will be displayed on the webpage. 
