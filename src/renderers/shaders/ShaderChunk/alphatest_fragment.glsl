#ifdef ALPHATEST

	if ( gl_FragColor.a < float(ALPHATEST) ) discard;

#endif
