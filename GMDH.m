function gmdh= GMDH(params, X, Y)
alpha= params.alpha;
MaxLayerNeurons = params.MaxLayerNeurons;
MaxLayers = params.MaxLayers;
nData=size(X,2);
% shuffle Data
permutation = randperm(nData);
X=X(:,permutation);
Y=Y(:,permutation);

% Devide Data
pTrainData= params.pTrain;
nTrainData=round(pTrainData*nData);
X1= X(:,1:nTrainData);
Y1= Y(:,1:nTrainData);
pTestData=1-pTrainData;
nTestData=nData-nTrainData;
X2= X(:,nTrainData+1:end);
Y2= Y(:,nTrainData+1:end);

Layers=cell(MaxLayers,1); 

Z1=X1;
Z2=X2;
for l=1:MaxLayers

L=GetpolynomialLayer(Z1, Y1, Z2, Y2);

ec=alpha*L(1).RMSE2+(1-alpha)*L(end).RMSE2;
ec=max(ec,L(1).RMSE2);
L=L([L.RMSE2]<=ec);

if numel(L)>MaxLayerNeurons
    L=L(1:MaxLayerNeurons);
end
if l==MaxLayers && numel(L)>1
    L=L(1);
end
Layers{l}=L;

Z1=reshape([L.Y1hat],nTrainData,[])';
Z2=reshape([L.Y2hat],nTestData,[])';
disp(['Layer' num2str(l) ': Neurons =' num2str(numel(L)) ',Min Error=' num2str(L(1).RMSE2)]);
if numel(L)==1
    break;
end
end
Layers=Layers(1:l);
gmdh.Layers=Layers;
end
