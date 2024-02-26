// Var Let Const

// var function scope --ram bellekte cok fazla yer kaplar

function selamVer(){
    var selam = "Herkese Selam"; //function scope
    if(true){
        var b = 10;
    }
    console.log(b);
    console.log(selam);
}

selamVer();

// let - const: block scope

// function selamVer2(){
//     var selam = "Herkese Selam"; //function scope
//     if(true){
//         let b = 10; // block scope
//     }
//     console.log(b);
//     console.log(selam);
// }

// selamVer2();


// aynı ismi kullanip degisken olusturulabilir
var a = 5;
console.log(a);
var a = 10;
console.log(10);

// let b = 10;
// let b = 65;

//const (constant sabit)

const c = 85;
// c = 45;

const user = {
    username : "devrekmyo",
    password : "123456"
};
// user = {age : 45};

console.log(user);

user.username = "devrek";
console.log(user);
