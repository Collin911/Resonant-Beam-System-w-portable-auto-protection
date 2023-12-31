%% 功率阈值单图
set(0, 'defaultTextInterpreter', 'latex');
figure()
set(gcf,'position',[100, 100,1200, 900]) %设置画布标准大小且宽高比为四比三
set(gca,'position',[0.085 0.085 0.90 0.9])

hold on

InputPowerP1 = plot(xAxis, ThreshP1, 'LineStyle','-.','Marker', '^','MarkerSize',10,'LineWidth',3,'color', [231 76 60]./255);
% InputPowerPm1 = plot(xAxis, ThreshPm1, 'LineStyle','-','Marker', 'v','MarkerSize',5,'LineWidth',2.2,'color', [130 176 210]./255);
InputPowerNP1 = plot(xAxis, ThreshNP1, 'LineStyle','--','Marker', 'Diamond','MarkerSize',10,'LineWidth',3,'color', [241 196 15]./255);

InputPowerP = plot(xAxis, ThreshP5, 'LineStyle','-.','Marker', '^', 'MarkerSize',10,'LineWidth',3, 'color', [125 60 152]./255);
InputPowerPm = plot(xAxis, ThreshPm5, 'LineStyle',':','Marker', 'v','MarkerSize',10,'LineWidth',4, 'color', [31 97 141]./255);
InputPowerNP = plot(xAxis, ThreshNP5, 'LineStyle','-','Marker', 'p','MarkerSize',10,'LineWidth',3, 'color', [243 156 18]./255);

% legend('P_{\rm thresh} = 350W,L=1m','P_{\rm thresh} = 350W,L=2m','P_{\rm thresh} = 350W,L=3m','P_{\rm thresh} = 300W,L=1m','P_{\rm thresh} = 300W,L=2m','P_{\rm thresh} = 300W,L=3m','P_{\rm thresh} = 250W,L=1m','P_{\rm thresh} = 250W,L=2m','P_{\rm thresh} = 250W,L=3m');
% legend('Power Threshold With PB', 'Power Threshold With MPB','Power Threshold Without PB');
%ylim([0 40])
xlabel('Angle [ ° ]', 'Interpreter','latex');
ylabel('Input Power Threshold [ W ]'); 
set(gca,'fontsize',20,'fontname','Times')  
xlim([0 75])

box on
grid on
legend( ' d=3m, $\tilde{P}_{\rm thresh}$', ' d=3m, ${P_{\rm thresh}}$', ...
    ' d=5m, $\tilde{P}_{\rm thresh}$',' d=5m, $\mathcal{M}\{\tilde{P}_{\rm thresh}\}$', ' d=5m, ${P_{\rm thresh}}$', ...
     'Interpreter', 'latex', 'fontsize', 22, 'Location', 'Northwest')


%% 功率阈值+放大图(shift)
set(0, 'defaultTextInterpreter', 'latex');

figure()
set(gcf,'position',[100, 100,1200, 900]) %设置画布标准大小且宽高比为四比三
set(gca,'position',[0.05 0.09 0.94 0.95])
hold on
InputPowerP1 = plot(xAxis, ThreshP1, 'LineStyle','-.','Marker', '^','MarkerSize',5,'LineWidth',3.5,'color', [231 76 60]./255);
InputPowerPm1 = plot(xAxis, ThreshPm1, 'LineStyle','-','Marker', 'v','MarkerSize',5,'LineWidth',3,'color', [52 152 219]./255);
InputPowerNP1 = plot(xAxis, ThreshNP1, 'LineStyle','--','Marker', 'Diamond','MarkerSize',5,'LineWidth',4,'color', [241 196 15]./255);

InputPowerP = plot(xAxis, ThreshP, 'LineStyle','-.','Marker', '<','MarkerSize',5,'LineWidth',3.5,'color', [142 68 173]./255);
InputPowerPm = plot(xAxis, ThreshPm, 'LineStyle',':','Marker', '>','MarkerSize',5,'LineWidth',3,'color', [31 97 141]./255);
InputPowerNP = plot(xAxis, ThreshNP, 'LineStyle','--','Marker', 'p','MarkerSize',5,'LineWidth',4,'color', [243 156 18]./255);

set(0, 'defaultTextInterpreter', 'tex');
% legend('P_{\rm thresh} = 350W,L=1m','P_{\rm thresh} = 350W,L=2m','P_{\rm thresh} = 350W,L=3m','P_{\rm thresh} = 300W,L=1m','P_{\rm thresh} = 300W,L=2m','P_{\rm thresh} = 300W,L=3m','P_{\rm thresh} = 250W,L=1m','P_{\rm thresh} = 250W,L=2m','P_{\rm thresh} = 250W,L=3m');
% legend('Power Threshold With PB', 'Power Threshold With MPB','Power Threshold Without PB');
%ylim([0 40])
xlabel('Shift [ $ ^\circ$ ]','Interpreter','latex');
ylabel('Input Power Threshold [ W ]','Interpreter','latex'); 
set(gca,'fontsize',20,'fontname','Times') 
set(gca,'position',[0.09 0.08 0.89 0.9])
xlim([-3.5 3.5])
box on
grid on

legend(' d=3m, $\tilde{P}_{\rm thresh}$',' d=3m, $\mathcal{M}\{\tilde{P}_{\rm thresh}\}$', ' d=3m, ${P_{\rm thresh}}$', ...
    ' d=5m, $\tilde{P}_{\rm thresh}$',' d=5m, $\mathcal{M}\{\tilde{P}_{\rm thresh}\}$', ' d=5m, ${P_{\rm thresh}}$', ...
    'Interpreter', 'latex', 'Location', 'North', 'fontsize', 22);
% h = annotation('textarrow',[0.53 0.53],[0.20 0.29]); %以左下角为原点，图画归一化的坐标 起始/终止

% axes('Position',[0.35 0.65 0.4 0.3])%x起始 y起始 宽度 高度
% hold on
% xlim([-0.08 0.08])
% set(gca,'xtick',[-0.08:0.04:0.08])
% set(gca,'xticklabel',{'-0.08' '-0.04' '0' '0.04' '0.08'},'fontsize',10,'fontname','Times')  
% set(gca,'fontsize',17,'fontname','Times') 
% 
% InputPowerP_micro1 = plot(xAxis(4:8), ThreshP1(4:8), 'LineStyle','-.','Marker', '^','MarkerSize',5,'LineWidth',1.8, 'color', [231 76 60]./255);
% InputPowerPm_micro1 = plot(xAxis(4:8), ThreshPm1(4:8), 'LineStyle','-','Marker', 'v','MarkerSize',5,'LineWidth',1.8, 'color', [52 152 219]./255);
% InputPowerNP_micro1 = plot(xAxis(4:8), ThreshNP1(4:8), 'LineStyle','--','Marker', 'Diamond','MarkerSize',5,'LineWidth',1.8, 'color',[241 196 15]./255);
% 
% InputPowerP_micro = plot(xAxis(4:8), ThreshP(4:8), 'LineStyle','-.','Marker', '^','MarkerSize',5,'LineWidth',1.8, 'color',  [142 68 173]./255);
% InputPowerPm_micro = plot(xAxis(4:8), ThreshPm(4:8), 'LineStyle','-','Marker', 'v','MarkerSize',5,'LineWidth',1.8, 'color', [31 97 141]./255);
% InputPowerNP_micro = plot(xAxis(4:8), ThreshNP(4:8), 'LineStyle','--','Marker', 'Diamond','MarkerSize',5,'LineWidth',1.8, 'color', [243 156 18]./255);
% 
% xlabel('Shift [ m ]','Interpreter','latex');
% ylabel('Input Power Threshold [ W ]','Interpreter','latex'); 
box on
grid on

%% 功率阈值+微数据图(dist)
set(0, 'defaultTextInterpreter', 'latex');
figure()
set(gcf,'position',[100, 100,1200, 900]) %设置画布标准大小且宽高比为四比三
set(gca,'position',[0.08 0.08 0.91 0.9])

hold on
InputPowerP = plot(xAxis, ThreshP1, 'LineStyle',':','MarkerSize',5,'LineWidth',3.5, 'color', [231 76 60]./255);
InputPowerPm = plot(xAxis, ThreshPm1, 'LineStyle','-','MarkerSize',5,'LineWidth',3, 'color', [52 152 219]./255);
InputPowerNP = plot(xAxis, ThreshNP1, 'LineStyle','--','MarkerSize',5,'LineWidth',3, 'color', [243 156 18]./255);

% legend('P_{\rm thresh} = 350W,L=1m','P_{\rm thresh} = 350W,L=2m','P_{\rm thresh} = 350W,L=3m','P_{\rm thresh} = 300W,L=1m','P_{\rm thresh} = 300W,L=2m','P_{\rm thresh} = 300W,L=3m','P_{\rm thresh} = 250W,L=1m','P_{\rm thresh} = 250W,L=2m','P_{\rm thresh} = 250W,L=3m');
% legend('Power Threshold With PB', 'Power Threshold With MPB','Power Threshold Without PB');
%ylim([0 40])
xlim([0.5 8])
set(gca,'xtick',[0.5 1 2 3 4 5 6 7 8])
xlabel('Distance [ m ]');
ylabel('Input Power Threshold [ W ]'); 
set(gca,'fontsize',20,'fontname','Times')  

box on
grid on
legend( ' $\tilde{P}_{\rm thresh}$',' $\mathcal{M}\{\tilde{P}_{\rm thresh}\}$', ' ${P_{\rm thresh}}$', ...
    'Interpreter', 'latex', 'fontsize', 22)

axes('Position',[0.18 0.68 0.30 0.28])%x起始 y起始 宽度 高度
hold on
xlim([3 3+1*lambda])
set(gca,'xtick',[3 3+0.25*lambda 3+0.5*lambda 3+0.75*lambda 3+1*lambda])
set(gca,'xticklabel',{'3' '3+0.25\lambda' '3+0.5\lambda' '3+0.75\lambda' '3+\lambda'},'fontsize',10,'fontname','Times')  
set(gca,'fontsize',18,'fontname','Times')  
InputPowerP_micro = plot(xAxis_micro, ThreshP_micro, 'LineStyle',':','MarkerSize',5,'LineWidth',3, 'color', [231 76 60]./255);
InputPowerPm_micro = plot(xAxis_micro, ThreshPm_micro, 'LineStyle','-','MarkerSize',5,'LineWidth',2.5, 'color', [52 152 219]./255);
InputPowerNP_micro = plot(xAxis_micro, ThreshNP_micro, 'LineStyle','--','MarkerSize',5,'LineWidth',2.5, 'color', [243 156 18]./255);
xlabel('Distance [ m ]','Interpreter','latex','fontSize',15);
ylabel('Input Power Threshold [ W ]','Interpreter','latex','fontSize',15); 
box on
grid on

%% 等效反射率叠加传输效率图
figure()
hold on
set(0, 'defaultTextInterpreter', 'tex');

yyaxis left
EquivR = plot(xAxis,ER, 'LineStyle','-.','LineWidth',1.5);
EquivRModu = plot(xAxis,ERm,  'LineStyle','-','LineWidth',1.5,'MarkerSize',5);
OriginR = plot(xAxis,Ros,  'LineStyle','--','LineWidth',1.5);
% OriginR = plot(xAxis,repelem(0.6,16),  'LineStyle','-.','LineWidth',1);
xlabel('Distance [ m ]','Interpreter','latex');
ylabel('Reflectance','Interpreter','latex'); 
hold on
box off
grid on

yyaxis right 
EffP = plot(xAxis, V_pb, 'LineStyle','--','MarkerSize',5,'LineWidth',1.5);
EffPm = plot(xAxis, V_pbm, 'LineStyle','-','MarkerSize',5,'LineWidth',1.5);
EffNP = plot(xAxis, V_np, 'LineStyle','-.','MarkerSize',5,'LineWidth',1.5);
ylabel('Transfer Efficiency','Interpreter', 'latex'); 

legend('Equivalent Reflectance', 'Modulated Equivalent Reflectance', 'Original Reflectance', 'Transfer Efficiency with PB', 'Transfer Efficiency with MPB', 'Transfer Efficiency without PB');


% 在当前图形窗口加入带箭头的文本标注框
h = annotation('textarrow',[0.6667 0.72],[0.325 0.325]); %以左下角为原点，图画归一化的坐标 起始/终止
% 设置文本标注框中显示的字符串，并设字体为Times New Roman
text(3.9,0.265,'Efficiency', 'FontName','Times New Roman')%对应实际xy坐标

h = annotation('textarrow',[0.48 0.42],[0.625 0.625]); %以左下角为原点，图画归一化的坐标 起始/终止
text(1.75,0.635,'Reflectance', 'FontName','Times New Roman')%对应实际xy坐标
%% Tilt RV
set(0, 'defaultTextInterpreter', 'latex');
figure()
set(gcf,'position',[100, 100,1200, 900]) %设置画布标准大小且宽高比为四比三
subplot(2,1,1)
hold on

set(gca,'position',[0.07 0.56 0.91 0.43]) %设置第一个subplot位置和大小[左边距 下边距 宽度 高度]
set(gca,'fontsize',20,'fontname','Times') 

%,'Marker', 'Diamond'
% EffP1 = plot(xAxis, V_pb1, 'LineStyle','-.','Marker', 'v','MarkerSize',10,'LineWidth',2.2, 'color', [231 76 60]./255);
EffPm1 = plot(xAxis, V_pbm1, 'LineStyle','-','Marker', '^','MarkerSize',10,'LineWidth',3, 'color', [52 152 219]./255);
EffNP1 = plot(xAxis, V_np1, 'LineStyle','--','Marker', 'Diamond','MarkerSize',10,'LineWidth',4, 'color', [241 196 15]./255);

EffP = plot(xAxis, V_pb, 'LineStyle','-.','Marker', '<','MarkerSize',10,'LineWidth',3, 'color', [142, 68, 173 ]./255);
EffPm = plot(xAxis, V_pbm, 'LineStyle',':','Marker', '>','MarkerSize',10,'LineWidth',3.5, 'color', [31 97 141]./255);
EffNP = plot(xAxis, V_np, 'LineStyle','--','Marker', 'p','MarkerSize',10,'LineWidth',4, 'color', [243 156 18]./255);
legend(' d=3m, $\tilde{V_{\rm rt}}$', ' d=3m, ${V_{\rm rt}}$', ...
    ' d=5m, $\tilde{V_{\rm rt}}$',' d=5m, $\mathcal{M}\{\tilde{V_{\rm rt}}\}$', ' d=5m, ${V_{\rm rt}}$', ...
    'Interpreter', 'latex', 'fontsize', 22);
% 
ylabel('Transfer Efficiency','Interpreter','latex'); 
xlim([0 75])
box on
grid on


subplot(2,1,2)
hold on
set(gca,'fontsize',20,'fontname','Times') 
set(gca,'position',[0.07 0.09 0.91 0.42])
set(0, 'defaultTextInterpreter', 'latex');
ylim([0.18 1])
% RP1 = plot(xAxis, ER1, 'LineStyle','-.','Marker', 'v','MarkerSize',10,'LineWidth',2.2, 'color', [231 76 60]./255);
RPm1 = plot(xAxis, ERm1, 'LineStyle','-','Marker', '^','MarkerSize',10,'LineWidth',3, 'color', [52 152 219]./255);

Ros = repelem(0.4, length(ER1));
RP = plot(xAxis, ER5, 'LineStyle','-.','Marker', '<','MarkerSize',10,'LineWidth',3, 'color', [142, 68, 173 ]./255);
RPm = plot(xAxis, ERm5, 'LineStyle',':','Marker', '>','MarkerSize',10,'LineWidth',4, 'color', [31 97 141]./255);
RNP = plot(xAxis, Ros, 'LineStyle','--','MarkerSize',10,'LineWidth',3.5, 'color', [39 174 96]./255);

xlim([0 75])


xlabel('Angle [ ° ]','Interpreter','latex');
ylabel('Reflectance','Interpreter','latex'); 
legend(' d=3m, $\tilde{R_r}$',...
    ' d=5m, $\tilde{R_r}$',  ' d=5m, $\mathcal{M}\{\tilde{R_r}\}$', ...
     ' $R_r$', 'Interpreter', 'latex', 'fontsize', 22);
% 
box on
grid on



%% Shift RV
set(0, 'defaultTextInterpreter', 'latex');
figure()
set(gcf,'position',[100, 100,1200, 900]) %设置画布标准大小且宽高比为四比三
subplot(2,1,1)
hold on

set(gca,'position',[0.07 0.56 0.91 0.43]) %设置第一个subplot位置和大小[左边距 下边距 宽度 高度]
set(gca,'fontsize',20,'fontname','Times') 

%,'Marker', 'Diamond'
EffP1 = plot(xAxis, V_pb1, 'LineStyle','-','Marker', 'v','MarkerSize',10,'LineWidth',3.5, 'color', [231 76 60]./255);
EffPm1 = plot(xAxis, V_pbm1, 'LineStyle','-.','Marker', '^','MarkerSize',10,'LineWidth',3, 'color', [52 152 219]./255);
EffNP1 = plot(xAxis, V_np1, 'LineStyle','--','Marker', 'Diamond','MarkerSize',10,'LineWidth',4, 'color', [241 196 15]./255);

EffP = plot(xAxis, V_pb, 'LineStyle','-.','Marker', '<','MarkerSize',10,'LineWidth',3, 'color', [142, 68, 173 ]./255);
EffPm = plot(xAxis, V_pbm, 'LineStyle',':','Marker', '>','MarkerSize',10,'LineWidth',3.5, 'color', [31 97 141]./255);
EffNP = plot(xAxis, V_np, 'LineStyle','--','Marker', 'p','MarkerSize',10,'LineWidth',4, 'color', [243 156 18]./255);
legend(' d=3m, $\tilde{V_{\rm rt}}$',' d=3m, $\mathcal{M}\{\tilde{V_{\rm rt}}\}$', ' d=3m, ${V_{\rm rt}}$', ...
    ' d=5m, $\tilde{V_{\rm rt}}$',' d=5m, $\mathcal{M}\{\tilde{V_{\rm rt}}\}$', ' d=5m, ${V_{\rm rt}}$', ...
    'Interpreter', 'latex', 'Location', 'South', 'fontsize', 22);
xlim([-3.5 3.5])
ylabel('Transfer Efficiency','Interpreter','latex'); 
box on
grid on


subplot(2,1,2)
hold on
set(gca,'fontsize',20,'fontname','Times') 
set(gca,'position',[0.07 0.09 0.91 0.42])
set(0, 'defaultTextInterpreter', 'latex');
xlim([-3.5 3.5])
ylim([0.2 1])
RP1 = plot(xAxis, ER1, 'LineStyle','-','Marker', 'v','MarkerSize',10,'LineWidth',3.5, 'color', [231 76 60]./255);
RPm1 = plot(xAxis, ERm1, 'LineStyle','-.','Marker', '^','MarkerSize',10,'LineWidth',3, 'color', [52 152 219]./255);

RP = plot(xAxis, ER, 'LineStyle','-.','Marker', '<','MarkerSize',10,'LineWidth',3, 'color', [142, 68, 173 ]./255);
RPm = plot(xAxis, ERm, 'LineStyle',':','Marker', '>','MarkerSize',10,'LineWidth',3.5, 'color', [31 97 141]./255);
RNP = plot(xAxis, repelem(Ro, length(ER)), 'LineStyle','--','MarkerSize',10,'LineWidth',3.2, 'color', [39 174 96]./255);



xlabel('Shift [ $^\circ$ ]','Interpreter','latex');
ylabel('Reflectance','Interpreter','latex'); 
legend(' d=3m, $\tilde{R_r}$',' d=3m, $\mathcal{M}\{\tilde{R_r}\}$',...
    ' d=5m, $\tilde{R_r}$',  ' d=5m, $\mathcal{M}\{\tilde{R_r}\}$', ...
     ' $R_r$', 'Interpreter', 'latex', 'fontsize', 22);
% 
box on
grid on


%% dist RV 
set(0, 'defaultTextInterpreter', 'latex');
figure()
set(gcf,'position',[100, 100,1200, 900]) %设置画布标准大小且宽高比为四比三
subplot(2,1,1)
hold on

set(gca,'position',[0.07 0.56 0.91 0.43]) %设置第一个subplot位置和大小[左边距 下边距 宽度 高度]
set(gca,'fontsize',20,'fontname','Times') 

%,'Marker', 'Diamond'
% EffP1 = plot(xAxis, V_pb1, 'LineStyle','-.','Marker', 'v','MarkerSize',5,'LineWidth',1.7, 'color', [250 127 111]./255);
% EffPm1 = plot(xAxis, V_pbm1, 'LineStyle','-','Marker', '^','MarkerSize',5,'LineWidth',1.7, 'color', [130 176 210]./255);
% EffNP1 = plot(xAxis, V_np1, 'LineStyle','--','Marker', 'Diamond','MarkerSize',5,'LineWidth',1.7, 'color', [150 195 125]./255);

EffP = plot(xAxis, V_pb1, 'LineStyle',':','MarkerSize',5,'LineWidth',3.5, 'color', [231, 76, 60]./255);%, [200 36 35]./255);
EffPm = plot(xAxis, V_pbm1, 'LineStyle','-','MarkerSize',5,'LineWidth',3, 'color', [52, 152, 219]./255);%, [40 120 181]./255);
EffNP = plot(xAxis, V_np1, 'LineStyle','--','MarkerSize',5,'LineWidth',3, 'color', [243, 156, 18]./255);%, [237 177 32]./255);
legend(' $\tilde{V_{\rm rt}}$',' $\mathcal{M}\{\tilde{V_{\rm rt}}\}$', ' ${V_{\rm rt}}$', 'Interpreter', 'latex','fontsize', 22);
ylabel('Transfer Efficiency','Interpreter','latex'); 
xlim([0.5 8])
set(gca,'xtick',[0.5 1 2 3 4 5 6 7 8])
box on
grid on


subplot(2,1,2)
hold on
set(gca,'fontsize',20,'fontname','Times') 
set(gca,'position',[0.07 0.08 0.91 0.42])
set(0, 'defaultTextInterpreter', 'latex');

RP = plot(xAxis, ER1, 'LineStyle',':','MarkerSize',5,'LineWidth',3.5, 'color', [231, 76, 60]./255);
RPm = plot(xAxis, ERm1, 'LineStyle','-','MarkerSize',5,'LineWidth',3, 'color', [52, 152, 219]./255);

% RP = plot(xAxis, ER, 'LineStyle','-.','Marker', 'v','MarkerSize',5,'LineWidth',1.7, 'color', [200 36 35]./255);
% RPm = plot(xAxis, ERm, 'LineStyle','-','Marker', '^','MarkerSize',5,'LineWidth',1.7, 'color', [40 120 181]./255);
RNP = plot(xAxis, repelem(Ro, length(ER1)), 'LineStyle','--','MarkerSize',5,'LineWidth',3, 'color', [243, 156, 18]./255);

% legend('P_{\rm thresh} = 350W,L=1m','P_{\rm thresh} = 350W,L=2m','P_{\rm thresh} = 350W,L=3m','P_{\rm thresh} = 300W,L=1m','P_{\rm thresh} = 300W,L=2m','P_{\rm thresh} = 300W,L=3m','P_{\rm thresh} = 250W,L=1m','P_{\rm thresh} = 250W,L=2m','P_{\rm thresh} = 250W,L=3m');
% legend('Power Threshold With PB', 'Power Threshold With MPB','Power Threshold Without PB');
%ylim([0 40])
xlim([0.5 8])
set(gca,'xtick',[0.5 1 2 3 4 5 6 7 8])
xlabel('Distance [ m ]','Interpreter','latex');
ylabel('Reflectance','Interpreter','latex'); 
legend(' $\tilde{R_{r}}$',' $\mathcal{M}\{\tilde{R_{r}}\}$', ' ${R_{r}}$', 'Interpreter', 'latex','fontsize', 22);
%    ' d=2m Equivalent Reflectance',  ' d=2m Modulated Equivalent Reflectance', ...

box on
grid on