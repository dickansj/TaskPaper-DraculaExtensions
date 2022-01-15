/*                                                                           
┌──────────────────────────────────────────────────────────┐                 
│ ════════════════════════════════════════════════════════ │                 
│ Enclose TaskPaper item in brackets when @wip is applied  │                 
│ ════════════════════════════════════════════════════════ │                 
│                 Author: dickansj@github                  │                 
│                 Last updated: 2021-12-25                 │                 
│                                                          │                 
│           Language: JavaScript for Automation            │                 
│Use case: Tag-based string manipulation of TaskPaper items│                 
└──────────────────────────────────────────────────────────┘                 
*/                                                                           
                                                                             
function TaskPaperContextScript(editor, options) {                           
    var outline = editor.outline                                             
    var selection = editor.selection                                         
                                                                             
    outline.groupUndoAndChanges(function () {                                
        outline.evaluateItemPath('//@wip')                                   
            .forEach(function (each) {                                       
                                                                             
                // Only proceed if content string doesn't already have a     
bracket                                                                      
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