import dn.heaps.slib.*;

class Assets {
	public static var fontPixel : h2d.Font;
	public static var fontTiny : h2d.Font;
	public static var fontSmall : h2d.Font;
	public static var fontMedium : h2d.Font;
	public static var fontLarge : h2d.Font;
	public static var tiles : SpriteLib;

	static var initDone = false;
	public static function init() {
		if( initDone )
			return;
		initDone = true;

		fontPixel = hxd.Res.fonts.minecraftiaOutline.toFont();
		fontTiny = hxd.Res.fonts.barlow_condensed_medium_regular_9.toFont();
		fontSmall = hxd.Res.fonts.barlow_condensed_medium_regular_11.toFont();
		fontMedium = hxd.Res.fonts.barlow_condensed_medium_regular_17.toFont();
		fontLarge = hxd.Res.fonts.barlow_condensed_medium_regular_32.toFont();

		tiles = dn.heaps.assets.Atlas.load("atlas/atlas.atlas");
		tiles.defineAnim("playerIdle", "1-9(2)");
		tiles.defineAnim("playerSkip", "1-8(1)");
		tiles.defineAnim("playerFall", "1-4(2)");
		tiles.defineAnim("playerJump", "1-4(2)");

		// tiles = dn.heaps.assets.Atlas.load("atlas/test_tiles.atlas");
		// tiles.defineAnim("heroRun", "0(2), 1(1), 2(2), 1(1)");
		// tiles.defineAnim("heroIdle", "0(10), 1(1), 2(8)");
	}
}