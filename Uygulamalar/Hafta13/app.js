
for(let i = 0; i <= 10; i++){
    document.write(i + "</br>");
}

for(let i = 0; i <= 10; i++){
    document.write("Devrek MYO" + "<br>");
}

// 0 ile 50 arasındaki çift sayılar
for(let i = 0; i <= 50; i++){
    if(i%2 == 0){
        document.write(i + "<br>");
    }
}


//1-100 arasındaki 3 ve 5 e tam bolunen sayılar

for(let i = 0; i <= 100; i++){
    if(i%3 == 0 && i%5 == 0){
        document.write(i + "<br>");
    }
}



//Kullanıcının girdiği metni istenilen adet kadar ekrana yazma

var metin = window.prompt("Metni Giriniz :");
var adet = window.prompt("Metin Kaç Defa Yazdırılsın : ");

for(let i = 1; i <= adet; i++){
    document.write(metin + "<br>");
}



//h6'dan h1'e dogru metin yazdırma

var metin = window.prompt("Metni Giriniz");

for(let i = 6; i > 0; i--){
    document.write("<h" + i + ">" + metin + "</h" + i + ">") ;
}
 
var metin = window.prompt("Metni Giriniz");
for(let i = 0; i < 10; i++){
    document.write("<span style='fonst-size: " + (i + 5) + "px;'>" + metin + "</span></br>");
}



var yukseklik = window.prompt("Yükseklik Giriniz : ");
var genislik = window.prompt("Genişlik Giriniz : ");

for(let i = 1; i <= yukseklik; i++){
    for(let j = 1; j <= genislik; j++){
        if(i == 1 || i == yukseklik){
            document.write("*");
        }else{
            if(j == 1 || j == genislik){
                document.write("*");
            }else{
                document.write("&nbsp;");
                document.write("&nbsp;");
            }
        }
    }
    document.write("</br>");
}