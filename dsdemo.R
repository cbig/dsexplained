alpha.500 <- 2 / 500
alpha.1000 <- 2 / 1000
alpha.3000 <- 2 / 3000

distance <- 5000

kernel.trans <- function(distance, alpha, two.dim=FALSE) {
  if (!two.dim) {
    alpha <- alpha / 2
  }
  return(data.frame(x = 1:distance,
                    y = exp(-alpha * 1:distance),
                    alpha = paste0("alpha.", alpha)))
}

dat <- do.call("rbind", lapply(c(alpha.500, alpha.1000, alpha.3000),
                               kernel.trans, distance=distance))

landscape <- create.landscape(1:100, 1:100, 1, "GaussRF", patches=TRUE)
image(landscape)

ds.landscape <- kernel.trans(landscape, alpha.500, two.dim=TRUE)
image(ds.landscape)
