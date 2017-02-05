file = 'Messung2.csv';
bplot = true;

if(strcmp('Messung2.csv',file))
    
    M = csvread('Messung2.csv',6);
    %A = csvread('Messung2.csv',5,1,[5 1 5 4]);
    M = M(1:28464,:);
    timeoffset = 17.5*3600;
    voltage = M(end:-1:1,3);
    current = M(end:-1:1,4);
    time = mod(timeoffset-M(end:-1:1,1),24*3600)/3600;

    figure(1),clf
    subplot(2,1,1)
    plot(time,voltage,'.')
    xlabel('Time')
    ylabel('Battery Voltage (V)')
    text(0.05,0.9,['Voltage min-max: ',num2str(min(voltage),4),' - ',...
        num2str(max(voltage),4),' V'],'units','normalized', 'VerticalAlignment', 'Top');
    
    
    subplot(2,1,2)
    plot(time,current*1000,'.','color','r')
    xlabel('Time')
    ylabel('Battery Current (mA)')

    energy = sum(voltage.*current)/3600;
    disp(['Energy: ',num2str(energy,4),' Wh']);
    disp(['Current max: ',num2str(max(current),4),' A']);
    
    text(0.05,0.9,['Energy: ',num2str(energy,4),' Wh', char(10)...
    'Current max: ',num2str(max(current),4),' A'],'units','normalized', 'VerticalAlignment', 'Top');
    
    if(bplot)
    print(figure(1),'-dpng',['./figures/', file(1:8),'','.png'],'-r500');
    end
end