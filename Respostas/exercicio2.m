% === Passo 1: Leitura dos dados do arquivo CSV ===
data = dlmread('temperatura.csv', ',', 1, 0);  % Lê o arquivo ignorando o cabeçalho (começa da 2ª linha)

% === Passo 2: Separação das colunas ===
hora = data(:,1);           % Coluna 1 representa a hora do dia (ex: 0 a 23)
temperatura = data(:,2);    % Coluna 2 representa a temperatura registrada naquela hora

% === Simulando variação de temperatura ao longo de 5 dias ===
[dia, hora_mesh] = meshgrid(1:5, hora);  
% Cria uma grade de valores onde:
% 'dia' vai de 1 a 5 (representando 5 dias)
% 'hora_mesh' replica o vetor de horas para cada dia

% Criação de matriz com variações leves por dia
temperatura_mesh = repmat(temperatura, 1, 5) + rand(size(hora,1), 5) * 0.6;
% Repete a mesma sequência de temperatura para cada um dos 5 dias
% e adiciona uma variação aleatória entre 0 e 0.6 em cada valor

% === Plotagem do gráfico 3D (malha colorida de temperatura) ===
figure;
surf(hora_mesh, dia, temperatura_mesh);  
% Cria um gráfico de superfície tridimensional (X: hora, Y: dia, Z: temperatura)

title('Plano de Temperatura 3D', 'fontsize', 14, 'fontweight', 'bold');  
% Define o título do gráfico com fonte maior e em negrito

xlabel('Hora do Dia', 'fontsize', 12, 'fontweight', 'bold');  % Rótulo do eixo X
ylabel('Dia', 'fontsize', 12, 'fontweight', 'bold');          % Rótulo do eixo Y
zlabel('Temperatura (°C)', 'fontsize', 12, 'fontweight', 'bold');  % Rótulo do eixo Z

colormap(jet);     % Define a paleta de cores "jet", com tons vivos do azul ao vermelho
shading interp;    % Suaviza as faces da superfície (sem bordas entre as células)
colorbar;          % Exibe barra lateral com a escala de cores (referência visual)
grid on;           % Ativa a grade no gráfico para facilitar a leitura visual
