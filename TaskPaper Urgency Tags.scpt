/*
Compare TaskPaper item @due date to current date and add (or remove) @today, @tomorrow, or @overdue

Lang: JavaScript for Automation
Use case: Tag-based coloring/formatting of items that are due soon/overdue (customize in LESS stylesheet)
Adapted from: https://support.hogbaysoftware.com/t/script-theme-tweak-to-add-colors-to-anything-due-today-or-tomorrow/1556/3

dickansj@github
*/

function TaskPaperContextScript(editor, options) {
    var today = DateTime.format('today');
    var outline = editor.outline;

// Removes urgency tags from items due after tomorrow (in case @due date was changed)
    outline.groupUndoAndChanges(function () {
        outline.evaluateItemPath('//@due > [d] tomorrow except /Archive//*')
            .forEach(function (each) {
	  			each.removeAttribute('data-today');
				each.removeAttribute('data-tomorrow');
	  			each.removeAttribute('data-overdue');
    		});
  		 });

// Adds @today to each item whose @due date is today, removes @tomorrow
    outline.groupUndoAndChanges(function () {
        outline.evaluateItemPath('//@due = [d] today except /Archive//*')
            .forEach(function (each) {
	  			each.setAttribute('data-today','');
				each.removeAttribute('data-tomorrow');
    		});
  		 });

// Adds @tomorrow to each item whose @due date is tomorrow
        outline.evaluateItemPath('//@due = [d] tomorrow except /Archive//*')
            .forEach(function (each) {
      			each.setAttribute('data-tomorrow', '');
    		});

// Adds @overdue (and @today if necessary) to each item whose @due date is before today
        outline.evaluateItemPath('//@due < [d] today except /Archive//*')
            .forEach(function (each) {
      			each.setAttribute('data-overdue', '');
	  			each.setAttribute('data-today','');
    		});
}

Application("TaskPaper")
    .documents[0].evaluate({
        script: TaskPaperContextScript.toString()
    })
