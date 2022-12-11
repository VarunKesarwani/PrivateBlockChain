// SPDX-License-Identifier: UNLICENSED

//pragma solidity 0.8.6;
pragma solidity >=0.7.0 <0.9.0;

interface TransactionBaseContract {
    // Customer Specific functions
    function book(address _guessAdress, uint8 _seatNumber) external payable;
    function cancelBooking(address _guestAdress) external payable;
    function requestRefund(address guest) external;
    function settleFlight(address airline) external;


    function getSeatByUuid(bytes32 uuid) external view returns(uint, bytes32, address, address, uint);
    function getOwnerBySeatNo(address airline, uint8 _flightNumber, uint8 _seatNumber) external;

    
    function getFlightStatus(uint8 _flightNumber) external;
    function getPrice(uint8 _flightNumber) external;
    function getPendingSeat(uint8 _flightNumber) external;
}

contract TransactionContract {
    constructor (){

    }

}
