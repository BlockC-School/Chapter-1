const TestNetToken = artifacts.require("TestNetToken");
const { expectRevert } = require("@openzeppelin/test-helpers");

contract("TestNet Token", async (accounts) => {
    let myTestNetToken;
    beforeEach(async () => {
        myTestNetToken = await TestNetToken.new();
    })

    // describe("Should return the correct balance", () => {
    describe("TestNetToken Test cases ::", () => {
        it("Should return the total supply", async () => {
            const totalSupply = await myTestNetToken.totalSupply()
            assert.equal(totalSupply.toNumber(), (1000 * 10 ** 5));

        })

        it("Should return the correct balance", async () => {
            const balance = await myTestNetToken.balanceOf(accounts[0])
            assert.equal(balance.toNumber(), (1000 * 10 ** 5));
        })

        it("Should transfer token", async () => {
            const transfer = await myTestNetToken.transfer(accounts[1], 2000)
            assert(transfer.receipt.status === true);
        })

        it("Should NOT transfer token if balance too low", async () => {
            // try {
            //     const transfer = await myTestNetToken.transfer(accounts[1], 200000000000000000000000000000000000000000000000000000000000)
            // } catch (err) {
                // console.log(err);
            // }
            expectRevert(
                myTestNetToken.transfer(accounts[1], 20000000000000000000000000000000000000000),
                `overflow (fault="overflow", operation="BigNumber.from", value=2e+40, code=NUMERIC_FAULT, version=bignumber/5.0.8)`
            )
        })

        it("Should transfer token when approved", async () => {
            const transfer = await myTestNetToken.transfer(accounts[1], 2000);
            const balance = await myTestNetToken.balanceOf(accounts[1]);
            const approve = await myTestNetToken.approve(accounts[1], 1000);
            // const allowance = await myTestNetToken.allowance(accounts[0], accounts[1])
            const transfer2 = await myTestNetToken.transfer(accounts[2], 1000, {from: accounts[1]})
            const balance2 = await myTestNetToken.balanceOf(accounts[2]);
            // console.log("account 3: ", balance2.toNumber());
        })

        it("Should NOT transfer token if not approved", async () => {
            const transfer = await myTestNetToken.transfer(accounts[1], 2000);
            const balance = await myTestNetToken.balanceOf(accounts[1]);
            // const approve = await myTestNetToken.approve(accounts[1], 1000);
            // const allowance = await myTestNetToken.allowance(accounts[0], accounts[1])
            // const balance2 = await myTestNetToken.balanceOf(accounts[2]);
            // console.log("account 3: ", balance2.toNumber());
            expectRevert(
                myTestNetToken.transferFrom(accounts[1], accounts[2], 1000),
                `VM Exception while processing transaction: revert ERC20: insufficient allowance -- Reason given: ERC20: insufficient allowance.`
            )
        })
    })
   
})