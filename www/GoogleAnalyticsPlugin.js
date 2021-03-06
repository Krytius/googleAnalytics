function GoogleAnalyticsPlugin() {}

GoogleAnalyticsPlugin.prototype.startTrackerWithAccountID = function(id) {
	cordova.exec(function(winParam) {
		console.log(winParam);
	}, function(error) {
		console.log(error);
	}, "GoogleAnalyticsPlugin", "startTrackerWithAccountID", [id]);
};

GoogleAnalyticsPlugin.prototype.trackPageview = function(pageUri) {
	cordova.exec(function(winParam) {
		console.log(winParam);
	}, function(error) {
		console.log(error);
	}, "GoogleAnalyticsPlugin", "trackPageview", [pageUri]);
};

GoogleAnalyticsPlugin.prototype.trackEvent = function(category, action, label, value) {
	var options = {
		category: category,
		action: action,
		label: label,
		value: isNaN(parseInt(value)) ? -1 : value
	};
	cordova.exec(function(winParam) {
		//console.log(winParam);
	}, function(error) {
		//console.log(error);
	}, "GoogleAnalyticsPlugin", "trackEvent", options);
};

GoogleAnalyticsPlugin.prototype.setCustomVariable = function(index, name, value) {
	var options = {
		index: index,
		name: name,
		value: value
	};
	cordova.exec(function(winParam) {
		//console.log(winParam);
	}, function(error) {
		//console.log(error);
	}, "GoogleAnalyticsPlugin", "setCustomVariable", options);
};

GoogleAnalyticsPlugin.prototype.hitDispatched = function(hitString) {
	//console.log("hitDispatched :: " + hitString);
};
GoogleAnalyticsPlugin.prototype.trackerDispatchDidComplete = function(count) {
	//console.log("trackerDispatchDidComplete :: " + count);
};

cordova.addConstructor(function() {
	if (!window.plugins) window.plugins = {};
	window.plugins.googleAnalyticsPlugin = new GoogleAnalyticsPlugin();
});