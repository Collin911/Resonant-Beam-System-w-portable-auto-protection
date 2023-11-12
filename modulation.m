x = 0:pi/20:4*pi;
y1 = sin(x);
Amp = [];
HAmp = []
IAmp = [];
TAmp = [];
dxs = [0:pi/12:2*pi];
for dx=dxs
    y2 = sin(x+dx);
    y3 = sin(x+dx+pi);
    y4 = sin(x+dx+3*pi/2);
    y5 = sin(x+dx+pi/2);
    Amp = [Amp max(y1+y2)];
    IAmp = [IAmp max(y1+y3)];
    TAmp = [TAmp max(y1+y4)];
    HAmp = [HAmp max(y1+y5)];
end
figure;
plot(dxs, Amp, 'linewidth', 1.5);
hold on
plot(dxs, IAmp, 'linewidth', 1.5);
plot(dxs, TAmp, 'linewidth', 1.5);
plot(dxs, HAmp, 'linewidth', 1.5);
xticks([0,pi/2,pi,3*pi/2,2*pi]);    %位置指定为向量
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'});%关联的标签，用cell指定刻度标签
thresh = ones(size(dxs)) * sqrt(2);
plot(dxs, thresh, 'linewidth',1.5);
p = ones(size(dxs)) * 1.6;
plot(dxs, p, 'linewidth',1.5);
legend('Superimposed Amplitude', 'Modulated Amplitude 1#', 'Modulated Amplitude 2#', 'Modulated Amplitude 3#', 'Phase Inversion Boarder')