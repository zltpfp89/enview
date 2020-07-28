<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--
 * FCKeditor - The text editor for Internet - http://www.fckeditor.net
 * Copyright (C) 2003-2009 Frederico Caldeira Knabben
 *
 * == BEGIN LICENSE ==
 *
 * Licensed under the terms of any of the following licenses at your
 * choice:
 *
 *  - GNU General Public License Version 2 or later (the "GPL")
 *    http://www.gnu.org/licenses/gpl.html
 *
 *  - GNU Lesser General Public License Version 2.1 or later (the "LGPL")
 *    http://www.gnu.org/licenses/lgpl.html
 *
 *  - Mozilla Public License Version 1.1 or later (the "MPL")
 *    http://www.mozilla.org/MPL/MPL-1.1.html
 *
 * == END LICENSE ==
 *
 * Flash Properties dialog window.
-->
<html>
	<head>
		<title>Flash Properties</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta content="noindex, nofollow" name="robots">
		<script src="common/fck_dialog_common.js" type="text/javascript"></script>
		<script src="fck_flash/fck_flash.js" type="text/javascript"></script>
		<script type="text/javascript">
			document.write( FCKTools.GetStyleHtml( GetCommonDialogCss() ) ) ;

			<%--BEGIN::Call by upload.jsp, check the limit.--%>
			
			function uploadFlash(fn, fm, fs, halign, valign) {
				var fileUrl = FCKConfig.BasePath.substring(0, FCKConfig.BasePath.lastIndexOf('/fckeditor'));
				fileUrl += '/upload/editor/'+document.frmUpload.boardId.value+'/'+fm;
				OnUploadCompleted(0, fileUrl);
				window.parent.parent.ebEdit.rebuildFile(fn, fm, fs);
				<%-- 
				  가끔가다 preview가 갱신이 안돼는 경우가 발생하므로 여기서 확실하게 해준다.
				  prview가 갱신이 안돼면 편집기 내부로 들어오지도 않는다.
				--%>
				UpdatePreview();
			}

			function uploadCafeGateFlash(fn, fm, fs, halign, valign) {
				var fileUrl = FCKConfig.BasePath.substring(0, FCKConfig.BasePath.lastIndexOf('/board/fckeditor'));
				fileUrl += '/cola/cafe/each/'+document.frmUpload.cmntId.value+'/'+fm;
				OnUploadCompleted(0, fileUrl);
				window.parent.parent.ebEdit.rebuildFile(fn, fm, fs);
				<%-- 
				  가끔가다 preview가 갱신이 안돼는 경우가 발생하므로 여기서 확실하게 해준다.
				  prview가 갱신이 안돼면 편집기 내부로 들어오지도 않는다.
				--%>
				UpdatePreview();
			}

			if (window.parent.parent.ebEdit) { // Just when FCKEditor is used on enBoard.
				if (!window.parent.parent.ebEdit.limitUpload()) {
					window.parent.Cancel(); // FCKeditor's function which called when 'cancel' button is clicked.
				}
			}
			<%--END::Call by upload.jsp, check the limit.--%>

		</script>
	</head>
	<body scroll="no" style="OVERFLOW: hidden">
		<div id="divInfo">
			<table cellSpacing="1" cellPadding="1" width="100%" border="0">
				<tr>
					<td>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td width="100%"><span fckLang="DlgImgURL">URL</span>
								</td>
								<td id="tdBrowse" style="DISPLAY: none" noWrap rowSpan="2">&nbsp; <input id="btnBrowse" onclick="BrowseServer();" type="button" value="Browse Server" fckLang="DlgBtnBrowseServer">
								</td>
							</tr>
							<tr>
								<td vAlign="top"><input id="txtUrl" onblur="UpdatePreview();" style="WIDTH: 100%" type="text" readonly="true">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<TR>
					<TD>
						<table cellSpacing="0" cellPadding="0" border="0">
							<TR>
								<TD nowrap>
									<span fckLang="DlgImgWidth">Width</span><br>
									<input id="txtWidth" onkeypress="return IsDigit(event);" type="text" size="3">
								</TD>
								<TD>&nbsp;</TD>
								<TD>
									<span fckLang="DlgImgHeight">Height</span><br>
									<input id="txtHeight" onkeypress="return IsDigit(event);" type="text" size="3">
								</TD>
							</TR>
						</table>
					</TD>
				</TR>
				<tr>
					<td vAlign="top">
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td valign="top" width="100%">
									<table cellSpacing="0" cellPadding="0" width="100%">
										<tr>
											<td><span fckLang="DlgImgPreview">Preview</span></td>
										</tr>
										<tr>
											<td id="ePreviewCell" valign="top" class="FlashPreviewArea"><iframe src="fck_flash/fck_flash_preview.html" frameborder="0" marginheight="0" marginwidth="0"></iframe></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div id="divUpload" style="DISPLAY: none">
			<form id="frmUpload" name="frmUpload" method="post" target="UploadWindow" enctype="multipart/form-data"
                  action="" onsubmit="document.frmUpload.action=document.frmUpload.action+'&boardId='+document.frmUpload.boardId.value; return CheckUpload();">
				<span fckLang="DlgLnkUpload">Upload</span><br />
				<input id="txtUploadFile" style="WIDTH: 100%" type="file" size="40" name="NewFile" /><br />
				<br />
				<input id="btnUpload" type="submit" value="Send it to the Server" fckLang="DlgLnkBtnUpload" />
				
				<%--BEGIN::Parameters to UploadMngr--%>
				<input type=hidden name=mode value=flash>
				<input type=hidden name=subId value=sub02>
				<input type=hidden name=boardId value=<%=request.getParameter("boardId")%>>
				<input type=hidden name=cmntId value=<%=request.getParameter("cmntId")%>>
				<%--END::Parameters to UploadMngr--%>

				<script type="text/javascript">
					document.write( '<iframe name="UploadWindow" style="DISPLAY: none" src="' + FCKTools.GetVoidUrl() + '"><\/iframe>' ) ;
				</script>
			</form>
		</div>
		<div id="divAdvanced" style="DISPLAY: none">
			<TABLE cellSpacing="0" cellPadding="0" border="0">
				<TR>
					<TD nowrap>
						<span fckLang="DlgFlashScale">Scale</span><BR>
						<select id="cmbScale">
							<option value="" selected></option>
							<option value="showall" fckLang="DlgFlashScaleAll">Show all</option>
							<option value="noborder" fckLang="DlgFlashScaleNoBorder">No Border</option>
							<option value="exactfit" fckLang="DlgFlashScaleFit">Exact Fit</option>
						</select></TD>
					<TD>&nbsp;&nbsp;&nbsp; &nbsp;
					</TD>
					<td valign="bottom">
						<table>
							<tr>
								<td><input id="chkAutoPlay" type="checkbox" checked></td>
								<td><label for="chkAutoPlay" nowrap fckLang="DlgFlashChkPlay">Auto Play</label>&nbsp;&nbsp;</td>
								<td><input id="chkLoop" type="checkbox" checked></td>
								<td><label for="chkLoop" nowrap fckLang="DlgFlashChkLoop">Loop</label>&nbsp;&nbsp;</td>
								<td><input id="chkMenu" type="checkbox" checked></td>
								<td><label for="chkMenu" nowrap fckLang="DlgFlashChkMenu">Enable Flash Menu</label></td>
							</tr>
						</table>
					</td>
				</TR>
			</TABLE>
			<br>
			&nbsp;
			<table cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
				<tr>
					<td vAlign="top" width="50%"><span fckLang="DlgGenId">Id</span><br>
						<input id="txtAttId" style="WIDTH: 100%" type="text">
					</td>
					<td>&nbsp;&nbsp;</td>
					<td vAlign="top" nowrap><span fckLang="DlgGenClass">Stylesheet Classes</span><br>
						<input id="txtAttClasses" style="WIDTH: 100%" type="text">
					</td>
					<td>&nbsp;&nbsp;</td>
					<td vAlign="top" nowrap width="50%">&nbsp;<span fckLang="DlgGenTitle">Advisory Title</span><br>
						<input id="txtAttTitle" style="WIDTH: 100%" type="text">
					</td>
				</tr>
			</table>
			<span fckLang="DlgGenStyle">Style</span><br>
			<input id="txtAttStyle" style="WIDTH: 100%" type="text">
		</div>
	</body>
</html>