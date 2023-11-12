figure;
subplot(2,2,1)
hold on
plot(xAxis, V_pb, 'linewidth', 1.5);
plot(xAxis, V_pbm, 'linewidth', 1.2);
plot(xAxis, V_np, 'linewidth', 1.2);
legend('Transfer Efficiency with PB', 'Transfer Efficiency with mPB', 'Transfer Efficiency without PB');
hold off
title("Transfer Efficiency");

subplot(2,2,2)
% ER = Cal_EquivalentReflect(opd, lambda, 0, Ros, Rps, V_pb, 0, 0)
title("Reflectivity");
hold on
plot(xAxis, ER, 'linewidth', 1.5)
% ERm = Cal_EquivalentReflect(opd, lambda, 0, Ros, Rps, V_pb, 1, 0.63)
plot(xAxis, ERm, 'linewidth', 1)
plot(xAxis, Ros)
% plot(xAxis, ones(size(xAxis) * 0.63)
hold off
legend('Equivalent Reflectivity','Modulated Reflectivity','Physical Reflectivity')%,'Designated Threshold')

subplot(2,2,3)

% T = Cal_PowerThresh(1, ER, V_pb, 1, 0.99, eta_excit, S_pb,12600000);
% Tm = Cal_PowerThresh(1, ERm, V_pb, 1, 0.99, eta_excit, S_pb,12600000);
% To = Cal_PowerThresh(1, Ros, V_np, 1, 0.99, eta_excit, S_np,12600000);
plot(xAxis, ThreshP, 'linewidth', 1.5);
hold on
plot(xAxis, ThreshPm, 'linewidth', 1);
plot(xAxis, ThreshNP, 'linewidth', 1.2);
legend('Power Threshold With PB', 'Power Threshold With MPB','Power Threshold Without PB');
hold off
title("Power Threshold");
