// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
// see CrowdFunding.txt for the scenario description

interface ICrowdFunding {
    // current status
    enum Status {Fundraising, Fail, Successful}

    // declare events
    event LogProjectInitialized(address  _owner, string _name, string _website, 
    uint _minimumToRaise, uint _durationProjects);
    event ProjectSubmitted(address addr,string name, string url, bool initialized);
    event LogFundingReceived(address addr, uint amount, uint currentTotal);
    event LogProjectPaid(address projectAddress, uint amount, Status status);
    event Refund(address _to, uint amount);
    event LogError(address addr, uint amount);

    // types:

    // Fund contributors
    struct Contribution {
        address payable  addr;
        uint amount;
    }

    // project:
    struct Project {
        address payable  addr;
        string name;
        string website;
        uint totalRaised;
        uint minimumToRaise;
        uint currentBalance;
        uint deadline;
        uint completedAt;
        Status status;
    }

}

 
contract CrowdFunding is ICrowdFunding {
    Project public project;
    Contribution[] public contributions;
    mapping(address => uint) contributionMap;
    

    // constructor
    constructor(
        address _owner, uint _minimumToRaise, uint _durationProjects, string memory _name, string memory _website )  payable {
        uint minimumToRaise = _minimumToRaise * 1 ether; // convert to smallest unit - Wei
        uint dealineProjects = block.timestamp + _durationProjects * 1 seconds;
        project = Project(payable(_owner), _name, _website, 0, minimumToRaise, 0, dealineProjects, 0, Status.Fundraising);
        emit LogProjectInitialized(_owner, _name, _website, minimumToRaise, _durationProjects);

    }

    // modifiers
    

    // check if the project is at the required stage
    modifier atStage(Status _stage) {
        require(project.status == _stage, "Only matched status is allowed.");
        _;
    }
    // only owner is inside msg.sender
    modifier onlyOwner() {
        require(msg.sender == project.addr, "only owner is allowed");
        _;
    }

    // check iff after deadline
    modifier afterDeadline() {
        require(block.timestamp >= project.deadline);
        _;
    }

    // wait for 6 hour after campain completed
    modifier atEndOfCampain() {
        require(!(  (project.status == Status.Fail || project.status == Status.Successful) 
        && project.completedAt + 6 hours < block.timestamp ));
        _;
    }

    // function () public payable {
    //     revert();
    // }
    // https://ethereum-blockchain-developer.com/028-fallback-view-constructor/02-receive-fallback-function/

    // the default fallback function is called whenever someone sends funds to the contract
    function fund() public atStage(Status.Fundraising) payable {
        assert(contributionMap[msg.sender] + msg.value >= contributionMap[msg.sender]);
        contributionMap[msg.sender] += contributionMap[msg.sender] + msg.value;
        contributions.push(
            Contribution({
                addr: payable(msg.sender),
                amount: msg.value
            })
        );
        project.totalRaised += msg.value;
        project.currentBalance = project.totalRaised;
        emit LogFundingReceived(msg.sender, msg.value, project.totalRaised);
    }

    receive() external payable {
        fund();
    }

    function checkSetGoalReached() public onlyOwner afterDeadline {
        require(project.status == Status.Fundraising);
        if (project.totalRaised >= project.minimumToRaise) {
            // project success
            project.addr.transfer(project.totalRaised);
            project.status = Status.Successful;
            emit LogProjectPaid(project.addr, project.totalRaised, project.status);
        } else {
            // project fundraising has failed, so refund each contributors
            for (uint256 index = 0; index < contributions.length; index++) {
                // use withdrawal like pattern
                uint amountToRefund = contributions[index].amount;
                contributions[index].amount = 0;
                if (!contributions[index].addr.send(amountToRefund)) {
                    // error when attempting to refund
                    contributions[index].amount = amountToRefund;
                    emit LogError(contributions[index].addr, contributions[index].amount);
                    revert();
                } else {
                    // send was successful
                    project.totalRaised -= amountToRefund;
                    project.currentBalance = project.totalRaised;
                    emit Refund(contributions[index].addr, amountToRefund);
                }


            }

        }
        project.completedAt = block.timestamp;
    }

    function destroy() public onlyOwner atEndOfCampain {
        selfdestruct(payable (msg.sender));
    }


}
