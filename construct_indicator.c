#include "mex.h"

void mexFunction(
    int nlhs, mxArray *plhs[],
    int nrhs, const mxArray *prhs[])
{
    mwSize m;
    mwSize n;
    mwSize i, j;
    mwSize numlabel;
    int index;
    double * yp;
    double * pIndex;
    double * pNum;
    
    
    /* Check for proper number of arguments */
    if (nrhs < 2) {
      mexErrMsgTxt("Two input arguments required.");
    } else if (nlhs > 1) {
      mexErrMsgTxt("Too many output arguments.");
    }
    
    if (!mxIsDouble(prhs[0]) | !mxIsDouble(prhs[1])){
      mexErrMsgTxt("The matrix must be full\n");
    }
    
    /* Get the data */
    pIndex = (double * ) mxGetPr(prhs[0]); /* the index matrix */
    pNum  = (double *) mxGetPr(prhs[1]); 
    /* the number of top entries for each row*/
    
    m = mxGetM(prhs[0]); 
    n = mxGetN(prhs[0]);
    
    /* mexPrintf("m=%d, n=%d\n", m, n); */
    

    /* the output matrix */
    plhs[0] = mxCreateDoubleMatrix(m, n, mxREAL); 
    yp = mxGetPr(plhs[0]);
    
    /* initialize to zero */
    for (i=0; i<m*n; i++)
      yp[i] = 0;

    /* start copy values */
    for (i=0; i<m; i++){
      numlabel = (int)pNum[i];
      /* mexPrintf("i=%d, numlabel = %d\n",i, numlabel); */
      for (j=0; j<numlabel; j++){
	index = (int) pIndex[j*m+i];
	/* mexPrintf("index = %d\n", index); */
	yp[(index-1)*m + i]  = 1;
      }
    }
}



