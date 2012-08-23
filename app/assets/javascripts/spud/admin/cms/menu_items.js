Spud = (typeof(Spud) == 'undefined') ? {} : Spud;
Spud.Admin = (typeof(Spud.Admin) == 'undefined') ? {} : Spud.Admin;
Spud.Admin.Cms = (typeof(Spud.Admin.Cms) == 'undefined') ? {} : Spud.Admin.Cms;

Spud.Admin.Cms.MenuItems = new function() {
  var self=this;

  self.editMode = false;
  self.mouseIsDown = false;
  self.init = function() {
    // $('.admin_application').effect('shake',{},100,self.shakeLoop)

    $('.sortable').sortable({
      connectWith:".connectedSortable",
      start: function(event,ui) {
        $('#root_menu_list').addClass('menu_edit');
      },
      axis:"y",
      tolerance:'pointer',
      cursor: "move",
      items:'li',
      stop: function(event,ui) {
        $('#root_menu_list').removeClass('menu_edit');
      },
      over: function(event,ui) {
        // console.log(event);
        var source = ui.item[0];
        // ui.placeholder.style.backgroundColor('#FAE7D9');
        var destination = $(event.target);
        // console.log(destination);
                  $('ul.left_guide').removeClass('left_guide');

        if(destination.hasClass('subitem'))
        {
          destination.addClass('left_guide');
        }
        // console.log(ui.item[0].innerHTML)
      }
    }).disableSelection();
    // $('.admin_application').addClass('jiggly')
    // $('.admin_application').draggable();
  };

}();
