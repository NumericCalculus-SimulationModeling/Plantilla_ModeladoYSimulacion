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
    LineWidth = '', ...
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

% SOLVER CONFIG
SolverTypes = {'VariableStep', };
SolverNames = {'ode45', };
StartTimes = {0, };
FixedSteps = {1, };
StopTimes = {20, };

solver_fields = {'SolverType', 'SolverName', 'StartTime', 'FixedStep', 'StopTime'};
solver_compress_fields = {SolverTypes, SolverNames, StartTimes, FixedSteps, StopTimes};
solver_compress_fields = cellfun(@string, solver_compress_fields, UniformOutput=false);

% PLOT CONFIG
Xs = {};
Ys = {};
Colors = {'', };
LineStyles = {'-', };
LineWidths = {'', };
DisplayNames = {'f(x)', };

pl_fields = {'', '', 'LineStyle', 'LineWidth', 'DisplayName', 'Color'};
pl_compress_fields = {X, Y, LineStyles, LineWidths, DisplayNames};

% SCATTER CONFIG
Xs = {};
Ys = {};
Markers = {'.', };
SizesData = {'32', };
MarkersFaceColor = {'flat', };
MarkersEdgeColor = {'flat', };
MarkersFaceAlpha = {0.5, };
MarkersFaceAlpha = {0.5, };
DisplayNames = {'f(x)', };

sc_fields = {'', '', 'Marker', 'SizeData', 'MarkerFaceColor', 'MarkerEdgeColor', 'MarkerEdgeAlpha', 'MarkerEdgeAlpha', 'DisplayName'};
sc_compress_fields = {Xs, Ys, Markers, SizesData, MarkersFaceColor, MarkersEdgeColor, MarkersEdgeAlpha, MarkersEdgeAlpha, DisplayNames};
sc_compress_fields = cellfun(@string, sc_compress_fields, UniformOutput=false);

% XLABEL CONFIG
txts = {'$x$', };
Interpreters = {'latex', };

xlabel_fields = {'', 'Interpreter', };
xlabel_compress_fields = {txts, Interpreters, };

% YLABEL CONFIG
txts = {'$y$', };
Interpreters = {'latex', };

ylabel_fields = {'', 'Interpreter', };
ylabel_compress_fields = {txts, Interpreters, };

% TITLE CONFIG
txts = {'$y = f(x)$', };
Interpreters = {'latex', };

titlelabel_fields = {'', 'Interpreter', };
titlelabel_compress_fields = {txts, Interpreters, };


% GROUP CONFIG PARAMETERS INTO SINGLE CONFIGS
solver_configs = group_data(solver_fields, solver_compress_fields);
pl_configs = group_data(pl_fields, pl_compress_fields);
sc_configs = group_data(sc_fields, sc_compress_fields);
xlabel_configs = group_data(xlabel_fields, xlabel_compress_fields);
ylabel_configs = group_data(ylabel_fields, ylabel_compress_fields);
titlelabel_configs = group_data(titlelabel_fields, titlelabel_compress_fields);

% COMPRESS CONFIGS
compress_configs = {solver_configs, pl_configs, xlabel_configs, ylabel_configs, title_configs};
config_types = {'solver', 'plot', 'scatter', 'xlabel', 'ylabel', 'title'};

cfg = group_configs(config_types, compress_configs);

function cfg = group_configs(config_types, compress_configs)
% Join configs into a base config (cfg)
% Example: cfg.plot{3}{:} returns all args for plot config in index 3 of plot configs
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
        cfg.(config_types(i)) = compress_configs{i};
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