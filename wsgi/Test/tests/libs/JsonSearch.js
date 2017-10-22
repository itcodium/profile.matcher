exports.JsonSearch = function(value) {
	
	var data;
	this.setData=function(value){
		if (typeof value=='string'){
			data=JSON.parse(value); 
		}else{
			if (typeof value=='object'){
				data=value; 
			}
		}
	}
	this.search = function (field,value) {
		for ( var i = 0; i < data.length; i++) {
			if(data[i][field]==value){
				return data[i];
			}
		}              	
	};

	this.toParams = function (value) {
		var parameters='';
		for (var key in value){
			if (value.hasOwnProperty(key)) {
				parameters=parameters+key + "=" + value[key]+'&';
			}
		}
		return parameters.substring(0, parameters.length - 1);  
	}
	
	this.setData(value);
		 
}
 