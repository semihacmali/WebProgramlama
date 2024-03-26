// Koşul Yapıları


let not = 65;

if(not > 50){
    console.log("Geçtiniz, notunuz : " + not);
}else{
    console.log("Kaldiniz, notunuz : " + not);
}

console.log(not > 50 ? "Geçtiniz, notunuz : " + not : "Kaldiniz, notunuz : " + not);

//Ehliyet alabilme
// yasi 18 den büyük 
//kurs icin en az 3000 lirasının olması lazım

let yas = Number(prompt("Yasiniz : "));
let para = Number(prompt("Butceniz : "));

if(yas >= 18 && para >= 3000){
    alert("Ehliyet Snavına katılabilirsiniz");
}else{
    alert("Ehliyet Sınavına Katılamazsiniz..");
}


//Ders notu hesaplama

// vize %40 final %60 etkiliyor

// Geçme notu 50 olsun

let vize = Number(prompt("Vize Notunuz : "));

let final = Number(prompt("Final Notunuz :"));

let ortalama = (vize * 0.4) + (final * 0.6);

if(ortalama < 50){
    console.log("Kaldınız...");
    let but = (50 - (vize * 0.4)) / 0.6;
    console.log("Butten alaniz gereken not : " + but);
}else if(ortalama < 60){
    console.log("CC ile Geçtiniz..");
}else if(ortalama < 70){
    console.log("BB ile Geçtiniz..");
}else{
    console.log("AA ile Geçtiniz..");
}



