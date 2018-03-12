var API_METHOD = {
    ADD: "ADD",
    EDIT: "EDIT",
    DELETE: "DELETE"
}

 var ApiCaller=function () {
     
    this.params={};
    this.apiName="";
    var scope={};
    // this.scope={};
    _this=this;
    this.setScope=function(param){
        scope=param;
        // this.scope=param;
        //_this.scope=param;
    }
    this.getScope=function(){
        return scope;
    }

    this.setCaller = function (param) {
        if (typeof this.caller == 'undefined') {
            this.caller = param;
        }
    }
    this.error = function (res) {
        alert("Error")
        console.log("error", res)
    }
    this.isError = function (res) {
        console.log("isError -> ", res)   
        var result = false;
        if (res.data.status.toUpperCase() == "ERROR") {
            alert("Error:  "+ res.data.message)
            result = true;
        }
        return result;
    }
    
    this.get = function (params,callback) {
        console.log("GET", _this.apiName)
        _this.params=params;
       this.caller.get(APP_API.getUrl(_this.apiName), _this.params)
            .then(callback, this.error)
    }
    this.getById = function (id,params,callback) {
        _this.params=params;
        _this.id=id;

        this.caller.get(APP_API.getUrl(_this.apiName, _this.id), _this.params)
            .then(callback, this.error)
    }
    
    this.put = function (id,data,callback) {
        console.log("PUT", _this.apiName)
        var url=APP_API.getUrl(_this.apiName, id);
        this.caller.put(url, data)
            .then(callback, this.error)
    }

    
    this.post = function (data, callback) {
        console.log("POST", _this.apiName)
        var url=APP_API.getUrl(_this.apiName);
        this.caller.post( url, data)
            .then(callback, this.error)
    }
   
    this.delete = function (id, callback) {
        console.log("DELETE", _this.apiName)
        var url=APP_API.getUrl(_this.apiName, id);
        this.caller.delete(url, {})
            .then(callback, this.error)
    }
    



    /*
    this.Get_callBack=function(res) {
        console.log("_this.scope",_this.scope)
        _this.scope.modalEdit.items = res.data;
    }
    this.Put_callBack=function(res) {
        console.log("Put_callBack -> ",res)
        if (!_this.isError(res)) {
            if (res.status != 200) {
                alert(res.message);
            } else {
                scope.modalEdit.hide();
                if(typeof _this.params=='undefined'){
                    _this.get();    
                }else{
                    _this.get(_this.params);
                }
                
            }
        }
    }
    this.Post_callBack = function (res) {
        if (!_this.isError(res)) {
            if (res.data.status != 'OK') {
                alert(res.message);
            } else {
                scope.modalEdit.items.push(scope.modalEdit.model)
                scope.modalEdit.hide();
                _this.get();
            }
        }
    }


    this.Delete_callBack = function (res) {
        if (!_this.isError(res)) {
            if (res.status != 200) {
                alert(res.message);
            } else {
                scope.modalEdit.hide();
                _this.get();
            }
        }
    }
    */
};

