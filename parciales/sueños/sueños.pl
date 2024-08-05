
%1
creen(gabriel,campanita).
creen(gabriel,magoOz).
creen(gabriel,cavenaghi).
creen(juan,conejoPascuas).
creen(macarena,reyesMagos).
creen(macarena,magoCapria).
creen(macarena,campanita).


sueno(gabriel,ganarLoteria([5,9])).
sueno(gabriel,futbolista(arsenal)).
sueno(juan,cantante(100000)).
sueno(macarena,cantante(10000)).

persona(gabriel).
persona(juan).
persona(macarena).




%2

ambicioso(Persona):-
dificultadTotal(Persona,Total),
Total > 20.

dificultadTotal(Persona,Total):-
  sueno(Persona,_),
  findall(Dificultad,( sueno(Persona,Sueno), dificultad(Sueno, Dificultad) ) , ListaDificultad),
  sumlist(ListaDificultad, Total).



dificultad(cantante(Ventas),6):-
  Ventas > 500000.

dificultad(cantante(Ventas),4):-
  Ventas =< 500000.

dificultad(ganarLoteria(ListaApuesta), Dificultad ):-
  length(ListaApuesta,Cantidad),
  Dificultad is Cantidad * 10 .

dificultad(futbolista(Equipo),3):-
  equipoChico(Equipo).

dificultad(futbolista(Equipo),16):-
  not(equipoChico(Equipo)).


equipoChico(arsenal).
equipoChico(aldosivi).


%3


tieneQuimica(Persona,campanita):-
  creen(Persona,campanita),
  suenoMenor(Persona).

tieneQuimica(Persona,Personaje):-
  creen(Persona,Personaje),
  cumpleCondicion(Persona,Personaje).

suenoMenor(Persona):-
  sueno(Persona,Sueno),
  dificultad(Sueno,Dificultad),
  Dificultad < 5.


suenoPuro(futbolista(_)).
suenoPuro(cantante(Ventas)):-
  Ventas < 200000.

cumpleCondicion(Persona,Personaje):-
  Personaje \= campanita,
  forall(sueno(Persona,Sueno), suenoPuro(Sueno)),
  not(ambicioso(Persona)).
  

%4

amigo(campanita,reyesMagos).
amigo(campanita,conejoPascuas).
amigo(conejoPascuas,cavenaghi).

estaEnfermo(reyesMagos).
estaEnfermo(campanita).
estaEnfermo(conejoPascuas).


puedeAlegrar(Personaje,Persona):-
  sueno(Persona,_),
  tieneQuimica(Persona,Personaje),
  noEnfermo(Personaje).


noEnfermo(Personaje):-
not(estaEnfermo(Personaje)).

noEnfermo(Personaje):-
amigodDirectoOIndirecto(Personaje,OtroPersonaje),
not(estaEnfermo(OtroPersonaje)).

amigoDirectoOIndirecto(Personaje,OtroPersonaje):-
amigo(Personaje,OtroPersonaje).

amigodDirectoOIndirecto(Personaje,OtroPersonaje):
amigo(Personaje,UnPersonaje),
amigo(UnPersonaje,OtroPersonaje).










