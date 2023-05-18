// ? Scope Kavramı

// * Global Scope

/** 
 * ? Global Scope : üretilen değişken her yerden kullanılabilir
 * */  

var a = 10;
function method1(){
    console.log("Degiskenin method ile ciktisi : " , a);
}

method1();

if(true){
    console.log("Degiskenin if ile ciktisi: " , a);
}

/**
 * ? Function Scope : üretilen değişken sadece bulundugu fonksiyon içerisinden erişilebilir.
 */


function method2(){
    var b = 10;
    console.log("Method içi Çıktısı : " , b);
}
method2();

// console.log("Metho içi değişkene dışardan erişim : " , b);


/**
 * ? Block Scope : üretilen değişken sadece o süslü parantezler("{ }") içerisinden erişilebilir
 */
if(true){
    let b = 10;
    const c = 20;
}

// console.log("if içi değişkene dışardan erişim : " , b);
// console.log("if içi değişkene dışardan erişim : " , c);

var a = 20;
a = 30;

let b = 10;
console.log(b);
// function method3(){
//     let b = 30;
//     console.log(b);
// }
// method3();
b = 40;
console.log(b);

/**
 * ! const(constant = sabit) : üretilen değişkenin degeri değiştirilemez!!!!!
 */
const c = 20;
console.log("Const değişken değeri : " , c);
// c = 30;
// console.log("Const değişken değeri : " , c);

