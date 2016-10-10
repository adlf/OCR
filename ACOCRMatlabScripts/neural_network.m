% createes a new neural network

function neural_net = neural_network(activation_function, learning_method, flag)
    
    
    % let's see what did the user choose: with AM or without
    load('user_option.mat');
    % data to train the neural network
    load('n_test_cases.mat');
    if n_test_cases == 1
        str = 'PF500.mat';
        load(str);
        network_input = PF500;
    else
        str = 'PF150.mat';
        load(str);   
        network_input = PF150;
    end
     
    
    [N, number_of_cases] = size(network_input);
    
    % if he choose AM
    if initial_user_option == 1
        load('user_choice_training_for_AM.mat');
        
        % associative memory type of training 
        if method_user_option == 1
            load('transpose_method_result.mat');
        else
            load('pseudoinverse_method_result.mat');
        end
        
        % filter or correct the input in the AM
        network_input = result_AM * network_input;
    end
   

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % perceptron creation to solve our classification problem
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % It is assumed that the classifier (a neural network) has
    % one single layer with 10 neurons (one for each class)
	%Set network parameter (number of distincted classes)
	number_neurons = 10;
    
    % -- newp function description --
    % NET = newp(P,T,TF,LF) takes these inputs,
    %      P  - RxQ matrix of Q1 representative input vectors.
    %      T  - SxQ matrix of Q2 representative target vectors.
    %      TF - Transfer/activation function, default = 'hardlim'.
    %      LF - Learning function, default = 'learnp'.
	neural_net = newp(ones(N,1)*[0 1], number_neurons ,...
        activation_function, learning_method);
	%Define the network properties
	W = 0.2*rand(10,256);
	b = 0.2*rand(10,1);
	neural_net.IW{1,1} = W;
	neural_net.b{1,1} = b;

	%Define training parameters
	neural_net.performParam.lr = 0.5;    % learning rate
	neural_net.trainParam.epochs = 1000; % maximum epochs
	neural_net.trainParam.show = 35;     % show
	neural_net.trainParam.goal = 1e-6;   % goal=objective
	neural_net.performFcn = 'sse';       % criterion
    
    % if the user chose the first test case
    if n_test_cases == 1
        new_str = 'TF500.mat';
        load(new_str);
        comp = TF500;
    % or the second one
    else
        new_str = 'TF150.mat';
        load(new_str);
        comp = TF150;
    end
    
    network_target = zeros(10, number_of_cases);
   
    load('PerfectArial.mat');
    for tmp=0:number_of_cases-1
        for column=0:10-1
            if (Perfect(:,column + 1) == comp(:,tmp + 1))
                network_target(column + 1, tmp + 1) = 1;
                break
            end
        end
    end
    
    % Train it
    % Builtin function from Neural network toolbox (MATLAB)
    neural_net = train(neural_net, network_input, network_target);
    
    
    if flag == 1
        load('user_input.mat')
        showim(P)
    end
end