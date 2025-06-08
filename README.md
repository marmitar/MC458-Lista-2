# Analysis of Algorithms I (MC458) - Test 2

- [Questions](./Enunciado.pdf)
- [Answers](./Resposta.pdf)
- [Turn in](./Entrega.pdf)

## Strong Induction

# Project and Analysis of Algorithms I (MC458) – Evaluation List 2

*In the questions below, the figures are merely illustrative and are **not** part of the material to be submitted.* :contentReference[oaicite:8]{index=8}

---

### Question 1

Assume $n$ is a power of 2. Let $M$ be an $n \times n$ matrix of real numbers such that each row is strictly increasing, $M(i,j) < M(i,j+1)$ for $1 \le i \le n$ and $1 \le j \le n-1$, and each column is strictly increasing, $M(i,j) < M(i+1,j)$ for $1 \le i \le n-1$ and $1 \le j \le n$.

Given a number $x$ and the matrix $M$, to determine whether there exist indices $i, j$ with $1 \le i,j \le n$ such that $x = M(i,j)$, one can build a divide-and-conquer algorithm that, depending on the comparison between $x$ and $M(n/2,n/2)$, either returns **true** or discards a substantial portion of the matrix before recursing.

Provide a **strong-induction** proof that the problem can be solved in this way, so that your proof naturally yields the sketched algorithm, and write the recurrence relation that describes the algorithm's worst-case complexity.

> You must present the induction proof that gives rise to the algorithm; pseudocode is **not** required.

---

### Question 2

Let $T$ be a non-empty rooted binary tree.

Design a **strong-induction** algorithm that labels each vertex $v$ with $\bigl\lvert \text{DFMP}(v) - \text{DFMD}(v) \bigr\rvert$, where

- $\text{DFMP}(v)$ is the distance (in edges) from $v$ to its Nearest leaf, and
- $\text{DFMD}(v)$ is the distance (in edges) from $v$ to its Farthest leaf.

If $T$ consists only of the root, that root must be labeled $0$. Denote by $v.D$ the field of $v$ that must receive this label.

You must present the induction proof that gives rise to the algorithm; pseudocode is **not** required.

---

### Question 3

A rooted **ternary** tree $T$ whose root stores a real number $r$ is called a **Tusca tree** if $T$ is empty **or** all of the following hold:

1. Every vertex in the **left** subtree of $T$ contains a real number **less than** $r$;
2. Every vertex in the **middle** subtree of $T$ contains a real number **equal to** $r$;
3. Every vertex in the **right** subtree of $T$ contains a real number **greater than** $r$;
4. The left, middle, and right subtrees of $T$ are themselves Tusca trees.

Design a **strong-induction** algorithm that, given a ternary tree, checks whether it is a Tusca tree.

You must present the induction proof that gives rise to the algorithm; pseudocode is **not** required.
