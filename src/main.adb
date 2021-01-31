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

    -- Initialisation de l'arbre 
    p := prompt_person(To_Unbounded_String("INITIALISATION"), To_Unbounded_String("Personne à la racine de l'arbre genalogique"));
    init(arbre, p);

    -- Boucle Principale du programme
    loop
        -- Affichage du menu
        clear_console;
        afficher(arbre);

        -- Entré de l'utilisateur
        input := prompt_menu;

        -- Sortie du programe si e est entré
        exit when input = 'e'; 

        -- Traitement des commande 
        case input is
            when 'a'=>
                -- Execution de la commande d'ajout de parent
                declare
                   parent: T_Personne;
                   t: E_Parent;
                   individu : integer;
                begin
                    -- Entrées utilisateur 
                    prompt_ajout(individu, t);
                    parent := prompt_person(To_Unbounded_String("AJOUTER PARENT 2/2"), To_Unbounded_String("Parent à ajouter"));
                    -- Execution
                    ajout_parent(arbre, t, individu, parent);
                exception
                    when  p_AB_Person.NOEUD_ABSENT_ERROR=>
                        error_message(To_Unbounded_String("ID du fils non existante"));
                    when  p_AB_Person.INSERTION_ERROR=>
                        error_message(To_Unbounded_String("L'individue a deja un parent de se genre"));
                end;
            when 's'=>
                -- Execution de la supression d'un individu 
                declare
                   individu : integer;
                begin
                    -- Entrées utilisateur 
                    individu := prompt_integer(To_Unbounded_String("SUPPRIMER INDIVIDUE"), To_Unbounded_String("Id de l'individue a supprimer"));
                    -- Execution
                    supprimer(arbre, get_dummy(individu));
                exception
                    when  p_AB_Person.NOEUD_ABSENT_ERROR=>
                        error_message(To_Unbounded_String("Aucun individue ayant cet ID"));
                end;
            when 'c'=>
                -- Execution du compte d'ancetre d'un individu
                declare
                   individu : integer;
                begin
                    -- Entrées utilisateur 
                    individu := prompt_integer(To_Unbounded_String("ID"), To_Unbounded_String("Id get content "));
                    -- Affichage du resultat
                    create_box(To_Unbounded_String("NOMBRE D'ANCETRES"), 4);
                    put(nombre_ancetres(arbre, individu));
                    skip_line;
                exception
                    when  p_AB_Person.NOEUD_ABSENT_ERROR=>
                        error_message(To_Unbounded_String("Aucun individue ayant cet ID"));
                end;
            when 't'=>
                -- Execution de la recherche d'ancetre
                declare
                   individu,generation : integer;
                begin
                    -- Entrée utilisateur
                    individu := prompt_integer(To_Unbounded_String("TROUVER ANCETRES 1/2"), To_Unbounded_String("id de l'individue : "));
                    generation := prompt_integer(To_Unbounded_String("TROUVER ANCETRES 2/2"), To_Unbounded_String("generation a trouver : "));
                    -- Affichage du resultat
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
                -- Execution de la recherche d'ancetre
                declare
                   individu,generation : integer;
                begin
                    -- Entrée utilisateur
                    individu := prompt_integer(To_Unbounded_String("TROUVER SUITE ANCETRES 1/2"), To_Unbounded_String("id de l'individue : "));
                    generation := prompt_integer(To_Unbounded_String("TROUVER SUITE ANCETRES 2/2"), To_Unbounded_String("generation a trouver : "));
                    -- Affichage du resultat
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
                -- Execution de la recherche de descendant 
                declare
                   individu,generation : integer;
                begin
                    -- Entrée utilisateur
                    individu := prompt_integer(To_Unbounded_String("TROUVER DECENDANT 1/2"), To_Unbounded_String("id de l'individue : "));
                    generation := prompt_integer(To_Unbounded_String("TROUVER DECENDANT 2/2"), To_Unbounded_String("generation a trouver : "));
                    -- Affichage du resultat
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
                -- Execution de la recherche des descendants
                declare
                   individu,generation : integer;
                begin
                    -- Entrée utilisateur
                    individu := prompt_integer(To_Unbounded_String("TROUVER SUITE DECENDANT 1/2"), To_Unbounded_String("id de l'individue : "));
                    generation := prompt_integer(To_Unbounded_String("TROUVER SUITE DECENDANT 2/2"), To_Unbounded_String("generation a trouver : "));
                    -- Affichage du resultat
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
                -- Affichage du resultat de la recherche d'individu ayant zero parent
                create_box(To_Unbounded_String("INDIVIDUES AYANT 0 PARENT"), 3);
                put(get_zero_parent(arbre));
                skip_line;
            when 'u' =>
                -- Affichage du resultat de la recherche d'individu ayant un parent
                create_box(To_Unbounded_String("INDIVIDUES AYANT 1 PARENT"), 3);
                put(get_un_parent(arbre));
                skip_line;
            when '2' =>
                -- Affichage du resultat de la recherche d'individu ayant deux parents
                create_box(To_Unbounded_String("INDIVIDUES AYANT 2 PARENTS"), 3);
                put(get_deux_parent(arbre));
                skip_line;
            when 'r' =>
                -- Reinitialisation de l'arbre
                p := prompt_person(To_Unbounded_String("INITIALISATION"), To_Unbounded_String("Personne à la racine de l'arbre genalogique"));
                init(arbre, p);
            when others =>
                error_message(To_Unbounded_String("Commande Inconue"));
        end case;
    end loop;
end main;