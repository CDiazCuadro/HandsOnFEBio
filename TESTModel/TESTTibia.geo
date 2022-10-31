// Parameters:
R   = 0.075         ;  
L   = 0.05        ;
e   = 0.005       ;
Ref = 100          ;
Porcentaje = 0.8  ;
A   = 0.1         ;
//
// Parameters Computing: 
Ref_Arc = Ref            ;
Ref_e   = Ref_Arc/15     ;
//
//
// Points:
Point(1) = {A/5,-A/5,0-e, 1.0};
Point(2) = {A/5,A,0-e, 1.0};
Point(3) = {-A,-A/5,0-e, 1.0};
Point(4) = {-A,A,0-e, 1.0};
//
// Lines:
Line(1) = {1, 2};
Line(2) = {2,4};
Line(3) = {4,3};
Line(4) = {3,1 };
//
// Surfaces:
Curve Loop(1) = {1,2,3,4};
Plane Surface(1) = {1};
//
// Volume:
Extrude {0, 0, -e} {
  Curve{3}; Curve{4}; Curve{1}; Curve{2}; 
}
//+
Curve Loop(2) = {9, 13, 17, 5};
Plane Surface(21) = {2};
//+
Surface Loop(1) = {1, 16, 20, 8, 12, 21};
Volume(1) = {1};



Transfinite Curve {1,2,3,4,9,5,17,13} = Ref Using Progression 1;
Transfinite Curve {11,7,6,15} = Ref/50 Using Progression 1;


