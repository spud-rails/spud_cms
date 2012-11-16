//= require_self
//= require spud/admin/cms/pages
//= require spud/admin/cms/menu_items

spud.admin.cms = {};

$(document).ready(function() {
	spud.admin.cms.pages.initFormTabs();

	$("#spud_page_layout").bind('change', function() {
		var $this = $(this);
		$.get($this.attr("data-source"), { template: $this.val() }, function(data) {

			spud.admin.editor.unload();

			$("#page_partials_form").replaceWith(data);
			spud.admin.cms.pages.initFormTabs();

			spud.admin.editor.init();

		}, 'text').error(function(jqXHR) {
			alert("Error: " + jqXHR.responseText);
		});
	});
});
