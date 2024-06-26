:- module(_,_,assertions).
%:- module(modulename,exports,[iso]).
:- use_module(library(lists)).
:- use_module(library(aggregates)).
:- use_module(library(between)).


author_data('Aguiar','Calvo','Hernán','B190090').
:- doc(author, "Hernán Calvo Aguiar,b190090").

:- doc(title, "Segunda Práctica: ISO Prolog").
:- doc(module,"
Este modulo define operaciones con 'Marias y Arañas'

@section{Parte 1 (5 pts). Particiones M-arias de un numero:}
Una particion de un número entero positivo N se define como un conjunto de números
enteros positivos que suman N, escritos en orden descendente. Por ejemplo, para el
número 15 tenemos:
@begin{verbatim}15=5+4+3+2+1@end{verbatim}
Una particion es M-aria si cada termino de dicha particion es una potencia de M.
Por ejemplo, las particiones 3-arias de 9 son:
@begin{verbatim}
9
3+3+3
3+3+1+1+1
3+1+1+1+1+1+1
1+1+1+1+1+1+1+1+1
@end{verbatim}
El objetivo de esta parte es escribir un predicado maria/3 tal que el tercer argumento es el numero de 
particiones M-arias del segundo argumento siendo M el primer argumento. 
Por ejemplo, @tt{?- maria(3,9,M).} debe devolver M=5 .
Para ello, se han implementan los siguientes predicados:

@subsection{Predicado 1.1 pots(M,N,Ps):}
Mi solución del predicado pots se basa en 2 ideas:
1. El uso de un corte para limitar la lista de soluciones
2. El cálculo de potencias de manera dinámica

Mi primera idea fue al darme cuenta que la longitud de la lista Ps mas uno sería igual al exponente mas uno:
@begin{verbatim}length(Ps)+1=exp@end{verbatim}
Pero debido a que incrementa demasiado el tiempo de cálculo no es una solución viable par exponentes demasiado grandes.

@subsection{Predicado 1.2 mpart(M,N,P):}
La solución hace uso del sistema de backtracking que tiene prolog. 



").

 %% 1.1
 %% dados M y N enteros, devuelve en Ps una lista con las potencias de M  que son menores o iguales que N en orden descendente

:- pred potcalc(M,N,Potencia,ListaPotencias,Ps)
   #"Realiza el cálculo de la potencia y el corte de la potencia. 
@var{M},
@var{N}, 
@var{Potencia} la ultima potencia calculada,
@var{ListaPotencias} la lista de potencias que se ha calculado, 
@var{Ps} la lista de potencias a devolver. @includedef{pot/5} ".


:- pred pots(M,N,Ps)
   #"Devuelve en @{Ps} la lista de potencias de @var{M} en orden descendente menores que @var{N}. @includedef{pots/3} ".
pots(1, _, [1]).
pots(M,N,Ps):-
    integer(M),
    integer(N),
    potcalc(M,N,1,[1],Ps).

potcalc(M,N,Potencia,Potencias,Potencias):-
    Potencia*M > N,
    !.
    
potcalc(M,N,OldPotencia,Potencias,Ps):-
    NuevaPotencia is OldPotencia * M,
    potcalc(M,N,NuevaPotencia,[NuevaPotencia|Potencias],Ps).    

:- pred mpart_aux(Potencias,Contador,Pots)
   #"".
mpart_aux(_, 0, []).
mpart_aux([Potencia|Potencias], Contador, [PotsH|PotsT]) :-
    PotsH is Potencia,
    Contador > 0,
    Contador_ is Contador - PotsH,
    mpart_aux([Potencia|Potencias], Contador_, PotsT).

mpart_aux([_|Potencias], Contador, P) :-
    Contador > 0,
    mpart_aux(Potencias, Contador, P).

:- pred mpart(M,N,Resultado)
   #"".
mpart(M, N, P) :-
    pots(M, N, Ps),
    mpart_aux(Ps, N, P).

:- pred maria(M,N,Npart)
   #"".
maria(M,N,Npart):-
    findall(X, mpart(M,N,X),Res),
    length(Res,Npart).
    
:- pred arista(N1,N2)
   #"".
arista(_,_).

:- pred guardar_grafo(Grafo)
   #"".
guardar_grafo(G):-
    retractall(arista(_,_)),
    assert_lista_aristas(G).

assert_lista_aristas(Arista|Aristas):-
    assert(Arista),
    assert_lista_aristas(Aristas).

