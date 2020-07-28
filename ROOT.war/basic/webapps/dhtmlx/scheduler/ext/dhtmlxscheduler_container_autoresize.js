/*
@license
dhtmlxScheduler v.4.3.25 Professional

This software is covered by DHTMLX Enterprise License. Usage without proper license is prohibited.

(c) Dinamenta, UAB.
*/
Scheduler.plugin(function(e){!function(){e.config.container_autoresize=!0,e.config.month_day_min_height=90,e.config.min_grid_size=25,e.config.min_map_size=400;var t=e._pre_render_events,a=!0,i=0,n=0;e._pre_render_events=function(r,s){if(!e.config.container_autoresize||!a)return t.apply(this,arguments);var o=this.xy.bar_height,d=this._colsS.heights,_=this._colsS.heights=[0,0,0,0,0,0,0],l=this._els.dhx_cal_data[0];if(r=this._table_view?this._pre_render_events_table(r,s):this._pre_render_events_line(r,s),
this._table_view)if(s)this._colsS.heights=d;else{var c=l.firstChild;if(c.rows){for(var h=0;h<c.rows.length;h++){if(_[h]++,_[h]*o>this._colsS.height-this.xy.month_head_height){var u=c.rows[h].cells,g=this._colsS.height-this.xy.month_head_height;1*this.config.max_month_events!==this.config.max_month_events||_[h]<=this.config.max_month_events?g=_[h]*o:(this.config.max_month_events+1)*o>this._colsS.height-this.xy.month_head_height&&(g=(this.config.max_month_events+1)*o);for(var v=0;v<u.length;v++)u[v].childNodes[1].style.height=g+"px";
_[h]=(_[h-1]||0)+u[0].offsetHeight}_[h]=(_[h-1]||0)+c.rows[h].cells[0].offsetHeight}_.unshift(0),c.parentNode.offsetHeight<c.parentNode.scrollHeight&&!c._h_fix}else if(r.length||"visible"!=this._els.dhx_multi_day[0].style.visibility||(_[0]=-1),r.length||-1==_[0]){var m=(c.parentNode.childNodes,(_[0]+1)*o+1);n!=m+1&&(this._obj.style.height=i-n+m-1+"px"),m+="px",l.style.top=this._els.dhx_cal_navline[0].offsetHeight+this._els.dhx_cal_header[0].offsetHeight+parseInt(m,10)+"px",l.style.height=this._obj.offsetHeight-parseInt(l.style.top,10)-(this.xy.margin_top||0)+"px";
var f=this._els.dhx_multi_day[0];f.style.height=m,f.style.visibility=-1==_[0]?"hidden":"visible",f=this._els.dhx_multi_day[1],f.style.height=m,f.style.visibility=-1==_[0]?"hidden":"visible",f.className=_[0]?"dhx_multi_day_icon":"dhx_multi_day_icon_small",this._dy_shift=(_[0]+1)*o,_[0]=0}}return r};var r=["dhx_cal_navline","dhx_cal_header","dhx_multi_day","dhx_cal_data"],s=function(t){i=0;for(var a=0;a<r.length;a++){var s=r[a],o=e._els[s]?e._els[s][0]:null,d=0;switch(s){case"dhx_cal_navline":case"dhx_cal_header":
d=parseInt(o.style.height,10);break;case"dhx_multi_day":d=o?o.offsetHeight-1:0,n=d;break;case"dhx_cal_data":var _=e.getState().mode;if(d=o.childNodes[1]&&"month"!=_?o.childNodes[1].offsetHeight:Math.max(o.offsetHeight-1,o.scrollHeight),"month"==_){if(e.config.month_day_min_height&&!t){var l=o.getElementsByTagName("tr").length;d=l*e.config.month_day_min_height}t&&(o.style.height=d+"px")}else if("year"==_)d=190*e.config.year_y;else if("agenda"==_){if(d=0,o.childNodes&&o.childNodes.length)for(var c=0;c<o.childNodes.length;c++)d+=o.childNodes[c].offsetHeight;
d+2<e.config.min_grid_size?d=e.config.min_grid_size:d+=2}else if("week_agenda"==_){for(var h,u,g=e.xy.week_agenda_scale_height+e.config.min_grid_size,v=0;v<o.childNodes.length;v++){u=o.childNodes[v];for(var c=0;c<u.childNodes.length;c++){for(var m=0,f=u.childNodes[c].childNodes[1],p=0;p<f.childNodes.length;p++)m+=f.childNodes[p].offsetHeight;h=m+e.xy.week_agenda_scale_height,h=1!=v||2!=c&&3!=c?h:2*h,h>g&&(g=h)}}d=3*g}else if("map"==_){d=0;for(var b=o.querySelectorAll(".dhx_map_line"),c=0;c<b.length;c++)d+=b[c].offsetHeight;
d+2<e.config.min_map_size?d=e.config.min_map_size:d+=2}else if(e._gridView)if(d=0,o.childNodes[1].childNodes[0].childNodes&&o.childNodes[1].childNodes[0].childNodes.length){for(var b=o.childNodes[1].childNodes[0].childNodes[0].childNodes,c=0;c<b.length;c++)d+=b[c].offsetHeight;d+=2,d<e.config.min_grid_size&&(d=e.config.min_grid_size)}else d=e.config.min_grid_size;if(e.matrix&&e.matrix[_])if(t)d+=2,o.style.height=d+"px";else{d=2;for(var y=e.matrix[_],x=y.y_unit,w=0;w<x.length;w++)d+=x[w].children?y.folder_dy||y.dy:y.dy;
}("day"==_||"week"==_||e._props&&e._props[_])&&(d+=2)}i+=d}e._obj.style.height=i+"px",t||e.updateView()},o=function(){if(!e.config.container_autoresize||!a)return!0;var t=e.getState().mode;s(),(e.matrix&&e.matrix[t]||"month"==t)&&window.setTimeout(function(){s(!0)},1)};e.attachEvent("onViewChange",o),e.attachEvent("onXLE",o),e.attachEvent("onEventChanged",o),e.attachEvent("onEventCreated",o),e.attachEvent("onEventAdded",o),e.attachEvent("onEventDeleted",o),e.attachEvent("onAfterSchedulerResize",o),
e.attachEvent("onClearAll",o),e.attachEvent("onBeforeExpand",function(){return a=!1,!0}),e.attachEvent("onBeforeCollapse",function(){return a=!0,!0})}()});
//# sourceMappingURL=../sources/ext/dhtmlxscheduler_container_autoresize.js.map