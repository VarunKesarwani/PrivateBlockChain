// SPDX-License-Identifier: UNLICENSED

//pragma solidity 0.8.6;
pragma solidity >=0.7.0 <0.9.0;

contract FlightContract {
    enum FlightStatus {
        SCHEDULED,
        DEPARTED,
        DELAYED,
        CANCELLED
    }
    address[] _guestList;
    struct FlightData {
        string flightNumber;
        string ScheduleData;
        string scheduleTime;
        uint8 noOfSeats;
        FlightStatus flightStatus;
    }

    FlightData _flightData;

    constructor(address _initiator, bytes32 _initiator_hash) {}
}

contract AirlineBaseContract {
    mapping(address => mapping(address => FlightContract)) _flight;
    enum FlightStatus {
        Presale,
        Sale,
        Closed,
        Landed,
        Finalised,
        Cancelled
    }
    struct Seat {

        bytes32 uuid;
        address owner;
        address passenger;
        uint price;
        FlightContract flightContract;
    }

    Seat[] public _seats;
}
