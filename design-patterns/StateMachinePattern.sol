pragma solidity >= 0.7.0;

// State machine pattern
/*
SCENARIO: dish washing steps are :
step 1: scrub
step 2: rinse
step 3: dry
step 4: cleanup
*/

contract DishWasher {
    enum Stages {
        INIT,SCRUB, RINSE, DRY,CLEANUP
    }
    Stages public stage = Stages.INIT;
    modifier atStage(Stages _stage){
        require(stage == _stage, "stage is the required stage");
        _;
    }
    function nextStage() internal {
        stage = Stages(uint(stage) + 1);
    }
    modifier transitionNext() {
        _;
        nextStage();
    }
    function scrub() public atStage(Stages.INIT) transitionNext {
        // implement scrubing here
    }
    function rinse() public atStage(Stages.RINSE) transitionNext {
        // do rinse logic
    }

    function dry() public atStage(Stages.DRY) transitionNext {
        // do dry stage here
    }
    function clenup() public view atStage(Stages.CLEANUP) {
        // do cleanup
    }
}