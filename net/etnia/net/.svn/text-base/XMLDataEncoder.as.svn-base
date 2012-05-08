package net.etnia.net {

	import com.etnia.net.XMLDataManager;
	
	import net.etnia.core.interfaces.IObject;

	public class XMLDataEncoder extends XMLDataManager {

		public function XMLDataEncoder() {
			super();
		}

		public static function encode($data:Object):XML {
			var defaultString:String = '<?xml version="1.0" encoding="UTF-8" ?><xmlData format="xmlDataManager" version="1.0"></xmlData>';
			var xml:XML = new XML(defaultString);
			for(var name:String in $data){
				var item:* = $data[name];
				var type:String = typeof item;
				var xmlNode:XML;
				if(type != "object"){
					xmlNode = node(name, type, item);
				} else {
					type = item is Array ? "array" : type;
					if(!(item is IObject) && type == "object"){
						try {
							item.prototype
						} catch($error:Error) {
							throw new Error();
						}
					}else if(type != "array"){
						item = item.toObject();
						type = item.classType != null ? item.classType : type;
						delete item.classType;
					}
					xmlNode = getSubContent(node(name, type), item)
				}
				xml.appendChild(xmlNode);
			}
			return xml;
		}

		protected static function getSubContent($node:XML, $data:Object):XML {
			for(var name:String in $data){
				var item:* = $data[name];
				var type:String = typeof item;
				var xmlNode:XML;
				if(type != "object"){
					xmlNode = node(name, type, item);
				}else{
					type = item is Array ? "array" : type;
					if(!(item is IObject) && type == "object"){
						try{
							item.prototype
						}catch($error:Error){
							throw new Error();
						}
					}else if(type != "array") {
						item = item.toObject();
						type = item.classType != null ? item.classType : type;
						delete item.classType;
					}
					xmlNode = getSubContent(node(isNaN(Number(name)) ? name : null, type), item)
				}
				$node.appendChild(xmlNode);
			}
			return $node;
		}
		
		protected static function simpleNode($value:String):XML {
			return new XML("<var>"+$value+"</var>");
		}
		
		protected static function node($name:String, $type:String, $content:String=""):XML {
			$name = $name != null ? 'varName="'+$name+'" ' : '';
			var str:String = '<var '+$name+' varType="'+$type+'">'+($content)+'</var>'; 
			return new XML(str);
		}

	}
}