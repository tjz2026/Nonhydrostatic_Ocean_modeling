//==========================================
/ Exercise 3: Short Surface Gravity Waves
//==========================================

// Animation of equivalent vertical displacements of pressure surfaces

f = gcf(); f.pixmap='on';
// read input data
eta1=read("eta.dat",-1,101); dp1=read("dp.dat",-1,101); 
[ntot nx] = size(eta1); x = (0:5:500)'; 

for n = 1:100// animation loop

clf(); time = n; // time in seconds

//grab data blocks
itop = (n-1)*51+1; ibot = itop+50; 
dp = dp1(itop:ibot,1:101)'; eta = eta1(n,1:101)'; 

// draw graphs
plot2d(x,5*eta,5); p1=get("hdl"); p1.children.thickness=2;

for i = 1:26
  plot2d(x,5*dp(:,i)+1-i*2,2,'019','',[0 -40 500 10],[1,6,1,6]);
  p2=get("hdl"); p2.children.thickness=1;
end;

a=get("current_axes"); a.parent.figure_size= [700,400]; 
a.font_size = 3;

title("Time = "+string(int(time))+" secs","fontsize",4); // draw title
 
xstring(234, -38,"x (m)");  // draw x label
txt=gce(); txt.font_size = 4;
xstring(2, -22,"z (m)");  // draw z label
txt=gce(); txt.font_size = 4;

show_pixmap(); f.pixmap='off';

// save frames as sequential GIF files
//if n < 10 then
//  xs2gif(0,'ex100'+string(n)+'.gif')
//else
//  if n < 100 then
//    xs2gif(0,'ex10'+string(n)+'.gif')
//  else
//    xs2gif(0,'ex1'+string(n)+'.gif')
//  end
//end

f.pixmap='on';

end // end reference for animation loop

