//==========================================
// Exercise 3: Short Surface Gravity Waves
//==========================================

// Animation of dynamic pressure anomalies

f = gcf(); f.pixmap='on'; f.color_map = jetcolormap(64); 

// read input data
eta1=read("eta.dat",-1,101); dp1=read("dp.dat",-1,101); 
[ntot nx] = size(eta1); x = (0:5:500)'; z = (0:2:100)'; 

for n = 1:100 // animation loop

clf(); time = n; // time in seconds

//grab data blocks
itop = (n-1)*51+1; ibot = itop+50; 
dp = dp1(itop:ibot,1:101)'; eta = eta1(n,1:101)'; 

// 2d color plot of pressure field
Sgrayplot(x,-z,dp,zminmax=[-1 1]);
colorbar(-1,1); 

// contour plot of pressure field
xset("fpf"," "); c(1:10) = 80; xset("thickness",2); 
contour2d(x,-z,dp,10,c);

// specify graph & axis properties
a = get("current_axes"); 
a.font_size = 3; a.data_bounds = [0,-50;500,0];
a.parent.figure_size = [800,400]; 
a.auto_ticks = ["off","off","on"]; a.sub_ticks = [4,3];
a.x_ticks = tlist(["ticks", "locations","labels"],..
 [0 100 200 300 400 500], ["0" "100" "200" "300" "400" "500"]);
a.y_ticks = tlist(["ticks", "locations","labels"],..
 [-50 -40 -30 -20 -10 0], ["-50" "-40" "-30" "-20" "-10" "0"]); 
 
title("Time = "+string(int(time))+" secs","fontsize",4,'position',[150 0]); // draw title
 
xstring(234,-48,"x (m)");  // draw x label
txt=gce(); txt.font_size = 4;
xstring(1,-35,"z (m)");  // draw z label
txt=gce(); txt.font_size = 4;

show_pixmap(); f.pixmap='off';

// save frames as sequential GIF files
//if n < 10 then
//  xs2gif(0,'ex100'+string(n)+'.gif')
//else
//  if n < 100 then
//    xs2gif(0,'ex10'+string(n)+'.gif')
// else
//    xs2gif(0,'ex1'+string(n)+'.gif')
//  end
//end

f.pixmap='on';

end // end reference for animation loop

