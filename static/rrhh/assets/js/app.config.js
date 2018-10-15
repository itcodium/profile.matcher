 

// Configuración de las rutas


function onlyLoggedIn(){
    console.log("LOG?",localStorage.getItem("uuid"))
    if(localStorage.getItem("uuid")=="null" || localStorage.getItem("uuid")==""){
        window.location = "login.html";
    }
}
app.config(function ($routeProvider) {

    $routeProvider
        .when('/', {
            templateUrl: 'assets/pages/home.html',
            controller: 'mainController',
            resolve:{loggedIn:onlyLoggedIn}
        })
         .when('', {
             templateUrl: 'assets/pages/home.html',
             controller: 'mainController',
             resolve:{loggedIn:onlyLoggedIn}
         })
        .when('/admin/user', {
            templateUrl: 'assets/pages/admin/users/user.html',
            controller: 'userController',
            resolve:{loggedIn:onlyLoggedIn}
        })
         .when('/admin/edituser', {
             templateUrl: 'assets/pages/admin/users/edituser.html',
            controller: 'edituserController',
            resolve:{loggedIn:onlyLoggedIn}
        })
         .when('/admin/perfil', {
             templateUrl: 'assets/pages/admin/perfiles/perfil.html',
            controller: 'perfilController',
            resolve:{loggedIn:onlyLoggedIn}
        })
         .when('/admin/editperfil', {
             templateUrl: 'assets/pages/admin/perfiles/editperfil.html',
            controller: 'editperfilController',
            resolve:{loggedIn:onlyLoggedIn}
        })
        .when('/admin/modulo', {
            templateUrl: 'assets/pages/admin/modulos/modulo.html',
            controller: 'moduloController',
            resolve:{loggedIn:onlyLoggedIn}
        })
         .when('/admin/editmodulo', {
             templateUrl: 'assets/pages/admin/modulos/editmodulo.html',
            controller: 'editmoduloController',
            resolve:{loggedIn:onlyLoggedIn}
        })
         .when('/admin/perfilmodulo', {
             templateUrl: 'assets/pages/admin/perfilesmodulos/perfilmodulo.html',
            controller: 'perfilmoduloController',
            resolve:{loggedIn:onlyLoggedIn}
        })
         .when('/admin/editperfilmodulo', {
             templateUrl: 'assets/pages/admin/perfilesmodulos/editperfilmodulo.html',
            controller: 'editperfilmoduloController',
            resolve:{loggedIn:onlyLoggedIn}
         })
        .when('/admin/menu', {
            templateUrl: 'assets/pages/admin/menu.html',
            controller: 'menuController',
            resolve:{loggedIn:onlyLoggedIn}
        })
        .otherwise({
            redirectTo: '/',
            resolve:{loggedIn:onlyLoggedIn}
        });
});

