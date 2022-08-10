// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ProofOfEvent is ERC721URIStorage {
    event EventToken(uint256 eventId, uint256 tokenId);
    using Counters for Counters.Counter;

    // Last Used id (used to generate new ids)
    Counters.Counter private _lastTokenId;

    // Event Id for each token, this is a dictionary to hold (TokenId,EventId)
    mapping(uint256 => uint256) private _tokenPerEvent;

    constructor() ERC721("AvanodProofOfEvent", "AVNProof") {}

    /**
     * @dev Gets the event Id
     * @param tokenId representing the token Id
     * @return uint256 representing the event Id
     */
    function getEventId(uint256 tokenId) external view returns (uint256) {
        return _tokenPerEvent[tokenId];
    }

    /**
     * @dev Function to create and mint tokens
     * @param eventId EventId for the new token
     * @param tokenURI Address of NFT MetaData which is stored on IPFS
     * @param to The address that will receive the minted tokens.
     * @return A boolean that indicates if the operation was successful.
     */
    function mintToken(
        uint256 eventId,
        string memory tokenURI,
        address to
    ) public returns (bool) {
        _lastTokenId.increment();
        uint256 __tokenId = _lastTokenId.current();
        return _mintToken(__tokenId, tokenURI, eventId, to);
    }

    /**
     * @dev Function to mint tokens for Many Users
     * @param eventId EventId for the new token
     * @param tokenURI Address of NFT MetaData which is stored on IPFS
     * @param to The address that will receive the minted tokens.
     * @return A boolean that indicates if the operation was successful.
     */
    function mintTokenToManyUsers(
        uint256 eventId,
        string[] memory tokenURI,
        address[] memory to
    ) public returns (bool) {
        uint256 __tokenId = 0;
        for (uint256 i = 0; i < to.length; ++i) {
            _lastTokenId.increment();
            __tokenId = _lastTokenId.current();
            _mintToken(__tokenId, tokenURI[i], eventId, to[i]);
        }
        return true;
    }

    /**
     * @dev Function to mint tokens
     * @param tokenId The token id to mint.
     * @param eventId EventId for the new token
     * @param tokenURI TokenURI to store on ERC721URIStorage.
     * @param to The address that will receive the minted tokens.
     * @return A boolean that indicates if the operation was successful.
     */
    function _mintToken(
        uint256 tokenId,
        string memory tokenURI,
        uint256 eventId,
        address to
    ) internal returns (bool) {
        // TODO Verify that the token receiver ('to') do not have already a token for the event ('eventId')

        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _tokenPerEvent[tokenId] = eventId;
        emit EventToken(eventId, tokenId);
        return true;
    }

    /**
     * @dev Internal function to burn a specific token
     * Reverts if the token does not exist
     * @param tokenId uint256 ID of the token being burned by the msg.sender
     */
    function _burn(uint256 tokenId) internal override {
        require(_isApprovedOrOwner(msg.sender, tokenId));
        super._burn(tokenId);
        delete _tokenPerEvent[tokenId];
    }
}
