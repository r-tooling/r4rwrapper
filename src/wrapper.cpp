#include <string>
#include <iostream>
#include <filesystem>
#include <R.h>
#include <Rinternals.h>
#include <r4r/r4r_lib.h> 


namespace fs = std::filesystem;


std::string sexpToNonEmptyStringOrFail(SEXP str_sexp, std::string argName) {
    if (!Rf_isString(str_sexp) || Rf_length(str_sexp) < 1) {
        std::string errorMessage = argName + ": " + "Expected a non-empty character vector."; 
        error("%s", errorMessage.c_str());  
        throw std::invalid_argument(""); //not reached
    }

    SEXP str_elem = STRING_ELT(str_sexp, 0);
    const char* c_str = CHAR(str_elem);
    return std::string(c_str);
}


extern "C"  SEXP traceExpression(SEXP expression, SEXP output, SEXP baseImage, SEXP imageTag, SEXP containerName) {

    auto expressionAsString = sexpToNonEmptyStringOrFail(expression, "expression");
    auto outputAsString = sexpToNonEmptyStringOrFail(output, "output");
    auto baseImageAsString = sexpToNonEmptyStringOrFail(baseImage, "base image");
    auto imageTagAsString = sexpToNonEmptyStringOrFail(imageTag, "image tag");
    auto containerNameAsString = sexpToNonEmptyStringOrFail(containerName, "container name");
    

    auto ret = r4r_trace_expression(expressionAsString, outputAsString, baseImageAsString, imageTagAsString, containerNameAsString);

    return ScalarInteger(ret);

}