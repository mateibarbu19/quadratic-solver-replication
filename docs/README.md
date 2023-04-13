# Introduction

## Motivation

The paper we chose @bambade:hal-03683733 proposes a new approach for solving
quadratic programming (QP) problems, which are commonly used in robotics for
simulation, planning, and control. Quadratic programming (QP) is a mathematical
optimization technique that can find the minimum value of a quadratic function
subject to linear constraints on the value. We will further discuss the two main
types of iterative methods which solve the general QP formalized in @eq:QP.
^[Where $G$ is a symmetric positive semi-definite matrix.]

$$\begin{split}
\min_{x} q(x) = {1 \over 2} x^T G x + x^T c \\
\text{subject to}
\begin{cases}
   a_i^T x = b_i, & i \in \mathcal{E} \\
   a_i^T x \geq b_i, & i \in \mathcal{I}
\end{cases}
\end{split}$${#eq:QP}

This article offers an efficient algorithm implemented in C++ that solves QPs at
very high-frequency (e.g. 1 kHz for inverse dynamics), under various levels of
accuracy depending on the application, and potentially in relatively large
dimension (e.g. model predictive control). It is important in such way as
increase the numerical robustness of the solvers while also lowering the need of
manual tuning of the underlying hyper- parameters.

## Context

### Active-Set methods

These are optimization programs used to determine the set of active constraints
at an optimal point of a QP. Popular active-set-based convex QP solvers include
qpOASES @ferreau2014qpoases, Quadprog @goldfarb1983numerically. One obstacle
regarding these methods is an undesirable effect such as "active-set cycling"
when the QP does not satisfy constraint qualification properties.

### Penalization methods

The articale presents two common families of penalization methods:
interior-point methods and augmented Lagrangian-type methods. Interior-point
methods use a barrier function to transform the original constrained problem
into a sequence of intermediary optimization problems with strictly feasible
solutions. Augmented Lagrangian-type methods use Lagrangian relaxations with an
additional quadratic penalization term to encourage feasibility of the iterate.
They can exploit warm-start procedures, but may exhibit slow convergence
behaviors.

# Our Implementation

Because ProxyQP combines a bounded constraint Lagrangian globalization strategy
with a primal-dual proximation method of multipliers, we found it to
sophisticated to be reproduced. Nevertheless, we will be implementing a textbook
QP solver see @nocedal1999numerical[Alg. 16.3], which is in embodies a
active-set method.

The algorithm takes in the set of variables from @eq:QP and outputs a numerical
value, $x*$, which was found to minimize the given function under the
contraints. Since ProxQP's data set is
public^[Maros Meszaros problems: <https://github.com/Simple-Robotics/proxsuite/tree/main/test/data/maros_meszaros_data>],
we will try to use it.

## Explanations

> Primal active-set methods find a step from one iterate to the next by solving
> a quadratic subproblem in which some of the inequality constraints, and all
> the equality constraints, are imposed as equalities. This subset is referred
> to as the working set and is denoted at the $k$th iterate $x_k$ by $W_k$. @nocedal1999numerical

At each step, $k$, we first check whether $x_k$ minimizes the quadratic $q$ in
the subspace defined by the working set. If not, let $p = x^* - x_k$. We compute
$p_k$ by solving an equality-constrained QP subproblem.

If $p_k$ is nonzero, we use a step-length parameter $\alpha_k$ to decide how far
to move along this direction.

$$x_{k+1} = x_k + \alpha_k p_k$$

If $p_k$ is neglijable, we have reached a point which minimizes the quadratic
objective function over its current working set. In this case, we need only
check if all the Lagrangian multipliers associated with the
KKT^[In mathematical optimization, the Karush–Kuhn–Tucker conditions,  are first
derivative tests for a solution in nonlinear programming to be optimal, provided
that some regularity conditions are satisfied. @KKT] condidition are positive.

## Pseudo-code

```typescript
Compute a feasible starting point x_0
Set W_0 to be a subset of the active constraints at x_0
for k = 0, 1, 2, ...
   // Let x = p_k + x_k
   Solve the QP subproblem for p_k
   if p_k = 0
      Compute Lagrange multipliers lambdas that satisfy KKT
      if lambdas[i] >= 0 for i in intersection(W_k , I)
         return x_k
      else
         j = arg_min(lambdas[i] for i in intersection(W_k, I))
         x_k_next = x_k
         W_k_next = W_k.remove(j)
   else
      Compute alpha_k
      x_k_next = x_k + alpha_k * p_k
      if !blocking_constraints.empty()
         W_k_next = W_k.add(choice(blocking_constraints))
      else
         W_k_next = W_k
```

# Evaluation

Our plan is to implement this algorithm in Matlab/Python using special
mathematic libraries for a good approach. We are trying to illustrate the
results in the same benchmarks used by
authors^[ProxQP Benchmark: <https://github.com/Simple-Robotics/proxqp_benchmark>]
in order to ilustrate a fair comparison. On the one hand, this can help to
understand the complexity of ProxQP algorithm, while on the other it provides a
good initialization for us in the numerical optimisation domain.

# References
