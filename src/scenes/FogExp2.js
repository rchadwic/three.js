/**
 * @author mrdoob / http://mrdoob.com/
 * @author alteredq / http://alteredqualia.com/
 */

THREE.FogExp2 = function ( color, density ) {

	this.name = '';

	this.color = new THREE.Color( color );
	this.density = ( density !== undefined ) ? density : 0.00025;
	    this.vFalloff = 20;
    this.vFalloffStart = 0;
    this.vAtmosphereColor = new THREE.Color(0x000000);

    this.vAtmosphereColor.r = 0.0;
    this.vAtmosphereColor.g = 0.02;
    this.vAtmosphereColor.b = 0.04;

    this.vAtmosphereDensity = .0005;

    this.vHorizonColor = new THREE.Color(0x000000);
    this.vHorizonColor.r = 0.88;
    this.vHorizonColor.g = 0.94;
    this.vHorizonColor.b = 0.999;


    this.vApexColor = new THREE.Color(0x000000);
    this.vApexColor.r = 0.78;
    this.vApexColor.g = 0.82;
    this.vApexColor.b = 0.999;

};

THREE.FogExp2.prototype.clone = function () {

	var ret = new THREE.FogExp2( this.color.getHex(), this.density );

    ret.color = this.color.clone();
    
    ret.density = this.density;
    ret.vFalloff = this.vFalloff;
    ret.vFalloffStart = this.vFalloffStart;
    ret.vAtmosphereColor = this.vAtmosphereColor.clone();
    ret.vAtmosphereDensity = this.vAtmosphereDensity;
    ret.vHorizonColor = this.vHorizonColor.clone();
    ret.vApexColor = this.vApexColor.clone();
    return ret;
   

};
