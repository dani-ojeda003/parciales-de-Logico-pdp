
composicion(platoPrincipal(milanesa),[ingrediente(pan,3),ingrediente(huevo,2),
ingrediente(carne,2)]).

composicion(entrada(ensMixta),[ingrediente(tomate,2),ingrediente(cebolla,1),
ingrediente(lechuga,2)]).

composicion(entrada(ensFresca),[ingrediente(huevo,1),
ingrediente(remolacha,2),ingrediente(zanahoria,1)]).

composicion(postre(budinDePan),[ingrediente(pan,2),ingrediente(caramelo,1)]).


calorias(pan,30).
calorias(huevo,18).
calorias(carne,40).
calorias(caramelo,170).


proveedor(disco, [pan, caramelo, carne, cebolla]).
proveedor(sanIgnacio, [zanahoria, lechuga, miel, huevo]).

%1
esPlato(Plato):-
    composicion(Plato,_).

caloriasTotal(Plato,Total):-
    esPlato(Plato),
    findall(Caloria,(obtenerIngrediente(Plato,Ingrediente),caloriasDeUnosIngredientes(Ingrediente,Caloria)),ListaDeCalorias),
    sumlist(ListaDeCalorias,Total).
    
obtenerIngrediente(Plato,Ingrediente):-
    composicion(Plato,Ingredientes),
    member(Ingrediente,Ingredientes).

caloriasDeUnosIngredientes(ingrediente(Ingrediente,Cantidad),CaloriasTotal):-
    calorias(Ingrediente,Caloria),
    CaloriasTotal is Caloria * Cantidad.

%3
platoSimpatico(Plato):-
    composicion(Plato,Ingredientes),
    member(ingrediente(pan,_),Ingredientes),
    member(ingrediente(huevo,_),Ingredientes).

platoSimpatico(Plato):-
    caloriasTotal(Plato,Total),
    Total < 200.

%4
menuDiet(Plato1,Plato2,Plato3):-
    esEntrada(Plato1),
    esPlatoPrincipal(Plato2),
    esPostre(Plato3),
    sumaDeCalorias(Plato1,Plato2,Plato3,Total),
    Total < 450.


sumaDeCalorias(Plato1,Plato2,Plato3,Suma):-
    caloriasTotal(Plato1,Total1),
    caloriasTotal(Plato2,Total2),
    caloriasTotal(Plato3,Total3),
    Suma is Total1 + Total2 + Total3.

esPlatoPrincipal(platoPrincipal(_)).

esEntrada(entrada(_)).

esPostre(postre(_)).

%5
esProveedor(Proveedor):-
    proveedor(Proveedor,_).
    
tieneTodo(Proveedor,Plato):-
    composicion(Plato,Ingredientes),
    esProveedor(Proveedor),
    forall((member(Ingrediente,Ingredientes),obtenerNombreIngrediente(Ingrediente,Nombre)),puedeProveer(Proveedor,Nombre)).
   
    
obtenerNombreIngrediente(ingrediente(Nombre,_),Nombre).

puedeProveer(Proveedor,Ingrediente):-
    proveedor(Proveedor,Productos),
    member(Ingrediente,Productos).

%6
esNombreDeIngrediente(Ingrediente):-
    composicion(_,Ingredientes),
    member(ingrediente(Ingrediente,_),Ingredientes).

ingredientePopular(Ingrediente):-
    esNombreDeIngrediente(Ingrediente),
    findall(Plato, ingredientePerteneceAPlato(Ingrediente,Plato) ,ListaDePlatos),
    length(ListaDePlatos, Cantidad),
    Cantidad >3.
    

ingredientePerteneceAPlato(Ingrediente,Plato):-
    composicion(Plato,Ingredientes),
    member(ingrediente(Ingrediente,_),Ingredientes).


%7
cantidadTotal(Ingrediente,Cantidades,Total):-
    esNombreDeIngrediente(Ingrediente),
    findall(CantidadResultante , (member(Cantidad,Cantidades),cantidadDeIngredientePorPlato(Ingrediente,Cantidad,CantidadResultante)) , ListaDeCantidadesResultantes),
    sumlist(ListaDeCantidadesResultantes,Total).

cantidadDeIngredientePorPlato(Ingrediente,cantidad(Plato,CantidadUnidades),CantidadResultante):-
    composicion(Plato,Ingredientes),
    member(ingrediente(Ingrediente,Cantidad),Ingredientes),
    CantidadResultante is Cantidad * CantidadUnidades.
