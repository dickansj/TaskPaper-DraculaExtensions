/*
Enclose TaskPaper item in brackets when @wip is applied

Lang: JavaScript for Automation
Use case: Tag-based string manipulation of TaskPaper items

dickansj@github
*/

function TaskPaperContextScript(editor, options) {
	var outline = editor.outline
	var selection = editor.selection

    outline.groupUndoAndChanges(function () {
        outline.evaluateItemPath('//@wip')
            .forEach(function (each) {

            	// Only proceed if content string doesn't already have a bracket
            	if (each.bodyContentString.indexOf('[') == -1) {
            		const contentEnd = each.bodyContentString.length + 3;

	  				// Enclose content string with brackets
	  				// Content string starts at position 2
	  				each.replaceBodyRange(2,0,'[');
	  				each.replaceBodyRange(contentEnd,0,']');

            	}
    		});
  		 });

}

Application("TaskPaper")
    .documents[0].evaluate({
        script: TaskPaperContextScript.toString()
    })
