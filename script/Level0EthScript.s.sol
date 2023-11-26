// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Level0} from "../src/Level0.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract Level0EthSolution is Script {
    Level0 public level0 = Level0(0x582f5fc80A54F652F337814A21611e9950c6e609);

    function run() external {
        string memory password = level0.password();
        console.log("Password: ", password);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        level0.authenticate(password);
        vm.stopBroadcast();
    }
}
