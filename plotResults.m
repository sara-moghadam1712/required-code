function plotResults(Y, Outputs, Title)
Errors=Y-Outputs;
MSE=mean(Errors.^2);
RMSE=sqrt(MSE);
ErrorMean=mean(Errors);
ErrorStd=std(Errors);

subplot(2,2,[1 2]);
plot(Y,'LineWidth',2);
hold on
plot(Outputs,'LineWidth',2);
legend('Y','Outputs');
ylabel('Y and Outputs');
grid on;
title(Title);

subplot(2,2,3);
plot(Errors,'LineWidth',2);
title(['MSE =' num2str(MSE) ', RMSE =' num2str(RMSE)]);
ylabel('Errors');
grid on;
subplot(2,2,4);
histfit(Errors);
title(['Error Mean=' num2str(ErrorMean) ', Error StD=' num2str(ErrorStd)]);
end