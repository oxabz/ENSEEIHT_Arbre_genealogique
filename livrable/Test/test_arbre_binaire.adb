with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with p_arbre_binaire;
procedure test_arbre_binaire is
    TEST_ECHOUE : exception;


    procedure afficher_element(x:integer) is

    begin -- Afficher
        put(x,3);
    end afficher_element;
    function compare(x,y:integer) return boolean is
    begin
        return x=y;
    end compare;
    package IntArbreBinaire is new p_arbre_binaire(integer, "=",afficher_element); use IntArbreBinaire;
    arbre : IntArbreBinaire.T_AB;
begin
    put_line("############ Init + Affichage ########################");
    init(arbre, 1);
    afficher(arbre, 0, "gauche", "droite");
    pragma Assert(not is_null(arbre), "initialisation");
    new_line;

    put_line("############ Insertion + Affichage ###################");
    inserer_gauche(arbre , 2);
    pragma Assert(get_racine_element(get_SA_gauche(arbre)) = 2, "insertion");
    inserer_droit(arbre , 3);
    pragma Assert(get_racine_element(get_SA_droit(arbre)) = 3, "insertion");
    afficher(arbre, 0, "gauche", "droite");
    new_line;

    put_line("############ Insertion + recherche + Affichage #######");
    inserer_gauche(rechercher(arbre, 2),4);
    inserer_droit(rechercher(arbre, 2),5);
    inserer_gauche(rechercher(arbre, 3),6);
    inserer_droit(rechercher(arbre, 3),7);
    inserer_gauche(rechercher(arbre, 4),8);
    inserer_droit(rechercher(arbre, 4),9);
    pragma Assert(get_racine_element(rechercher(arbre, 2))=2, "recherche");
    pragma Assert(get_racine_element(rechercher(arbre, 3))=3, "recherche");
    pragma Assert(get_racine_element(rechercher(arbre, 4))=4, "recherche");
    pragma Assert(get_racine_element(rechercher(arbre, 5))=5, "recherche");
    pragma Assert(get_racine_element(rechercher(arbre, 6))=6, "recherche");
    pragma Assert(is_null(rechercher(arbre, 20)), "recherche");
    afficher(arbre, 0, "gauche", "droite");
    begin
        inserer_droit(rechercher(arbre, 4),9);
        raise TEST_ECHOUE;
    exception
        when  INSERTION_ERROR=>
            put_line("Erreur attendu levée");
    end;
    new_line;

    put_line("############ Suprimer + Affichage ####################");
    supprimer(arbre, 4);
    pragma Assert(is_null(rechercher(arbre, 4)), "recherche");
    afficher(arbre, 0, "gauche", "droite");
    begin
        supprimer(arbre, 9000);
        raise TEST_ECHOUE;
    exception
        when  NOEUD_ABSENT_ERROR=>
            put_line("Erreur attendu levée");
    end;
    new_line;

    put_line("############ Suprimer + Affichage ####################");
    put("Taille : "); put (calcul_taille(arbre)); new_line;
    pragma Assert(calcul_taille(arbre) = 6);
end test_arbre_binaire;