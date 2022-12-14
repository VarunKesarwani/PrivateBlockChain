// SPDX-License-Identifier: UNLICENSED

//pragma solidity 0.8.6;
pragma solidity >=0.7.0 <0.9.0;

import "./AirlineBaseContract.sol";

interface TransactionBaseContract {
    function addAirline() external;
    // Customer Specific functions
    function book(address _guessAdress, uint8 _seatNumber, uint8 _flightNumber,address _airline) external payable;
    function cancelBooking(address _guestAdress) external payable;
    function requestRefund(address guest) external;
    //function settleFlight(address airline) external;


    function getSeatByUuid(bytes32 uuid) external view returns(uint, bytes32, address, address, uint);
    function getOwnerBySeatNo(address airline, uint8 _flightNumber, uint8 _seatNumber) external;

    
    function getFlightStatus(uint8 _flightNumber) external;
    function getPrice(uint8 _flightNumber) external;
    function getAvailableSeat(uint8 _flightNumber) external;
    function getPendingSeat(uint8 _flightNumber) external;
}

contract TransactionContract {
    //mapping(bytes32 => mapping(address)) _airlineList;
    constructor (){
        
    }
    function addAirline(address airline,bytes32 Name) public{
        // _airlineList. 
    }

    function book(address _guessAdress, uint8 _seatNumber, uint8 _flightNumber,address _airline) public{
        // look inside _airlineList

    }

}
