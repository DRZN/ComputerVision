function  heightMap = getSurface(allPartial, method)
% GETSURFACE computes the surface depth from normals
% Input:
%   Partial Derivatives of Surface normals: height x width x 3 array of unit surface normals
%   METHOD: the intergration method to be used
%
% Output:
%   HEIGHTMAP: height map of object

[h,w,~]=size(allPartial);
x=reshape(allPartial(:,:,1),[h,w]);
y=reshape(allPartial(:,:,2),[h,w]);
heightMap=zeros(h,w);

summed_x1=repmat(cumsum(x(1,:)),h,1);
summed_y1=cumsum(y);

summed_x2=cumsum(x,2);
summed_y2=repmat(cumsum(y(:,1)),1,w);

switch method
    case 'column'
        %%% implement this %%%
        heightMap=(summed_x1+summed_y1);
        
    case 'row'
        %%% implement this %%%
        heightMap=(summed_x2+summed_y2);
        
    case 'average'
        %%% implement this %%%
        heightMap=((summed_x2+summed_y2)+(summed_x1+summed_y1))/2;
        
end

