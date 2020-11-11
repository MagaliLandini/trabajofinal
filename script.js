$("#contacto").click(function irAContacto(evento){
    evento.preventDefault();
    let elemento= document.getElementById("contacto2");
    elemento.scrollIntoView();
    
   
 });

 $("#inicio").click(function irAInicio(evento){
    evento.preventDefault();
    let elemento= document.getElementById("inicio2");
    elemento.scrollIntoView();
    
   
 });
 $("#sobreMi").click(function irASobreMi(evento){
    evento.preventDefault();
    let elemento= document.getElementById("sobreMi2");
    elemento.scrollIntoView();
    
   
 });


 
$("#email").click(
 function Redireccionar() {
  window.open("https://mail.google.com/mail/u/0/?view=cm&to=magaliyazminlandini@gmail.com");
});

$("#git").click(
 function Redireccionar() {
  window.open("https://github.com/MagaliLandini");
});

$("#face").click(
 function Redireccionar() {
  window.open("https://www.facebook.com/magali.landini/");
});
