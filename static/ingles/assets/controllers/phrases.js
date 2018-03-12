 
var PhrasesModule = (function () {
    var PageText = {
        "category" : "Categoria",
        "us" : "US",
        "es" : "ES",
        "meaning" : "Significado",
        "addTitle":"Agregar texto",
        "editTitle":"Editar texto",
        "deleteTitle":"Borrar texto",
        "emptyList":"No se encontraron registros."
    };

    
    var validate = new FormValidations();
    function PhrasesBase($scope, AppServiceCaller, AplicationText) {
        $scope.pageText = PageText;
        $scope.AplicationText = AplicationText;

    };
 
    this.PhrasesList = function ($scope, $route,$filter,$location,$route, AppServiceCaller, AplicationText) {
        PhrasesBase.call(this, $scope, AppServiceCaller, AplicationText);
        var apiF = new ApiCaller();
            apiF.apiName="phrases";
            apiF.setCaller(AppServiceCaller);

        $scope.title = "Listado de phrases"
        $scope.modalEdit = new ModalTemplate();
        $scope.modalEdit.setItems($scope.models);

        
        $scope.modalEdit.modal_name = "editPhrases";
        $scope.modalEdit.key_id = "_id";
        $scope.modalEdit.template = { src: "assets/pages/phrases/phrases.html" };
        $scope.modalEdit.pageText = $scope.pageText;
        $scope.modalEdit.AplicationText = AplicationText;
 
        $scope.modalEdit.submit = function (form) {
            this.form = form;
            if (form.$valid) {
                if (this.method == "EDIT") {
                    apiF.apiName="phrases";
                    apiF.put($scope.modalEdit.model._id.$oid, $scope.modalEdit.model, Put_callBack);
                }
                if (this.method == "DELETE") {
                    apiF.delete($scope.modalEdit.model._id.$oid, Delete_callBack);
                }
                if (this.method == "ADD") {
                    $scope.modalEdit.model.creado_por="test"
                    apiF.post($scope.modalEdit.model, Post_callBack);
                }
            }
        }
     
            
        $scope.modalEdit.category="test";// $location.search();
        $scope.modalEdit.model={};
        $scope.modalEdit.model.category="Test";//$location.search().category;
        $scope.modalEdit.categories=JSON.parse(localStorage.getItem("categories"));
        
        
 
        console.log("--------------------------------------------")
        console.log("$scope.modalEdit.categories",typeof $scope.modalEdit.categories,$scope.modalEdit.categories)
        console.log("--------------------------------------------")

        apiF.setScope($scope);
        apiF.get($location.search(),Get_callBack);

        function Get_callBack(res) {
            console.log("Get_callBack", res)
            $scope.modalEdit.items = res.data;
            /*
            var apiCategories = new ApiCaller();
            apiCategories.apiName="categories";
            apiCategories.setCaller(AppServiceCaller);
            apiCategories.get({},$scope.GetCategorias_callBack);
            */
        }
        $scope.GetCategorias_callBack= function(res) {
            $scope.modalEdit.categories = res.data;
        }

        function Put_callBack (res) {
                console.log(" Put_callBack res",_this)
                var lScope=_this.getScope();
                if (!_this.isError(res)) {
                    if (res.status != 200) {
                        alert(res.message);
                    } else {
                        console.log(" Put_callBack res",_this)
                        _this.get($location.search(),Get_callBack);
                        lScope.modalEdit.hide();
                    }
                }
            
        }
        function Post_callBack  (res) {
             console.log("Post_callBack", _this.getScope())
            var lScope=_this.getScope();
            if (!_this.isError(res)) {
                if (res.status != 200) {
                    alert(res.message);
                } else {
                    lScope.modalEdit.items.push(lScope.modalEdit.model)
                    lScope.modalEdit.hide();
                    _this.get($location.search(),Get_callBack);
                        
                    
                }
            }
        }
        var Delete_callBack = function (res) {
            console.log("Delete_callBack", _this.getScope())
            var lScope=_this.getScope();
            if (!_this.isError(res)) {
                if (res.status != 200) {
                    alert(res.message);
                } else {
                    lScope.modalEdit.hide();
                    _this.get($location.search(),Get_callBack);
                }
            }
        }
            
    };
    return {
        PhrasesListController: this.PhrasesList
    };

})();


app.controller('controllerPhrasesList', ["$scope", "$route", "$filter","$location","$route", "AppServiceCaller", "AplicationText", PhrasesModule.PhrasesListController])
