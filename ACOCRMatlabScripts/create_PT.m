function create_PT
    load('PerfectArial.mat');

    TF500 = [];
    TF150 = [];

    for pos=1:500
        a = mod(pos, 10);
        if a == 0
            a = 10;
        end
        if pos < 150+1
            TF150 = [TF150, Perfect(:, a)];
        end
        TF500 = [TF500, Perfect(:, a)];
    end

    save TF150;  % T150 (256x150 double
    save TF500;  % T500 (256x500 double)

    load('P1.mat');
    P50 = horzcat([],P);

    load('P2.mat');
    P100 = horzcat(P50,P);

    load('P3.mat');
    PF150 = horzcat(P100,P);

    load('P4.mat');
    P200 = horzcat(PF150,P);

    load('P5.mat');
    P250 = horzcat(P200,P);

    load('P6.mat');
    P300 = horzcat(P250,P);

    load('P7.mat');
    P350 = horzcat(P300,P);

    load('P8.mat');
    P400 = horzcat(P350,P);

    load('P9.mat');
    P450 = horzcat(P400,P);

    load('P10.mat');
    PF500 = horzcat(P450,P);

    save PF150;  % P150 (256x150 double)
    save PF500;  % P150 (256x500 double)

    clearvars P50 P100 P200 P250
    clearvars P300 P350 P400 P450
end
