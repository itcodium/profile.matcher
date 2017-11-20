
exports.CrudRunner = function() {
	var page = require('webpage').create(),
		url = '',
		urlId = '',
		data = '',
		data_update = '',
		data_search='';
		PAGE_ERROR=0;		
		page.onConsoleMessage = function(msg) {
			console.log(msg);
		};
		
		page.onResourceReceived = function(res) {
		  if (res.stage === 'end') {
		    	//console.log('Status code: ',res.status,res.statusText,res.url);
		    	if(res.status!=200 && res.status!=401){
		    		PAGE_ERROR=1;
		    	}
		  }
		};

	 

		this.setDataSearch = function (value) {
			data_search=value;
		};
		this.getDataSearch = function (value) {
			return data_search;
		};
		this.setIdValue = function (value) {
			urlId=urlId+'/'+value
		};	
		
		this.setUrl = function (value) {
			url=value;
			urlId=value;
		};
		this.setData = function (value) {
			data=value;
		};
		this.setDataUpdate = function (value) {
			data_update=value;
		};
		
		this.delete = function (callback) {
			send(urlId,'DELETE','',callback,"- ERROR  CHECK DELETE-");
		};
		
		this.checkUpdate = function (callback) {
			send(urlId,'GET','',callback,"- ERROR  CHECK UPDATE-");
		};
		
		this.update = function (callback) {
			page.customHeaders = {"Content-Type": "application/x-www-form-urlencoded"};
			send(urlId,'PUT',data_update,callback,"- ERROR UPDATE -");
		};
		
		this.getById = function (callback) {
			send(urlId,'GET','',callback,"ERROR GetById");
		};
		
		this.get = function (callback) {
			send(url,'GET','',callback,"- ERROR GetAll - ");
		};
		
		this.post = function (callback) {
			send(url,'POST',data,callback,"POST Error ");
		};
		this.print = function (msg, value) {
			console.log(msg, value);
			console.log("--------------------------------------------------------");	
		};
		
		function send(pUrl,pMethod,pData,pCallback,pError){
			page.open(pUrl, pMethod,pData,function(status) {
				
				if (status === "success") {
						page.injectJs('./js/jquery.min.js');
						
						res=page.evaluate(function() {
							return $("body").text();
						})
						if(PAGE_ERROR==1){
							console.log(res);	
						}else{
							pCallback(res);	
						}
						
						
					} else {
						phantom.exit(1);
					}
			
			});
			
		}
}
 