// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

contract AttendanceContract {
    struct ShiftRecord {
        uint256 shiftId;
        address employee;
        string clockInTime;
        string clockOutTime;
        string duration;
    }

    mapping(uint256 => ShiftRecord) public shiftRecords;
    uint256 public shiftCounter;

    event ShiftClockedIn(uint256 shiftId, address indexed employee, string clockInTime);
    event ShiftClockedOut(uint256 shiftId, string clockOutTime, string duration);

    function recordClockIn(string memory _clockInTime) public {
        shiftCounter++;
        shiftRecords[shiftCounter] = ShiftRecord({
            shiftId: shiftCounter,
            employee: msg.sender,
            clockInTime: _clockInTime,
            clockOutTime: "",
            duration: ""
        });
        emit ShiftClockedIn(shiftCounter, msg.sender, _clockInTime);
    }

    function recordClockOut(uint256 _shiftId, string memory _clockOutTime, string memory _duration) public {
        require(shiftRecords[_shiftId].employee == msg.sender, "You are not the owner of this shift.");
        require(bytes(shiftRecords[_shiftId].clockOutTime).length == 0, "Shift already clocked out.");

        shiftRecords[_shiftId].clockOutTime = _clockOutTime;
        shiftRecords[_shiftId].duration = _duration;

        emit ShiftClockedOut(_shiftId, _clockOutTime, _duration);
    }

    function getShiftRecord(uint256 _shiftId) public view returns (ShiftRecord memory) {
        return shiftRecords[_shiftId];
    }
}
