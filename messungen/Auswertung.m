file = 'Messung2.csv';
file = 'Messung3.csv';
file = 'Messung4.csv';
bsaveplot = true;

if(strcmp('Messung2.csv',file))  
    M = csvread(file,6);
    %A = csvread('Messung2.csv',5,1,[5 1 5 4]);
    M = M(1:28464,:);
    timeoffset = 17.5*3600;
    voltage = M(end:-1:1,3);
    current = M(end:-1:1,4);
    time = mod(timeoffset-M(end:-1:1,1),24*3600)/3600;
end


if(strcmp('Messung3.csv',file))
    M = csvread(file,6);
    M = M(1:2644,:);
    timeoffset = 9.25*3600;
    voltage = M(end:-1:1,3);
    current = M(end:-1:1,5);
    time = mod(timeoffset-M(end:-1:1,1),24*3600)/3600;
end


if(strcmp('Messung4.csv',file))    
    M = csvread(file,6);
    M = M(1:73000,:);
    timeoffset = 19*3600;
    voltage = M(end:-1:1,3);
    current = M(end:-1:1,5);
    time = mod(timeoffset-M(end:-1:1,1),24*3600)/3600; 
end

energy = sum(voltage.*current)/3600;
energy_in = sum(voltage(current>0).*current(current>0))/3600;

disp(['Energy total: ',num2str(energy,4),' Wh']);
disp(['Energy in: ',num2str(energy_in,4),' Wh']);
disp(['Current max: ',num2str(max(current)*1000,4),' mA']);


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
energy_in = sum(voltage(current>0).*current(current>0))/3600;

text(0.05,0.9,['Energy: ',num2str(energy,4),' Wh', char(10)...
'Current max: ',num2str(max(current)*1000,3),' mA'],'units','normalized', 'VerticalAlignment', 'Top');

if(bsaveplot)
    print(figure(1),'-dpng',['./figures/', file(1:8),'','.png'],'-r500');
end

