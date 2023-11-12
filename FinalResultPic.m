clc
clear all
close all



%% ————平移角度因素画图————
figure(1)
t = 0:5:30;
hold on
P2501m = plot(t, trans1m250W3mmDI(t+1), 'Color','b','LineStyle','-','marker','o','MarkerSize',5,'LineWidth',1);
P2502m = plot(t, trans2m250W3mmDI(t+1), 'color','b','LineStyle','--','marker','o','MarkerSize',5,'LineWidth',1);
P2503m = plot(t, trans3m250W3mmDI(t+1), 'color','b','LineStyle',':','marker','o','MarkerSize',5,'LineWidth',1);

% P2001m = plot(t, trans1m200W3mmDI(t+1), 'Color','g','LineStyle','-','marker','+','MarkerSize',5,'LineWidth',1);
% P2002m = plot(t, trans2m200W3mmDI(t+1), 'color','g','LineStyle','--','marker','+','MarkerSize',5,'LineWidth',1);
% P2003m = plot(t, trans3m200W3mmDI(t+1), 'color','g','LineStyle',':','marker','+','MarkerSize',5,'LineWidth',1);

P1501m = plot(t, trans1m150W3mmDI(t+1), 'Color','m','LineStyle','-','marker','d','MarkerSize',5,'LineWidth',1);
P1502m = plot(t, trans2m150W3mmDI(t+1), 'color','m','LineStyle','--','marker','d','MarkerSize',5,'LineWidth',1);
P1503m = plot(t, trans3m150W3mmDI(t+1), 'color','m','LineStyle',':','marker','d','MarkerSize',5,'LineWidth',1);

set(0, 'defaultTextInterpreter', 'tex');
% legend('P_{in} = 350W,L=1m','P_{in} = 350W,L=2m','P_{in} = 350W,L=3m','P_{in} = 300W,L=1m','P_{in} = 300W,L=2m','P_{in} = 300W,L=3m','P_{in} = 250W,L=1m','P_{in} = 250W,L=2m','P_{in} = 250W,L=3m');
legend('P_{in} = 350W,L=1m','P_{in} = 350W,L=2m','P_{in} = 350W,L=3m','P_{in} = 250W,L=1m','P_{in} = 250W,L=2m','P_{in} = 250W,L=3m');
ylim([0 40])
xlabel('Pan angle $\theta [^{\circ}]$','Interpreter','latex');
ylabel('Output laser power [ W ]','Interpreter','latex'); 

hold on
t=[0:0.1:2*pi];
x=10+0.8*cos(t);
y=19+5*sin(t);
plot(x,y, 'color','k', 'LineStyle','-','LineWidth',1);
hold on
% 在当前图形窗口加入带箭头的文本标注框
h = annotation('textarrow',[0.41 0.47],[0.56 0.56]);
% 设置文本标注框中显示的字符串，并设字号为15
text(14,22,'P_{in}=350W')

hold on
t=[0:0.1:2*pi];
x=5+0.8*cos(t);
y=10.3+4.5*sin(t);
plot(x,y, 'color','k', 'LineStyle','-','LineWidth',1);
hold on
% 在当前图形窗口加入带箭头的文本标注框
h = annotation('textarrow',[0.24634 0.1115],[0.2508 0.1498]);
% 设置文本标注框中显示的字符串，并设字号为15
text(3,2,'P_{in}=250W')
box off
grid on
%% ————————
%% ————倾斜角度因素画图————
figure(2)
t = 0:5:30;
hold on
P2501m = plot(t, tilt1m250W3mmDI(t+1), 'Color','b','LineStyle','-','marker','o','MarkerSize',5,'LineWidth',1);
P2502m = plot(t, tilt2m250W3mmDI(t+1), 'color','b','LineStyle','--','marker','o','MarkerSize',5,'LineWidth',1);
P2503m = plot(t, tilt3m250W3mmDI(t+1), 'color','b','LineStyle',':','marker','o','MarkerSize',5,'LineWidth',1);

% P2001m = plot(t, tilt1m200W3mmDI(t+1), 'Color','r','LineStyle','-','marker','*','MarkerSize',5,'LineWidth',1);
% P2002m = plot(t, tilt2m200W3mmDI(t+1), 'color','r','LineStyle','--','marker','*','MarkerSize',5,'LineWidth',1);
% P2003m = plot(t, tilt3m200W3mmDI(t+1), 'color','r','LineStyle',':','marker','*','MarkerSize',5,'LineWidth',1);

P1501m = plot(t, tilt1m150W3mmDI(t+1), 'Color','m','LineStyle','-','marker','d','MarkerSize',5,'LineWidth',1);
P1502m = plot(t, tilt2m150W3mmDI(t+1), 'color','m','LineStyle','--','marker','d','MarkerSize',5,'LineWidth',1);
P1503m = plot(t, tilt3m150W3mmDI(t+1), 'color','m','LineStyle',':','marker','d','MarkerSize',5,'LineWidth',1);

% legend('P_{in} = 350W,L=1m','P_{in} = 350W,L=2m','P_{in} = 350W,L=3m','P_{in} = 300W,L=1m','P_{in} = 300W,L=2m','P_{in} = 300W,L=3m','P_{in} = 250W,L=1m','P_{in} = 250W,L=2m','P_{in} = 250W,L=3m');
legend('P_{in} = 350W,L=1m','P_{in} = 350W,L=2m','P_{in} = 350W,L=3m','P_{in} = 250W,L=1m','P_{in} = 250W,L=2m','P_{in} = 250W,L=3m');
ylim([0 35])
xlim([0 25])
xlabel('Tilt angle $\alpha [^{\circ}]$, Pan angle $\theta = 5^{\circ}$','Interpreter','latex');
ylabel('Output laser power [ W ]','Interpreter','latex'); 

hold on
t=[0:0.1:2*pi];
x=10+0.8*cos(t);
y=11+4.7*sin(t);
plot(x,y, 'color','k', 'LineStyle','-','LineWidth',1);
hold on
% 在当前图形窗口加入带箭头的文本标注框
h = annotation('textarrow',[0.41 0.47],[0.56 0.56]);
% 设置文本标注框中显示的字符串，并设字号为15
text(14,22,'P_{in}=350W')

hold on
t=[0:0.1:2*pi];
x=5+0.8*cos(t);
y=6.2+3.7*sin(t);
plot(x,y, 'color','k', 'LineStyle','-','LineWidth',1);
hold on
% 在当前图形窗口加入带箭头的文本标注框
h = annotation('textarrow',[0.24634 0.1115],[0.2508 0.1498]);
% 设置文本标注框中显示的字符串，并设字号为15
text(3,2,'P_{in}=250W')

box off
grid on
%% ————————
%% ————自旋角度因素画图1m————
figure(3)
t = 0:5:60;
hold on
P1501m = plot(t, rota1m150W3mmDI, 'Color','m','LineStyle','-','marker','d','MarkerSize',5,'LineWidth',1);
% P2001m = plot(t, rota1m200W3mmDI, 'Color','r','LineStyle','-','marker','*','MarkerSize',5,'LineWidth',1);
P2501m = plot(t, rota1m250W3mmDI, 'Color','b','LineStyle','-','marker','o','MarkerSize',5,'LineWidth',1);

P1502m = plot(t, rota2m150W3mmDI, 'color','m','LineStyle','--','marker','d','MarkerSize',5,'LineWidth',1);
% P2002m = plot(t, rota2m200W3mmDI, 'color','r','LineStyle','--','marker','*','MarkerSize',5,'LineWidth',1);
P2502m = plot(t, rota2m250W3mmDI-0.7, 'color','b','LineStyle','--','marker','o','MarkerSize',5,'LineWidth',1);

P1503m = plot(t, rota3m150W3mmDI, 'color','m','LineStyle',':','marker','d','MarkerSize',5,'LineWidth',1);
% P2003m = plot(t, rota3m200W3mmDI, 'color','r','LineStyle',':','marker','*','MarkerSize',5,'LineWidth',1);
P2503m = plot(t, rota3m250W3mmDI, 'color','b','LineStyle',':','marker','o','MarkerSize',5,'LineWidth',1);

yh = get(gca,'XLabel');
set(yh,'Interpreter','latex','string','Rotation angle $\varphi~[^{\circ}]$');
%xlabel('Roation angle $$\varphi$$ [ °]','Interpreter','latex');
ylabel('Output laser power [ W ]','Interpreter','latex'); 

box off
grid on
ax1 = gca;
ylim(ax1,[0 40])
xlim(ax1,[0 60])
ax2 = axes( 'Position',get(ax1,'Position'),'Xlim',[0 60],'Ylim',[0 40],'Visible','off','color','none');
% legend1 = legend(ax1,[P2003m,P1501m,P1502m,P1503m],{'P_{in} = 300W,L=3m','P_{in} = 250W,L=1m','P_{in} = 250W,L=2m','P_{in} = 250W,L=3m'});
% legend2 = legend(ax2,[P2501m,P2502m,P2503m,P2001m,P2002m],{'P_{in} = 350W,L=1m','P_{in} = 350W,L=2m','P_{in} = 350W,L=3m','P_{in} = 300W,L=1m','P_{in} = 300W,L=2m'},'color','none');
legend1 = legend(ax1,[P1501m,P1502m,P1503m],{'P_{in} = 250W,L=1m','P_{in} = 250W,L=2m','P_{in} = 250W,L=3m'});
legend2 = legend(ax2,[P2501m,P2502m,P2503m],{'P_{in} = 350W,L=1m','P_{in} = 350W,L=2m','P_{in} = 350W,L=3m'},'color','none');

hold on
t=[0:0.1:2*pi];
x=25+1.2*cos(t);
y=7.8+3.6*sin(t);
plot(x,y, 'color','k', 'LineStyle','-','LineWidth',1);
hold on
% 在当前图形窗口加入带箭头的文本标注框
h = annotation('textarrow',[0.41 0.47],[0.56 0.56]);
% 设置文本标注框中显示的字符串，并设字号为15
text(14,22,'P_{in}=350W')

hold on
t=[0:0.1:2*pi];
x=35+1.5*cos(t);
y=22.5+4.5*sin(t);
plot(x,y, 'color','k', 'LineStyle','-','LineWidth',1);
hold on
% 在当前图形窗口加入带箭头的文本标注框
h = annotation('textarrow',[0.24634 0.1115],[0.2508 0.1498]);
% 设置文本标注框中显示的字符串，并设字号为15
text(3,2,'P_{in}=250W')

%% ————————
%% ————增益介质尺寸因素画图————
% figure(4)original
% t = 0:5:30;
% t1 = 0:1:6;
% hold on
% P1501m = plot(t, all1m250W3mmDI(t+1), 'Color','m','LineWidth',1);
% P2001m = plot(t, all2m250W3mmDI(t+1), 'Color','r','LineWidth',1);
% P2501m = plot(t, all3m250W3mmDI(t+1), 'Color','b','LineWidth',1);
% 
% P1503m = plot(t, all1m250W4mmDI(t+1), 'color','m','LineStyle',':','marker','*','MarkerSize',5,'LineWidth',1);
% P2003m = plot(t, all2m250W4mmDI(t+1), 'color','r','LineStyle',':','marker','*','MarkerSize',5,'LineWidth',1);
% P2503m = plot(t, all3m250W4mmDI(t+1), 'color','b','LineStyle',':','marker','*','MarkerSize',5,'LineWidth',1);
% 
% P1502m = plot(t, all1m250W2mmDI(t1+1), 'color','m','LineStyle','--','marker','+','MarkerSize',5,'LineWidth',1);
% P2002m = plot(t, all2m250W2mmDI(t1+1), 'color','r','LineStyle','--','marker','+','MarkerSize',5,'LineWidth',1);
% P2502m = plot(t, all3m250W2mmDI(t1+1), 'color','b','LineStyle','--','marker','+','MarkerSize',5,'LineWidth',1);
% 
% legend('r = 3mm,L=1m','r = 3mm,L=2m','r = 3mm,L=3m','r = 3.5mm,L=1m','r = 3.5mm,L=2m','r = 3.5mm,L=3m');
% ylim([0 25])
% xlim([0 30])
% xlabel('Pan angle $\theta [^{\circ}]$, Tilt angle $\alpha = 5^{\circ}$,Rotation angle $\varphi = 5^{\circ}$','Interpreter','latex');
% ylabel('Output laser power [ W ]','Interpreter','latex'); 
% 
% box off
% grid on

figure(4)
r = 2:0.5:4;
t = 1:5;
Allmaxtrans1m = [24.2353 22.7512 19.9689 17.0736 10.4499];
Allmaxtrans2m = [19.9286 19.6252 16.1792 14.0784 6.5694];
Allmaxtrans3m = [18.5676 17.5463 13.1973 11.0672 1.5435];
Allmaxpower1m = [28.3005 27.0275 22.4323 15.1625 5.5559];
Allmaxpower2m = [26.9456 20.8061 20.2834 13.2827 2.8565];
Allmaxpower3m = [18.5166 17.6207 16.8661 11.2772 0.5935];
hold on
yyaxis left
T1 = plot(r, Allmaxtrans1m(t), 'LineStyle','-','marker','d','MarkerSize',5,'LineWidth',1);
T2 = plot(r, Allmaxtrans2m(t), 'LineStyle','-','marker','>','MarkerSize',5,'LineWidth',1);
T3 = plot(r, Allmaxtrans3m(t), 'LineStyle','-','marker','+','MarkerSize',5,'LineWidth',1);
ylabel('Maximum  pan angle $\theta [^{\circ}]$','Interpreter','latex')
ylim([0 25])

yyaxis right
P1 = plot(r, Allmaxpower1m(t), 'LineStyle','--','marker','d','MarkerSize',5,'LineWidth',1);
P2 = plot(r, Allmaxpower2m(t), 'LineStyle','-.','marker','>','MarkerSize',5,'LineWidth',1);
P3 = plot(r, Allmaxpower3m(t), 'LineStyle',':','marker','+','MarkerSize',5,'LineWidth',1);
ylabel('Maximum output power [W]','Interpreter','latex')
ylim([0 30])
xlabel('Corner-cube / gain medium size $r $[mm]','Interpreter','latex');
legend('L=1m, maximum pan angle','L=2m, maximum pan angle','L=3m, maximum pan angle','L=1m, maximum output power','L=2m, maximum output power','L=3m, maximum output power');
% hold on
% h = annotation('textarrow',[0.24634 0.1115],[0.2508 0.1498]);
% h1 = annotation('textarrow',[0.24634 0.1115],[0.2508 0.1498]);
% h2 = annotation('textarrow',[0.24634 0.1115],[0.2508 0.1498]);
% h3 = annotation('textarrow',[0.24634 0.1115],[0.2508 0.1498]);
% h4 = annotation('textarrow',[0.24634 0.1115],[0.2508 0.1498]);
% h5 = annotation('textarrow',[0.24634 0.1115],[0.2508 0.1498]);
box off
grid on
%% ————————
%% 数能同传性能
%% ————平移角度因素画图1m————
figure(5)
t = 0:5:30;
hold on
yyaxis left
P150_2m_01 = plot(t, Pc_250W_1m_01(t+1), 'LineStyle','-','marker','o','MarkerSize',5,'LineWidth',1);
P150_2m_1 = plot(t, Pc_250W_1m_1(t+1), 'LineStyle','-','marker','*','MarkerSize',5,'LineWidth',1);
P250_2m_5 = plot(t, Pc_250W_1m_5(t+1), 'LineStyle','-','marker','+','MarkerSize',5,'LineWidth',1);
P250_2m_9 = plot(t, Pc_250W_1m_9(t+1), 'LineStyle','-','marker','>','MarkerSize',5,'LineWidth',1);
P200_2m_99 = plot(t, Pc_250W_1m_99(t+1), 'LineStyle','-','marker','d','MarkerSize',5,'LineWidth',1);
ylabel('Charging power [ W ]','Interpreter','latex')
%legend('\mu=0.01','\mu=0.1','\mu=0.5','\mu=0.9','\mu=0.99');
ylim([0 7])

t = 0:1:30;
yyaxis right
P150_01 = plot(t, Rb_250W_1m_01, 'LineStyle','-.','marker','o','MarkerSize',5,'LineWidth',1);
P150_1 = plot(t, Rb_250W_1m_1, 'LineStyle','-.','marker','*','MarkerSize',5,'LineWidth',1);
P250_5 = plot(t, Rb_250W_1m_5, 'LineStyle','-.','marker','+','MarkerSize',5,'LineWidth',1);
P250_9 = plot(t, Rb_250W_1m_9, 'LineStyle','-.','marker','>','MarkerSize',5,'LineWidth',1);
P200_99 = plot(t, Rb_250W_1m_99, 'LineStyle','-.','marker','d','MarkerSize',5,'LineWidth',1);

%legend('\mu=0.01','\mu=0.1','\mu=0.5','\mu=0.9','\mu=0.99');
ylim([0 40])
xlabel('Pan angle $\theta [^{\circ}]$, $L=1$m, $P_{in}=350$W','Interpreter','latex');
ylabel('Spectral efficiency [bps/Hz]','Interpreter','latex'); 
hold on
annotation('arrow',[0.75 0.85],[0.65 0.65],...
'LineStyle','-','color','k','HeadStyle','cback3');
hold on
annotation('arrow',[0.45 0.35],[0.4 0.4],...
'LineStyle','-','color','k','HeadStyle','cback3');

box off
grid on
ax1 = gca;
ax2 = axes( 'Position',get(ax1,'Position'),'Visible','off','color','none');
legend1 = legend(ax1,[P150_2m_01,P150_2m_1,P250_2m_5,P250_2m_9,P200_2m_99],{'\mu=0.01','\mu=0.1','\mu=0.5','\mu=0.9','\mu=0.99'},'color','none');
legend2 = legend(ax2,[P150_01,P150_1,P250_5,P250_9,P200_99],{'\mu=0.01','\mu=0.1','\mu=0.5','\mu=0.9','\mu=0.99'},'color','none');

%% ————————
figure(6)
t = 0:5:30;
hold on
yyaxis left
P150_2m_5 = plot(t, Pc_250W_1m_99(t+1), 'LineStyle','-','marker','d','MarkerSize',5,'LineWidth',1);
P200_2m_5 = plot(t, Pc_200W_1m_99(t+1),  'LineStyle','-','marker','*','MarkerSize',5,'LineWidth',1);
P250_2m_5 = plot(t, Pc_150W_1m_99(t+1), 'LineStyle','-','marker','+','MarkerSize',5,'LineWidth',1);
ylabel('Charging power [ W ]','Interpreter','latex')
ylim([0 7])

t = 0:1:30;
yyaxis right
P150_5 = plot(t, Rb_250W_1m_99, 'LineStyle','-.','marker','d','MarkerSize',5,'LineWidth',1);
P200_5 = plot(t, Rb_200W_1m_99, 'LineStyle','-.','marker','*','MarkerSize',5,'LineWidth',1);
P250_5 = plot(t, Rb_150W_1m_99, 'LineStyle','-.','marker','+','MarkerSize',5,'LineWidth',1);

%legend('P_{in} = 350W, charging power','P_{in} = 300W, charging power','P_{in} = 250W, charging power','P_{in} = 350W, spectral efficiency','P_{in} = 300W, spectral efficiency','P_{in} = 250W, spectral efficiency');
ylim([0 30])
xlabel('Pan angle $\theta [^{\circ}]$, $L=1$m','Interpreter','latex');
ylabel('Spectral efficiency [bps/Hz]','Interpreter','latex'); 
hold on
annotation('arrow',[0.75 0.85],[0.5 0.5],...
'LineStyle','-','color','k','HeadStyle','cback3');
hold on
annotation('arrow',[0.45 0.35],[0.4 0.4],...
'LineStyle','-','color','k','HeadStyle','cback3');

box off
grid on
ax1 = gca;
ax2 = axes( 'Position',get(ax1,'Position'),'Visible','off','color','none');
legend1 = legend(ax1,[P150_2m_5,P200_2m_5,P250_2m_5],{'P_{in} = 350W','P_{in} = 300W','P_{in} = 250W'},'color','none');
legend2 = legend(ax2,[P150_5,P200_5,P250_5],{'P_{in} = 350W','P_{in} = 300W','P_{in} = 250W'},'color','none');

%%
figure(7)
t = 0:5:30;
hold on
yyaxis left
P150_2m_5 = plot(t, Pc_250W_1m_99(t+1), 'LineStyle','-','marker','d','MarkerSize',5,'LineWidth',1);
P200_2m_5 = plot(t, Pc_250W_2m_99(t+1), 'LineStyle','-','marker','*','MarkerSize',5,'LineWidth',1);
P250_2m_5 = plot(t, Pc_250W_3m_99(t+1), 'LineStyle','-','marker','+','MarkerSize',5,'LineWidth',1);
ylabel('Charging power [ W ]','Interpreter','latex')
ylim([0 7])

t = 0:1:30;
yyaxis right
P150_5 = plot(t, Rb_250W_1m_99, 'LineStyle','-.','marker','d','MarkerSize',5,'LineWidth',1);
P200_5 = plot(t, Rb_250W_2m_99, 'LineStyle','-.','marker','*','MarkerSize',5,'LineWidth',1);
P250_5 = plot(t, Rb_250W_3m_99, 'LineStyle','-.','marker','+','MarkerSize',5,'LineWidth',1);

legend('L=1m','L=2m','L=3m','L=1m','L=2m','L=3m');
ylim([0 30])
xlabel('Pan angle $\theta [^{\circ}]$, $P_{in}=350$W','Interpreter','latex');
ylabel('Spectral efficiency [bps/Hz]','Interpreter','latex'); 


hold on
annotation('arrow',[0.7 0.8],[0.5 0.5],...
'LineStyle','-','color','k','HeadStyle','cback3');
hold on
annotation('arrow',[0.45 0.35],[0.4 0.4],...
'LineStyle','-','color','k','HeadStyle','cback3');

box off
grid on
%%

%% 功率输出
function Power_out = outputPower(Pin, V_i, Ab, r)
   I_s = 12600000;                                                         %饱和光强                                                      
   V_s = 0.99;                                                             %增益介质损耗系数                                                            
   Eta_exict = 0.72*0.715;                                                       %激励效率                                                     
   radius = r;                                                             %增益介质半径
   R2 = 0.7;                                                               %接收端反射率
   A = pi * radius * radius;                                               %增益介质尺寸
 
   V = V_i;                                                                %单程损耗系数

   fenzi = Ab.*I_s .* (1-R2) .* V;
   fenmu = 1 - R2.*V.^2 + sqrt(R2).*V .* ((1./(V_s.*V))-V_s); 
   factor_left = fenzi ./ fenmu;
   factor_right = ((Eta_exict.*Pin)./(A.*I_s)) - abs(log(sqrt(R2.*(V_s.^2).*(V.^2))));  
   %eta = (Ab.* (1-R2) .* V)./(A * (1 - R2.*V.^2 + sqrt(R2).*V .* ((1./(V_s.*V))-V_s)))
   Power_out = factor_left .* factor_right;
end
%% 充电功率
function [Pc] = charging(Pout, kp)
eta = 0.186;   
Pc = kp * eta * Pout;
end
%% 频谱效率
function [C] = spectralEfficiency(Pout, kp)
q = 1.6 * 10^(-19);
gamma = 0.6;
Pout(Pout<0)=0;
Pd = (1-kp) .* Pout;
Is = gamma .* Pd;
Ib = 5.1 * 10^(-3);
B = 811700000;

shot = 2.* q.* (Is + Ib) .* B;

K = 1.38 * 10^(-23);
T = 300;
R = 10000;
thermal = 4.* K .* T.* B./ R;
N = shot + thermal;
SNR = Is.^2./N;
C = log2(1+SNR);
end
