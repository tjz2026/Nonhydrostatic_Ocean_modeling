function [z,zz,dx,dy,dz,dzz,h,aru,arv,art,cor,fsm,dum,dvm,rho,rmean,tb, ...
    sb,ub,vb,uab,vab,elb,etb,tclim,sclim,tsurf,ssurf,rn,rs,hmax]=lock_exchange_flow(grav,elb,etb,...
    alon,alat,h,depth_bath,alonmx,alonmn,alatmx,alatmn,cor,dx,dy,im,jm,kb,...
    imm1,jmm1,kbm1,kbm2,art,aru,arv,z,zz,dz,dzz,tb,sb,ub,vb,uab,vab,rho,rmean,...
    tbias,sbias,rhoref,fsm,dum,dvm)
rn=0; % add by wangmq
rs=0; % add by wangmq

hmax=depth_bath;
dxlon=(alonmx-alonmn)/imm1;
dylat=(alatmx-alatmn)/(jmm1);
for j=1:jm
    for i=1:im
        alon(i,j)=alonmn+dxlon*(i-1.);
        alat(i,j)=alatmn+dylat*(j-1.);
    end
end

for j=1:jm
    for i=1:im
        h(i,j)=hmax;
    end
end
min_alon = min(alon(:));
min_alat = min(alat(:));
alon = alon - min_alon;
alat = alat - min_alat;

h(1,:)=0. ; h(im,:)=0. ;
if (rn ==0)
    h(:,jm) = 0.;
end
if (rs ==0)
    h(:,1) = 0.;
end

for j=1:jm
    for i=2:imm1
        dx(i,j)=0.5*sqrt((alon(i+1,j)-alon(i-1,j))^2 + ...
            (alat(i+1,j)-alat(i-1,j))^2);
    end
    dx(1,j)=dx(2,j);
    dx(im,j)=dx(imm1,j);
end

for i=1:im
    for j=2:jmm1
        dy(i,j)=0.5*sqrt( (alon(i,j+1)-alon(i,j-1))^2 ...
            + (alat(i,j+1)-alat(i,j-1))^2 );
    end
    dy(i,1)=dy(i,2);
    dy(i,jm)=dy(i,jmm1);
end

for  j=2:jm
    for  i=2:im
        cor(i,j)=0.;
    end
end

for  j=2:jm
    for  i=2:im
        art(i,j)=dx(i,j)*dy(i,j);
        aru(i,j)=.25*(dx(i,j)+dx(i-1,j))*(dy(i,j)+dy(i-1,j));
        arv(i,j)=.25*(dx(i,j)+dx(i,j-1))*(dy(i,j)+dy(i,j-1));
    end
end
for  j=1:jm
    cor(1,j)=cor(2,j);
    art(1,j)=art(2,j);
    aru(1,j)=aru(2,j);
    arv(1,j)=arv(2,j);
end
for  i=1:im
    cor(i,1)=cor(i,2);
    art(i,1)=art(i,2);
    aru(i,1)=aru(i,2);
    arv(i,1)=arv(i,2);
end

%----makes sigma-levels
% [z,zz,h,dz,dzz] = maksig(z,zz,h,hmax, ...
%     dz,dzz);
    kl1 = 2;
    kdz = ones(1,12);
    z(1)=0.;
    for k=2:kl1
        z(k)=z(k-1)+kdz(k-1);
    end
    delz=z(kl1)-z(kl1-1);
    for k=kl1+1:kb
        z(k)=z(k-1)+delz;
    end
    for k=1:kb
        z(k)=-z(k)/z(kb);
    end
    for k=1:kbm1
        zz(k)=0.5*(z(k)+z(k+1));
    end
    zz(kb)=2.*zz(kbm1)-zz(kbm2);
    

    fsm(:,:)=1;
    h(h<0.001)=0.001;
    for i=1:im
        for j=1:jm
            if(h(i,j) <= 0.001)
                fsm(i,j)=0;
            end
        end
    end
    
    for  k=1:kbm1
        dz(k)=z(k)-z(k+1);
        dzz(k)=zz(k)-zz(k+1);
    end
    
    h(fsm(:,:) ==0) = hmax;
    
    h(:,1) = h(:,2);
    h(:,jm) = h(:,jmm1);
    h(1,:) = h(2,:);
    h(im,:) = h(imm1,:); 


%----setting boundary mask
if(rs == 1)
    fsm(:,1) = 1.;
end
if (rn == 1)
    fsm(:,jm) = 1.;
end
dum(1,2:jm)=0;
dvm(:,2:jm)=fsm(:,1:jmm1).*fsm(:,2:jm);
dvm(2:im,1)=1;
dum(2:im,:)=fsm(1:imm1,:).*fsm(2:im,:);
dum(1,1)=0; dvm(1,1)=0;

tb(:,:,:)=0;
%******************surface wave case ***************************
sb(:,:,:) = 3.0

[rho]=dens(sb,tb,rho,...
    im,jm,kbm1,tbias,sbias,grav,rhoref,zz,h,fsm);
for k=1:kbm1
tb(:,:,k)=tb(:,:,k).*fsm;
sb(:,:,k)=sb(:,:,k).*fsm;
end
rmean(:,:,:)=0;

tclim=tb;sclim=sb;
tsurf=tb(:,:,1);ssurf=sb(:,:,1);
ub(:,:,:)=0; uab(:,:)=0;
vb(:,:,:)=0; vab(:,:)=0;
elb(:,:)=0;  etb(:,:)=0;




end
