/*
Copyright (c) 2009, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.net/yui/license.txt
version: 3.0.0
build: 1549
*/
YUI.add("widget-position",function(A){var H=A.Lang,J=A.Widget,K="xy",F="positioned",I="boundingBox",L="renderUI",G="bindUI",D="syncUI",C=J.UI_SRC,E="xyChange";function B(M){this._posNode=this.get(I);A.after(this._renderUIPosition,this,L);A.after(this._syncUIPosition,this,D);A.after(this._bindUIPosition,this,G);}B.ATTRS={x:{setter:function(M){this._setX(M);},lazyAdd:false,getter:function(){return this._getX();}},y:{setter:function(M){this._setY(M);},lazyAdd:false,getter:function(){return this._getY();}},xy:{value:[0,0],validator:function(M){return this._validateXY(M);}}};B.POSITIONED_CLASS_NAME=J.getClassName(F);B.prototype={_renderUIPosition:function(){this._posNode.addClass(B.POSITIONED_CLASS_NAME);},_syncUIPosition:function(){this._uiSetXY(this.get(K));},_bindUIPosition:function(){this.after(E,this._afterXYChange);},move:function(){var M=arguments,N=(H.isArray(M[0]))?M[0]:[M[0],M[1]];this.set(K,N);},syncXY:function(){this.set(K,this._posNode.getXY(),{src:C});},_validateXY:function(M){return(H.isArray(M)&&H.isNumber(M[0])&&H.isNumber(M[1]));},_setX:function(M){this.set(K,[M,this.get(K)[1]]);},_setY:function(M){this.set(K,[this.get(K)[0],M]);},_getX:function(){return this.get(K)[0];},_getY:function(){return this.get(K)[1];},_afterXYChange:function(M){if(M.src!=C){this._uiSetXY(M.newVal);}},_uiSetXY:function(M){this._posNode.setXY(M);}};A.WidgetPosition=B;},"3.0.0",{requires:["widget"]});
