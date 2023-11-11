clear, clc
LineStyles = {'--', };
LineWidths = {};
DisplayNames = {'Hello', };
Colors = {'b'};
Y = {};

pl_fields = {'', 'LineStyle', 'LineWidth', 'DisplayName'};
pl_compress_fields = {Y, LineStyles, LineWidths, DisplayNames};

pl = group_data(pl_fields, pl_compress_fields);
my_cell = {}
plot([1, 2, 3], my_cell{:})

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