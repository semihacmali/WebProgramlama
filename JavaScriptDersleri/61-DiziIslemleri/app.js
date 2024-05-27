//Diziler  
//ArrayIndexOutOfBoundException == undefined
let sayilar = [0,1,2,3,4,5,6,7,8,9];

console.log(sayilar[6]); // dizideki 6. indisdeki degeri getirir

sayilar[sayilar.length - 1] // son eleman

let isimler = ["Semih", "Ali", "Veli", "Soner"];

isimler[2] = "Ahmet";
console.log(isimler);

let karisikDizi = [2, "Semih", 5, null, 8, false, undefined];

let isimler2 = new Array("Ali", "Veli");
let isimler3 = [];

console.log(typeof isimler2);
isimler3[0] = "Semih";
isimler2[0] = 5;
