function [err, s] = broadcast_gossip(kmax, G, s, x_ave)
% iterate until convergence
k=0;
err=inf;
d=degree(G);
i=zeros(0,1);
w=ones(200,1);%initialize the weight vector
x=zeros(200,1);
while(err(end)>1e-12) && (k<kmax)
    %select node randmly
    i(end+1)=randi(200);
    nei=neighbors(G, i(end));
    
    %update sum vector
    s(i(end))=s(i(end))/(d(i(end))+1);
    s(nei)=s(nei)+s(i(end));
    
    %update the weight vector
    w(i(end))=w(i(end))/(d(i(end))+1);
    w(nei)=w(nei)+w(i(end));
    
    %update the node value
    x=s./w;
    
    %compute the iteration error
    k=k+1;
    err(k)=norm(x-x_ave);
end