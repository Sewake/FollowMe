package en;

class Hero extends Entity {
	var ca : dn.heaps.Controller.ControllerAccess;

    public function new(x,y) {
		super(x,y);
		ca = Main.ME.controller.createAccess("hero");

		spr.anim.registerStateAnim("playerIdle", 0, 0.4);
		spr.anim.registerStateAnim("playerSkip", 1, 0.2, function() return isMoving());
		spr.anim.registerStateAnim("playerFall", 2, 0.8, function() return isFalling());
		spr.anim.registerStateAnim("playerJump", 2, 0.2, function() return isJumping());
	}

	public function isLocked() return cd.has("lock");
	inline function isMoving() return M.fabs(dxTotal)>=0.01;
	inline function isFalling() return dyTotal > 0;
	inline function isJumping() return dyTotal < 0;

    override public function update() {
		super.update();

		var leftDist = M.dist(0,0, ca.lxValue(), ca.lyValue());
		var leftPushed = leftDist>=0.3;
		var leftAng = Math.atan2(-ca.lyValue(), ca.lxValue());

		if( !isLocked() ) {
			// Move
			if( leftPushed ) {
				// var s = 0.014 * leftDist * tmod * ( isGrabbing(Item) ? 1-grabbedEnt.as(Item).getSpeedReductionOnGrab() : 1.0 );
				var s = 0.014 * leftDist * tmod * 1.0;
				dx+=Math.cos(leftAng)*s;
				dy+=Math.sin(leftAng)*s;
				if( ca.lxValue()<0.3 ) dir = -1;
				if( ca.lxValue()>0.3 ) dir = 1;
			}
			else {
				dx *= Math.pow(0.6,tmod);
				dy *= Math.pow(0.6,tmod);
			}

			if( ca.aDown() && !level.hasCollision(cx,cy) ) {
				// WIP; TODO: jumpLock
				dy = -0.35;
			}
		}
    }
}