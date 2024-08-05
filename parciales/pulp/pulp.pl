

personaje(pumkin, ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,mafioso(maton)).
personaje(jules, mafioso(maton)).
personaje(marsellus,mafioso(capo)).
personaje(winston, mafioso(resuelveProblemas)).
personaje(mia, actriz([foxForceFive])).
personaje(butch, boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

%1



esPeligroso(Personaje):-
    personaje(Personaje,Actividad),
    actividadPeligrosa(Actividad).

esPeligroso(Personaje):-
    empleadoPeligroso(Personaje).



actividadPeligrosa(mafioso(maton)).
actividadPeligrosa(ladron(Lugares)):-
    member(licorerias,Lugares).

empleadoPeligroso(Empleador):-
    trabajaPara(Empleador,Empleado),
    esPeligroso(Empleado).


%2

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).


duoTemible(Personaje,OtroPersonaje):-
    sonAmigos(Personaje,OtroPersonaje),
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje).

duoTemible(Personaje,OtroPersonaje):-
    sonPareja(Personaje,OtroPersonaje),
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje).


sonPareja(Personaje,OtroPersonaje):-
    amigo(Personaje,OtroPersonaje).
    

sonPareja(Personaje,OtroPersonaje):-
    amigo(OtroPersonaje,Personaje).
    

sonAmigos(Personaje,OtroPersonaje):-
    amigo(Personaje,OtroPersonaje).
    

sonAmigos(Personaje,OtroPersonaje):-
    amigo(OtroPersonaje,Personaje).
    



%3

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).


estaEnProblemas(butch).

estaEnProblemas(Personaje):-
    trabajaPara(Jefe,Personaje),
    esPeligroso(Jefe),
    encargo(Jefe,Personaje,cuidar(Persona)),
    sonPareja(Jefe,Persona).

estaEnProblemas(Personaje):-
    encargo(_,Personaje,buscar(Buscado,_)),
    personaje(Buscado,boxeador).

%4

sanCayetano(Personaje):-
    encargo(Personaje,_,_),
    forall(tieneCerca(Personaje,OtroPersonaje),encargo(Personaje, OtroPersonaje, _)).

tieneCerca(Personaje,OtroPersonaje):-
    sonAmigos(Personaje,OtroPersonaje).
    

tieneCerca(Personaje,OtroPersonaje):-
    trabajaPara(Personaje,OtroPersonaje).


%5

masAtareado(Personaje):-
    cantidadDeEncargos(Personaje,Cantidad),
    forall(cantidadDeEncargos(_,OtraCantidad),Cantidad>=OtraCantidad).

cantidadDeEncargos(Personaje,Cantidad):-
    personaje(Personaje,_),
    findall(Encargo, encargo(_,Personaje,Encargo),ListaDeEncargos),
    length(ListaDeEncargos, Cantidad).
    

%6


personajesRespetables(Personajes):-
    findall(Personaje,(personaje(Personaje,_),esRespetable(Personaje)),Personajes).

esRespetable(Personaje):-
    personaje(Personaje,Actividad),
    nivelDeRespeto(Actividad,Respeto),
    Respeto > 9.

nivelDeRespeto(actriz(Peliculas),Respeto):-
    length(Peliculas,Cantidad),
    Respeto is Cantidad / 10.

nivelDeRespeto(mafioso(resuelveProblemas),10).
nivelDeRespeto(mafioso(maton),1).
nivelDeRespeto(mafioso(capo),20).


%7

hartoDe(Personaje, OtroPersonaje):-
    personaje(Personaje,_),
    personaje(OtroPersonaje,_),
    forall(encargo(_,Personaje,_),interactuanEntreEllos(Personaje,OtroPersonaje)).


interactuanEntreEllos(Personaje,OtroPersonaje):-
    encargo(_,Personaje,Actividad),
    interactua(OtroPersonaje,Actividad).

interactuanEntreEllos(Personaje,OtroPersonaje):-
    encargo(_,Personaje,Actividad),
    sonAmigos(OtroPersonaje,Tercero),
    interactua(Tercero,Actividad).

interactua(Personaje,cuidar(Personaje)).
interactua(Personaje,ayudar(Personaje)).
interactua(Personaje,buscar(Personaje,_)).



%8

caracteristicas(vincent, [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,[tieneCabeza, muchoPelo]).
caracteristicas(marvin, [negro]).

duo(Personaje,OtroPersonaje):-
    sonAmigos(Personaje,OtroPersonaje).

duo(Personaje,OtroPersonaje):-
    sonPareja(Personaje,OtroPersonaje).
    

duoDiferenciable(Personaje,OtroPersonaje):-
    duo(Personaje,OtroPersonaje),
    diferenciables(Personaje,OtroPersonaje).

duoDiferenciable(Personaje,OtroPersonaje):-
    esDuo(Personaje,OtroPersonaje),
    diferenciables(OtroPersonaje,Personaje).


diferenciables(Personaje,OtroPersonaje):-
    caracteristica(Personaje,Caracteristica),
    caracteristicas(OtroPersonaje,Caracteristicas2).
    not(member(UnaCaracteristica,CaracteristicasDelOtro)).


caracteristica(Personaje,Caracteristica):-
    caracteristicas(Personaje,Caracteristicas),
    member(Caracteristica,Caracteristicas).


