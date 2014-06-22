# Example usage:
# source("cachematrix.R")
# x <- matrix(rnorm(9), nrow = 3)      # Create a matrix x
# cx <- makeCacheMatrix(x)              # Create our special matrix
# cx$get()                              # Return the matrix
# cacheSolve(cx)                        # Return the inverse
# cacheSolve(cx)                        # Call again to return cached inverse matrix


# makeCacheMatrix containing function for:
# 1. Set the value of the matrix
# 2. Get the value of the matrix
# 3. Set the value of the inverse
# 4. Get the value of the inverse
makeCacheMatrix <- function(x = matrix()) {
    # inv will store the cached inverse matrix
    inv <- NULL

    # Setter - matrix
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    # Getter - matrix
    get <- function() x

    # Setter - inverse matrix
    setinv <- function(inverse) inv <<- inverse
    # Getter - inverse matrix
    getinv <- function() inv
	
    list(set = set, get = get, setinv = setinv, getinv = getinv)
}


# Function cacheSolve - Computes inverse of the matrix.
# Returns the cached inverse if available.
cacheSolve <- function(x, ...) {
    inv <- x$getinv()

    # Cached Data
    if (!is.null(inv)) {
        message("This is cached data")
        return(inv)
    }

    # First Time ran Data
    data <- x$get()
    inv <- solve(data, ...)

    # Cache the object
    x$setinv(inv)
	
    inv
}