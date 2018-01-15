/*
var http = require('http');
 
module.exports = {
	
	get: function(callback) {
		var req = http.request({
			hostname: 'http://chatbot-chatbot01.7e14.starter-us-west-2.openshiftapps.com',
			path: '/api/chatbot?text=hello'
		}, function(response) {
			var data = '';
			response.on('data', function(chunk) {
				data += chunk;
			});
 
			response.on('end', function() {
				callback(null, JSON.parse(data));
			});
		});
 
		req.end();
	}

			 
 
};
*/
/*

var request = require('request')
  , async   = require('async');

function getProfile(username, cb){
  async.waterfall([
    function(callback){
      request.get('http://chatbot-chatbot01.7e14.starter-us-west-2.openshiftapps.com/api/chatbot?text=hello', 
      		function(err, response, body){
        		if (err) return callback(err);
        		callback(null, body);
      });
    }
  ], cb)
}

module.exports = getProfile;
getProfile('bulkan', function(error,result){
  	console.log(result);
});

*/