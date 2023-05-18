//! console.log ile çıktı alma

console.log("Dışarıdan entegre edilen ilk JS Denemesi!");
console.log(true);
console.log(5/3);
console.log({name: "Semih", surname: "Açmalı"});

console.log(window);

console.log(document.location.protocol);

// ! document.write ile html e yazı yazma

document.write("HTML dosyaya çıktı alma denemesi!");
document.write("<br><h6>Zonguldak Bülent Ecevit Üniversitesi</h6>");

document.write(96/3);


//! alert ile çıktı gösterme

let a = 15, b = 21;
alert("Uyarı Denemesi!");
alert("İki sayının toplamı : " + (a+b));