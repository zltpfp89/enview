
dojo.provide("dojo.i18n.common");
dojo.i18n.getLocalization = function(packageName, bundleName, locale){dojo.hostenv.preloadLocalizations();
locale = dojo.hostenv.normalizeLocale(locale);
var elements = locale.split('-');
var module = [packageName,"nls",bundleName].join('.');
var bundle = dojo.hostenv.findModule(module, true);
var localization;
for(var i = elements.length; i > 0; i--){var loc = elements.slice(0, i).join('_');
if(bundle[loc]){localization = bundle[loc];
break;
}}
if(!localization){localization = bundle.ROOT;
}
if(localization){var clazz = function(){};
clazz.prototype = localization;
return new clazz();
}
dojo.raise("Bundle not found: " + bundleName + " in " + packageName+" , locale=" + locale);
};
dojo.i18n.isLTR = function(locale){var lang = dojo.hostenv.normalizeLocale(locale).split('-')[0];
var RTL = {ar:true,fa:true,he:true,ur:true,yi:true};
return !RTL[lang];
};
