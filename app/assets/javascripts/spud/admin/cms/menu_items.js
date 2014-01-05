spud.admin.cms.menu_items = {};

(function() {
  var menu_items = spud.admin.cms.menu_items;
  var menuId = 0;
  menu_items.init = function(id) {
    menuId = id;
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
        menu_items.save.call(menu_items);
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

  menu_items.save = function() {
    var menuItems = $('#root_menu_list > li > .menu-item-row');

    var orderArray = []
    menu_items.buildOrderArray(menuItems, orderArray);

    // Post To Menu Items Save method
    $.ajax({
      url: "/spud/admin/menus/" + menuId + "/menu_items/sort",
      type: 'post',
      data: {menu_order: JSON.stringify(orderArray), _method: 'put'}
    });

  };

  menu_items.buildOrderArray = function(menuItems,orderArray) {
    for(var counter=0;counter < menuItems.length; counter++) {
      var menuItem = $(menuItems[counter]);
      var menuHash = {id: menuItem.attr('data-menu-item-id'), order: []}
      var subItems = menuItem.parent().find(' > .menu_list > li > .menu-item-row');
      if(subItems && subItems.length > 0) {
        menu_items.buildOrderArray(subItems, menuHash.order)
      }
      orderArray.push(menuHash)
    }
  }

})();
