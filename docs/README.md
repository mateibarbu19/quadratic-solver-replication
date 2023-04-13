# Introduction

We chose the ProxyQP paper @bambade:hal-03683733 because it proposes a new approach
for solving quadratic programming (QP) problems, which are commonly used in
robotics for simulation, planning, and control. Quadratic programming (QP) is a
mathematical optimization technique that can find the minimum value of a
quadratic function subject to linear constraints on the value. This is
formalised in @eq:QP.

$$
\min_{x \in \mathbb{R}^d} {1 \over 2} x^T H x + g^T x \\
\text{subject to}
\begin{cases}
   Ax = b \\
   Cx \leq u
\end{cases}
$${#eq:QP}

where $H \in \mathbb{R}^{d \times d}$ is a symmetric positive semi-definite matrix, $A \in \mathbb{R}^{n_e \times d}$, $C \in \mathbb{R}^{n_i \times d}$, $b \in \mathbb{R}^{n_e}$ and $u \in \mathbb{R}^{n_i}$.

The method of Lagrange multipliers is a strategy for finding the local maxima
and minima of a function subject to equality constraints. This article is based
on Augmented Lagrangian formalism which is a modification of the previous one
that can handle both **equality and inequality** constraints.

Citing: @nocedal1999numerical, @goldfarb1983numerically.

# References
