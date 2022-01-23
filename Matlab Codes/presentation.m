figure(2);
bitSNRdB = 0:0.5:8;
pbErrBSC = pBitError(2,:);
pbErrAWGN = pBitError(3,:);
semilogy(bitSNRdB,pbErrBSC,'o-','linewidth',2,'markerfacecolor','b','markeredgecolor','b');
hold on; semilogy(bitSNRdB,pbErrAWGN,'^-','linewidth',2,'color',[0 0.5 0],'markerfacecolor',[0 0.5 0],'markeredgecolor',[0 0.5 0]);
hold on; xlabel('SNR per Bit in dB'); ylabel('Probability of Bit Error'); grid
axis([0 8 1e-7 1]); set(gca,'xtick',0:0.5:8)
