const { expect } = require("chai");
 const { expectRevert } = require("@openzeppelin/test-helpers");



const MultiSigner = artifacts.require("MultiSigner");

contract("MutltiSigner Testing", (accounts) => {
    let wallet;
    it("Instatiate Wallet Address with incorrect constructor value",async () => {
        try{
            wallet = await MultiSigner.new([], 2);
        }catch(e){
            expect(e.reason).to.be.equal("Owners Required !")
        }
    })

    it("Instatiate Wallet Address with incorrect limit value",async () => {
        try{
            wallet = await MultiSigner.new([accounts[0], accounts[1]], 0);
        }catch(e){
            expect(e.reason).to.be.equal("Invalid number of required approver's !")
        }
    })

    it("Instatiate Wallet Address with incorrect value, like same owner 2 times",async () => {
        try{
            wallet = await MultiSigner.new([accounts[0], accounts[0]], 2);
        }catch(e){
            expect(e.reason).to.be.equal("Owner not unique");
        }
    })

    it("Instatiate Wallet Address with correct constructor value",async () => {
        wallet = await MultiSigner.new([accounts[0], accounts[1], accounts[2]], 2);
    })

    it("Create Transaction without owner", async () => {
       try{
            await wallet.submitTransaction(accounts[2], 1, {from: accounts[4]});
       }catch(e){
        expect(e.reason).to.be.equal("not owner");
       }
    })

    it("Create Transaction", async () => {
        await wallet.submitTransaction(accounts[2], 1, {from: accounts[0]});
     })

    it("Conifrom Transaction with wrong transaction ID", async () => {
        try{
             await wallet.coniformTransaction(1, {from: accounts[0]});
        }catch(e){
         expect(e.reason).to.be.equal("transaction does not exit");
        }
     })

     it("Conifrom Transaction with wrong owner", async () => {
        try{
             await wallet.coniformTransaction(1, {from: accounts[4]});
        }catch(e){
         expect(e.reason).to.be.equal("not owner");
        }
     })

     it("Conifrom Transaction", async () => {
        try{
             await wallet.coniformTransaction(0, {from: accounts[0]});
        }catch(e){
         expect(e.reason).to.be.equal("not owner");
        }
     })

     it("Execute Transaction without min approvers", async () => {
        try{
             await wallet.executeTransaction(0);
        }catch(e){
         expect(e.reason).to.be.equal("connot execute, some approver's not approve transaction !");
        }
     })

     it("Conifrom Transaction", async () => {
        try{
             await wallet.coniformTransaction(0, {from: accounts[1]});
        }catch(e){
         expect(e.reason).to.be.equal("not owner");
        }
     })

     it("Execute Transaction failed", async () => {
        try{
             await wallet.executeTransaction(0);
        }catch(e){
            expect(e.reason).to.be.equal("transfer failed");
        }
     })

     it("Execute Transaction", async () => {
        try{
             await wallet.executeTransaction(0, {from: accounts[0]});
        }catch(e){
            // expect(e.reason).to.be.equal("transfer failed");
            console.log(e)
        }
     })
})

