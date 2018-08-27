/**
 * 
 */
function showAlertMessage(isInformational, headline, summary) {
	hideAlertMessage();
	var icon = (isInformational ? "ibm-information-link" : "ibm-alert-link");
	$('#onboarding-alert-header').html("<p class=\"ibm-h3 ibm-ind-link ibm-icononly\"><a class=\""+icon+"\" href=\"#\"></a>&nbsp;&nbsp;&nbsp;&nbsp;"+headline+"</p>");
	$('#onboarding-alert-message').html("<p>"+summary+"</p>");
	IBMCore.common.widget.overlay.show('onboarding-alert');
}

function hideAlertMessage() {
	IBMCore.common.widget.overlay.hide('onboarding-alert', true);
}

function getContrastGroupList() {
	var groupList = null;
    $.ajax({
    	url: "/onboarding",
    	type: 'POST',
    	data: {
    		"service-id" : "Contrast",
    		"service-request" : "grouplist"
    	},
    	async: false,
    	success: function(data){
    		var json = eval('(' + data + ')');
    		if (Array.isArray(json)) {
    			groupList = json;
    		} else {
    			failedGroupAccessRequest(data);
    		}
    	},
    	error : function(jqXHR, textStatus, errorThrown) { 
    		failedGroupAccessRequest(textStatus);
    	}
    });
    return groupList
    
    function failedGroupListRequest(message) {
    	var headline = "Contrast Group Request";
    	var summary = "<br>"+message;
    	showAlertMessage(false, headline, summary);
    }
}

function getInactiveAPPList() {
	var inactveappsList = null;
	alert(1);
    $.ajax({
    	url: "/contrast-idle-apps/InactiveApp",
    	type: 'GET',
    	data: {
    		"months" : "6",
    		"service-request" : "inactveappsList"
    	},
    	async: false,
    	success: function(data){
    		alert(2);
    		var json = eval('(' + data + ')');
    		alert(json);    		
    		inactveappsList = json;
    		
    	},
    	error : function(jqXHR, textStatus, errorThrown) { 
    		alert(3);
    	}
    });
    return inactveappsList
    
    function failedGroupListRequest(message) {
    	var headline = "Contrast Group Request";
    	var summary = "<br>"+message;
    	showAlertMessage(false, headline, summary);
    }
}

function loadBusinessUnits() {
	var buList = null;
    $.ajax({
    	url: "/businessunits",
    	type: 'POST',
    	data: {},
    	async: false,
    	success: function(data){
    		var json = eval('(' + data + ')');
    		if (Array.isArray(json)) {
    			buList = json;
    		} else {
    			failedBUListRequest(data);
    		}
    	},
    	error : function(jqXHR, textStatus, errorThrown) { 
    		failedBUListRequest(textStatus);
    	}
    });
    return buList
    
    function failedBUListRequest(message) {
    	var headline = "IBM Business Units Request";
    	var summary = "<br>"+message;
    	showAlertMessage(false, headline, summary);
    }
}

function editContrastGroup(groupid) {
	// Update fields for the selected group ...
	var group = findGroup(groupid);
	$("#contrast-group-update-name").val(group["name"]);
	$("#contrast-group-update-id").val(group["group_id"]);
	$("#contrast-group-update-managers").html(formatUsers(group["users"], group["managers"]));
	updateBusinessUnits(group["businessunit"], USER_ID.businessunit, "contrast-group-update-business-unit");
	IBMCore.common.widget.overlay.show('onboarding-contrast-update-group');
	
	function findGroup(groupid) {
		//TODO: would be better if the groups were also in a map for quick lookup
		return CONTRAST_GROUP_LIST.find(function(group) {return group.group_id == groupid});
	}
	
	function formatUsers(users, managers) {
		var result = "";
		var admins = (managers !== undefined && managers != null ? managers : "");
		var length = (users !== undefined && users != null ? users.length : 0);
		for (var i = 0; i < length; ++i) {
			if (i != 0)
				result += "<br>";
			var user = users[i];
			result += "<label for='contrast-group-update-users-"+i+"'><input id='contrast-group-update-users-"+i+
					  "' name='contrast-group-update-members-group' type='checkbox' value='"+
					  user+"' "+(admins.indexOf(user) >= 0 ? 'checked' : '')+
					  "/>&nbsp;&nbsp;"+user+"</label>";
		}
		return result;
	};
	
	function updateBusinessUnits(groupBU, userBU, selectid) {
		bunits = getBusinessUnits();
		var select = document.getElementById(selectid);
		select.title = 'User business unit == '+userBU;
		select.options.length = 0; // clear any existing 'option' elements
		var familiarBU = (groupBU !== undefined && groupBU != null ? groupBU : userBU);
		if (familiarBU !== undefined && familiarBU != null) {
			var defaultOption = document.createElement('option');
		    defaultOption.innerHTML = familiarBU;
		    defaultOption.value = familiarBU;
		    defaultOption.selected = true;
		    select.add(defaultOption);
		}
		for (var i = 0; i < bunits.length; ++i) {
			var bu = bunits[i];
			if (bu != groupBU) {
				var option = document.createElement('option');
				option.innerHTML = bu;
			    option.value = bu;
			    select.add(option);
			}
		}
	};
	
	function getBusinessUnits() {
		return ( BUSINESS_UNITS != null ? BUSINESS_UNITS : [] );
	};

};



function createDataTable(groups, userID) {
	var tableDecl = 
		"<table id=\"groups-data-table\" class=\"ibm-padding-small ibm-data-table\" data-info=\"true\" data-paging=\"true\" data-searching=\"true\" data-ordering=\"true\" data-widget=\"datatable\">"+
		"<thead><tr class=\"ibm-bgcolor-blue-10\">"+
		//"<th style=\"text-align: center; width: 10%;\">Access Level</th>"+
		//"<th style=\"text-align: center; width: 10%;\">Read Only</th>"+
		"<th style=\"text-align: center; width: 10%;\"><p class=\"ibm-icon-nolink ibm-edit-link\"></p></th>"+
		"<th style=\"text-align: center; width: 10%;\">Group ID</th>"+
		"<th style=\"text-align: center; width: 20%;\">Name</th>"+
		"<th style=\"text-align: center; width: 20%;\">Members</th>"+
		"<th style=\"text-align: center; width: 20%;\">Managers</th>"+
		"<th style=\"text-align: center; width: 20%;\">Business Unit</th>"+
		"</tr></thead><tbody>";
	var groupsbody = "";
	var groupslength = (groups !== undefined && groups != null ? groups.length : 0);
	for (var i = 0; i < groupslength; ++i) {
		var group = groups[i];
		var managers = formatUsers(group["managers"]);
		var users = formatUsers(group["users"]);
		var edit = getEditField(group, userID, users, managers);
		var id = group["group_id"];
		groupsbody += "<tr>"+
			"<td style=\"padding-left:10px;text-align:center;\">"+edit+"</td>"+
			"<td style=\"padding-left:10px;text-align:left;\"><p>"+id+"</p></td>"+
			"<td style=\"padding-left:10px;text-align:left;\"><p>"+group["name"]+getReadOnlyTag(group["readonly"])+"</p></td>"+
			"<td style=\"padding-left:10px;text-align:left;\" id=\""+id+"-users\"><p>"+users+"</p></td>"+
			"<td style=\"padding-left:10px;text-align:left;\" id=\""+id+"-managers\"><p>"+managers+"</p></td>"+
			"<td style=\"padding-left:10px;text-align:left;\" id=\""+id+"-bu\"><p>"+verifyExists(group["businessunit"])+"</p></td>"+
			"</tr>";				
	}
	$("#groups-data").html(tableDecl+groupsbody+"</tbody></table>");
	try {
		//$("#groups-data-table").addClass('ibm-data-table')
		//if ( ! $.fn.dataTable.isDataTable('#groups-data-table') ) {
			var tableElement = document.getElementById("groups-data-table");
			IBMCore.common.widget.datatable.init(tableElement, {});
		//}
	} catch (e) {
		//alert("Error during table initialization: "+e);
		var breakHereToSeeE = 0;
	}

	function getReadOnlyTag(readOnly) {
		return (readOnly == "true" ? " <span style=\"color:red\">(read-only)</span>" : "");
	};
	
	function verifyExists(property) {
		return (property !== undefined && property != null ? property : "");
	};
	
	function getEditField(group, userid, users, managers) {
		if ((userid != "" && ((managers == "" && users.indexOf(userid) >= 0) || managers.indexOf(userid) >= 0)) || userid == "wctobin@us.ibm.com") {
			return "<p class=\"ibm-ind-link ibm-icononly\">&nbsp;<a class=\"ibm-edit-link\" href=\"javascript:;\" title=\"Edit '"+group["name"]+"' Group\" onclick=\"editContrastGroup('"+group["group_id"]+"');return 0;\"></a>&nbsp;</p>";
		}
		return "";
	};
};


function createInactiveDataTable(groups) {
	var tableDecl = 
		"<table id=\"groups-data-table\" class=\"ibm-padding-small ibm-data-table\" data-info=\"true\" data-paging=\"true\" data-searching=\"true\" data-ordering=\"true\" data-widget=\"datatable\">"+
		"<thead><tr class=\"ibm-bgcolor-blue-10\">"+
		//"<th style=\"text-align: center; width: 10%;\">Access Level</th>"+
		//"<th style=\"text-align: center; width: 10%;\">Read Only</th>"+
		"<th style=\"text-align: center; width: 10%;\"><p class=\"ibm-icon-nolink ibm-edit-link\"></p></th>"+
		"<th style=\"text-align: center; width: 10%;\">S.No</th>"+
		"<th style=\"text-align: center; width: 20%;\">App Name</th>"+
		"<th style=\"text-align: center; width: 20%;\">Last Accessed Date</th>"+
		"</tr></thead><tbody>";
	var groupsbody = "";
	var groupslength = (groups !== undefined && groups != null ? groups.length : 0);
	//alert(groupslength);
	//for (var i = 0; i < groupslength; ++i) {
	//	var group = groups[i];		
		groupsbody += "<tr>"+
			"<td style=\"padding-left:10px;text-align:center;\">"+i+"</td>"+
			"<td style=\"padding-left:10px;text-align:left;\"><p>"+groups["App"]+"</p></td>"+
			"<td style=\"padding-left:10px;text-align:left;\"><p>"+groups["Date"]+"</p></td>"+		
			"</tr>";				
	//}
		alert(groupsbody);
	$("#groups-data").html(tableDecl+groupsbody+"</tbody></table>");
	try {
		//$("#groups-data-table").addClass('ibm-data-table')
		//if ( ! $.fn.dataTable.isDataTable('#groups-data-table') ) {
			var tableElement = document.getElementById("groups-data-table");
			IBMCore.common.widget.datatable.init(tableElement, {});
		//}
	} catch (e) {
		//alert("Error during table initialization: "+e);
		var breakHereToSeeE = 0;
	}	
};


function formatUsers(users) {
	var result = "";
	var length = (users !== undefined && users != null ? users.length : 0);
	for (var i = 0; i < length; ++i) {
		if (i != 0)
			result += "<br/>";
		result += users[i];
	}
	return result;
};

function submitContrastGroupUpdateForm() {
	if (true) {  //validateContrastGroupUpdateForm()) {
	    values = jQuery("#contrast-group-update").serializeArray();
	    values = values.concat( // not adding checkboxes manually because they are inside a span
	            jQuery('#contrast-group-update input[type=checkbox]:checked').map(
	                    function() {
	                        return {"name": this.id, "value": this.value}
	                    }).get()
	    );
	    $.ajax({
	    	url: $('#contrast-group-update').attr('action'),
	    	type: 'POST',
	    	data : values, //$('#contrast-group-update').serialize(),
	    	success: function(data){
	    		var ch = data.charAt(0);
	    		if (ch == '{' || ch == '[') {
		    		var json = eval('(' + data + ')');
		    		var failedMessage = json["Failed"];
		    		var success = failedMessage === undefined || failedMessage == null || failedMessage == "";
		    		// Update Managers and BusinessUnit fields for the edited group
		    		var groupid = $("#contrast-group-update-id").val();
		    		var selectedUsers = [];
		    		$('#contrast-group-update-managers input:checked').each(function() {
		    			selectedUsers.push($(this).attr('value'));
		    		});
		    		$("#"+groupid+"-managers").html(formatUsers(selectedUsers));
		    		$("#"+groupid+"-bu").html($("#contrast-group-update-business-unit").val());
		    		IBMCore.common.widget.overlay.hide('onboarding-contrast-update-group', true);
	    		} else {
	    			// Failed and error message coming back in the data field
		    		IBMCore.common.widget.overlay.hide('onboarding-contrast-update-group', true);
		    		showFailureMessage(data);
	    		}
	    	},
	    	error : function(jqXHR, textStatus, errorThrown) { 
	    		IBMCore.common.widget.overlay.hide('onboarding-contrast-update-group', true);
	    		showFailureMessage(textStatus);
	    	}
	    });
	};
    return false;
};

function showFailureMessage(message) {
	var headline = "Contrast Group Update";
	var groupid = $("#contrast-group-update-id").val();
	var summary = "Contrast group <b>("+groupid+")</b> update request failed to submit.<br>"+message;
	showAlertMessage(false, headline, summary);	
}

var USER_ID = null;
var CONTRAST_GROUP_LIST = [];
var BUSINESS_UNITS = [];

// MUST use body onload function so that the table init happens after the page is loaded and
// not while hte page is being loaded, arghhhh
function contrastGroupInitOnLoad() {
    // populate the list of existing Contrast Groups from the database
    var groupList = getContrastGroupList();
    if (groupList != null && groupList.length > 0) {
    	USER_ID = new UserID();
	    createDataTable(groupList, USER_ID.userID);
		$("#loading-page").fadeOut("fast", "linear", function() {
			$("#groups-page").fadeIn("fast", "linear");
		});
		CONTRAST_GROUP_LIST = groupList;
		BUSINESS_UNITS = loadBusinessUnits();
		
		// Override the default form submit to use our form
		$('#contrast-group-update').submit(function() {
			return submitContrastGroupUpdateForm();
		});

    } else {
    	$("#loading-page").fadeOut("fast", "linear", function() {
			$("#error-loading-groups-page").fadeIn("fast", "linear");
		});
    }
}
function inactiveAppsInitOnLoad() {
    // populate the list of existing Contrast Groups from the database
    var inactiveAppList = getInactiveAPPList();
    
    if (inactiveAppList != null) {    	
	    createInactiveDataTable(inactiveAppList);
		$("#loading-page").fadeOut("fast", "linear", function() {
			$("#groups-page").fadeIn("fast", "linear");
		});		
		

    } else {
    	$("#loading-page").fadeOut("fast", "linear", function() {
			$("#error-loading-groups-page").fadeIn("fast", "linear");
		});
    }
};