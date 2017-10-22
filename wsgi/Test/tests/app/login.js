var Sequencer = require('../libs/CallbackSequencer').Sequencer;
var crudTester= require('../libs/CrudRunner').CrudRunner; 


localStorage.setItem("url","http://127.0.0.1:5000/")
localStorage.getItem("url")
var Test = function() {
	var sequencer=new Sequencer();
	var crud=new crudTester();
	
	var urlLogin='http://127.0.0.1:5000/api/login'
	var print=function(){
		console.log("-----------------------------",sequencer.getLength(),"---------------------------------\n");	
	}
	
	var fnLogin_ok=function(result){
			crud.setUrl(urlLogin); 
			crud.setData('usuario=admin&password=123123');
			crud.post(callback_login_ok)
		}
	var fnLogin_NoValid_UserPassword=function(result){
			crud.setUrl(urlLogin); 
			crud.setData('usuario=novalid&password=xxss123');
			crud.post(callback_NoValid_UserPassword);
		}		

	var callback_login_ok=function(result){
		console.log("result",result);
		var token=JSON.parse(result)
			localStorage.setItem("uuid", token[0].uuid);
			print();
			next();
	}

	var callback_NoValid_UserPassword=function(result){
			console.log(result);
			print();
			console.log(result);
			next();
	}

	sequencer.addFunction(fnLogin_ok);
	sequencer.addFunction(fnLogin_NoValid_UserPassword);


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

var test=new Test();
 	test.run();
 	
 


