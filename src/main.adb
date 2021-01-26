with p_personne; use p_personne;
with p_arbre_genealogique; use p_arbre_genealogique;
with ada.strings; use ada.strings;
with ada.strings.unbounded; use ada.strings.unbounded;
with Ada.Text_IO; use ada.Text_IO;
with Ada.Integer_Text_IO; use ada.Integer_Text_IO;
with P_Front; use P_Front;

procedure main is
    arbre : T_AG;
    p : T_Personne;
    input : character;

begin
    clear_console;
    p := prompt_person(To_Unbounded_String("INITIALISATION"), To_Unbounded_String("Personne à la racine de l'arbre genalogique"));
    init(arbre, p);
    loop
        clear_console;
        afficher(arbre);
        input := prompt_menu;
        exit when input = 'e'; 
        case input is
            when 'a'=>
                declare
                   parent: T_Personne;
                   t: E_Parent;
                   individu : integer;
                begin
                    prompt_ajout(individu, t);
                    parent := prompt_person(To_Unbounded_String("AJOUTER PARENT 2/2"), To_Unbounded_String("Parent à ajouter"));
                    ajout_parent(arbre, t, individu, parent);
                exception
                    when  p_AB_Person.NOEUD_ABSENT_ERROR=>
                        error_message(To_Unbounded_String("ID du fils non existante"));
                    when  p_AB_Person.INSERTION_ERROR=>
                        error_message(To_Unbounded_String("L'individue a deja un parent de se genre"));
                end;
            when 's'=>
                declare
                   individu : integer;
                begin
                    individu := prompt_integer(To_Unbounded_String("SUPPRIMER INDIVIDUE"), To_Unbounded_String("Id de l'individue a supprimer"));
                    supprimer(arbre, get_dummy(individu));
                exception
                    when  p_AB_Person.NOEUD_ABSENT_ERROR=>
                        error_message(To_Unbounded_String("Aucun individue ayant cet ID"));
                end;
            when 'c'=>
                declare
                   individu : integer;
                begin
                    individu := prompt_integer(To_Unbounded_String("ID"), To_Unbounded_String("Id get content "));
                    create_box(To_Unbounded_String("NOMBRE D'ANCETRES"), 4);
                    put(nombre_ancetres(arbre, individu));
                    skip_line;
                exception
                    when  p_AB_Person.NOEUD_ABSENT_ERROR=>
                        error_message(To_Unbounded_String("Aucun individue ayant cet ID"));
                end;
            when 't'=>
                declare
                   individu,generation : integer;
                begin
                    individu := prompt_integer(To_Unbounded_String("TROUVER ANCETRES 1/2"), To_Unbounded_String("id de l'individue : "));
                    generation := prompt_integer(To_Unbounded_String("TROUVER ANCETRES 2/2"), To_Unbounded_String("generation a trouver : "));
                    case generation is
                        when 1 => 
                            create_box(To_Unbounded_String("ANCETRES DE PREMIERE GENERATION"),4);
                        when 2 => 
                            create_box(To_Unbounded_String("ANCETRES DE SECOND GENERATION"),4);
                        when others=>
                            create_box(To_Unbounded_String("ANCETRES DE "&Integer'Image(generation)&"EME GENERATION"),4);
                    end case;
                    put(get_ancetre_generation(arbre, individu, generation));
                    skip_line;
                exception
                    when  p_AB_Person.NOEUD_ABSENT_ERROR=>
                        error_message(To_Unbounded_String("Aucun individue ayant cet ID"));
                end;
            when 'T'=>
                declare
                   individu,generation : integer;
                begin
                    individu := prompt_integer(To_Unbounded_String("TROUVER SUITE ANCETRES 1/2"), To_Unbounded_String("id de l'individue : "));
                    generation := prompt_integer(To_Unbounded_String("TROUVER SUITE ANCETRES 2/2"), To_Unbounded_String("generation a trouver : "));
                    case generation is
                        when 1 => 
                            create_box(To_Unbounded_String("SUITE DES ANCETRES DE PREMIERE GENERATION"),10);
                        when 2 => 
                            create_box(To_Unbounded_String("SUITE DES ANCETRES DE SECOND GENERATION"),10);
                        when others=>
                            create_box(To_Unbounded_String("SUITE DES ANCETRES DE "&Integer'Image(generation)&"EME GENERATION"),10);
                    end case;
                    new_line;
                    afficher(get_succession_ancetre_generation(arbre, individu, generation));
                    skip_line;
                exception
                    when  p_AB_Person.NOEUD_ABSENT_ERROR=>
                        error_message(To_Unbounded_String("Aucun individue ayant cet ID"));
                end;
            when 'd'=>
                declare
                   individu,generation : integer;
                begin
                    individu := prompt_integer(To_Unbounded_String("TROUVER DECENDANT 1/2"), To_Unbounded_String("id de l'individue : "));
                    generation := prompt_integer(To_Unbounded_String("TROUVER DECENDANT 2/2"), To_Unbounded_String("generation a trouver : "));
                    case generation is
                        when 1 => 
                            create_box(To_Unbounded_String("DECENDANTS DE PREMIERE GENERATION"),4);
                        when 2 => 
                            create_box(To_Unbounded_String("DECENDANTS DE SECOND GENERATION"),4);
                        when others=>
                            create_box(To_Unbounded_String("DECENDANTS DE "&Integer'Image(generation)&"EME GENERATION"),4);
                    end case;
                    put(get_decendant_generation(arbre, individu, generation));
                    skip_line;
                exception
                    when  p_AB_Person.NOEUD_ABSENT_ERROR=>
                        error_message(To_Unbounded_String("Aucun individue ayant cet ID"));
                end;
            when 'D'=>
                declare
                   individu,generation : integer;
                begin
                    individu := prompt_integer(To_Unbounded_String("TROUVER SUITE DECENDANT 1/2"), To_Unbounded_String("id de l'individue : "));
                    generation := prompt_integer(To_Unbounded_String("TROUVER SUITE DECENDANT 2/2"), To_Unbounded_String("generation a trouver : "));
                    case generation is
                        when 1 => 
                            create_box(To_Unbounded_String("SUITE DES DECENDANTS DE PREMIERE GENERATION"),4);
                        when 2 => 
                            create_box(To_Unbounded_String("SUITE DES DECENDANTS DE SECOND GENERATION"),4);
                        when others=>
                            create_box(To_Unbounded_String("SUITE DES DECENDANTS DE "&Integer'Image(generation)&"EME GENERATION"),4);
                    end case;
                    put(get_sucession_decendant_generation(arbre, individu, generation));
                    skip_line;
                exception
                    when  p_AB_Person.NOEUD_ABSENT_ERROR=>
                        error_message(To_Unbounded_String("Aucun individue ayant cet ID"));
                end;
            when 'z' =>
                create_box(To_Unbounded_String("INDIVIDUES AYANT 0 PARENT"), 3);
                put(get_zero_parent(arbre));
                skip_line;
            when 'u' =>
                create_box(To_Unbounded_String("INDIVIDUES AYANT 1 PARENT"), 3);
                put(get_un_parent(arbre));
                skip_line;
            when '2' =>
                create_box(To_Unbounded_String("INDIVIDUES AYANT 2 PARENTS"), 3);
                put(get_deux_parent(arbre));
                skip_line;
            when 'r' =>
                p := prompt_person(To_Unbounded_String("INITIALISATION"), To_Unbounded_String("Personne à la racine de l'arbre genalogique"));
                init(arbre, p);
            when others =>
                error_message(To_Unbounded_String("Commande Inconue"));
        end case;
    end loop;
end main;