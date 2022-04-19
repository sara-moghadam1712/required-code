function L=GetpolynomialLayer(X1,Y1,X2,Y2)
n=size(X1,1);
k=0;
for i=1:n-1
    for j=i+1:n
        k=k+1;
        L(k)=Fitpolynomial(X1([i j],:),Y1,X2([i j],:),Y2,[i j]);
    end
end
[~, sortorder]=sort([L.RMSE2]);
L=L(sortorder);
end