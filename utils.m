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

% SOLVER EXAMPLE



% % PLOT EXAMPLE
% x = [1, 2, 3]; 
% y = [5, 2, 5];

% my_plot_pos_args = {x, y};

% my_plot_named_args = pl_named_args;
% my_plot_named_args.LineStyle = '--';
% my_plot_named_args.DisplayName = 'f(x)';

% my_plot_args = combine_args(my_plot_pos_args, my_plot_named_args);

% % LABELS EXAMPLE
% my_labels_pos_args = {'x', 'my_function f(x)', 'My Title $e^{i\pi} - 1 = 0$'};
% my_labels_named_args = labels_named_args;
% my_labels_named_args.y.Interpreter = 'none';

% my_labels_args = combine_labels_args(my_labels_pos_args, my_labels_named_args);

% PLOT CONFIG
X = {};
Y = {};
Colors = {'', };
LineStyles = {'', };
LineWidths = {'', };
DisplayNames = {'', };

pl_fields = {'', '', 'LineStyle', 'LineWidth', 'DisplayName', 'Color'};
pl_compress_fields = {X, Y, LineStyles, LineWidths, DisplayNames};

% XLABEL CONFIG
txt = {'', };
Interpreters = {'', };

xlabel_fields = {'', 'Interpreter', };
xlabel_compress_fields = {txt, Interpreters, };

xlabel_configs = group_data(xlabel_fields, xlabel_compress_fields);

% YLABEL CONFIG
txt = {'', };
Interpreters = {'', };

xlabel_fields = {'', 'Interpreter', };
xlabel_compress_fields = {txt, Interpreters, };

xlabel_configs = group_data(xlabel_fields, xlabel_compress_fields);

% TITLE CONFIG
txt = {'', };
Interpreters = {'', };

xlabel_fields = {'', 'Interpreter', };
xlabel_compress_fields = {txt, Interpreters, };


% GROUP CONFIG PARAMETERS INTO SINGLE CONFIGS
pl_configs = group_data(pl_fields, pl_compress_fields);
xlabel_configs = group_data(xlabel_fields, xlabel_compress_fields);

% COMPRESS CONFIGS
compress_configs = {solver_configs, pl_configs, xlabel_configs, ylabel_configs, title_configs};
config_types = {'solver', 'plot', 'scatter', 'xlabel', 'ylabel', 'title'};


function cfg = group_configs(config_types, compress_configs)
% Join configs into a base config (cfg)
% Example: cfg.pl{3}{:} returns all args for plot config in index 3 of plot configs
% INPUTS
% ------------------------------------------
% config_types = cell array
% configs = cell array of cell arrays
%
% OUTPUTS
% ------------------------------------------
% cfg = struct of cell arrays
    cfg = struct()
    for i=1:length(config_types)
        cfg.(config_types(i)) = configs{i};
    end
end







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

function labels_args = combine_labels_args(labels_pos_args, labels_named_args)
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

function grouped_data = group_data(field_names, compress_fields)
% Group named args
% INPUTS
% ------------------------------------------
% field_names = cell array
% compress_fields = cell array of cell arrays
%
% OUTPUTS
% ------------------------------------------
% grouped_data = cell array of cell arrays
    n = max(cellfun(@length, compress_fields));
    m = length(field_names);
    grouped_data = cell(1, n);
    for i = 1:n
        group_i = cell(1, m);
        for j = 1:m
            try
                value = compress_fields{j}{i};
                field = field_names(j);
            
                if isempty(value)
                    continue
                end
                if isempty(field{1})
                    group_i{j} = value;
                else
                    group_i{j} = [field, value];
                end
            catch
                continue
            end
        end
        grouped_data{i} = horzcat(group_i{:});
    end
end