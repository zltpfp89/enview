/*
@license

dhtmlxGantt v.4.0.0 Professional
This software is covered by DHTMLX Enterprise License. Usage without proper license is prohibited.

(c) Dinamenta, UAB.
*/
gantt.config.smart_rendering=!0,gantt._smart_render={getViewPort:function(){var t=this.getScrollSizes(),e=gantt._restore_scroll_state();return e.y=Math.min(t.y_inner-t.y,e.y),{y:e.y,y_end:e.y+t.y}},getScrollSizes:function(){var t=gantt._scroll_sizes();return t.x=t.x||0,t.y=t.y||gantt._order.length*gantt.config.row_height,t},isInViewPort:function(t,e){return!!(t.y<e.y_end&&t.y_end>e.y)},isTaskDisplayed:function(t){return this.isInViewPort(this.getTaskPosition(t),this.getViewPort())},isLinkDisplayed:function(t){
return this.isInViewPort(this.getLinkPosition(t),this.getViewPort())},getTaskPosition:function(t){var e=gantt.getTaskTop(t);return{y:e,y_end:e+gantt.config.row_height}},getLinkPosition:function(t){var e=gantt.getLink(t),i=gantt.getTaskTop(e.source),n=gantt.getTaskTop(e.target);return{y:Math.min(i,n),y_end:Math.max(i,n)+gantt.config.row_height}},getRange:function(t){t=t||0;var e=this.getViewPort(),i=Math.floor(Math.max(0,e.y)/gantt.config.row_height)-t,n=Math.ceil(Math.max(0,e.y_end)/gantt.config.row_height)+t,a=gantt._order.slice(i,n);
return a},_redrawItems:function(t,e){for(var i in t){var n=t[i];for(var i in n.rendered)n.hide(i);for(var a=0;a<e.length;a++)n.restore(e[a])}},_getVisibleTasks:function(){return gantt._get_tasks_data()},_getVisibleLinks:function(){for(var t=[],e=gantt._get_links_data(),i=0;i<e.length;i++)this.isLinkDisplayed(e[i].id)&&t.push(e[i]);return t},updateRender:function(){this._redrawItems(gantt._get_task_renderers(),this._getVisibleTasks()),this._redrawItems(gantt._get_link_renderers(),this._getVisibleLinks());
},cached:{},_takeFromCache:function(t,e,i){this.cached[i]||(this.cached[i]=null);var n=this.cached[i];return void 0!==t?(n||(n=this.cached[i]={}),void 0===n[t]&&(n[t]=e(t)),n[t]):(n||(n=e()),n)},initCache:function(){for(var t=["getLinkPosition","getTaskPosition","isTaskDisplayed","isLinkDisplayed","getViewPort","getScrollSizes"],e=0;e<t.length;e++){var i=t[e],n=gantt.bind(this[i],this);this[i]=function(t,e){return function(i){return this._takeFromCache(i,t,e)}}(n,i)}this.invalidateCache(),this.initCache=function(){};
},invalidateCache:function(){function t(){s.cached.getViewPort=null,s.cached.getScrollSizes=null,s.cached.isTaskDisplayed=null,s.cached.isLinkDisplayed=null}function e(){s.cached.isTaskDisplayed=null,s.cached.isLinkDisplayed=null,s.cached.getLinkPosition=null,s.cached.getTaskPosition=null}function i(){t(),e()}function n(t){s.cached.isTaskDisplayed&&(s.cached.isTaskDisplayed[t]=void 0),s.cached.getTaskPosition&&(s.cached.getTaskPosition[t]=void 0)}function a(t){s.cached.isLinkDisplayed&&(s.cached.isLinkDisplayed[t]=void 0),
s.cached.getLinkPosition&&(s.cached.getLinkPosition[t]=void 0)}var s=this;gantt.attachEvent("onClear",function(){i()}),gantt.attachEvent("onParse",function(){i()}),gantt.attachEvent("onAfterLinkUpdate",a),gantt.attachEvent("onAfterTaskAdd",i),gantt.attachEvent("onAfterTaskDelete",i),gantt.attachEvent("onAfterTaskUpdate",n),gantt.attachEvent("onGanttScroll",t),gantt.attachEvent("onDataRender",i),this.invalidateCache=function(){}}},gantt._smart_render.initCache(),gantt.attachEvent("onGanttScroll",function(t,e,i,n){
gantt.config.smart_rendering&&e!=n&&gantt._smart_render.updateRender()}),gantt.attachEvent("onDataRender",function(){gantt.config.smart_rendering&&gantt._smart_render.updateRender()}),function(){function t(t,e){return function(){return gantt.config.smart_rendering?e.apply(this,arguments):t.apply(this,arguments)}}var e=gantt._get_task_filters;gantt._get_task_filters=t(gantt._get_task_filters,function(){var t=e.call(gantt);return t.push(function(t){return gantt.config.smart_rendering?gantt._smart_render.isTaskDisplayed(t):!0;
}),t});var i=gantt._get_link_filters;gantt._get_link_filters=t(gantt._get_link_filters,function(){var t=i.call(gantt);return t.push(function(t){return gantt.config.smart_rendering?gantt._smart_render.isLinkDisplayed(t):!0}),t}),gantt._get_data_range=t(gantt._get_data_range,function(){return this._smart_render.getRange()})}();
//# sourceMappingURL=../sources/ext/dhtmlxgantt_smart_rendering.js.map