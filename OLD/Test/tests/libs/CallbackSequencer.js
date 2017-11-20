exports.Sequencer = function() {
    var functions=[];
    
    this.addFunction=function(f) {
        functions.push(f);
    }

    this.setEndCallback=function(p){
        end_callback=p;
    }

    this.getLength=function(){
        return functions.length;
    }
    
    this.execute=function(){
        run();
    }
    this.executeAll=function(){
        if(functions.length>0){
            run();
            this.executeAll();
        }
    }
    var end=function(){
        console.log("end");
    }
    var run=function() {
        var fx=functions.shift();
            fx();
    }
}


