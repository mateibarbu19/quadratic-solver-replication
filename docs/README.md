# Introduction

## Motivation

The paper we chose @bambade:hal-03683733 proposes a new approach for solving
quadratic programming (QP) problems, which are commonly used in robotics for
simulation, planning, and control. Quadratic programming (QP) is a mathematical
optimization technique that can find the minimum value of a quadratic function
subject to linear constraints on the value. We will further discuss the two main
types of iterative methods which solve the general QP formalized in @eq:QP

$$
\min_{x \in \mathbb{R}^d} {1 \over 2} x^T H x + g^T x \\
\text{subject to}
\begin{cases}
   Ax = b \\
   Cx \leq u
\end{cases}
$${#eq:QP}

where $H \in \mathbb{R}^{d \times d}$ is a symmetric positive semi-definite matrix, $A \in \mathbb{R}^{n_e \times d}$, $C \in \mathbb{R}^{n_i \times d}$, $b \in \mathbb{R}^{n_e}$ and $u \in \mathbb{R}^{n_i}$.


TODO - A description of the paper and the novelty of their approach

## Context

### Active-Set methods

These are optimization programs used to determine the set of active constraints
at an optimal point of a QP. Popular active-set-based convex QP solvers include
qpOASES @ferreau2014qpoases, Quadprog @goldfarb1983numerically. One obstacle
regarding these methods is an undesirable effect such as "active-set cycling"
when the QP does not satisfy constraint qualification properties.

### Penalization methods

# Our Implementation

Because ProxyQP combines a bounded constraint Lagrangian globalization strategy with a primal-dual proximation method of multipliers, we found it to sophisticated to be reproduced. Nevertheless, we will be implementing a textbook QP solver see @nocedal1999numerical[Alg. 16.3].

# References
