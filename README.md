-> Meshes, Models, Results and others related with FEBio simulations.

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

**Primary and secondary surfaces**
- We have two contacting surfaces denoted: primary and secondary. The primary surface is the one where most of the contact calculations are done, (all the integration points of the second that are in the primary, are taken into account to compute the contact force ). The general recommendation is to pick the finner  non- rigid surface as primary. The nodes of the primary surface are projected into the secondary (that is the contact gap g). 

** Relevant parameters**
- Projection tolerance: is a tolerance in a parametric space that defines when a projection is inside the facet. It gives an area surrounding the face that if a point is outside that faces (but inside the tolerance) that point is still considered inside of the same facet. This avoids convergence issues due to flip-flop of the elements. By default 1% and it turns out that in most cases this is not needed to be changed. 
-  Search Radius: Maximum distance to secondary surface. Face sets  outside the search radius are not eligible for contact. 

