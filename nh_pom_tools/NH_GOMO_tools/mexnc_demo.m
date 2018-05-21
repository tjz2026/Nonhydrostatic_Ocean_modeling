% this is a demo of how to use mexnc for writing and reading .nc files.
% written by Jiuzou Tang @ NSCCWX

clear, close('all'), clc
% Make POM netcdf initial condition file
runid='seamount'; %rund id
im=92;jm=62;
%% Vertical levels (z-coordinate)
kb=35;
z=linspace(0,4500,kb);

%% Set up initial tempearature and salinity
% startified temperature profile (uniform in the horizontal
t1=5.0+15.0*exp(-z/4500/0.25);
t=permute(t1,[1,3,2]);
t=repmat(t,[jm,im,1]); % t is 62 by 92 by 35!
%% Figure
% figure
% plot(t1,-z)
% ylabel('Sigma level')
% xlabel('Temperature')
% hold on

%% turn off warnings from netcdf
mexnc('setopts',0);

%% write netcdf grid file
runid = 'seamount';
% 'CLOBBER' - overwrite existing files
% 'NOCLOBBER' - do not overwrite existing files
% 'SHARE' - allow for synchronous file updates
% '64BIT_OFFSET' - allow the creation of 64-bit files instead of
% the classic format
% 'NETCDF4' - create a netCDF-4/HDF5 file
% 'CLASSIC_MODEL' - enforce classic model, has no effect unless used
% in a bitwise-or with 'NETCDF4'
nc=mexnc('create',['./',runid,'.ts_initial.nc'],'clobber');
%% dimension
x_dimid=mexnc('def_dim',nc,'x',im);
y_dimid=mexnc('def_dim',nc,'y',jm);
z_dimid=mexnc('def_dim',nc,'z',kb);

%write 1D variable z 
%% define variables and attributes
z_varid=mexnc('def_var',nc,'z',nc_double,1,z_dimid);
mexnc('attput',nc,z_varid,'long_name',nc_char,11,'depth level'); % 11, character length 
mexnc('attput',nc,z_varid,'units',nc_char,1,'m');

t_varid=mexnc('def_var',nc,'t',nc_double,3,[z_dimid,y_dimid,x_dimid]);
mexnc('attput',nc,t_varid,'long_name',nc_char,21,'potential temperature');
mexnc('attput',nc,t_varid,'units',nc_char,1,'K');
%% end definitions
mexnc('enddef',nc);
%% write data
mexnc('put_var_double',nc,z_varid,z);
% NetCDF files use C-style row-major ordering for multidimensional arrays, 
%      while MATLAB uses FORTRAN-style column-major ordering.  This means that 
%      the size of a MATLAB array must be flipped relative to the defined 
%      dimension sizes of the netCDF data set.  For example, if the netCDF 
%      dataset has dimensions 3x4x5, then the equivalent MATLAB array has 
%      size 5x4x3.  The PERMUTE command is useful for making any necessary 
%      conversions when reading from or writing to netCDF data sets.

% e.g, permute(t,[2,1,3]) is 92 by 62 by 35
% while t_varid is 35 by 62 by 92 
mexnc('put_var_double',nc,t_varid,permute(t,[2,1,3]));

%% close file
mexnc('close',nc);
file = ['./',runid,'.ts_initial.nc'];
nc_read=mexnc('open',file,'nowrite');
z_read=mexnc('varget',nc_read,'z',0,-1,1);
t_read = mexnc('varget',nc_read,'t',[0,0,0],[-1,-1,-1],1);

% usage of matlab native netcdf
filename = 'z.nc';
ncid2      =    netcdf.create(filename,'NC_SHARE');
imx       =    netcdf.defDim(ncid2,'im',im);     jmy       =    netcdf.defDim(ncid2,'jm',jm);
kbz       =    netcdf.defDim(ncid2,'kb',kb);     dconst    =    netcdf.defDim(ncid2,'dc',1);
dx = linspace(0,1,im*jm);
dx = reshape(dx,[im,jm]);
zid       =    netcdf.defVar(ncid2,'z','double',[dconst dconst kbz]);
netcdf.endDef(ncid2);
netcdf.putVar(ncid2,zid,z);  
netcdf.close(ncid2);
zz = ncread(filename,'z');



