/**
 * Access the bluepages information for the authenticated user from the onboarding server ...
 */
UserID = function() {
	var that = this;
	this.userID = "";
	this.name = "";
	this.firstname = "";
	this.lastname = "";
	this.businessunit = "";
	this.orgcode = "";
	this.groupid = "";
	this.employeeid = "";
	this.userGroups = {}; // list of user groups that this user is included in
	var request = $.ajax({
		type: 'GET',
		url : "/bluepagesinfo",
		data : {},
		success : function(data) {
			var json = eval('(' + data + ')');
			that.userID = validateUserData(json.userid).toLowerCase();
			that.name = validateUserData(json.name);
			that.firstname = validateUserData(json.firstname);
			that.lastname = validateUserData(json.lastname);
			that.businessunit = validateUserData(json.businessunit);
			that.orgcode = validateUserData(json.orgcode);
			that.groupid = validateUserData(json.groupid);
			that.employeeid = validateUserData(json.employeeid);
	    },
		dataType : "text",
		async : false,
		timeout : 120000,
		error : function(jqXHR, textStatus, errorThrown) { 
			alert("Request to server failed: "+textStatus);
		}
	});
	
	function validateUserData(property) {
		return (property !== undefined && property != null ? property.trim() : "");
	}
};


