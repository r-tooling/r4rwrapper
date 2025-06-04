#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>

extern SEXP traceExpression(SEXP expression, SEXP output, SEXP baseImage, SEXP imageTag, SEXP containerName);

static const R_CallMethodDef CallEntries[] = {
  {"traceExpression", (DL_FUNC) &traceExpression, 5},
  {NULL, NULL, 0}
};

void R_init_r4rwrapper(DllInfo *dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}