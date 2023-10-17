%% Run this code to obtain %O^A and \bar f_L - set the proper parameter values in the "runmeeasyFINAL3", "runmeeasyFINAL3TRANSIENT", or "runmeeasyFINAL3DOUBLETRANSIENT" code

N=1; %Number of Simulations
G=504 ;%Final time (hours)
 
Te=zeros(1,N);
for i=1:1:N
    

%%% Select the code that you want to use

runmeeasyFINAL3;
% runmeeasyFINAL3TRANSIENT;
%runmeeasyFINAL3DOUBLETRANSIENT;


load('Tfin');
if Tfin(end-1)>G
    Te(i)=G;
else
Te(i)=Tfin(end-1); 
end
    

    display('-------------------------------------');
        disp(i);
    display('-------------------------------------');

end



Te=sort(Te);

R=G;
Se=zeros(1,R);

SSe=zeros(1,R);



for h=1:1:R
  for j=1:1:N
    if Te(j)<(h) && Te(j)>=((h-1))
        
        Se(h)=Se(h)+1;
    end
  end
    
end

Se0=0;


for h=1:1:R-1
 
  SSe(h)=Se0+Se(h);
    Se0=SSe(h);
    
end
SSe(R)=SSe(R-1);



for h= 1:1:R;

SSe(h) = SSe(h)/N;

end




%%% Plot \% O^A

SSSe=[0,SSe];

h=0:1:R;
figure(1)
hold on;
plot(h/24,SSSe,'LineWidth',5);
set(gca, 'FontName', 'Times New Roman','xtick',[],'ytick',[])
% set(gcf, 'Color', 'None')
xlabel('time (days)');
box on
ax = gca;
ax.LineWidth = 1;
ylabel('% O^A');
axis([0 G/24 0 1]);

%%% Plot \bar f_L

TTee=Te/24;

TTee=[TTee, -1, 21];

BinU=33;

figure(2)
hold on
histogram(TTee,BinU,'Normalization','probability');
set(gca, 'FontName', 'Times New Roman','FontSize',18)
set(gca, 'XTick', [], 'YTick', []);
grid on
grid minor
xlabel('time (days)');
box on
ylabel('\bar{f}_L');
