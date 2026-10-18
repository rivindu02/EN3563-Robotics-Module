# EN3563 — Robotics

Laboratory work for **EN3563 Robotics**, Department of Electronic & Telecommunication Engineering, University of Moratuwa (2025).
All labs use MATLAB with Peter Corke's [Robotics Toolbox](https://petercorke.com/toolboxes/robotics-toolbox/).

**Author:** Kumarage R. V. (220343B)

## Labs

| Lab | Topic | Code | Report |
|---|---|---|---|
| [Lab 01](Robotic%20Lab%2001) | Spatial descriptions: 2D and 3D frames, rotation matrices, intrinsic X-Y-Z rotations, RPY extraction | [`task_1.m`](Robotic%20Lab%2001/task_1.m), [`task_2.m`](Robotic%20Lab%2001/task_2.m) | [PDF](Robotic%20Lab%2001/Lab-01_report.pdf) |
| [Lab 02](Robotics%20Lab%2002) | Homogeneous transformations: build and invert `H`, change frames for points, and a 3D table, box and camera scene with frames {0}–{3} | [`task_1.m`](Robotics%20Lab%2002/task_1.m), [`task_2.m`](Robotics%20Lab%2002/task_2.m), [`task_3.m`](Robotics%20Lab%2002/task_3.m) | [PDF](Robotics%20Lab%2002/lab-02_report.pdf) |
| [Lab 03](Robotics%20Lab%2003) | Puma 560: DH parameters, forward kinematics for canonical poses, analytical IK (`ikine6s`), unreachable poses, and quintic joint trajectories (`jtraj`) with 3D animation | [`code_submitted.m`](Robotics%20Lab%2003/code_submitted.m) | [PDF](Robotics%20Lab%2003/lab3_report.pdf) |

Each lab folder also contains the lab sheet (`lab-0X.pdf`).

## Setup

1. Install MATLAB.
2. Install the Robotics Toolbox for MATLAB and add it to the path.
   See [`Setup_instructions.pdf`](Setup_instructions.pdf) and the [toolbox manual](manual_robotics%20toolbox.pdf).
3. Run a lab script, for example:

```matlab
cd 'Robotics Lab 03'
code_submitted
```
