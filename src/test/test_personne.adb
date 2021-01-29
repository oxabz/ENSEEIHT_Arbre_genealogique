with Ada.Text_IO; use Ada.Text_IO;
with p_personne; use p_personne;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure test_person is
    p0,p1,p2: T_Personne;
begin
    put_line("############ Init + Affichage #############");
    init(p0, To_Unbounded_String("bernard"), To_Unbounded_String("ermite"));
    pragma Assert(get_id(p0)=1, "init 1/3 : id");
    pragma Assert(get_nom(p0)=To_Unbounded_String("bernard"), "init 1/3 : nom");
    pragma Assert(get_prenom(p0)=To_Unbounded_String("ermite"), "init 1/3 : prenom");
    put(p0);new_line;
    init(p1, To_Unbounded_String("daniel"), To_Unbounded_String("bis"));
    pragma Assert(get_id(p1)=2, "init 2/3 : id");
    pragma Assert(get_prenom(p1)=To_Unbounded_String("bis"), "init 2/3 : prenom");
    pragma Assert(get_nom(p1)=To_Unbounded_String("daniel"), "init 2/3 : nom");
    put(p0);new_line;
    init(p2, To_Unbounded_String("jean"), To_Unbounded_String("tris"));
    pragma Assert(get_id(p2)=3, "init 3/3 : id");
    pragma Assert(get_nom(p2)=To_Unbounded_String("jean"), "init 3/3 : nom");
    pragma Assert(get_prenom(p2)=To_Unbounded_String("tris"), "init 3/3 : prenom");
    put(p0);new_line;
    new_line;

    put_line("############ setters + Affichage #############");
    set_nom(p0,To_Unbounded_String("ermite"));
    set_prenom(p0,To_Unbounded_String("bernard"));
    put(p0);new_line;
    pragma Assert(get_nom(p0)=To_Unbounded_String("ermite"), "set_nom");
    pragma Assert(get_prenom(p0)=To_Unbounded_String("bernard"), "set_prenom");
end test_person;