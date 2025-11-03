// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title DecentralizedStorage
 * @dev This contract stores metadata for files stored on IPFS.
 * It maps a user's address to their file's IPFS CID, description,
 * and upload timestamp.
 * Access control is implicit: only the owner of an address (msg.sender)
 * can add or update the file record for their address.
 */
contract DecentralizedStorage {
    
    // A structure to hold file metadata
    struct FileInfo {
        string cid;         // The IPFS Content Identifier (hash)
        string description; // A brief description of the file
        uint256 timestamp;   // The time the file was added (Unix timestamp)
    }

    // A mapping from a user's address to their stored file info.
    // Each user can store one file record (which can be updated).
    // The mapping is private to enforce a-s-s control via the `addFile` function.
    mapping(address => FileInfo) private userFiles;

    // An event that is emitted when a file is successfully uploaded/updated
    event FileAdded(
        address indexed owner,
        string cid,
        string description,
        uint256 timestamp
    );

    /**
     * @dev Adds or updates the file record for the calling address (msg.sender).
     * This is the "access control" - only you can write to your own record.
     * @param _cid The IPFS CID (hash) of the file.
     * @param _description A user-provided description for the file.
     */
    function addFile(string memory _cid, string memory _description) public {
        require(bytes(_cid).length > 0, "CID cannot be empty");
        
        uint256 timestamp = block.timestamp;

        // Add or update the file info for the message sender
        userFiles[msg.sender] = FileInfo(_cid, _description, timestamp);

        // Emit an event to log this action on-chain
        emit FileAdded(msg.sender, _cid, _description, timestamp);
    }

    /**
     * @dev Retrieves the file information for a given owner address.
     * This function is public and can be called by anyone to view
     * the metadata (as all blockchain data is public).
     * @param _owner The address of the user whose file info to retrieve.
     * @return cid The file's IPFS CID.
     * @return description The file's description.
     * @return timestamp The upload timestamp.
     */
    function getFile(address _owner) 
        public 
        view 
        returns (string memory cid, string memory description, uint256 timestamp)
    {
        FileInfo storage file = userFiles[_owner];
        return (file.cid, file.description, file.timestamp);
    }
}
