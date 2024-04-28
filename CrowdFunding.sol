//SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract CrowdFunding{

    address public owner; 
    uint public goal; 
    uint timePreiod; 
    uint public minimumCon;
    uint public fundRaised;

    mapping(address => uint) public funders; 
    uint public numberOfFunders; 

    constructor(uint _goal, uint _time){
        owner = msg.sender; 
        goal = _goal; 
        timePreiod = block.timestamp + _time;
        minimumCon = 1000 wei; 

    }

    modifier isOwner(){
        require(msg.sender == owner, "You are not a owner to perform this");
        _;
    }

    function Contribute()public payable{
        require(msg.sender != owner, "Owner are not eligible to contribute"); 
        require(block.timestamp < timePreiod, "Crowdfunding is closed already");
        require(msg.value >= minimumCon, "Minimum contribution is 1000 wei");

        if(funders[msg.sender] == 0){
            numberOfFunders++;
        }

        fundRaised += msg.value;
        funders[msg.sender] = msg.value;

    }

    function GetRefund() public payable {
        require(funders[msg.sender] > 0, "You are not a funder");
        require(block.timestamp > timePreiod, " Still collecting funds");
        require(fundRaised > goal, "Crowdfunding was successful");

        funders[msg.sender] = 0;
        fundRaised-=funders[msg.sender];
        numberOfFunders--;

    }

    struct Request{
        string description; 
        uint spendingAmount; 
        address payable receiver; 
        mapping (address => bool ) votes;
        uint totalVote;
        bool completed;  

    }

    mapping (uint => Request) public allRequest; 
    uint indexRequest; 

    function CreateRequest(string memory _des, uint _amt, address payable _rcv) public isOwner{

        require(block.timestamp > timePreiod, "Funding is still on");

        Request storage newRequest = allRequest[indexRequest];
        indexRequest++;
        newRequest.description = _des;
        newRequest.spendingAmount = _amt;
        newRequest.receiver = _rcv;
        newRequest.completed = false; 
        newRequest.totalVote = 0;

    }

    function VotingProcess(uint _index) public {
        require(msg.sender != owner, "Owner can not vote for a request.");
        require(funders[msg.sender] > 0, "You are not a funder");

        Request storage theRequest = allRequest[_index];
        require(theRequest.completed == false, "The voting for this has been closed");
        require(theRequest.votes[msg.sender] == false, "You already have voted for this");

        theRequest.totalVote++;
        theRequest.votes[msg.sender] = true;



    }

    event MoneySent(address _to, uint _amt, string _des);

    function MakePayment(uint _index) public payable isOwner {
        
        Request storage theRequest = allRequest[_index];
        require(theRequest.completed == false, "This request has been completed successfully");
        require(theRequest.spendingAmount <= fundRaised, "Not enough money raised to send money for this cause");
        require(theRequest.totalVote > numberOfFunders /2, "Vote was not in favour");

        payable (theRequest.receiver).transfer(theRequest.spendingAmount);
        fundRaised -= theRequest.spendingAmount;

        emit MoneySent(theRequest.receiver, theRequest.spendingAmount, theRequest.description);


    }

}