with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ArbreGenealogique; use arbreGenealogique;
with Persone; use Persone;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure T_arbre_genealogique is
    arbre: T_AG;
    p0,p1,p2,p3,p4,p5,p6,p7 : T_Personne;
    nb: integer;
begin
    put_line("############ Init + Affichage #############");
    init(p0, To_Unbounded_String("bernard"), To_Unbounded_String("ermite"));
    init(arbre, p0);
    afficher(arbre, get_id(p0));
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
    afficher(arbre, get_id(p0));
    new_line;

    put_line("############# Nombre ancetres #############");
    nb := nombre_ancetres(arbre,get_id(p0));
    put("Nombre ancetres de 1 : "); put(nb); new_line;
    pragma Assert(nb=8, "Nombre d'ancetres incorecte");
    put("Nombre ancetres de 6 : "); put(nombre_ancetres(arbre,get_id(p5))); new_line;
    new_line;

    put_line("########## Ancetres de generation #########");
    put("Ancetres de 1 de deuxieme generation : "); put(get_ancetre_generation(arbre,get_id(p0),2)); new_line;
    put("Ancetres de 6 de premiere generation : "); put(get_ancetre_generation(arbre,get_id(p5),1)); new_line;
    new_line;
    
    put_line("################ Supprimer ################");
    supprimer(arbre, p5);
    afficher(arbre, get_id(p0));
    ajout_parent(arbre, PERE, get_id(p2), p5);
    ajout_parent(arbre, PERE, get_id(p5), p6);
    ajout_parent(arbre, MERE, get_id(p5), p7);
    new_line;

    put_line("########## nombre de parent #########");
    put("A un parent : "); put(get_un_parent(arbre)); new_line;
    put("A deux parents : "); put(get_deux_parent(arbre)); new_line;
    put("A zero parent : "); put(get_zero_parent(arbre)); new_line;

    put_line("########## Ancetres de generation #########");
    put_line("Ancetres de 1 de deuxieme generation : "); 
    afficher(get_succession_ancetre_generation(arbre, get_id(p0), 2), get_id(p0));
    put_line("Ancetres de 6 de premiere generation : "); 
    afficher(get_succession_ancetre_generation(arbre, get_id(p5) , 1));
    new_line;

    put_line("############### Descendants ###############");
    put("descendant de 5 de deuxieme generation : "); put(get_decendant_generation(arbre, get_id(p4),2)); new_line;
    put("succession de descendant de 5 de deuxieme generation : "); put(get_sucession_decendant_generation(arbre, get_id(p4),2)); new_line;
    new_line;

end T_arbre_genealogique;