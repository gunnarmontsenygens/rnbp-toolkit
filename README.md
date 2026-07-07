# N-Body Problem in Jacobi Coordinates Toolkit

## Overview

The **N-Body Problem in Jacobi Coordinates Toolkit** is a MATLAB library for modeling, simulating, and analyzing the gravitational N-Body Problem using **Jacobi coordinates**.

Unlike the standard barycentric formulation, Jacobi coordinates remove the translational motion of the system barycenter and express the equations of motion in a hierarchical coordinate system. This formulation significantly simplifies many analytical derivations and provides an efficient framework for numerical propagation of gravitational N-body systems.

The toolkit was developed as part of **ASEN 6062 – Celestial Mechanics** at the University of Colorado Boulder and forms the computational foundation for several subsequent toolboxes in this repository, including the **Restricted N-Body Problem**, **Central Configurations**, and future multi-body astrodynamics utilities.

---

## Features

The toolkit includes routines for

- transforming between barycentric and Jacobi coordinate systems,
- constructing complete Jacobi state vectors,
- propagating the gravitational N-Body Problem,
- computing conserved quantities such as
  - kinetic energy,
  - gravitational potential energy,
  - total mechanical energy,
  - angular momentum,
  - polar moment of inertia,
- computing relative geometric quantities,
- visualizing N-body trajectories in two and three dimensions.

---

## Mathematical Background

The implementation follows the Jacobi-coordinate formulation presented in the ASEN 6062 course notes.

Throughout the toolbox,

- the gravitational constant is normalized to

```text
G = 1
```

- the system barycenter is removed from the dynamics,
- the equations are expressed entirely in Jacobi coordinates.

---

## Repository Structure

The toolkit is organized into several modules:

- **Mass Utilities**
- **Center-of-Mass Utilities**
- **Coordinate Transformations**
- **Relative Geometry Utilities**
- **Propagation Utilities**
- **Integral Quantities**
- **Visualization Utilities**

Each module contains its own documentation describing the available functions and their usage.

---

## Related Toolboxes

This toolkit serves as the computational foundation for

- Restricted N-Body Problem in Jacobi Coordinates Toolkit
- Central Configurations Toolbox
- Three-Body Problem in Jacobi Coordinates Toolbox

---

## References

The implementation follows the notation and derivations presented in

- ASEN 6062 – Celestial Mechanics
- 'Jacobi_notation.pdf'
- Lecture Notes: *The N-Body Problem*
- Lecture Notes: *Jacobi Coordinates*
- Lecture Notes: *Restricted Full N-Body Problem*
