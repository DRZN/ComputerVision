function [albedoImage, surfaceNormals,allPartial] = photometricStereo(imArray, lightDirs)
% PHOTOMETRICSTEREO compute intrinsic image decomposition from images
%   [ALBEDOIMAGE, SURFACENORMALS] = PHOTOMETRICSTEREO(IMARRAY, LIGHTDIRS)
%   comptutes the ALBEDOIMAGE and SURFACENORMALS from an array of images
%   with their lighting directions. The surface is assumed to be perfectly
%   lambertian so that the measured intensity is proportional to the albedo
%   times the dot product between the surface normal and lighting
%   direction. The lights are assumed to be of unit intensity.
%
%   Input:
%       IMARRAY - [h w n] array of images, i.e., n images of size [h w]
%       LIGHTDIRS - [n 3] array of unit normals for the light directions
%       (Source vectors S)
%
%   Output:
%        ALBEDOIMAGE - [h w] image specifying albedos
%        SURFACENORMALS - [h w 3] array of unit normals for each pixel

[h,w,n]= size(imArray);

% For each pixel set up a linear system, 
%the solution to that linear system Ax = b is given by x = A\b in matlab.
all_g=zeros(h,w,3);
all_rho=zeros(h,w);
all_N=zeros(h,w,3);
allPartial=zeros(h,w,2);
for i=1:h
    for j=1:w
        
        I=imArray(i,j,:);
        I=reshape(I,[n,1]);
        %I=lightDirs*g
        g=lightDirs\I; % dimensions are right
        disp(g)
        rho=norm(g); % ALBEDO: taking magnitude of g vector
        N=g/rho; % Getting normals for each pixel
        all_g(i,j,:)=g;
        all_rho(i,j)=rho; 
        all_N(i,j,:)=N;
        allPartial(i,j,1)=N(1)/N(3);
        allPartial(i,j,2)=N(2)/N(3);
        
    end
end
 

albedoImage=all_rho;
surfaceNormals=all_N;
