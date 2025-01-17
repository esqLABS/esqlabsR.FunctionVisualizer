#' extractVariableNames
#'
#' @description A fct function
#'
#' @return A character vector of variable names extracted from the equation.
#'
#' @examples
#' extractVariableNames("a * (b + 5) / c - sqrt(d)")
#' # Returns: "a" "b" "c" "d"
#'
#' extractVariableNames("x^2 + y - log(z)", c("exp", "log", "sin", "cos", "tan", "sqrt", "floor", "ceiling", "pi"))
#' # Returns: "x" "y" "z"
#' @keywords internal
#' @noRd
extractVariableNames <- function(equation,
                                 mathexpressions = c("exp", "log", "sin", "cos", "tan", "sqrt", "floor", "ceiling", "pi"),
                                 operatorTokenRegex = "[-+*/^(){}]|(%%)|(%/%)"
) {
  # Check input types
  if (!is.character(equation) || !is.character(mathexpressions) || !is.character(operatorTokenRegex)) {
    stop("Both 'equation', 'mathexpressions' and 'operatorTokenRegex' must be character vectors.")
  }

  # Remove all blanks from the equation
  cleaned_eq <- gsub("[[:blank:]]", "", equation)

  # Split the equation string at arithmetic operators and parentheses
  split_eq <- unlist(strsplit(
    cleaned_eq,
    operatorTokenRegex
  ))


  # Remove numeric values and predefined mathematical expressions to get variable names
  varnames <- setdiff(
    grep("[^[:digit:]*.?[:digit:]+]", split_eq, value = TRUE),
    mathexpressions
  )

  return(varnames)
}
