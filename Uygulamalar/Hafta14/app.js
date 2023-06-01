/**
 * ! Fonksiyon Tanımlama;
 * fuction fonksiyonAdi(Parametre){
 * return -> geri değer dondurmek için kullanılır
 * }
 * ! Fonksiyon Çağırma;
 *  var donenDeger = fonksiyonAdi(Parametre);
 */
/**
 * ? Parametresiz Fonksiyonlar
 */

function fonk1(){
    console.log("Parametresiz ve geri değer döndürmeyen bir fonksiyon örneği!!");
}

fonk1();

// parametresiz ve geri deger donduren fonksiyon
function fonk2(){
    let a = 5;
    return a;
}
let a = 10;
console.log("Fonksiyonı çağırmadan önceki a degiskeninin degeri : " + a);
a = fonk2();
console.log("Fonksiyonı çağırdıktan sonraki a degiskeninin degeri : " + a);

let sayi1 = 8;

function fonk3(){
    console.log("Global olarak tanımlanmış sayi1'in degeri : " + sayi1);
}

fonk3();

function fonk4(){
    let b = 78;
}
fonk4();

//console.log("Yerel olarak tanımlanmış( { } arasında) b degiskeninin degeri : " + b);

/**
 * ? Parametreli Fonksiyonlar
 */

function fonk5(sayi2){
    console.log("Parametresi : " + sayi2 + " olan fonksiyon örneği");
}
fonk5();
fonk5("lsjkhg %!24|}");

function fonk6(sayi2, sayi3=7){
    console.log("Parametreleri : " + sayi2 + ", " + sayi3 + " olan fonksiyon örneği");
}

fonk6(9,2);
fonk6(9);

/**
 * ! return ile geri deger donduren Fonksiyonlar
 * ? KDV örneği
 */

function KDVHesapla(tutar, kdvOrani=18){
    let sonuc = tutar + (tutar * kdvOrani / 100);
    return sonuc;
}

var girilenTutar = Number(prompt("Tutarı Giriniz : " ));
var sonuc = KDVHesapla(girilenTutar);
console.log("Girilen Tutar : " + girilenTutar + "\n Bu tutarın KDV'li fiyati : " + sonuc);


var girilenTutar = Number(prompt("Tutarı Giriniz : " ));
var KDVTutarı = Number(prompt("KDV tutarını Giriniz : " ));
var sonuc = KDVHesapla(girilenTutar, KDVTutarı);
console.log("Girilen Tutar : " + girilenTutar + "\n Bu tutarın KDV'li fiyati : " + sonuc);


function degerOkuma(){
    var gelenDeger = document.getElementById("inputTxt").value;
    let sonuc = FaktoriyelHesaplama(gelenDeger);
    document.getElementById("outputTxt").innerHTML = "Girilen Deger : " + gelenDeger;
    document.getElementById("faktOut").innerHTML = "Faktöriyel Sonucu : " + sonuc;
    let sonuc2 = recursiveFaktoriyelHesaplama(gelenDeger);
    document.getElementById("recFaktOut").innerHTML = "Recursive Faktöriyel Sonuc : " + sonuc2;
}

function FaktoriyelHesaplama(deger){
    let sonuc = 1;
    for(let i = 2; i <= deger; i++){
        sonuc *= i;
    }
    return sonuc
}

function recursiveFaktoriyelHesaplama(deger){
    if(deger <= 1){
        return 1;
    }else{
        return deger * recursiveFaktoriyelHesaplama(deger-1);
    }
}

/**
 * ! Kombinasyon Hesaplama Örneği
 */

function kombinasyonHesaplama(){
    let n = document.getElementById("nInput").value;
    let r = document.getElementById("rInput").value;
    let nfaktoriyel = recursiveFaktoriyelHesaplama(n);
    let rfaktoriyel = recursiveFaktoriyelHesaplama(r);
    let nrfaktoriyel = recursiveFaktoriyelHesaplama(n-r);
    let sonuc = nfaktoriyel / (rfaktoriyel * nrfaktoriyel);
    document.getElementById("komOutput").innerHTML = "Kombinasyon Hesaplama Sonucu : " + sonuc;
}