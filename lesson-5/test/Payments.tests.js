const {expect} = require("chai");
const {ethers} = require("hardhat");

describe("Payments", () => {
    let acc1, acc2;
    let payments;

    beforeEach(async function(){
        [acc1, acc2] = await ethers.getSigners();
        const Payments = await ethers.getContractFactory("Payments", acc1);
        payments = await Payments.deploy();
        await payments.waitForDeployment();
    
        console.log(await payments.getAddress());
    })

    it("should be deployed", async () => {
        expect(await payments.getAddress()).to.be.properAddress;
    });

    it("should be 0 eth by default", async () => {
        const balance = await ethers.provider.getBalance(await payments);
        expect(balance).to.equal(0);
        console.log('balance:',balance);
    });

    it("should be possible to send funds", async () => {
        const sum = 1000;
        const msg = 'it is transaction';

        const tx = await payments.connect(acc2).pay(msg, {
            value: sum,
        });
        payments.connect(acc2).pay(msg, {
            value: sum,
        });

        await tx.wait();

        await expect(() => tx).changeEtherBalances([acc2, payments], [-sum, sum]);

        const balance = await ethers.provider.getBalance(await payments);
        expect(balance).to.equal(sum*2);
        console.log('balance:',balance);

        const payment = await payments.getPayments(acc2, 1);
        console.log("payment", payment);
        expect(payment.amount).to.eq(sum);
        expect(payment.message).to.eq(msg);
        expect(payment.from).to.eq(acc2.address);
        console.log(acc2.address)   
    });
})