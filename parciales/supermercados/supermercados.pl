
%primeraMarca(Marca)
primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

%precioUnitario(Producto,Precio)
/* donde Producto puede ser 
arroz(Marca)
lacteo(Marca,TipoDeLacteo)
salchicas(Marca,Cantidad) */
precioUnitario(arroz(gallo),25.10).
precioUnitario(lacteo(laSerenisima,leche), 6.00).
precioUnitario(lacteo(laSerenisima,crema), 4.00).
precioUnitario(lacteo(gandara,queso(gouda)), 13.00).
precioUnitario(lacteo(vacalin,queso(mozzarella)), 12.50).
precioUnitario(salchichas(vienisima,12), 9.80).
precioUnitario(salchichas(vienisima, 6), 5.80).
precioUnitario(salchichas(granjaDelSol, 8), 5.10).

%descuento(Producto, Descuento)
descuento(lacteo(laSerenisima,leche), 0.20).
descuento(lacteo(laSerenisima,crema), 0.70).
descuento(lacteo(gandara,queso(gouda)), 0.70).
descuento(lacteo(vacalin,queso(mozzarella)), 0.05).

%compro(Cliente,Producto,Cantidad)
compro(juan,lacteo(laSerenisima,crema),2).

/* 1)  Desarrollar la lógica para agregar los siguientes descuentos
    - El arroz tiene un descuento del  $1.50. 
    - Las salchichas tienen $0,50 de descuento si no son vienisima.
    - Los lacteos tienen $2 de descuento si son leches o quesos de primera marca. 
    (el primera marca sólo se refiere a los quesos).
    - El producto con el mayor precio unitario tiene 5% de descuento. */

descuento(arroz(_),1.50).
descuento(salchichas(Tipo,_),0.50):-
    Tipo \= vienisima.

descuento(lacteo(_,leche),2).


descuento(lacteo(Marca,queso(_)),2):-
    primeraMarca(Marca).

mayorPrecio(Producto):-
    precioUnitario(Producto,Precio).
    forall(precioUnitario(_,OtroPrecio), Precio >= OtroPrecio).
