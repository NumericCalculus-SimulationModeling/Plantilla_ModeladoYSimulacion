%% Ejercicio 1: Ecuación Van der Pol
% Limpieza del entorno de trabajo

clear % clear workspace variables
clc % clear command line
close all % close all figures
beep off % Supress running model sound
% Procedimiento
% Este script configura automáticamente para un modelo discreto los principales 
% parámetros necesarios para simular, dibujar y etiquetar. Se deben definir los 
% parámetros de la configuración a continuación:
% Planteamiento
% $${x^{\prime } }^{\prime } =-\left(x^2 -1\right){\;x}^{\prime } -x$$
% Configuración usuario
% Constantes del modelo

% Initial conditions
dx0 = 0.25; % x'(0) = 0.25
x0 = 1; % x(0) = 1

% Global constants
% Example: g = 9.8

% Nombre del modelo

model_name = "Ejer1_EcVanDerPol";

% Configuración del solver

solver = struct();
solver.type = "Variable-Step";
solver.name = "VariableStepAuto";
solver.start = 0;
solver.stop = 20;
%solver.step = 1;

% Configuración dibujos gráfica

graph = "plot"; % draw function used

% scatter settings
sc = struct();
sc.sz = 200; % size
sc.mkr = "."; % marker
sc.transparency = 0.5; % transparency

% plot settings
pl = struct();
pl.linespec = "-"; % linestyle/marker/color
pl.mkr.sz = 12; % marker size

% Configuración etiquetas gráfica

labels = struct();
% xlabel settings
labels.x.name = "t"; 
labels.x.interpreter = "latex";

% ylabel settings
labels.y.name = "x(t)";
labels.y.interpreter = "latex";

% title settings
labels.title.name = "Simulación Ec de Van der Pol";
labels.title.interpreter = "none";
% Ejecución simulación (Automática)
% Al final de este livescript se encuentra la definición de la función sim_config, 
% función que simula el modelo de nombre model_name para una configuración de 
% solver almacenada en el struct solver

sim_data = sim_config(model_name, solver); % End of file definition

% De sim_data se extrae la información de la simulación gracias a bloques output 
% (véase consideraciones adicionales Simulink al final de este LiveScript)
% 
% Obtenemos un data set con las señales del campo yout

signals = sim_data.yout; % Dataset container of signals
num_signals = numElements(signals); % Number of signals

% Se dibuja cada señal

% Draw each signal
hold on
for i = 1:num_signals
    signal = signals{i}.Values;
    if graph == "scatter"
        scatter(signal.Time, signal.Data, sc.sz, sc.mkr, ...
            MarkerEdgeAlpha=string(sc.transparency), ...
            DisplayName=signal.Name);
    elseif graph == "plot"
        plot(signal.Time, signal.Data, pl.linespec, ...
            MarkerSize=pl.mkr.sz, ...
            DisplayName=signal.Name);
    elseif graph == "none"
        break
    else
        break
    end
end
xlim([signal.Time(1), signal.Time(end)]);
legend('show','location','best');
set_labels(labels)
grid on
hold off
%% Funciones disponibles para todas las secciones:
% MATLAB permite utilizar la última sección de un livescript para definir funciones 
% globales.

function sim_data = sim_config(model_name, solver)
% Decorador de la función sim de MATLAB
% Esta función ejecuta la función sim, tras establecer los parámetros del solver. 
% Recibe como argumentos el nombre del modelo y un struct con la configuración 
% del solver.
% 
% Carga del modelo con load_system
% 
load_system(model_name)
% open_system(model_name) will also open it
% 
% Configuración con set_param
% 
% Set solver parameters
set_param(model_name, ...
    SolverType  = solver.type, ...
    SolverName  = solver.name, ...
    StartTime   = string(solver.start),...
    StopTime    = string(solver.stop))%, ...
    %FixedStep   = string(solver.step) ...
    %)
% More model parameters can be retrieved with:
% model_data = get_param(model_name, "ObjectParameters")
% Access blocks params with "model_name/block_name"
% 
% Simulación del modelo con sim
% 
sim_data = sim(model_name);
% SimulationMode="normal" by default
end

function set_labels(labels)
% Configuración xlabel, ylabel, title de MATLAB
% Esta función configura las etiquetas de la figura actual. Recibe una variable 
% struct con la configuración de las etiquetas.
title(labels.title.name, Interpreter=labels.title.interpreter)
xlabel(labels.x.name, Interpreter=labels.x.interpreter);
ylabel(labels.y.name, Interpreter=labels.y.interpreter);
end

% Consideraciones adicionales Simulink
% Se utiliza el bloque Out1 para cada señal debido a que:
% 
% * No usaremos bloques Bus para no formatear los nombres, ejemplo: MATLAB transforma 
% '+' a '_'
% * No usaremos bloques To Workspace para iterar más fácil, iteramos el contenido 
% de .yout
% * Es posible el manejo de múltiples condiciones iniciales sin problema
% Scripts adicionales
% Para obtener cada señal se puede usar: 
%
% signals{index}
% signals.getElement('signal_name')
%
% Los valores de una señal se encuentran en el campo Values
%
% signals{index}.Values.Data
% signals{index}.Values.Time
% signals{index}.Values.Name
%
% Inicio y fin de una señal
% 
% sim_data = sim_config(model_name, solver)
% signals = sim_data.yout
% 
% start_value = signals{1}.Values.Data(1);
% end_value = signals{1}.Values.Data(end);
% 
% Máximo y mínimo de una señal
% 
% sim_data = sim_config(model_name, solver)
% signals = sim_data.yout
% 
% [signal_max, index_max] = max(signals{1}.Values.Data);
% point_max = [signals{1}.Values.Time(index_max), signal_max];
% 
% [signal_min, index_min] = min(signals{1}.Values.Data);
% point_min = [signals{1}.Values.Time(index_min), signal_min];
% 
% Media de una señal
% 
% sim_data = sim_config(model_name, solver)
% signals = sim_data.yout
% 
% signal_mean = mean(signals{1}.Values.Data)
% 
% Autor: Alfredo Robledano Abasolo 3ºB Ingeniería Matemática UFV (2023-2024)