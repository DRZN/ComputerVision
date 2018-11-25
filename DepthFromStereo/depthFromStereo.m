function depth = depthFromStereo(img1, img2, patch_radius)
%% Input- RGB Images taken of the same object from different camera angles.
%       - patch_radius to be considered 
% output- depth map.
% Assumption- only horizontal shift in the camera position. 

depth = ones(size(img1,1), size(img1,2));

%taking average of the three channels 
img1 = mean(img1, 3);
img2 = mean(img2, 3);

[rows, cols]=size(img1);

for i=1:rows
    mini = max(1, i - patch_radius);
    maxi = min(rows, i + patch_radius);

    for j=1:cols
        minc = max(1, j - patch_radius);
        maxc = min(cols, j + patch_radius);

        patch_x1=img2(mini:maxi, minc:maxc);

        left_col= 0; % searching only on the right side
        right_col= min(50,cols-maxc); % upto 50 places only

        min_ssd=1000000000;
        min_index=0;

        for l=left_col:right_col
            patch_x2=img1(mini:maxi, minc+l:maxc+l);
            ssd=sum(sum((patch_x1-patch_x2).^2));
            if(ssd<min_ssd)
                min_ssd=ssd;
                min_index=l+1;
            end
        end
       depth(i,j)=min_index;
    end
end
figure();
image(depth);
axis image;
colormap('jet');
colorbar;
