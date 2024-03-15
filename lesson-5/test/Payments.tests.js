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
        console.log('success!')
    })
})