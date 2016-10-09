% 
% sequencing function call:
%       main.m -> mpaper.m -> ocr_fun.m -> myclassify.m
% 
% @data - the numbers drawn by the user
% @filled - indexes not used from the squares
%
%
function ret = myclassify(data, filled)
    
    % clean empty squares
    % basically, to provide a good classsification we only want the 
    % filled squares that were drawn by the user using the mouse. 
    % Empty spaces are not considered.
    data = data(:,filled);
    
    % did the user choose associative memory or not?
    % load the user's option (main.m : line 13)
    load('user_option.mat');
    if initial_user_option == 1
        load('user_choice_training_for_AM');
        if method_user_option == 1
            load('transpose_method_result.mat');
        else
            load('pseudoinverse_method_result.mat');
        end
        
        % 'correct' or 'filter' the input 
        %             ______________
        %            |              |
        %  input     | Associative  |  
        % ---------> |   memory     | 
        %            |______________| 
        data = result_AM * data;
    end
    
    
    
    func = menu('Choose the activation function:',...
        'Hardlim - Hard-limit transfer function',...
        'Logsig - Log-sigmoid transfer function',...
        'Purelin - Linear transfer function');
        
    % activation function and Learning Method
    % The neural network parameters should be evaluated using the
    % perceptron rule (learnp), if harlim is used, or the gradient method
    % (learngd) if purlin or logsig are used"
    switch func
        case 1
            activation_function_name = 'hardlim';
            learning_method_name = 'learnp';
        case 2
            activation_function_name = 'logsig';
            learning_method_name = 'learngd';
        case 3
            activation_function_name = 'purelin';
            learning_method_name = 'learngd';            
    end
    
    load('user_choice_training_for_AM.mat');
    load('n_test_cases.mat');
    
    % nn_name = neural network name
    if initial_user_option == 1
        nn_name = 'nn_with_am';
    else
        nn_name = 'nn_without_am';
    end
    
    % create and train the new neural network
    % this calls the function avaliable at neural_network.m
    new_nn = neural_network(activation_function_name,learning_method_name);
    save(nn_name, 'new_nn');
    
    % Simulate a neural network.
    % Builtin function avaliable from the Neural Network Toolbox (MATLAB)
    network_output = sim(new_nn, data);
    
    [~, number_of_cases] = size(data);
    
    
    ret = -ones(1, number_of_cases);
    
    for pos = 1:number_of_cases
        result = find(network_output(:,pos) == max(network_output(:,pos)));
        
        if length(result) == 1
            ret(pos) = result(1); 
        end
    end   
    
end