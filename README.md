# Decentralized-File-Storage
A simple dApp for decentralized file storage using IPFS and Ethereum

#Decentralized File Storage dApp

This project is a simple decentralized application (dApp) for securely storing and retrieving files. It uses a blockchain (like Ethereum) to store file metadata and access control information, while the files themselves are stored on the InterPlanetary File System (IPFS).

#Architecture

This dApp is built on a common decentralized architecture:

Smart Contract (Solidity): The DecentralizedStorage.sol contract is deployed to an Ethereum-compatible blockchain (e.g., Sepolia testnet). It acts as a public ledger, mapping a user's wallet address to the metadata of their file (the IPFS CID, a description, and a timestamp).

Decentralized Storage (IPFS): The actual file data is uploaded to IPFS. We use Pinata as a "pinning service" to ensure the file remains available on the IPFS network. When a file is uploaded to IPFS, it receives a unique Content Identifier (CID).

Frontend (HTML/JS/Ethers.js): The index.html file provides the user interface. It connects to the user's wallet (e.g., MetaMask) to interact with the smart contract and uses the Pinata API to upload and download the file data from IPFS.


#File Structure

DecentralizedStorage.sol: The Solidity smart contract that manages file metadata.

index.html: The complete frontend application (HTML, Tailwind CSS, and JavaScript) that interacts with MetaMask, Pinata, and the smart contract.


#Getting Started

To run this project, you need to set up all three components (Contract, Pinata, Frontend).

Prerequisites

Wallet: A web3 wallet like MetaMask installed in your browser.

Test ETH: You will need test currency for the network you deploy to (e.g., Sepolia ETH).

Pinata Account: A free account from Pinata.cloud to get an API key.

Local Web Server: You must run the index.html file from a server. The easiest way is with the Live Server extension for VS Code.

Step-by-Step Setup

Step 1: Deploy the Smart Contract

Go to the Remix IDE.

Create a new file DecentralizedStorage.sol and paste the code from this repository.

Go to the "Solidity Compiler" tab and click "Compile".

Go to the "Deploy & Run Transactions" tab.

Under "Environment," select "Injected Provider - MetaMask".

Ensure your MetaMask is connected and set to your desired test network (e.g., Sepolia).

Click the "Deploy" button. Confirm the transaction in MetaMask.

Once deployed, find your contract in the "Deployed Contracts" section and copy its address. You will need this for the frontend.

Step 2: Get Your Pinata JWT

Log in to your Pinata.cloud account.

Navigate to the API Keys section.

Click "New Key".

Enable the pinFileToIPFS permission.

Give your key a name (e.g., "dApp Project").

Pinata will generate your key and show you a JWT (JSON Web Token). Copy this JWT and save it securely. You will need this for the frontend.

Step 3: Run the Frontend

You cannot just double-click index.html (it won't work due to browser security policies).

The best way is to use a local server. If you have VS Code:

Install the "Live Server" extension.

Right-click the index.html file in your VS Code explorer.

Select "Open with Live Server".

This will open the application in your browser (e.g., at http://127.0.0.1:5500/index.html).

How to Use the Application

Once the app is running in your browser:

Paste your Contract Address from Step 1 into the "Contract Address" field.

Paste your Pinata JWT from Step 2 into the "Pinata JWT Token" field.

Click "Connect Wallet". MetaMask will ask you to connect (make sure you are on the same network you deployed the contract to, e.g., Sepolia).

To Upload:

Enter a description for your file.

Choose a file from your computer.

Click "Upload File & Store on-Chain".

Confirm the transaction in MetaMask. This will first upload to IPFS, then call the addFile function on your smart contract to save the CID.

To Retrieve:

Enter any wallet address (yours or someone else's) that you know has uploaded a file.

Click "Retrieve File Info".

The app will call the getFile function on the smart contract, fetch the metadata, and show you the description and a link to view the file on an IPFS gateway.
