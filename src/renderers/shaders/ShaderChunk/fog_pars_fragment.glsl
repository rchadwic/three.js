
        #ifdef USE_FOG

        uniform vec3 fogColor;

        #ifdef FOG_EXP2

        uniform vec3 vAtmosphereColor; //vec3(0.0, 0.02, 0.04);
        uniform vec3 vHorizonColor; //vec3(0.88, 0.94, 0.999);
        uniform vec3 vApexColor; //vec3(0.78, 0.82, 0.999)
        uniform float vAtmosphereDensity; //.0005
        uniform float vFalloff;
        uniform float vFalloffStart;
              uniform float fogDensity;

        #if MAX_DIR_LIGHTS > 0
         
        

        vec3 atmosphereColor(vec3 rayDirection){
            float a = max(0.0, dot(rayDirection, vec3(0.0, 1.0, 0.0)));
            vec3 skyColor = mix(vHorizonColor, vApexColor, a);
            float sunTheta = max( dot(rayDirection, directionalLightDirection[0].xzy), 0.0 );
            return skyColor+directionalLightColor[0]*4.0*pow(sunTheta, 16.0)*0.5;
        }

        vec3 applyFog(vec3 albedo, float dist, vec3 rayOrigin, vec3 rayDirection){
            float fogDensityA = fogDensity ;
            float fog = exp((-rayOrigin.y*vFalloff)*fogDensityA) * (1.0-exp(-dist*rayDirection.y*vFalloff*fogDensityA))/(rayDirection.y*vFalloff);
            return mix(albedo, fogColor, clamp(fog, 0.0, 1.0));
        }

        vec3 aerialPerspective(vec3 albedo, float dist, vec3 rayOrigin, vec3 rayDirection){
         rayOrigin.y += vFalloffStart;
            vec3 atmosphere = atmosphereColor(rayDirection)+vAtmosphereColor; 
            atmosphere = mix( atmosphere, atmosphere*.85, clamp(1.0-exp(-dist*vAtmosphereDensity), 0.0, 1.0));
            vec3 color = mix( applyFog(albedo, dist, rayOrigin, rayDirection), atmosphere, clamp(1.0-exp(-dist*vAtmosphereDensity)-log(rayOrigin.y)/10.0, 0.0, 1.0));
            return color;
        }                      
        #endif
          #else

               uniform float fogNear;
               uniform float fogFar;

           #endif

        #endif