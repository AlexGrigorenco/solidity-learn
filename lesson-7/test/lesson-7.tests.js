const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Demo", () => {
  let owner;
  let otherAddress;
  let demo;

  beforeEach(async function () {
    [owner, otherAddress] = await ethers.getSigners();
    const DemoContract = await ethers.getContractFactory("Demo", owner);
    demo = await DemoContract.deploy();
    await demo.waitForDeployment();

    console.log(await demo.getAddress());
  });

  async function sendMoney(sender) {
    const amount = 100;
    const txData = {
      to: await demo.getAddress(),
      value: amount,
    };

    const tx = await sender.sendTransaction(txData);
    await tx.wait();

    return [tx, amount];
  }

  it("should allow to send money", async () => {
    const [sendMoneyTx, AMOUNT] = await sendMoney(otherAddress);

    await expect(() => sendMoneyTx).to.changeEtherBalance(demo, AMOUNT);

    const timestamp = (await ethers.provider.getBlock(sendMoneyTx.blockNumber)).timestamp;

    await expect(sendMoneyTx).to.emit(
      demo,
      "Paid"
    ).withArgs(otherAddress.address, AMOUNT, timestamp)
  });

  it("should allow owner to withdraw founds", async () => {
    const [_, AMOUNT] = await sendMoney(otherAddress);

    const tx = await demo.withdraw(owner.address);

    await expect(() => tx).to.changeEtherBalances([demo, owner], [-AMOUNT, AMOUNT]);
  });

  it("shound not allow other accounts to withdraw founds", async () => {
    const [_, AMOUNT] = await sendMoney(otherAddress);

    await expect(demo.connect(otherAddress).withdraw(owner.address)).to.be.revertedWith("you are not an owner");
  });
});
