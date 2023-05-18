/*
Atama ve Mantıksal Operatörler
! = atama yapma operatöru
! == mantıksal eşitliği kontrol eder değişken türüne bakılmaksızın aynı olup olmadığını kontrol eder
! <=, >= değerlerin birbirinden buyuk olup olmamasını kontrol eder
! === hem değişken türü hem de içerik aynı ise true dondurur

*/

/*
let a = 5;
console.log(a);

console.log(5 == 6);
console.log(6 <= 4);
console.log(5 >= 3);

console.log(typeof 5);
console.log(typeof '5');

console.log(5 == 5);
console.log(5 == "5");
console.log(5 === "5");
*/


/** 
 * ! %= mod alma
 * ! *= çarpma
 * ! /= bölme
 * ! -= çıkarma
 * ! += toplama
 * ! **= kuvvet alma
*/

console.log(28%5);

let a = 28;
console.log(a);
//a = a % 5;
a %= 5;
console.log(a);


a = 27;

a -= 7;

console.log(a);


console.log(5**3); //5^3

let b = 7;

b **= 2;
console.log(b);

console.log(121**(1/2));


/**
 * ! && ve ifadesi
 * ! || veya ifadesi
 * ! ! değil (tersi)
 */

// yasi 18 den fazla ve geliri varsa ehliyet alabilir 

let yas = 17;
let gelir = 3000;

console.log(yas>=18 && gelir > 0);

//yasi 18den fazla veya geliri varsa ehliyet alabilir

console.log(yas>=18 || gelir > 0);


//yasi 18den fazla veya geliri varsa ehliyet alabilir
yas = 17;
gelir = 0;


console.log(!(yas<18) || gelir > 0);



/**
 * ! alert = uyarı ekranı verir ve tamama basana kadar başka işlem yapılamaz
 * ! prompt = Kullanıcan değer girilmesini sağlayan fonksiyondur. Ancak girilen değer her zaman String türündedir.
 * ! confirm = verilen uyarı ekranındaki butonlara tıklayarak true veya false olarak donus almayı sağlıyor
*/

//alert("Uyarı Ekranı!");


let sayi1 = prompt("Bir Sayı Giriniz : ");
console.log(typeof sayi1);

console.log(Number(sayi1) + 5);

let c = 165;

console.log(typeof (String(c) + 8));


let conf1 = confirm("Deneme Mesajı");
console.log(conf1);



// vize sınavına girip girmediğini kontrol edelim?

let conf2 = confirm("Vize Sınavına Girdiniz mi? \nGirdiyseniz 'Tamam' a, \nGirmediyseniz 'İptal' e basınız.");

let vizeNotu;
if (conf2){
    console.log("Vize Sınavına girmişsiniz!");
    vizeNotu = Number(prompt("Lütfen Vize Notunuzu Giriniz : "));
}
else{
    console.log("Vize Sınavına girmemişsiniz!");
    vizeNotu = -1;
    conf3 = confirm("Mazeret Sınavına Girdiniz mi?\nGirdiyseniz 'Tamam' a, \nGirmediyseniz 'İptal' e basınız.");
    if(conf3){
        console.log("Mazeret Sınavına girmişsiniz!");
        vizeNotu = Number(prompt("Lütfen Mazeret Sınavı Notunuzu Giriniz : "));
    }else{
        console.log("Mazeret Sınavına girmemişsiniz!");
        vizeNotu = -1;
    }
}

// öğrenci eğer vize sınavına girdiyse finalden alması gereken en düşük notu ekrana yazdıralım

// vize * 0,4 + final * 0,6 = 60
let gerekliFinalNotu;
if(vizeNotu != -1){
    gerekliFinalNotu = (60 - (vizeNotu * 0.4)) / 0.6;
}else{
    gerekliFinalNotu = "Öğrenci Vizeye Girmediği İçin Final Notu Hesaplanamaz!";
}

console.log(gerekliFinalNotu);