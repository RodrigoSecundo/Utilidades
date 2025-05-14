% === Passo 1: Leitura dos dados da planilha Excel ===
pkg load io  % Carrega o pacote necessário para ler arquivos .xlsx
[~, ~, raw] = xlsread('controle_estoque.xlsx');  % Lê todos os dados (inclusive texto e números)

% Extração dos dados, ignorando a primeira linha (cabeçalho)
produtos     = raw(2:end, 1);         % Coluna 1: nomes dos produtos
quantidades  = cell2mat(raw(2:end, 2));  % Coluna 2: converte as quantidades (células) em números
valores      = cell2mat(raw(2:end, 3));  % Coluna 3: converte os valores unitários em números

% === Passo 2: Cálculo do total por produto ===
totais = quantidades .* valores;  % Multiplica quantidade pelo valor para obter total por produto

% === Passo 3: Salvando os dados em arquivo .mat ===
save('dados_calculados.mat', 'produtos', 'quantidades', 'valores', 'totais');  
% Salva os vetores em um arquivo MATLAB/Octave para uso posterior

% === Passo 4: Criando nova planilha com a coluna "Total" ===
nova_tabela = [produtos, num2cell(quantidades), num2cell(valores), num2cell(totais)];
% Cria uma célula combinando os dados e os totais calculados

cabecalho = {'Produto', 'Quantidade', 'Valor', 'Total'};  % Cabeçalho da nova planilha

% Escreve o cabeçalho e os dados na nova planilha
xlswrite('controle_com_total.xlsx', cabecalho, 1, 'A1');  % Cabeçalho na primeira linha
xlswrite('controle_com_total.xlsx', nova_tabela, 1, 'A2');  % Dados a partir da segunda linha

% === Passo 5: Plotando gráfico de colunas com os totais por produto ===
figure;
bar(totais);  % Cria um gráfico de barras com os totais
set(gca, 'xtick', 1:length(produtos), 'xticklabel', produtos);  % Define os rótulos do eixo x
xtickangle(45);  % Gira os nomes dos produtos para facilitar a leitura
ylabel('Total (R$)');  % Rótulo do eixo Y
title('Total em R$ por Produto');  % Título do gráfico
grid on;  % Ativa a grade no gráfico

% === Passo 6: Recarregar os dados salvos e mostrar os produtos com total acima de R$ 3.000 ===
disp(' ');  % Linha em branco para separar a saída
load('dados_calculados.mat');  % Recarrega os dados salvos anteriormente

disp('Produtos com total acima de R$ 3.000:');
for i = 1:length(produtos)
    if totais(i) > 3000
        % Exibe apenas os produtos cujo total seja superior a R$ 3.000
        fprintf('Produto: %s - Total: R$ %.2f\n', produtos{i}, totais(i));
    end
end
