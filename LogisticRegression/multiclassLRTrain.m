function model = multiclassLRTrain(x, y, param, classLabels)
%% Inputs- X- size= number_of_features, ( number of training samples)
% for eg, mnist dataset- size(x)= 784,1000 if each pixel is a feature
% and size(y)=(1,1000) 
% classlabels=digits(0,1,2,3,4,5,6,7,8,9)   
% param.lambda = 0.01;  % Regularization term
% param.maxiter = 1000; % Number of iterations
% param.eta = 0.01;     % Learning rate

numClass = length(classLabels);
numFeats = size(x,1);  % total number of features
numData = size(x,2);   % total number of samples given for training

% converting y into one hot encoding each row stands for each class, each column stands for a sample
one_hot_y=zeros(numClass,numData);
for i=1:numData
    class=y(i)+1;
    one_hot_y(class,i)=1;
end

% Initialize weights randomly (Implement the gradient descent)
x_bias=[x;ones(1,numData)];
model.w = randn(numClass, numFeats+1)*0.01;
model.classLabels = classLabels;

for i=1:param.maxiter
    % predictions
    temp=model.w*x_bias;
    num=exp(temp- max(temp)); % for stability
    den=sum(num); %summing on columns only.
    yhat=num./den; %diving each column with its sum
    
    % gradients
    term1=yhat-one_hot_y;
    term1=term1*x_bias'; 
    term2=2*param.lambda*model.w;
    grad_w=term1+term2;
    
    % weight updation
    model.w=model.w-param.eta*grad_w;
end



