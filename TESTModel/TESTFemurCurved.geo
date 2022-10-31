// Parameters:
R   = 0.075         ;  
L   = 0.05        ;
e   = 0.005       ;
Ref = 50          ;
Progression = 1.05;
Porcentaje = 0.8  ;
//
// Parameters Computing: 
Ref_L   = Ref     ;
Ref_R   = Ref     ;
Ref_Arc = Ref     ;
//
Ref_L_distal = Ref_L    ; 
Ref_L_prox   = Ref_L/10 ;
Ref_L_ant    = Ref_L/20 ;
//
Ref_Rv = Ref*Porcentaje    ;
Ref_Rh = Ref*(1-Porcentaje);
//
Progr_Arc = Progression    ;
Progr_Line = Progression   ;
//
// Points:
Point(0) = {0,0,0, 1.0};
Point(1) = {-R,0,R, 1.0};
Point(10) = {-R,0,0, 1.0};
Point(11) = {-R,0,R/2, 1.0};
Point(2) = {0,0,R, 1.0};
//
//Point(3) = {0,L,R, 1.0};
//Point(4) = {0,L,R/10, 1.0};
//Point(40) = {0,L,0, 1.0};
//
//Point(5) = {-R,L,R, 1.0};
//Point(6) = {-R, L, R/5, 1.0};
//Point(60) = {-R,L,0, 1.0};
//
// Lines:
Line(1) = {0, 2};
Line(2) = {2, 1};
//Line(8) = {4, 3};
//Line(9) = {6, 5};
//Line(10) = {2, 3};
//Line(11) = {3, 5};
//Line(12) = {5, 1};
Line(13) = {11, 1};
BSpline(5) = {0, 10, 11};
//BSpline(6) = {0, 40, 4, 3};
//BSpline(7) = {0, 60, 6,5};
//
// Surfaces:
Curve Loop(1) = {5,13, -2, -1};
Plane Surface(1) = {1};
//Curve Loop(2) = {1, 10,-6};
//Plane Surface(2) = {2};
//Curve Loop(3) = {10, 11, 12, -2};
//Plane Surface(3) = {3};
//Curve Loop(4) = {6, 11, -7};
//Surface(4) = {4};
//Curve Loop(5) = {7, 12, -5};
//Surface(5) = {5};
//
//+

//+

//+
//Extrude {{0, 0, -1}, {0, 0, 0}, Pi/2} {
//  Curve{2}; Curve{1}; Curve{5}; Curve{13}; 
//}

//+
Extrude {{0, 0, -1}, {0, 0, 0}, Pi/2} {
  Surface{1}; 
}
