var Sequencer = require('../libs/CallbackSequencer').Sequencer;
var crudTester= require('../libs/CrudRunner').CrudRunner; 
var jsonSearch= require('../libs/JsonSearch').JsonSearch; 
/*

var Test = function(data) {
	

	var dataUpdate={	modulo:"test_mod",
						vigencia_desde:'2022-01-01 00:00:00',
						vigencia_hasta:'2022-01-01 00:00:00',
						modificado_por:"test_mod"};

	var tokenParam='uuid='+localStorage.getItem("uuid")
	var urlById=url;
	var searchValue='';

	var sequencer=new Sequencer();
	var json=new jsonSearch();
	var crud=new crudTester();
	
	crud.setDataSearch(data.modulo);

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
			console.log("crud.getDataSearch()",crud.getDataSearch());
			var reg=json.search('modulo', crud.getDataSearch());					
			urlById=url+'/'+reg["id_modulo"]+'?'+tokenParam
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
			crud.setDataSearch(dataUpdate.modulo);
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

	
	sequencer.addFunction(fnPost);
	sequencer.addFunction(fnGetAll);
	sequencer.addFunction(fnSetUrlId);
	sequencer.addFunction(fnGetById);
	sequencer.addFunction(fnUpdate);
	sequencer.addFunction(fnGetAll);
	sequencer.addFunction(fnDelete);

}
*/
var Cliente={	modulo:"Cliente",
			vigencia_desde:'2016-06-01 00:00:00',
			vigencia_hasta:'2018-06-01 00:00:00',
			creado_por:"dbo"};

var Usuarios={	modulo:"Usuarios",
			vigencia_desde:'2016-06-01 00:00:00',
			vigencia_hasta:'2018-06-01 00:00:00',
			creado_por:"dbo"};
var Perfiles={	modulo:"Perfiles",
			vigencia_desde:'2016-06-01 00:00:00',
			vigencia_hasta:'2018-06-01 00:00:00',
			creado_por:"dbo"};		

var Modulos={	modulo:"Modulos",
			vigencia_desde:'2016-06-01 00:00:00',
			vigencia_hasta:'2018-06-01 00:00:00',
			creado_por:"dbo"};

var PerfilesModulos={	modulo:"PerfilesModulos",
			vigencia_desde:'2016-06-01 00:00:00',
			vigencia_hasta:'2018-06-01 00:00:00',
			creado_por:"dbo"};			



var json=new jsonSearch();
var urlModulo='http://127.0.0.1:5000/api/modulo'
var urlPerfil='http://127.0.0.1:5000/api/modulo'
var tokenParam='uuid='+localStorage.getItem("uuid")


var fnPostModulo=function(data){
		var crud=new crudTester();
		crud.setUrl(urlModulo+'?'+tokenParam); 
		crud.setData(json.toParams(data));
		crud.post(function(result){
			print("POST");
			console.log(result);			
		});
	}

var fnPostPerfil=function(data){
		var crud=new crudTester();
		crud.setUrl(urlModulo+'?'+tokenParam); 
		crud.setData(json.toParams(data));
		crud.post(function(result){
			print("POST");
			console.log(result);			
		});
	}

fnPostModulo(Cliente);
fnPostModulo(Usuarios);
fnPostModulo(Perfiles);
fnPostModulo(Modulos);
fnPostModulo(PerfilesModulos);
