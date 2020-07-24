if ( ! window.enview )
    window.enview = new Object();
if ( ! window.enview.portal )
    window.enview.portal = new Object();
enview.portal.MessageResource = function()
{
	this.init();
}
enview.portal.MessageResource.prototype =
{
	m_messageRes : null,
	init : function()
	{
		this.messageRes = new Map();
		this.messageRes.put("mm.error.invalid.delete.0", "This data can not be deleted.");
		this.messageRes.put("mm.error.invalid.delete.minPage.0", "My page must be at least one.");
		this.messageRes.put("mm.error.invalid.insert.0", "lt is the location which data can not be added.");
		this.messageRes.put("mm.error.invalid.page.nameupdate.0", "You can not change the name. You can change from sub-tree.");
		this.messageRes.put("mm.error.invalid.referer.0", "It is not a valid referer.");
		this.messageRes.put("mm.error.invalid.update.0", "Invalid request for update.");
		this.messageRes.put("mm.error.link.insert.0", "Duplicate service code. Please re-enter.");
		this.messageRes.put("mm.error.sql.badIntegrity.0", "It is against the integrity constraints.");
		this.messageRes.put("mm.error.sql.problem.0", "An error has occurred while processing data.");
		this.messageRes.put("mm.error.system.failure.0", "System error occurred  ");
		this.messageRes.put("mm.info.cant.hanguel.0", "You can not input Hangeul (Korean alphabet).");
		this.messageRes.put("mm.info.cant.special.0", "There are invalid characters. Special characters can not be entered.");
		this.messageRes.put("mm.info.cant.whitespace.0", "Blank space can not come");
		this.messageRes.put("mm.info.common.success.0", "It\'\'s settled ordinarily.");
		this.messageRes.put("mm.info.input.0", "Please input.");
		this.messageRes.put("mm.info.input.param.0", "Please input {0}");
		this.messageRes.put("mm.info.jumin.invalid.0", "The resident registration number is invalid!");
		this.messageRes.put("mm.info.jumin1.cant.char.0", "The front of the resident registration number contains invalid characters.");
		this.messageRes.put("mm.info.jumin1.wrong.0", "The front of the resident registration number is wrong.");
		this.messageRes.put("mm.info.jumin2.cant.char.0", "The back of the resident registration number contains invalid characters.");
		this.messageRes.put("mm.info.limitByte.0", "It is possible to input up to {0}byte.");
		this.messageRes.put("mm.info.mileSttg.0", "Input the limited number of times or select -none- in the policy of mileage.");
		this.messageRes.put("mm.info.move.success.0", "It is moved normally.");
		this.messageRes.put("mm.info.notExist.delFile.0", "There are no files to delete.");
		this.messageRes.put("mm.info.only.minusNumber.0", "There is the wrong number. Negative or non-numeric characters can not be input.");
		this.messageRes.put("mm.info.only.nnumber.0", "There is wrong number.\\n Characters other than the natural numbers can not be input.");
		this.messageRes.put("mm.info.only.number.0", "There is wrong number.\\n Characters other than numbers can not be input.");
		this.messageRes.put("mm.info.select.0", "Please select. {0}");
		this.messageRes.put("mm.info.select.multi.0", "Please choose {0} {1}");
		this.messageRes.put("mm.info.success.0", "Successfully processed.");




		if( typeof(window["initialize_ev"]) == "function" ) { initialize_ev(this); }
		if( typeof(window["initialize_hn"]) == "function" ) { initialize_hn(this); }
		if( typeof(window["initialize_cf"]) == "function" ) { initialize_cf(this); }
		if( typeof(window["initialize_eb"]) == "function" ) { initialize_eb(this); }
	},
	getMessage : function( key ) 	{
		var msg =  this.messageRes.get( key + '.' + portalPage.getDomainId());
		if( msg==null) { 
			msg = this.messageRes.get( key + '.0' );
		}
		return msg==null ? key : msg; 
	},
	setMessage : function( key, val ) {
		return this.messageRes.put( key, val );
	}
}
