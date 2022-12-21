## HandsOnFEBIO
This repository contains examples and notes on how to use [FEBIO software.](https://febio.org/)
## Files
FEBio software provides the following files: 

-  `.fsp` project files (may contain several model .fsm files). We can add files create groups or folders to include model files.
-  `.fsm` model files contains the model definition, geometry, mesh generation, and job information. 
- `.feb` XML file that is executed when the job is executed.
- `.xplt` Plot results of the analysis. We can select what we want to store in th output item in the model tree. For contact we can plot different things. We have different data formats for all of the data variables that are being used, ITEM (one value per element or face), NODE(one value per node), or MIXED. Furthermore FEBio is filtering the results to get a continuous representation. This can be turned off into `Color Map` and turn off the nodal smoothing option. 


## Contact

By default if we want to use contact we have to define the contact model or interfaces, and also the surfaces that interact. We have three types of contact:

### Contact types:
- Rigid contact: Connects deformable part to a rigid body. Special case of tied contact. In this case we are imposing to the dofs on the surface the rigid body. Does not require mesh for the rigid body. We apply the forces to the rigid body and then then the interface surface displacements are computed, this is more efficient than a tied surface. 

    - Assign a rigid material to the body (Select a Rigid Body Material).
    - Assign the prescribed boundary conditions to the rigid body (Rigid Constraints item)
    - Add contact interface: Click on contact, add Rigid, then select the material and then a surface to that rigid interface. (We can hide objects with h shortcat). Esentialy this is imposed displacements example 

- Tied contact: Connects two non conforming meshes and there is no relative motion between contact surfaces. 

- Allows sliding between contacting interfaces. Surfaces can separate but not penetrate. 


### Contact Basics:

Contact is a nonlinear constraint and is enforced through Lagrange multipliers (LM). But this can be expensive in terms of computational cost, so it used approximations methods such as:

**The penalty method**: A contact force si added like a spring with with a penalty factor $\epsilon$ when both surfaces split that spring will kind of pull these points back together. If  $g$ is negative or zero the force is zero. Mathematically: $f_c = \epsilon g$, therefore if we use penalty a gap $g$ is needed, if not we have no contact. To overcome this, the Augmented Lagranigan Method is uesd. 

- The Augmented Lagrangian Method**: The contact force is changed adding a LM to the force $f_c^k = \lambda _c^k \epsilon g$, and the LM is constant during the Newton Iteration. After Newton iterations converge, LM are updated. Then the step is re-solved updating  $\lambda_c^{k+1} = \lambda_c^k \epsilon g$ and the norm is checked below a user specified tolerance. 


**Primary and secondary surfaces**
- We have two contacting surfaces denoted: primary and secondary. The primary surface is the one where most of the contact calculations are done, (all the integration points of the second that are in the primary, are taken into account to compute the contact force). The general recommendation is to pick the finer  non-rigid surface as the  primary, specially if we are using the auto penalty feature. The nodes of the primary surface are projected into the secondary (that is the contact gap g).

![image](https://user-images.githubusercontent.com/50339940/208787635-6ea89b2b-8a49-4750-940e-769d4ccfd4c2.png)

**Relevant parameters**
- Projection tolerance: is a tolerance in a parametric space that defines when a projection is inside the facet. It gives an area surrounding the face that if a point is outside that faces (but inside the tolerance) that point is still considered inside of the same facet. This avoids convergence issues due to flip-flop of the elements. By default 1% and it turns out that in most cases this is not needed to be changed. 
-  Search Radius: Maximum distance to secondary surface. Face sets  outside the search radius are not eligible for contact. 

![image](https://user-images.githubusercontent.com/50339940/208787804-8771091f-27d5-4b44-8f1f-029216d19797.png)

### Tied contact 

We have three different flavors of tied contact regarding the projection operation implemented. 
![image](https://user-images.githubusercontent.com/50339940/208970420-52d20f6e-96c3-4506-8cbd-c3e55aed93e6.png)

- **Tied node-on-facet (TN2F)** : Projects the primary surface nodes into the secondary. The projection is done computing the closest point. 
    - Nodal, closest point projections
    - Symetric formulation
- **Tied facet-on-facet (TF2F)**: Projects the integration points of the primary surface into the secondary. The projection is done computing the closest point. This forumalations gives us a more accurate sampling of the contact surface.
    - Integration point, closest point projections
    - Symetric formulation

- **Tied-elastic (TE)** Projects the integration points of the primary surface into the secondary. The projection is done computing the normal projection. This formulation gives us a more stable formulation. We avoid to have more than one closest point, the normal projection is unique. 
    - Integration point, closest point projections
    - Non-Symetric formulation (but we have an option to make the stiffness matrix symetric)

- **Parameters**
    -![image](https://user-images.githubusercontent.com/50339940/208972615-34416c75-8dc3-4bbf-9039-ff0754fadc3f.png)

    - If we have a gap between both surfaces we can increase the penalty factor. Turning the auto-penalty parameter on we can combat the gap. Remember that the penalty factor $\lambda$ has units.  

    - Because ALM depends on a contact gap, there will be always a small gap between two surfaces. We can solve this problem by adding more augmentations and also increasing the penalty factor (take into account that big numbers of penalty might lead to instabilities). We have an option also ino the TN2F we have a truth lagrange multiplier formulation when we dont need to specify a penalty factor. 


## Sliding contact
Sliding contact prevents points from pentrating the secondary surface, but separation is still allowed. Contact gap $g$ now is a signed scalar quantity. Contact only if $g<0$. The contact force is:

$$ f_c = 0 ~~if~~ g~~ > 0 $$
$$f_c =  \epsilon g \bf{n} ~~if~~ g~~ > 0$$

Friction is supported ina sub-set of contact interfaces: sliding-elastic, sliding-node-on-facet ( Couloumb law with the same static and dynamic friction coefficients.). According on the prvious flavors we can use:

- **Sliced node-on-facet (TN2F)** 
- **Sliced facet-on-facet (TF2F)**
- **Sliced-elastic (TE)** 


- **Parameters**
    -![image](https://user-images.githubusercontent.com/50339940/208977831-1ae4665a-366b-494d-98c1-f32101902d81.png)
    - **seg_up** During de Newton Iteration a point can be projected into different facests of the secondary surface while the mesh is being updated. This flip flop can be problematic since is afecting the residual and it cannot converge, since the residual force is being changed. 
    - **two_pass** we can have a small bias if we switch the primary and the secondary surface, so this parameter switches auto primary and secondary. 
    - Also another tip to inspect the contact results we a 