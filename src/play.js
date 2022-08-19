const contractAddr = "0x5A33776493f6507D058276791D162e77D72be637"
const avnWalletAddress = "0x015647C576DB6863B593c0567F4c65AEF7440489"

require('dotenv').config();
const { ethers, providers } = require('ethers');
const fs = require('fs');
const path = require('path');


const readABI = name => {
  const json = JSON.parse(
    fs.readFileSync(path.join(__dirname, '/build/contracts/', `${name}.json`))
  );
  return json.abi;
};

const admin = new ethers.Wallet(
  process.env.PRIVATE_KEY,
  new ethers.providers.JsonRpcProvider('https://goerli.infura.io/v3/' + process.env.INFURA_API_KEY)
);

const contract = new ethers.Contract(contractAddr, readABI('ProofOfEvent'), admin);

async function printTx(txhash) {
  console.log(await provider.getTransaction(txhash));
}

async function mintToken(eventId, uri, to) {
  const tx = await contract.functions.mintToken(eventId, uri, to, {
    gasLimit: 6521975,
  });
  console.log(tx);
  await tx.wait();
}


async function printTokens(address) {
  const tokensAmount = (await contract.functions.balanceOf(address)).toNumber();
  console.log('tokensAmount ' + tokensAmount)
  let events = [];
  for (let i = 0; i < tokensAmount; i++) {
    let tokenId = await contract.functions.tokenOfOwnerByIndex(address, i);
    let uri = await contract.functions.tokenURI(tokenId);
    events.push({
      uri: uri,
      tokenId: tokenId,
    });
  }
  console.log(events);
  return events;
}

async function main() {
  console.log('call mint token');
  await mintToken(1, "bafybeibnsoufr2renqzsh347nrx54wcubt5lgkeivez63xvivplfwhtpym", avnWalletAddress)
  await printTokens(avnWalletAddress);
}

main().catch(err => {
  console.log('Error', err.msg);
  console.log(err);
});
