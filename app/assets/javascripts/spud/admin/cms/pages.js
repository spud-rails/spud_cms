spud.admin.cms.pages = {};

(function(){
  var pages = spud.admin.cms.pages;


  pages.initFormTabs = function(){
    var tabNames = [];

    $('.formtabs .formtab').each(function(tabind) {
      if(tabind === 0) {
        $(this).addClass('active');
      }
      this.id = 'tab-' + tabind;
      tabNames.push($('.tab_name',this).first().val());
    });

    var tabButtons = $('.formtabs .formtab_buttons').first();
    for(var x=0;x<tabNames.length;x++)
    {
      var tabButton = $('<li><a class="spud-page-tab-button" href="#tab-' + x + '" data-toggle="tab">' + tabNames[x] + '</a></li>');
      if(x === 0) {
        tabButton.addClass('active');
      }
      tabButtons.append(tabButton);

    }
    pages.tabMonitor();
  };
  pages.tabMonitor = function() {
    $('a.spud-page-tab-button[data-toggle="tab"]').on('shown', function (e) {
      var editors = $(e.target).find('.spud-formatted-editor');
      spud.admin.editor.unload('.formtab [code-mirror-id]')
      spud.admin.editor.init(editors);
    })
  };
})();
