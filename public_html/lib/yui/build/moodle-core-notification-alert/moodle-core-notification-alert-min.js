YUI.add("moodle-core-notification-alert",function(e,t){var n,r,i,s,o,u,a,f;n="moodle-dialogue",r="notificationBase",i=0,s="yesLabel",o="noLabel",u="title",a="question",f={BASE:"moodle-dialogue-base",WRAP:"moodle-dialogue-wrap",HEADER:"moodle-dialogue-hd",BODY:"moodle-dialogue-bd",CONTENT:"moodle-dialogue-content",FOOTER:"moodle-dialogue-ft",HIDDEN:"hidden",LIGHTBOX:"moodle-dialogue-lightbox"},M.core=M.core||{};var l="Moodle alert",c;c=function(e){e.closeButton=!1,c.superclass.constructor.apply(this,[e])},e.extend(c,M.core.dialogue,{_enterKeypress:null,initializer:function(){this.publish("complete");var t=e.Node.create('<input type="button" id="id_yuialertconfirm-'+this.get("COUNT")+'" value="'+this.get(s)+'" />'),n=e.Node.create('<div class="confirmation-dialogue"></div>').append(e.Node.create('<div class="confirmation-message">'+this.get("message")+"</div>")).append(e.Node.create('<div class="confirmation-buttons"></div>').append(t));this.get(r).addClass("moodle-dialogue-confirm"),this.setStdModContent(e.WidgetStdMod.BODY,n,e.WidgetStdMod.REPLACE),this.setStdModContent(e.WidgetStdMod.HEADER,'<h1 id="moodle-dialogue-'+this.get("COUNT")+'-header-text">'+this.get(u)+"</h1>",e.WidgetStdMod.REPLACE),this.after("destroyedChange",function(){this.get(r).remove()},this),this._enterKeypress=e.on("key",this.submit,window,"down:13",this),t.on("click",this.submit,this)},submit:function(){this._enterKeypress.detach(),this.fire("complete"),this.hide(),this.destroy()}},{NAME:l,CSS_PREFIX:n,ATTRS:{title:{validator:e.Lang.isString,value:"Alert"},message:{validator:e.Lang.isString,value:"Confirm"},yesLabel:{validator:e.Lang.isString,setter:function(e){return e||(e="Ok"),e},value:"Ok"}}}),M.core.alert=c},"@VERSION@",{requires:["moodle-core-notification-dialogue"]});
