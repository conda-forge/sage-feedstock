r"""
Tests that the standard components of SageMath are functional.

TESTS:

Verify that GAP is functional::

  sage: from sage.libs.gap.libgap import libgap
  sage: libgap.Order(libgap.SymmetricGroup(3)).sage()
  6

Verify that Singular is functional::

  sage: R.<x,y> = PolynomialRing(QQ)
  sage: ideal(x^2 + y, x*y - 1).dimension()
  0

Verify that Maxima is functional::

  sage: x = SR.var('x')
  sage: bool(maxima('expand((x+1)^5)').sage() == expand((x+1)^5))
  True

Verify that PARI is functional::

  sage: pari('qfbclassno(-23)').sage()
  3

Verify that SymPy is functional::

  sage: import sympy
  sage: x = sympy.Symbol('x')
  sage: sympy.expand((x + 1)^5) == x^5 + 5*x^4 + 10*x^3 + 10*x^2 + 5*x + 1
  True

Verify that mpmath is functional::

  sage: import mpmath
  sage: mpmath.binomial(6, 2) == 15
  True

Verify that NumPy is functional::

  sage: import numpy
  sage: (numpy.array([[1, 2], [3, 4]], dtype=int) @ numpy.array([1, 1], dtype=int)).tolist()
  [3, 7]

Verify that SciPy is functional::

  sage: from scipy.sparse import csr_matrix
  sage: from scipy.sparse.csgraph import connected_components
  sage: connected_components(csr_matrix([[0, 1, 0], [1, 0, 0], [0, 0, 0]]), directed=False)[0]
  2

Verify that NetworkX is functional::

  sage: import networkx
  sage: G = networkx.Graph([(0, 1), (1, 2)])
  sage: list(networkx.shortest_path(G, 0, 2))
  [0, 1, 2]

Verify that PPL is functional::

  sage: P = Polyhedron(vertices=[(0, 0), (1, 0), (0, 1)], backend='ppl')
  sage: (P.dim(), P.n_vertices(), P.integral_points_count())
  (2, 3, 3)

Verify that Nauty is functional::

  sage: len(list(graphs.nauty_geng('4 -c')))
  6

Verify that FLINT is functional::

  sage: from sage.libs.flint.arith_sage import bell_number
  sage: bell_number(6)
  203

Verify that LinBox is functional::

  sage: matrix(ZZ, [[1, 2], [3, 4]]).det(algorithm='linbox', proof=False)
  -2

Verify that Givaro is functional::

  sage: k.<a> = GF(9, impl='givaro')
  sage: (a^2)^4 == 1
  True

Verify that NTL is functional::

  sage: k.<a> = GF(2^5, impl='ntl')
  sage: a.multiplicative_order()
  31

Verify that eclib is functional::

  sage: EllipticCurve('37a1').rank()
  1

Verify that fpylll is functional::

  sage: from fpylll import IntegerMatrix, LLL
  sage: A = IntegerMatrix.from_matrix([[1, 1], [0, 2]])
  sage: LLL.reduction(A)
  <IntegerMatrix(2, 2) at ...>
  sage: [[A[i, j] for j in range(2)] for i in range(2)]
  [[1, 1], [-1, 1]]

Verify that primecount is functional::

  sage: prime_pi(100)
  25

Verify that ECM is functional::

  sage: from sage.interfaces.ecm import ECM
  sage: ECM(B1=50).factor(5959)
  [59, 101]

Verify that PALP is functional::

  sage: p = LatticePolytope([(1, 0), (0, 1), (-1, -1)])
  sage: (p.npoints(), p.nvertices())
  (4, 3)

Verify that libhomfly is functional::

  sage: KnotInfo.K3_1.link().homfly_polynomial(normalization='vz')
  -v^4 + v^2*z^2 + 2*v^2

Verify that lrcalc is functional::

  sage: import sage.libs.lrcalc.lrcalc as lrcalc
  sage: lrcalc.lrcoef([3, 2, 1], [2, 1], [2, 1])
  2

"""
