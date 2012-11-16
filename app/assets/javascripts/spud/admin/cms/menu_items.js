spud.admin.cms.menu_items = {};

(function() {
  var menu_items = spud.admin.cms.menu_items;

  menu_items.init = function() {
    return;
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

        var source = ui.item[0];

        var destination = $(event.target);
                  $('ul.left_guide').removeClass('left_guide');

        if(destination.hasClass('subitem'))
        {
          destination.addClass('left_guide');
        }
      }
    }).disableSelection();
  };

})();
