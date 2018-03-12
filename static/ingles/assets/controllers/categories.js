 
var CategoriesModule = (function () {
    var PageText = {
        "category": "Categoria",
        "description": "Descripcion",
        "addTitle":"Agregar Categoria",
        "editTitle":"Editar Categoria",
        "deleteTitle":"Borrar Categoria"
    };

    
    var validate = new FormValidations();
    function CategoriesBase($scope, AppServiceCaller, AplicationText) {
        $scope.pageText = PageText;
        $scope.AplicationText = AplicationText;
    };

    this.CategoriesList = function ($scope, $route,$filter,$route, AppServiceCaller, AplicationText) {
        CategoriesBase.call(this, $scope, AppServiceCaller, AplicationText);
        var api = new ApiCaller();
            api.apiName="categories";
            api.setCaller(AppServiceCaller);

        $scope.title = "Listado de categorias"
        $scope.modalEdit = new ModalTemplate();
        $scope.modalEdit.setItems($scope.models);
        
        $scope.modalEdit.modal_name = "editCategories";
        $scope.modalEdit.key_id = "_id";
        $scope.modalEdit.template = { src: "assets/pages/categories/categories.html" };
        $scope.modalEdit.pageText = $scope.pageText;
        $scope.modalEdit.AplicationText = AplicationText;

        $scope.modalEdit.submit = function (form) {
            this.form = form;

            if (form.$valid) {
                if (this.method == "EDIT") {
                    api.put($scope.modalEdit.model._id.$oid, $scope.modalEdit.model,Put_callBack);
                }
                if (this.method == "DELETE") {
                    api.delete($scope.modalEdit.model._id.$oid, Delete_callBack);
                }
                if (this.method == "ADD") {
                    $scope.modalEdit.model.creado_por="test"
                    api.post($scope.modalEdit.model,Post_callBack);
                }
            }
        }

        api.setScope($scope);
        api.get({},Get_callBack);

        function Get_callBack(res) {
            localStorage.setItem("categories",JSON.stringify(res.data));
            $scope.modalEdit.items = res.data;
        }
         function Put_callBack(res) {
            var lScope=_this.getScope();
            if (!api.isError(res)) {
                if (res.status != 200) {
                    alert(res.message);
                } else {
                    _this.get({},Get_callBack);
                    lScope.modalEdit.hide();
                }
            }
            
        }
        var Post_callBack = function (res) {
            console.log("Post_callBack", _this.getScope())
            var lScope=_this.getScope();
            if (!api.isError(res)) {
                if (res.status != 200) {
                    alert(res.message);
                } else {
                    lScope.modalEdit.items.push(lScope.modalEdit.model)
                    lScope.modalEdit.hide();
                    _this.get({},Get_callBack);
                }
            }
        }
        var Delete_callBack = function (res) {
            console.log("Delete_callBack", _this.getScope())
            var lScope=_this.getScope();
            if (!api.isError(res)) {
                if (res.status != 200) {
                    alert(res.message);
                } else {
                    lScope.modalEdit.hide();
                    _this.get({},Get_callBack);
                }
            }
        }
    };

 
    return {
        CategoriesListController: this.CategoriesList
    };

})();

                
app.controller('controllerCategoriesList', ["$scope", "$route", "$filter","$route", "AppServiceCaller", "AplicationText", CategoriesModule.CategoriesListController])



 


