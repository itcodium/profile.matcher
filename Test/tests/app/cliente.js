var Sequencer = require('../libs/CallbackSequencer').Sequencer;
var crudTester= require('../libs/CrudRunner').CrudRunner; 
var jsonSearch= require('../libs/JsonSearch').JsonSearch; 

localStorage.setItem("uuid",'gAAAAABXuk-oIAJMfYR6YiRFNZUFaaUT5Q0sus2ESlzIUTYB0Edn52KT5D23FzjGMItIFJPb8HBy4EB6tMhOd8uiVNr5ZywPtbhTjp-S9Ur3wVEBlGW7DxxeAMElKGq6TxKwb-wltXNh')
// localStorage.getItem("uuid")

var Test = function() {
	
	var sequencer=new Sequencer();
	var crud=new crudTester();
	var json=new jsonSearch();
	
	//console.log("localStorage.getItem(uuid)",localStorage.getItem("uuid"));
	// console.log("*** Token -> ",localStorage.getItem("uuid"));

	var url='http://127.0.0.1:5000/api/cliente'
	var tokenParam='uuid='+localStorage.getItem("uuid")
	var urlById=url;
	var searchValue='';
	
	var cliente={nombre:'Test PHANTOM',codigo:'PHATEST', habilitado:1};
	var clienteUpdate={nombre:'test_update', habilitado:0, codigo:'phantom_update',modificado_por:'phantom_update'};
	
	
	var fnPost=function(){
			console.log("POST",url+'?'+tokenParam);
			crud.setUrl(url+'?'+tokenParam); 
			crud.setData(json.toParams(cliente)); //'nombre='+cliente.nombre+'&codigo='+cliente.codigo+'&habilitado='+cliente.habilitado
			crud.post(function(result){
				console.log(result);			
				next();
			});
		}
	var fnGetAll=function(){
			crud.setUrl(url+'?'+tokenParam); 
			crud.get(function(result){
				print("GetAll");
				console.log(result); 
				json.setData(result);
				next();
			});
		}

	var fnSetUrlId=function(){
		print("SetUrlId");
		try{
			var reg=json.search('codigo', crud.getDataSearch());					
			urlById=url+'/'+reg["id_cliente"]+'?'+tokenParam
			console.log(urlById); 
			next();
		}catch (e) {
		   console.log(e); 
		   phantom.exit(1);
		}

	}

	var fnGetById=function(){
			crud.setUrl(urlById); 
			crud.get(function(result){
				print("GetById");
				console.log(result);
				next();			
			});
		}
	var fnUpdate=function(){
			crud.setUrl(urlById); 
			crud.setDataUpdate(json.toParams(clienteUpdate));
			crud.setDataSearch(clienteUpdate.codigo);
			crud.update(function(result){
				print("UPDATE");
				console.log(result);
				next();			
			});
		}
		
	var fnDelete=function(){
			crud.setUrl(urlById); 
			crud.delete(function(result){
				print("Delete");
				console.log(result);
				next();			
			});
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

	var print=function(p){
		console.log('\n',p,"----------",sequencer.getLength(),"---------------------------------\n");	
	}

	crud.setDataSearch(cliente.codigo);	
	sequencer.addFunction(fnPost);
	sequencer.addFunction(fnGetAll);
	sequencer.addFunction(fnSetUrlId);
	sequencer.addFunction(fnGetById);
	sequencer.addFunction(fnUpdate);
	sequencer.addFunction(fnGetAll);
	sequencer.addFunction(fnDelete);
	
}

var test=new Test();
 	test.run();
 

 