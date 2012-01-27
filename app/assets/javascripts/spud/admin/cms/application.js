//= require codemirror
//= require codemirror/modes/xml
//= require codemirror/modes/javascript
//= require codemirror/modes/css
//= require codemirror/modes/htmlmixed
//= require codemirror/modes/htmlembedded
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
	initWysiwym();

	$("#spud_page_template_id").bind('change', function() {
		var $this = $(this);
		$.get($this.attr("data-source"), { template: $this.val() }, function(data) {
			$('.formtabs').tabs('destroy');
			$("#page_partials_form").replaceWith(data)
			initFormTabs();
			initWysiwym();
		}, 'text').error(function(jqXHR) {
			$('<p> Error: ' + jqXHR.responseText + '</p>').dialog();
		});
	});
});