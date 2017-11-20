// localStorage.clear();
// console.log("UUID",localStorage.getItem("uuid"))

/*  
	var callBackFin=function (result){
		var res=JSON.parse(result)
			//console.log("FIN Token",res[0].expiration,res[0].uuid);
			localStorage.setItem("uuid", res[0].uuid);
			console.log("FIN Token",localStorage.getItem("uuid"));
	}
*/


var Sequencer = require('../libs/CallbackSequencer').Sequencer;
var crudTester= require('../libs/CrudRunner').CrudRunner; 

var Test = function() {
	var sequencer=new Sequencer();
	var client=new crudTester();
	
	var urlNotoken='http://127.0.0.1:5000/api/cliente'
	var urlTokenVacio=urlNotoken+'?uuid=';
	var urlTokenNoValido=urlNotoken+'?uuid=2344234fsdfsdf3243';
	var urlTokenExpirado=urlNotoken+'?uuid=8084d8c4-2b79-11e6-a94e-c04a00011902';
	var urlTokenOk=urlNotoken+'?uuid=a223e322-3657-11e6-a49b-c04a00011902';

	
	var noToken=function(){
			client.setUrl(urlNotoken); 
			client.get(callback_result)
		}
	var tokenVacio=function(){
			client.setUrl(urlTokenVacio); 
			client.get(callback_result)
		}
	var tokenNoValido=function(){
			client.setUrl(urlTokenNoValido); 
			client.get(callback_result)
		}
	var tokenExpirado=function(){
			client.setUrl(urlTokenExpirado); 
			client.get(callback_result)
		}		
	var tokenOk=function(){
			client.setUrl(urlTokenOk); 
			client.get(callback_result)
		}	

	sequencer.addFunction(noToken);
	sequencer.addFunction(tokenVacio);
	sequencer.addFunction(tokenNoValido);
	sequencer.addFunction(tokenExpirado);
	sequencer.addFunction(tokenOk);
	
	
	var callback_result=function(result){
		console.log("-----------------------------",sequencer.getLength(),"---------------------------------\n");	
		console.log(result);	
		next();
	}

	this.run=function(){
		sequencer.execute();
	}
	var next=function(){
		if(sequencer.getLength()==0){
			phantom.exit(1);	
		}else{
			sequencer.execute();	
		}
	}
}

var testToken=new Test();
 	testToken.run();
 


