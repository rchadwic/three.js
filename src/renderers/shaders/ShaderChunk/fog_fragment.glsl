#ifdef USE_FOG

	#ifdef USE_LOGDEPTHBUF_EXT

		float depth = gl_FragDepthEXT / gl_FragCoord.w;

	#else

		float depth = gl_FragCoord.z / gl_FragCoord.w;

	#endif

	#ifdef FOG_EXP2

		const float LOG2 = 1.442695;
		float fogFactor = exp2( - fogDensity * fogDensity * depth * depth * LOG2 );
		fogFactor = 1.0 - clamp( fogFactor, 0.0, 1.0 );
		#if MAX_DIR_LIGHTS > 0
          gl_FragColor.xyz = aerialPerspective(gl_FragColor.xyz, distance(vFogPosition.xyz,cameraPosition),cameraPosition.xzy, normalize(vFogPosition.xyz-cameraPosition).xzy);
        #endif
	#else

		float fogFactor = smoothstep( fogNear, fogFar, depth );

	
	
	gl_FragColor = mix( gl_FragColor, vec4( fogColor, gl_FragColor.w ), fogFactor );
	#endif

#endif