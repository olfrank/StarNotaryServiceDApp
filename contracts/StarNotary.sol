// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../app/node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract StarNotary is ERC721 {

    string public constant tokenName = "StarNotaryToken";
    string public constant tokenSymbol = "SNT";

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol){}

    struct Star {
        string name;
    }

    mapping(uint256 => Star) public tokenIdToStarInfo;
    mapping(uint256 => uint256) public starsForSale;

    event TransferOfStar(address _from, address _to, uint256 _tokenId);
    event CreateStar(address _creator, string _name, uint256 _tokenId);
    event ExchangeStars(address _party1, address _party2, uint256 _tokenId1, uint256 _tokenId2);



    // Create Star using the Struct
    function createStar(string memory _name, uint256 _tokenId) public { // Passing the name and tokenId as a parameters
        Star memory newStar = Star(_name); // Star is an struct so we are creating a new Star
        tokenIdToStarInfo[_tokenId] = newStar; // Creating in memory the Star -> tokenId mapping
        _mint(msg.sender, _tokenId); // _mint assign the the star with _tokenId to the sender address (ownership)
        emit CreateStar(msg.sender, _name, _tokenId);
    }

    // Putting an Star for sale (Adding the star tokenid into the mapping starsForSale, first verify that the sender is the owner)
    function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
        require(ownerOf(_tokenId) == msg.sender, "You can't sell a star you don't own");
        starsForSale[_tokenId] = _price;
    }

    function buyStar(uint256 _tokenId) public  payable {
        require(starsForSale[_tokenId] > 0, "The star should be up for sale");
        uint256 starCost = starsForSale[_tokenId];
        address ownerAddress = ownerOf(_tokenId);
        require(msg.value > starCost, "You need to have enough Ether");
        _transfer(ownerAddress, msg.sender, _tokenId); 
        address payable ownerAddressPayable = payable(ownerAddress); // We need to make this conversion to be able to use transfer() function to transfer ethers
        ownerAddressPayable.transfer(starCost);
        if(msg.value > starCost) {
            address payable seller = payable(msg.sender);
            seller.transfer(msg.value - starCost);
        }
        emit TransferOfStar(ownerAddress, msg.sender, _tokenId);
    }

    // Implement Task 1 lookUptokenIdToStarInfo
    function lookUptokenIdToStarInfo (uint _tokenId) public view returns (string memory _name) {
        //1. You should return the Star saved in tokenIdToStarInfo mapping
        _name = tokenIdToStarInfo[_tokenId].name;
        return _name;
    }

    // Implement Task 1 Exchange Stars function
    function exchangeStars(uint256 _tokenId1, uint256 _tokenId2) public {
        //1. Passing to star tokenId you will need to check if the owner of _tokenId1 or _tokenId2 is the sender
        require(ownerOf(_tokenId1) == msg.sender || ownerOf(_tokenId2) == msg.sender, "You can't exchange a star you don't own");
        //2. You don't have to check for the price of the token (star)
        //3. Get the owner of the two tokens (ownerOf(_tokenId1), ownerOf(_tokenId1)
        address party1 = ownerOf(_tokenId1);
        address party2 = ownerOf(_tokenId2);
        //4. Use _transferFrom function to exchange the tokens.
        _transfer(party1, party2, _tokenId1);
        _transfer(party2, party1, _tokenId2);

    }

    // Implement Task 1 Transfer Stars
    function transferStar(address _to1, uint256 _tokenId) public {
        //1. Check if the sender is the ownerOf(_tokenId)
        require(ownerOf(_tokenId) == msg.sender, "You are not the owner of this token");
        //2. Use the transferFrom(from, to, tokenId); function to transfer the Star
        _transfer(msg.sender, _to1, _tokenId);
        emit TransferOfStar(msg.sender, _to1, _tokenId);
    }

}
