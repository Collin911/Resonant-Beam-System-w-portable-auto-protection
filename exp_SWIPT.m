clc
close all
rho_pv = 0.4;
I_0 = 9.8e-9;
L_pv = 100;
R_s = 0.93;
R_p = 52.6e3;
n_s = 40;
A = 1.105;
K = 1.38e-23;
T = 300;

B = 811.7e6;
L_apd = 10000;
rho_apd = 0.6;
I_b = 5100e-6;

% rho_pv = 0.6;
% I_0 = 0.32e6;
% L_pv = 100;
% R_s = 37e-3;
% R_p = 53.82;
% n_s = 10;
% A = 1.48;
% K = 1.38e-23;
% T = 398;
% 
% B = 800e6;
% L_apd = 10000;
% rho_apd = 0.4;
% I_b = 5100e-6;

% P_in = repelem(60, length(xAxis));
P_in = ThreshNP1(1:56);
g0l = (eta_excit.*P_in) ./ (A_gm*I_s);
P_out_np = gather(Cal_PowerOutput(A_gm, I_s, Vvec_np_fullR, Vs, g0l, 0.95));
P_out_pm = gather(Cal_PowerOutput(A_gm, I_s, Vvec_pm(1:224), Vs, g0l, ERm1(1:56)));
xi_e = 0.8;
xi_c = 0.05;
%%
P_pv_np = xi_e*P_out_np;
P_pv_pm = xi_e*P_out_pm;
P_e_np = Cal_PowerPV(P_out_np, rho_pv, I_0, L_pv, R_s, R_p, n_s, A, K, T);
P_e_pm = Cal_PowerPV(P_out_pm, rho_pv, I_0, L_pv, R_s, R_p, n_s, A, K, T);
%%
P_channel_np = xi_c*P_out_np;
P_channel_pm = xi_c*P_out_pm;
C_np = Cal_SpectralEfficiency(P_channel_np, rho_apd, L_apd, I_b, K, T, B);
C_pm = Cal_SpectralEfficiency(P_channel_pm, rho_apd, L_apd, I_b, K, T, B);


%%
set(0, 'defaultTextInterpreter', 'latex');
figure()
set(gcf,'position',[100, 100,1200, 900]) %设置画布标准大小且宽高比为四比三
set(gca,'position',[0.055 0.06 0.92 0.93])

hold on
plot(xAxis, P_in, 'LineWidth',2.2, 'color', [243 156 18]./255)
plot(xAxis, P_out_np, 'LineWidth',2.2, 'color', [52 152 219]./255,'Marker', 'p','MarkerSize',3)
plot(xAxis, P_out_pm, 'LineWidth',2.2, 'color', [231 76 60]./255,'Marker', '^','MarkerSize',3)
plot(xAxis, repelem(mean(P_out_np), length(P_out_np)), 'LineWidth',2.2, 'color', [52 152 219]./255, 'LineStyle','--')
plot(xAxis, repelem(mean(P_out_pm(1:55)), length(P_out_pm)), 'LineWidth',2.2, 'color', [231 76 60]./255, 'LineStyle','--')

h = annotation('textarrow',[0.57 0.57],[0.28 0.33]); %以左下角为原点，图画归一化的坐标 起始/终止
% 设置文本标注框中显示的字符串，并设字号为15
text(3.1,40,'Average = 31.59W', 'FontName','Times New Roman','fontSize',20)%对应实际xy坐标

h = annotation('textarrow',[0.35 0.35],[0.23 0.18]); %以左下角为原点，图画归一化的坐标 起始/终止
% 设置文本标注框中显示的字符串，并设字号为15
text(1.85,15,'Average = 24.93W', 'FontName','Times New Roman','fontSize',20)%对应实际xy坐标

% 在当前图形窗口加入带箭头的文本标注框
h = annotation('textarrow',[0.155 0.205],[0.415 0.415]); %以左下角为原点，图画归一化的坐标 起始/终止
% 设置文本标注框中显示的字符串，并设字号为15
text(1.45,50,'Maximum = 47.2W', 'FontName','Times New Roman','fontSize',20)%对应实际xy坐标


xlim([0.5 6])
set(gca,'xtick',[0.5 1 2 3 4 5 6])
xlabel('Distance [ m ]','Interpreter','latex','fontSize',20);
ylim([0 130])
ylabel('Power [ W ]','Interpreter','latex','fontSize',20); 
box on
grid on
legend( 'Input Power','Output Power w/o PB', ' Output Power with PB', 'Interpreter', 'latex','fontSize',20, 'Location', 'NorthWest')


%%
set(0, 'defaultTextInterpreter', 'latex');
figure()
set(gcf,'position',[100, 100,1200, 900]) %设置画布标准大小且宽高比为四比三
set(gca,'position',[0.048 0.07 0.9 0.91])

hold on
yyaxis left
ylim([0 10])
ylabel('Output Electric Power [ W ]','Interpreter','latex','fontSize',20); 
plot(xAxis, P_e_pm, 'LineWidth',2.2, 'color', [52 152 219]./255)
plot(xAxis, P_e_np, 'LineWidth',2.2, 'color', [52 152 219]./255, 'LineStyle','--')
% 在当前图形窗口加入带箭头的文本标注框
h = annotation('textarrow',[0.53 0.48],[0.52 0.52]); %以左下角为原点，图画归一化的坐标 起始/终止
% 设置文本标注框中显示的字符串，并设字号为15
text(2.25,4.9,'Electric Power', 'FontName','Times New Roman','fontSize',20)%对应实际xy坐标

% P_mean = mean(P_e(1:55));
% plot(xAxis, repelem(P_mean, length(P_e)), 'LineWidth',2.2, 'color', [52 152 219]./255, 'LineStyle','--');
% 在当前图形窗口加入带箭头的文本标注框
% h = annotation('textarrow',[0.53 0.48],[0.5 0.5]); %以左下角为原点，图画归一化的坐标 起始/终止
% % 设置文本标注框中显示的字符串，并设字号为15
% text(2.73,4.67,'Power', 'FontName','Times New Roman','fontSize',20)%对应实际xy坐标
% % 在当前图形窗口加入带箭头的文本标注框
% h = annotation('textarrow',[0.2 0.2],[0.55 0.5]); %以左下角为原点，图画归一化的坐标 起始/终止
% % 设置文本标注框中显示的字符串，并设字号为15
% text(1.1,4.5,'$P_{\rm mean} = 5.28 \rm W$', 'FontName','Times New Roman','fontSize',20)%对应实际xy坐标

yyaxis right
ylabel('Spectral Efficiency [ bps/Hz ]','Interpreter','latex','fontSize',20); 
plot(xAxis, C_pm, 'LineWidth',2.2, 'color', [231 76 60]./255)
plot(xAxis, C_np, 'LineWidth',2.2, 'color', [231 76 60]./255,'LineStyle','--')
h = annotation('textarrow',[0.55 0.6],[0.85 0.85]); %以左下角为原点，图画归一化的坐标 起始/终止
% 设置文本标注框中显示的字符串，并设字号为15
text(3.9,12.8,'Spectral Efficiency', 'FontName','Times New Roman','fontSize',20)%对应实际xy坐标

% C_mean = mean(C(1:55));
% plot(xAxis, repelem(C_mean, length(P_e)), 'LineWidth',2.2, 'color', [231 76 60]./255, 'LineStyle','--');
% % 在当前图形窗口加入带箭头的文本标注框
% h = annotation('textarrow',[0.78 0.83],[0.9 0.9]); %以左下角为原点，图画归一化的坐标 起始/终止
% % 设置文本标注框中显示的字符串，并设字号为15
% text(5.3,13.65,'Efficiency', 'FontName','Times New Roman','fontSize',20)%对应实际xy坐标
% % 在当前图形窗口加入带箭头的文本标注框
% h = annotation('textarrow',[0.4 0.4],[0.87 0.82]); %以左下角为原点，图画归一化的坐标 起始/终止
% % 设置文本标注框中显示的字符串，并设字号为15
% text(2.1,12,'$C_{\rm mean} = 13.25 bps/ \rm Hz$', 'FontName','Times New Roman','fontSize',20)%对应实际xy坐标

xlim([0.5 6])
set(gca,'xtick',[0.5 1 2 3 4 5 6])
xlabel('Distance [ m ]','Interpreter','latex','fontSize',20);
box on
grid on
legend( 'Output Power with PB','Output Power w/o PB', ' Spectral Efficiency with PB', ' Spectral Efficiency w/o PB', 'Interpreter', 'latex','fontSize',20, 'Location', 'SouthWest')


%%
function P_out = Cal_PowerOutput_(A_b, I_s, Vvec, Vs, g0l, Ro)
V1 = Vvec(1:4:end);
V2 = Vvec(2:4:end);
V3 = Vvec(3:4:end);
V4 = Vvec(4:4:end);
V_io = V1.*V2;
V_rt = V1 .* V2 .* V3 .* V4;
P_out = A_b .* I_s;
numerator = (1-Ro) .* V_io; % positive
denom1 = Ro .* V_rt; % positive
denom2 = sqrt(Ro .* V_rt); % negative
denom3 = 1./(V_rt .* Vs) - Vs; % negative
denominator = 1 - denom1 + denom2.*denom3;
frac = numerator ./ denominator;
P_out = P_out .* frac;

g0lThresh = abs(log(sqrt(Ro .* V_rt) .* Vs));

P_out = max(P_out .* (g0l-g0lThresh),0);

end