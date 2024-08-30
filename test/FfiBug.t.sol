// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "forge-std/Test.sol";

contract FfiBug is Test {
    function test_ffi_works_py() public {
        // printed by script 7631602904498167808
        // returned bytes by ffi 0x37363331363032393034343938313637383038
        // parsed string from bytes 7631602904498167808
        ffi_python(7631602904498167808);
    }

    function test_ffi_fails_py() public {
        // printed by script 3892671398392822131232
        // returned bytes by ffi 0x3892671398392822131232
        // parsed string from bytes 8�g�9("2
        ffi_python(3892671398392822131232);
    }

    function test_ffi_works_js() public {
        // printed by script 7631602904498167808
        // returned bytes by ffi 0x37363331363032393034343938313637383038
        // parsed string from bytes 7631602904498167808
        ffi_js(7631602904498167808);
    }

    function test_ffi_fails_js() public {
        // printed by script 3892671398392822131232
        // returned bytes by ffi 0x3892671398392822131232
        // parsed string from bytes 8�g�9("2
        ffi_js(3892671398392822131232);
    }

    function test_ffi_works_echo() public {
        uint256 value = 7631602904498167808;
        ffi_echo(vm.toString(value));
    }

    function test_ffi_fails_echo() public {
        uint256 value = 3892671398392822131232;
        ffi_echo(vm.toString(value));
    }

    function ffi_js(uint256 value) public {
        ffi("node", "test/print.js", vm.toString(value));
    }

    function ffi_python(uint256 value) public {
        ffi("python3", "test/print.py", vm.toString(value));
    }

    function ffi_echo(string memory value) public {
        ffi("echo", "-n", value);
    }

    function ffi(string memory cmd, string memory file, string memory value) public {
        string[] memory cmds = new string[](3);
        cmds[0] = cmd;
        cmds[1] = file;
        cmds[2] = value;
        bytes memory res = vm.ffi(cmds);
        console.logBytes(res);
        console.log("res", string(res));
        uint256 expectedResult = vm.parseUint(string(res));
        console.log("expectedResult", expectedResult);
    }
}
