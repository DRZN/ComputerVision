function denoised_image=non_local_means(input,w,p)
% Input- Noisy image, window size, patch size
% output denoised image via non local means filtering


%% Denoising alogirthm (Non-local means)
%w=10; % window size
%p=2;  % patch size
gamma=0.7;
[rows,cols]=size(input);
input = padarray(input,[p p],'symmetric');
denoised_image=zeros(rows,cols);
min_error=100000000000;
min_gamma=0;

% This for loop is for testing multiple values of gamma, be sure to uncomment the end statement of this for loop
% for gamma=0.1:0.1:1  

for i=p+1:rows
    for j=p+1:cols
        patch_x=input(i-p:i+p,j-p:j+p);
        r_top_pix=max(p+1,i-w);
        r_bottom=min(i+w,rows);
        c_top=max(p+1,j-w);
        c_bottom=min(j+w,cols);

        numerator=0;
        denominator=0;
        for i1=r_top_pix:r_bottom
            for j1=c_top:c_bottom
                intensity=input(i1,j1);
                patch=input(i1-p:i1+p,j1-p:j1+p);

                num=patch_x-patch;
                numerator=numerator+intensity*exp(-1*gamma*((norm(num))^2));
                denum=exp(-1*gamma*((norm(num))^2));
                denominator=denominator+denum;
            end
        end
        denoised_image(i,j)=numerator/denominator;

    end
end
error1 = sum(sum((denoised_image - im).^2));
disp(error1);
% end   %uncommment end if using gamma for loop

end
