with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with p_arbre_genealogique; use p_arbre_genealogique;
with p_personne; use p_personne;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure test_arbre_genealogique is
    TEST_ECHOUE : exception;
    arbre,ab_test: T_AG;
    t : integer;
    p0,p1,p2,p3,p4,p5,p6,p7,tp: T_Personne;
    l: L_Personne;
begin
    put_line("############ Init + Affichage #############");
    init(p0, To_Unbounded_String("bernard"), To_Unbounded_String("ermite"));
    init(arbre, p0);
    afficher(arbre, get_id(p0));
    pragma Assert(not is_null(arbre), "pas initalisé");
    pragma Assert(get_racine_element(arbre)=p0, "pas initalisé");
    new_line;
    
    put_line("########## Insertion + Affichage ##########");
    init(p1, To_Unbounded_String("smith"), To_Unbounded_String("john"));
    init(p2, To_Unbounded_String("Ano"), To_Unbounded_String("nimous"));
    init(p3, To_Unbounded_String("Ano"), To_Unbounded_String("nimous"));
    init(p4, To_Unbounded_String("Ano"), To_Unbounded_String("nimous"));
    init(p5, To_Unbounded_String("Ano"), To_Unbounded_String("nimous"));
    init(p6, To_Unbounded_String("Ano"), To_Unbounded_String("nimous"));
    init(p7, To_Unbounded_String("Ano"), To_Unbounded_String("nimous"));
    ajout_parent(arbre, PERE, get_id(p0), p1);
    ajout_parent(arbre, MERE, get_id(p0), p2);
    ajout_parent(arbre, PERE, get_id(p1), p3);
    ajout_parent(arbre, MERE, get_id(p1), p4);
    ajout_parent(arbre, PERE, get_id(p2), p5);
    ajout_parent(arbre, PERE, get_id(p5), p6);
    ajout_parent(arbre, MERE, get_id(p5), p7);
    begin
        ajout_parent(arbre, PERE, 90, p7);
        raise TEST_ECHOUE;
    exception
        when  p_AB_Person.NOEUD_ABSENT_ERROR=>
            put_line("Erreur attendu levée");
    end;
    begin
        ajout_parent(arbre, PERE, get_id(p5), p7);
        raise TEST_ECHOUE;
    exception
        when  p_AB_Person.INSERTION_ERROR=>
            put_line("Erreur attendu levée");
    end;
    afficher(arbre, get_id(p0));
    pragma Assert(
        get_racine_element(get_SA_droit(arbre))=p1,
        "insertion 1/7"
    );
    pragma Assert(
        get_racine_element(get_SA_gauche(arbre))=p2,
        "insertion 2/7"
    );
    pragma Assert(
        get_racine_element(get_SA_droit(get_SA_droit(arbre)))=p3,
        "insertion 3/7"
    );
    pragma Assert(
        get_racine_element(get_SA_gauche(get_SA_droit(arbre)))=p4,
        "insertion 4/7"
    );
    pragma Assert(
        get_racine_element(get_SA_droit(get_SA_gauche(arbre)))=p5,
        "insertion 5/7"
    );
    pragma Assert(
        get_racine_element(get_SA_droit(get_SA_droit(get_SA_gauche(arbre))))=p6,
        "insertion 6/7"
    );
    pragma Assert(
        get_racine_element(get_SA_gauche(get_SA_droit(get_SA_gauche(arbre))))=p7,
        "insertion 7/7"
    );
    new_line;

    put_line("############# Nombre ancetres #############");
    t:= nombre_ancetres(arbre,get_id(p0));
    put("Nombre ancetres de 1 : "); put(t); new_line;
    pragma Assert(t=8, "nombre incorecte");
    t:= nombre_ancetres(arbre,get_id(p5));
    put("Nombre ancetres de 6 : "); put(t); new_line;
    pragma Assert(t=3, "nombre incorecte");
    begin
        t:=nombre_ancetres(arbre, 90);
        raise TEST_ECHOUE;
    exception
        when  p_AB_Person.NOEUD_ABSENT_ERROR=>
            put_line("Erreur attendu levée");
    end;
    new_line;

    put_line("########## Ancetres de generation #########");
    l:= get_ancetre_generation(arbre,get_id(p0),2);
    put("Ancetres de 1 de deuxieme generation : "); put(l); new_line;
    pragma Assert(not isEmpty(find(l, p5)) and not isEmpty(find(l, p4)) and not isEmpty(find(l, p3)));
    l:= get_ancetre_generation(arbre,get_id(p5),1);
    put("Ancetres de 6 de premiere generation : "); put(l); new_line;
    pragma Assert(not isEmpty(find(l, p7)) and not isEmpty(find(l, p6)));
    begin
        l := get_ancetre_generation(arbre, 90, 2);
        raise TEST_ECHOUE;
    exception
        when  p_AB_Person.NOEUD_ABSENT_ERROR=>
            put_line("Erreur attendu levée");
    end;
    new_line;
    
    put_line("################ Supprimer ################");
    supprimer(arbre, p5);
    afficher(arbre, get_id(p0));
    pragma Assert(
        is_null(get_SA_droit(get_SA_gauche(arbre))),
        "suppression"
    );
    ajout_parent(arbre, PERE, get_id(p2), p5);
    ajout_parent(arbre, PERE, get_id(p5), p6);
    ajout_parent(arbre, MERE, get_id(p5), p7);
    pragma Assert(not isEmpty(find(l, p7)) and not isEmpty(find(l, p6)));
    begin
        supprimer(arbre, get_dummy(90));
        raise TEST_ECHOUE;
    exception
        when  p_AB_Person.NOEUD_ABSENT_ERROR=>
            put_line("Erreur attendu levée");
    end;
    new_line;

    put_line("########## nombre de parent #########");
    l:=get_un_parent(arbre);
    put("A un parent : "); put(l); new_line;
    pragma Assert(not isEmpty(find(l, p2)));
    l:=get_deux_parent(arbre);
    put("A deux parents : "); put(l); new_line;
    pragma Assert(not isEmpty(find(l, p1)) and not isEmpty(find(l, p5)) and not isEmpty(find(l, p0)));
    l:=get_zero_parent(arbre);
    put("A zero parent : "); put(l); new_line;
    pragma Assert(not isEmpty(find(l, p3)) and not isEmpty(find(l, p4)) and not isEmpty(find(l, p6))and not isEmpty(find(l, p7)));

    put_line("########## Ancetres de generation #########");
    put_line("Ancetres de 1 de deuxieme generation : "); 
    ab_test := get_succession_ancetre_generation(arbre, get_id(p0), 2);
    afficher(ab_test);
    pragma Assert(
        get_racine_element(get_SA_droit(ab_test))=p1,
        "ancetre"
    );
    pragma Assert(
        get_racine_element(ab_test)=p0,
        "ancetre"
    );
    pragma Assert(
        get_racine_element(get_SA_gauche(ab_test))=p2,
        "ancetre"
    );
    pragma Assert(
        get_racine_element(get_SA_droit(get_SA_droit(ab_test)))=p3,
        "ancetre"
    );
    pragma Assert(
        get_racine_element(get_SA_gauche(get_SA_droit(ab_test)))=p4,
        "ancetre"
    );
    pragma Assert(
        get_racine_element(get_SA_droit(get_SA_gauche(ab_test)))=p5,
        "ancetre"
    );
    put_line("Ancetres de 6 de premiere generation : "); 
    ab_test := get_succession_ancetre_generation(arbre, get_id(p5), 1);
    afficher(ab_test);
    pragma Assert(
        get_racine_element(get_SA_droit(ab_test))=p6,
        "ancetre"
    );
    pragma Assert(
        get_racine_element(ab_test)=p5,
        "ancetre"
    );
    pragma Assert(
        get_racine_element(get_SA_gauche(ab_test))=p7,
        "ancetre"
    );
    begin
        ab_test := get_succession_ancetre_generation(arbre, 90, 2);
        raise TEST_ECHOUE;
    exception
        when  p_AB_Person.NOEUD_ABSENT_ERROR=>
            put_line("Erreur attendu levée");
    end;
    new_line;

    put_line("############### Descendants ###############");
    tp := get_decendant_generation(arbre, get_id(p4),2);
    put("descendant de 5 de deuxieme generation : "); put(tp); new_line;
    pragma Assert(get_id(tp) = 1);
    begin
        tp := get_decendant_generation(arbre, 90, 2);
        raise TEST_ECHOUE;
    exception
        when  p_AB_Person.NOEUD_ABSENT_ERROR=>
            put_line("Erreur attendu levée");
    end;
    l:=get_sucession_decendant_generation(arbre, get_id(p4),2);
    put("succession de descendant de 5 de deuxieme generation : "); put(l); new_line;
    pragma Assert(not isEmpty(find(l, p0)) and not isEmpty(find(l, p1)));
    begin
        l := get_sucession_decendant_generation(arbre, 90, 2);
        raise TEST_ECHOUE;
    exception
        when  p_AB_Person.NOEUD_ABSENT_ERROR=>
            put_line("Erreur attendu levée");
    end;
    new_line;

end test_arbre_genealogique;