jQuery(function($){
	// List Tab Navigation
	var tab_list = $('div.tab');
	var tab_list_i = tab_list.find('>ul>li');
	tab_list.removeClass('jx');
	tab_list_i.find('>ul').hide();
	tab_list.find('>ul>li[class=on]').find('>ul').show();
	tab_list.css('height', tab_list.find('>ul>li.on>ul').height()+40);
	function listTabMenuToggle(event){
		var t = $(this);
		tab_list_i.find('>ul').hide();
		t.next('ul').show();
		tab_list_i.removeClass('on');
		t.parent('li').addClass('on');
		tab_list.css('height', t.next('ul').height()+40);
		return false;
	}
	tab_list_i.find('>a[href=#]').click(listTabMenuToggle).focus(listTabMenuToggle);
});