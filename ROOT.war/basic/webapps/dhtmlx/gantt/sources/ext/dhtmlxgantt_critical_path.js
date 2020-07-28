/*
@license

dhtmlxGantt v.4.0.0 Professional
This software is covered by DHTMLX Enterprise License. Usage without proper license is prohibited.

(c) Dinamenta, UAB.
*/
Gantt.plugin(function(gantt){

gantt.config.highlight_critical_path = false;
gantt._criticalPathHandler = function(){
	if(gantt.config.highlight_critical_path)
		gantt.render();
};
gantt.attachEvent("onAfterLinkAdd", gantt._criticalPathHandler);
gantt.attachEvent("onAfterLinkUpdate", gantt._criticalPathHandler);
gantt.attachEvent("onAfterLinkDelete", gantt._criticalPathHandler);
gantt.attachEvent("onAfterTaskAdd", gantt._criticalPathHandler);
gantt.attachEvent("onAfterTaskUpdate", gantt._criticalPathHandler);
gantt.attachEvent("onAfterTaskDelete", gantt._criticalPathHandler);


gantt.isCriticalTask = function (task) {
	if(!task) return;
	var path = arguments[1] || {};
	if(this._isTask(task)){
		if(this._isProjectEnd(task)){
			return true;
		}else{
			path[task.id] = true;
			var successors = this._getSuccessors(task);
			for(var i=0; i < successors.length; i++){
				var next = this.getTask(successors[i].task);
				if(this._getSlack(task, next, successors[i].link, successors[i].lag) <= 0 && (!path[next.id] && this.isCriticalTask(next, path)))
					return true;
			}
		}
	}
	return false;
};

gantt.isCriticalLink = function (link) {
	return this.isCriticalTask(gantt.getTask(link.source));
};

gantt.getSlack = function(task1, task2){
	var relations = [];
	var common = {};
	for(var i=0; i < task1.$source.length; i++){
		common[task1.$source[i]] = true;
	}
	for(var i=0; i < task2.$target.length; i++){
		if(common[task2.$target[i]])
			relations.push(task2.$target[i]);
	}

	var slacks = [];
	for(var i=0; i < relations.length; i++){
		var link = this.getLink(relations[i]);
		slacks.push(this._getSlack(task1, task2, link.type, link.lag));
	}

	return Math.min.apply(Math, slacks);
};

gantt._getSlack = function (task, next_task, relation, relation_lag) {
	if(relation === null) return 0;
	var from = null,
		to = null;
	var links = this.config.links,
		types = this.config.types;

	if((relation == links.finish_to_finish || relation == links.finish_to_start) && this._get_safe_type(task.type) != types.milestone){
		from = task.end_date;
	}else{
		from = task.start_date;
	}
	if((relation == links.finish_to_finish || relation == links.start_to_finish) && this._get_safe_type(next_task.type) != types.milestone){
		to = next_task.end_date;
	}else{
		to = next_task.start_date;
	}

	var duration = 0;
	if(+from > +to){
		duration = -this.calculateDuration(to, from);
	}else{
		duration = this.calculateDuration(from, to);
	}

	if(relation_lag && relation_lag*1 == relation_lag){
		duration -= relation_lag;
	}

	return duration;
};

gantt._getProjectEnd = function () {
	var tasks = gantt.getTaskByTime();
	tasks = tasks.sort(function (a, b) { return +a.end_date > +b.end_date ? 1 : -1; });
	return tasks.length ? tasks[tasks.length - 1].end_date : null;
};

gantt._isProjectEnd = function (task) {
	return !(this._hasDuration(task.end_date, this._getProjectEnd()));
};


gantt._formatSuccessors = function(ids, link){
	var res = [];
	for(var i = 0; i < ids.length; i++){
		res.push(this._formatSuccessor(ids[i], link));
	}
	return res;
};
gantt._formatSuccessor = function(id, link){
	return {task:id, link:link.type, lag: link.lag};
};
gantt._getSuccessors = function (task) {
	var successors = [];
	if (gantt._isProject(task)) {
		successors = successors.concat(gantt._formatSuccessors(this.getChildren(task.id), null));
	} else {
		var links = task.$source;
		for (var i = 0; i < links.length; i++) {
			var link = this.getLink(links[i]);
			if(this.isTaskExists(link.target)){
				var target = this.getTask(link.target);
				if(this._isTask(target)){
					successors.push(gantt._formatSuccessor(link.target, link));
				}else{
					successors = successors.concat(gantt._formatSuccessors(this.getChildren(target.id), link));
				}
			}
		}
	}
	return successors;
};

});
