function features = lbp(x)
%% Input- x-images
% N=total images, W*H=size of each image
% output- Simple Local Binary Pattern features of the images

[W, H, ~, N]=size(x);
disp(size(x))
features=zeros(256,N);

% reverse binary array
binary=[1,2,4; 8,0,16; 32,64,128];

    for i=1:N
        img=x(:,:,:,i);
        for j=2:W-1
            for k=2:H-1
                patch=img(j-1:j+1,k-1:k+1);
                indexes=patch>patch(2,2);
                decimal=sum(sum(indexes.*binary))+1;
                features(decimal,i)=features(decimal,i)+1;
            end
        end
        
        % Normalization
        features(:,i)=features(:,i)/norm(features(:,i),2);
    end
    
end
