var sayi, tahmin, hak = 1, i = 0;

sayi = Math.round((Math.random() * 100));

do{
    tahmin = parseInt(window.prompt("Tahmininizi Giriniz : "));

    if(tahmin < sayi){
        console.log("Daha Büyük Bir Sayı Giriniz!");
    }
    if(tahmin > sayi){
        console.log("Daha Küçük Bir Sayi Giriniz!");
    }
    if(tahmin == sayi){
        console.log("Tebrikler Bildiniz. Tutulan sayı : " + sayi);
        console.log(hak + ". hakkınızda bildiniz!");
    }
    hak++;

}while(tahmin != sayi && hak < 10);

if(hak => 10){
    console.log("Hakkınız bitti. Tutulan Sayı : " + sayi);
}