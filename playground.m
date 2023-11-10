clear, clc
% scatter([1, 2, 3], [5, 2, 5], 100, '.', ...
%     MarkerEdgeAlpha='0.5', ...
%     DisplayName='Prueba');
% 
% p = struct(MarkerEdgeAlpha='0.5', DisplayName='Pruebac');
% p = namedargs2cell(p);
% scatter([1, 2, 3], [5, 2, 5], 100, '.', ...
%     p{:});
% positional_args = {[1, 2, 3], [5, 2, 5], 100, '.'};
% keyword_args = struct(MarkerEdgeAlpha='0.5', DisplayName='Prueba');
% 
% sc_args = [positional_args, namedargs2cell(keyword_args)]
% 
% scatter(sc_args{:});    
% solver = struct( ...
%     SolverName = [], ...
%     SolverType = [], ...
%     StartTime = [], ...
%     FixedStep = [], ...
%     StopTime = [] ...
% );
% namedargs2cell(solver)

% plot([1, 2, 3], [5; 2; 5], LineStyle='none', Marker=".", MarkerSize=100, MarkerEdgeColor=[0.5, 0.5, 0.5, 0.01])
% plot([1, 2, 3], [5, 2, 5], '.-', LineWidth=1)
% scatter([1, 2, 3], [5, 2, 5], ...
%     Marker='default', ...
%     MarkerFaceColor='default', ...
%     MarkerEdgeColor='default', ...
%     MarkerFaceAlpha='default', ...
%     DisplayName='', ...
%     SizeData=32)

% plot([1, 2, 3], [5, 2, 5], Color='default')
% hold on
% plot([1, 2, 3], LineStyle='-')
run('utils')
plot(my_plot_args{:}, Color='g')
my_labels_args;
set_labels(my_labels_args)

function set_labels(labels)
% Set label parameters
% INPUTS
% ------------------------------------------
% labels = struct

title(labels.title{:})
xlabel(labels.x{:});
ylabel(labels.y{:});

end


