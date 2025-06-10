function Current_Control(com,cur,state)
%str = "SOUR:CURR" + " " + string(cur);
Ilimit = 3e-3;
if cur > Ilimit
    cur = Ilimit;
elseif cur < - Ilimit
    cur = -Ilimit;
else
end
    
attempt = 5;
seconds = 2;
for rep = 1:attempt
    try
        s = serialport(com,9600);
        %id = writeread(s,"*IDN?");
        %id = readline(s);
        configureTerminator(s,"LF");
        writeline(s,"SOUR:CURR:RANG:AUTO ON");
        writeline(s,"SOUR:CURR " + string(cur));
        writeline(s,"OUTP " + state);
        clear s;
        %fprintf('Instrument Name: %s\n',id);
        fprintf('Instrument Port: %s\n',com);
        fprintf('Output Current: %f A\n',cur);
        fprintf('Output State: %s\n',state);
        disp('Connection established and output set!');
        break;
    catch
        disp('Trying to connect ...');
        
        if rep == attempt
            disp('Could not establish connection!');
        end
        pause(seconds);
    end
end
end
