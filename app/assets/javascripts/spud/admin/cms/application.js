//= require codemirror
//= require codemirror/modes/xml
//= require codemirror/modes/javascript
//= require codemirror/modes/css
//= require codemirror/modes/htmlmixed
//= require codemirror/modes/htmlembedded
//= require spud/admin/cms/menu_items
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
	// initWysiwym();
	initTinyMCE();
	$("#spud_page_layout").bind('change', function() {
		var $this = $(this);
		$.get($this.attr("data-source"), { template: $this.val() }, function(data) {
			// $('.formtabs').tabs('destroy');


			$('textarea.tinymce').each(function() {$(this).tinymce().execCommand('mceRemoveControl',false,this.id)});
			$("#page_partials_form").replaceWith(data)
			initFormTabs();
			initTinyMCE();

		}, 'text').error(function(jqXHR) {
			$('<p> Error: ' + jqXHR.responseText + '</p>').dialog();
		});
	});
});
