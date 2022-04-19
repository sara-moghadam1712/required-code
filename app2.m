%% LOAD DATA
load test;
nData=size(X,2);
perm=randperm(nData);
%% Train Data
pTrain=0.7;
nTrainData=round(pTrain*nData);
TrainInd=perm(1:nTrainData);
TrainX=X(:,TrainInd);
TrainY=Y(:,TrainInd);
%% Test Data
pTest=1-pTrain;
nTestData=nData-nTrainData;
TestInd=perm(nTrainData+1:end);
TestX=X(:,TestInd);
TestY=Y(:,TestInd);
%% Create and Train GMDH Network

params.MaxLayerNeurons= 20;      %Max Number of Neurons in a Layer
params.MaxLayers= 3;            %Max Number of Layers
params.alpha= 0.7;               %selection pressure
params.pTrain= 0.7;
gmdh= GMDH(params, TrainX, TrainY);
%% Evaluate GMDH Network

Outputs=ApplyGMDH(gmdh,X);
TrainOutputs=Outputs(:,TrainInd);
TestOutputs=Outputs(:,TestInd);


%% show results
figure;
plotResults(TrainY, TrainOutputs, 'Train Data');
figure;
plotResults(TestY, TestOutputs, 'Test Data');
figure;
plotResults(Y, Outputs, 'All Data');
figure;
plotregression(TrainY, TrainOutputs, 'Train Data',...
               TestY, TestOutputs, 'TestData',...
               Y, Outputs, 'All Data');

