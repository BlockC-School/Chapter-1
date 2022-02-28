const DragonballzWorldCollection = artifacts.require(
  "DragonballzWorldCollection",
);

module.exports = async function (deployer, network, accounts) {
  deployer.deploy(
    DragonballzWorldCollection,
    "DragonballZ",
    "DBZ",
    "https://ipfs.io/ipfs/QmNZDPr8vPFgpzySyU4VHtRZeaUt4Ux6eWaXYqumXsc9L1/",
    { from: accounts[0] },
  );

  const instance = await DragonballzWorldCollection.deployed();
  await instance.mint(10);
  await instance.mint(100);
  await instance.mint(10);
  await instance.mint(8);
  await instance.mint(5);
  await instance.mint(10);
  console.log("Minted");
};
