<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/apps/enface/WEB-INF/view/cmmn/declare.jspf" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
/* 
#evtArea {
	height: 100px;
	font-size: 15px;
	background: rgb(238, 238, 238);
	margin: 15px 0px 0px 0px;
	border-width: 1px;
	border-style: solid;
	border-color: rgb(153, 153, 153);
	border-image: initial;
	overflow: auto;
}
 */
</style>
<script type="text/javascript">
var RightTechPath = '<c:out value="${pageContext.request.contextPath}" />/QCELL/';
</script>
<script type="text/javascript" src="<c:url value="/QCELL/qcell.js" />"></script>
</head>
<body>
<script type="text/javascript">
var qcell1, 
data = [],
grid_data=[{"name":"Brendan Tanner","phone":"053-666-1463","email":"","company":"Aliquam Consulting","regdate":"02.19.10","addr":"8699 Tincidunt Av."},{"name":"Derek Hoover","phone":"017-015-8706","email":"eleifend@consectetueripsum.ca","company":"Interdum Ligula LLP","regdate":"06.01.01","addr":"4794 Senectus Ave"},{"name":"Lucius Simmons","phone":"016-966-6152","email":"commodo.at@elit.net","company":"Non Luctus Sit Company","regdate":"06.01.01","addr":"972-9492 Sapien, Avenue"},{"name":"Finn Spence","phone":"028-244-3946","email":"Nam.ac.nulla@mollisnoncursus.net","company":"Nibh Sit Incorporated","regdate":"12.04.03","addr":"3183 Fringilla Road"},{"name":"Hoyt Henderson","phone":"038-283-1226","email":"placerat@Nunccommodoauctor.org","company":"Nam Ac Nulla Company","regdate":"11.13.06","addr":"6246 A, Rd."},{"name":"Hamish Peters","phone":"022-807-7586","email":"velit.Quisque@non.ca","company":"Ligula Aenean Inc.","regdate":"11.13.06","addr":"P.O. Box 756, 953 Vulputate, Road"},{"name":"Ronan Calhoun","phone":"040-381-7924","email":"ac.fermentum.vel@Aliquam.ca","company":"Dictum Limited","regdate":"11.25.05","addr":"437-1318 Massa. Road"},{"name":"Harrison Carver","phone":"002-570-4574","email":"non.enim@risus.co.uk","company":"Sem Molestie Foundation","regdate":"10.09.03","addr":"Ap #433-3682 Placerat St."},{"name":"Beau Whitfield","phone":"028-399-3832","email":"Integer.vulputate.risus@eros.co.uk","company":"Morbi Quis Urna LLP","regdate":"06.04.06","addr":"P.O. Box 460, 6351 Massa. Av."},{"name":"Dexter Carey","phone":"014-179-5753","email":"non@cursusnon.co.uk","company":"Phasellus Nulla Integer Company","regdate":"08.22.01","addr":"3882 Nisl St."},{"name":"Coby Alvarez","phone":"048-021-2285","email":"rutrum.eu@a.org","company":"Proin Foundation","regdate":"10.10.05","addr":"965-1251 Erat Av."},{"name":"Damon Gentry","phone":"039-387-7714","email":"erat@euodio.ca","company":"Tincidunt Congue Turpis Limited","regdate":"10.26.03","addr":"Ap #385-240 Vitae Street"},{"name":"Cain Dale","phone":"076-434-6172","email":"congue.In.scelerisque@Cras.com","company":"Id Libero Donec Consulting","regdate":"09.26.02","addr":"Ap #611-4302 Nisi. Av."},{"name":"Jared Wagner","phone":"056-458-4317","email":"sollicitudin@urnajusto.org","company":"In Corporation","regdate":"11.09.01","addr":"137-9385 Eu Street"},{"name":"Connor Le","phone":"005-641-7554","email":"est.ac.mattis@euismod.net","company":"Dictum Proin Eget Incorporated","regdate":"02.14.09","addr":"Ap #570-443 Non Road"},{"name":"Daquan Riggs","phone":"077-904-4014","email":"neque@a.co.uk","company":"Feugiat Sed Nec Consulting","regdate":"08.17.02","addr":"Ap #106-8871 Ullamcorper, Ave"},{"name":"Reuben Lucas","phone":"054-347-3693","email":"mauris.ipsum.porta@natoquepenatibuset.org","company":"Magna Malesuada Associates","regdate":"03.11.10","addr":"6231 Quisque Rd."},{"name":"Colorado Franklin","phone":"030-363-6901","email":"neque.non@dictummagna.org","company":"Auctor LLC","regdate":"04.20.04","addr":"522 Tempus St."},{"name":"Branden Pollard","phone":"046-420-9672","email":"egestas.Sed@accumsanconvallis.com","company":"Tempus Consulting","regdate":"03.22.05","addr":"Ap #334-1193 Euismod Rd."},{"name":"Craig Burks","phone":"097-241-8633","email":"ornare.sagittis@magnamalesuada.org","company":"Odio Nam LLC","regdate":"05.21.02","addr":"868-9959 Sociis Road"},{"name":"Reed Harper","phone":"090-490-5306","email":"vel@montes.com","company":"Dis Parturient Montes Corporation","regdate":"10.04.06","addr":"Ap #884-1956 Purus. Ave"},{"name":"Vernon Mcclain","phone":"032-682-5291","email":"Sed.neque@Quisque.com","company":"Morbi Limited","regdate":"01.12.06","addr":"226-4724 Feugiat Ave"},{"name":"Rajah Peterson","phone":"011-958-9753","email":"adipiscing.ligula@Aliquamnisl.ca","company":"Montes Nascetur Corporation","regdate":"09.22.01","addr":"527 Vel, St."},{"name":"John Bailey","phone":"089-885-0947","email":"amet@venenatisvel.edu","company":"Euismod Ltd","regdate":"02.05.04","addr":"886 Aenean Ave"},{"name":"Moses Camacho","phone":"074-193-2779","email":"Sed.diam.lorem@seddui.co.uk","company":"Neque Et Nunc LLC","regdate":"08.12.09","addr":"P.O. Box 944, 9817 Donec Street"},{"name":"Blaze Holland","phone":"095-192-4078","email":"nulla.Donec.non@enimNuncut.ca","company":"Proin Dolor Nulla Industries","regdate":"04.03.04","addr":"127-5474 Quam, Ave"},{"name":"Tanner Rasmussen","phone":"094-421-3576","email":"Fusce.fermentum.fermentum@ornarefacilisiseget.co.uk","company":"Hendrerit A Foundation","regdate":"06.04.03","addr":"6099 Mauris Rd."},{"name":"Rafael Duncan","phone":"082-582-8296","email":"eu@vel.org","company":"Gravida Praesent Eu Corp.","regdate":"12.11.09","addr":"Ap #221-7724 Duis Avenue"},{"name":"Aaron Henderson","phone":"033-545-6808","email":"volutpat.Nulla@Nulla.co.uk","company":"Cursus Foundation","regdate":"12.25.04","addr":"911-390 Nullam Av."},{"name":"Tanner Mitchell","phone":"079-735-9109","email":"id@non.co.uk","company":"Id Ante Nunc LLP","regdate":"10.06.04","addr":"4083 Nisi. Street"},{"name":"Zachery Jimenez","phone":"029-320-5071","email":"consectetuer.cursus@etnunc.co.uk","company":"Nulla Institute","regdate":"06.04.03","addr":"Ap #133-2731 Blandit. Rd."},{"name":"Kareem Lyons","phone":"075-962-1790","email":"faucibus.leo@ac.com","company":"Tristique Ltd","regdate":"04.11.02","addr":"682-4021 Metus. Rd."},{"name":"Neil Harvey","phone":"013-672-0120","email":"facilisis.facilisis@luctussitamet.net","company":"Iaculis Lacus Pede Limited","regdate":"11.05.01","addr":"P.O. Box 877, 9764 Mauris Rd."},{"name":"Conan Emerson","phone":"076-085-9007","email":"Suspendisse.eleifend@velit.org","company":"Quis Pede LLP","regdate":"12.22.09","addr":"925-4895 Enim. St."},{"name":"Lev Bender","phone":"091-399-8259","email":"Duis.volutpat@erat.ca","company":"Fringilla Ltd","regdate":"10.01.05","addr":"9459 Eleifend Rd."},{"name":"Lucian Head","phone":"027-473-1647","email":"enim.Etiam@disparturientmontes.com","company":"Dui Associates","regdate":"10.27.07","addr":"P.O. Box 632, 7044 Odio. Av."},{"name":"Ferdinand Finch","phone":"061-179-2352","email":"tortor@habitantmorbi.net","company":"Sem Ut Industries","regdate":"03.26.02","addr":"1146 Ut Street"},{"name":"Justin Brooks","phone":"007-219-9489","email":"nec@pede.ca","company":"Eleifend Cras Sed PC","regdate":"08.22.07","addr":"2406 Nec Avenue"},{"name":"Timon Serrano","phone":"028-872-5653","email":"sapien@seddolorFusce.edu","company":"Vitae Corp.","regdate":"11.29.04","addr":"783-1700 Cursus St."},{"name":"Kieran Rodgers","phone":"082-233-3723","email":"erat@eudolor.ca","company":"Mollis Integer Ltd","regdate":"04.29.04","addr":"P.O. Box 974, 4066 Semper Road"},{"name":"Philip Bruce","phone":"069-509-5770","email":"ornare@famesac.net","company":"Mi Lacinia Institute","regdate":"05.01.04","addr":"5206 Curabitur St."},{"name":"Hoyt Chavez","phone":"000-395-5056","email":"lorem.fringilla@Inlorem.net","company":"Neque Non LLP","regdate":"09.21.03","addr":"8976 Tincidunt, Avenue"},{"name":"Seth Rosa","phone":"072-849-6358","email":"vestibulum.nec.euismod@pede.ca","company":"Mi Aliquam Company","regdate":"06.21.01","addr":"3663 Orci St."},{"name":"Price Campos","phone":"024-741-5140","email":"dapibus@justo.ca","company":"Nulla Integer Corporation","regdate":"06.07.01","addr":"P.O. Box 873, 1756 Proin Avenue"},{"name":"Ethan Estes","phone":"026-317-6112","email":"Nullam.ut.nisi@magnisdisparturient.edu","company":"Lacinia Sed Foundation","regdate":"03.30.04","addr":"1708 Facilisis Avenue"},{"name":"Calvin Reeves","phone":"015-244-0315","email":"nunc.sed.libero@est.net","company":"Nunc Pulvinar Arcu Limited","regdate":"01.14.07","addr":"5314 Ultrices St."},{"name":"Amir Whitehead","phone":"024-584-8629","email":"et.magnis.dis@Aliquamrutrumlorem.com","company":"Aenean Incorporated","regdate":"08.15.09","addr":"4991 Erat Avenue"},{"name":"Acton Cantrell","phone":"034-651-6127","email":"at.velit.Pellentesque@nuncacmattis.edu","company":"Mattis Cras Eget Industries","regdate":"12.12.06","addr":"Ap #773-7351 Commodo St."},{"name":"Shad Benson","phone":"075-918-8148","email":"quis.pede.Praesent@erat.com","company":"Tristique Senectus Et Institute","regdate":"08.31.02","addr":"9591 Parturient Road"},{"name":"Phelan Battle","phone":"091-709-5228","email":"diam.Duis.mi@dapibusgravida.co.uk","company":"Dolor Foundation","regdate":"05.15.04","addr":"4174 Parturient St."},{"name":"Hall Mooney","phone":"087-173-4834","email":"cursus.a.enim@risus.com","company":"Fringilla Company","regdate":"11.21.05","addr":"P.O. Box 912, 4870 Erat. Av."},{"name":"Guy Sloan","phone":"056-896-0582","email":"quam.Pellentesque@tellus.org","company":"A Malesuada Id Limited","regdate":"02.03.07","addr":"P.O. Box 412, 4072 Eget Avenue"},{"name":"Jarrod Barron","phone":"097-636-9651","email":"semper@lobortisClass.net","company":"Lorem Ut Incorporated","regdate":"09.05.04","addr":"Ap #633-249 Molestie Av."},{"name":"Jasper Landry","phone":"031-543-4903","email":"ridiculus@adlitora.ca","company":"At Velit LLP","regdate":"04.24.06","addr":"P.O. Box 420, 3660 Mauris Ave"},{"name":"Hector James","phone":"065-518-4674","email":"vel.venenatis.vel@arcuSedeu.ca","company":"Placerat Company","regdate":"11.29.09","addr":"8923 Leo. Road"},{"name":"Aaron Mccormick","phone":"096-441-4068","email":"Sed.et.libero@liberoInteger.ca","company":"Ac Libero Limited","regdate":"04.16.06","addr":"8393 Euismod Ave"},{"name":"Ciaran Lyons","phone":"094-973-5685","email":"venenatis.lacus.Etiam@nonummyFusce.net","company":"Quis PC","regdate":"04.10.02","addr":"P.O. Box 558, 9017 Dignissim Street"},{"name":"Beau Bolton","phone":"062-184-8000","email":"Cras@justo.ca","company":"Proin Corp.","regdate":"11.01.05","addr":"Ap #835-5120 Penatibus St."},{"name":"Zeus Hoffman","phone":"026-089-0990","email":"habitant.morbi@sedleoCras.ca","company":"Orci Lobortis Augue Consulting","regdate":"01.11.05","addr":"Ap #934-8768 Posuere Avenue"},{"name":"Simon Beach","phone":"039-421-2628","email":"dictum@tellusSuspendissesed.ca","company":"Habitant Morbi Tristique Corp.","regdate":"03.15.09","addr":"349-8611 Arcu Ave"},{"name":"Gil Richmond","phone":"061-751-3910","email":"odio@Etiam.org","company":"Nulla Integer Urna Incorporated","regdate":"08.18.09","addr":"387-3919 Vestibulum Av."},{"name":"Ian Villarreal","phone":"063-410-3407","email":"et.ultrices.posuere@at.co.uk","company":"Montes LLP","regdate":"10.25.09","addr":"Ap #308-8359 Magna. Rd."},{"name":"Gray Wade","phone":"001-788-0041","email":"ut.pellentesque.eget@Donecconsectetuermauris.ca","company":"Lectus Pede LLP","regdate":"07.27.05","addr":"P.O. Box 185, 2166 Aliquet. Av."},{"name":"Jared Vega","phone":"019-983-1805","email":"ac.mi.eleifend@duiaugue.com","company":"Et Institute","regdate":"02.27.03","addr":"6247 Ut, Road"},{"name":"Howard Decker","phone":"026-535-7964","email":"Sed.nulla@Curabitur.ca","company":"Magna Et Ipsum LLP","regdate":"05.18.08","addr":"657-1217 Magna. Street"},{"name":"Amir Patterson","phone":"006-591-5257","email":"Aliquam.gravida.mauris@molestieSedid.ca","company":"Non Bibendum LLP","regdate":"07.16.01","addr":"Ap #708-5249 Eu Ave"},{"name":"Lev Mayo","phone":"004-915-6703","email":"egestas@adipiscinglobortis.net","company":"Sociosqu Ad Foundation","regdate":"02.04.02","addr":"227-5157 Velit. Rd."},{"name":"James Morse","phone":"092-259-1981","email":"consectetuer.rhoncus@arcu.com","company":"Turpis In Associates","regdate":"02.16.04","addr":"2058 Nam St."},{"name":"Lawrence Bryant","phone":"024-023-1375","email":"malesuada.ut.sem@Quisquefringilla.co.uk","company":"Fermentum Fermentum Arcu Incorporated","regdate":"04.14.10","addr":"Ap #376-1925 Dictum Avenue"},{"name":"Ulysses Lester","phone":"051-532-1667","email":"eget.nisi@anteipsum.co.uk","company":"Non LLP","regdate":"12.23.04","addr":"Ap #630-6341 Nec, Road"},{"name":"Guy Vega","phone":"098-690-4529","email":"Proin.sed.turpis@ipsum.net","company":"Eget Metus Eu Consulting","regdate":"11.29.02","addr":"2761 Venenatis St."},{"name":"Otto Craft","phone":"030-107-4863","email":"sapien@porttitoreros.net","company":"Leo Incorporated","regdate":"01.20.06","addr":"6222 Sodales Street"},{"name":"Ross French","phone":"062-250-0013","email":"luctus@quis.net","company":"Tempor Bibendum Donec Ltd","regdate":"11.28.02","addr":"565-2782 At, Street"},{"name":"Tyrone Patton","phone":"019-521-3282","email":"malesuada.vel.convallis@convalliserat.com","company":"Pede Inc.","regdate":"06.19.05","addr":"3002 Egestas Av."},{"name":"Jameson Reilly","phone":"003-494-5606","email":"dignissim@nibh.net","company":"Leo Morbi Neque Institute","regdate":"10.27.06","addr":"7141 Libero. Rd."},{"name":"Hector Hinton","phone":"095-957-2963","email":"enim.gravida@diamnuncullamcorper.edu","company":"Euismod Foundation","regdate":"10.04.07","addr":"P.O. Box 594, 4530 Eu Street"},{"name":"Porter Craig","phone":"066-086-3818","email":"neque@Mauriseu.net","company":"Arcu Sed LLP","regdate":"05.18.04","addr":"156 Tempus, St."},{"name":"Justin Dominguez","phone":"012-195-6393","email":"nascetur@tellus.edu","company":"Eget Magna Ltd","regdate":"11.17.06","addr":"4083 Tempus Ave"},{"name":"Daniel Marsh","phone":"092-714-0869","email":"sagittis@elit.ca","company":"Feugiat Sed Ltd","regdate":"07.26.05","addr":"Ap #312-6494 Massa. Ave"},{"name":"Isaac Casey","phone":"001-311-5399","email":"mattis@Donec.co.uk","company":"Dapibus Id Blandit Corporation","regdate":"04.02.06","addr":"P.O. Box 289, 5209 A, St."},{"name":"Ira Lamb","phone":"099-375-0178","email":"Praesent.luctus@eu.com","company":"Penatibus PC","regdate":"07.21.07","addr":"Ap #733-9760 Id, Rd."},{"name":"Daniel Barrett","phone":"070-752-2261","email":"purus@tincidunt.ca","company":"Egestas Corporation","regdate":"05.19.06","addr":"Ap #806-1444 Curabitur Street"},{"name":"Keegan Berry","phone":"078-753-2705","email":"mollis.Integer@Nuncac.org","company":"Cursus Consulting","regdate":"07.04.01","addr":"8040 Et Road"},{"name":"Fletcher Howard","phone":"070-424-6989","email":"per@idsapienCras.co.uk","company":"Gravida Sit Limited","regdate":"02.08.07","addr":"Ap #870-9366 Est. Avenue"},{"name":"Gary Rivera","phone":"086-013-7412","email":"penatibus.et@leoelementum.co.uk","company":"Sagittis Duis Gravida Corporation","regdate":"02.15.03","addr":"P.O. Box 668, 1993 Nec, Avenue"},{"name":"Hyatt Greer","phone":"066-441-9024","email":"magnis@magna.net","company":"Hendrerit Associates","regdate":"04.27.09","addr":"P.O. Box 801, 1454 Euismod Road"},{"name":"Macaulay Bernard","phone":"093-301-1155","email":"pharetra.nibh@sapien.edu","company":"Montes Nascetur Ltd","regdate":"02.21.06","addr":"8700 Ornare, Av."},{"name":"Dustin Mitchell","phone":"097-868-9869","email":"sociis.natoque.penatibus@aliquetmolestie.org","company":"Mi Ltd","regdate":"11.28.05","addr":"P.O. Box 475, 5187 Montes, St."},{"name":"Blaze Perry","phone":"091-644-8649","email":"Ut@aliquet.com","company":"Laoreet Institute","regdate":"04.20.05","addr":"P.O. Box 374, 5614 Donec St."},{"name":"Logan Hamilton","phone":"097-566-5013","email":"Aenean.eget@utpellentesque.net","company":"Nunc Lectus Pede Foundation","regdate":"07.30.03","addr":"5620 Enim. Rd."},{"name":"Fuller Cooke","phone":"013-026-9183","email":"ante.dictum@ultricesposuerecubilia.ca","company":"Scelerisque Neque Inc.","regdate":"12.09.06","addr":"Ap #226-4512 Malesuada. Av."},{"name":"Wade Jacobson","phone":"029-747-0473","email":"nibh.sit.amet@etmagna.edu","company":"Aliquet Corp.","regdate":"11.30.07","addr":"2896 Elit Avenue"},{"name":"Dorian Grimes","phone":"012-563-0428","email":"dolor.vitae@egestas.org","company":"Tortor Nibh Sit Consulting","regdate":"05.13.02","addr":"Ap #955-3953 Justo Avenue"},{"name":"Vance Curtis","phone":"015-000-3745","email":"a@tellusPhaselluselit.edu","company":"Nisi Magna Sed Corp.","regdate":"05.20.03","addr":"P.O. Box 397, 9603 Non Road"},{"name":"Giacomo Boyer","phone":"078-797-8162","email":"auctor.vitae@netus.net","company":"Lorem Incorporated","regdate":"10.07.04","addr":"3708 Montes, Street"},{"name":"Trevor Waters","phone":"099-679-6426","email":"auctor.nunc@lorem.org","company":"Purus Consulting","regdate":"12.02.02","addr":"P.O. Box 322, 3330 Imperdiet St."},{"name":"Lev Sims","phone":"073-733-6931","email":"vel@sociosquad.com","company":"Nunc Sed Inc.","regdate":"08.26.01","addr":"Ap #357-8770 Ipsum Road"},{"name":"Drew Fitzgerald","phone":"015-102-5302","email":"sapien.Nunc.pulvinar@mauris.org","company":"Facilisis Facilisis Limited","regdate":"06.09.07","addr":"P.O. Box 677, 699 Ac Av."},{"name":"Igor Joyce","phone":"072-466-5583","email":"Nullam.lobortis@ipsumdolorsit.edu","company":"Phasellus At Augue Corporation","regdate":"06.17.09","addr":"Ap #541-5204 Nunc St."},{"name":"Lee Shepherd","phone":"086-191-1088","email":"et.magna.Praesent@Pellentesquehabitantmorbi.co.uk","company":"Metus Vivamus Euismod Consulting","regdate":"10.23.06","addr":"P.O. Box 507, 2154 Malesuada. Av."}];

for(var i = 0 ; i < 100; i++){
	data = data.concat(grid_data);
}

// Cross Domain에서 사용이 가능하도록 event listener 설정
if (window.addEventListener){
	addEventListener("message", listener, false);
} else {
	attachEvent("onmessage", listener);
}

function listener(event){
	if( !QBOX._.isUndefined(event.data) ) {
		var data = "";
		if( QBOX._.isObject(event.data) ){
			data = event.data;
		} else if(QBOX._.isString(event.data)) {
			data = JSON.parse(event.data);
		}
		QBOX.$("#"+data.ifrm).remove();
		if( data.alert.length > 0) {
			alert(data.alert);
			return;
		} else {
			window[data.target].setData(data.result);
		}
	}
}

QBOX.$(document).ready(function(){
	QCELL.create({
		id			: "qcell1",
		parentid	: "sheetarea",
		columns		: [
			{width: "20%",		key: "name",		title: ["개인정보","이름"]},
			{width: "10%",		key: "phone",		title: ["개인정보","전화번호"]},
			{width: "20%",		key: "email",		title: ["개인정보","이메일"]},
			{width: "20%",		key: "company",		title: ["회사정보","사명"]},
			{width: "10%",		key: "regdate",		title: ["회사정보","입사일"]},
			{width: "20%",		key: "addr",		title: ["회사정보","주소"]}
		],
		data		: {"input": []},
		rowheader	: "sequence",
		emptymessage: "데이터가 없습니다."
	});
	
	qcell1 = QCELL.getInstance("qcell1");
	
	if( QBOX.$.browser.msie && QBOX.$.browser.version < 10) {
		QBOX.$(".oldIE").hide();
	}
	
	$("#file").change(function(e){
		var properties = {
			event: e,
			headerrows: 2
			//,progressui: true // progressui 여부
		};
		qcell1.excelUpload(properties);
	});
	
	$("#file2").change(function(e){
		var properties = {
			cellname: "qcell1",
			fileid: $(this).attr("id"),
			headerrows: 2,
			url: '/demo/excelUpload'
			//,progressui: true // progressui 여부
		};
		qcell1.excelUpload(properties);
	});
});

function exportLOC(){
	var properties = {
		filename: "exportLoc",
		border: true, // border 처리
		headershow: true, // header 출력
		colwidth: true // col의 width 'px' 적용
		//progressui: true // progressui 여부
	};
	qcell1.excelDownload(properties);
}

function exportURL(){
	var properties = {
		filename: "exportUrl",
		url: '/excelDownload.do',
		border: true, // border 처리
		headershow: true, // header 출력
		colwidth: true, // col의 width 'px' 적용
		//progressui: true, // progressui 여부 
		huge: false, //대용량 여부
		param: {
			data1: "data1",
			data2: "data2"
		}
	};
	qcell1.excelDownload(properties);
}

function dataLoad(){
	qcell1.setData(data);
}
</script>











<div class="main_title"><a href="/">QCELL DEMO</a></div>
<div class="line"></div>
<div class="detail_contents">
	<div class="explain">
		<div class="contents">
			<div class="title"></div>
			<div class="guide">
			Excel Import / Export 사용 예제입니다.<br>
			IE10 이후의 MS사의 브라우저나, Chrome, Firefox와 같은 브라우저와 같이 HTML5를 지원하는 브라우저에서는 서버를 통하지 않고, 브라우저 자체적으로 엑셀 파일을 업/다운로드를 사용할 수 있으며, 또한 Data 정보만 담기 / Border 설정 여부등을 설정하여 엑셀 파일을 다운로드 받을 수 있습니다.<br>
			현재 지원하는 엑셀 파일은 MSOffice 2007버전 이후에 지원하는 xlsx파일 형식만을 지원합니다.
			</div>
		</div>
	</div>
	
	<div class="btn-area">
		<input type="file" id="file" class="oldIE"> <span class="oldIE">local file upload<br></span>
		<input type="file" id="file2"> <span>server file upload</span><br>
		<br>
		<input type="button" id="export" value="EXCEL" onclick="exportLOC()" class="btns oldIE">
		<input type="button" id="exportUrl" value="EXCEL URL" onclick="exportURL()" class="btns">
		<input type="button" id="load" value="dataLoad" onclick="dataLoad()" class="btns">
	</div>
	
	
	<div id="sheetarea" style="width:100%;height:600px;"></div>

</body>
</html>