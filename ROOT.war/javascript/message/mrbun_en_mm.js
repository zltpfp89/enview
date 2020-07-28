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
		this.messageRes.put("mm.error.system.failure.0", "System error occurred \u003Cbr\u003E");
		this.messageRes.put("mm.info.jumin.invalid.0", "It isn\'\'t a valid social security number!");
		this.messageRes.put("mm.error.sql.problem.0", "An error has occurred while processing data.");
		this.messageRes.put("mm.info.input.0", "is required.");
		this.messageRes.put("mm.info.cant.whitespace.0", "Blank space can\'\'t come");
		this.messageRes.put("mm.info.cant.hanguel.0", "You can\'t input Hangeul (Korean alphabet).");
		this.messageRes.put("mm.info.jumin2.cant.char.0", "The back of the resident registration number contains invalid characters.");
		this.messageRes.put("mm.info.limitByte.0", "It\'\'s possible to input up to {0}byte.");
		this.messageRes.put("mm.error.sql.badIntegrity.0", "It\'\'s against the integrity constraints.\u003Cbr\u003E");
		this.messageRes.put("mm.info.notExist.delFile.0", "There are no files to delete.");
		this.messageRes.put("mm.info.common.success.0", "It\'\'s settled ordinarily.");
		this.messageRes.put("mm.info.cant.special.0", "There are invalid characters. Special characters can\'\'t be entered.");
		this.messageRes.put("mm.info.only.nnumber.0", "There is wrong number.\\n Characters other than the natural numbers can\'\'t be input.");
		this.messageRes.put("mm.info.mileSttg.0", "Input the limited number of times or select -none- in the policy of mileage.");
		this.messageRes.put("mm.info.jumin1.cant.char.0", "The front of the resident registration number contains invalid characters.");
		this.messageRes.put("mm.info.jumin1.wrong.0", "The front of the resident registration number is wrong.");
		this.messageRes.put("mm.info.only.minusNumber.0", "There is the wrong number. Negative or non-numeric characters can\'\'t be entered.");
		this.messageRes.put("mm.error.invalid.referer.0", "It\'\'s not a valid referrer \u003Cbr\u003E");
		this.messageRes.put("mm.info.success.0", "It\'\'s settled ordinarily.");
		this.messageRes.put("mm.error.invalid.delete.0", "This data can not be deleted.");
		this.messageRes.put("mm.info.move.success.0", "It\'\'s moved ordinarily.");
		this.messageRes.put("mm.info.only.number.0", "There is wrong number.\\n Characters other than the numbers can\'\'t be input.");
		this.messageRes.put("mm.error.invalid.update.0", "Invalid request for update.");
		this.messageRes.put("mm.error.invalid.insert.0", "lt\'\'s the location which data can\'\'t be added.");
		this.messageRes.put("mm.error.invalid.delete.minPage.0", "My page must be at least one.");
		this.messageRes.put("mm.info.input.param.1", "Please input {0}");
		this.messageRes.put("mm.info.select.0", "must be selected.");
		this.messageRes.put("mm.info.select.multi.0", "Please choose {0}");
		this.messageRes.put("mm.error.invalid.page.nameupdate.0", "You can\'\'t change the name. You can change from sub-tree.");
		this.messageRes.put("mm.error.invalid.insert.1", "This point can not insert data.");
		this.messageRes.put("mm.error.link.insert.1", "서비스 코드가 중복됩니다 다시 입력해 주세요");




		if( typeof(window["initialize_ef"]) == "function" ) { initialize_ef(this); }
		if( typeof(window["initialize_sn"]) == "function" ) { initialize_sn(this); }
		if( typeof(window["initialize_ev"]) == "function" ) { initialize_ev(this); }
		if( typeof(window["initialize_pt"]) == "function" ) { initialize_pt(this); }
		if( typeof(window["initialize_hn"]) == "function" ) { initialize_hn(this); }
		if( typeof(window["initialize_cf"]) == "function" ) { initialize_cf(this); }
		if( typeof(window["initialize_eb"]) == "function" ) { initialize_eb(this); }
	},
	getMessage : function( key )
	{
		var msg =  this.messageRes.get( key + '.' + portalPage.getDomainId());
		if( msg==null) { 
			msg = this.messageRes.get( key + '.0' );
		}
		if( msg==null) { 
			msg = this.messageRes.get( key);
		}
		return msg;
	},
	setMessage : function( key, val )
	{
		return this.messageRes.put( key, val );
	}
}
