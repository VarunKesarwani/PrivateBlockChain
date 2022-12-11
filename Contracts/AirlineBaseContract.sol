// SPDX-License-Identifier: UNLICENSED

//pragma solidity 0.8.6;
pragma solidity >=0.7.0 <0.9.0;

import "./FlightContract.sol";

interface AirlineBaseContract {
    function schduleFlight(
        address _airlines,
        uint8 _flightNumber,
        bytes32 _scheduleData,
        bytes32 _scheduleTime,
        uint8 _noOfSeats
    ) external;

    function getSeatPrice(uint _seatPrice, uint8 _flightNumber) external;

    function getSeatNumbers(uint _seatNumber, uint8 _flightNumber) external;

    // Managing staus of flight
    function enableFlight( uint8 _flightNumber,uint8 _seatNumber,uint8 _seatPrice) external; // changes status from Presale to sale

    function readyFlight() external; // 24 hours before depart, cancel with penality, book at higher cost.

    function closeFlight() external; // 2 hours before departure, cannot purchase or cancel ticket

    function landFlight() external;

    function finalizeFlight() external; // after 24 hours of departure, may cancel will very minimal refund

    function concludeFlight() external; // after 24 hours of landing, final settlement to airline

    function cancelFlight() external; // full refund if before 24 hours of departure, refund plus penalty if after 24 hours

    function delayedFlight() external; // penalty based on hours of departure
}

contract EagleAirlineContract is AirlineBaseContract {
    mapping(uint16 => mapping(address => FlightContract)) _flightList;

    uint[] private _listOfFlight;


    function schduleFlight(
        address _airlines,
        uint8 _flightNumber,
        bytes32 _scheduleData,
        bytes32 _scheduleTime,
        uint8 _noOfSeats
    ) public {
        FlightContract _flight = new FlightContract(
            msg.sender,
            _scheduleData,
            _scheduleTime,
            _flightNumber,
            _noOfSeats
        );
        _flightList[_flightNumber][msg.sender] = _flight;
        _listOfFlight.push(_flightNumber);
    }

    function enableFlight( uint8 _flightNumber,uint8 _seatNumber,uint8 _seatPrice) public{
        // validate if flight number exit in _listOfFlight array
        FlightContract _flightData = _flightList[_flightNumber][msg.sender];
        _flightData.initiateFlight(_seatNumber,_seatPrice);

    }

    function cancelFlight(uint8 _flightNumber) public {
        // validate if flight number exit in _listOfFlight array
        //require(msg.sender == _owner, "Only the owner may perform this action");
        FlightContract _flightData = _flightList[_flightNumber][msg.sender];
        _flightData.cancelFlight();
    }
}
