package en;

class Hero extends Entity {
	var ca : dn.heaps.Controller.ControllerAccess;

    public function new(x,y) {
		super(x,y);
		ca = Main.ME.controller.createAccess("hero");

		spr.anim.registerStateAnim("heroRun", 1, 0.2, function() return isMoving());
		spr.anim.registerStateAnim("heroIdle", 0, 0.4);
	}

	public function isLocked() return cd.has("lock");
	inline function isMoving() return M.fabs(dxTotal)>=0.01 || M.fabs(dyTotal)>=0.01;

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
		}
    }
}