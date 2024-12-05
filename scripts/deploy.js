const { ethers } = require("hardhat");

async function main() {
    // Get the contract factory
    const AttendanceContract = await ethers.getContractFactory("AttendanceContract");
    console.log("Deploying AttendanceContract...");

    // Deploy the contract
    const attendanceContract = await AttendanceContract.deploy();
    console.log("Waiting for deployment...");

    console.log("attendanceContract object:", JSON.stringify(attendanceContract));
    console.log("AttendanceContract deployed to 1:", await attendanceContract.getAddress());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
