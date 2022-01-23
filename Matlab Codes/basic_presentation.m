gammaDB = 0:0.5:8;
gammaLin = 10.^(gammaDB/10);
p = [0.1587    0.1447    0.1309    0.1173    0.1040    0.0912    0.0789    0.0673    0.0565    0.0466    0.0377    0.0298    0.0230    0.0173    0.0126    0.0089    0.0060];
D1 = exp(-(gammaLin*(1/2)));
D2 = sqrt(4*p.*(1-p));
y1 = D1.^5./((1-2*D1).^2);
y2 = D2.^5./((1-2*D2).^2);
pbErrBSC = y2;
pbErrAWGN = y1;
semilogy(bitSNRdB,pbErrBSC,'o:','linewidth',2,'markerfacecolor','b','markeredgecolor','b');
hold on; semilogy(bitSNRdB,pbErrAWGN,'^:','linewidth',2,'color',[0 0.5 0],'markerfacecolor',[0 0.5 0],'markeredgecolor',[0 0.5 0]);
hold on; 
axis([0 8 1e-7 1]); set(gca,'xtick',0:0.5:8)

