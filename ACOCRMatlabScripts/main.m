%
%   Machine Learning - Optical caracther recognition
%   Main program
%

function main
    % With Associative Memory = 1
    % With Associative Memory = 2
    initial_user_option = menu('Neural network architecture:',...
        'With Associative Memory',...
        'Without Associative Memory');

    save('user_option.mat','initial_user_option');

    % 150 test cases = 1
    % 500 test cases = 2
    n_test_cases = menu(...,
        'Number of test cases:',...
        '500 test cases',...
        '150 test cases');

    save('n_test_cases.mat','n_test_cases');
    
    
    if initial_user_option == 1
        switch n_test_cases
            case 1
                %P_ = load('PF500.mat');
                %T_ = load('TF500.mat');
                load('PF500.mat');
                load('TF500.mat');

                % training data to feed the associative memory
                in_data = PF500;
                out_data = TF500;
                disp('::loaded PF150 and TF150 test cases')
            case 2
                %P_ = load('PF150.mat');
                %T_ = load('TF50.mat'); 
                load('PF150.mat');
                load('TF150.mat');

                % training data to feed the associative memory 
                in_data = PF150;
                out_data = TF150;
                disp('::loaded PF500 and TF500 test cases')
        end

        % associative memory's type of train:
        % Pseudoinverse or Hebb's rule,
        % transpose weighting method
        % (Slides 127 and 128 ACChapter4SingleLayerNN16EN)
        % method_user_option = menu(...,
        %    'Associative memory''s type of train:',...
        %    'Transpose weighting method ',...
        %    'Pseudoinverse weighting method'); 
        method_user_option = 2;
        switch method_user_option
            case 1
                f = 'transpose_method_result.mat';
            case 2
                f = 'pseudoinverse_method_result.mat';
        end
        
        % save the user's choice type of training
        save('user_choice_training_for_AM.mat', 'method_user_option');
       
        result_AM = train_associative_memory(in_data, out_data,...
            method_user_option);
        
        save(f, 'result_AM');
        
    end
    
    option = menu('Load pre-data?','Yes','No');
    
    test_data = load('user_input.mat');
    test = test_data.P;
    temp = zeros(256,50);
    temp(:,1:50) = test;
    
    
    data.X = temp;
    
    
    if option == 1
        ocr_fun(data);
    else
        mpaper();
    end
    % Allows the user to enter handwritten characters
    %mpaper();

    %  Clear variables and functions from memory
    clear;
end
