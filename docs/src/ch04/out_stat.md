### solver.status.dat

**Introduction**

The *solver.status.dat* is used to store the current diagram configuration. In other words, we can treat it as a snapshot of the CT-QMC impurity solvers.

Usually, the quantum impurity solvers will output *solver.status.dat* file periodically. In the next run, they can reload it in order to reach thermal equilibrium state as soon as possible. In addition, when they meet fatal errors/exceptions, a *solver.status.dat* will be generated as well. It is very useful for us to diagnose where the bug is.

> NOTE: 

> The *solver.status.dat* is always generated by the quantum impurity solvers. **DO NOT** try to modify it by yourself. It is **EXTREMELY DANGEROUS**.

**Format**

The *solver.status.dat* files generated by various quantum impurity solvers are quite different. In principle you can not mix them. For example, the *solver.status.dat* generated by the **AZALEA** component can not be recognized by the **BEGONIA** component, and vice versa.

**Code**

N/A