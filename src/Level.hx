import dn.CdbHelper;
import dn.pathfinder.AStar;

class Level extends dn.Process {
	public var game(get,never) : Game; inline function get_game() return Game.ME;
	public var fx(get,never) : Fx; inline function get_fx() return Game.ME.fx;

	public var wid: Int;
	public var hei: Int;

	var invalidated = true;

	var lInfos : Data.LevelMap;

	var invalidatedColls = true;
	var collMap : Map<Int, Bool> = new Map();

	public function new(id: Data.LevelMapKind) {
		super(Game.ME);
		
		lInfos = Data.levelMap.get(id);
		wid = lInfos.width;
		hei = lInfos.height;

		createRootInLayers(Game.ME.scroller, Const.DP_BG);
	}

	public function setCollision(cx, cy, v) {
		if( isValid(cx,cy) ) {
			invalidatedColls = true;
			collMap.set( coordId(cx, cy), v );
		}
	}

	public function hasCollision(cx,cy) {
		return isValid(cx,cy) ? collMap.get(coordId(cx,cy))==true : true;
	}

	public function attachEntities() {
		for (m in lInfos.markers) {
			switch(m.markerId) {
				case Data.MarkerKind.Hero: Game.ME.hero = new en.Hero(m.x, m.y);
			}
		}
	}

	public inline function isValid(cx,cy) return cx>=0 && cx<wid && cy>=0 && cy<hei;
	public inline function coordId(cx,cy) return cx + cy*wid;


	public function render() {
		for(l in lInfos.layers) {
			var tileSet = lInfos.props.getTileset(Data.levelMap, l.data.file);
			var sheet = hxd.Res.load(l.data.file).toTile();
			var bg = new h2d.TileGroup(sheet, root);
			var tiles = CdbHelper.getLayerTiles(l.data, sheet, lInfos.width, tileSet);

			var g = new h2d.Graphics(root);
			for(t in tiles) {
				// Collisions
				if( l.name=="coll" ) {
					collMap.set(coordId(t.cx,t.cy), true);
				}
				else {
					g.drawTile(t.x, t.y, t.t);
				}
			}
		}
	}

	override function postUpdate() {
		super.postUpdate();

		if( invalidated ) {
			invalidated = false;
			render();
		}
	}
}