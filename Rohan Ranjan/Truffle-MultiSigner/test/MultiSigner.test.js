const { expect } = require("chai");



const MultiSigner = artifacts.require("MultiSigner");

contract("MutltiSigner Testing", (accounts) => {
    let wallet;
    it("Get Wallet Address",async () => {
        wallet = await MultiSigner.new()
    })

    it("Get All List Of Owners Right There Is No Owner", async () => {
        const OwnerList = await wallet.getAllOwnerList();
        expect(OwnerList).to.be.an("array")
    })

     it("Add First Owner ", async () => {
        const res = await wallet.addOwner(accounts[0]);
        // console.log("res => ", res.value)
        // expect(res).to.be.equal("Owner added successfully !")
    })

    it("Check First Owner is equal to accounts[0] or not", async () => {
        const OwnerList = await wallet.getAllOwnerList();
        expect(OwnerList[0].ownerAddress).to.be.equal(accounts[0]);
    })

    it("Add Second Owner ", async () => {
        const res = await wallet.addOwner(accounts[1]);
        // console.log("res => ", reciept)
        // expect(res).to.be.equal("Owner added successfully !")
    })

    it("Check Second Owner is equal to accounts[1] or not", async () => {
        const OwnerList = await wallet.getAllOwnerList();
        expect(OwnerList[1].ownerAddress).to.be.equal(accounts[1]);
    })

    it("Trying to add account[0] as a owner, expect to be error", async () => {
        const res = await wallet.addOwner(accounts[0]);
        // console.log("again res => ", res)
    })

    it("Approve transaction", async () => {
        const res = await wallet.approveTransaction({from: accounts[2]});
        // console.log("approve res => ", res)
    })
    
})