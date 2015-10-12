


## Distribution smoothing in Zonation

### The alpha-value

The $\alpha$-value of biodiversity feature-specific scale of landscape use 
(parameter of negative exponential, $\alpha_j$). This parameter is only used when 
distribution smoothing is enabled. However, you always need to specify this 
parameter, and any numerical value will do fine if distribution smoothing is not 
used. The value indicates the range of connectivity of biodiversity features. 
For example, it may refer to how a species uses the surrounding landscape.

**How to define the degree of smoothing for individual features.** The 
$\alpha$-value indicates how species use the surrounding landscape and can be
calculated based on, for example, the dispersal capability or the home range
sizes of the species. It can be calculated as:

$\alpha=\frac{2}{Use\ of\ landscape\ (in\ same\ units\ as\ cell\ size)}$

It is extremely important to make sure that the distance units used in this
calculation are consistent with the cell size units used in the feature
distribution files. The above equation assumes that '*use of landscape*' is 
given in the same units that are use for the cell size value in the feature 
distribution files (if these are .asc files, the cell size value is given in the 
'*cellsize*' field in the first rows). For example, if the cell size in the 
distribution files is 1 km and the known/guesstimated mean dispersal capability 
of a species is 3 km, then the value of alpha for this feature is:

$\alpha=\frac{2}{3}\approx0.667$

Let the cell size of the distribution files is 100 meters. Let's calculate the
corresponding $\alpha$-values for mean dispersal distances of 500, 1000 and 
3000 meters:


```r
(alpha.500 <- 2/500)
```

```
## [1] 0.004
```

```r
(alpha.1000 <- 2/1000)
```

```
## [1] 0.002
```

```r
(alpha.3000 <- 2/3000)
```

```
## [1] 0.0006667
```


### Distribution smoothing

Distribution smoothing transforms the values of each pixel in the distribution 
file by the values of all the other pixel values according to a negative 
exponential kernel, where the above calulated alpha value is used as a 
multiplier.

When using smoothing, the value for species $j$ in a focal cell $i$ is

$O_ij'=\sum\limits_{x}\sum\limits_{y}exp(-\alpha d(x-u,y-r))O_ij$

where $O_ij$ is the original occurrence level of species $j$ at cell $i$. Cell 
$i$ is located in $(u,r)$ and $d(x-u, y-r)$ is the distance between locations 
$(x,y)$ and $(u,r)$. The summation is over the landscape grid and $\alpha_j$ is
the parameter of the dispersal kernel for species $j$. This is a two-dimension 
kernel smoothing using a radially symmetric negative exponential (dispersal) 
kernel.

For the above calculated $\alpha$-values, the kernel takes the following values:

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


Note that the mean dispersal distances (500, 1000, and 3000 meters) on the 
x-axis correspond to value

$value=exp(-1)\approx 0.368$

on the y-axis.

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

