
dojo.provide("dojo.data.old.provider.Delicious");
dojo.require("dojo.data.old.provider.FlatFile");
dojo.require("dojo.data.old.format.Json");
dojo.data.old.provider.Delicious = function() {dojo.data.old.provider.FlatFile.call(this);
if (Delicious && Delicious.posts) {dojo.data.old.format.Json.loadDataProviderFromArrayOfJsonData(this, Delicious.posts);
} else {}
var u = this.registerAttribute('u');
var d = this.registerAttribute('d');
var t = this.registerAttribute('t');
u.load('name', 'Bookmark');
d.load('name', 'Description');
t.load('name', 'Tags');
u.load('type', 'String');
d.load('type', 'String');
t.load('type', 'String');
};
dojo.inherits(dojo.data.old.provider.Delicious, dojo.data.old.provider.FlatFile);
