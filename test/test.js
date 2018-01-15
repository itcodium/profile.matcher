// var assert = require('assert');
var assert = require('chai').assert
var http = require('http');

var calc = require('./lib/calc.js');
var chatbot = require('./lib/chatbot.js');
var request = require('request');

describe('API CALL UNIT TESTING', function () {

  // GET /properties
  describe('GET /api', function () {
    it("La respuesta existe para el mensaje hello", function (done) {
      request('http://chatbot-chatbot01.7e14.starter-us-west-2.openshiftapps.com/api/chatbot?text=hello!', 
      	function (err, resp) {
		var positive = ["HELLO","HI","GREETINGS"];
		// console.log("JSON.parse(resp.body)",JSON.parse(resp.body))
		// console.log("positive.toString()",positive.toString())
		var answer=JSON.parse(resp.body);
			if(answer.status=="ERROR"){
				assert.isNotOk(positive.toString() , answer.message)
				done();
			}else{
				var index=positive.indexOf(answer.text.toUpperCase())
				assert.notEqual(-1, index,"El saludo existe.");
		        done();		
			}
        
      });
    });
  });
});
 
/*
chatbot.get(request,function(error, response, body){
				console.log("res ** ", body)
			     test();
})


describe('ChatBot', function() {
  describe('Hello!', function() {
    it('should return -a list of greetings', 
    	);
  });
});
*/


 
describe('Array', function() {
  describe('#indexOf()', function() {
    it('should return -1 when the value is not present', function(){
      assert.equal(-1, [1,2,3].indexOf(4));
    });
  });
});


describe('Calculator Tests', function() {
	it('returns 1+1=2', function(done) {
		assert.equal(calc.add(1, 1), 2);
		done();
	});

	it('returns 2*2=4', function(done) {
		assert.equal(calc.mul(2, 2), 4);
		done();
	});


});

