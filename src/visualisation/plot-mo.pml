bg_color white
set ray_opaque_background, on
load mo.cube
isosurface pos, mo, 0.03
isosurface neg, mo, -0.03
ramp_new ramp_pos, mo, [1, 2], [orange, lightblue]
ramp_new ramp_neg, mo, [1, 2], [lightblue, orange]
set surface_color, ramp_pos, pos
set surface_color, ramp_neg, neg
set transparency, 0.2
set surface_quality, 1
load mol.xyz
turn x,-25
turn y,-25
turn z,90
rebuild
png mo.png, width=5cm, dpi=300, ray=1
