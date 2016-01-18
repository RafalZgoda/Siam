nextPlayer(e,r).
nextPlayer(r, e).

% Position des éléphants et rhino 
 
% Aucun rhino et elephant sur le plateau 
plateau_initial([e,[32,33,34],
 		[(0,0),(0,0),(0,0),(0,0),(0,0)],
 		[(0,0),(0,0),(0,0),(0,0),(0,0)]]).

plateau(X) :- plateau_initial(X).  


affiche_plat(0) :- write('ok'). 
affiche_plat(6) :- write(' ___ ___ ___ ___ ___'),nl, affiche_plat(5) . 

affiche_plat(Y) :- write('|'),write('   '),write('|'),write('   '),write('|'),write('   '),write('|'),write('   '),write('|'),write('   '),write('|'), nl, 
write('|'),write('___'),write('|'),write('___'),write('|'),write('___'),write('|'),write('___'),write('|'),write('___'),write('|'),nl, X is Y-1 ,affiche_plat(X ).

/* Implémentation de l'affichage : mode xpce */
crea_dialog:- new(@d, dialog('Siam')),send(@d, size, size(560,530)).

show(Bo) :- flatten(Bo,Fb), sh_aux(Fb,0), send(@d, open).

sh_aux([],_).
sh_aux([H|T],N):-  
                new(I1, image('red.jpg')),%new(B1,bitmap(I1)) ,
                new(I2, image('black.jpg')),%new(B2,bitmap(I2)) ,
                new(I3, image('vide.jpg')),%new(B3,bitmap(I3)) ,
                new(Dors, button(N, message(@d, return, N) )  ),
                ( 
                    (H = black) -> send(Dors,label(I1) ); 
                    (H = white) -> send(Dors,label(I2) );
                    (H = empty) -> send(Dors,label(I3) ) 
                ),
                ( 
                    (0 is mod(N,8)  )-> send(@d,append,Dors,below); send(@d,append,Dors,right)
                ) ,
                N1 is N+1, sh_aux(T,N1).
                
                    inutile:- writeln("Inutile d'appuyer ici").

    human_select_move(Move, MovesList):-free(@nameItem),
    									new(@nameItem, button("A toi homme", message(@prolog, inutile) )),
    									send(@d, display, @nameItem, point(0,500)),
    									get(@d, confirm, Rval),
    									SelectedColumn is mod(Rval,8), SelectedRow is (Rval - SelectedColumn)/8,
    									member(Move, MovesList),
    									nth0(0, Move, SelectedRow), nth0(1, Move, SelectedColumn).
    human_select_move(Move, MovesList):- writeln('Not a valid move'),human_select_move(Move, MovesList).


