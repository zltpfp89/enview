
dojo.provide("dojo.widget.LinkPane");
dojo.require("dojo.widget.*");
dojo.require("dojo.widget.ContentPane");
dojo.require("dojo.html.style");
dojo.widget.defineWidget(
"dojo.widget.LinkPane",
dojo.widget.ContentPane,
{templateString: '<div class="dojoLinkPane"></div>',
fillInTemplate: function(args, frag){var source = this.getFragNodeRef(frag);
this.label += source.innerHTML;
var source = this.getFragNodeRef(frag);
dojo.html.copyStyle(this.domNode, source);
}});
