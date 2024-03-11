/*
İsim : Bos birakilamaz
TCKN : 11 hanel olmasi gerekiyor
*/

let isim = prompt("İsminiz : ");
let tckn = prompt("TCKN giriniz : ");

function kontrolEt(ad, tckn){
    if(ad != ""){
        if(tckn.length == 11 & Number(tckn)%2 == 0){
            console.log("İsim ve TCKN dogru girilmistir");
        }else{
            console.log("TCKN yanlis girilmistir.");
        }
    }else{
        console.log("İsim yanlis girilmistir.");
    }
}

kontrolEt(isim, tckn);