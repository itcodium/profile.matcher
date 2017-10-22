var Sequencer = require('../libs/CallbackSequencer').Sequencer;


var test=new Sequencer();

test.addFunction(function(){
    console.log("Test 1");
});

test.addFunction(function(){
    console.log("Test 2");
});

test.addFunction(function(){
    console.log("Test 3");
});

test.addFunction(function(){
    console.log("Test 4");
});

test.executeAll();