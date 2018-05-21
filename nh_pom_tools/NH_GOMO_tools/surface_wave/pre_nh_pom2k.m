clc
clear all
init_constant_non_hydro();
init_arrays();
[z,zz,dx,dy,dz,dzz,h,aru,arv,art,cor,fsm,dum,dvm,rho,rmean,tb, ...
    sb,ub,vb,uab,vab,elb,etb,tclim,sclim,tsruf,ssurf,rn,rs,hmax]=lock_exchange_flow(grav,elb,etb,...
    alon,alat,h,depth_bath,alonmx,alonmn,alatmx,alatmn,cor,dx,dy,im,jm,kb,...
    imm1,jmm1,kbm1,kbm2,art,aru,arv,z,zz,dz,dzz,tb,sb,ub,vb,uab,vab,rho,rmean,...
    tbias,sbias,rhoref,fsm,dum,dvm);
for k=1:kbm1
    fsm3d(:,:,k) = fsm(:,:);
end
for k=1:kbm1
    dum3d(:,:,k) = dum(:,:);
end
for k=1:kbm1
    dvm3d(:,:,k) = dvm(:,:);
end
write_init_variables();
write_init_variables_mexnc();

%     End of main program






