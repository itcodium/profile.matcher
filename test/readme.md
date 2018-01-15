#Install Mocha Globally

	npm install mocha
	
#Create a project	

	- create file test.js
	- initialize project 
		npm init
			
			test command: mocha
			
			test
			|-- test.js
			|-- package.json
					
						"scripts": {
						  "test": "mocha"
						 },
	
#Writing our first test						 

	var assert = require('assert');
	describe('Array', function() {
	  describe('#indexOf()', function() {
		it('should return -1 when the value is not present', function(){
		  assert.equal(-1, [1,2,3].indexOf(4));
		});
	  });
	});

	- npm test
	
	
#mochawesome

	Ref: https://github.com/adamgruber/mochawesome

	
##Usage

1. Add Mochawesome to your project:

	npm install --save-dev mochawesome

2. Tell mocha to use the Mochawesome reporter:

	mocha test.js --reporter mochawesome

3. If using mocha programatically:
	var mocha = new Mocha({
	  reporter: 'mochawesome'
	});

#Output

	Mochawesome generates the following inside your project directory:

#Test request 

	ref: https://codeutopia.net/blog/2015/01/30/how-to-unit-test-nodejs-http-requests/
	
	npm install mocha sinon








