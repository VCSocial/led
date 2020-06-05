package tools;

class JsTools {
	public static function makeSortable(selector:String, onSort:(from:Int, to:Int)->Void) {
		js.Lib.eval('sortable("$selector")');
		new J(selector)
			.off("sortupdate")
			.on("sortupdate", function(ev) {
				var from : Int = ev.detail.origin.index;
				var to : Int = ev.detail.destination.index;
				onSort(from,to);
				// var moved = project.sortLayerDef(from,to);
				// selectLayer(moved);
				// client.ge.emit(LayerDefSorted);
			}
		);
	}

	public static function createFieldTypeIcon(type:FieldType, withName=true, ?ctx:js.jquery.JQuery) : js.jquery.JQuery {
		var icon = new J("<span/>");
		icon.addClass("fieldTypeIcon");
		icon.addClass(type.getName());
		if( withName )
			icon.append('<span class="typeName">'+L.getFieldType(type)+'</span>');
		icon.append('<span class="typeIcon">'+L.getFieldTypeShortName(type)+'</span>');

		if( ctx!=null )
			icon.appendTo(ctx);

		return icon;
	}


	public static function createEntityPreview(ed:EntityDef, scale=1.0) {
		var ent = new J('<div class="entity"/>');
		ent.css("width", ed.width*scale);
		ent.css("height", ed.height*scale);
		ent.css("background-color", C.intToHex(ed.color));

		var wrapper = ent.wrap("<div/>").parent();
		wrapper.addClass("entityPreview");

		if( scale!=1 )
			wrapper.css("transform","scale("+scale+")");

		return wrapper;
	}
}