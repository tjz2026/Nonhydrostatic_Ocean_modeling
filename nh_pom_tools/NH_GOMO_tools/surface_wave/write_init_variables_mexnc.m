file_name = ['./in/',problem,'_mex.nc'];
nc=mexnc('create',file_name,'clobber');
%% dimension
imx=mexnc('def_dim',nc,'x',im);
jmy=mexnc('def_dim',nc,'y',jm);
kbz=mexnc('def_dim',nc,'z',kb);
dconst=mexnc('def_dim',nc,'dc',1);
% define variables
% % to simplify the code, construct a list of variables
% var_z.name='z';
% var_z.var = z;
% var_z.dim = [imx jmy dconst];

% scalar variables

rnid=mexnc('def_var',nc,'rn',nc_double,3,[dconst dconst dconst]);
rsid=mexnc('def_var',nc,'rs',nc_double,3,[dconst dconst dconst]);
hmaxid=mexnc('def_var',nc,'hmax',nc_double,3,[dconst dconst dconst]);

% 1d variables
zid=mexnc('def_var',nc,'z',nc_double,3,[kbz,dconst dconst]); 
dzid=mexnc('def_var',nc,'dz',nc_double,3,[kbz,dconst dconst]); 
zzid=mexnc('def_var',nc,'zz',nc_double,3,[kbz,dconst dconst]);
dzzid=mexnc('def_var',nc,'dzz',nc_double,3,[kbz,dconst dconst]);
% 2d variables
dxid=mexnc('def_var',nc,'dx',nc_double,3,[dconst jmy imx]);
dyid=mexnc('def_var',nc,'dy',nc_double,3,[dconst jmy imx]);
corid=mexnc('def_var',nc,'cor',nc_double,3,[dconst jmy imx]);
hid=mexnc('def_var',nc,'h',nc_double,3,[dconst jmy imx]);
fsmid=mexnc('def_var',nc,'fsm',nc_double,3,[dconst jmy imx]);
dumid=mexnc('def_var',nc,'dum',nc_double,3,[dconst jmy imx]);
dvmid=mexnc('def_var',nc,'dvm',nc_double,3,[dconst jmy imx]);
artid=mexnc('def_var',nc,'art',nc_double,3,[dconst jmy imx]);
aruid=mexnc('def_var',nc,'aru',nc_double,3,[dconst jmy imx]);
arvid=mexnc('def_var',nc,'arv',nc_double,3,[dconst jmy imx]);
uabid=mexnc('def_var',nc,'uab',nc_double,3,[dconst jmy imx]);
vabid=mexnc('def_var',nc,'vab',nc_double,3,[dconst jmy imx]);
elbid=mexnc('def_var',nc,'elb',nc_double,3,[dconst jmy imx]);
etbid=mexnc('def_var',nc,'etb',nc_double,3,[dconst jmy imx]);
ssurfid=mexnc('def_var',nc,'ssurf',nc_double,3,[dconst jmy imx]);
tsurfid=mexnc('def_var',nc,'tsurf',nc_double,3,[dconst jmy imx]);

%3d variables
tbid=mexnc('def_var',nc,'tb',nc_double,3,[kbz jmy imx]);
sbid=mexnc('def_var',nc,'sb',nc_double,3,[kbz jmy imx]);
tclimid=mexnc('def_var',nc,'tclim',nc_double,3,[kbz jmy imx]);
sclimid=mexnc('def_var',nc,'sclim',nc_double,3,[kbz jmy imx]);
rhoid=mexnc('def_var',nc,'rho',nc_double,3,[kbz jmy imx]);
rmeanid=mexnc('def_var',nc,'rmean',nc_double,3,[kbz jmy imx]);
ubid=mexnc('def_var',nc,'ub',nc_double,3,[kbz jmy imx]);
vbid=mexnc('def_var',nc,'vb',nc_double,3,[kbz jmy imx]);

mexnc('enddef',nc);
% writing variables 
mexnc('put_var_double',nc,rnid,rn);
mexnc('put_var_double',nc,rsid,rs);
mexnc('put_var_double',nc,hmaxid,hmax);

mexnc('put_var_double',nc,zid,z);
mexnc('put_var_double',nc,zzid,zz);
mexnc('put_var_double',nc,dzid,dz);
mexnc('put_var_double',nc,dzzid,dzz);

mexnc('put_var_double',nc,dxid,dx);
mexnc('put_var_double',nc,dyid,dy);
mexnc('put_var_double',nc,corid,cor);
mexnc('put_var_double',nc,hid,h);
mexnc('put_var_double',nc,fsmid,fsm);
mexnc('put_var_double',nc,dumid,dum);
mexnc('put_var_double',nc,dvmid,dvm);
mexnc('put_var_double',nc,uabid,uab);
mexnc('put_var_double',nc,vabid,vab);
mexnc('put_var_double',nc,artid,art);
mexnc('put_var_double',nc,aruid,aru);
mexnc('put_var_double',nc,arvid,arv);
mexnc('put_var_double',nc,elbid,elb);
mexnc('put_var_double',nc,etbid,etb);
mexnc('put_var_double',nc,ssurfid,ssurf);
mexnc('put_var_double',nc,tsurfid,tsurf);

mexnc('put_var_double',nc,tbid,tb);
mexnc('put_var_double',nc,sbid,sb);
mexnc('put_var_double',nc,tclimid,tclim);
mexnc('put_var_double',nc,sclimid,sclim);
mexnc('put_var_double',nc,rhoid,rho);
mexnc('put_var_double',nc,rmeanid,rmean);
mexnc('put_var_double',nc,ubid,ub);
mexnc('put_var_double',nc,vbid,vb);

%% close file
mexnc('close',nc);









