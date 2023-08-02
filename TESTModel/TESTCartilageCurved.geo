// Parameters:
R   = 0.075         ;  
L   = 0.05        ;
e   = 0.005       ;
Ref = 50          ;
Porcentaje = 0.8  ;
Progression = 1 ;
//
// Parameters Computing: 
Ref_Arc = Ref     ;
Ref_e   = Ref_Arc/15     ;
//
Progr_Arc = Progression    ;
Progr_e= Progression   ;
//
// Points:
Point(1) = {0,0,0, 1.0};
Point(10) = {-R,0,0, 1.0};
Point(100) = {-R,0,R/2, 1.0};
Point(2) = {0,0,0-e, 1.0};
Point(20) = {-R-e,0,-e, 1.0};
Point(200) = {-R-e,0,R/2, 1.0};//
// Lines:
Line(1) = {1, 2};
Line(2) = {100, 200};
BSpline(3) = {1, 10, 100};
BSpline(4) = {2, 20, 200};
// Surfaces:
Curve Loop(1) = {1,4, -2, -3};
Plane Surface(1) = {1};

//+
//Extrude {{0, 0, -1}, {0, 0, 0}, Pi} {
//  Surface{1}; 
//}
//+
//Transfinite Curve {12,16} = 2*Ref Using Progression 1;
//Transfinite Curve {4,3,9,7} = Ref Using Progression 1;
//Transfinite Curve {2,1,8} = Ref/15 Using Progression 1;
//+
Physical Surface("cara", 5) = {1};
//+
Extrude {{0, 0, -1}, {0, 0, 0}, Pi/2} {
  Surface{1}; 
}
Transfinite Curve {3,4,8,-10} = Ref Using Progression 1;
Transfinite Curve {16,12} = Ref Using Progression 1;
Transfinite Curve {7} = Ref Using Progression 1;
Transfinite Curve {2,9} = 3 Using Progression 1;
Transfinite Curve {1} = 4 Using Progression 1;
Transfinite Curve {17, 13} = Ref Using Progression 1;
//+

