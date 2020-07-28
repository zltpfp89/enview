<%@ page contentType="text/html; charset=UTF-8"%>
<div id="colorPicker" class=colorInner style="z-index: 99999">
	<table id="colorPreview" cellSpacing=0 cellPadding=0>
		<colgroup>
			<col width=81>
			<col width=68>
			<col>
		</colgroup>
		<tbody>
			<tr>
				<td><div id="colorThumb" style="background-image: none; background-color: #616544" ></div></td>
				<td><INPUT id="colorInput" maxLength=7></td>
				<td><a id="colorInputBtn"><img alt=입력 src="<%=request.getContextPath() %>/cola/cafe/images/editor/colorPicker/input.gif" width=33 height=16></a></td>
			</tr>
		</tbody>
	</table>
	<table id="colorSwatches" cellSpacing="1" cellPadding="0">
		<tbody>
			<tr>
				<td><div style="background-color: #ff0000"></div></td>
				<td><div style="background-color: #ff5e00"></div></td>
				<td><div style="background-color: #ffbb00"></div></td>
				<td><div style="background-color: #ffe400"></div></td>
				<td><div style="background-color: #abf200"></div></td>
				<td><div style="background-color: #1ddb16"></div></td>
				<td><div style="background-color: #00d8ff"></div></td>
				<td><div style="background-color: #0054ff"></div></td>
				<td><div style="background-color: #0100ff"></div></td>
				<td><div style="background-color: #5f00ff"></div></td>
				<td><div style="background-color: #ff00dd"></div></td>
				<td><div style="background-color: #ff007f"></div></td>
				<td><div style="background-color: #000000"></div></td>
				<td><div style="background-color: #ffffff"></div></td>
			</tr>
			<tr>
				<td><div style="background-color: #ffd8d8"></div></td>
				<td><div style="background-color: #fae0d4"></div></td>
				<td><div style="background-color: #faecc5"></div></td>
				<td><div style="background-color: #faf4c0"></div></td>
				<td><div style="background-color: #e4f7ba"></div></td>
				<td><div style="background-color: #cefbc9"></div></td>
				<td><div style="background-color: #d4f4fa"></div></td>
				<td><div style="background-color: #d9e5ff"></div></td>
				<td><div style="background-color: #dad9ff"></div></td>
				<td><div style="background-color: #e8d9ff"></div></td>
				<td><div style="background-color: #ffd9fa"></div></td>
				<td><div style="background-color: #ffd9ec"></div></td>
				<td><div style="background-color: #f6f6f6"></div></td>
				<td><div style="background-color: #eaeaea"></div></td>
			</tr>
			<tr>
				<td><div style="background-color: #ffa7a7"></div></td>
				<td><div style="background-color: #ffc19e"></div></td>
				<td><div style="background-color: #ffe08c"></div></td>
				<td><div style="background-color: #faed7d"></div></td>
				<td><div style="background-color: #cef279"></div></td>
				<td><div style="background-color: #b7f0b1"></div></td>
				<td><div style="background-color: #b2ebf4"></div></td>
				<td><div style="background-color: #b2ccff"></div></td>
				<td><div style="background-color: #b5b2ff"></div></td>
				<td><div style="background-color: #d1b2ff"></div></td>
				<td><div style="background-color: #ffb2f5"></div></td>
				<td><div style="background-color: #ffb2d9"></div></td>
				<td><div style="background-color: #d5d5d5"></div></td>
				<td><div style="background-color: #bdbdbd"></div></td>
			</tr>
			<tr>
				<td><div style="background-color: #f15f5f"></div></td>
				<td><div style="background-color: #f29661"></div></td>
				<td><div style="background-color: #f2cb61"></div></td>
				<td><div style="background-color: #e5d85c"></div></td>
				<td><div style="background-color: #bce55c"></div></td>
				<td><div style="background-color: #86e57f"></div></td>
				<td><div style="background-color: #5cd1e5"></div></td>
				<td><div style="background-color: #6799ff"></div></td>
				<td><div style="background-color: #6b66ff"></div></td>
				<td><div style="background-color: #a566ff"></div></td>
				<td><div style="background-color: #f361dc"></div></td>
				<td><div style="background-color: #f361a6"></div></td>
				<td><div style="background-color: #a6a6a6"></div></td>
				<td><div style="background-color: #8c8c8c"></div></td>
			</tr>
			<tr>
				<td><div style="background-color: #cc3d3d"></div></td>
				<td><div style="background-color: #cc723d"></div></td>
				<td><div style="background-color: #cca63d"></div></td>
				<td><div style="background-color: #c4b73b"></div></td>
				<td><div style="background-color: #9fc93c"></div></td>
				<td><div style="background-color: #47c83e"></div></td>
				<td><div style="background-color: #3db7cc"></div></td>
				<td><div style="background-color: #4374d9"></div></td>
				<td><div style="background-color: #4641d9"></div></td>
				<td><div style="background-color: #8041d9"></div></td>
				<td><div style="background-color: #d941c5"></div></td>
				<td><div style="background-color: #d9418c"></div></td>
				<td><div style="background-color: #747474"></div></td>
				<td><div style="background-color: #5d5d5d"></div></td>
			</tr>
			<tr>
				<td><div style="background-color: #980000"></div></td>
				<td><div style="background-color: #993800"></div></td>
				<td><div style="background-color: #997000"></div></td>
				<td><div style="background-color: #998a00"></div></td>
				<td><div style="background-color: #6b9900"></div></td>
				<td><div style="background-color: #2f9d27"></div></td>
				<td><div style="background-color: #008299"></div></td>
				<td><div style="background-color: #003399"></div></td>
				<td><div style="background-color: #050099"></div></td>
				<td><div style="background-color: #3f0099"></div></td>
				<td><div style="background-color: #990085"></div></td>
				<td><div style="background-color: #99004c"></div></td>
				<td><div style="background-color: #4c4c4c"></div></td>
				<td><div style="background-color: #353535"></div></td>
			</tr>
			<tr>
				<td><div style="background-color: #670000"></div></td>
				<td><div style="background-color: #662500"></div></td>
				<td><div style="background-color: #664b00"></div></td>
				<td><div style="background-color: #665c00"></div></td>
				<td><div style="background-color: #476600"></div></td>
				<td><div style="background-color: #22741c"></div></td>
				<td><div style="background-color: #005766"></div></td>
				<td><div style="background-color: #002266"></div></td>
				<td><div style="background-color: #030066"></div></td>
				<td><div style="background-color: #2a0066"></div></td>
				<td><div style="background-color: #660058"></div></td>
				<td><div style="background-color: #660033"></div></td>
				<td><div style="background-color: #212121"></div></td>
				<td><div style="background-color: #000000; background-image: url(<%=request.getContextPath()%>/cola/cafe/images/editor/colorPicker/empty.gif);" id="transY"></div></td>
			</tr>
		</tbody>
	</table>
	<div id="resetArea" class="resetArea">
		<a id="colorResetBtn"><img alt=리셋 src="<%=request.getContextPath()%>/cola/cafe/images/editor/colorPicker/reset.gif" width=15 height=14></a> 
	</div>
</div>