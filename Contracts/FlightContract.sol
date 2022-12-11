// SPDX-License-Identifier: UNLICENSED

//pragma solidity 0.8.6;
pragma solidity >=0.7.0 <0.9.0;

contract FlightContract {
    event PurchasedTicket(
        bytes32 indexed uuid,
        address airline,
        address passenger,
        uint8 seatNumber
    );
    event CancelTicket(address indexed purchaser);
    event FindGues(address indexed purchaser);

    enum FlightRunningStatus {
        SCHEDULED,
        DEPARTED,
        DELAYED,
        CANCELLED
    }
    enum FlightBookingStatus {
        PRESALE,
        SALE,
        READY,
        CLOSED,
        LANDED,
        FINALISED,
        CANCELLED
    }

    uint public _seatsRemaining;
    uint public _seatPurchaseIndex = 0;
    uint public _ticketPrice;

    address[] private _guestList;

    struct Seat {
        bytes32 uuid;
        address airline;
        address passenger;
        uint16 price;
        uint8 seatNumber;
        uint index;
    }

    mapping(address => Seat) private _flightSeatList;

    struct FlightData {
        uint8 FlightNumber;
        address Airline;
        bytes32 ScheduleData;
        bytes32 ScheduleTime;
        uint8 NoOfSeats;
        uint8 PendingSeat;
        FlightRunningStatus RunningStatus;
        FlightBookingStatus BookingStatus;
    }

    FlightData _flightData;

    constructor(
        address _airlineAddress,
        bytes32 _ScheduleData,
        bytes32 _scheduleTime,
        uint8 _flightNumber,
        uint8 _noOfSeats
    ) {
        _flightData = FlightData({
            FlightNumber: _flightNumber,
            Airline: _airlineAddress,
            ScheduleData: _ScheduleData,
            ScheduleTime: _scheduleTime,
            NoOfSeats: _noOfSeats,
            PendingSeat: _noOfSeats,
            RunningStatus: FlightRunningStatus.SCHEDULED,
            BookingStatus: FlightBookingStatus.PRESALE
        });
        _seatsRemaining = _noOfSeats;
        _guestList = new address[](_noOfSeats + 1);
    }

    function addGuestToList(
        address _bookingGuest,
        uint8 _seatNumber,
        uint8 _price
    ) public {
        _seatsRemaining--;
        _seatPurchaseIndex++;
        _guestList.push(_bookingGuest);
        _flightSeatList[_bookingGuest].uuid = "test";
        _flightSeatList[_bookingGuest].passenger = _bookingGuest;
        _flightSeatList[_bookingGuest].airline = msg.sender;
        _flightSeatList[_bookingGuest].price = _price;
        _flightSeatList[_bookingGuest].seatNumber = _seatNumber;
        _flightSeatList[_bookingGuest].index = _guestList.length - 1;

        emit PurchasedTicket(
            _flightSeatList[_bookingGuest].uuid,
            _flightSeatList[_bookingGuest].airline,
            _flightSeatList[_bookingGuest].passenger,
            _flightSeatList[_bookingGuest].seatNumber
        );
    }

    function removeGuestFromList(address _bookingAdress) public {
        Seat storage searchSeat = _flightSeatList[_bookingAdress];
        _guestList[searchSeat.index] = _guestList[_guestList.length - 1];
        _guestList.pop();
        delete _flightSeatList[_bookingAdress];
        _seatsRemaining++;
        _seatPurchaseIndex--;
    }

    function findGuestInList(
        address _bookingAddress
    ) public view returns (uint, bytes32, address, address, uint16, uint8) {
        if (!IsGuestvalid(_bookingAddress)) revert("Guest not found");
        Seat storage searchSeat = _flightSeatList[_bookingAddress];
        return (
            _flightData.FlightNumber,
            searchSeat.uuid,
            searchSeat.airline,
            searchSeat.passenger,
            searchSeat.price,
            searchSeat.seatNumber
        );
    }

    function IsGuestvalid(address _guestAddress) public view returns (bool) {
        for (uint i = 0; i < _guestList.length - 1; i++) {
            if (_guestList[i] == _guestAddress) {
                return true;
            }
        }
        return false;
    }

    /* Flight Operation*/
    
    function initiateFlight(uint8 _seatNumber,uint8 _price) public {
        _seatsRemaining = _seatNumber;
        _ticketPrice = _price;
        _flightData.RunningStatus = FlightRunningStatus.SCHEDULED;
        _flightData.BookingStatus = FlightBookingStatus.SALE; 
    }
    

    function cancelFlight() public {
        _flightData.RunningStatus = FlightRunningStatus.CANCELLED;
    }
}
