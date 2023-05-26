# Inputs and Ouputs

## QuadProg



## Inputs

Avem următoarea funcție pe care trebuie să o minimizăm.

$$f(x) = {1 \over 2} x_1^2 + x_2^2 - x_1x_2 - 2x_1 - 6x_2$$

Cu următoarele constrângeri:

$$\begin{aligned}
x_1 + x_2   &\leq 2 \\
-x_1 + 2x_2 &\leq 2 \\
2x_1 + x_2  &\leq 3
\end{aligned}$$

Identificăm necunoscutele:

$${1 \over 2} x^THx = {1 \over 2} x_1^2 + x_2^2 - x_1x_2$$

$$f^Tx = - 2x_1 - 6x_2$$

---

Prelucrăm sistemul:

$$\begin{cases}
{1 \over 2}
\begin{bmatrix}
   x_1 & x_2
\end{bmatrix}
\overbrace{\begin{bmatrix}
   a & b \\
   c & d
\end{bmatrix}}^H
\begin{bmatrix}
   x_1 \\
   x_2
\end{bmatrix} = {1 \over 2} x_1^2 + x_2^2 - x_1x_2 \\
\underbrace{\begin{bmatrix}
   p & q
\end{bmatrix}}_{f^T}
\begin{bmatrix}
   x_1 \\
   x_2
\end{bmatrix} = - 2x_1 - 6x_2
\end{cases}
$$

$$\Rightarrow
\begin{cases}
{1 \over 2}(ax_1^2 + cx_1x_2 + bx_1x_2 + dx_2^2) = {1 \over 2} x_1^2 + x_2^2 - x_1x_2 \\
px_1 + qx_2 = -2x_1 -6x_2
\end{cases}
$$

$$\Rightarrow
\begin{cases}
H = \begin{bmatrix}
   1 & -1 \\
   -1 & 2
\end{bmatrix} \\
f = \begin{bmatrix}
   -2 \\
   -6
\end{bmatrix}
\end{cases}
$$

# Bibliography

## References {.allowframebreaks}

$$\min q(x) \Rightarrow x^*$$

$$x^*= x_k + p$$
$$p = x^* - x_k$$

$$\min r(p) \Rightarrow p_k$$


De ce nu $x^* = x_k + p_k$?

Pt. că când s-a minimizat $r$, s-au luat în calcul constrângeri mai slabe decât
în problema inițială.

De unde știm că $|x^*-(x_k+\alpha_kp_k)| < |x^*-x_0|$?


$$x^* = x_0+\alpha_0p_0 + \alpha_1p_1 + \alpha_2p_2 + ...$$