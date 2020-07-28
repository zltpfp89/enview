(function (factory) {
    if (typeof define === 'function' && define.amd) {
        define(['moment-with-locales.min'], factory);
    } else if(typeof module !== 'undefined' && module.exports) {
        var moment = require('moment-with-locales.min');
        factory(moment);
    } else {
        factory(moment);
    }
}(function(moment){
	window.moment = moment;
	return moment;
}));