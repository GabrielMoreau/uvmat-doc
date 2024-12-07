# Thin Plate Shell interpolation

Interpolation/smoothing is an important aspect of PIV.
Linear interpolation is the simplest option but it cannot smooth noise, and for 2D (or 3D) fields it does not extrapolate data beyond the convex hull of the initial data set.
Global polynomial interpolation generally produce excessive smoothing, for low order polynomials, or spurious oscillations, for high order polynomials.
Cubic spline is an optimum general method to interpolate a 1D data series $f_{i}$  measured at a set of abscissa $x_{i},i=1,\ldots,N.$ The spline interpolation function $f(x)$  is made of piecewise cubic polynomials matched at the measurement abscissa $x_{i}$ by the condition $f(x_{i})=f_{i} $, with the continuity of the first derivative.
It can be shown that this spline function minimizes the global curvature $\int_{x_{1}}^{x_{N}}f_(x)^{2}dx$ .
The name 'spline' refers to a flexible wooden strip used in ship design to draw a smooth curved line pinned on a set of reference points.
Its equilibrium shape indeed minimizes the elastic energy.
This is proportional to the integral of $f_{2}$ if it represents a small transverse displacement from the absissa line.

To deal with noisy data, smoothing spline do not go strictly through the measurement values, but minimises a linear combination of distance to these values and curvature $E=\sum_{i=1}^{N}(f_{i}-f(x_{i}))^{2}+\rho\int_{x_{1}}^{x_{N}}f_(x)_{2}\,\mathrm{d}x$, where $\rho$  is a smoothing parameter.
In the limit of small $\rho$ , the weight of the distance constraint becomes very strong so the optimum approaches the pure interpolation spline, with $f(x_{i})=f_{i}$.
In the opposite limit of large $\rho$ , the curvature constraint becomes very strong, so the optimum tends to be linear $(f_=0 )$ and approaches the least square linear fit by the minimisation of the distance term contribution.

Generalisation to multi-dimensional spaces can be performed as products of spline functions along each coordinate.
However this choice is not optimum and depends on the coordinate axis.
The proper generalisation is the ’thin plate spline’ proposed by Duchon, 1976 ('Splines minimizing rotation invariant semi-norms in Sobolev spaces. pp 85–100, In: Constructive Theory of Functions of Several Variables, Oberwolfach 1976, W. Schempp and K. Zeller, eds., Lecture Notes in Math., Vol. 571, Springer, Berlin, 1977).
The name refers to a physical analogy with the bending of a thin sheet of metal.
Practical algorithms have been first developed by Paihua Montes (these UJF 1978, 'Quelques méthodes numériques pour le calcul de fonctions splines').It has been first used in the field of cartography and first applied to flow measurements by [attachment:NguyenDuc_sommeria_1988.pdf NguyenDuc and Sommeria(1988)].
We use here a more recent algorithm proposed by Wahba, 1990 ('Spline models for observational data', SIAM bookstore), rely on the standard inversion matrix functions provided by Matlab.

# Case of pure interpolation

We consider a set of measurement points ${\bf r_i}, i = 1,2, \ldots,N$, and the corresponding set of measurements values for a quantity $f$ (a velocity component for PIV data).

$$f({\bf r_i})=f_i, i = 1,2, \ldots,N \; [equ. 1]$$

A pure interpolation function $f({\bf r})$ must exactly reach these values $f_i$ at the measurement points, while a smoothing function should approach these values within a range smaller than the estimated error bar.

Considering first the case of a pure interpolation, the function $f({\bf r})$ must minimise the 'elastic energy' or mean squared curvature 

$$E = \int\left[\left(\frac{\partial^2 f}{\partial x^2}\right)^2 + 2\left(\frac{\partial^2 f}{\partial xy}\right)^2 + \left(\frac{\partial^2 f}{\partial y^2}\right)^2 \right] \textrm{d} x \, \textrm{d}y  \;\textrm{[equ. 2]}$$

with the constraints [->equ. 1].
These constraints can be also written as a domain integral with Dirac functions at measurement points: 

$${\int f \delta({\bf r-r_i}) \textrm{d} x \, \textrm{d}y=f_i , i = 1,2, \ldots,N} \;\textrm{[equ. 3]}$$

This variational problem is solved by introducing a Lagrange parameter $8\pi S_i$ for each constraint (the factor $8\pi$ is put for further convenience).
The variation of the energy can be rewritten by a double integration by part, leading to $\int \Delta^2 f \delta f dx dy$.
The optimum function $f$ is thus solution of the  double Laplacian equation with pointwise source terms at locations $r_i$,

$$\Delta^2 f= \sum 8\pi S_i \delta ({\bf r-r_i})\;\textrm{[equ. 4]}$$

The solution $\phi$ for a single source point is such that $\Delta^2 \phi=0$ everywhere outside the source.
Using the axisymmetric form of the Laplacian $\Delta \phi=\frac{1}{r}\frac{d}{dr}(r\frac{d\phi}{dr})$, we can show that the general axisymmetric solution is 

$$\phi=C_0 \log(r)+C_1 r^2 + C_2 r^2 \log (r)+C_3 \;\textrm{[equ. 5]}$$
whose Laplacian writes 

$$\Delta\phi=\frac{1}{r}\frac{d}{dr}(r\frac{d\phi}{dr})=4 C_1+ 4 C_2 (1+\log(r))\;\textrm{[equ. 6]}$$

The coefficient $C_0$ must be zero to avoid divergence of $\phi$ at the origin.
The constant $C_3$ can be included in a global constant $a_0$.
The constant $C_1$ can be viewed as a change of unit for $r$ (replacing $r$ by $r/r_0$ with $\log(r_0)=-C_1/C_2)$), and can be set to 0 without loss of generality.
The integral of $\Delta\phi$ over a small neighborhood of the source must be equal to $8\pi S_i$.
By the divergence theorem, this is also equal to the flux of $\nabla \Delta \phi=4 C_2/r$ around the source, equal to $8\pi C_2$.
This must be equal to $8\pi S_i$, which sets $C_2=S_i$.
The elementary function is thus $\phi(r)=S_i r^2\log (r)$.

The general form of $f$ is thus 

$$\label{sol_gene} f({\bf r})=\sum S_i \phi({\bf|r-r_i}|)+a_0+a_1x+a_2y\;\textrm{[equ. 7]}$$

with $\phi(r)=r^2\log (r)$.
The  values at the measurement points ${\bf r_j}$ are 

$$f({\bf r_j})=\sum S_i \phi({\bf|r_j-r_i}|)+a_0+a_1x_j+a_2y_j;\;\textrm{[equ. 8]}$$

In other words, defining the vector $F=f({\bf r_j}) \{ j=1,...N \}, a_0, a_1,a_2$ and the matrix 

$$M=\left[  \begin{array}{cc}^\phi(|r_j-r_i|) , 1,\;  x_j,\;  y_j \\ ... \;\;\;\;\;\;\;\;\;\;\;\;\; ... \;\;\; ... \;\;\; ...\\... \;\;\;\;\;\; \;\;\;\;\;\;\; 1,\;   x_j,\;  y_j\\ \end{array}\;\right] \;[equ. 9]$$

the sources $S_i$ are obtained by solving the matrix equation $ F=S*M$.

# Smoothing interpolation

To account for measurement noise, interpolation should involve smoothing, so that the interpolated data can deviate from the measurement at the measurement sites $r_i$.
This can be performed by minimising a linear combination of the elastic energy and the quadratic deviation to the measurement values  

$ E = \sum(|f({\bf  r_i})-f_i|^2)+ \rho\int\left[\left(\frac{\partial^2 f}{\partial x^2}\right)^2 + 2\left(\frac{\partial^2 f}{\partial xy}\right)^2 + \left(\frac{\partial^2 f}{\partial y^2}\right)^2 \right] \textrm{d} x \, \textrm{d}y   $

The variational problem then leads to the equation 

$$ \rho\Delta^2 f= \sum  (f_i-f) \delta ({\bf r-r_i}) $$

The solution is still obtained as a sum of radial basis functions $\phi({\bf|r-r_i}|)$, whose weight $S_i$ now satisfies $M_\rho*S=F$, with the matrix 

$$ M_\rho=M+\rho I_{000} $$

where $I_{000}$ is the NxN identity matrix extended by three columns of 0.^

# Spatial derivatives

Spatial derivatives of the interpolated quantity $f$ can be obtained by direct differentiation of the result.
For any function $\phi(r)$, with radial distance $r=|{\bf r-r_i}|$, $r^2=X^2+Y^2$, $\partial_X \phi=(d\phi/dr) \partial_X r$, and $\partial_X r=X/r$.
This yields $\partial_X \phi=X (2 \log(r) +1)$, so that,

$$\partial_x f({\bf r})=\sum S_i (2 \log|{\bf r-r_i}|+1)(x-x_i)+a_1;$$
$$\partial_y f({\bf r})=\sum S_i (2 \log|{\bf r-r_i}|+1)(y-y_i)+a_2;$$

# Sub-domains

The computing cost and memory required to invert the matrix [->equ. 9] increases as the cube of the number of measurement points, so that large data sets need to be partitioned in sub-domains.
The interpolation is made independently in each subdomain.
If sub-domain overlap, the average of the different answers is taken.
