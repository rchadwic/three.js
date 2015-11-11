mat4 normMat = modelMatrix;
normMat[3][0] = normMat[3][1] = normMat[3][2] = 0.0;
vWorldNormal = normalize(normMat * vec4(normal,1.0));