var Sequencer = require('../libs/CallbackSequencer').Sequencer;
var crudTester= require('../libs/CrudRunner').CrudRunner; 
var jsonSearch= require('../libs/JsonSearch').JsonSearch; 


var Test = function() {
	
	var sequencer=new Sequencer();
	var crud=new crudTester();
	var json=new jsonSearch();
	
	var url='http://127.0.0.1:5000/api/perfilModulo'
	var tokenParam='uuid='+localStorage.getItem("uuid")
	var urlById=url;
	var searchValue='';

	var data={	id_perfil:3,
				id_modulo:47,
				creado_por:"Test_Mod_Per"};

	var dataUpdate={	id_perfil:3,
						id_modulo:47,
						modificado_por:"Test_Mod_Per" };

	var fnPost=function(){
			crud.setUrl(url+'?'+tokenParam); 
			crud.setData(json.toParams(data));
			crud.post(function(result){
				print("POST");
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
			var reg=json.search('creado_por', crud.getDataSearch());
			urlById=url+'/'+reg["id_perfil_modulo"]+'?'+tokenParam
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
			crud.setDataUpdate(json.toParams(dataUpdate));
			crud.setDataSearch(dataUpdate.creado_por);
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

	crud.setDataSearch(data.creado_por);	
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
 

 