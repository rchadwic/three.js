

        vec3 tnorm    = normalize(vWorldNormal.xzy);
        #ifdef USE_BUMPMAP

        tnorm  = perturbNormalArb( -vViewPosition, normalize( vNormal ), dHdxy_fwd() );

        #endif
        #ifdef USE_NORMALMAP

        tnorm  = perturbNormal2Arb( -vViewPosition.xzy, tnorm);
       
        #endif
        shAmbient =  C1 * L22 * (tnorm.x * tnorm.x - tnorm.y * tnorm.y) +
                    C3 * L20 * tnorm.z * tnorm.z +
                    C4 * L00 -
                    C5 * L20 +
                   2.0 * C1 * L2m2 * tnorm.x * tnorm.y +
                   2.0 * C1 * L21  * tnorm.x * tnorm.z +
                   2.0 * C1 * L2m1 * tnorm.y * tnorm.z +
                  2.0 * C2 * L11  * tnorm.x +
                  2.0 * C2 * L1m1 * tnorm.y + 
                  2.0 * C2 * L10  * tnorm.z;
        shAmbient *= length(ambientLightColor);