%1


atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leonC, lunes, 14, 18).
atiende(leonC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).

atiende(vale, Dia, Horario1,Horario2):-
atiende(dodain,Dia,Horario1,Horario2).

atiende(vale, Dia, Horario1,Horario2):-
atiende(juanC,Dia,Horario1,Horario2).



%nadie_hace_el_mismo_horario_que_leoC_no_se_agrega_por_universo_cerrado

%maiu_esta_pensando_no_se_agrega_por_universo_cerrado


%2

quienAtiende(Persona, Dia, HorarioPuntual):-
  atiende(Persona, Dia, HorarioInicio, HorarioFinal),
  between(HorarioInicio, HorarioFinal, HorarioPuntual).

%3
foreverAlone(Persona, Dia, HorarioPuntual):-
  quienAtiende(Persona, Dia, HorarioPuntual),
  not((quienAtiende(OtraPersona, Dia, HorarioPuntual), Persona \= OtraPersona)).


%4

atiendeEl(Persona,Dia):-
  atiende(Persona,Dia,_,_),
  forall()

  posibilidadesAtencion(Dia, Personas):-
  findall(Persona, distinct(Persona, quienAtiende(Persona, Dia, _)), PersonasPosibles),
  combinar(PersonasPosibles, Personas).

combinar([], []).
combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).


%5

venta(dodain, fecha(10, 8), [golosinas(1200), cigarrillos(jockey), golosinas(50)]).

venta(dodain, fecha(12, 8), [bebidas(alcoholicas, 8), bebidas(noAlcoholicas, 1), golosinas(10)]).

venta(martu, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).

venta(lucas, fecha(11, 8), [golosinas(600)]).

venta(lucas, fecha(18, 8), [bebidas(noAlcoholicas, 2), cigarrillos([derby])]).


personaSuertuda(Persona):-
  vendedora(Persona),
  forall(venta(Persona, _, [Venta|_]), ventaImportante(Venta)).

vendedora(Persona):-venta(Persona, _, _).

ventaImportante(golosinas(Precio)):-Precio > 100.

ventaImportante(cigarrillos(Marcas)):-
length(Marcas, Cantidad), 
Cantidad > 2.

ventaImportante(bebidas(alcoholicas, _)).

ventaImportante(bebidas(_, Cantidad)):-
Cantidad > 5.



