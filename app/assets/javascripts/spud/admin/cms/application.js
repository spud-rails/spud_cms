//= require codemirror
//= require codemirror/modes/xml
//= require codemirror/modes/javascript
//= require codemirror/modes/css
//= require codemirror/modes/htmlmixed
//= require codemirror/modes/htmlembedded
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
       $('textarea.wysiwym').wymeditor({
        	basePath:'/assets/wymeditor/'
       });
   });