with Ada.Text_IO; use Ada.Text_IO;
package body linked_list is

  procedure init(list : out T_linked_list)is
  begin
    list := null;
  end init;


  function isEmpty(list : in T_linked_list)return boolean is
  begin
    return list=null;
  end isEmpty;

  function getHead(list : in T_linked_list) return T is

  begin -- getHead
    return list.all.value;
  end getHead;


  procedure insertHead(list : in out T_linked_list; e : in T) is
    n : T_linked_list_cell;
  begin
    n.value := e;
    n.next := list;
    list := new T_linked_list_cell'(n);
  end insertHead;

  procedure put(list : in T_linked_list) is
    curr : T_linked_list := list;
  begin
    put("[");
    while curr/=null loop
      afficher(curr.all.value);
      curr := curr.all.next;
      put(", ");
    end loop;
    put(Character'val(8)&Character'val(8)&"]");
  end put;


  function find(list : in T_linked_list; e :in T) return T_linked_list is
    curr : T_linked_list := list;
  begin
    while curr/=null and then curr.all.value/=e loop
      curr := curr.all.next;
    end loop;
    return curr;
  end find;


  procedure insertAfter(list : in out T_linked_list; d,e : in T) is
    cell : T_linked_list;
    n : T_linked_list_cell;
  begin
    if list = null then
      n.value := e;
      n.next := null;
      list := new T_linked_list_cell'(n);
      return;
    end if;
    cell := find(list,d);
    n.value := e;
    n.next := cell.all.next;
    cell.all.next := new T_linked_list_cell'(n);
  end insertAfter;


  procedure insertBefore(list : in out T_linked_list; d,e : in T) is
    n : T_linked_list_cell;
  begin

    if( list = null or else list.all.value = d ) then
      n.value := e;
      n.next := list;
      list := new T_linked_list_cell'(n);
      return;
    end if;

    insertBefore(list.all.next, d, e);
  end insertBefore;


  procedure remove(list : in out T_linked_list; e :in T) is
    procedure removerec(list : in out T_linked_list; e :in T) is
    begin -- removerec
        if list = null then
          return;
        end if;
        if list.all.value = e then
          list := list.all.next;
          removerec(list,e);
        else
          removerec(list.all.next,e);
        end if;
    end removerec;
  begin
    removerec(list,e);
  end remove;

end linked_list;
