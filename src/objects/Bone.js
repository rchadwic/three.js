/**
 * @author mikael emtinger / http://gomo.se/
 * @author alteredq / http://alteredqualia.com/
 * @author ikerr / http://verold.com
 */

THREE.Bone = function ( belongsToSkin ) {

	THREE.Object3D.call( this );

	this.skin = belongsToSkin;

    this.orthoSkinMatrix = new THREE.Matrix4();
	this.accumulatedRotWeight = 0;
	this.accumulatedPosWeight = 0;
	this.accumulatedSclWeight = 0;

};

THREE.Bone.prototype = Object.create( THREE.Object3D.prototype );

THREE.Bone.prototype.updateMatrixWorld = function ( force ) {

	THREE.Object3D.prototype.updateMatrixWorld.call( this, force );

	// Reset weights to be re-accumulated in the next frame

	this.accumulatedRotWeight = 0;
	this.accumulatedPosWeight = 0;
	this.accumulatedSclWeight = 0;

};

THREE.Bone.prototype.update = function(parentSkinMatrix, forceUpdate, parentOrthoSkinMatrix) {

    // update local

    if (this.matrixAutoUpdate) {

        forceUpdate |= this.updateMatrix();

    }

    // update skin matrix

    if (forceUpdate || this.matrixWorldNeedsUpdate) {

        if (parentSkinMatrix) {

            if (this.inheritScale)
                this.skinMatrix.multiplyMatrices(parentSkinMatrix, this.matrix);
            else {
                var tx, ty, tz;
                this.skinMatrix.multiplyMatrices(parentSkinMatrix, this.matrix);
                tx = this.skinMatrix.elements[12];
                ty = this.skinMatrix.elements[13];
                tz = this.skinMatrix.elements[14];
                this.skinMatrix.multiplyMatrices(parentOrthoSkinMatrix, this.matrix);
                this.skinMatrix.elements[12] = tx;
                this.skinMatrix.elements[13] = ty;
                this.skinMatrix.elements[14] = tz;
            }

        } else {

            this.skinMatrix.copy(this.matrix);

        }
        this.orthoSkinMatrix.copy(this.skinMatrix);
        this.orthoSkinMatrix.orthogonalize();
        this.matrixWorldNeedsUpdate = false;
        forceUpdate = true;

        // Reset weights to be re-accumulated in the next frame

        this.accumulatedRotWeight = 0;
        this.accumulatedPosWeight = 0;
        this.accumulatedSclWeight = 0;

    }

    // update children

    for (var i = 0, l = this.children.length; i < l; i++) {

        this.children[i].update(this.skinMatrix, forceUpdate, this.orthoSkinMatrix);

    }

};