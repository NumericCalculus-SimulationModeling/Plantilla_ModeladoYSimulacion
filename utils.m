model_names = [];

solver = struct( ...
    SolverType = 'Variable-Step', ...
    SolverName = 'ode45', ...
    StartTime = 0, ...
    FixedStep = 1, ...
    StopTime = 20 ...
);

pl_named_args = struct( ...
    LineStyle = '-', ...
    LineWidth = 'default', ...
    DisplayName = '' ...
);

sc_named_args = struct( ...
    Marker = '.', ...
    SizeData = 32, ...
    MarkerFaceColor = 'flat', ...
    MarkerEdgeColor = 'flat', ...
    MarkerFaceAlpha = '0.5', ...
    MarkerEdgeAlpha = '0.5', ...
    DisplayName = '' ...
);
% Notes:
% Color=Value not specified in order to get default colors (can't get in other way)
% No keyword argument for points values (not available)
% For custom color add keyword argument Color or append to Linestyle/Marker in each case

label_default = struct(Interpreter='latex');
labels_named_args = struct( ...
    x = label_default, ...
    y = label_default, ...
    title = label_default);
% Note:
% No keyword argument for text (not available)

% PLOT EXAMPLE
x = [1, 2, 3]; 
y = [5, 2, 5];

my_plot_pos_args = {x, y};

my_plot_named_args = pl_named_args;
my_plot_named_args.LineStyle = '--';
my_plot_named_args.DisplayName = 'f(x)';

my_plot_args = combine_args(my_plot_pos_args, my_plot_named_args);

% LABELS EXAMPLE
my_labels_pos_args = {'x', 'my_function f(x)', 'My Title $e^{i\pi} - 1 = 0$'};
my_labels_named_args = labels_named_args;
my_labels_named_args.y.Interpreter = 'none';

my_labels_args = combine_labels(my_labels_pos_args, my_labels_named_args);















function args = combine_args(positional_args, named_args)
% Combine positional and keyword arguments
% Useful when passing to a function as args{:}
% INPUTS
% ------------------------------------------
% positional_args = cell array
% named_args = struct
%
% OUTPUTS
% ------------------------------------------
% args = cell array
    args = [positional_args, namedargs2cell(named_args)];
end

function labels_args = combine_labels(labels_pos_args, labels_named_args)
% Group labels args
% INPUTS
% ------------------------------------------
% labels_pos_args = cell array
% labels_named_args = struct of structs
%
% OUTPUTS
% ------------------------------------------
% labels_args = struct of cell arrays
    label_types = {'x', 'y', 'title'};
    labels_args = struct();
    for i = 1:length(label_types)
        type = label_types{i};
        labels_args.(type) = combine_args(labels_pos_args{i}, labels_named_args.(type));
    end
end