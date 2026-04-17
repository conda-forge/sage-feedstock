r"""
Tests that the basic functionality of SageMath is functional.

TESTS:

Verify exact arithmetic::

  sage: (factorial(6), binomial(6, 2), gcd(84, 30))
  (720, 15, 6)

Verify polynomial arithmetic::

  sage: R.<x> = PolynomialRing(QQ)
  sage: (x^2 - 1).factor()
  (x - 1) * (x + 1)

Verify matrix arithmetic::

  sage: A = matrix(ZZ, [[1, 2], [3, 4]])
  sage: (A.det(), A.charpoly())
  (-2, x^2 - 5*x - 2)

Verify finite field arithmetic::

  sage: F = GF(7)
  sage: F(3)^3
  6

Verify symbolic differentiation::

  sage: x = SR.var('x')
  sage: diff(x^3 + x, x)
  3*x^2 + 1

Verify combinatorics::

  sage: Partitions(4).cardinality()
  5

"""
