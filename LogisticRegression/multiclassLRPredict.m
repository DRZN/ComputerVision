function ypred = multiclassLRPredict(model,x)
numData = size(x,2);

%add a bias term
x_bias=[x;ones(1,numData)];

num=exp(model.w*x_bias);
probs=(num)./sum(num); 
[~,ypred]= max(probs);% Choose the class with max prob for each data case
ypred=model.classLabels(ypred);

