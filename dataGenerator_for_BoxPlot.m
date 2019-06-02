%% Choose the changing parameters: c1, c3 or c4
variable = 'c1';
%% Choose the phase: phase3, phase2
phase = 'phase3';

choice = [variable,'_', phase];

switch choice
    case 'c1_phase3'
        Varying_c1_phase3; % this will generate data:AllData_varyingc1_totBreath1_phase3.mat
    case 'c1_phase2'
        Varying_c1_phase2;  %this will generate data: AllData_varyingc1_totBreath1_phase2.mat
    case 'c3_phase3'
        Varying_c3_phase3;
    case 'c3_phase2'
        Varying_c3_phase2;
    case  'c4_phase3'
        Varying_c4_phase3;
    otherwise 
        warning('Wrong Choice')
end