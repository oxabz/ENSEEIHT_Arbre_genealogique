with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ArbreBinaire;
procedure T_ArbreBin is
    procedure afficher_element(x:integer) is

    begin -- Afficher
        put(x,3);
    end afficher_element;
    function compare(x,y:integer) return boolean is
    begin
        return x=y;
    end compare;
    package IntArbreBinaire is new ArbreBinaire(integer, "=",afficher_element); use IntArbreBinaire;
    arbre : IntArbreBinaire.T_AB;
begin
    put_line("Init + Affichage");
    init(arbre, 1);
    afficher(arbre, 0, "gauche", "droite");
    put_line("Insertion + Affichage");
    inserer_gauche(arbre , 2);
    inserer_droit(arbre , 3);
    afficher(arbre, 0, "gauche", "droite");
    put_line("Insertion + recherche + Affichage");
    inserer_gauche(rechercher(arbre, 2),4);
    inserer_droit(rechercher(arbre, 2),5);
    inserer_gauche(rechercher(arbre, 3),6);
    inserer_droit(rechercher(arbre, 3),7);
    inserer_gauche(rechercher(arbre, 4),8);
    inserer_droit(rechercher(arbre, 4),9);
    afficher(arbre, 0, "gauche", "droite");
    put_line("Suprimer + Affichage");
    supprimer(arbre, 4);
    afficher(arbre, 0, "gauche", "droite");
    put("Taille : "); put (calcul_taille(arbre)); new_line;
end T_ArbreBin;